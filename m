Received: from eggs.gnu.org ([2001:4830:134:3::10]:54986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eycib-00061q-4g
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eyciX-0005ir-0h
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:19:49 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 21 Mar 2018 15:19:40 +0300
Message-Id: <20180321121940.39426-5-vsementsov@virtuozzo.com>
In-Reply-To: <20180321121940.39426-1-vsementsov@virtuozzo.com>
References: <20180321121940.39426-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 4/4] qapi: new qmp command nbd-server-add-bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block.json | 27 +++++++++++++++++++++++++++
 blockdev-nbd.c  | 23 +++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/qapi/block.json b/qapi/block.json
index c694524002..4afbbcd7b7 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -269,6 +269,33 @@
   'data': {'name': 'str', '*mode': 'NbdServerRemoveMode'} }
 
 ##
+# @nbd-server-add-bitmap:
+#
+# Export dirty bitmap through selected export. Bitmaps are searched for in
+# device attached to the export and in all its backings. Exported bitmap
+# is locked until NBD export is removed.
+#
+# @name: Export name.
+#
+# @bitmap: Bitmap name to search.
+#
+# @bitmap-export-name: How the bitmap will be seen by nbd clients
+#                      (default @bitmap)
+#
+#
+# Returns: error on one of the following conditions:
+#           - the server is not running
+#           - export is not found
+#           - bitmap is not found
+#           - bitmap is disabled
+#           - bitmap is locked
+#
+# Since: 2.13
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
