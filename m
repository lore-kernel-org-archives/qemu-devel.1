Received: from eggs.gnu.org ([2001:4830:134:3::10]:55183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS30N-00073W-Ga
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 11:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS30M-0008AF-Fz
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 11:11:15 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  3 Jul 2017 10:10:41 -0500
Message-Id: <20170703151051.31327-8-eblake@redhat.com>
In-Reply-To: <20170703151051.31327-1-eblake@redhat.com>
References: <20170703151051.31327-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 07/17] qcow2: Switch
 sectors_covered_by_bitmap_cluster() to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, Max Reitz <mreitz@redhat.com>

We are gradually converting to byte-based interfaces, as they are
easier to reason about than sector-based.  Change the qcow2 bitmap
helper function sectors_covered_by_bitmap_cluster(), renaming it
in the process.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v4: new patch
---
 block/qcow2-bitmap.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 8fd2598..7fce226 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -269,18 +269,16 @@ static int free_bitmap_clusters(BlockDriverState *bs, Qcow2BitmapTable *tb)
     return 0;
 }

-/* This function returns the number of disk sectors covered by a single qcow2
- * cluster of bitmap data. */
-static uint64_t sectors_covered_by_bitmap_cluster(const BDRVQcow2State *s,
-                                                  const BdrvDirtyBitmap *bitmap)
+/* Return the disk size covered by a single qcow2 cluster of bitmap data. */
+static uint64_t bytes_covered_by_bitmap_cluster(const BDRVQcow2State *s,
+                                                const BdrvDirtyBitmap *bitmap)
 {
-    uint64_t sector_granularity =
-            bdrv_dirty_bitmap_granularity(bitmap) >> BDRV_SECTOR_BITS;
-    uint64_t sbc = sector_granularity * (s->cluster_size << 3);
+    uint64_t granularity = bdrv_dirty_bitmap_granularity(bitmap);
+    uint64_t limit = granularity * (s->cluster_size << 3);

-    assert(QEMU_IS_ALIGNED(sbc << BDRV_SECTOR_BITS,
+    assert(QEMU_IS_ALIGNED(limit,
                            bdrv_dirty_bitmap_serialization_align(bitmap)));
-    return sbc;
+    return limit;
 }

 /* load_bitmap_data
@@ -293,7 +291,7 @@ static int load_bitmap_data(BlockDriverState *bs,
 {
     int ret = 0;
     BDRVQcow2State *s = bs->opaque;
-    uint64_t sector, sbc;
+    uint64_t sector, limit, sbc;
     uint64_t bm_size = bdrv_dirty_bitmap_size(bitmap);
     uint64_t bm_sectors = DIV_ROUND_UP(bm_size, BDRV_SECTOR_SIZE);
     uint8_t *buf = NULL;
@@ -306,7 +304,8 @@ static int load_bitmap_data(BlockDriverState *bs,
     }

     buf = g_malloc(s->cluster_size);
-    sbc = sectors_covered_by_bitmap_cluster(s, bitmap);
+    limit = bytes_covered_by_bitmap_cluster(s, bitmap);
+    sbc = limit >> BDRV_SECTOR_BITS;
     for (i = 0, sector = 0; i < tab_size; ++i, sector += sbc) {
         uint64_t count = MIN(bm_sectors - sector, sbc);
         uint64_t entry = bitmap_table[i];
@@ -1076,7 +1075,7 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
     int ret;
     BDRVQcow2State *s = bs->opaque;
     int64_t sector;
-    uint64_t sbc;
+    uint64_t limit, sbc;
     uint64_t bm_size = bdrv_dirty_bitmap_size(bitmap);
     uint64_t bm_sectors = DIV_ROUND_UP(bm_size, BDRV_SECTOR_SIZE);
     const char *bm_name = bdrv_dirty_bitmap_name(bitmap);
@@ -1102,8 +1101,9 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,

     dbi = bdrv_dirty_iter_new(bitmap, 0);
     buf = g_malloc(s->cluster_size);
-    sbc = sectors_covered_by_bitmap_cluster(s, bitmap);
-    assert(DIV_ROUND_UP(bm_sectors, sbc) == tb_size);
+    limit = bytes_covered_by_bitmap_cluster(s, bitmap);
+    sbc = limit >> BDRV_SECTOR_BITS;
+    assert(DIV_ROUND_UP(bm_size, limit) == tb_size);

     while ((sector = bdrv_dirty_iter_next(dbi)) != -1) {
         uint64_t cluster = sector / sbc;
-- 
2.9.4
