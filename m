Received: from eggs.gnu.org ([2001:4830:134:3::10]:48294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1foAFu-0007eH-TL
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 12:27:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1foAFt-0004wi-Sr
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 12:27:14 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 10 Aug 2018 18:26:57 +0200
Message-Id: <20180810162658.6562-2-kwolf@redhat.com>
In-Reply-To: <20180810162658.6562-1-kwolf@redhat.com>
References: <20180810162658.6562-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] commit: Add top-node/base-node options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pkrempa@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

The block-commit QMP command required specifying the top and base nodes
of the commit jobs using the file name of that node. While this works
in simple cases (local files with absolute paths), the file names
generated for more complicated setups can be hard to predict.

This adds two new options top-node and base-node to the command, which
allow specifying node names instead. They are mutually exclusive with
the old options.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json | 24 ++++++++++++++++++------
 blockdev.c           | 32 ++++++++++++++++++++++++++++++--
 2 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5b9084a394..91dd075c84 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1455,12 +1455,23 @@
 #
 # @device:  the device name or node-name of a root node
 #
-# @base:   The file name of the backing image to write data into.
-#                    If not specified, this is the deepest backing image.
+# @base-node: The node name of the backing image to write data into.
+#             If not specified, this is the deepest backing image.
+#             (since: 2.10)
 #
-# @top:    The file name of the backing image within the image chain,
-#                    which contains the topmost data to be committed down. If
-#                    not specified, this is the active layer.
+# @base: Same as @base-node, except that it is a file name rather than a node
+#        name. This must be the exact filename string that was used to open the
+#        node; other strings, even if addressing the same file, are not
+#        accepted (deprecated, use @base-node instead)
+#
+# @top-node: The node name of the backing image within the image chain
+#            which contains the topmost data to be committed down. If
+#            not specified, this is the active layer. (since: 2.10)
+#
+# @top: Same as @top-node, except that it is a file name rather than a node
+#       name. This must be the exact filename string that was used to open the
+#       node; other strings, even if addressing the same file, are not
+#       accepted (deprecated, use @base-node instead)
 #
 # @backing-file:  The backing file string to write into the overlay
 #                           image of 'top'.  If 'top' is the active layer,
@@ -1516,7 +1527,8 @@
 #
 ##
 { 'command': 'block-commit',
-  'data': { '*job-id': 'str', 'device': 'str', '*base': 'str', '*top': 'str',
+  'data': { '*job-id': 'str', 'device': 'str', '*base-node': 'str',
+            '*base': 'str', '*top-node': 'str', '*top': 'str',
             '*backing-file': 'str', '*speed': 'int',
             '*filter-node-name': 'str' } }
 
diff --git a/blockdev.c b/blockdev.c
index dcf8c8d2ab..064c8fb3f5 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3308,7 +3308,9 @@ out:
 }
 
 void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
+                      bool has_base_node, const char *base_node,
                       bool has_base, const char *base,
+                      bool has_top_node, const char *top_node,
                       bool has_top, const char *top,
                       bool has_backing_file, const char *backing_file,
                       bool has_speed, int64_t speed,
@@ -3360,7 +3362,20 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
     /* default top_bs is the active layer */
     top_bs = bs;
 
-    if (has_top && top) {
+    if (has_top_node && has_top) {
+        error_setg(errp, "'top-node' and 'top' are mutually exclusive");
+        goto out;
+    } else if (has_top_node) {
+        top_bs = bdrv_lookup_bs(NULL, top_node, errp);
+        if (top_bs == NULL) {
+            goto out;
+        }
+        if (!bdrv_chain_contains(bs, top_bs)) {
+            error_setg(errp, "'%s' is not in this backing file chain",
+                       top_node);
+            goto out;
+        }
+    } else if (has_top && top) {
         if (strcmp(bs->filename, top) != 0) {
             top_bs = bdrv_find_backing_image(bs, top);
         }
@@ -3373,7 +3388,20 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
 
     assert(bdrv_get_aio_context(top_bs) == aio_context);
 
-    if (has_base && base) {
+    if (has_base_node && has_base) {
+        error_setg(errp, "'base-node' and 'base' are mutually exclusive");
+        goto out;
+    } else if (has_base_node) {
+        base_bs = bdrv_lookup_bs(NULL, base_node, errp);
+        if (base_bs == NULL) {
+            goto out;
+        }
+        if (!bdrv_chain_contains(top_bs, base_bs)) {
+            error_setg(errp, "'%s' is not in this backing file chain",
+                       base_node);
+            goto out;
+        }
+    } else if (has_base && base) {
         base_bs = bdrv_find_backing_image(top_bs, base);
     } else {
         base_bs = bdrv_find_base(top_bs);
-- 
2.13.6
