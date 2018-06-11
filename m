Received: from eggs.gnu.org ([2001:4830:134:3::10]:56728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSSaO-0001ue-M0
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 15:34:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSSaM-0003X5-BA
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 15:34:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47082 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fSSaM-0003WX-6h
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 15:34:38 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 11 Jun 2018 15:34:31 -0400
Message-Id: <20180611193434.19004-5-jsnow@redhat.com>
In-Reply-To: <20180611193434.19004-1-jsnow@redhat.com>
References: <20180611193434.19004-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 4/7] qapi: add
 x-block-dirty-bitmap-enable/disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Expose the ability to turn bitmaps "on" or "off". This is experimental
and principally for the sake of the Libvirt Checkpoints API, and it may
or may not be committed for 3.0.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Message-id: 20180606182449.1607-3-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockdev.c           | 42 ++++++++++++++++++++++++++++++++++++++++++
 qapi/block-core.json | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/blockdev.c b/blockdev.c
index 266ecc06cc..4a353c934a 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2922,6 +2922,48 @@ void qmp_block_dirty_bitmap_clear(const char *node, const char *name,
     bdrv_clear_dirty_bitmap(bitmap, NULL);
 }
 
+void qmp_x_block_dirty_bitmap_enable(const char *node, const char *name,
+                                   Error **errp)
+{
+    BlockDriverState *bs;
+    BdrvDirtyBitmap *bitmap;
+
+    bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
+    if (!bitmap) {
+        return;
+    }
+
+    if (bdrv_dirty_bitmap_frozen(bitmap)) {
+        error_setg(errp,
+                   "Bitmap '%s' is currently frozen and cannot be enabled",
+                   name);
+        return;
+    }
+
+    bdrv_enable_dirty_bitmap(bitmap);
+}
+
+void qmp_x_block_dirty_bitmap_disable(const char *node, const char *name,
+                                    Error **errp)
+{
+    BlockDriverState *bs;
+    BdrvDirtyBitmap *bitmap;
+
+    bitmap = block_dirty_bitmap_lookup(node, name, &bs, errp);
+    if (!bitmap) {
+        return;
+    }
+
+    if (bdrv_dirty_bitmap_frozen(bitmap)) {
+        error_setg(errp,
+                   "Bitmap '%s' is currently frozen and cannot be disabled",
+                   name);
+        return;
+    }
+
+    bdrv_disable_dirty_bitmap(bitmap);
+}
+
 BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(const char *node,
                                                               const char *name,
                                                               Error **errp)
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 4b1de474a9..02de674f5f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1808,6 +1808,48 @@
 { 'command': 'block-dirty-bitmap-clear',
   'data': 'BlockDirtyBitmap' }
 
+##
+# @x-block-dirty-bitmap-enable:
+#
+# Enables a dirty bitmap so that it will begin tracking disk changes.
+#
+# Returns: nothing on success
+#          If @node is not a valid block device, DeviceNotFound
+#          If @name is not found, GenericError with an explanation
+#
+# Since: 3.0
+#
+# Example:
+#
+# -> { "execute": "x-block-dirty-bitmap-enable",
+#      "arguments": { "node": "drive0", "name": "bitmap0" } }
+# <- { "return": {} }
+#
+##
+  { 'command': 'x-block-dirty-bitmap-enable',
+    'data': 'BlockDirtyBitmap' }
+
+##
+# @x-block-dirty-bitmap-disable:
+#
+# Disables a dirty bitmap so that it will stop tracking disk changes.
+#
+# Returns: nothing on success
+#          If @node is not a valid block device, DeviceNotFound
+#          If @name is not found, GenericError with an explanation
+#
+# Since: 3.0
+#
+# Example:
+#
+# -> { "execute": "x-block-dirty-bitmap-disable",
+#      "arguments": { "node": "drive0", "name": "bitmap0" } }
+# <- { "return": {} }
+#
+##
+    { 'command': 'x-block-dirty-bitmap-disable',
+      'data': 'BlockDirtyBitmap' }
+
 ##
 # @BlockDirtyBitmapSha256:
 #
-- 
2.14.3
