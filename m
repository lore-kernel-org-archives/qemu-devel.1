Received: from eggs.gnu.org ([2001:4830:134:3::10]:42657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPw7H-0006Ga-D2
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 15:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPw7G-0006sL-4M
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 15:25:39 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 27 Jun 2017 14:24:52 -0500
Message-Id: <20170627192458.15519-15-eblake@redhat.com>
In-Reply-To: <20170627192458.15519-1-eblake@redhat.com>
References: <20170627192458.15519-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 14/20] backup: Switch BackupBlockJob to
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, jsnow@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>

We are gradually converting to byte-based interfaces, as they are
easier to reason about than sector-based.  Continue by converting an
internal structure (no semantic change), and all references to
tracking progress.  Drop a redundant local variable bytes_per_cluster.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>

---
v2: no change
---
 block/backup.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 06431ac..4e64710 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -39,7 +39,7 @@ typedef struct BackupBlockJob {
     BlockdevOnError on_source_error;
     BlockdevOnError on_target_error;
     CoRwlock flush_rwlock;
-    uint64_t sectors_read;
+    uint64_t bytes_read;
     unsigned long *done_bitmap;
     int64_t cluster_size;
     bool compress;
@@ -102,16 +102,15 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
     void *bounce_buffer = NULL;
     int ret = 0;
     int64_t sectors_per_cluster = cluster_size_sectors(job);
-    int64_t bytes_per_cluster = sectors_per_cluster * BDRV_SECTOR_SIZE;
-    int64_t start, end;
-    int n;
+    int64_t start, end; /* clusters */
+    int n; /* bytes */

     qemu_co_rwlock_rdlock(&job->flush_rwlock);

     start = sector_num / sectors_per_cluster;
     end = DIV_ROUND_UP(sector_num + nb_sectors, sectors_per_cluster);

-    trace_backup_do_cow_enter(job, start * bytes_per_cluster,
+    trace_backup_do_cow_enter(job, start * job->cluster_size,
                               sector_num * BDRV_SECTOR_SIZE,
                               nb_sectors * BDRV_SECTOR_SIZE);

@@ -120,28 +119,27 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,

     for (; start < end; start++) {
         if (test_bit(start, job->done_bitmap)) {
-            trace_backup_do_cow_skip(job, start * bytes_per_cluster);
+            trace_backup_do_cow_skip(job, start * job->cluster_size);
             continue; /* already copied */
         }

-        trace_backup_do_cow_process(job, start * bytes_per_cluster);
+        trace_backup_do_cow_process(job, start * job->cluster_size);

-        n = MIN(sectors_per_cluster,
-                job->common.len / BDRV_SECTOR_SIZE -
-                start * sectors_per_cluster);
+        n = MIN(job->cluster_size,
+                job->common.len - start * job->cluster_size);

         if (!bounce_buffer) {
             bounce_buffer = blk_blockalign(blk, job->cluster_size);
         }
         iov.iov_base = bounce_buffer;
-        iov.iov_len = n * BDRV_SECTOR_SIZE;
+        iov.iov_len = n;
         qemu_iovec_init_external(&bounce_qiov, &iov, 1);

         ret = blk_co_preadv(blk, start * job->cluster_size,
                             bounce_qiov.size, &bounce_qiov,
                             is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0);
         if (ret < 0) {
-            trace_backup_do_cow_read_fail(job, start * bytes_per_cluster, ret);
+            trace_backup_do_cow_read_fail(job, start * job->cluster_size, ret);
             if (error_is_read) {
                 *error_is_read = true;
             }
@@ -157,7 +155,7 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
                                  job->compress ? BDRV_REQ_WRITE_COMPRESSED : 0);
         }
         if (ret < 0) {
-            trace_backup_do_cow_write_fail(job, start * bytes_per_cluster, ret);
+            trace_backup_do_cow_write_fail(job, start * job->cluster_size, ret);
             if (error_is_read) {
                 *error_is_read = false;
             }
@@ -169,8 +167,8 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
         /* Publish progress, guest I/O counts as progress too.  Note that the
          * offset field is an opaque progress value, it is not a disk offset.
          */
-        job->sectors_read += n;
-        job->common.offset += n * BDRV_SECTOR_SIZE;
+        job->bytes_read += n;
+        job->common.offset += n;
     }

 out:
@@ -363,9 +361,8 @@ static bool coroutine_fn yield_and_check(BackupBlockJob *job)
      */
     if (job->common.speed) {
         uint64_t delay_ns = ratelimit_calculate_delay(&job->limit,
-                                                      job->sectors_read *
-                                                      BDRV_SECTOR_SIZE);
-        job->sectors_read = 0;
+                                                      job->bytes_read);
+        job->bytes_read = 0;
         block_job_sleep_ns(&job->common, QEMU_CLOCK_REALTIME, delay_ns);
     } else {
         block_job_sleep_ns(&job->common, QEMU_CLOCK_REALTIME, 0);
-- 
2.9.4
