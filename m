Received: from eggs.gnu.org ([2001:4830:134:3::10]:36093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKnhF-00027z-SA
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:58:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKndO-0008L5-SS
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:57:49 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 30 Nov 2017 19:42:42 -0600
Message-Id: <20171201014242.16877-21-eblake@redhat.com>
In-Reply-To: <20171201014242.16877-1-eblake@redhat.com>
References: <20171201014242.16877-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 20/20] block: Drop unused
 .bdrv_co_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Now that all drivers have been updated to provide the
byte-based .bdrv_co_block_status(), we can delete the sector-based
interface.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

---
v5: rebase to master
v4: rebase to interface tweak
v3: no change
v2: rebase to earlier changes
---
 include/block/block_int.h |  3 ---
 block/io.c                | 34 +---------------------------------
 2 files changed, 1 insertion(+), 36 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 980333c671..df9b62934d 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -215,9 +215,6 @@ struct BlockDriver {
      * in turn, the driver must return an error or set pnum to an
      * aligned non-zero value.
      */
-    int64_t coroutine_fn (*bdrv_co_get_block_status)(BlockDriverState *bs,
-        int64_t sector_num, int nb_sectors, int *pnum,
-        BlockDriverState **file);
     int coroutine_fn (*bdrv_co_block_status)(BlockDriverState *bs,
         bool want_zero, int64_t offset, int64_t bytes, int64_t *pnum,
         int64_t *map, BlockDriverState **file);
diff --git a/block/io.c b/block/io.c
index 49d299b7e3..9e59dfb550 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1893,7 +1893,7 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,

     /* Must be non-NULL or bdrv_getlength() would have failed */
     assert(bs->drv);
-    if (!bs->drv->bdrv_co_get_block_status && !bs->drv->bdrv_co_block_status) {
+    if (!bs->drv->bdrv_co_block_status) {
         *pnum = bytes;
         ret = BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED;
         if (offset + bytes == total_size) {
@@ -1911,40 +1911,9 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,

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
-        goto refine;
-    }
-
     ret = bs->drv->bdrv_co_block_status(bs, want_zero, aligned_offset,
                                         aligned_bytes, pnum, &local_map,
                                         &local_file);
@@ -1963,7 +1932,6 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
         *pnum = total_size - aligned_offset;
     }

-refine:
     /*
      * The driver's result must be a multiple of request_alignment.
      * Clamp pnum and adjust map to original request.
-- 
2.14.3
