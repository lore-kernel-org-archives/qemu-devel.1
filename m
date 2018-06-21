Received: from eggs.gnu.org ([2001:4830:134:3::10]:52665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVq8u-0006V5-6S
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 23:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVq8s-0001gG-Qm
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 23:20:16 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 20 Jun 2018 22:19:56 -0500
Message-Id: <20180621031957.134718-7-eblake@redhat.com>
In-Reply-To: <20180621031957.134718-1-eblake@redhat.com>
References: <20180621031957.134718-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 6/7] qapi: new qmp command nbd-server-add-bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

For now, the actual command ix x-nbd-server-add-bitmap, reflecting
the fact that we are still working on libvirt code that proves the
command works as needed, and also the fact that we may remove
bitmap-export-name (and just require that the exported name be the
bitmap name).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20180609151758.17343-6-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: make the command experimental by adding x- prefix]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/block.json | 23 +++++++++++++++++++++++
 blockdev-nbd.c  | 23 +++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/qapi/block.json b/qapi/block.json
index c6945240029..ca807f176ae 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -268,6 +268,29 @@
 { 'command': 'nbd-server-remove',
   'data': {'name': 'str', '*mode': 'NbdServerRemoveMode'} }

+##
+# @x-nbd-server-add-bitmap:
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
+  { 'command': 'x-nbd-server-add-bitmap',
+    'data': {'name': 'str', 'bitmap': 'str', '*bitmap-export-name': 'str'} }
+
 ##
 # @nbd-server-stop:
 #
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 65a84739edc..1ef11041a73 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -220,3 +220,26 @@ void qmp_nbd_server_stop(Error **errp)
     nbd_server_free(nbd_server);
     nbd_server = NULL;
 }
+
+void qmp_x_nbd_server_add_bitmap(const char *name, const char *bitmap,
+                                 bool has_bitmap_export_name,
+                                 const char *bitmap_export_name,
+                                 Error **errp)
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
2.14.4
