Received: from eggs.gnu.org ([2001:4830:134:3::10]:59963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef6UM-0002zg-Hk
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:04:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef6UL-0002aT-HW
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 11:04:26 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri, 26 Jan 2018 10:04:04 -0600
Message-Id: <20180126160411.4033-2-eblake@redhat.com>
In-Reply-To: <20180126160411.4033-1-eblake@redhat.com>
References: <20180126160411.4033-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 1/8] qapi: add name parameter to nbd-server-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Allow user to specify name for new export, to not reuse internal
node name and to not show it to clients.

This also allows creating several exports per device.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180119135719.24745-2-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/block.json |  9 +++++++--
 blockdev-nbd.c  | 14 +++++++++-----
 hmp.c           |  5 +++--
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index f093fa3f276..353e3a45bdf 100644
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
index 9e3c22109c6..104789e521c 100644
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
index 056bf70cf1e..5bcfc36de10 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2203,7 +2203,8 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
             continue;
         }

-        qmp_nbd_server_add(info->value->device, true, writable, &local_err);
+        qmp_nbd_server_add(info->value->device, false, NULL,
+                           true, writable, &local_err);

         if (local_err != NULL) {
             qmp_nbd_server_stop(NULL);
@@ -2223,7 +2224,7 @@ void hmp_nbd_server_add(Monitor *mon, const QDict *qdict)
     bool writable = qdict_get_try_bool(qdict, "writable", false);
     Error *local_err = NULL;

-    qmp_nbd_server_add(device, true, writable, &local_err);
+    qmp_nbd_server_add(device, false, NULL, true, writable, &local_err);

     if (local_err != NULL) {
         hmp_handle_error(mon, &local_err);
-- 
2.14.3
