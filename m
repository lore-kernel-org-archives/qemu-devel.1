Received: from eggs.gnu.org ([2001:4830:134:3::10]:55831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS9cp-0007X2-QC
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 18:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS9cn-0004Ts-Rl
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 18:15:23 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon,  3 Jul 2017 17:14:43 -0500
Message-Id: <20170703221456.30817-3-eblake@redhat.com>
In-Reply-To: <20170703221456.30817-1-eblake@redhat.com>
References: <20170703221456.30817-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 02/15] block: Allow NULL file for
 bdrv_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>

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

---
v2: use local variable and final transfer, rather than assignment
of parameter to local
[previously in different series]:
v2: new patch, https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg05645.html
---
 include/block/block_int.h | 10 ++++++----
 block/io.c                | 44 ++++++++++++++++++++++++++++----------------
 block/mirror.c            |  3 +--
 block/qcow2.c             |  4 +---
 qemu-img.c                | 10 ++++------
 5 files changed, 40 insertions(+), 31 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 724799c..ffa22c7 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -168,10 +168,12 @@ struct BlockDriver {
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
index 8c67ba8..6358d07 100644
--- a/block/io.c
+++ b/block/io.c
@@ -671,7 +671,6 @@ int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
 {
     int64_t target_sectors, ret, nb_sectors, sector_num = 0;
     BlockDriverState *bs = child->bs;
-    BlockDriverState *file;
     int n;

     target_sectors = bdrv_nb_sectors(bs);
@@ -684,7 +683,7 @@ int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
         if (nb_sectors <= 0) {
             return 0;
         }
-        ret = bdrv_get_block_status(bs, sector_num, nb_sectors, &n, &file);
+        ret = bdrv_get_block_status(bs, sector_num, nb_sectors, &n, NULL);
         if (ret < 0) {
             error_report("error getting block status at sector %" PRId64 ": %s",
                          sector_num, strerror(-ret));
@@ -1729,8 +1728,9 @@ int64_t coroutine_fn bdrv_co_get_block_status_from_backing(BlockDriverState *bs,
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
@@ -1740,15 +1740,22 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
     int64_t total_sectors;
     int64_t n;
     int64_t ret, ret2;
+    BlockDriverState *local_file = NULL;

-    *file = NULL;
+    assert(pnum);
     total_sectors = bdrv_nb_sectors(bs);
     if (total_sectors < 0) {
+        if (file) {
+            *file = NULL;
+        }
         return total_sectors;
     }

     if (sector_num >= total_sectors) {
         *pnum = 0;
+        if (file) {
+            *file = NULL;
+        }
         return BDRV_BLOCK_EOF;
     }

@@ -1765,23 +1772,27 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
         }
         if (bs->drv->protocol_name) {
             ret |= BDRV_BLOCK_OFFSET_VALID | (sector_num * BDRV_SECTOR_SIZE);
-            *file = bs;
+            if (file) {
+                *file = bs;
+            }
+        } else if (file) {
+            *file = NULL;
         }
         return ret;
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

@@ -1799,14 +1810,13 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
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
@@ -1828,6 +1838,9 @@ static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState *bs,
     }

 out:
+    if (file) {
+        *file = local_file;
+    }
     bdrv_dec_in_flight(bs);
     if (ret >= 0 && sector_num + *pnum == total_sectors) {
         ret |= BDRV_BLOCK_EOF;
@@ -1931,7 +1944,6 @@ int64_t bdrv_get_block_status(BlockDriverState *bs,
 int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
                                    int64_t bytes, int64_t *pnum)
 {
-    BlockDriverState *file;
     int64_t sector_num = offset >> BDRV_SECTOR_BITS;
     int nb_sectors = bytes >> BDRV_SECTOR_BITS;
     int64_t ret;
@@ -1941,7 +1953,7 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
     assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE) &&
            bytes < INT_MAX * BDRV_SECTOR_SIZE);
     ret = bdrv_get_block_status(bs, sector_num, nb_sectors, &psectors,
-                                &file);
+                                NULL);
     if (ret < 0) {
         return ret;
     }
diff --git a/block/mirror.c b/block/mirror.c
index 4e883bc..21758a8 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -391,7 +391,6 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
         int io_sectors;
         unsigned int io_bytes;
         int64_t io_bytes_acct;
-        BlockDriverState *file;
         enum MirrorMethod {
             MIRROR_METHOD_COPY,
             MIRROR_METHOD_ZERO,
@@ -402,7 +401,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
         ret = bdrv_get_block_status_above(source, NULL,
                                           offset >> BDRV_SECTOR_BITS,
                                           nb_chunks * sectors_per_chunk,
-                                          &io_sectors, &file);
+                                          &io_sectors, NULL);
         io_bytes = io_sectors * BDRV_SECTOR_SIZE;
         if (ret < 0) {
             io_bytes = MIN(nb_chunks * s->granularity, max_io_bytes);
diff --git a/block/qcow2.c b/block/qcow2.c
index 9d3c70e..d75f248 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2909,7 +2909,6 @@ static bool is_zero_sectors(BlockDriverState *bs, int64_t start,
                             uint32_t count)
 {
     int nr;
-    BlockDriverState *file;
     int64_t res;

     if (start + count > bs->total_sectors) {
@@ -2919,8 +2918,7 @@ static bool is_zero_sectors(BlockDriverState *bs, int64_t start,
     if (!count) {
         return true;
     }
-    res = bdrv_get_block_status_above(bs, NULL, start, count,
-                                      &nr, &file);
+    res = bdrv_get_block_status_above(bs, NULL, start, count, &nr, NULL);
     return res >= 0 && (res & BDRV_BLOCK_ZERO) && nr == count;
 }

diff --git a/qemu-img.c b/qemu-img.c
index 8def1e8..daba954 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1373,7 +1373,6 @@ static int img_compare(int argc, char **argv)

     for (;;) {
         int64_t status1, status2;
-        BlockDriverState *file;

         nb_sectors = sectors_to_process(total_sectors, sector_num);
         if (nb_sectors <= 0) {
@@ -1381,7 +1380,7 @@ static int img_compare(int argc, char **argv)
         }
         status1 = bdrv_get_block_status_above(bs1, NULL, sector_num,
                                               total_sectors1 - sector_num,
-                                              &pnum1, &file);
+                                              &pnum1, NULL);
         if (status1 < 0) {
             ret = 3;
             error_report("Sector allocation test failed for %s", filename1);
@@ -1391,7 +1390,7 @@ static int img_compare(int argc, char **argv)

         status2 = bdrv_get_block_status_above(bs2, NULL, sector_num,
                                               total_sectors2 - sector_num,
-                                              &pnum2, &file);
+                                              &pnum2, NULL);
         if (status2 < 0) {
             ret = 3;
             error_report("Sector allocation test failed for %s", filename2);
@@ -1594,15 +1593,14 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
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
2.9.4
