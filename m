Received: from eggs.gnu.org ([2001:4830:134:3::10]:40138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fQHAu-00035l-PT
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 14:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fQHAt-0005R2-CM
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 14:59:20 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  5 Jun 2018 14:59:04 -0400
Message-Id: <20180605185905.4583-5-jsnow@redhat.com>
In-Reply-To: <20180605185905.4583-1-jsnow@redhat.com>
References: <20180605185905.4583-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] qapi: add x-block-dirty-bitmap-merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c         | 18 ++++++++++++++++++
 blockdev.c                   | 30 ++++++++++++++++++++++++++++++
 include/block/dirty-bitmap.h |  3 ++-
 qapi/block-core.json         | 38 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 56234257f4..4159d3929e 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -757,3 +757,21 @@ int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t offset)
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
index 33bfe4817f..b00908fdfd 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3044,6 +3044,36 @@ void qmp_x_block_dirty_bitmap_disable(const char *node, const char *name,
     bdrv_disable_dirty_bitmap(bitmap);
 }
 
+void qmp_x_block_dirty_bitmap_merge(const char *node, const char *dst_name,
+                                    const char *src_name, Error **errp)
+{
+    BlockDriverState *bs;
+    BdrvDirtyBitmap *dst, *src;
+
+    dst = block_dirty_bitmap_lookup(node, dst_name, &bs, errp);
+    if (!dst || !bs) {
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
index 1ff8949b1b..1e14743032 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -70,7 +70,8 @@ void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap, bool value);
 void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap,
                                        bool persistent);
 void bdrv_dirty_bitmap_set_qmp_locked(BdrvDirtyBitmap *bitmap, bool qmp_locked);
-
+void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
+                             Error **errp);
 
 /* Functions that require manual locking.  */
 void bdrv_dirty_bitmap_lock(BdrvDirtyBitmap *bitmap);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index c061884a0e..3999175c23 100644
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
+# bitmap is unchanged.
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
