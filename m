Received: from eggs.gnu.org ([2001:4830:134:3::10]:36969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVSaA-0004yq-0M
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 21:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVSa6-0001bT-9g
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 21:06:17 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 12 Jul 2017 20:05:42 -0500
Message-Id: <20170713010555.6769-6-eblake@redhat.com>
In-Reply-To: <20170713010555.6769-1-eblake@redhat.com>
References: <20170713010555.6769-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 05/18] dirty-bitmap: Change
 bdrv_dirty_bitmap_size() to report bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

We are still using an internal hbitmap that tracks a size in sectors,
with the granularity scaled down accordingly, because it lets us
use a shortcut for our iterators which are currently sector-based.
But there's no reason we can't track the dirty bitmap size in bytes,
since it is (mostly) an internal-only variable (remember, the size
is how many bytes are covered by the bitmap, not how many bytes the
bitmap occupies).  Furthermore, we're already reporting bytes for
bdrv_dirty_bitmap_granularity(); mixing bytes and sectors in our
return values is a recipe for confusion.  A later cleanup will
convert dirty bitmap internals to be entirely byte-based,
eliminating the intermediate sector rounding added here; and
technically, since bdrv_getlength() already rounds up to sectors,
our use of DIV_ROUND_UP is more for theoretical completeness than
for any actual rounding.

The only external caller in qcow2-bitmap.c is temporarily more verbose
(because it is still using sector-based math), but will later be
switched to track progress by bytes instead of sectors.

Use is_power_of_2() while at it, instead of open-coding that, and
add an assertion where bdrv_getlength() should not fail.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v5: fix bdrv_dirty_bitmap_truncate [John], drop R-b
v4: retitle from "Track size in bytes", rebase to persistent bitmaps,
round up when converting bytes to sectors
v3: no change
v2: tweak commit message, no code change
---
 block/dirty-bitmap.c | 26 +++++++++++++++-----------
 block/qcow2-bitmap.c | 14 ++++++++------
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 42a55e4..e65ec4f 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -1,7 +1,7 @@
 /*
  * Block Dirty Bitmap
  *
- * Copyright (c) 2016 Red Hat. Inc
+ * Copyright (c) 2016-2017 Red Hat. Inc
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
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
@@ -305,13 +307,14 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
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
+        hbitmap_truncate(bitmap->bitmap, DIV_ROUND_UP(size, BDRV_SECTOR_SIZE));
         bitmap->size = size;
     }
     bdrv_dirty_bitmaps_unlock(bs);
@@ -549,7 +552,8 @@ void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out)
         hbitmap_reset_all(bitmap->bitmap);
     } else {
         HBitmap *backup = bitmap->bitmap;
-        bitmap->bitmap = hbitmap_alloc(bitmap->size,
+        bitmap->bitmap = hbitmap_alloc(DIV_ROUND_UP(bitmap->size,
+                                                    BDRV_SECTOR_SIZE),
                                        hbitmap_granularity(backup));
         *out = backup;
     }
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 5aa0b8d..d478fe8 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -295,10 +295,11 @@ static int load_bitmap_data(BlockDriverState *bs,
     BDRVQcow2State *s = bs->opaque;
     uint64_t sector, sbc;
     uint64_t bm_size = bdrv_dirty_bitmap_size(bitmap);
+    uint64_t bm_sectors = DIV_ROUND_UP(bm_size, BDRV_SECTOR_SIZE);
     uint8_t *buf = NULL;
     uint64_t i, tab_size =
             size_to_clusters(s,
-                bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_size));
+                bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_sectors));

     if (tab_size != bitmap_table_size || tab_size > BME_MAX_TABLE_SIZE) {
         return -EINVAL;
@@ -307,7 +308,7 @@ static int load_bitmap_data(BlockDriverState *bs,
     buf = g_malloc(s->cluster_size);
     sbc = sectors_covered_by_bitmap_cluster(s, bitmap);
     for (i = 0, sector = 0; i < tab_size; ++i, sector += sbc) {
-        uint64_t count = MIN(bm_size - sector, sbc);
+        uint64_t count = MIN(bm_sectors - sector, sbc);
         uint64_t entry = bitmap_table[i];
         uint64_t offset = entry & BME_TABLE_ENTRY_OFFSET_MASK;

@@ -1073,13 +1074,14 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
     int64_t sector;
     uint64_t sbc;
     uint64_t bm_size = bdrv_dirty_bitmap_size(bitmap);
+    uint64_t bm_sectors = DIV_ROUND_UP(bm_size, BDRV_SECTOR_SIZE);
     const char *bm_name = bdrv_dirty_bitmap_name(bitmap);
     uint8_t *buf = NULL;
     BdrvDirtyBitmapIter *dbi;
     uint64_t *tb;
     uint64_t tb_size =
             size_to_clusters(s,
-                bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_size));
+                bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_sectors));

     if (tb_size > BME_MAX_TABLE_SIZE ||
         tb_size * s->cluster_size > BME_MAX_PHYS_SIZE)
@@ -1097,7 +1099,7 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
     dbi = bdrv_dirty_iter_new(bitmap, 0);
     buf = g_malloc(s->cluster_size);
     sbc = sectors_covered_by_bitmap_cluster(s, bitmap);
-    assert(DIV_ROUND_UP(bm_size, sbc) == tb_size);
+    assert(DIV_ROUND_UP(bm_sectors, sbc) == tb_size);

     while ((sector = bdrv_dirty_iter_next(dbi)) != -1) {
         uint64_t cluster = sector / sbc;
@@ -1105,7 +1107,7 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
         int64_t off;

         sector = cluster * sbc;
-        end = MIN(bm_size, sector + sbc);
+        end = MIN(bm_sectors, sector + sbc);
         write_size =
             bdrv_dirty_bitmap_serialization_size(bitmap, sector, end - sector);
         assert(write_size <= s->cluster_size);
@@ -1137,7 +1139,7 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
             goto fail;
         }

-        if (end >= bm_size) {
+        if (end >= bm_sectors) {
             break;
         }

-- 
2.9.4
