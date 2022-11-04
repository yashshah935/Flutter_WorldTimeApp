import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String location;
  String time="";
  String flag; //url to image
  String url; //url for API (Asia/Kolkata)
  bool isDaytime=true;

  WorldTime({required this.location,required this.flag,required this.url});
  Future<void> getTime() async{
    try{
      //make request
      Response response =  await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      // print(data);
      //get properties
      String datetime = data['datetime'];
      String offset_hr = data['utc_offset'].substring(1,3);
      String offset_mn= data['utc_offset'].substring(4,6);
      //create date time object
      DateTime now  = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset_hr),minutes: int.parse(offset_mn)));
      //set time
      isDaytime = ((now.hour > 6)  && (now.hour < 19) )? true : false;
      time = DateFormat.jm().format(now);
    }catch(e){
      print('caught error:$e');
      time = 'could not get time data \n something went wrong';
    }

  }
}
