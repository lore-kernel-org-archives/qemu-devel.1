Received: from eggs.gnu.org ([2001:4830:134:3::10]:52722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpqJ-0001QG-3n
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:55:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpqI-000314-2s
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:55:43 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  2 Mar 2018 19:54:30 +0100
Message-Id: <20180302185448.6314-20-kwolf@redhat.com>
In-Reply-To: <20180302185448.6314-1-kwolf@redhat.com>
References: <20180302185448.6314-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 19/37] vpc: Switch to .bdrv_co_block_status()
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

We are gradually moving away from sector-based interfaces, towards
byte-based.  Update the vpc driver accordingly.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vpc.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/block/vpc.c b/block/vpc.c
index cfa5144e86..fba4492fd7 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -706,53 +706,54 @@ fail:
     return ret;
 }
 
-static int64_t coroutine_fn vpc_co_get_block_status(BlockDriverState *bs,
-        int64_t sector_num, int nb_sectors, int *pnum, BlockDriverState **file)
+static int coroutine_fn vpc_co_block_status(BlockDriverState *bs,
+                                            bool want_zero,
+                                            int64_t offset, int64_t bytes,
+                                            int64_t *pnum, int64_t *map,
+                                            BlockDriverState **file)
 {
     BDRVVPCState *s = bs->opaque;
     VHDFooter *footer = (VHDFooter*) s->footer_buf;
-    int64_t start, offset;
+    int64_t image_offset;
     bool allocated;
-    int64_t ret;
-    int n;
+    int ret;
+    int64_t n;
 
     if (be32_to_cpu(footer->type) == VHD_FIXED) {
-        *pnum = nb_sectors;
+        *pnum = bytes;
+        *map = offset;
         *file = bs->file->bs;
-        return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
-               (sector_num << BDRV_SECTOR_BITS);
+        return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID;
     }
 
     qemu_co_mutex_lock(&s->lock);
 
-    offset = get_image_offset(bs, sector_num << BDRV_SECTOR_BITS, false, NULL);
-    start = offset;
-    allocated = (offset != -1);
+    image_offset = get_image_offset(bs, offset, false, NULL);
+    allocated = (image_offset != -1);
     *pnum = 0;
     ret = 0;
 
     do {
         /* All sectors in a block are contiguous (without using the bitmap) */
-        n = ROUND_UP(sector_num + 1, s->block_size / BDRV_SECTOR_SIZE)
-          - sector_num;
-        n = MIN(n, nb_sectors);
+        n = ROUND_UP(offset + 1, s->block_size) - offset;
+        n = MIN(n, bytes);
 
         *pnum += n;
-        sector_num += n;
-        nb_sectors -= n;
+        offset += n;
+        bytes -= n;
         /* *pnum can't be greater than one block for allocated
          * sectors since there is always a bitmap in between. */
         if (allocated) {
             *file = bs->file->bs;
-            ret = BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID | start;
+            *map = image_offset;
+            ret = BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID;
             break;
         }
-        if (nb_sectors == 0) {
+        if (bytes == 0) {
             break;
         }
-        offset = get_image_offset(bs, sector_num << BDRV_SECTOR_BITS, false,
-                                  NULL);
-    } while (offset == -1);
+        image_offset = get_image_offset(bs, offset, false, NULL);
+    } while (image_offset == -1);
 
     qemu_co_mutex_unlock(&s->lock);
     return ret;
@@ -1098,7 +1099,7 @@ static BlockDriver bdrv_vpc = {
 
     .bdrv_co_preadv             = vpc_co_preadv,
     .bdrv_co_pwritev            = vpc_co_pwritev,
-    .bdrv_co_get_block_status   = vpc_co_get_block_status,
+    .bdrv_co_block_status       = vpc_co_block_status,
 
     .bdrv_get_info          = vpc_get_info,
 
-- 
2.13.6
