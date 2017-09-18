Received: from eggs.gnu.org ([2001:4830:134:3::10]:44190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1du1Fl-00025m-LT
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 14:58:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1du1Fk-0006PG-Jn
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 14:58:45 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 18 Sep 2017 13:58:05 -0500
Message-Id: <20170918185819.5984-7-eblake@redhat.com>
In-Reply-To: <20170918185819.5984-1-eblake@redhat.com>
References: <20170918185819.5984-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v8 06/20] dirty-bitmap: Change
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
Cc: kwolf@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

We're already reporting bytes for bdrv_dirty_bitmap_granularity();
mixing bytes and sectors in our return values is a recipe for
confusion.  A later cleanup will convert dirty bitmap internals
to be entirely byte-based, but in the meantime, we should report
the bitmap size in bytes.

The only external caller in qcow2-bitmap.c is temporarily more verbose
(because it is still using sector-based math), but will later be
switched to track progress by bytes instead of sectors.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>

---
v8: no change
v7: split external from internal change [Kevin], drop R-b
v6: no change
v5: fix bdrv_dirty_bitmap_truncate [John], drop R-b
v4: retitle from "Track size in bytes", rebase to persistent bitmaps,
round up when converting bytes to sectors
v3: no change
v2: tweak commit message, no code change
---
 block/dirty-bitmap.c |  2 +-
 block/qcow2-bitmap.c | 14 ++++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index ee164fb518..755555af32 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -175,7 +175,7 @@ void bdrv_release_meta_dirty_bitmap(BdrvDirtyBitmap *bitmap)

 int64_t bdrv_dirty_bitmap_size(const BdrvDirtyBitmap *bitmap)
 {
-    return bitmap->size;
+    return bitmap->size * BDRV_SECTOR_SIZE;
 }

 const char *bdrv_dirty_bitmap_name(const BdrvDirtyBitmap *bitmap)
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index b3ee4c794a..65122e9ae1 100644
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

@@ -1077,13 +1078,14 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
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
@@ -1101,7 +1103,7 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
     dbi = bdrv_dirty_iter_new(bitmap, 0);
     buf = g_malloc(s->cluster_size);
     sbc = sectors_covered_by_bitmap_cluster(s, bitmap);
-    assert(DIV_ROUND_UP(bm_size, sbc) == tb_size);
+    assert(DIV_ROUND_UP(bm_sectors, sbc) == tb_size);

     while ((sector = bdrv_dirty_iter_next(dbi)) != -1) {
         uint64_t cluster = sector / sbc;
@@ -1109,7 +1111,7 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
         int64_t off;

         sector = cluster * sbc;
-        end = MIN(bm_size, sector + sbc);
+        end = MIN(bm_sectors, sector + sbc);
         write_size =
             bdrv_dirty_bitmap_serialization_size(bitmap, sector, end - sector);
         assert(write_size <= s->cluster_size);
@@ -1141,7 +1143,7 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
             goto fail;
         }

-        if (end >= bm_size) {
+        if (end >= bm_sectors) {
             break;
         }

-- 
2.13.5
