Received: from eggs.gnu.org ([2001:4830:134:3::10]:52823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpqP-0001W9-Ax
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:55:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpqO-00033m-82
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:55:49 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  2 Mar 2018 19:54:32 +0100
Message-Id: <20180302185448.6314-22-kwolf@redhat.com>
In-Reply-To: <20180302185448.6314-1-kwolf@redhat.com>
References: <20180302185448.6314-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 21/37] block: Drop unused
 .bdrv_co_get_block_status()
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
byte-based.  Now that all drivers have been updated to provide the
byte-based .bdrv_co_block_status(), we can delete the sector-based
interface.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h |  3 ---
 block/io.c                | 50 ++++++++++-------------------------------------
 2 files changed, 10 insertions(+), 43 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index bf2598856c..5ae7738cf8 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -215,9 +215,6 @@ struct BlockDriver {
      * as well as non-NULL pnum, map, and file; in turn, the driver
      * must return an error or set pnum to an aligned non-zero value.
      */
-    int64_t coroutine_fn (*bdrv_co_get_block_status)(BlockDriverState *bs,
-        int64_t sector_num, int nb_sectors, int *pnum,
-        BlockDriverState **file);
     int coroutine_fn (*bdrv_co_block_status)(BlockDriverState *bs,
         bool want_zero, int64_t offset, int64_t bytes, int64_t *pnum,
         int64_t *map, BlockDriverState **file);
diff --git a/block/io.c b/block/io.c
index 5bae79f282..4c3dba0973 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1963,7 +1963,7 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
 
     /* Must be non-NULL or bdrv_getlength() would have failed */
     assert(bs->drv);
-    if (!bs->drv->bdrv_co_get_block_status && !bs->drv->bdrv_co_block_status) {
+    if (!bs->drv->bdrv_co_block_status) {
         *pnum = bytes;
         ret = BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED;
         if (offset + bytes == total_size) {
@@ -1981,53 +1981,23 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
 
     /* Round out to request_alignment boundaries */
     align = bs->bl.request_alignment;
-    if (bs->drv->bdrv_co_get_block_status && align < BDRV_SECTOR_SIZE) {
-        align = BDRV_SECTOR_SIZE;
-    }
     aligned_offset = QEMU_ALIGN_DOWN(offset, align);
     aligned_bytes = ROUND_UP(offset + bytes, align) - aligned_offset;
 
-    if (bs->drv->bdrv_co_get_block_status) {
-        int count; /* sectors */
-        int64_t longret;
-
-        assert(QEMU_IS_ALIGNED(aligned_offset | aligned_bytes,
-                               BDRV_SECTOR_SIZE));
-        /*
-         * The contract allows us to return pnum smaller than bytes, even
-         * if the next query would see the same status; we truncate the
-         * request to avoid overflowing the driver's 32-bit interface.
-         */
-        longret = bs->drv->bdrv_co_get_block_status(
-            bs, aligned_offset >> BDRV_SECTOR_BITS,
-            MIN(INT_MAX, aligned_bytes) >> BDRV_SECTOR_BITS, &count,
-            &local_file);
-        if (longret < 0) {
-            assert(INT_MIN <= longret);
-            ret = longret;
-            goto out;
-        }
-        if (longret & BDRV_BLOCK_OFFSET_VALID) {
-            local_map = longret & BDRV_BLOCK_OFFSET_MASK;
-        }
-        ret = longret & ~BDRV_BLOCK_OFFSET_MASK;
-        *pnum = count * BDRV_SECTOR_SIZE;
-    } else {
-        ret = bs->drv->bdrv_co_block_status(bs, want_zero, aligned_offset,
-                                            aligned_bytes, pnum, &local_map,
-                                            &local_file);
-        if (ret < 0) {
-            *pnum = 0;
-            goto out;
-        }
-        assert(*pnum); /* The block driver must make progress */
+    ret = bs->drv->bdrv_co_block_status(bs, want_zero, aligned_offset,
+                                        aligned_bytes, pnum, &local_map,
+                                        &local_file);
+    if (ret < 0) {
+        *pnum = 0;
+        goto out;
     }
 
     /*
-     * The driver's result must be a multiple of request_alignment.
+     * The driver's result must be a non-zero multiple of request_alignment.
      * Clamp pnum and adjust map to original request.
      */
-    assert(QEMU_IS_ALIGNED(*pnum, align) && align > offset - aligned_offset);
+    assert(*pnum && QEMU_IS_ALIGNED(*pnum, align) &&
+           align > offset - aligned_offset);
     *pnum -= offset - aligned_offset;
     if (*pnum > bytes) {
         *pnum = bytes;
-- 
2.13.6
