Received: from eggs.gnu.org ([2001:4830:134:3::10]:47107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsVKs-0006Vx-Nc
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsVKr-00038N-Of
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:41:46 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 14 Sep 2017 09:40:32 -0500
Message-Id: <20170914144032.14945-21-eblake@redhat.com>
In-Reply-To: <20170914144032.14945-1-eblake@redhat.com>
References: <20170914144032.14945-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 20/20] block: Drop unused
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
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  Now that all drivers have been updated to provide the
byte-based .bdrv_co_block_status(), we can delete the sector-based
interface.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: rebase to earlier changes
---
 include/block/block_int.h |  3 ---
 block/io.c                | 23 +----------------------
 2 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index ba5c2f9f1f..0bb5e9ebe0 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -212,9 +212,6 @@ struct BlockDriver {
      * (favor larger *pnum).  The block layer guarantees input aligned
      * to request_alignment, as well as non-NULL pnum and file.
      */
-    int64_t coroutine_fn (*bdrv_co_get_block_status)(BlockDriverState *bs,
-        int64_t sector_num, int nb_sectors, int *pnum,
-        BlockDriverState **file);
     int64_t coroutine_fn (*bdrv_co_block_status)(BlockDriverState *bd,
         bool mapping, int64_t offset, int64_t bytes, int64_t *pnum,
         BlockDriverState **file);
diff --git a/block/io.c b/block/io.c
index 85c01b2800..e58da6f81a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1796,7 +1796,7 @@ static int64_t coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
         bytes = n;
     }

-    if (!bs->drv->bdrv_co_get_block_status && !bs->drv->bdrv_co_block_status) {
+    if (!bs->drv->bdrv_co_block_status) {
         *pnum = bytes;
         ret = BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED;
         if (offset + bytes == total_size) {
@@ -1817,29 +1817,9 @@ static int64_t coroutine_fn bdrv_co_block_status(BlockDriverState *bs,

     /* Round out to request_alignment boundaries */
     align = bs->bl.request_alignment;
-    if (bs->drv->bdrv_co_get_block_status && align < BDRV_SECTOR_SIZE) {
-        align = BDRV_SECTOR_SIZE;
-    }
     aligned_offset = QEMU_ALIGN_DOWN(offset, align);
     aligned_bytes = ROUND_UP(offset + bytes, align) - aligned_offset;

-    if (bs->drv->bdrv_co_get_block_status) {
-        int count; /* sectors */
-
-        assert(QEMU_IS_ALIGNED(aligned_offset | aligned_bytes,
-                               BDRV_SECTOR_SIZE));
-        ret = bs->drv->bdrv_co_get_block_status(
-            bs, aligned_offset >> BDRV_SECTOR_BITS,
-            MIN(INT_MAX, aligned_bytes) >> BDRV_SECTOR_BITS, &count,
-            &local_file);
-        if (ret < 0) {
-            *pnum = 0;
-            goto out;
-        }
-        *pnum = count * BDRV_SECTOR_SIZE;
-        goto refine;
-    }
-
     ret = bs->drv->bdrv_co_block_status(bs, mapping, aligned_offset,
                                         aligned_bytes, pnum, &local_file);
     if (ret < 0) {
@@ -1856,7 +1836,6 @@ static int64_t coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
         *pnum = total_size - aligned_offset;
     }

- refine:
     /* Clamp pnum and ret to original request */
     assert(QEMU_IS_ALIGNED(*pnum, align));
     *pnum -= offset - aligned_offset;
-- 
2.13.5
