import 'dart:convert';

import 'package:capo/modules/settings/settings_modules/node_settings/view/validator/model/validator_cell_model.dart';
import 'package:capo/utils/dialog/capo_dialog_utils.dart';
import 'package:capo/utils/rnode_networking.dart';
import 'package:capo/utils/storage_manager.dart';
import 'package:capo_core_dart/capo_core_dart.dart';
import 'package:easy_localization/public.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;

class ValidatorViewModel with ChangeNotifier {
  CoopNodes nodeModel;
  BuildContext _buildContext;
  loadJson(context) async {
//    String jsonString;
//    jsonString = StorageManager.sharedPreferences
//        .getString(kCapoUserValidatorNodeSettings);
//
//    if (jsonString == null) {
//      jsonString = await DefaultAssetBundle.of(context).loadString(
//          'lib/modules/settings/settings_modules/node_settings/view/validator/model/validator_sections.json');
//    }
//    final map = json.decode(jsonString);
//    tableViewSections = ValidatorSections.fromJson(map);
//
//    if (tableViewSections.selectedNode == null ||
//        tableViewSections.selectedNode.length == 0) {
//      var index = Random().nextInt(tableViewSections.sections.first.length);
//      tableViewSections.selectedNode =
//          tableViewSections.sections.first.elementAt(index).url;
//      await saveNodeSettings2Storage(tableViewSections);
//    }
    var sections = await getValidatorNodeSetting();
    nodeModel = sections;
    notifyListeners();
    _buildContext = context;
  }

  cellTapped({@required int section, @required int row}) async {
    if (section == 0) {
      nodeModel.autoSelected = true;
      nodeModel.selectedNode = null;
      String jsonString = json.encode(nodeModel.toJson());
      await saveNodeSettings2Storage(jsonString);
      notifyListeners();
      return;
    }
    CoopValidators selectedNode = nodeModel.validators[row];
    if (selectedNode.host ==
        (nodeModel.selectedNode != null ? nodeModel.selectedNode.host : "")) {
      return;
    }
    nodeModel.autoSelected = false;
    nodeModel.selectedNode = selectedNode;
    String jsonString = json.encode(nodeModel.toJson());
    await saveNodeSettings2Storage(jsonString);
    notifyListeners();
  }

  static Future<CoopNodes> getValidatorNodeSetting() async {
    String jsonString;
    jsonString = StorageManager.sharedPreferences
        .getString(kCapoUserValidatorNodeSettings);
    if (jsonString == null) {
      jsonString = await rootBundle.loadString(
          "lib/modules/settings/settings_modules/node_settings/view/validator/model/validator_sections.json");
    }
    final map = json.decode(jsonString);
    CoopNodes model = CoopNodes.fromJson(map);

//    if (model.selectedNode == null || model.selectedNode.length == 0) {
//      var index = Random().nextInt(model.sections.first.length);
//      model.selectedNode = model.sections.first.elementAt(index).url;
//      String jsonString = json.encode(model.toJson());
//      await saveNodeSettings2Storage(jsonString);
//    }
    return model;
  }

  static saveNodeSettings2Storage(String jsonString) async {
    await Future.wait([
      StorageManager.sharedPreferences
          .setString(kCapoUserValidatorNodeSettings, jsonString),
    ]);
  }

//   addCustomNode(String nodeUrl) async {
//     if (nodeUrl == null || nodeUrl.length == 0) {
//       return;
//     }
//
//     var _url = nodeUrl;
//     if (_url.startsWith(RegExp(r'https?:'))) {
//       CapoDialogUtils.showCupertinoDialog(
//           buildContext: _buildContext,
//           message: tr(
//               "settings.note_settings.validator_page.node_address_not_validate"));
//       return;
//     }
//     var s = _url.split(':');
//     try {
//       final int _ = int.parse(s.last);
//     } catch (e) {
//       CapoDialogUtils.showCupertinoDialog(
//           buildContext: _buildContext,
//           message: tr("settings.note_settings.validator_page.port_error"));
//       return;
//     }
//
// //    for (List<Section> sections in tableViewSections.sections) {
// //      for (Section section in sections) {
// //        if (section.url == nodeUrl) {
// //          CapoDialogUtils.showCupertinoDialog(
// //              buildContext: _buildContext,
// //              message: tr(
// //                  "settings.note_settings.validator_page.node_already_exists"));
// //          return;
// //        }
// //      }
// //    }
//     CapoDialogUtils.showProcessIndicator(
//         context: _buildContext,
//         tip: tr("settings.note_settings.validator_page.testing"));
//     bool passed = await testNode(nodeUrl);
//     Navigator.pop(_buildContext);
//     if (!passed) {
//       CapoDialogUtils.showCupertinoDialog(
//           buildContext: _buildContext,
//           message: tr(
//               "settings.note_settings.validator_page.unable_to_connect_to_this_node"));
//       return;
//     }
//
//
//   }

  deleteNode(int section, int row) async {
//    String nodeUrl = tableViewSections.sections[section][row].url;
//    if (nodeUrl == tableViewSections.selectedNode) {
//      tableViewSections.selectedNode =
//          tableViewSections.sections.first.first.url;
//    }
//    tableViewSections.sections[section].removeAt(row);
//    String jsonString = json.encode(tableViewSections.toJson());
//    await saveNodeSettings2Storage(jsonString);
//    notifyListeners();
  }

  bool _disposed = false;

  @override
  void notifyListeners() {
    if (!_disposed) super.notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
