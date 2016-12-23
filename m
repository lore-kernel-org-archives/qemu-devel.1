Received: from eggs.gnu.org ([2001:4830:134:3::10]:49126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKV6t-000549-No
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 14:02:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKV6s-0001ym-JL
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 14:02:31 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 23 Dec 2016 17:28:52 +0300
Message-ID: <1482503344-6424-10-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 09/21] backup: separate copy function
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 103 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 61 insertions(+), 42 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 4ef8daf..2c8b7ba 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -95,6 +95,65 @@ static void cow_request_end(CowRequest *req)
     qemu_co_queue_restart_all(&req->wait_queue);
 }
 
+static int coroutine_fn backup_copy_cluster(BackupBlockJob *job,
+                                            int64_t cluster,
+                                            bool *error_is_read,
+                                            bool is_write_notifier,
+                                            void *bounce_buffer)
+{
+    BlockBackend *blk = job->common.blk;
+    int n;
+    struct iovec iov;
+    QEMUIOVector bounce_qiov;
+    int ret = 0;
+    int64_t sectors_per_cluster = cluster_size_sectors(job);
+
+    trace_backup_do_cow_process(job, cluster);
+
+    n = MIN(sectors_per_cluster,
+            job->common.len / BDRV_SECTOR_SIZE -
+            cluster * sectors_per_cluster);
+
+    iov.iov_base = bounce_buffer;
+    iov.iov_len = n * BDRV_SECTOR_SIZE;
+    qemu_iovec_init_external(&bounce_qiov, &iov, 1);
+
+    ret = blk_co_preadv(blk, cluster * job->cluster_size,
+                        bounce_qiov.size, &bounce_qiov,
+                        is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0);
+    if (ret < 0) {
+        trace_backup_do_cow_read_fail(job, cluster, ret);
+        if (error_is_read) {
+            *error_is_read = true;
+        }
+        return ret;
+    }
+
+    if (buffer_is_zero(iov.iov_base, iov.iov_len)) {
+        ret = blk_co_pwrite_zeroes(job->target, cluster * job->cluster_size,
+                                   bounce_qiov.size, BDRV_REQ_MAY_UNMAP);
+    } else {
+        ret = blk_co_pwritev(job->target, cluster * job->cluster_size,
+                             bounce_qiov.size, &bounce_qiov,
+                             job->compress ? BDRV_REQ_WRITE_COMPRESSED : 0);
+    }
+    if (ret < 0) {
+        trace_backup_do_cow_write_fail(job, cluster, ret);
+        if (error_is_read) {
+            *error_is_read = false;
+        }
+        return ret;
+    }
+
+    /* Publish progress, guest I/O counts as progress too.  Note that the
+     * offset field is an opaque progress value, it is not a disk offset.
+     */
+    job->sectors_read += n;
+    job->common.offset += n * BDRV_SECTOR_SIZE;
+
+    return 0;
+}
+
 static int coroutine_fn backup_do_cow(BackupBlockJob *job,
                                       int64_t sector_num, int nb_sectors,
                                       bool *error_is_read,
@@ -102,13 +161,10 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
 {
     BlockBackend *blk = job->common.blk;
     CowRequest cow_request;
-    struct iovec iov;
-    QEMUIOVector bounce_qiov;
     void *bounce_buffer = NULL;
     int ret = 0;
     int64_t sectors_per_cluster = cluster_size_sectors(job);
     int64_t start, end;
-    int n;
 
     qemu_co_rwlock_rdlock(&job->flush_rwlock);
 
@@ -127,53 +183,16 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
         }
         hbitmap_reset(job->copy_bitmap, start, 1);
 
-        trace_backup_do_cow_process(job, start);
-
-        n = MIN(sectors_per_cluster,
-                job->common.len / BDRV_SECTOR_SIZE -
-                start * sectors_per_cluster);
-
         if (!bounce_buffer) {
             bounce_buffer = blk_blockalign(blk, job->cluster_size);
         }
-        iov.iov_base = bounce_buffer;
-        iov.iov_len = n * BDRV_SECTOR_SIZE;
-        qemu_iovec_init_external(&bounce_qiov, &iov, 1);
 
-        ret = blk_co_preadv(blk, start * job->cluster_size,
-                            bounce_qiov.size, &bounce_qiov,
-                            is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0);
+        ret = backup_copy_cluster(job, start, error_is_read, is_write_notifier,
+                                  bounce_buffer);
         if (ret < 0) {
-            trace_backup_do_cow_read_fail(job, start, ret);
-            if (error_is_read) {
-                *error_is_read = true;
-            }
-            hbitmap_set(job->copy_bitmap, start, 1);
-            goto out;
-        }
-
-        if (buffer_is_zero(iov.iov_base, iov.iov_len)) {
-            ret = blk_co_pwrite_zeroes(job->target, start * job->cluster_size,
-                                       bounce_qiov.size, BDRV_REQ_MAY_UNMAP);
-        } else {
-            ret = blk_co_pwritev(job->target, start * job->cluster_size,
-                                 bounce_qiov.size, &bounce_qiov,
-                                 job->compress ? BDRV_REQ_WRITE_COMPRESSED : 0);
-        }
-        if (ret < 0) {
-            trace_backup_do_cow_write_fail(job, start, ret);
-            if (error_is_read) {
-                *error_is_read = false;
-            }
             hbitmap_set(job->copy_bitmap, start, 1);
             goto out;
         }
-
-        /* Publish progress, guest I/O counts as progress too.  Note that the
-         * offset field is an opaque progress value, it is not a disk offset.
-         */
-        job->sectors_read += n;
-        job->common.offset += n * BDRV_SECTOR_SIZE;
     }
 
 out:
-- 
1.8.3.1
