Received: from eggs.gnu.org ([2001:4830:134:3::10]:58544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i2x-0000HA-En
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i2v-0001ky-Q0
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:07 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 26 Oct 2017 15:17:10 +0200
Message-Id: <20171026131741.5059-5-kwolf@redhat.com>
In-Reply-To: <20171026131741.5059-1-kwolf@redhat.com>
References: <20171026131741.5059-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 04/35] block: Add flag to avoid wasted work in
 bdrv_is_allocated()
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

Not all callers care about which BDS owns the mapping for a given
range of the file, or where the zeroes lie within that mapping.  In
particular, bdrv_is_allocated() cares more about finding the
largest run of allocated data from the guest perspective, whether
or not that data is consecutive from the host perspective, and
whether or not the data reads as zero.  Therefore, doing subsequent
refinements such as checking how much of the format-layer
allocation also satisfies BDRV_BLOCK_ZERO at the protocol layer is
wasted work - in the best case, it just costs extra CPU cycles
during a single bdrv_is_allocated(), but in the worst case, it
results in a smaller *pnum, and forces callers to iterate through
more status probes when visiting the entire file for even more
extra CPU cycles.

This patch only optimizes the block layer (no behavior change when
want_zero is true, but skip unnecessary effort when it is false).
Then when subsequent patches tweak the driver callback to be
byte-based, we can also pass this hint through to the driver.

Tweak BdrvCoGetBlockStatusData to declare arguments in parameter
order, rather than mixing things up (minimizing padding is not
necessary here).

Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 57 +++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/block/io.c b/block/io.c
index 93231b0e26..8ba408c813 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1769,10 +1769,11 @@ int bdrv_flush_all(void)
 typedef struct BdrvCoGetBlockStatusData {
     BlockDriverState *bs;
     BlockDriverState *base;
-    BlockDriverState **file;
+    bool want_zero;
     int64_t sector_num;
     int nb_sectors;
     int *pnum;
+    BlockDriverState **file;
     int64_t ret;
     bool done;
 } BdrvCoGetBlockStatusData;
@@ -1808,6 +1809,11 @@ int64_t coroutine_fn bdrv_co_get_block_status_from_backing(BlockDriverState *bs,
  * Drivers not implementing the functionality are assumed to not support
  * backing files, hence all their sectors are reported as allocated.
  *
+ * If 'want_zero' is true, the caller is querying for mapping purposes,
+ * and the result should include BDRV_BLOCK_OFFSET_VALID and
+ * BDRV_BLOCK_ZERO where possible; otherwise, the result may omit those
+ * bits particularly if it allows for a larger value in 'pnum'.
+ *
  * If 'sector_num' is beyond the end of the disk image the return value is
  * BDRV_BLOCK_EOF and 'pnum' is set to 0.
  *
@@ -1824,6 +1830,7 @@ int64_t coroutine_fn bdrv_co_get_block_status_from_backing(BlockDriverState *bs,
  * is allocated in.
  */
 static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
+                                                     bool want_zero,
                                                      int64_t sector_num,
                                                      int nb_sectors, int *pnum,
                                                      BlockDriverState **file)
@@ -1878,31 +1885,34 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
 
     if (ret & BDRV_BLOCK_RAW) {
         assert(ret & BDRV_BLOCK_OFFSET_VALID && local_file);
-        ret = bdrv_co_get_block_status(local_file, ret >> BDRV_SECTOR_BITS,
+        ret = bdrv_co_get_block_status(local_file, want_zero,
+                                       ret >> BDRV_SECTOR_BITS,
                                        *pnum, pnum, &local_file);
         goto out;
     }
 
     if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
         ret |= BDRV_BLOCK_ALLOCATED;
-    } else {
+    } else if (want_zero) {
         if (bdrv_unallocated_blocks_are_zero(bs)) {
             ret |= BDRV_BLOCK_ZERO;
         } else if (bs->backing) {
             BlockDriverState *bs2 = bs->backing->bs;
             int64_t nb_sectors2 = bdrv_nb_sectors(bs2);
+
             if (nb_sectors2 >= 0 && sector_num >= nb_sectors2) {
                 ret |= BDRV_BLOCK_ZERO;
             }
         }
     }
 
-    if (local_file && local_file != bs &&
+    if (want_zero && local_file && local_file != bs &&
         (ret & BDRV_BLOCK_DATA) && !(ret & BDRV_BLOCK_ZERO) &&
         (ret & BDRV_BLOCK_OFFSET_VALID)) {
         int file_pnum;
 
-        ret2 = bdrv_co_get_block_status(local_file, ret >> BDRV_SECTOR_BITS,
+        ret2 = bdrv_co_get_block_status(local_file, want_zero,
+                                        ret >> BDRV_SECTOR_BITS,
                                         *pnum, &file_pnum, NULL);
         if (ret2 >= 0) {
             /* Ignore errors.  This is just providing extra information, it
@@ -1938,6 +1948,7 @@ early_out:
 
 static int64_t coroutine_fn bdrv_co_get_block_status_above(BlockDriverState *bs,
         BlockDriverState *base,
+        bool want_zero,
         int64_t sector_num,
         int nb_sectors,
         int *pnum,
@@ -1949,7 +1960,8 @@ static int64_t coroutine_fn bdrv_co_get_block_status_above(BlockDriverState *bs,
 
     assert(bs != base);
     for (p = bs; p != base; p = backing_bs(p)) {
-        ret = bdrv_co_get_block_status(p, sector_num, nb_sectors, pnum, file);
+        ret = bdrv_co_get_block_status(p, want_zero, sector_num, nb_sectors,
+                                       pnum, file);
         if (ret < 0) {
             break;
         }
@@ -1979,6 +1991,7 @@ static void coroutine_fn bdrv_get_block_status_above_co_entry(void *opaque)
     BdrvCoGetBlockStatusData *data = opaque;
 
     data->ret = bdrv_co_get_block_status_above(data->bs, data->base,
+                                               data->want_zero,
                                                data->sector_num,
                                                data->nb_sectors,
                                                data->pnum,
@@ -1991,20 +2004,22 @@ static void coroutine_fn bdrv_get_block_status_above_co_entry(void *opaque)
  *
  * See bdrv_co_get_block_status_above() for details.
  */
-int64_t bdrv_get_block_status_above(BlockDriverState *bs,
-                                    BlockDriverState *base,
-                                    int64_t sector_num,
-                                    int nb_sectors, int *pnum,
-                                    BlockDriverState **file)
+static int64_t bdrv_common_block_status_above(BlockDriverState *bs,
+                                              BlockDriverState *base,
+                                              bool want_zero,
+                                              int64_t sector_num,
+                                              int nb_sectors, int *pnum,
+                                              BlockDriverState **file)
 {
     Coroutine *co;
     BdrvCoGetBlockStatusData data = {
         .bs = bs,
         .base = base,
-        .file = file,
+        .want_zero = want_zero,
         .sector_num = sector_num,
         .nb_sectors = nb_sectors,
         .pnum = pnum,
+        .file = file,
         .done = false,
     };
 
@@ -2020,6 +2035,16 @@ int64_t bdrv_get_block_status_above(BlockDriverState *bs,
     return data.ret;
 }
 
+int64_t bdrv_get_block_status_above(BlockDriverState *bs,
+                                    BlockDriverState *base,
+                                    int64_t sector_num,
+                                    int nb_sectors, int *pnum,
+                                    BlockDriverState **file)
+{
+    return bdrv_common_block_status_above(bs, base, true, sector_num,
+                                          nb_sectors, pnum, file);
+}
+
 int64_t bdrv_get_block_status(BlockDriverState *bs,
                               int64_t sector_num,
                               int nb_sectors, int *pnum,
@@ -2032,15 +2057,15 @@ int64_t bdrv_get_block_status(BlockDriverState *bs,
 int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
                                    int64_t bytes, int64_t *pnum)
 {
-    int64_t sector_num = offset >> BDRV_SECTOR_BITS;
-    int nb_sectors = bytes >> BDRV_SECTOR_BITS;
     int64_t ret;
     int psectors;
 
     assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
     assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE) && bytes < INT_MAX);
-    ret = bdrv_get_block_status(bs, sector_num, nb_sectors, &psectors,
-                                NULL);
+    ret = bdrv_common_block_status_above(bs, backing_bs(bs), false,
+                                         offset >> BDRV_SECTOR_BITS,
+                                         bytes >> BDRV_SECTOR_BITS, &psectors,
+                                         NULL);
     if (ret < 0) {
         return ret;
     }
-- 
2.13.6
