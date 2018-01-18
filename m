Received: from eggs.gnu.org ([2001:4830:134:3::10]:59742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ecEex-0001WC-KK
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:11:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ecEeu-0004NX-Ir
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:11:31 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 18 Jan 2018 21:11:18 +0300
Message-Id: <20180118181123.37056-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180118181123.37056-1-vsementsov@virtuozzo.com>
References: <20180118181123.37056-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 1/6] qapi: add name parameter to
 nbd-server-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Allow user to specify name for new export, to not reuse internal
node name and to not show it to clients.

This also allows creating several exports per device.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/block.json |  9 +++++++--
 blockdev-nbd.c  | 14 +++++++++-----
 hmp.c           |  5 +++--
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index f093fa3f27..353e3a45bd 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -213,14 +213,19 @@
 #
 # @device: The device name or node name of the node to be exported
 #
+# @name: Export name. If unspecified, the @device parameter is used as the
+#        export name. (Since 2.12)
+#
 # @writable: Whether clients should be able to write to the device via the
 #     NBD connection (default false).
 #
-# Returns: error if the device is already marked for export.
+# Returns: error if the server is not running, or export with the same name
+#          already exists.
 #
 # Since: 1.3.0
 ##
-{ 'command': 'nbd-server-add', 'data': {'device': 'str', '*writable': 'bool'} }
+{ 'command': 'nbd-server-add',
+  'data': {'device': 'str', '*name': 'str', '*writable': 'bool'} }
 
 ##
 # @nbd-server-stop:
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 9e3c22109c..104789e521 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -140,8 +140,8 @@ void qmp_nbd_server_start(SocketAddressLegacy *addr,
     qapi_free_SocketAddress(addr_flat);
 }
 
-void qmp_nbd_server_add(const char *device, bool has_writable, bool writable,
-                        Error **errp)
+void qmp_nbd_server_add(const char *device, bool has_name, const char *name,
+                        bool has_writable, bool writable, Error **errp)
 {
     BlockDriverState *bs = NULL;
     BlockBackend *on_eject_blk;
@@ -152,8 +152,12 @@ void qmp_nbd_server_add(const char *device, bool has_writable, bool writable,
         return;
     }
 
-    if (nbd_export_find(device)) {
-        error_setg(errp, "NBD server already exporting device '%s'", device);
+    if (!has_name) {
+        name = device;
+    }
+
+    if (nbd_export_find(name)) {
+        error_setg(errp, "NBD server already has export named '%s'", name);
         return;
     }
 
@@ -177,7 +181,7 @@ void qmp_nbd_server_add(const char *device, bool has_writable, bool writable,
         return;
     }
 
-    nbd_export_set_name(exp, device);
+    nbd_export_set_name(exp, name);
 
     /* The list of named exports has a strong reference to this export now and
      * our only way of accessing it is through nbd_export_find(), so we can drop
diff --git a/hmp.c b/hmp.c
index c6bab5373b..37972f8322 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2218,7 +2218,8 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
             continue;
         }
 
-        qmp_nbd_server_add(info->value->device, true, writable, &local_err);
+        qmp_nbd_server_add(info->value->device, false, NULL,
+                           true, writable, &local_err);
 
         if (local_err != NULL) {
             qmp_nbd_server_stop(NULL);
@@ -2238,7 +2239,7 @@ void hmp_nbd_server_add(Monitor *mon, const QDict *qdict)
     bool writable = qdict_get_try_bool(qdict, "writable", false);
     Error *local_err = NULL;
 
-    qmp_nbd_server_add(device, true, writable, &local_err);
+    qmp_nbd_server_add(device, false, NULL, true, writable, &local_err);
 
     if (local_err != NULL) {
         hmp_handle_error(mon, &local_err);
-- 
2.11.1
