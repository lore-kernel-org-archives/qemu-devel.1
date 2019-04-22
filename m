Received: from eggs.gnu.org ([209.51.188.92]:51091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIaP5-0000no-PE
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIaP4-00038Y-OL
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:58:43 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 22 Apr 2019 17:58:35 +0300
Message-Id: <20190422145838.70903-7-vsementsov@virtuozzo.com>
In-Reply-To: <20190422145838.70903-1-vsementsov@virtuozzo.com>
References: <20190422145838.70903-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 6/9] block/backup: use buffer-based io
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 9988753249..910ed764aa 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -107,7 +107,6 @@ static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
                                                       void **bounce_buffer)
 {
     int ret;
-    QEMUIOVector qiov;
     BlockBackend *blk = job->common.blk;
     int nbytes;
     int read_flags = is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
@@ -118,9 +117,8 @@ static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
     if (!*bounce_buffer) {
         *bounce_buffer = blk_blockalign(blk, job->cluster_size);
     }
-    qemu_iovec_init_buf(&qiov, *bounce_buffer, nbytes);
 
-    ret = blk_co_preadv(blk, start, qiov.size, &qiov, read_flags);
+    ret = blk_co_pread(blk, start, nbytes, *bounce_buffer, read_flags);
     if (ret < 0) {
         trace_backup_do_cow_read_fail(job, start, ret);
         if (error_is_read) {
@@ -129,13 +127,13 @@ static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
         goto fail;
     }
 
-    if (qemu_iovec_is_zero(&qiov)) {
+    if (buffer_is_zero(*bounce_buffer, nbytes)) {
         ret = blk_co_pwrite_zeroes(job->target, start,
-                                   qiov.size, write_flags | BDRV_REQ_MAY_UNMAP);
+                                   nbytes, write_flags | BDRV_REQ_MAY_UNMAP);
     } else {
-        ret = blk_co_pwritev(job->target, start,
-                             qiov.size, &qiov, write_flags |
-                             (job->compress ? BDRV_REQ_WRITE_COMPRESSED : 0));
+        ret = blk_co_pwrite(job->target, start,
+                            nbytes, *bounce_buffer, write_flags |
+                            (job->compress ? BDRV_REQ_WRITE_COMPRESSED : 0));
     }
     if (ret < 0) {
         trace_backup_do_cow_write_fail(job, start, ret);
-- 
2.18.0
