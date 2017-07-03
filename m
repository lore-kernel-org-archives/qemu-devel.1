Received: from eggs.gnu.org ([2001:4830:134:3::10]:55813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS9co-0007W8-VI
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 18:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS9cn-0004Te-DG
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 18:15:22 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  3 Jul 2017 17:14:44 -0500
Message-Id: <20170703221456.30817-4-eblake@redhat.com>
In-Reply-To: <20170703221456.30817-1-eblake@redhat.com>
References: <20170703221456.30817-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 03/15] block: Add flag to avoid wasted work
 in bdrv_is_allocated()
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

Not all callers care about which BDS owns the mapping for a given
range of the file.  In particular, bdrv_is_allocated() cares more
about finding the largest run of allocated data from the guest
perspective, whether or not that data is consecutive from the
host perspective.  Therefore, doing subsequent refinements such
as checking how much of the format-layer allocation also satisfies
BDRV_BLOCK_ZERO at the protocol layer is wasted work - in the best
case, it just costs extra CPU cycles during a single
bdrv_is_allocated(), but in the worst case, it results in a smaller
*pnum, and forces callers to iterate through more status probes when
visiting the entire file for even more extra CPU cycles.

This patch only optimizes the block layer.  But subsequent patches
will tweak the driver callback to be byte-based, and in the process,
can also pass this hint through to the driver.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: new patch
---
 block/io.c | 51 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/block/io.c b/block/io.c
index 6358d07..719a6b0 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1685,6 +1685,7 @@ typedef struct BdrvCoGetBlockStatusData {
     int nb_sectors;
     int *pnum;
     int64_t ret;
+    bool allocation;
     bool done;
 } BdrvCoGetBlockStatusData;

@@ -1717,6 +1718,10 @@ int64_t coroutine_fn bdrv_co_get_block_status_from_backing(BlockDriverState *bs,
  * Drivers not implementing the functionality are assumed to not support
  * backing files, hence all their sectors are reported as allocated.
  *
+ * If 'allocation' is true, the caller only cares about allocation
+ * status; this is a hint that a larger 'pnum' result is more
+ * important than including BDRV_BLOCK_OFFSET_VALID in the return.
+ *
  * If 'sector_num' is beyond the end of the disk image the return value is
  * BDRV_BLOCK_EOF and 'pnum' is set to 0.
  *
@@ -1733,6 +1738,7 @@ int64_t coroutine_fn bdrv_co_get_block_status_from_backing(BlockDriverState *bs,
  * is allocated in.
  */
 static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
+                                                     bool allocation,
                                                      int64_t sector_num,
                                                      int nb_sectors, int *pnum,
                                                      BlockDriverState **file)
@@ -1791,14 +1797,15 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,

     if (ret & BDRV_BLOCK_RAW) {
         assert(ret & BDRV_BLOCK_OFFSET_VALID && local_file);
-        ret = bdrv_co_get_block_status(local_file, ret >> BDRV_SECTOR_BITS,
+        ret = bdrv_co_get_block_status(local_file, allocation,
+                                       ret >> BDRV_SECTOR_BITS,
                                        *pnum, pnum, &local_file);
         goto out;
     }

     if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
         ret |= BDRV_BLOCK_ALLOCATED;
-    } else {
+    } else if (!allocation) {
         if (bdrv_unallocated_blocks_are_zero(bs)) {
             ret |= BDRV_BLOCK_ZERO;
         } else if (bs->backing) {
@@ -1810,12 +1817,13 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
         }
     }

-    if (local_file && local_file != bs &&
+    if (!allocation && local_file && local_file != bs &&
         (ret & BDRV_BLOCK_DATA) && !(ret & BDRV_BLOCK_ZERO) &&
         (ret & BDRV_BLOCK_OFFSET_VALID)) {
         int file_pnum;

-        ret2 = bdrv_co_get_block_status(local_file, ret >> BDRV_SECTOR_BITS,
+        ret2 = bdrv_co_get_block_status(local_file, true,
+                                        ret >> BDRV_SECTOR_BITS,
                                         *pnum, &file_pnum, NULL);
         if (ret2 >= 0) {
             /* Ignore errors.  This is just providing extra information, it
@@ -1850,6 +1858,7 @@ out:

 static int64_t coroutine_fn bdrv_co_get_block_status_above(BlockDriverState *bs,
         BlockDriverState *base,
+        bool allocation,
         int64_t sector_num,
         int nb_sectors,
         int *pnum,
@@ -1861,7 +1870,8 @@ static int64_t coroutine_fn bdrv_co_get_block_status_above(BlockDriverState *bs,

     assert(bs != base);
     for (p = bs; p != base; p = backing_bs(p)) {
-        ret = bdrv_co_get_block_status(p, sector_num, nb_sectors, pnum, file);
+        ret = bdrv_co_get_block_status(p, allocation, sector_num, nb_sectors,
+                                       pnum, file);
         if (ret < 0) {
             break;
         }
@@ -1891,6 +1901,7 @@ static void coroutine_fn bdrv_get_block_status_above_co_entry(void *opaque)
     BdrvCoGetBlockStatusData *data = opaque;

     data->ret = bdrv_co_get_block_status_above(data->bs, data->base,
+                                               data->allocation,
                                                data->sector_num,
                                                data->nb_sectors,
                                                data->pnum,
@@ -1903,11 +1914,12 @@ static void coroutine_fn bdrv_get_block_status_above_co_entry(void *opaque)
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
+                                              bool allocation,
+                                              int64_t sector_num,
+                                              int nb_sectors, int *pnum,
+                                              BlockDriverState **file)
 {
     Coroutine *co;
     BdrvCoGetBlockStatusData data = {
@@ -1917,6 +1929,7 @@ int64_t bdrv_get_block_status_above(BlockDriverState *bs,
         .sector_num = sector_num,
         .nb_sectors = nb_sectors,
         .pnum = pnum,
+        .allocation = allocation,
         .done = false,
     };

@@ -1932,6 +1945,16 @@ int64_t bdrv_get_block_status_above(BlockDriverState *bs,
     return data.ret;
 }

+int64_t bdrv_get_block_status_above(BlockDriverState *bs,
+                                    BlockDriverState *base,
+                                    int64_t sector_num,
+                                    int nb_sectors, int *pnum,
+                                    BlockDriverState **file)
+{
+    return bdrv_common_block_status_above(bs, base, false, sector_num,
+                                          nb_sectors, pnum, file);
+}
+
 int64_t bdrv_get_block_status(BlockDriverState *bs,
                               int64_t sector_num,
                               int nb_sectors, int *pnum,
@@ -1944,16 +1967,16 @@ int64_t bdrv_get_block_status(BlockDriverState *bs,
 int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
                                    int64_t bytes, int64_t *pnum)
 {
-    int64_t sector_num = offset >> BDRV_SECTOR_BITS;
-    int nb_sectors = bytes >> BDRV_SECTOR_BITS;
     int64_t ret;
     int psectors;

     assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
     assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE) &&
            bytes < INT_MAX * BDRV_SECTOR_SIZE);
-    ret = bdrv_get_block_status(bs, sector_num, nb_sectors, &psectors,
-                                NULL);
+    ret = bdrv_common_block_status_above(bs, backing_bs(bs), true,
+                                         offset >> BDRV_SECTOR_BITS,
+                                         bytes >> BDRV_SECTOR_BITS, &psectors,
+                                         NULL);
     if (ret < 0) {
         return ret;
     }
-- 
2.9.4
