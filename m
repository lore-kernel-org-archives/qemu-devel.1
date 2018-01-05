Received: from eggs.gnu.org ([2001:4830:134:3::10]:47281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXawF-0002oD-6L
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:58:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXawD-0008SH-8Z
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:58:11 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri,  5 Jan 2018 16:57:34 -0600
Message-Id: <20180105225753.30509-2-eblake@redhat.com>
In-Reply-To: <20180105225753.30509-1-eblake@redhat.com>
References: <20180105225753.30509-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 01/20] block: Add .bdrv_co_block_status()
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based. Now that the block layer exposes byte-based allocation,
it's time to tackle the drivers.  Add a new callback that operates
on as small as byte boundaries. Subsequent patches will then update
individual drivers, then finally remove .bdrv_co_get_block_status().

The new code also passes through the 'want_zero' hint, which will
allow subsequent patches to further optimize callers that only care
about how much of the image is allocated (want_zero is false),
rather than full details about runs of zeroes and which offsets the
allocation actually maps to (want_zero is true).  As part of this
effort, fix another part of the documentation: the claim in commit
4c41cb4 that BDRV_BLOCK_ALLOCATED is short for 'DATA || ZERO' is a
lie at the block layer (see commit e88ae2264), even though it is
how the bit is computed from the driver layer.  After all, there
are intentionally cases where we return ZERO but not ALLOCATED at
the block layer, when we know that a read sees zero because the
backing file is too short.  Note that the driver interface is thus
slightly different than the public interface with regards to which
bits will be set, and what guarantees are provided on input.

We also add an assertion that any driver using the new callback will
make progress (the only time pnum will be 0 is if the block layer
already handled an out-of-bounds request, or if there is an error);
the old driver interface did not provide this guarantee, which
could lead to some inf-loops in drastic corner-case failures.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Fam Zheng <famz@redhat.com>

---
v7: add R-b
v6: drop now-useless rounding of mid-sector end-of-file hole [Kevin],
better documentation of 'want_zero' [Kevin]
v5: rebase to master, typo fix, document more block layer guarantees
v4: rebase to master
v3: no change
v2: improve alignment handling, ensure all iotests still pass
---
 include/block/block.h     | 14 +++++++-------
 include/block/block_int.h | 20 +++++++++++++++-----
 block/io.c                | 28 +++++++++++++++++++---------
 3 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 9b12774ddf..179901c9f4 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -128,19 +128,19 @@ typedef struct HDGeometry {
  * BDRV_BLOCK_ZERO: offset reads as zero
  * BDRV_BLOCK_OFFSET_VALID: an associated offset exists for accessing raw data
  * BDRV_BLOCK_ALLOCATED: the content of the block is determined by this
- *                       layer (short for DATA || ZERO), set by block layer
- * BDRV_BLOCK_EOF: the returned pnum covers through end of file for this layer
+ *                       layer rather than any backing, set by block layer
+ * BDRV_BLOCK_EOF: the returned pnum covers through end of file for this
+ *                 layer, set by block layer
  *
  * Internal flag:
  * BDRV_BLOCK_RAW: for use by passthrough drivers, such as raw, to request
  *                 that the block layer recompute the answer from the returned
  *                 BDS; must be accompanied by just BDRV_BLOCK_OFFSET_VALID.
  *
- * If BDRV_BLOCK_OFFSET_VALID is set, bits 9-62 (BDRV_BLOCK_OFFSET_MASK) of
- * the return value (old interface) or the entire map parameter (new
- * interface) represent the offset in the returned BDS that is allocated for
- * the corresponding raw data.  However, whether that offset actually
- * contains data also depends on BDRV_BLOCK_DATA, as follows:
+ * If BDRV_BLOCK_OFFSET_VALID is set, the map parameter represents the
+ * host offset within the returned BDS that is allocated for the
+ * corresponding raw guest data.  However, whether that offset
+ * actually contains data also depends on BDRV_BLOCK_DATA, as follows:
  *
  * DATA ZERO OFFSET_VALID
  *  t    t        t       sectors read as zero, returned file is zero at offset
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 29cafa4236..4c9777b55d 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -204,15 +204,25 @@ struct BlockDriver {
     /*
      * Building block for bdrv_block_status[_above] and
      * bdrv_is_allocated[_above].  The driver should answer only
-     * according to the current layer, and should not set
-     * BDRV_BLOCK_ALLOCATED, but may set BDRV_BLOCK_RAW.  See block.h
-     * for the meaning of _DATA, _ZERO, and _OFFSET_VALID.  The block
-     * layer guarantees input aligned to request_alignment, as well as
-     * non-NULL pnum and file.
+     * according to the current layer, and should only need to set
+     * BDRV_BLOCK_DATA, BDRV_BLOCK_ZERO, BDRV_BLOCK_OFFSET_VALID,
+     * and/or BDRV_BLOCK_RAW; if the current layer defers to a backing
+     * layer, the result should be 0 (and not BDRV_BLOCK_ZERO).  See
+     * block.h for the overall meaning of the bits.  As a hint, the
+     * flag want_zero is true if the caller cares more about precise
+     * mappings (favor accurate _OFFSET_VALID/_ZERO) or false for
+     * overall allocation (favor larger *pnum, perhaps by reporting
+     * _DATA instead of _ZERO).  The block layer guarantees input
+     * clamped to bdrv_getlength() and aligned to request_alignment,
+     * as well as non-NULL pnum, map, and file; in turn, the driver
+     * must return an error or set pnum to an aligned non-zero value.
      */
     int64_t coroutine_fn (*bdrv_co_get_block_status)(BlockDriverState *bs,
         int64_t sector_num, int nb_sectors, int *pnum,
         BlockDriverState **file);
+    int coroutine_fn (*bdrv_co_block_status)(BlockDriverState *bs,
+        bool want_zero, int64_t offset, int64_t bytes, int64_t *pnum,
+        int64_t *map, BlockDriverState **file);

     /*
      * Invalidate any cached meta-data.
diff --git a/block/io.c b/block/io.c
index 7ea402352e..9a697f3b20 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1899,10 +1899,10 @@ int64_t coroutine_fn bdrv_co_get_block_status_from_backing(BlockDriverState *bs,
  * Drivers not implementing the functionality are assumed to not support
  * backing files, hence all their sectors are reported as allocated.
  *
- * If 'want_zero' is true, the caller is querying for mapping purposes,
- * and the result should include BDRV_BLOCK_OFFSET_VALID and
- * BDRV_BLOCK_ZERO where possible; otherwise, the result may omit those
- * bits particularly if it allows for a larger value in 'pnum'.
+ * If 'want_zero' is true, the caller is querying for mapping
+ * purposes, with a focus on valid BDRV_BLOCK_OFFSET_VALID, _DATA, and
+ * _ZERO where possible; otherwise, the result favors larger 'pnum',
+ * with a focus on accurate BDRV_BLOCK_ALLOCATED.
  *
  * If 'offset' is beyond the end of the disk image the return value is
  * BDRV_BLOCK_EOF and 'pnum' is set to 0.
@@ -1959,7 +1959,7 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,

     /* Must be non-NULL or bdrv_getlength() would have failed */
     assert(bs->drv);
-    if (!bs->drv->bdrv_co_get_block_status) {
+    if (!bs->drv->bdrv_co_get_block_status && !bs->drv->bdrv_co_block_status) {
         *pnum = bytes;
         ret = BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED;
         if (offset + bytes == total_size) {
@@ -1976,13 +1976,14 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
     bdrv_inc_in_flight(bs);

     /* Round out to request_alignment boundaries */
-    /* TODO: until we have a byte-based driver callback, we also have to
-     * round out to sectors, even if that is bigger than request_alignment */
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
         int64_t longret;

@@ -2007,6 +2008,15 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
         }
         ret = longret & ~BDRV_BLOCK_OFFSET_MASK;
         *pnum = count * BDRV_SECTOR_SIZE;
+    } else {
+        ret = bs->drv->bdrv_co_block_status(bs, want_zero, aligned_offset,
+                                            aligned_bytes, pnum, &local_map,
+                                            &local_file);
+        if (ret < 0) {
+            *pnum = 0;
+            goto out;
+        }
+        assert(*pnum); /* The block driver must make progress */
     }

     /*
-- 
2.14.3
