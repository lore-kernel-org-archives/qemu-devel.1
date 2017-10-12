Received: from eggs.gnu.org ([2001:4830:134:3::10]:45600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2ioi-000094-Tx
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 15:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2ioh-0003zd-S7
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 15:06:48 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 12 Oct 2017 13:59:16 -0500
Message-Id: <20171012185916.22776-21-eblake@redhat.com>
In-Reply-To: <20171012185916.22776-1-eblake@redhat.com>
References: <20171012185916.22776-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 20/20] block: Drop unused
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
Cc: qemu-block@nongnu.org, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Now that all drivers have been updated to provide the
byte-based .bdrv_co_block_status(), we can delete the sector-based
interface.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v4: rebase to interface tweak
v3: no change
v2: rebase to earlier changes
---
 include/block/block_int.h |  3 ---
 block/io.c                | 34 +---------------------------------
 2 files changed, 1 insertion(+), 36 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 7c8503f693..6e7ae5fc8d 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -213,9 +213,6 @@ struct BlockDriver {
      * guarantees input aligned to request_alignment, as well as
      * non-NULL pnum, map, and file.
      */
-    int64_t coroutine_fn (*bdrv_co_get_block_status)(BlockDriverState *bs,
-        int64_t sector_num, int nb_sectors, int *pnum,
-        BlockDriverState **file);
     int coroutine_fn (*bdrv_co_block_status)(BlockDriverState *bd,
         bool want_zero, int64_t offset, int64_t bytes, int64_t *pnum,
         int64_t *map, BlockDriverState **file);
diff --git a/block/io.c b/block/io.c
index 6a2a2e1484..7ae4cdadf5 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1847,7 +1847,7 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
         bytes = n;
     }

-    if (!bs->drv->bdrv_co_get_block_status && !bs->drv->bdrv_co_block_status) {
+    if (!bs->drv->bdrv_co_block_status) {
         *pnum = bytes;
         ret = BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED;
         if (offset + bytes == total_size) {
@@ -1865,40 +1865,9 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,

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
@@ -1916,7 +1885,6 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
         *pnum = total_size - aligned_offset;
     }

-refine:
     /*
      * The driver's result must be a multiple of request_alignment.
      * Clamp pnum and adjust map to original request.
-- 
2.13.6
