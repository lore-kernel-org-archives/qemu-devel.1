Received: from eggs.gnu.org ([2001:4830:134:3::10]:55466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uxb-0000F4-5A
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uxa-0002ex-7O
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:54:47 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  6 Oct 2017 17:53:38 +0200
Message-Id: <20171006155422.10135-11-kwolf@redhat.com>
In-Reply-To: <20171006155422.10135-1-kwolf@redhat.com>
References: <20171006155422.10135-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 10/54] qcow2: Switch
 sectors_covered_by_bitmap_cluster() to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

We are gradually converting to byte-based interfaces, as they are
easier to reason about than sector-based.  Change the qcow2 bitmap
helper function sectors_covered_by_bitmap_cluster(), renaming it
to bytes_covered_by_bitmap_cluster() in the process.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-bitmap.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 9e799996e6..8324468b16 100644
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
@@ -1080,7 +1079,7 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
     int ret;
     BDRVQcow2State *s = bs->opaque;
     int64_t sector;
-    uint64_t sbc;
+    uint64_t limit, sbc;
     uint64_t bm_size = bdrv_dirty_bitmap_size(bitmap);
     uint64_t bm_sectors = DIV_ROUND_UP(bm_size, BDRV_SECTOR_SIZE);
     const char *bm_name = bdrv_dirty_bitmap_name(bitmap);
@@ -1106,8 +1105,9 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
 
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
2.13.6
