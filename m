Received: from eggs.gnu.org ([2001:4830:134:3::10]:56736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSSaP-0001ur-1R
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 15:34:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSSaN-0003Yi-9H
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 15:34:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45256 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fSSaN-0003Xx-4l
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 15:34:39 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 11 Jun 2018 15:34:33 -0400
Message-Id: <20180611193434.19004-7-jsnow@redhat.com>
In-Reply-To: <20180611193434.19004-1-jsnow@redhat.com>
References: <20180611193434.19004-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 6/7] qapi: add x-block-dirty-bitmap-merge
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Message-id: 20180606182449.1607-5-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c         | 18 ++++++++++++++++++
 blockdev.c                   | 30 ++++++++++++++++++++++++++++++
 include/block/dirty-bitmap.h |  3 ++-
 qapi/block-core.json         | 38 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 59b38b2671..383d742cdb 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -728,3 +728,21 @@ int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t offset)
 {
     return hbitmap_next_zero(bitmap->bitmap, offset);
 }
+
+void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
+                             Error **errp)
+{
+    /* only bitmaps from one bds are supported */
+    assert(dest->mutex == src->mutex);
+
+    qemu_mutex_lock(dest->mutex);
+
+    assert(bdrv_dirty_bitmap_enabled(dest));
+    assert(!bdrv_dirty_bitmap_readonly(dest));
+
+    if (!hbitmap_merge(dest->bitmap, src->bitmap)) {
+        error_setg(errp, "Bitmaps are incompatible and can't be merged");
+    }
+
+    qemu_mutex_unlock(dest->mutex);
+}
diff --git a/blockdev.c b/blockdev.c
index 2ac15601d9..dcb7a6d54e 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3043,6 +3043,36 @@ void qmp_x_block_dirty_bitmap_disable(const char *node, const char *name,
     bdrv_disable_dirty_bitmap(bitmap);
 }
 
+void qmp_x_block_dirty_bitmap_merge(const char *node, const char *dst_name,
+                                    const char *src_name, Error **errp)
+{
+    BlockDriverState *bs;
+    BdrvDirtyBitmap *dst, *src;
+
+    dst = block_dirty_bitmap_lookup(node, dst_name, &bs, errp);
+    if (!dst) {
+        return;
+    }
+
+    if (bdrv_dirty_bitmap_frozen(dst)) {
+        error_setg(errp, "Bitmap '%s' is frozen and cannot be modified",
+                   dst_name);
+        return;
+    } else if (bdrv_dirty_bitmap_readonly(dst)) {
+        error_setg(errp, "Bitmap '%s' is readonly and cannot be modified",
+                   dst_name);
+        return;
+    }
+
+    src = bdrv_find_dirty_bitmap(bs, src_name);
+    if (!src) {
+        error_setg(errp, "Dirty bitmap '%s' not found", src_name);
+        return;
+    }
+
+    bdrv_merge_dirty_bitmap(dst, src, errp);
+}
+
 BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(const char *node,
                                                               const char *name,
                                                               Error **errp)
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 5a51a78b63..02e0cbabd2 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -69,7 +69,8 @@ void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap, bool value);
 void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap,
                                        bool persistent);
 void bdrv_dirty_bitmap_set_qmp_locked(BdrvDirtyBitmap *bitmap, bool qmp_locked);
-
+void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
+                             Error **errp);
 
 /* Functions that require manual locking.  */
 void bdrv_dirty_bitmap_lock(BdrvDirtyBitmap *bitmap);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 02de674f5f..9d4ab93190 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1740,6 +1740,20 @@
   'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32',
             '*persistent': 'bool', '*autoload': 'bool' } }
 
+##
+# @BlockDirtyBitmapMerge:
+#
+# @node: name of device/node which the bitmap is tracking
+#
+# @dst_name: name of the destination dirty bitmap
+#
+# @src_name: name of the source dirty bitmap
+#
+# Since: 3.0
+##
+{ 'struct': 'BlockDirtyBitmapMerge',
+  'data': { 'node': 'str', 'dst_name': 'str', 'src_name': 'str' } }
+
 ##
 # @block-dirty-bitmap-add:
 #
@@ -1850,6 +1864,30 @@
     { 'command': 'x-block-dirty-bitmap-disable',
       'data': 'BlockDirtyBitmap' }
 
+##
+# @x-block-dirty-bitmap-merge:
+#
+# Merge @src_name dirty bitmap to @dst_name dirty bitmap. @src_name dirty
+# bitmap is unchanged. On error, @dst_name is unchanged.
+#
+# Returns: nothing on success
+#          If @node is not a valid block device, DeviceNotFound
+#          If @dst_name or @src_name is not found, GenericError
+#          If bitmaps has different sizes or granularities, GenericError
+#
+# Since: 3.0
+#
+# Example:
+#
+# -> { "execute": "x-block-dirty-bitmap-merge",
+#      "arguments": { "node": "drive0", "dst_name": "bitmap0",
+#                     "src_name": "bitmap1" } }
+# <- { "return": {} }
+#
+##
+      { 'command': 'x-block-dirty-bitmap-merge',
+        'data': 'BlockDirtyBitmapMerge' }
+
 ##
 # @BlockDirtyBitmapSha256:
 #
-- 
2.14.3
