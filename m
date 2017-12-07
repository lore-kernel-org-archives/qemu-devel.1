Received: from eggs.gnu.org ([2001:4830:134:3::10]:47234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eMySW-0003bj-Uo
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:51:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eMySU-0008Bb-2i
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:51:36 -0500
Received: from [195.214.232.25] (port=17523 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eMyST-00089H-Iy
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:51:34 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  7 Dec 2017 18:50:59 +0300
Message-Id: <20171207155102.66622-4-vsementsov@virtuozzo.com>
In-Reply-To: <20171207155102.66622-1-vsementsov@virtuozzo.com>
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 3/6] qapi: add nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Add command for export removing. It is needed for cases when we
don't want to keep export after the operation on it was completed.
The other example is temporary node, created with blockdev-add.
If we want to delete it we should firstly remove corresponding
NBD export.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block.json     | 18 ++++++++++++++++++
 include/block/nbd.h |  3 ++-
 blockdev-nbd.c      | 29 ++++++++++++++++++++++++++++-
 nbd/server.c        | 25 ++++++++++++++++++++++---
 4 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index 503d4b287b..f83485c325 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -228,6 +228,24 @@
   'data': {'device': 'str', '*name': 'str', '*writable': 'bool'} }
 
 ##
+# @nbd-server-remove:
+#
+# Remove NBD export by name.
+#
+# @name: Export name.
+#
+# @force: Whether active connections to the export should be closed. If this
+#         parameter is false the export only becomes hidden from clients (new
+#         connections are impossible), and would be automatically freed after
+#         all clients are disconnected (default false).
+#
+# Returns: error if the server is not running or export is not found.
+#
+# Since: 2.12
+##
+{ 'command': 'nbd-server-remove', 'data': {'name': 'str', '*force': 'bool'} }
+
+##
 # @nbd-server-stop:
 #
 # Stop QEMU's embedded NBD server, and unregister all devices previously
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 113c707a5e..b89d116597 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -261,12 +261,13 @@ NBDExport *nbd_export_new(BlockDriverState *bs, off_t dev_offset, off_t size,
                           bool writethrough, BlockBackend *on_eject_blk,
                           Error **errp);
 void nbd_export_close(NBDExport *exp);
+void nbd_export_hide(NBDExport *exp);
 void nbd_export_get(NBDExport *exp);
 void nbd_export_put(NBDExport *exp);
 
 BlockBackend *nbd_export_get_blockdev(NBDExport *exp);
 
-NBDExport *nbd_export_find(const char *name);
+NBDExport *nbd_export_find(const char *name, bool include_hidden);
 void nbd_export_set_name(NBDExport *exp, const char *name);
 void nbd_export_set_description(NBDExport *exp, const char *description);
 void nbd_export_close_all(void);
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 46c885aa35..2495d38f2c 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -174,7 +174,7 @@ void qmp_nbd_server_add(const char *device, bool has_name, const char *name,
         name = device;
     }
 
-    if (nbd_export_find(name)) {
+    if (nbd_export_find(name, true)) {
         error_setg(errp, "NBD server already has export named '%s'", name);
         return;
     }
@@ -207,6 +207,33 @@ void qmp_nbd_server_add(const char *device, bool has_name, const char *name,
     nbd_export_put(exp);
 }
 
+void qmp_nbd_server_remove(const char *name, bool has_force, bool force,
+                           Error **errp)
+{
+    NBDExport *exp;
+
+    if (!nbd_server) {
+        error_setg(errp, "NBD server not running");
+        return;
+    }
+
+    exp = nbd_export_find(name, true);
+    if (exp == NULL) {
+        error_setg(errp, "Export '%s' is not found", name);
+        return;
+    }
+
+    if (!has_force) {
+        force = false;
+    }
+
+    if (force) {
+        nbd_export_close(exp);
+    } else {
+        nbd_export_hide(exp);
+    }
+}
+
 void qmp_nbd_server_stop(Error **errp)
 {
     nbd_export_close_all();
diff --git a/nbd/server.c b/nbd/server.c
index e817c48087..d85f2dc747 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -78,6 +78,10 @@ struct NBDExport {
 
     BlockBackend *eject_notifier_blk;
     Notifier eject_notifier;
+
+    /* hidden export is not available for new connections and should be removed
+     * after last client disconnect */
+    bool hidden;
 };
 
 static QTAILQ_HEAD(, NBDExport) exports = QTAILQ_HEAD_INITIALIZER(exports);
@@ -300,7 +304,7 @@ static int nbd_negotiate_handle_export_name(NBDClient *client, uint32_t length,
 
     trace_nbd_negotiate_handle_export_name_request(name);
 
-    client->exp = nbd_export_find(name);
+    client->exp = nbd_export_find(name, false);
     if (!client->exp) {
         error_setg(errp, "export not found");
         return -EINVAL;
@@ -429,7 +433,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,
     }
     assert(length == 0);
 
-    exp = nbd_export_find(name);
+    exp = nbd_export_find(name, false);
     if (!exp) {
         return nbd_negotiate_send_rep_err(client->ioc, NBD_REP_ERR_UNKNOWN,
                                           opt, errp, "export '%s' not present",
@@ -966,6 +970,9 @@ void nbd_client_put(NBDClient *client)
         if (client->exp) {
             QTAILQ_REMOVE(&client->exp->clients, client, next);
             nbd_export_put(client->exp);
+            if (client->exp->hidden && QTAILQ_EMPTY(&client->exp->clients)) {
+                nbd_export_close(client->exp);
+            }
         }
         g_free(client);
     }
@@ -1125,10 +1132,14 @@ fail:
     return NULL;
 }
 
-NBDExport *nbd_export_find(const char *name)
+NBDExport *nbd_export_find(const char *name, bool include_hidden)
 {
     NBDExport *exp;
     QTAILQ_FOREACH(exp, &exports, next) {
+        if (!include_hidden && exp->hidden) {
+            continue;
+        }
+
         if (strcmp(name, exp->name) == 0) {
             return exp;
         }
@@ -1177,6 +1188,14 @@ void nbd_export_close(NBDExport *exp)
     nbd_export_put(exp);
 }
 
+void nbd_export_hide(NBDExport *exp)
+{
+    exp->hidden = true;
+    if (QTAILQ_EMPTY(&exp->clients)) {
+        nbd_export_close(exp);
+    }
+}
+
 void nbd_export_get(NBDExport *exp)
 {
     assert(exp->refcount > 0);
-- 
2.11.1
