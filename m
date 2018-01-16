Received: from eggs.gnu.org ([2001:4830:134:3::10]:51903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ebQlQ-0002nz-Cg
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:54:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ebQlP-0007C6-9e
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:54:52 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:35061 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1ebQlO-000799-Tl
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:54:51 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 16 Jan 2018 15:54:26 +0300
Message-Id: <20180116125427.18540-6-vsementsov@virtuozzo.com>
In-Reply-To: <20180116125427.18540-1-vsementsov@virtuozzo.com>
References: <20180116125427.18540-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 5/6] qapi: add block-dirty-bitmap-merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, nshirokovskiy@virtuozzo.com, mnestratov@virtuozzo.com

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json         | 38 ++++++++++++++++++++++++++++++++++++++
 include/block/dirty-bitmap.h |  2 ++
 block/dirty-bitmap.c         | 18 ++++++++++++++++++
 blockdev.c                   | 30 ++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index b3851ee760..9f9cfa0a44 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1604,6 +1604,20 @@
             '*persistent': 'bool', '*autoload': 'bool' } }
 
 ##
+# @BlockDirtyBitmapMerge:
+#
+# @node: name of device/node which the bitmap is tracking
+#
+# @dst_name: name of the destination dirty bitmap
+#
+# @src_name: name of the source dirty bitmap
+#
+# Since: 2.12
+##
+{ 'struct': 'BlockDirtyBitmapMerge',
+  'data': { 'node': 'str', 'dst_name': 'str', 'src_name': 'str' } }
+
+##
 # @block-dirty-bitmap-add:
 #
 # Create a dirty bitmap with a name on the node, and start tracking the writes.
@@ -1714,6 +1728,30 @@
       'data': 'BlockDirtyBitmap' }
 
 ##
+# @block-dirty-bitmap-merge:
+#
+# Merge @src_name dirty bitmap to @dst_name dirty bitmap. @src_name dirty
+# bitmap is unchanged.
+#
+# Returns: nothing on success
+#          If @node is not a valid block device, DeviceNotFound
+#          If @dst_name or @src_name is not found, GenericError
+#          If bitmaps has different sizes or granularities, GenericError
+#
+# Since: 2.12
+#
+# Example:
+#
+# -> { "execute": "block-dirty-bitmap-merge",
+#      "arguments": { "node": "drive0", "dst_name": "bitmap0",
+#                     "src_name": "bitmap1" } }
+# <- { "return": {} }
+#
+##
+      { 'command': 'block-dirty-bitmap-merge',
+        'data': 'BlockDirtyBitmapMerge' }
+
+##
 # @BlockDirtyBitmapSha256:
 #
 # SHA256 hash of dirty bitmap data
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 144e77a879..92a1041368 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -67,6 +67,8 @@ void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap);
 void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap, bool value);
 void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap,
                                        bool persistent);
+void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
+                             Error **errp);
 
 /* Functions that require manual locking.  */
 void bdrv_dirty_bitmap_lock(BdrvDirtyBitmap *bitmap);
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index d0a10c4f5d..afcb3f541e 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -699,3 +699,21 @@ char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp)
 {
     return hbitmap_sha256(bitmap->bitmap, errp);
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
index d338363d78..1650c31c87 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2942,6 +2942,36 @@ void qmp_block_dirty_bitmap_disable(const char *node, const char *name,
     bdrv_disable_dirty_bitmap(bitmap);
 }
 
+void qmp_block_dirty_bitmap_merge(const char *node, const char *dst_name,
+                                  const char *src_name, Error **errp)
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
-- 
2.11.1
