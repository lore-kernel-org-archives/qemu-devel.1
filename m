Received: from eggs.gnu.org ([2001:4830:134:3::10]:33277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKZnq-0000jM-Hk
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 19:03:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKZnp-0003mN-8J
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 19:03:10 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 23 Dec 2016 17:28:54 +0300
Message-ID: <1482503344-6424-12-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 11/21] backup: move r/w error handling code to
 r/w functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com, pbonzini@redhat.com, jcody@redhat.com

It simplifies code: we do not need error_is_read parameter and
retrying in backup_loop. Also, retrying for read and write are separate,
so we will not reread if write failed after successfull read.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 141 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 74 insertions(+), 67 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 5c31607..442e6da 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -95,18 +95,65 @@ static void cow_request_end(CowRequest *req)
     qemu_co_queue_restart_all(&req->wait_queue);
 }
 
+static BlockErrorAction backup_error_action(BackupBlockJob *job,
+                                            bool read, int error)
+{
+    if (read) {
+        return block_job_error_action(&job->common, job->on_source_error,
+                                      true, error);
+    } else {
+        return block_job_error_action(&job->common, job->on_target_error,
+                                      false, error);
+    }
+}
+
+static bool coroutine_fn yield_and_check(BackupBlockJob *job)
+{
+    if (block_job_is_cancelled(&job->common)) {
+        return true;
+    }
+
+    /* we need to yield so that bdrv_drain_all() returns.
+     * (without, VM does not reboot)
+     */
+    if (job->common.speed) {
+        uint64_t delay_ns = ratelimit_calculate_delay(&job->limit,
+                                                      job->sectors_read);
+        job->sectors_read = 0;
+        block_job_sleep_ns(&job->common, QEMU_CLOCK_REALTIME, delay_ns);
+    } else {
+        block_job_sleep_ns(&job->common, QEMU_CLOCK_REALTIME, 0);
+    }
+
+    if (block_job_is_cancelled(&job->common)) {
+        return true;
+    }
+
+    return false;
+}
+
 static int coroutine_fn backup_do_read(BackupBlockJob *job,
                                        int64_t offset, unsigned int bytes,
                                        QEMUIOVector *qiov,
                                        bool is_write_notifier)
 {
-    int ret = blk_co_preadv(job->common.blk, offset, bytes, qiov,
-                            is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0);
+    int ret;
+    BdrvRequestFlags flags = is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
+
+retry:
+    ret = blk_co_preadv(job->common.blk, offset, bytes, qiov, flags);
     if (ret < 0) {
         trace_backup_do_read_fail(job, offset, bytes, ret);
+
+        BlockErrorAction action = backup_error_action(job, true, -ret);
+        if (action != BLOCK_ERROR_ACTION_REPORT && !yield_and_check(job)) {
+            goto retry;
+        }
+
+        return ret;
     }
 
-    return ret;
+    return 0;
 }
 
 static int coroutine_fn backup_do_write(BackupBlockJob *job,
@@ -114,9 +161,13 @@ static int coroutine_fn backup_do_write(BackupBlockJob *job,
                                         QEMUIOVector *qiov)
 {
     int ret;
+    bool zeroes;
+
     assert(qiov->niov == 1);
+    zeroes = buffer_is_zero(qiov->iov->iov_base, qiov->iov->iov_len);
 
-    if (buffer_is_zero(qiov->iov->iov_base, qiov->iov->iov_len)) {
+retry:
+    if (zeroes) {
         ret = blk_co_pwrite_zeroes(job->target, offset, bytes,
                                    BDRV_REQ_MAY_UNMAP);
     } else {
@@ -125,14 +176,20 @@ static int coroutine_fn backup_do_write(BackupBlockJob *job,
     }
     if (ret < 0) {
         trace_backup_do_write_fail(job, offset, bytes, ret);
+
+        BlockErrorAction action = backup_error_action(job, false, -ret);
+        if (action != BLOCK_ERROR_ACTION_REPORT && !yield_and_check(job)) {
+            goto retry;
+        }
+
+        return ret;
     }
 
-    return ret;
+    return 0;
 }
 
 static int coroutine_fn backup_copy_cluster(BackupBlockJob *job,
                                             int64_t cluster,
-                                            bool *error_is_read,
                                             bool is_write_notifier,
                                             void *bounce_buffer)
 {
@@ -156,17 +213,11 @@ static int coroutine_fn backup_copy_cluster(BackupBlockJob *job,
     ret = backup_do_read(job, offset, bounce_qiov.size, &bounce_qiov,
                          is_write_notifier);
     if (ret < 0) {
-        if (error_is_read) {
-            *error_is_read = true;
-        }
         return ret;
     }
 
     ret = backup_do_write(job, offset, bounce_qiov.size, &bounce_qiov);
     if (ret < 0) {
-        if (error_is_read) {
-            *error_is_read = false;
-        }
         return ret;
     }
 
@@ -181,7 +232,6 @@ static int coroutine_fn backup_copy_cluster(BackupBlockJob *job,
 
 static int coroutine_fn backup_do_cow(BackupBlockJob *job,
                                       int64_t sector_num, int nb_sectors,
-                                      bool *error_is_read,
                                       bool is_write_notifier)
 {
     BlockBackend *blk = job->common.blk;
@@ -212,8 +262,7 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
             bounce_buffer = blk_blockalign(blk, job->cluster_size);
         }
 
-        ret = backup_copy_cluster(job, start, error_is_read, is_write_notifier,
-                                  bounce_buffer);
+        ret = backup_copy_cluster(job, start, is_write_notifier, bounce_buffer);
         if (ret < 0) {
             hbitmap_set(job->copy_bitmap, start, 1);
             goto out;
@@ -247,7 +296,7 @@ static int coroutine_fn backup_before_write_notify(
     assert((req->offset & (BDRV_SECTOR_SIZE - 1)) == 0);
     assert((req->bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
 
-    return backup_do_cow(job, sector_num, nb_sectors, NULL, true);
+    return backup_do_cow(job, sector_num, nb_sectors, true);
 }
 
 static void backup_set_speed(BlockJob *job, int64_t speed, Error **errp)
@@ -374,18 +423,6 @@ static void backup_drain(BlockJob *job)
     }
 }
 
-static BlockErrorAction backup_error_action(BackupBlockJob *job,
-                                            bool read, int error)
-{
-    if (read) {
-        return block_job_error_action(&job->common, job->on_source_error,
-                                      true, error);
-    } else {
-        return block_job_error_action(&job->common, job->on_target_error,
-                                      false, error);
-    }
-}
-
 typedef struct {
     int ret;
 } BackupCompleteData;
@@ -398,31 +435,6 @@ static void backup_complete(BlockJob *job, void *opaque)
     g_free(data);
 }
 
-static bool coroutine_fn yield_and_check(BackupBlockJob *job)
-{
-    if (block_job_is_cancelled(&job->common)) {
-        return true;
-    }
-
-    /* we need to yield so that bdrv_drain_all() returns.
-     * (without, VM does not reboot)
-     */
-    if (job->common.speed) {
-        uint64_t delay_ns = ratelimit_calculate_delay(&job->limit,
-                                                      job->sectors_read);
-        job->sectors_read = 0;
-        block_job_sleep_ns(&job->common, QEMU_CLOCK_REALTIME, delay_ns);
-    } else {
-        block_job_sleep_ns(&job->common, QEMU_CLOCK_REALTIME, 0);
-    }
-
-    if (block_job_is_cancelled(&job->common)) {
-        return true;
-    }
-
-    return false;
-}
-
 static void backup_skip_clusters(BackupBlockJob *job,
                                  int64_t start, int64_t end)
 {
@@ -521,26 +533,21 @@ static void backup_skip_loop(BackupBlockJob *job, BlockDriverState *base)
 static int coroutine_fn backup_loop(BackupBlockJob *job)
 {
     int ret;
-    bool error_is_read;
     int64_t sectors_per_cluster = cluster_size_sectors(job);
     int64_t cluster;
     HBitmapIter hbi;
 
     hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
     while ((cluster = hbitmap_iter_next(&hbi)) != -1) {
-        do {
-            if (yield_and_check(job)) {
-                return 0;
-            }
-            ret = backup_do_cow(job, cluster * sectors_per_cluster,
-                                sectors_per_cluster, &error_is_read,
-                                false);
-            if ((ret < 0) &&
-                backup_error_action(job, error_is_read, -ret) ==
-                BLOCK_ERROR_ACTION_REPORT) {
-                return ret;
-            }
-        } while (ret < 0);
+        if (yield_and_check(job)) {
+            return 0;
+        }
+
+        ret = backup_do_cow(job, cluster * sectors_per_cluster,
+                            sectors_per_cluster, false);
+        if (ret < 0) {
+            return ret;
+        }
     }
 
     return 0;
-- 
1.8.3.1
