Received: from eggs.gnu.org ([2001:4830:134:3::10]:44763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@void.so>) id 1fL1H6-000876-45
	for qemu-devel@nongnu.org; Tue, 22 May 2018 03:00:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@void.so>) id 1fL1H2-0008JT-4w
	for qemu-devel@nongnu.org; Tue, 22 May 2018 03:00:00 -0400
Received: from forward105p.mail.yandex.net ([77.88.28.108]:36747)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mail@void.so>) id 1fL1H1-0008Fx-Kw
	for qemu-devel@nongnu.org; Tue, 22 May 2018 02:59:56 -0400
Received: from mxback13j.mail.yandex.net (mxback13j.mail.yandex.net
	[IPv6:2a02:6b8:0:1619::88])
	by forward105p.mail.yandex.net (Yandex) with ESMTP id CF8DB408214A
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 09:59:51 +0300 (MSK)
Date: Tue, 22 May 2018 09:59:24 +0300
From: Pavel Balaev <mail@void.so>
Message-ID: <20180522065922.GA3462@rnd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] Add save/load/del[vm] QMP api
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

Now savevm, loadvm and delvm commands only allowed from hmp monitor.
This patch adds ability to send them via QMP api. 

Signed-off-by: Pavel Balaev <mail@void.so>
---
 hmp.c              | 22 +++++++++-------------
 migration/savevm.c | 27 +++++++++++++++++++++++++++
 qapi/misc.json     | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+), 13 deletions(-)

diff --git a/hmp.c b/hmp.c
index ef93f4878b..7ae5852c77 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1313,37 +1313,33 @@ void hmp_snapshot_delete_blkdev_internal(Monitor *mon, const QDict *qdict)
 
 void hmp_loadvm(Monitor *mon, const QDict *qdict)
 {
-    int saved_vm_running  = runstate_is_running();
     const char *name = qdict_get_str(qdict, "name");
     Error *err = NULL;
 
-    vm_stop(RUN_STATE_RESTORE_VM);
-
-    if (load_snapshot(name, &err) == 0 && saved_vm_running) {
-        vm_start();
-    }
+    qmp_loadvm(name, &err);
     hmp_handle_error(mon, &err);
 }
 
 void hmp_savevm(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
+    bool has_name = TRUE;
+    const char *name = qdict_get_try_str(qdict, "name");
 
-    save_snapshot(qdict_get_try_str(qdict, "name"), &err);
+    if (name == NULL) {
+        has_name = FALSE;
+    }
+
+    qmp_savevm(has_name, name, &err);
     hmp_handle_error(mon, &err);
 }
 
 void hmp_delvm(Monitor *mon, const QDict *qdict)
 {
-    BlockDriverState *bs;
     Error *err = NULL;
     const char *name = qdict_get_str(qdict, "name");
 
-    if (bdrv_all_delete_snapshot(name, &bs, &err) < 0) {
-        error_reportf_err(err,
-                          "Error while deleting snapshot on device '%s': ",
-                          bdrv_get_device_name(bs));
-    }
+    qmp_delvm(name, &err);
 }
 
 void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
diff --git a/migration/savevm.c b/migration/savevm.c
index 4251125831..3c830ca5a4 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2515,6 +2515,33 @@ int save_snapshot(const char *name, Error **errp)
     return ret;
 }
 
+void qmp_savevm(bool has_name, const char *name, Error **errp)
+{
+    save_snapshot(has_name ? name : NULL, errp);
+}
+
+void qmp_loadvm(const char *name, Error **errp)
+{
+    int saved_vm_running  = runstate_is_running();
+
+    vm_stop(RUN_STATE_RESTORE_VM);
+
+    if (load_snapshot(name, errp) == 0 && saved_vm_running) {
+        vm_start();
+    }
+}
+
+void qmp_delvm(const char *name, Error **errp)
+{
+    BlockDriverState *bs;
+
+    if (bdrv_all_delete_snapshot(name, &bs, errp) < 0) {
+        error_reportf_err(*errp,
+                          "Error while deleting snapshot on device '%s': ",
+                          bdrv_get_device_name(bs));
+    }
+}
+
 void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
                                 Error **errp)
 {
diff --git a/qapi/misc.json b/qapi/misc.json
index f5988cc0b5..cca7df0202 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3097,6 +3097,60 @@
 { 'enum': 'ReplayMode',
   'data': [ 'none', 'record', 'play' ] }
 
+##
+# @savevm:
+#
+# Save a VM snapshot. Without a name new snapshot is created.
+#
+# @name: identifier of a snapshot to be saved
+#
+# Returns: Nothing on success
+#
+# Since: 2.12
+#
+# Example:
+#
+# -> { "execute": "savevm", "arguments": { "name": "snapshot1" } }
+# <- { "return": {} }
+##
+{ 'command': 'savevm', 'data': {'*name': 'str'} }
+
+##
+# @loadvm:
+#
+# Load a VM snapshot.
+#
+# @name: identifier of a snapshot to be loaded
+#
+# Returns: Nothing on success
+#
+# Since: 2.12
+#
+# Example:
+#
+# -> { "execute": "loadvm", "arguments": { "name": "snapshot1" } }
+# <- { "return": {} }
+##
+{ 'command': 'loadvm', 'data': {'name': 'str'} }
+
+##
+# @delvm:
+#
+# Delete a VM snapshot.
+#
+# @name: identifier of a snapshot to be deleted
+#
+# Returns: Nothing on success
+#
+# Since: 2.12
+#
+# Example:
+#
+# -> { "execute": "delvm", "arguments": { "name": "snapshot1" } }
+# <- { "return": {} }
+##
+{ 'command': 'delvm', 'data': {'name': 'str'} }
+
 ##
 # @xen-load-devices-state:
 #
-- 
2.16.1
