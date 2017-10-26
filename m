Received: from eggs.gnu.org ([2001:4830:134:3::10]:58487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i2r-0000AS-E5
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i2p-0001ed-Ln
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:01 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 26 Oct 2017 15:17:09 +0200
Message-Id: <20171026131741.5059-4-kwolf@redhat.com>
In-Reply-To: <20171026131741.5059-1-kwolf@redhat.com>
References: <20171026131741.5059-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 03/35] block: Allow NULL file for
 bdrv_get_block_status()
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
range of the file.  This patch merely simplifies the callers by
consolidating the logic in the common call point, while guaranteeing
a non-NULL file to all the driver callbacks, for no semantic change.
The only caller that does not care about pnum is bdrv_is_allocated,
as invoked by vvfat; we can likewise add assertions that the rest
of the stack does not have to worry about a NULL pnum.

Furthermore, this will also set the stage for a future cleanup: when
a caller does not care about which BDS owns an offset, it would be
nice to allow the driver to optimize things to not have to return
BDRV_BLOCK_OFFSET_VALID in the first place.  In the case of fragmented
allocation (for example, it's fairly easy to create a qcow2 image
where consecutive guest addresses are not at consecutive host
addresses), the current contract requires bdrv_get_block_status()
to clamp *pnum to the limit where host addresses are no longer
consecutive, but allowing a NULL file means that *pnum could be
set to the full length of known-allocated data.

Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h | 10 ++++++----
 block/io.c                | 49 ++++++++++++++++++++++++++---------------------
 block/mirror.c            |  3 +--
 block/qcow2.c             |  8 ++------
 qemu-img.c                | 10 ++++------
 5 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 885c08e989..246eee2e82 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -202,10 +202,12 @@ struct BlockDriver {
         int64_t offset, int bytes);
 
     /*
-     * Building block for bdrv_block_status[_above]. The driver should
-     * answer only according to the current layer, and should not
-     * set BDRV_BLOCK_ALLOCATED, but may set BDRV_BLOCK_RAW.  See block.h
-     * for the meaning of _DATA, _ZERO, and _OFFSET_VALID.
+     * Building block for bdrv_block_status[_above] and
+     * bdrv_is_allocated[_above].  The driver should answer only
+     * according to the current layer, and should not set
+     * BDRV_BLOCK_ALLOCATED, but may set BDRV_BLOCK_RAW.  See block.h
+     * for the meaning of _DATA, _ZERO, and _OFFSET_VALID.  The block
+     * layer guarantees non-NULL pnum and file.
      */
     int64_t coroutine_fn (*bdrv_co_get_block_status)(BlockDriverState *bs,
         int64_t sector_num, int nb_sectors, int *pnum,
diff --git a/block/io.c b/block/io.c
index 0854e0fdac..93231b0e26 100644
--- a/block/io.c
+++ b/block/io.c
@@ -718,7 +718,6 @@ int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
 {
     int64_t target_sectors, ret, nb_sectors, sector_num = 0;
     BlockDriverState *bs = child->bs;
-    BlockDriverState *file;
     int n;
 
     target_sectors = bdrv_nb_sectors(bs);
@@ -731,7 +730,7 @@ int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
         if (nb_sectors <= 0) {
             return 0;
         }
-        ret = bdrv_get_block_status(bs, sector_num, nb_sectors, &n, &file);
+        ret = bdrv_get_block_status(bs, sector_num, nb_sectors, &n, NULL);
         if (ret < 0) {
             error_report("error getting block status at sector %" PRId64 ": %s",
                          sector_num, strerror(-ret));
@@ -1820,8 +1819,9 @@ int64_t coroutine_fn bdrv_co_get_block_status_from_backing(BlockDriverState *bs,
  * beyond the end of the disk image it will be clamped; if 'pnum' is set to
  * the end of the image, then the returned value will include BDRV_BLOCK_EOF.
  *
- * If returned value is positive and BDRV_BLOCK_OFFSET_VALID bit is set, 'file'
- * points to the BDS which the sector range is allocated in.
+ * If returned value is positive, BDRV_BLOCK_OFFSET_VALID bit is set, and
+ * 'file' is non-NULL, then '*file' points to the BDS which the sector range
+ * is allocated in.
  */
 static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
                                                      int64_t sector_num,
@@ -1831,20 +1831,23 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
     int64_t total_sectors;
     int64_t n;
     int64_t ret, ret2;
+    BlockDriverState *local_file = NULL;
 
-    *file = NULL;
+    assert(pnum);
+    *pnum = 0;
     total_sectors = bdrv_nb_sectors(bs);
     if (total_sectors < 0) {
-        return total_sectors;
+        ret = total_sectors;
+        goto early_out;
     }
 
     if (sector_num >= total_sectors) {
-        *pnum = 0;
-        return BDRV_BLOCK_EOF;
+        ret = BDRV_BLOCK_EOF;
+        goto early_out;
     }
     if (!nb_sectors) {
-        *pnum = 0;
-        return 0;
+        ret = 0;
+        goto early_out;
     }
 
     n = total_sectors - sector_num;
@@ -1860,23 +1863,23 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
         }
         if (bs->drv->protocol_name) {
             ret |= BDRV_BLOCK_OFFSET_VALID | (sector_num * BDRV_SECTOR_SIZE);
-            *file = bs;
+            local_file = bs;
         }
-        return ret;
+        goto early_out;
     }
 
     bdrv_inc_in_flight(bs);
     ret = bs->drv->bdrv_co_get_block_status(bs, sector_num, nb_sectors, pnum,
-                                            file);
+                                            &local_file);
     if (ret < 0) {
         *pnum = 0;
         goto out;
     }
 
     if (ret & BDRV_BLOCK_RAW) {
-        assert(ret & BDRV_BLOCK_OFFSET_VALID && *file);
-        ret = bdrv_co_get_block_status(*file, ret >> BDRV_SECTOR_BITS,
-                                       *pnum, pnum, file);
+        assert(ret & BDRV_BLOCK_OFFSET_VALID && local_file);
+        ret = bdrv_co_get_block_status(local_file, ret >> BDRV_SECTOR_BITS,
+                                       *pnum, pnum, &local_file);
         goto out;
     }
 
@@ -1894,14 +1897,13 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
         }
     }
 
-    if (*file && *file != bs &&
+    if (local_file && local_file != bs &&
         (ret & BDRV_BLOCK_DATA) && !(ret & BDRV_BLOCK_ZERO) &&
         (ret & BDRV_BLOCK_OFFSET_VALID)) {
-        BlockDriverState *file2;
         int file_pnum;
 
-        ret2 = bdrv_co_get_block_status(*file, ret >> BDRV_SECTOR_BITS,
-                                        *pnum, &file_pnum, &file2);
+        ret2 = bdrv_co_get_block_status(local_file, ret >> BDRV_SECTOR_BITS,
+                                        *pnum, &file_pnum, NULL);
         if (ret2 >= 0) {
             /* Ignore errors.  This is just providing extra information, it
              * is useful but not necessary.
@@ -1927,6 +1929,10 @@ out:
     if (ret >= 0 && sector_num + *pnum == total_sectors) {
         ret |= BDRV_BLOCK_EOF;
     }
+early_out:
+    if (file) {
+        *file = local_file;
+    }
     return ret;
 }
 
@@ -2026,7 +2032,6 @@ int64_t bdrv_get_block_status(BlockDriverState *bs,
 int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
                                    int64_t bytes, int64_t *pnum)
 {
-    BlockDriverState *file;
     int64_t sector_num = offset >> BDRV_SECTOR_BITS;
     int nb_sectors = bytes >> BDRV_SECTOR_BITS;
     int64_t ret;
@@ -2035,7 +2040,7 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
     assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
     assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE) && bytes < INT_MAX);
     ret = bdrv_get_block_status(bs, sector_num, nb_sectors, &psectors,
-                                &file);
+                                NULL);
     if (ret < 0) {
         return ret;
     }
diff --git a/block/mirror.c b/block/mirror.c
index 153758ca9f..e76e754d26 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -390,7 +390,6 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
         int io_sectors;
         unsigned int io_bytes;
         int64_t io_bytes_acct;
-        BlockDriverState *file;
         enum MirrorMethod {
             MIRROR_METHOD_COPY,
             MIRROR_METHOD_ZERO,
@@ -401,7 +400,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
         ret = bdrv_get_block_status_above(source, NULL,
                                           offset >> BDRV_SECTOR_BITS,
                                           nb_chunks * sectors_per_chunk,
-                                          &io_sectors, &file);
+                                          &io_sectors, NULL);
         io_bytes = io_sectors * BDRV_SECTOR_SIZE;
         if (ret < 0) {
             io_bytes = MIN(nb_chunks * s->granularity, max_io_bytes);
diff --git a/block/qcow2.c b/block/qcow2.c
index f63d1831f8..0e4c91cabc 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2976,7 +2976,6 @@ static bool is_zero_sectors(BlockDriverState *bs, int64_t start,
                             uint32_t count)
 {
     int nr;
-    BlockDriverState *file;
     int64_t res;
 
     if (start + count > bs->total_sectors) {
@@ -2986,8 +2985,7 @@ static bool is_zero_sectors(BlockDriverState *bs, int64_t start,
     if (!count) {
         return true;
     }
-    res = bdrv_get_block_status_above(bs, NULL, start, count,
-                                      &nr, &file);
+    res = bdrv_get_block_status_above(bs, NULL, start, count, &nr, NULL);
     return res >= 0 && (res & BDRV_BLOCK_ZERO) && nr == count;
 }
 
@@ -3703,13 +3701,11 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
                  offset += pnum * BDRV_SECTOR_SIZE) {
                 int nb_sectors = MIN(ssize - offset,
                                      BDRV_REQUEST_MAX_BYTES) / BDRV_SECTOR_SIZE;
-                BlockDriverState *file;
                 int64_t ret;
 
                 ret = bdrv_get_block_status_above(in_bs, NULL,
                                                   offset >> BDRV_SECTOR_BITS,
-                                                  nb_sectors,
-                                                  &pnum, &file);
+                                                  nb_sectors, &pnum, NULL);
                 if (ret < 0) {
                     error_setg_errno(&local_err, -ret,
                                      "Unable to get block status");
diff --git a/qemu-img.c b/qemu-img.c
index d6007b2a6d..e9c7b30c91 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1375,7 +1375,6 @@ static int img_compare(int argc, char **argv)
 
     for (;;) {
         int64_t status1, status2;
-        BlockDriverState *file;
 
         nb_sectors = sectors_to_process(total_sectors, sector_num);
         if (nb_sectors <= 0) {
@@ -1383,7 +1382,7 @@ static int img_compare(int argc, char **argv)
         }
         status1 = bdrv_get_block_status_above(bs1, NULL, sector_num,
                                               total_sectors1 - sector_num,
-                                              &pnum1, &file);
+                                              &pnum1, NULL);
         if (status1 < 0) {
             ret = 3;
             error_report("Sector allocation test failed for %s", filename1);
@@ -1393,7 +1392,7 @@ static int img_compare(int argc, char **argv)
 
         status2 = bdrv_get_block_status_above(bs2, NULL, sector_num,
                                               total_sectors2 - sector_num,
-                                              &pnum2, &file);
+                                              &pnum2, NULL);
         if (status2 < 0) {
             ret = 3;
             error_report("Sector allocation test failed for %s", filename2);
@@ -1599,15 +1598,14 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
     n = MIN(s->total_sectors - sector_num, BDRV_REQUEST_MAX_SECTORS);
 
     if (s->sector_next_status <= sector_num) {
-        BlockDriverState *file;
         if (s->target_has_backing) {
             ret = bdrv_get_block_status(blk_bs(s->src[src_cur]),
                                         sector_num - src_cur_offset,
-                                        n, &n, &file);
+                                        n, &n, NULL);
         } else {
             ret = bdrv_get_block_status_above(blk_bs(s->src[src_cur]), NULL,
                                               sector_num - src_cur_offset,
-                                              n, &n, &file);
+                                              n, &n, NULL);
         }
         if (ret < 0) {
             return ret;
-- 
2.13.6
