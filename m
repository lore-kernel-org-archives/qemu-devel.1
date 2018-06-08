Received: from eggs.gnu.org ([2001:4830:134:3::10]:41399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRJFF-0007Gb-7o
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:24:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRJFE-0005QE-Ex
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:24:05 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  8 Jun 2018 18:23:52 +0300
Message-Id: <20180608152353.98712-6-vsementsov@virtuozzo.com>
In-Reply-To: <20180608152353.98712-1-vsementsov@virtuozzo.com>
References: <20180608152353.98712-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 5/6] qapi: new qmp command
 nbd-server-add-bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block.json | 23 +++++++++++++++++++++++
 blockdev-nbd.c  | 23 +++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/qapi/block.json b/qapi/block.json
index c694524002..ddbca2e286 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -269,6 +269,29 @@
   'data': {'name': 'str', '*mode': 'NbdServerRemoveMode'} }
 
 ##
+# @nbd-server-add-bitmap:
+#
+# Expose a dirty bitmap associated with the selected export. The bitmap search
+# starts at the device attached to the export, and includes all backing files.
+# The exported bitmap is then locked until the NBD export is removed.
+#
+# @name: Export name.
+#
+# @bitmap: Bitmap name to search for.
+#
+# @bitmap-export-name: How the bitmap will be seen by nbd clients
+#                      (default @bitmap)
+#
+# Note: the client must use NBD_OPT_SET_META_CONTEXT with a query of
+# "qemu:dirty-bitmap:NAME" (where NAME matches @bitmap-export-name) to access
+# the exposed bitmap.
+#
+# Since: 3.0
+##
+  { 'command': 'nbd-server-add-bitmap',
+    'data': {'name': 'str', 'bitmap': 'str', '*bitmap-export-name': 'str'} }
+
+##
 # @nbd-server-stop:
 #
 # Stop QEMU's embedded NBD server, and unregister all devices previously
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 65a84739ed..6b0c50732c 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -220,3 +220,26 @@ void qmp_nbd_server_stop(Error **errp)
     nbd_server_free(nbd_server);
     nbd_server = NULL;
 }
+
+void qmp_nbd_server_add_bitmap(const char *name, const char *bitmap,
+                               bool has_bitmap_export_name,
+                               const char *bitmap_export_name,
+                               Error **errp)
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
+    nbd_export_bitmap(exp, bitmap,
+                      has_bitmap_export_name ? bitmap_export_name : bitmap,
+                      errp);
+}
-- 
2.11.1
