Received: from eggs.gnu.org ([2001:4830:134:3::10]:40908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKUCu-0001ce-Dy
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 13:04:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKUCt-00061H-5c
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 13:04:40 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 23 Dec 2016 17:28:53 +0300
Message-ID: <1482503344-6424-11-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 10/21] backup: refactor backup_copy_cluster()
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

    Split out read and write functions.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c     | 53 +++++++++++++++++++++++++++++++++++++++--------------
 block/trace-events |  4 ++--
 2 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 2c8b7ba..5c31607 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -95,18 +95,53 @@ static void cow_request_end(CowRequest *req)
     qemu_co_queue_restart_all(&req->wait_queue);
 }
 
+static int coroutine_fn backup_do_read(BackupBlockJob *job,
+                                       int64_t offset, unsigned int bytes,
+                                       QEMUIOVector *qiov,
+                                       bool is_write_notifier)
+{
+    int ret = blk_co_preadv(job->common.blk, offset, bytes, qiov,
+                            is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0);
+    if (ret < 0) {
+        trace_backup_do_read_fail(job, offset, bytes, ret);
+    }
+
+    return ret;
+}
+
+static int coroutine_fn backup_do_write(BackupBlockJob *job,
+                                        int64_t offset, unsigned int bytes,
+                                        QEMUIOVector *qiov)
+{
+    int ret;
+    assert(qiov->niov == 1);
+
+    if (buffer_is_zero(qiov->iov->iov_base, qiov->iov->iov_len)) {
+        ret = blk_co_pwrite_zeroes(job->target, offset, bytes,
+                                   BDRV_REQ_MAY_UNMAP);
+    } else {
+        ret = blk_co_pwritev(job->target, offset, bytes, qiov,
+                             job->compress ? BDRV_REQ_WRITE_COMPRESSED : 0);
+    }
+    if (ret < 0) {
+        trace_backup_do_write_fail(job, offset, bytes, ret);
+    }
+
+    return ret;
+}
+
 static int coroutine_fn backup_copy_cluster(BackupBlockJob *job,
                                             int64_t cluster,
                                             bool *error_is_read,
                                             bool is_write_notifier,
                                             void *bounce_buffer)
 {
-    BlockBackend *blk = job->common.blk;
     int n;
     struct iovec iov;
     QEMUIOVector bounce_qiov;
     int ret = 0;
     int64_t sectors_per_cluster = cluster_size_sectors(job);
+    int64_t offset = cluster * job->cluster_size;
 
     trace_backup_do_cow_process(job, cluster);
 
@@ -118,27 +153,17 @@ static int coroutine_fn backup_copy_cluster(BackupBlockJob *job,
     iov.iov_len = n * BDRV_SECTOR_SIZE;
     qemu_iovec_init_external(&bounce_qiov, &iov, 1);
 
-    ret = blk_co_preadv(blk, cluster * job->cluster_size,
-                        bounce_qiov.size, &bounce_qiov,
-                        is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0);
+    ret = backup_do_read(job, offset, bounce_qiov.size, &bounce_qiov,
+                         is_write_notifier);
     if (ret < 0) {
-        trace_backup_do_cow_read_fail(job, cluster, ret);
         if (error_is_read) {
             *error_is_read = true;
         }
         return ret;
     }
 
-    if (buffer_is_zero(iov.iov_base, iov.iov_len)) {
-        ret = blk_co_pwrite_zeroes(job->target, cluster * job->cluster_size,
-                                   bounce_qiov.size, BDRV_REQ_MAY_UNMAP);
-    } else {
-        ret = blk_co_pwritev(job->target, cluster * job->cluster_size,
-                             bounce_qiov.size, &bounce_qiov,
-                             job->compress ? BDRV_REQ_WRITE_COMPRESSED : 0);
-    }
+    ret = backup_do_write(job, offset, bounce_qiov.size, &bounce_qiov);
     if (ret < 0) {
-        trace_backup_do_cow_write_fail(job, cluster, ret);
         if (error_is_read) {
             *error_is_read = false;
         }
diff --git a/block/trace-events b/block/trace-events
index cfc05f2..832e8ed 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -43,8 +43,8 @@ backup_do_cow_enter(void *job, int64_t start, int64_t sector_num, int nb_sectors
 backup_do_cow_return(void *job, int64_t sector_num, int nb_sectors, int ret) "job %p sector_num %"PRId64" nb_sectors %d ret %d"
 backup_do_cow_skip(void *job, int64_t start) "job %p start %"PRId64
 backup_do_cow_process(void *job, int64_t start) "job %p start %"PRId64
-backup_do_cow_read_fail(void *job, int64_t start, int ret) "job %p start %"PRId64" ret %d"
-backup_do_cow_write_fail(void *job, int64_t start, int ret) "job %p start %"PRId64" ret %d"
+backup_do_read_fail(void *job, int64_t offset, unsigned bytes, int ret) "job %p offset %"PRId64" bytes %u ret %d"
+backup_do_write_fail(void *job, int64_t offset, unsigned bytes, int ret) "job %p offset %"PRId64" bytes %u ret %d"
 
 # blockdev.c
 qmp_block_job_cancel(void *job) "job %p"
-- 
1.8.3.1
