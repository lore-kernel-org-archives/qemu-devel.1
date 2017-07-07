Received: from eggs.gnu.org ([2001:4830:134:3::10]:45793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTSeA-0001Jp-ON
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:46:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTSe7-0000wI-I6
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:46:10 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri,  7 Jul 2017 07:44:59 -0500
Message-Id: <20170707124459.10269-22-eblake@redhat.com>
In-Reply-To: <20170707124459.10269-1-eblake@redhat.com>
References: <20170707124459.10269-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 21/21] block: Make bdrv_is_allocated_above()
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  In the common case, allocation is unlikely to ever use
values that are not naturally sector-aligned, but it is possible
that byte-based values will let us be more precise about allocation
at the end of an unaligned file that can do byte-based access.

Changing the signature of the function to use int64_t *pnum ensures
that the compiler enforces that all callers are updated.  For now,
the io.c layer still assert()s that all callers are sector-aligned,
but that can be relaxed when a later patch implements byte-based
block status.  Therefore, for the most part this patch is just the
addition of scaling at the callers followed by inverse scaling at
bdrv_is_allocated().  But some code, particularly stream_run(),
gets a lot simpler because it no longer has to mess with sectors.
Leave comments where we can further simplify by switching to
byte-based iterations, once later patches eliminate the need for
sector-aligned operations.

For ease of review, bdrv_is_allocated() was tackled separately.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v5: add assertions about rounding [Kevin], R-b dropped
v3-v4: no change
v2: tweak function comments, favor bdrv_getlength() over ->total_sectors
---
 include/block/block.h |  2 +-
 block/commit.c        | 20 ++++++++------------
 block/io.c            | 38 ++++++++++++++++++--------------------
 block/mirror.c        |  8 +++++++-
 block/replication.c   | 17 ++++++++++++-----
 block/stream.c        | 23 +++++++++--------------
 qemu-img.c            | 13 ++++++++++---
 7 files changed, 65 insertions(+), 56 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index d3e01fb..f0fdbe8 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -430,7 +430,7 @@ int64_t bdrv_get_block_status_above(BlockDriverState *bs,
 int bdrv_is_allocated(BlockDriverState *bs, int64_t offset, int64_t bytes,
                       int64_t *pnum);
 int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
-                            int64_t sector_num, int nb_sectors, int *pnum);
+                            int64_t offset, int64_t bytes, int64_t *pnum);

 bool bdrv_is_read_only(BlockDriverState *bs);
 bool bdrv_is_writable(BlockDriverState *bs);
diff --git a/block/commit.c b/block/commit.c
index 241aa95..774a8a5 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -146,7 +146,7 @@ static void coroutine_fn commit_run(void *opaque)
     int64_t offset;
     uint64_t delay_ns = 0;
     int ret = 0;
-    int n = 0; /* sectors */
+    int64_t n = 0; /* bytes */
     void *buf = NULL;
     int bytes_written = 0;
     int64_t base_len;
@@ -171,7 +171,7 @@ static void coroutine_fn commit_run(void *opaque)

     buf = blk_blockalign(s->top, COMMIT_BUFFER_SIZE);

-    for (offset = 0; offset < s->common.len; offset += n * BDRV_SECTOR_SIZE) {
+    for (offset = 0; offset < s->common.len; offset += n) {
         bool copy;

         /* Note that even when no rate limit is applied we need to yield
@@ -183,15 +183,12 @@ static void coroutine_fn commit_run(void *opaque)
         }
         /* Copy if allocated above the base */
         ret = bdrv_is_allocated_above(blk_bs(s->top), blk_bs(s->base),
-                                      offset / BDRV_SECTOR_SIZE,
-                                      COMMIT_BUFFER_SIZE / BDRV_SECTOR_SIZE,
-                                      &n);
+                                      offset, COMMIT_BUFFER_SIZE, &n);
         copy = (ret == 1);
-        trace_commit_one_iteration(s, offset, n * BDRV_SECTOR_SIZE, ret);
+        trace_commit_one_iteration(s, offset, n, ret);
         if (copy) {
-            ret = commit_populate(s->top, s->base, offset,
-                                  n * BDRV_SECTOR_SIZE, buf);
-            bytes_written += n * BDRV_SECTOR_SIZE;
+            ret = commit_populate(s->top, s->base, offset, n, buf);
+            bytes_written += n;
         }
         if (ret < 0) {
             BlockErrorAction action =
@@ -204,11 +201,10 @@ static void coroutine_fn commit_run(void *opaque)
             }
         }
         /* Publish progress */
-        s->common.offset += n * BDRV_SECTOR_SIZE;
+        s->common.offset += n;

         if (copy && s->common.speed) {
-            delay_ns = ratelimit_calculate_delay(&s->limit,
-                                                 n * BDRV_SECTOR_SIZE);
+            delay_ns = ratelimit_calculate_delay(&s->limit, n);
         }
     }

diff --git a/block/io.c b/block/io.c
index 77cdf6f..b413727 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1930,50 +1930,48 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
 /*
  * Given an image chain: ... -> [BASE] -> [INTER1] -> [INTER2] -> [TOP]
  *
- * Return true if the given sector is allocated in any image between
- * BASE and TOP (inclusive).  BASE can be NULL to check if the given
- * sector is allocated in any image of the chain.  Return false otherwise,
+ * Return true if (a prefix of) the given range is allocated in any image
+ * between BASE and TOP (inclusive).  BASE can be NULL to check if the given
+ * offset is allocated in any image of the chain.  Return false otherwise,
  * or negative errno on failure.
  *
- * 'pnum' is set to the number of sectors (including and immediately following
- *  the specified sector) that are known to be in the same
- *  allocated/unallocated state.
+ * 'pnum' is set to the number of bytes (including and immediately
+ * following the specified offset) that are known to be in the same
+ * allocated/unallocated state.  Note that a subsequent call starting
+ * at 'offset + *pnum' may return the same allocation status (in other
+ * words, the result is not necessarily the maximum possible range);
+ * but 'pnum' will only be 0 when end of file is reached.
  *
  */
 int bdrv_is_allocated_above(BlockDriverState *top,
                             BlockDriverState *base,
-                            int64_t sector_num,
-                            int nb_sectors, int *pnum)
+                            int64_t offset, int64_t bytes, int64_t *pnum)
 {
     BlockDriverState *intermediate;
-    int ret, n = nb_sectors;
+    int ret;
+    int64_t n = bytes;

     intermediate = top;
     while (intermediate && intermediate != base) {
         int64_t pnum_inter;
         int64_t size_inter;
-        int psectors_inter;

-        ret = bdrv_is_allocated(intermediate, sector_num * BDRV_SECTOR_SIZE,
-                                nb_sectors * BDRV_SECTOR_SIZE,
-                                &pnum_inter);
+        ret = bdrv_is_allocated(intermediate, offset, bytes, &pnum_inter);
         if (ret < 0) {
             return ret;
         }
-        assert(pnum_inter < INT_MAX * BDRV_SECTOR_SIZE);
-        psectors_inter = pnum_inter >> BDRV_SECTOR_BITS;
         if (ret) {
-            *pnum = psectors_inter;
+            *pnum = pnum_inter;
             return 1;
         }

-        size_inter = bdrv_nb_sectors(intermediate);
+        size_inter = bdrv_getlength(intermediate);
         if (size_inter < 0) {
             return size_inter;
         }
-        if (n > psectors_inter &&
-            (intermediate == top || sector_num + psectors_inter < size_inter)) {
-            n = psectors_inter;
+        if (n > pnum_inter &&
+            (intermediate == top || offset + pnum_inter < size_inter)) {
+            n = pnum_inter;
         }

         intermediate = backing_bs(intermediate);
diff --git a/block/mirror.c b/block/mirror.c
index b33f4bb..eaf0fe7 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -621,6 +621,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
     BlockDriverState *bs = s->source;
     BlockDriverState *target_bs = blk_bs(s->target);
     int ret, n;
+    int64_t count;

     end = s->bdev_length / BDRV_SECTOR_SIZE;

@@ -670,11 +671,16 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
             return 0;
         }

-        ret = bdrv_is_allocated_above(bs, base, sector_num, nb_sectors, &n);
+        ret = bdrv_is_allocated_above(bs, base, sector_num * BDRV_SECTOR_SIZE,
+                                      nb_sectors * BDRV_SECTOR_SIZE, &count);
         if (ret < 0) {
             return ret;
         }

+        /* TODO: Relax this once bdrv_is_allocated_above and dirty
+         * bitmaps no longer require sector alignment. */
+        assert(QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE));
+        n = count >> BDRV_SECTOR_BITS;
         assert(n > 0);
         if (ret == 1) {
             bdrv_set_dirty_bitmap(s->dirty_bitmap, sector_num, n);
diff --git a/block/replication.c b/block/replication.c
index 8f3aba7..bf4462c 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -264,7 +264,8 @@ static coroutine_fn int replication_co_writev(BlockDriverState *bs,
     BdrvChild *top = bs->file;
     BdrvChild *base = s->secondary_disk;
     BdrvChild *target;
-    int ret, n;
+    int ret;
+    int64_t n;

     ret = replication_get_io_status(s);
     if (ret < 0) {
@@ -283,14 +284,20 @@ static coroutine_fn int replication_co_writev(BlockDriverState *bs,
      */
     qemu_iovec_init(&hd_qiov, qiov->niov);
     while (remaining_sectors > 0) {
-        ret = bdrv_is_allocated_above(top->bs, base->bs, sector_num,
-                                      remaining_sectors, &n);
+        int64_t count;
+
+        ret = bdrv_is_allocated_above(top->bs, base->bs,
+                                      sector_num * BDRV_SECTOR_SIZE,
+                                      remaining_sectors * BDRV_SECTOR_SIZE,
+                                      &count);
         if (ret < 0) {
             goto out1;
         }

+        assert(QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE));
+        n = count >> BDRV_SECTOR_BITS;
         qemu_iovec_reset(&hd_qiov);
-        qemu_iovec_concat(&hd_qiov, qiov, bytes_done, n * BDRV_SECTOR_SIZE);
+        qemu_iovec_concat(&hd_qiov, qiov, bytes_done, count);

         target = ret ? top : base;
         ret = bdrv_co_writev(target, sector_num, n, &hd_qiov);
@@ -300,7 +307,7 @@ static coroutine_fn int replication_co_writev(BlockDriverState *bs,

         remaining_sectors -= n;
         sector_num += n;
-        bytes_done += n * BDRV_SECTOR_SIZE;
+        bytes_done += count;
     }

 out1:
diff --git a/block/stream.c b/block/stream.c
index df9679c..e6f7234 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -111,7 +111,7 @@ static void coroutine_fn stream_run(void *opaque)
     uint64_t delay_ns = 0;
     int error = 0;
     int ret = 0;
-    int n = 0; /* sectors */
+    int64_t n = 0; /* bytes */
     void *buf;

     if (!bs->backing) {
@@ -135,9 +135,8 @@ static void coroutine_fn stream_run(void *opaque)
         bdrv_enable_copy_on_read(bs);
     }

-    for ( ; offset < s->common.len; offset += n * BDRV_SECTOR_SIZE) {
+    for ( ; offset < s->common.len; offset += n) {
         bool copy;
-        int64_t count = 0;

         /* Note that even when no rate limit is applied we need to yield
          * with no pending I/O here so that bdrv_drain_all() returns.
@@ -149,28 +148,25 @@ static void coroutine_fn stream_run(void *opaque)

         copy = false;

-        ret = bdrv_is_allocated(bs, offset, STREAM_BUFFER_SIZE, &count);
-        /* TODO relax this once bdrv_is_allocated does not enforce sectors */
-        assert(QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE));
-        n = count >> BDRV_SECTOR_BITS;
+        ret = bdrv_is_allocated(bs, offset, STREAM_BUFFER_SIZE, &n);
         if (ret == 1) {
             /* Allocated in the top, no need to copy.  */
         } else if (ret >= 0) {
             /* Copy if allocated in the intermediate images.  Limit to the
              * known-unallocated area [offset, offset+n*BDRV_SECTOR_SIZE).  */
             ret = bdrv_is_allocated_above(backing_bs(bs), base,
-                                          offset / BDRV_SECTOR_SIZE, n, &n);
+                                          offset, n, &n);

             /* Finish early if end of backing file has been reached */
             if (ret == 0 && n == 0) {
-                n = (s->common.len - offset) / BDRV_SECTOR_SIZE;
+                n = s->common.len - offset;
             }

             copy = (ret == 1);
         }
-        trace_stream_one_iteration(s, offset, n * BDRV_SECTOR_SIZE, ret);
+        trace_stream_one_iteration(s, offset, n, ret);
         if (copy) {
-            ret = stream_populate(blk, offset, n * BDRV_SECTOR_SIZE, buf);
+            ret = stream_populate(blk, offset, n, buf);
         }
         if (ret < 0) {
             BlockErrorAction action =
@@ -189,10 +185,9 @@ static void coroutine_fn stream_run(void *opaque)
         ret = 0;

         /* Publish progress */
-        s->common.offset += n * BDRV_SECTOR_SIZE;
+        s->common.offset += n;
         if (copy && s->common.speed) {
-            delay_ns = ratelimit_calculate_delay(&s->limit,
-                                                 n * BDRV_SECTOR_SIZE);
+            delay_ns = ratelimit_calculate_delay(&s->limit, n);
         }
     }

diff --git a/qemu-img.c b/qemu-img.c
index 2f55f94..7f1de74 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1477,12 +1477,16 @@ static int img_compare(int argc, char **argv)
         }

         for (;;) {
+            int64_t count;
+
             nb_sectors = sectors_to_process(total_sectors_over, sector_num);
             if (nb_sectors <= 0) {
                 break;
             }
-            ret = bdrv_is_allocated_above(blk_bs(blk_over), NULL, sector_num,
-                                          nb_sectors, &pnum);
+            ret = bdrv_is_allocated_above(blk_bs(blk_over), NULL,
+                                          sector_num * BDRV_SECTOR_SIZE,
+                                          nb_sectors * BDRV_SECTOR_SIZE,
+                                          &count);
             if (ret < 0) {
                 ret = 3;
                 error_report("Sector allocation test failed for %s",
@@ -1490,7 +1494,10 @@ static int img_compare(int argc, char **argv)
                 goto out;

             }
-            nb_sectors = pnum;
+            /* TODO relax this once bdrv_is_allocated_above does not enforce
+             * sector alignment */
+            assert(QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE));
+            nb_sectors = count >> BDRV_SECTOR_BITS;
             if (ret) {
                 ret = check_empty_sectors(blk_over, sector_num, nb_sectors,
                                           filename_over, buf1, quiet);
-- 
2.9.4
