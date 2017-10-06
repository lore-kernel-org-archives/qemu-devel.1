Received: from eggs.gnu.org ([2001:4830:134:3::10]:55868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uxt-0000YI-Ur
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uxq-00039U-TJ
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:06 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  6 Oct 2017 17:53:46 +0200
Message-Id: <20171006155422.10135-19-kwolf@redhat.com>
In-Reply-To: <20171006155422.10135-1-kwolf@redhat.com>
References: <20171006155422.10135-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 18/54] qcow2: Switch load_bitmap_data() to
 byte-based iteration
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

Now that we have adjusted the majority of the calls this function
makes to be byte-based, it is easier to read the code if it makes
passes over the image using bytes rather than sectors.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-bitmap.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 2d8dcba3e8..02512a21f2 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -291,9 +291,8 @@ static int load_bitmap_data(BlockDriverState *bs,
 {
     int ret = 0;
     BDRVQcow2State *s = bs->opaque;
-    uint64_t sector, limit, sbc;
+    uint64_t offset, limit;
     uint64_t bm_size = bdrv_dirty_bitmap_size(bitmap);
-    uint64_t bm_sectors = DIV_ROUND_UP(bm_size, BDRV_SECTOR_SIZE);
     uint8_t *buf = NULL;
     uint64_t i, tab_size =
             size_to_clusters(s,
@@ -305,32 +304,27 @@ static int load_bitmap_data(BlockDriverState *bs,
 
     buf = g_malloc(s->cluster_size);
     limit = bytes_covered_by_bitmap_cluster(s, bitmap);
-    sbc = limit >> BDRV_SECTOR_BITS;
-    for (i = 0, sector = 0; i < tab_size; ++i, sector += sbc) {
-        uint64_t count = MIN(bm_sectors - sector, sbc);
+    for (i = 0, offset = 0; i < tab_size; ++i, offset += limit) {
+        uint64_t count = MIN(bm_size - offset, limit);
         uint64_t entry = bitmap_table[i];
-        uint64_t offset = entry & BME_TABLE_ENTRY_OFFSET_MASK;
+        uint64_t data_offset = entry & BME_TABLE_ENTRY_OFFSET_MASK;
 
         assert(check_table_entry(entry, s->cluster_size) == 0);
 
-        if (offset == 0) {
+        if (data_offset == 0) {
             if (entry & BME_TABLE_ENTRY_FLAG_ALL_ONES) {
-                bdrv_dirty_bitmap_deserialize_ones(bitmap,
-                                                   sector * BDRV_SECTOR_SIZE,
-                                                   count * BDRV_SECTOR_SIZE,
+                bdrv_dirty_bitmap_deserialize_ones(bitmap, offset, count,
                                                    false);
             } else {
                 /* No need to deserialize zeros because the dirty bitmap is
                  * already cleared */
             }
         } else {
-            ret = bdrv_pread(bs->file, offset, buf, s->cluster_size);
+            ret = bdrv_pread(bs->file, data_offset, buf, s->cluster_size);
             if (ret < 0) {
                 goto finish;
             }
-            bdrv_dirty_bitmap_deserialize_part(bitmap, buf,
-                                               sector * BDRV_SECTOR_SIZE,
-                                               count * BDRV_SECTOR_SIZE,
+            bdrv_dirty_bitmap_deserialize_part(bitmap, buf, offset, count,
                                                false);
         }
     }
-- 
2.13.6
