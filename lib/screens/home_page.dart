import 'dart:convert';
import 'package:flutter/material.dart';
import '../model/photo_model.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 List<Photos> photosList = [];
 Future<List<Photos>> getPhotos ()async{
   final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
   if(response.statusCode == 200){
      for(Map i in data){
        Photos photos = Photos(id: i['id'],title: i["title"], thumbnailUrl: i["thumbnailUrl"], url: i["url"]);
        photosList.add(photos);
      }
      return photosList;
   }else{
      return photosList;
   }
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Photo Screen'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
            Expanded(
              child: FutureBuilder(
                future: getPhotos(),
                  builder: (context, AsyncSnapshot<List<Photos>> snapshot){
                return ListView.builder(
                  itemCount: photosList.length,
                  itemBuilder: (context, index){
                    return Card(
                      elevation: 10,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                        ),
                        title: Text("Title: "+photosList[index].id.toString()),
                        subtitle:  Text(snapshot.data![index].title.toString()),
                        trailing: CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data![index].thumbnailUrl.toString()),
                        ),
                      ),
                    );
                  },
                );
              }),
            )
        ],
      ),
    );
  }
}
