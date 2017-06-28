Received: from eggs.gnu.org ([2001:4830:134:3::10]:46392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQHBv-0000XD-Ca
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 13:55:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQHBu-0002Im-Ca
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 13:55:51 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 28 Jun 2017 12:55:26 -0500
Message-Id: <20170628175534.14295-4-eblake@redhat.com>
In-Reply-To: <20170628175534.14295-1-eblake@redhat.com>
References: <20170628175534.14295-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 03/11] dirty-bitmap: Track size in bytes
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

We are still using an internal hbitmap that tracks a size in sectors,
with the granularity scaled down accordingly, because it lets us
use a shortcut for our iterators which are currently sector-based.
But there's no reason we can't track the dirty bitmap size in bytes,
since it is an internal-only variable.

Use is_power_of_2() while at it, instead of open-coding that.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>

---
v2: tweak commit message, no code change
---
 block/dirty-bitmap.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 13febf2..b2b9342 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -42,7 +42,7 @@ struct BdrvDirtyBitmap {
     HBitmap *meta;              /* Meta dirty bitmap */
     BdrvDirtyBitmap *successor; /* Anonymous child; implies frozen status */
     char *name;                 /* Optional non-empty unique ID */
-    int64_t size;               /* Size of the bitmap (Number of sectors) */
+    int64_t size;               /* Size of the bitmap, in bytes */
     bool disabled;              /* Bitmap is read-only */
     int active_iterators;       /* How many iterators are active */
     QLIST_ENTRY(BdrvDirtyBitmap) list;
@@ -103,17 +103,14 @@ BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
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
@@ -121,7 +118,12 @@ BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs,
     }
     bitmap = g_new0(BdrvDirtyBitmap, 1);
     bitmap->mutex = &bs->dirty_bitmap_mutex;
-    bitmap->bitmap = hbitmap_alloc(bitmap_size, ctz32(sector_granularity));
+    /*
+     * TODO - let hbitmap track full granularity. For now, it is tracking
+     * only sector granularity, as a shortcut for our iterators.
+     */
+    bitmap->bitmap = hbitmap_alloc(bitmap_size >> BDRV_SECTOR_BITS,
+                                   ctz32(granularity) - BDRV_SECTOR_BITS);
     bitmap->size = bitmap_size;
     bitmap->name = g_strdup(name);
     bitmap->disabled = false;
@@ -284,13 +286,14 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
 void bdrv_dirty_bitmap_truncate(BlockDriverState *bs)
 {
     BdrvDirtyBitmap *bitmap;
-    uint64_t size = bdrv_nb_sectors(bs);
+    int64_t size = bdrv_getlength(bs);

+    assert(size >= 0);
     bdrv_dirty_bitmaps_lock(bs);
     QLIST_FOREACH(bitmap, &bs->dirty_bitmaps, list) {
         assert(!bdrv_dirty_bitmap_frozen(bitmap));
         assert(!bitmap->active_iterators);
-        hbitmap_truncate(bitmap->bitmap, size);
+        hbitmap_truncate(bitmap->bitmap, size >> BDRV_SECTOR_BITS);
         bitmap->size = size;
     }
     bdrv_dirty_bitmaps_unlock(bs);
@@ -490,7 +493,7 @@ void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out)
         hbitmap_reset_all(bitmap->bitmap);
     } else {
         HBitmap *backup = bitmap->bitmap;
-        bitmap->bitmap = hbitmap_alloc(bitmap->size,
+        bitmap->bitmap = hbitmap_alloc(bitmap->size >> BDRV_SECTOR_BITS,
                                        hbitmap_granularity(backup));
         *out = backup;
     }
-- 
2.9.4
