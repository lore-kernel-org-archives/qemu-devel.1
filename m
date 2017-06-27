Received: from eggs.gnu.org ([2001:4830:134:3::10]:42806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPw7Y-0006XA-1x
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 15:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPw7U-0006y1-L7
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 15:25:56 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 27 Jun 2017 14:24:56 -0500
Message-Id: <20170627192458.15519-19-eblake@redhat.com>
In-Reply-To: <20170627192458.15519-1-eblake@redhat.com>
References: <20170627192458.15519-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 18/20] block: Make bdrv_is_allocated()
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, jsnow@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

We are gradually moving away from sector-based interfaces, towards
byte-based.  In the common case, allocation is unlikely to ever use
values that are not naturally sector-aligned, but it is possible
that byte-based values will let us be more precise about allocation
at the end of an unaligned file that can do byte-based access.

Changing the signature of the function to use int64_t *pnum ensures
that the compiler enforces that all callers are updated.  For now,
the io.c layer still assert()s that all callers are sector-aligned
on input and that *pnum is sector-aligned on return to the caller,
but that can be relaxed when a later patch implements byte-based
block status.  Therefore, this code adds usages like
DIV_ROUND_UP(,BDRV_SECTOR_SIZE) to callers that still want aligned
values, where the call might reasonbly give non-aligned results
in the future; on the other hand, no rounding is needed for callers
that should just continue to work with byte alignment.

For the most part this patch is just the addition of scaling at the
callers followed by inverse scaling at bdrv_is_allocated().  But
some code, particularly bdrv_commit(), gets a lot simpler because it
no longer has to mess with sectors; also, it is now possible to pass
NULL if the caller does not care how much of the image is allocated
beyond the initial offset.

For ease of review, bdrv_is_allocated_above() will be tackled
separately.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>

---
v2: rebase to earlier changes, tweak commit message
---
 include/block/block.h |  4 +--
 block/backup.c        | 17 ++++---------
 block/commit.c        | 21 +++++++---------
 block/io.c            | 49 +++++++++++++++++++++++++-----------
 block/stream.c        |  5 ++--
 block/vvfat.c         | 34 ++++++++++++++-----------
 migration/block.c     |  9 ++++---
 qemu-img.c            |  5 +++-
 qemu-io-cmds.c        | 70 +++++++++++++++++++++++----------------------------
 9 files changed, 114 insertions(+), 100 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 5cdd690..9b9d87b 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -425,8 +425,8 @@ int64_t bdrv_get_block_status_above(BlockDriverState *bs,
                                     int64_t sector_num,
                                     int nb_sectors, int *pnum,
                                     BlockDriverState **file);
-int bdrv_is_allocated(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
-                      int *pnum);
+int bdrv_is_allocated(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                      int64_t *pnum);
 int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
                             int64_t sector_num, int nb_sectors, int *pnum);

diff --git a/block/backup.c b/block/backup.c
index 04def91..b2048bf 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -47,12 +47,6 @@ typedef struct BackupBlockJob {
     QLIST_HEAD(, CowRequest) inflight_reqs;
 } BackupBlockJob;

-/* Size of a cluster in sectors, instead of bytes. */
-static inline int64_t cluster_size_sectors(BackupBlockJob *job)
-{
-  return job->cluster_size / BDRV_SECTOR_SIZE;
-}
-
 /* See if in-flight requests overlap and wait for them to complete */
 static void coroutine_fn wait_for_overlapping_requests(BackupBlockJob *job,
                                                        int64_t offset,
@@ -433,7 +427,6 @@ static void coroutine_fn backup_run(void *opaque)
     BackupCompleteData *data;
     BlockDriverState *bs = blk_bs(job->common.blk);
     int64_t offset;
-    int64_t sectors_per_cluster = cluster_size_sectors(job);
     int ret = 0;

     QLIST_INIT(&job->inflight_reqs);
@@ -465,12 +458,13 @@ static void coroutine_fn backup_run(void *opaque)
             }

             if (job->sync_mode == MIRROR_SYNC_MODE_TOP) {
-                int i, n;
+                int i;
+                int64_t n;

                 /* Check to see if these blocks are already in the
                  * backing file. */

-                for (i = 0; i < sectors_per_cluster;) {
+                for (i = 0; i < job->cluster_size;) {
                     /* bdrv_is_allocated() only returns true/false based
                      * on the first set of sectors it comes across that
                      * are are all in the same state.
@@ -478,9 +472,8 @@ static void coroutine_fn backup_run(void *opaque)
                      * backup cluster length.  We end up copying more than
                      * needed but at some point that is always the case. */
                     alloced =
-                        bdrv_is_allocated(bs,
-                                          (offset >> BDRV_SECTOR_BITS) + i,
-                                          sectors_per_cluster - i, &n);
+                        bdrv_is_allocated(bs, offset + i,
+                                          job->cluster_size - i, &n);
                     i += n;

                     if (alloced || n == 0) {
diff --git a/block/commit.c b/block/commit.c
index c3a7bca..241aa95 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -443,7 +443,7 @@ fail:
 }


-#define COMMIT_BUF_SECTORS 2048
+#define COMMIT_BUF_SIZE (2048 * BDRV_SECTOR_SIZE)

 /* commit COW file into the raw image */
 int bdrv_commit(BlockDriverState *bs)
@@ -452,8 +452,9 @@ int bdrv_commit(BlockDriverState *bs)
     BlockDriverState *backing_file_bs = NULL;
     BlockDriverState *commit_top_bs = NULL;
     BlockDriver *drv = bs->drv;
-    int64_t sector, total_sectors, length, backing_length;
-    int n, ro, open_flags;
+    int64_t offset, length, backing_length;
+    int ro, open_flags;
+    int64_t n;
     int ret = 0;
     uint8_t *buf = NULL;
     Error *local_err = NULL;
@@ -531,30 +532,26 @@ int bdrv_commit(BlockDriverState *bs)
         }
     }

-    total_sectors = length >> BDRV_SECTOR_BITS;
-
     /* blk_try_blockalign() for src will choose an alignment that works for
      * backing as well, so no need to compare the alignment manually. */
-    buf = blk_try_blockalign(src, COMMIT_BUF_SECTORS * BDRV_SECTOR_SIZE);
+    buf = blk_try_blockalign(src, COMMIT_BUF_SIZE);
     if (buf == NULL) {
         ret = -ENOMEM;
         goto ro_cleanup;
     }

-    for (sector = 0; sector < total_sectors; sector += n) {
-        ret = bdrv_is_allocated(bs, sector, COMMIT_BUF_SECTORS, &n);
+    for (offset = 0; offset < length; offset += n) {
+        ret = bdrv_is_allocated(bs, offset, COMMIT_BUF_SIZE, &n);
         if (ret < 0) {
             goto ro_cleanup;
         }
         if (ret) {
-            ret = blk_pread(src, sector * BDRV_SECTOR_SIZE, buf,
-                            n * BDRV_SECTOR_SIZE);
+            ret = blk_pread(src, offset, buf, n);
             if (ret < 0) {
                 goto ro_cleanup;
             }

-            ret = blk_pwrite(backing, sector * BDRV_SECTOR_SIZE, buf,
-                             n * BDRV_SECTOR_SIZE, 0);
+            ret = blk_pwrite(backing, offset, buf, n, 0);
             if (ret < 0) {
                 goto ro_cleanup;
             }
diff --git a/block/io.c b/block/io.c
index d9fec1f..0545180 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1036,14 +1036,15 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
         int64_t start_sector = offset >> BDRV_SECTOR_BITS;
         int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
         unsigned int nb_sectors = end_sector - start_sector;
-        int pnum;
+        int64_t pnum;

-        ret = bdrv_is_allocated(bs, start_sector, nb_sectors, &pnum);
+        ret = bdrv_is_allocated(bs, start_sector << BDRV_SECTOR_BITS,
+                                nb_sectors << BDRV_SECTOR_BITS, &pnum);
         if (ret < 0) {
             goto out;
         }

-        if (!ret || pnum != nb_sectors) {
+        if (!ret || pnum != nb_sectors << BDRV_SECTOR_BITS) {
             ret = bdrv_co_do_copy_on_readv(child, offset, bytes, qiov);
             goto out;
         }
@@ -1876,15 +1877,26 @@ int64_t bdrv_get_block_status(BlockDriverState *bs,
                                        sector_num, nb_sectors, pnum, file);
 }

-int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t sector_num,
-                                   int nb_sectors, int *pnum)
+int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
+                                   int64_t bytes, int64_t *pnum)
 {
     BlockDriverState *file;
-    int64_t ret = bdrv_get_block_status(bs, sector_num, nb_sectors, pnum,
-                                        &file);
+    int64_t sector_num = offset >> BDRV_SECTOR_BITS;
+    int nb_sectors = bytes >> BDRV_SECTOR_BITS;
+    int64_t ret;
+    int psectors;
+
+    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
+    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE) &&
+           bytes < INT_MAX * BDRV_SECTOR_SIZE);
+    ret = bdrv_get_block_status(bs, sector_num, nb_sectors, &psectors,
+                                &file);
     if (ret < 0) {
         return ret;
     }
+    if (pnum) {
+        *pnum = psectors * BDRV_SECTOR_SIZE;
+    }
     return !!(ret & BDRV_BLOCK_ALLOCATED);
 }

@@ -1893,7 +1905,8 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t sector_num,
  *
  * Return true if the given sector is allocated in any image between
  * BASE and TOP (inclusive).  BASE can be NULL to check if the given
- * sector is allocated in any image of the chain.  Return false otherwise.
+ * sector is allocated in any image of the chain.  Return false otherwise,
+ * or negative errno on failure.
  *
  * 'pnum' is set to the number of sectors (including and immediately following
  *  the specified sector) that are known to be in the same
@@ -1910,13 +1923,19 @@ int bdrv_is_allocated_above(BlockDriverState *top,

     intermediate = top;
     while (intermediate && intermediate != base) {
-        int pnum_inter;
-        ret = bdrv_is_allocated(intermediate, sector_num, nb_sectors,
+        int64_t pnum_inter;
+        int psectors_inter;
+
+        ret = bdrv_is_allocated(intermediate, sector_num * BDRV_SECTOR_SIZE,
+                                nb_sectors * BDRV_SECTOR_SIZE,
                                 &pnum_inter);
         if (ret < 0) {
             return ret;
-        } else if (ret) {
-            *pnum = pnum_inter;
+        }
+        assert(pnum_inter < INT_MAX * BDRV_SECTOR_SIZE);
+        psectors_inter = pnum_inter >> BDRV_SECTOR_BITS;
+        if (ret) {
+            *pnum = psectors_inter;
             return 1;
         }

@@ -1926,10 +1945,10 @@ int bdrv_is_allocated_above(BlockDriverState *top,
          *
          * [sector_num+x, nr_sectors] allocated.
          */
-        if (n > pnum_inter &&
+        if (n > psectors_inter &&
             (intermediate == top ||
-             sector_num + pnum_inter < intermediate->total_sectors)) {
-            n = pnum_inter;
+             sector_num + psectors_inter < intermediate->total_sectors)) {
+            n = psectors_inter;
         }

         intermediate = backing_bs(intermediate);
diff --git a/block/stream.c b/block/stream.c
index 2f9618b..0a56c29 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -138,6 +138,7 @@ static void coroutine_fn stream_run(void *opaque)

     for ( ; offset < s->common.len; offset += n * BDRV_SECTOR_SIZE) {
         bool copy;
+        int64_t count = 0;

         /* Note that even when no rate limit is applied we need to yield
          * with no pending I/O here so that bdrv_drain_all() returns.
@@ -149,8 +150,8 @@ static void coroutine_fn stream_run(void *opaque)

         copy = false;

-        ret = bdrv_is_allocated(bs, offset / BDRV_SECTOR_SIZE,
-                                STREAM_BUFFER_SIZE / BDRV_SECTOR_SIZE, &n);
+        ret = bdrv_is_allocated(bs, offset, STREAM_BUFFER_SIZE, &count);
+        n = DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);
         if (ret == 1) {
             /* Allocated in the top, no need to copy.  */
         } else if (ret >= 0) {
diff --git a/block/vvfat.c b/block/vvfat.c
index 8ab647c..6f9b9cb 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1403,24 +1403,27 @@ static int vvfat_read(BlockDriverState *bs, int64_t sector_num,
 	if (sector_num >= bs->total_sectors)
 	   return -1;
 	if (s->qcow) {
-	    int n;
+            int64_t n;
             int ret;
-            ret = bdrv_is_allocated(s->qcow->bs, sector_num,
-                                    nb_sectors - i, &n);
+            ret = bdrv_is_allocated(s->qcow->bs, sector_num * BDRV_SECTOR_SIZE,
+                                    (nb_sectors - i) * BDRV_SECTOR_SIZE, &n);
             if (ret < 0) {
                 return ret;
             }
             if (ret) {
-                DLOG(fprintf(stderr, "sectors %d+%d allocated\n",
-                             (int)sector_num, n));
-                if (bdrv_read(s->qcow, sector_num, buf + i * 0x200, n)) {
+                DLOG(fprintf(stderr, "sectors %" PRId64 "+%" PRId64
+                             " allocated\n", sector_num,
+                             n >> BDRV_SECTOR_BITS));
+                if (bdrv_read(s->qcow, sector_num, buf + i * 0x200,
+                              n >> BDRV_SECTOR_BITS)) {
                     return -1;
                 }
-                i += n - 1;
-                sector_num += n - 1;
+                i += (n >> BDRV_SECTOR_BITS) - 1;
+                sector_num += (n >> BDRV_SECTOR_BITS) - 1;
                 continue;
             }
-DLOG(fprintf(stderr, "sector %d not allocated\n", (int)sector_num));
+            DLOG(fprintf(stderr, "sector %" PRId64 " not allocated\n",
+                         sector_num));
 	}
 	if(sector_num<s->faked_sectors) {
 	    if(sector_num<s->first_sectors_number)
@@ -1688,7 +1691,7 @@ static inline bool cluster_was_modified(BDRVVVFATState *s,
                                         uint32_t cluster_num)
 {
     int was_modified = 0;
-    int i, dummy;
+    int i;

     if (s->qcow == NULL) {
         return 0;
@@ -1696,8 +1699,9 @@ static inline bool cluster_was_modified(BDRVVVFATState *s,

     for (i = 0; !was_modified && i < s->sectors_per_cluster; i++) {
         was_modified = bdrv_is_allocated(s->qcow->bs,
-                                         cluster2sector(s, cluster_num) + i,
-                                         1, &dummy);
+                                         (cluster2sector(s, cluster_num) +
+                                          i) * BDRV_SECTOR_SIZE,
+                                         BDRV_SECTOR_SIZE, NULL);
     }

     /*
@@ -1844,7 +1848,7 @@ static uint32_t get_cluster_count_for_direntry(BDRVVVFATState* s,
 	    }

 	    if (copy_it) {
-		int i, dummy;
+                int i;
 		/*
 		 * This is horribly inefficient, but that is okay, since
 		 * it is rarely executed, if at all.
@@ -1855,7 +1859,9 @@ static uint32_t get_cluster_count_for_direntry(BDRVVVFATState* s,
                 for (i = 0; i < s->sectors_per_cluster; i++) {
                     int res;

-                    res = bdrv_is_allocated(s->qcow->bs, offset + i, 1, &dummy);
+                    res = bdrv_is_allocated(s->qcow->bs,
+                                            (offset + i) * BDRV_SECTOR_SIZE,
+                                            BDRV_SECTOR_SIZE, NULL);
                     if (res < 0) {
                         return -1;
                     }
diff --git a/migration/block.c b/migration/block.c
index 7674ae1..4a48e5c 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -34,7 +34,7 @@
 #define BLK_MIG_FLAG_PROGRESS           0x04
 #define BLK_MIG_FLAG_ZERO_BLOCK         0x08

-#define MAX_IS_ALLOCATED_SEARCH 65536
+#define MAX_IS_ALLOCATED_SEARCH (65536 * BDRV_SECTOR_SIZE)

 #define MAX_INFLIGHT_IO 512

@@ -267,6 +267,7 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
     BlockBackend *bb = bmds->blk;
     BlkMigBlock *blk;
     int nr_sectors;
+    int64_t count;

     if (bmds->shared_base) {
         qemu_mutex_lock_iothread();
@@ -274,9 +275,9 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
         /* Skip unallocated sectors; intentionally treats failure as
          * an allocated sector */
         while (cur_sector < total_sectors &&
-               !bdrv_is_allocated(blk_bs(bb), cur_sector,
-                                  MAX_IS_ALLOCATED_SEARCH, &nr_sectors)) {
-            cur_sector += nr_sectors;
+               !bdrv_is_allocated(blk_bs(bb), cur_sector * BDRV_SECTOR_SIZE,
+                                  MAX_IS_ALLOCATED_SEARCH, &count)) {
+            cur_sector += DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);
         }
         aio_context_release(blk_get_aio_context(bb));
         qemu_mutex_unlock_iothread();
diff --git a/qemu-img.c b/qemu-img.c
index 91ad6be..c5709bf 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3274,6 +3274,7 @@ static int img_rebase(int argc, char **argv)
         int64_t new_backing_num_sectors = 0;
         uint64_t sector;
         int n;
+        int64_t count;
         float local_progress = 0;

         buf_old = blk_blockalign(blk, IO_BUF_SIZE);
@@ -3321,12 +3322,14 @@ static int img_rebase(int argc, char **argv)
             }

             /* If the cluster is allocated, we don't need to take action */
-            ret = bdrv_is_allocated(bs, sector, n, &n);
+            ret = bdrv_is_allocated(bs, sector << BDRV_SECTOR_BITS,
+                                    n << BDRV_SECTOR_BITS, &count);
             if (ret < 0) {
                 error_report("error while reading image metadata: %s",
                              strerror(-ret));
                 goto out;
             }
+            n = DIV_ROUND_UP(count, BDRV_SECTOR_SIZE);
             if (ret) {
                 continue;
             }
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index b0ea327..e529b8f 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -1760,12 +1760,12 @@ out:
 static int alloc_f(BlockBackend *blk, int argc, char **argv)
 {
     BlockDriverState *bs = blk_bs(blk);
-    int64_t offset, sector_num, nb_sectors, remaining, count;
+    int64_t offset, start, remaining, count;
     char s1[64];
-    int num, ret;
-    int64_t sum_alloc;
+    int ret;
+    int64_t num, sum_alloc;

-    offset = cvtnum(argv[1]);
+    start = offset = cvtnum(argv[1]);
     if (offset < 0) {
         print_cvtnum_err(offset, argv[1]);
         return 0;
@@ -1793,32 +1793,30 @@ static int alloc_f(BlockBackend *blk, int argc, char **argv)
                count);
         return 0;
     }
-    nb_sectors = count >> BDRV_SECTOR_BITS;

-    remaining = nb_sectors;
+    remaining = count;
     sum_alloc = 0;
-    sector_num = offset >> 9;
     while (remaining) {
-        ret = bdrv_is_allocated(bs, sector_num, remaining, &num);
+        ret = bdrv_is_allocated(bs, offset, remaining, &num);
         if (ret < 0) {
             printf("is_allocated failed: %s\n", strerror(-ret));
             return 0;
         }
-        sector_num += num;
+        offset += num;
         remaining -= num;
         if (ret) {
             sum_alloc += num;
         }
         if (num == 0) {
-            nb_sectors -= remaining;
+            count -= remaining;
             remaining = 0;
         }
     }

-    cvtstr(offset, s1, sizeof(s1));
+    cvtstr(start, s1, sizeof(s1));

     printf("%"PRId64"/%"PRId64" bytes allocated at offset %s\n",
-           sum_alloc << BDRV_SECTOR_BITS, nb_sectors << BDRV_SECTOR_BITS, s1);
+           sum_alloc, count, s1);
     return 0;
 }

@@ -1833,14 +1831,15 @@ static const cmdinfo_t alloc_cmd = {
 };


-static int map_is_allocated(BlockDriverState *bs, int64_t sector_num,
-                            int64_t nb_sectors, int64_t *pnum)
+static int map_is_allocated(BlockDriverState *bs, int64_t offset,
+                            int64_t bytes, int64_t *pnum)
 {
-    int num, num_checked;
+    int64_t num;
+    int num_checked;
     int ret, firstret;

-    num_checked = MIN(nb_sectors, INT_MAX);
-    ret = bdrv_is_allocated(bs, sector_num, num_checked, &num);
+    num_checked = MIN(bytes, BDRV_REQUEST_MAX_BYTES);
+    ret = bdrv_is_allocated(bs, offset, num_checked, &num);
     if (ret < 0) {
         return ret;
     }
@@ -1848,12 +1847,12 @@ static int map_is_allocated(BlockDriverState *bs, int64_t sector_num,
     firstret = ret;
     *pnum = num;

-    while (nb_sectors > 0 && ret == firstret) {
-        sector_num += num;
-        nb_sectors -= num;
+    while (bytes > 0 && ret == firstret) {
+        offset += num;
+        bytes -= num;

-        num_checked = MIN(nb_sectors, INT_MAX);
-        ret = bdrv_is_allocated(bs, sector_num, num_checked, &num);
+        num_checked = MIN(bytes, BDRV_REQUEST_MAX_BYTES);
+        ret = bdrv_is_allocated(bs, offset, num_checked, &num);
         if (ret == firstret && num) {
             *pnum += num;
         } else {
@@ -1866,25 +1865,21 @@ static int map_is_allocated(BlockDriverState *bs, int64_t sector_num,

 static int map_f(BlockBackend *blk, int argc, char **argv)
 {
-    int64_t offset;
-    int64_t nb_sectors, total_sectors;
+    int64_t offset, bytes;
     char s1[64], s2[64];
     int64_t num;
     int ret;
     const char *retstr;

     offset = 0;
-    total_sectors = blk_nb_sectors(blk);
-    if (total_sectors < 0) {
-        error_report("Failed to query image length: %s",
-                     strerror(-total_sectors));
+    bytes = blk_getlength(blk);
+    if (bytes < 0) {
+        error_report("Failed to query image length: %s", strerror(-bytes));
         return 0;
     }

-    nb_sectors = total_sectors;
-
-    do {
-        ret = map_is_allocated(blk_bs(blk), offset, nb_sectors, &num);
+    while (bytes) {
+        ret = map_is_allocated(blk_bs(blk), offset, bytes, &num);
         if (ret < 0) {
             error_report("Failed to get allocation status: %s", strerror(-ret));
             return 0;
@@ -1894,15 +1889,14 @@ static int map_f(BlockBackend *blk, int argc, char **argv)
         }

         retstr = ret ? "    allocated" : "not allocated";
-        cvtstr(num << BDRV_SECTOR_BITS, s1, sizeof(s1));
-        cvtstr(offset << BDRV_SECTOR_BITS, s2, sizeof(s2));
+        cvtstr(num, s1, sizeof(s1));
+        cvtstr(offset, s2, sizeof(s2));
         printf("%s (0x%" PRIx64 ") bytes %s at offset %s (0x%" PRIx64 ")\n",
-               s1, num << BDRV_SECTOR_BITS, retstr,
-               s2, offset << BDRV_SECTOR_BITS);
+               s1, num, retstr, s2, offset);

         offset += num;
-        nb_sectors -= num;
-    } while (offset < total_sectors);
+        bytes -= num;
+    };

     return 0;
 }
-- 
2.9.4
