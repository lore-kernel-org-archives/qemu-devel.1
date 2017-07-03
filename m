Received: from eggs.gnu.org ([2001:4830:134:3::10]:57444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS9hp-0003tu-7X
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 18:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS9hm-0001FB-3H
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 18:20:33 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  3 Jul 2017 17:20:15 -0500
Message-Id: <20170703222015.31507-1-eblake@redhat.com>
In-Reply-To: <20170703221456.30817-1-eblake@redhat.com>
References: <20170703221456.30817-1-eblake@redhat.com>
Subject: [Qemu-devel] [RFC PATCH v2 16/15] block: Add
 .bdrv_co_block_status() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based. Now that the block layer exposes byte-based allocation,
it's time to tackle the drivers.  Add a new callback that operates
on as small as byte boundaries. Subsequent patches will then update
individual drivers, then finally remove .bdrv_co_get_block_status().
The old code now uses a goto in order to minimize churn at that later
removal.

The new code also passes through the 'allocation' hint, which will
allow subsequent patches to further optimize callers that only care
about how much of the image is allocated, rather than which offsets
the allocation actually maps to.

Note that most drivers give sector-aligned answers, except at
end-of-file, even when request_alignment is smaller than a sector.
However, bdrv_getlength() is sector-aligned (even though it gives a
byte answer), often by exceeding the actual file size.  If we were to
give back strict results, at least file-posix.c would report a
transition from DATA to HOLE at the end of a file even in the middle
of a sector, which can throw off callers; so we intentionally lie and
state that any partial sector at the end of a file has the same
status for the entire sector.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: improve alignment handling, add additional 'allocation' argument
for future optimization potential, ensure all iotests still pass

Sending as an RFC as part of my third series; this patch is technically
the start of my fourth series, but given the rebase churn I've had
elsewhere, it can't hurt to get the interface looked at in case it
needs tweaking
---
 include/block/block_int.h |  9 ++++++++-
 block/io.c                | 27 ++++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 5f6ba5d..45ff534 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -172,13 +172,20 @@ struct BlockDriver {
      * bdrv_is_allocated[_above].  The driver should answer only
      * according to the current layer, and should not set
      * BDRV_BLOCK_ALLOCATED, but may set BDRV_BLOCK_RAW.  See block.h
-     * for the meaning of _DATA, _ZERO, and _OFFSET_VALID.  The block
+     * for the meaning of _DATA, _ZERO, and _OFFSET_VALID.  As a hint,
+     * the flag allocation is true if the caller cares more about
+     * learning how much of the image is allocated, without regards to
+     * a breakdown by offset (a driver may either ignore the hint, or
+     * avoid _OFFSET_VALID to provide a larger *pnum).  The block
      * layer guarantees input aligned to request_alignment, as well as
      * non-NULL pnum and file.
      */
     int64_t coroutine_fn (*bdrv_co_get_block_status)(BlockDriverState *bs,
         int64_t sector_num, int nb_sectors, int *pnum,
         BlockDriverState **file);
+    int64_t coroutine_fn (*bdrv_co_block_status)(BlockDriverState *bd,
+        bool allocation, int64_t offset, int64_t bytes, int64_t *pnum,
+        BlockDriverState **file);

     /*
      * Invalidate any cached meta-data.
diff --git a/block/io.c b/block/io.c
index 5ed1ac7..00cdac1 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1771,7 +1771,7 @@ static int64_t coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
         bytes = n;
     }

-    if (!bs->drv->bdrv_co_get_block_status) {
+    if (!bs->drv->bdrv_co_get_block_status && !bs->drv->bdrv_co_block_status) {
         *pnum = bytes;
         ret = BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED;
         if (offset + bytes == total_size) {
@@ -1791,11 +1791,14 @@ static int64_t coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
     bdrv_inc_in_flight(bs);

     /* Round out to request_alignment boundaries */
-    align = MAX(bs->bl.request_alignment, BDRV_SECTOR_SIZE);
+    align = bs->bl.request_alignment;
+    if (bs->drv->bdrv_co_get_block_status && align < BDRV_SECTOR_SIZE) {
+        align = BDRV_SECTOR_SIZE;
+    }
     aligned_offset = QEMU_ALIGN_DOWN(offset, align);
     aligned_bytes = ROUND_UP(offset + bytes, align) - aligned_offset;

-    {
+    if (bs->drv->bdrv_co_get_block_status) {
         int count; /* sectors */

         assert(QEMU_IS_ALIGNED(aligned_offset | aligned_bytes,
@@ -1808,8 +1811,26 @@ static int64_t coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
             goto out;
         }
         *pnum = count * BDRV_SECTOR_SIZE;
+        goto refine;
     }

+    ret = bs->drv->bdrv_co_block_status(bs, false, aligned_offset,
+                                        aligned_bytes, pnum, &local_file);
+    if (ret < 0) {
+        *pnum = 0;
+        goto out;
+    }
+
+    /*
+     * total_size is always sector-aligned, by sometimes exceeding actual
+     * file size. Expand pnum if it lands mid-sector due to end-of-file.
+     */
+    if (QEMU_ALIGN_UP(*pnum + aligned_offset,
+                      BDRV_SECTOR_SIZE) == total_size) {
+        *pnum = total_size - aligned_offset;
+    }
+
+ refine:
     /* Clamp pnum and ret to original request */
     assert(QEMU_IS_ALIGNED(*pnum, align));
     *pnum -= offset - aligned_offset;
-- 
2.9.4
