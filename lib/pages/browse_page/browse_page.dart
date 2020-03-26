import 'package:flutter/material.dart';
import 'package:flutter_music/music_app_bar/music_app_bar.dart';
import 'package:flutter_music/common/music_store.dart';
import 'package:flutter_music/pages/browse_page/browse_banner_widget.dart';
import 'package:flutter_music/public_widget/music_item_widget.dart';
import 'package:flutter_music/http_request/music_api.dart';
import 'package:flutter_music/public_widget/music_title_widget.dart';
class BrowsePage extends StatefulWidget {
  @override
  _BrowsePageState createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> with AutomaticKeepAliveClientMixin{

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Future _future = MusicApi.newSongList();


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: MusicStore.Theme.of(context).theme,
      appBar: MusicAppBar(
        title: "浏览",
        rightIconData: Icons.search,
      ),
      body: FutureBuilderWidget<List<TrackItemModel>>(
        future:_future,
        successBuilder: (BuildContext context, AsyncSnapshot<List<TrackItemModel>> snapshot){


          return ListView.builder(
              itemCount: 10 + 2,
              itemBuilder: (BuildContext context, int index){


                if(index == 0){
                  return BrowseBannerWidget();
                }else if(index == 1){
                  return MusicTitleWidget(
                    title: "新歌",
                  );
                }

                TrackItemModel itemModel = snapshot.data[index-2];
                return MusicItemWidget(
                  title: itemModel.name,
                  subtTitle: itemModel.arList.first.name + "-" + itemModel.al.name,
                  coverImageUrl: itemModel.al.picUrl,
                  heroTageName: itemModel.id.toString(),
                );
              }
          );
        },
      )

    );
  }


}