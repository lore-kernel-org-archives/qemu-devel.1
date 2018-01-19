Received: from eggs.gnu.org ([2001:4830:134:3::10]:51745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ecXAe-0004Vj-Gm
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:57:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ecXAZ-0004NE-JH
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:57:28 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 19 Jan 2018 16:57:16 +0300
Message-Id: <20180119135719.24745-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180119135719.24745-1-vsementsov@virtuozzo.com>
References: <20180119135719.24745-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 2/5] qapi: add nbd-server-remove
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

Add command for removing an export. It is needed for cases when we
don't want to keep export after the operation on it was completed.
The other example is temporary node, created with blockdev-add.
If we want to delete it we should firstly remove corresponding
NBD export.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block.json     | 41 +++++++++++++++++++++++++++++++++++++++++
 include/block/nbd.h |  1 +
 blockdev-nbd.c      | 24 ++++++++++++++++++++++++
 nbd/server.c        | 20 ++++++++++++++++++++
 4 files changed, 86 insertions(+)

diff --git a/qapi/block.json b/qapi/block.json
index 353e3a45bd..c694524002 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -228,6 +228,47 @@
   'data': {'device': 'str', '*name': 'str', '*writable': 'bool'} }
 
 ##
+# @NbdServerRemoveMode:
+#
+# Mode for removing an NBD export.
+#
+# @safe: Remove export if there are no existing connections, fail otherwise.
+#
+# @hard: Drop all connections immediately and remove export.
+#
+# Potential additional modes to be added in the future:
+#
+# hide: Just hide export from new clients, leave existing connections as is.
+#       Remove export after all clients are disconnected.
+#
+# soft: Hide export from new clients, answer with ESHUTDOWN for all further
+#       requests from existing clients.
+#
+# Since: 2.12
+##
+{'enum': 'NbdServerRemoveMode', 'data': ['safe', 'hard']}
+
+##
+# @nbd-server-remove:
+#
+# Remove NBD export by name.
+#
+# @name: Export name.
+#
+# @mode: Mode of command operation. See @NbdServerRemoveMode description.
+#        Default is 'safe'.
+#
+# Returns: error if
+#            - the server is not running
+#            - export is not found
+#            - mode is 'safe' and there are existing connections
+#
+# Since: 2.12
+##
+{ 'command': 'nbd-server-remove',
+  'data': {'name': 'str', '*mode': 'NbdServerRemoveMode'} }
+
+##
 # @nbd-server-stop:
 #
 # Stop QEMU's embedded NBD server, and unregister all devices previously
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 978e443366..ee74ec391a 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -261,6 +261,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs, off_t dev_offset, off_t size,
                           bool writethrough, BlockBackend *on_eject_blk,
                           Error **errp);
 void nbd_export_close(NBDExport *exp);
+void nbd_export_remove(NBDExport *exp, NbdServerRemoveMode mode, Error **errp);
 void nbd_export_get(NBDExport *exp);
 void nbd_export_put(NBDExport *exp);
 
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 104789e521..a9f79c6778 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -189,6 +189,30 @@ void qmp_nbd_server_add(const char *device, bool has_name, const char *name,
     nbd_export_put(exp);
 }
 
+void qmp_nbd_server_remove(const char *name,
+                           bool has_mode, NbdServerRemoveMode mode,
+                           Error **errp)
+{
+    NBDExport *exp;
+
+    if (!nbd_server) {
+        error_setg(errp, "NBD server not running");
+        return;
+    }
+
+    exp = nbd_export_find(name);
+    if (exp == NULL) {
+        error_setg(errp, "Export '%s' is not found", name);
+        return;
+    }
+
+    if (!has_mode) {
+        mode = NBD_SERVER_REMOVE_MODE_SAFE;
+    }
+
+    nbd_export_remove(exp, mode, errp);
+}
+
 void qmp_nbd_server_stop(Error **errp)
 {
     nbd_export_close_all();
diff --git a/nbd/server.c b/nbd/server.c
index 6cf2eeb2c1..bf2afd264a 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1177,6 +1177,26 @@ void nbd_export_close(NBDExport *exp)
     nbd_export_put(exp);
 }
 
+void nbd_export_remove(NBDExport *exp, NbdServerRemoveMode mode, Error **errp)
+{
+    NBDClient *client;
+    int nb_clients = 0;
+
+    if (mode == NBD_SERVER_REMOVE_MODE_HARD || QTAILQ_EMPTY(&exp->clients)) {
+        nbd_export_close(exp);
+        return;
+    }
+
+    assert(mode == NBD_SERVER_REMOVE_MODE_SAFE);
+
+    QTAILQ_FOREACH(client, &exp->clients, next) {
+        nb_clients++;
+    }
+
+    error_setg(errp, "export '%s' still in use", exp->name);
+    error_append_hint(errp, "Use mode='hard' to force client disconnect\n");
+}
+
 void nbd_export_get(NBDExport *exp)
 {
     assert(exp->refcount > 0);
-- 
2.11.1
