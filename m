Received: from eggs.gnu.org ([2001:4830:134:3::10]:39921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drrr8-0002Ji-67
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 16:32:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drrr6-0006eG-Ip
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 16:32:26 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 12 Sep 2017 15:31:19 -0500
Message-Id: <20170912203119.24166-21-eblake@redhat.com>
In-Reply-To: <20170912203119.24166-1-eblake@redhat.com>
References: <20170912203119.24166-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 20/20] dirty-bitmap: Convert internal
 hbitmap size/granularity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

Now that all callers are using byte-based interfaces, there's no
reason for our internal hbitmap to remain with sector-based
granularity.  It also simplifies our internal scaling, since we
already know that hbitmap widens requests out to granularity
boundaries.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>

---
v7: rebase to dirty_iter_next cleanup (no semantic change, R-b kept)
v6: no change
v5: fix bdrv_dirty_bitmap_truncate [John]
v4: rebase to earlier changes, include serialization, R-b dropped
v3: no change
v2: no change
---
 block/dirty-bitmap.c | 62 +++++++++++++++-------------------------------------
 1 file changed, 18 insertions(+), 44 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index dd91f56b94..c2322c2619 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -38,7 +38,7 @@
  */
 struct BdrvDirtyBitmap {
     QemuMutex *mutex;
-    HBitmap *bitmap;            /* Dirty sector bitmap implementation */
+    HBitmap *bitmap;            /* Dirty bitmap implementation */
     HBitmap *meta;              /* Meta dirty bitmap */
     BdrvDirtyBitmap *successor; /* Anonymous child; implies frozen status */
     char *name;                 /* Optional non-empty unique ID */
@@ -130,12 +130,7 @@ BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
     }
     bitmap = g_new0(BdrvDirtyBitmap, 1);
     bitmap->mutex = &bs->dirty_bitmap_mutex;
-    /*
-     * TODO - let hbitmap track full granularity. For now, it is tracking
-     * only sector granularity, as a shortcut for our iterators.
-     */
-    bitmap->bitmap = hbitmap_alloc(DIV_ROUND_UP(bitmap_size, BDRV_SECTOR_SIZE),
-                                   ctz32(granularity) - BDRV_SECTOR_BITS);
+    bitmap->bitmap = hbitmap_alloc(bitmap_size, ctz32(granularity));
     bitmap->size = bitmap_size;
     bitmap->name = g_strdup(name);
     bitmap->disabled = false;
@@ -316,7 +311,7 @@ int bdrv_dirty_bitmap_truncate(BlockDriverState *bs)
     QLIST_FOREACH(bitmap, &bs->dirty_bitmaps, list) {
         assert(!bdrv_dirty_bitmap_frozen(bitmap));
         assert(!bitmap->active_iterators);
-        hbitmap_truncate(bitmap->bitmap, DIV_ROUND_UP(size, BDRV_SECTOR_SIZE));
+        hbitmap_truncate(bitmap->bitmap, size);
         bitmap->size = size;
     }
     bdrv_dirty_bitmaps_unlock(bs);
@@ -447,7 +442,7 @@ bool bdrv_get_dirty_locked(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
                            int64_t offset)
 {
     if (bitmap) {
-        return hbitmap_get(bitmap->bitmap, offset >> BDRV_SECTOR_BITS);
+        return hbitmap_get(bitmap->bitmap, offset);
     } else {
         return false;
     }
@@ -475,7 +470,7 @@ uint32_t bdrv_get_default_bitmap_granularity(BlockDriverState *bs)

 uint32_t bdrv_dirty_bitmap_granularity(const BdrvDirtyBitmap *bitmap)
 {
-    return BDRV_SECTOR_SIZE << hbitmap_granularity(bitmap->bitmap);
+    return 1U << hbitmap_granularity(bitmap->bitmap);
 }

 BdrvDirtyBitmapIter *bdrv_dirty_iter_new(BdrvDirtyBitmap *bitmap)
@@ -508,20 +503,16 @@ void bdrv_dirty_iter_free(BdrvDirtyBitmapIter *iter)

 int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter)
 {
-    int64_t ret = hbitmap_iter_next(&iter->hbi);
-    return ret < 0 ? -1 : ret * BDRV_SECTOR_SIZE;
+    return hbitmap_iter_next(&iter->hbi);
 }

 /* Called within bdrv_dirty_bitmap_lock..unlock */
 void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
                                   int64_t offset, int64_t bytes)
 {
-    int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
-
     assert(bdrv_dirty_bitmap_enabled(bitmap));
     assert(!bdrv_dirty_bitmap_readonly(bitmap));
-    hbitmap_set(bitmap->bitmap, offset >> BDRV_SECTOR_BITS,
-                end_sector - (offset >> BDRV_SECTOR_BITS));
+    hbitmap_set(bitmap->bitmap, offset, bytes);
 }

 void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
@@ -536,12 +527,9 @@ void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
 void bdrv_reset_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
                                     int64_t offset, int64_t bytes)
 {
-    int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
-
     assert(bdrv_dirty_bitmap_enabled(bitmap));
     assert(!bdrv_dirty_bitmap_readonly(bitmap));
-    hbitmap_reset(bitmap->bitmap, offset >> BDRV_SECTOR_BITS,
-                  end_sector - (offset >> BDRV_SECTOR_BITS));
+    hbitmap_reset(bitmap->bitmap, offset, bytes);
 }

 void bdrv_reset_dirty_bitmap(BdrvDirtyBitmap *bitmap,
@@ -561,8 +549,7 @@ void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out)
         hbitmap_reset_all(bitmap->bitmap);
     } else {
         HBitmap *backup = bitmap->bitmap;
-        bitmap->bitmap = hbitmap_alloc(DIV_ROUND_UP(bitmap->size,
-                                                    BDRV_SECTOR_SIZE),
+        bitmap->bitmap = hbitmap_alloc(bitmap->size,
                                        hbitmap_granularity(backup));
         *out = backup;
     }
@@ -581,51 +568,40 @@ void bdrv_undo_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap *in)
 uint64_t bdrv_dirty_bitmap_serialization_size(const BdrvDirtyBitmap *bitmap,
                                               uint64_t offset, uint64_t bytes)
 {
-    assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));
-    return hbitmap_serialization_size(bitmap->bitmap,
-                                      offset >> BDRV_SECTOR_BITS,
-                                      bytes >> BDRV_SECTOR_BITS);
+    return hbitmap_serialization_size(bitmap->bitmap, offset, bytes);
 }

 uint64_t bdrv_dirty_bitmap_serialization_align(const BdrvDirtyBitmap *bitmap)
 {
-    return hbitmap_serialization_align(bitmap->bitmap) * BDRV_SECTOR_SIZE;
+    return hbitmap_serialization_align(bitmap->bitmap);
 }

 void bdrv_dirty_bitmap_serialize_part(const BdrvDirtyBitmap *bitmap,
                                       uint8_t *buf, uint64_t offset,
                                       uint64_t bytes)
 {
-    assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));
-    hbitmap_serialize_part(bitmap->bitmap, buf, offset >> BDRV_SECTOR_BITS,
-                           bytes >> BDRV_SECTOR_BITS);
+    hbitmap_serialize_part(bitmap->bitmap, buf, offset, bytes);
 }

 void bdrv_dirty_bitmap_deserialize_part(BdrvDirtyBitmap *bitmap,
                                         uint8_t *buf, uint64_t offset,
                                         uint64_t bytes, bool finish)
 {
-    assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));
-    hbitmap_deserialize_part(bitmap->bitmap, buf, offset >> BDRV_SECTOR_BITS,
-                             bytes >> BDRV_SECTOR_BITS, finish);
+    hbitmap_deserialize_part(bitmap->bitmap, buf, offset, bytes, finish);
 }

 void bdrv_dirty_bitmap_deserialize_zeroes(BdrvDirtyBitmap *bitmap,
                                           uint64_t offset, uint64_t bytes,
                                           bool finish)
 {
-    assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));
-    hbitmap_deserialize_zeroes(bitmap->bitmap, offset >> BDRV_SECTOR_BITS,
-                               bytes >> BDRV_SECTOR_BITS, finish);
+    hbitmap_deserialize_zeroes(bitmap->bitmap, offset, bytes, finish);
 }

 void bdrv_dirty_bitmap_deserialize_ones(BdrvDirtyBitmap *bitmap,
                                         uint64_t offset, uint64_t bytes,
                                         bool finish)
 {
-    assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTOR_SIZE));
-    hbitmap_deserialize_ones(bitmap->bitmap, offset >> BDRV_SECTOR_BITS,
-                             bytes >> BDRV_SECTOR_BITS, finish);
+    hbitmap_deserialize_ones(bitmap->bitmap, offset, bytes, finish);
 }

 void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap)
@@ -636,7 +612,6 @@ void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap)
 void bdrv_set_dirty(BlockDriverState *bs, int64_t offset, int64_t bytes)
 {
     BdrvDirtyBitmap *bitmap;
-    int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);

     if (QLIST_EMPTY(&bs->dirty_bitmaps)) {
         return;
@@ -648,8 +623,7 @@ void bdrv_set_dirty(BlockDriverState *bs, int64_t offset, int64_t bytes)
             continue;
         }
         assert(!bdrv_dirty_bitmap_readonly(bitmap));
-        hbitmap_set(bitmap->bitmap, offset >> BDRV_SECTOR_BITS,
-                    end_sector - (offset >> BDRV_SECTOR_BITS));
+        hbitmap_set(bitmap->bitmap, offset, bytes);
     }
     bdrv_dirty_bitmaps_unlock(bs);
 }
@@ -659,12 +633,12 @@ void bdrv_set_dirty(BlockDriverState *bs, int64_t offset, int64_t bytes)
  */
 void bdrv_set_dirty_iter(BdrvDirtyBitmapIter *iter, int64_t offset)
 {
-    hbitmap_iter_init(&iter->hbi, iter->hbi.hb, offset >> BDRV_SECTOR_BITS);
+    hbitmap_iter_init(&iter->hbi, iter->hbi.hb, offset);
 }

 int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap)
 {
-    return hbitmap_count(bitmap->bitmap) << BDRV_SECTOR_BITS;
+    return hbitmap_count(bitmap->bitmap);
 }

 int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap)
-- 
2.13.5
