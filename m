Received: from eggs.gnu.org ([2001:4830:134:3::10]:46689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQHCE-0000mH-Iw
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 13:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQHCD-0002UX-7j
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 13:56:10 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 28 Jun 2017 12:55:34 -0500
Message-Id: <20170628175534.14295-12-eblake@redhat.com>
In-Reply-To: <20170628175534.14295-1-eblake@redhat.com>
References: <20170628175534.14295-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 11/11] dirty-bitmap: Convert internal
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
Cc: jsnow@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

Now that all callers are using byte-based interfaces, there's no
reason for our internal hbitmap to remain with sector-based
granularity.  It also simplifies our internal scaling, since we
already know that hbitmap widens requests out to granularity
boundaries.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>

---
v2: no change
---
 block/dirty-bitmap.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index e353b69..b0af91f 100644
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
@@ -118,12 +118,7 @@ BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
     }
     bitmap = g_new0(BdrvDirtyBitmap, 1);
     bitmap->mutex = &bs->dirty_bitmap_mutex;
-    /*
-     * TODO - let hbitmap track full granularity. For now, it is tracking
-     * only sector granularity, as a shortcut for our iterators.
-     */
-    bitmap->bitmap = hbitmap_alloc(bitmap_size >> BDRV_SECTOR_BITS,
-                                   ctz32(granularity) - BDRV_SECTOR_BITS);
+    bitmap->bitmap = hbitmap_alloc(bitmap_size, ctz32(granularity));
     bitmap->size = bitmap_size;
     bitmap->name = g_strdup(name);
     bitmap->disabled = false;
@@ -293,7 +288,7 @@ void bdrv_dirty_bitmap_truncate(BlockDriverState *bs)
     QLIST_FOREACH(bitmap, &bs->dirty_bitmaps, list) {
         assert(!bdrv_dirty_bitmap_frozen(bitmap));
         assert(!bitmap->active_iterators);
-        hbitmap_truncate(bitmap->bitmap, size >> BDRV_SECTOR_BITS);
+        hbitmap_truncate(bitmap->bitmap, size);
         bitmap->size = size;
     }
     bdrv_dirty_bitmaps_unlock(bs);
@@ -388,7 +383,7 @@ bool bdrv_get_dirty_locked(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
                            int64_t offset)
 {
     if (bitmap) {
-        return hbitmap_get(bitmap->bitmap, offset >> BDRV_SECTOR_BITS);
+        return hbitmap_get(bitmap->bitmap, offset);
     } else {
         return false;
     }
@@ -416,7 +411,7 @@ uint32_t bdrv_get_default_bitmap_granularity(BlockDriverState *bs)

 uint32_t bdrv_dirty_bitmap_granularity(BdrvDirtyBitmap *bitmap)
 {
-    return BDRV_SECTOR_SIZE << hbitmap_granularity(bitmap->bitmap);
+    return 1U << hbitmap_granularity(bitmap->bitmap);
 }

 BdrvDirtyBitmapIter *bdrv_dirty_iter_new(BdrvDirtyBitmap *bitmap)
@@ -449,18 +444,15 @@ void bdrv_dirty_iter_free(BdrvDirtyBitmapIter *iter)

 int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter)
 {
-    return hbitmap_iter_next(&iter->hbi) * BDRV_SECTOR_SIZE;
+    return hbitmap_iter_next(&iter->hbi);
 }

 /* Called within bdrv_dirty_bitmap_lock..unlock */
 void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
                                   int64_t offset, int64_t bytes)
 {
-    int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
-
     assert(bdrv_dirty_bitmap_enabled(bitmap));
-    hbitmap_set(bitmap->bitmap, offset >> BDRV_SECTOR_BITS,
-                end_sector - (offset >> BDRV_SECTOR_BITS));
+    hbitmap_set(bitmap->bitmap, offset, bytes);
 }

 void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
@@ -475,11 +467,8 @@ void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
 void bdrv_reset_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
                                     int64_t offset, int64_t bytes)
 {
-    int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
-
     assert(bdrv_dirty_bitmap_enabled(bitmap));
-    hbitmap_reset(bitmap->bitmap, offset >> BDRV_SECTOR_BITS,
-                  end_sector - (offset >> BDRV_SECTOR_BITS));
+    hbitmap_reset(bitmap->bitmap, offset, bytes);
 }

 void bdrv_reset_dirty_bitmap(BdrvDirtyBitmap *bitmap,
@@ -498,7 +487,7 @@ void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out)
         hbitmap_reset_all(bitmap->bitmap);
     } else {
         HBitmap *backup = bitmap->bitmap;
-        bitmap->bitmap = hbitmap_alloc(bitmap->size >> BDRV_SECTOR_BITS,
+        bitmap->bitmap = hbitmap_alloc(bitmap->size,
                                        hbitmap_granularity(backup));
         *out = backup;
     }
@@ -553,7 +542,6 @@ void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBitmap *bitmap)
 void bdrv_set_dirty(BlockDriverState *bs, int64_t offset, int64_t bytes)
 {
     BdrvDirtyBitmap *bitmap;
-    int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);

     if (QLIST_EMPTY(&bs->dirty_bitmaps)) {
         return;
@@ -564,8 +552,7 @@ void bdrv_set_dirty(BlockDriverState *bs, int64_t offset, int64_t bytes)
         if (!bdrv_dirty_bitmap_enabled(bitmap)) {
             continue;
         }
-        hbitmap_set(bitmap->bitmap, offset >> BDRV_SECTOR_BITS,
-                    end_sector - (offset >> BDRV_SECTOR_BITS));
+        hbitmap_set(bitmap->bitmap, offset, bytes);
     }
     bdrv_dirty_bitmaps_unlock(bs);
 }
@@ -575,12 +562,12 @@ void bdrv_set_dirty(BlockDriverState *bs, int64_t offset, int64_t bytes)
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
2.9.4
