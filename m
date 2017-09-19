Received: from eggs.gnu.org ([2001:4830:134:3::10]:42924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duP0E-0005we-4k
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:20:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duP0C-00059o-Sm
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:20:18 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 19 Sep 2017 15:18:57 -0500
Message-Id: <20170919201910.25656-8-eblake@redhat.com>
In-Reply-To: <20170919201910.25656-1-eblake@redhat.com>
References: <20170919201910.25656-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v9 07/20] dirty-bitmap: Track bitmap size by
 bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

We are still using an internal hbitmap that tracks a size in sectors,
with the granularity scaled down accordingly, because it lets us
use a shortcut for our iterators which are currently sector-based.
But there's no reason we can't track the dirty bitmap size in bytes,
since it is (mostly) an internal-only variable (remember, the size
is how many bytes are covered by the bitmap, not how many bytes the
bitmap occupies).  A later cleanup will convert dirty bitmap
internals to be entirely byte-based, eliminating the intermediate
sector rounding added here; and technically, since bdrv_getlength()
already rounds up to sectors, our use of DIV_ROUND_UP is more for
theoretical completeness than for any actual rounding.

Use is_power_of_2() while at it, instead of open-coding that.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>

---
v8: rebase to earlier truncate changes, R-b kept
v7: split external from internal [Kevin], drop R-b
v6: no change
v5: fix bdrv_dirty_bitmap_truncate [John], drop R-b
v4: retitle from "Track size in bytes", rebase to persistent bitmaps,
round up when converting bytes to sectors
v3: no change
v2: tweak commit message, no code change
---
 block/dirty-bitmap.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 755555af32..6d32554b4e 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -42,7 +42,7 @@ struct BdrvDirtyBitmap {
     HBitmap *meta;              /* Meta dirty bitmap */
     BdrvDirtyBitmap *successor; /* Anonymous child; implies frozen status */
     char *name;                 /* Optional non-empty unique ID */
-    int64_t size;               /* Size of the bitmap (Number of sectors) */
+    int64_t size;               /* Size of the bitmap, in bytes */
     bool disabled;              /* Bitmap is disabled. It ignores all writes to
                                    the device */
     int active_iterators;       /* How many iterators are active */
@@ -115,17 +115,14 @@ BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
 {
     int64_t bitmap_size;
     BdrvDirtyBitmap *bitmap;
-    uint32_t sector_granularity;

-    assert((granularity & (granularity - 1)) == 0);
+    assert(is_power_of_2(granularity) && granularity >= BDRV_SECTOR_SIZE);

     if (name && bdrv_find_dirty_bitmap(bs, name)) {
         error_setg(errp, "Bitmap already exists: %s", name);
         return NULL;
     }
-    sector_granularity = granularity >> BDRV_SECTOR_BITS;
-    assert(sector_granularity);
-    bitmap_size = bdrv_nb_sectors(bs);
+    bitmap_size = bdrv_getlength(bs);
     if (bitmap_size < 0) {
         error_setg_errno(errp, -bitmap_size, "could not get length of device");
         errno = -bitmap_size;
@@ -133,7 +130,12 @@ BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
     }
     bitmap = g_new0(BdrvDirtyBitmap, 1);
     bitmap->mutex = &bs->dirty_bitmap_mutex;
-    bitmap->bitmap = hbitmap_alloc(bitmap_size, ctz32(sector_granularity));
+    /*
+     * TODO - let hbitmap track full granularity. For now, it is tracking
+     * only sector granularity, as a shortcut for our iterators.
+     */
+    bitmap->bitmap = hbitmap_alloc(DIV_ROUND_UP(bitmap_size, BDRV_SECTOR_SIZE),
+                                   ctz32(granularity) - BDRV_SECTOR_BITS);
     bitmap->size = bitmap_size;
     bitmap->name = g_strdup(name);
     bitmap->disabled = false;
@@ -175,7 +177,7 @@ void bdrv_release_meta_dirty_bitmap(BdrvDirtyBitmap *bitmap)

 int64_t bdrv_dirty_bitmap_size(const BdrvDirtyBitmap *bitmap)
 {
-    return bitmap->size * BDRV_SECTOR_SIZE;
+    return bitmap->size;
 }

 const char *bdrv_dirty_bitmap_name(const BdrvDirtyBitmap *bitmap)
@@ -305,14 +307,13 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
 void bdrv_dirty_bitmap_truncate(BlockDriverState *bs, int64_t bytes)
 {
     BdrvDirtyBitmap *bitmap;
-    int64_t size = DIV_ROUND_UP(bytes, BDRV_SECTOR_SIZE);

     bdrv_dirty_bitmaps_lock(bs);
     QLIST_FOREACH(bitmap, &bs->dirty_bitmaps, list) {
         assert(!bdrv_dirty_bitmap_frozen(bitmap));
         assert(!bitmap->active_iterators);
-        hbitmap_truncate(bitmap->bitmap, size);
-        bitmap->size = size;
+        hbitmap_truncate(bitmap->bitmap, DIV_ROUND_UP(bytes, BDRV_SECTOR_SIZE));
+        bitmap->size = bytes;
     }
     bdrv_dirty_bitmaps_unlock(bs);
 }
@@ -549,7 +550,8 @@ void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out)
         hbitmap_reset_all(bitmap->bitmap);
     } else {
         HBitmap *backup = bitmap->bitmap;
-        bitmap->bitmap = hbitmap_alloc(bitmap->size,
+        bitmap->bitmap = hbitmap_alloc(DIV_ROUND_UP(bitmap->size,
+                                                    BDRV_SECTOR_SIZE),
                                        hbitmap_granularity(backup));
         *out = backup;
     }
-- 
2.13.5
