Received: from eggs.gnu.org ([209.51.188.92]:50666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liliangleo@didiglobal.com>) id 1hKgeX-0000k0-DT
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 06:03:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liliangleo@didiglobal.com>) id 1hKgeV-0005t1-Sm
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 06:03:21 -0400
Received: from mx2.didiglobal.com ([111.202.154.82]:24326
	helo=bsf02.didichuxing.com) by eggs.gnu.org with smtp (Exim 4.71)
	(envelope-from <liliangleo@didiglobal.com>) id 1hKgeV-0005qa-7e
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 06:03:19 -0400
Date: Sun, 28 Apr 2019 18:03:05 +0800
From: Liang Li <liliangleo@didiglobal.com>
Message-ID: <20190428100244.GA63606@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH 1/2] backup: buffer COW request and delay the
 write operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>

If the backup target is a slow device like ceph rbd, the backup
process will affect guest BLK write IO performance seriously,
it's cause by the drawback of COW mechanism, if guest overwrite the
backup BLK area, the IO can only be processed after the data has
been written to backup target.
The impact can be relieved by buffering data read from backup
source and writing to backup target later, so the guest BLK write
IO can be processed in time.
Data area with no overwrite will be process like before without
buffering, in most case, we don't need a very large buffer.

An fio test was done when the backup was going on, the test resut
show a obvious performance improvement by buffering.

Test result(1GB buffer):
========================
fio setting:
[random-writers]
ioengine=libaio
iodepth=8
rw=randwrite
bs=32k
direct=1
size=1G
numjobs=1

result:
                      IOPS        AVG latency
       no backup:     19389         410 us
          backup:      1402        5702 us
backup w/ buffer:      8684         918 us
==============================================

Cc: John Snow <jsnow@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Wen Congyang <wencongyang2@huawei.com>
Cc: Xie Changlong <xiechanglong.d@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Fam Zheng <fam@euphon.net>
Signed-off-by: Liang Li <liliangleo@didiglobal.com>
---
 block/backup.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 104 insertions(+), 13 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 9988753249..d436f9e4ee 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -35,6 +35,12 @@ typedef struct CowRequest {
     CoQueue wait_queue; /* coroutines blocked on this request */
 } CowRequest;
 
+typedef struct CowBufReq {
+    int64_t offset;
+    struct iovec iov;
+    QTAILQ_ENTRY(CowBufReq) next;
+} CowBufReq;
+
 typedef struct BackupBlockJob {
     BlockJob common;
     BlockBackend *target;
@@ -56,9 +62,14 @@ typedef struct BackupBlockJob {
     int64_t copy_range_size;
 
     bool serialize_target_writes;
+    QTAILQ_HEAD(, CowBufReq) buf_reqs;
+    int64_t cow_buf_used;
+    int64_t cow_buf_size;
+    int64_t buf_cow_total;
 } BackupBlockJob;
 
 static const BlockJobDriver backup_job_driver;
+static bool coroutine_fn yield_and_check(BackupBlockJob *job);
 
 /* See if in-flight requests overlap and wait for them to complete */
 static void coroutine_fn wait_for_overlapping_requests(BackupBlockJob *job,
@@ -97,6 +108,46 @@ static void cow_request_end(CowRequest *req)
     qemu_co_queue_restart_all(&req->wait_queue);
 }
 
+static int write_buffer_reqs(BackupBlockJob *job, bool *error_is_read)
+{
+    int ret = 0;
+    CowBufReq *req, *next_req;
+    QEMUIOVector qiov;
+
+    QTAILQ_FOREACH_SAFE(req, &job->buf_reqs, next, next_req) {
+        if (req->iov.iov_base == NULL) {
+            ret = blk_co_pwrite_zeroes(job->target, req->offset,
+                                       req->iov.iov_len, BDRV_REQ_MAY_UNMAP);
+        } else {
+            qemu_iovec_init_external(&qiov, &req->iov, 1);
+            ret = blk_co_pwritev(job->target, req->offset,
+                                 req->iov.iov_len, &qiov,
+                                 job->compress ? BDRV_REQ_WRITE_COMPRESSED : 0);
+        }
+        if (ret < 0) {
+            trace_backup_do_cow_write_fail(job, req->offset, ret);
+            if (error_is_read) {
+                *error_is_read = false;
+            }
+            ret = -1;
+            break;
+        }
+        job_progress_update(&job->common.job, req->iov.iov_len);
+        QTAILQ_REMOVE(&job->buf_reqs, req, next);
+        if (req->iov.iov_base) {
+            job->cow_buf_used -= job->cluster_size;
+            assert(job->cow_buf_used >= 0);
+            g_free(req->iov.iov_base);
+        }
+        g_free(req);
+        if (yield_and_check(job)) {
+            break;
+        }
+    }
+
+    return ret;
+}
+
 /* Copy range to target with a bounce buffer and return the bytes copied. If
  * error occurred, return a negative error number */
 static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
@@ -129,20 +180,35 @@ static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
         goto fail;
     }
 
-    if (qemu_iovec_is_zero(&qiov)) {
-        ret = blk_co_pwrite_zeroes(job->target, start,
-                                   qiov.size, write_flags | BDRV_REQ_MAY_UNMAP);
+    if (is_write_notifier &&
+        job->cow_buf_used <= job->cow_buf_size - job->cluster_size) {
+        CowBufReq *cow_req = g_malloc0(sizeof(CowBufReq));
+        cow_req->offset = start;
+        cow_req->iov = *qiov.iov;
+        if (qemu_iovec_is_zero(&qiov)) {
+            cow_req->iov.iov_base = NULL;
+        } else {
+            job->cow_buf_used += job->cluster_size;
+            *bounce_buffer = NULL;
+        }
+        QTAILQ_INSERT_TAIL(&job->buf_reqs, cow_req, next);
+        job->buf_cow_total++;
     } else {
-        ret = blk_co_pwritev(job->target, start,
-                             qiov.size, &qiov, write_flags |
-                             (job->compress ? BDRV_REQ_WRITE_COMPRESSED : 0));
-    }
-    if (ret < 0) {
-        trace_backup_do_cow_write_fail(job, start, ret);
-        if (error_is_read) {
-            *error_is_read = false;
+        if (qemu_iovec_is_zero(&qiov)) {
+            ret = blk_co_pwrite_zeroes(job->target, start, qiov.size,
+                                       write_flags | BDRV_REQ_MAY_UNMAP);
+        } else {
+            write_flags |= job->compress ? BDRV_REQ_WRITE_COMPRESSED : 0;
+            ret = blk_co_pwritev(job->target, start,
+                                 qiov.size, &qiov, write_flags);
+        }
+        if (ret < 0) {
+            trace_backup_do_cow_write_fail(job, start, ret);
+            if (error_is_read) {
+                *error_is_read = false;
+            }
+            goto fail;
         }
-        goto fail;
     }
 
     return nbytes;
@@ -195,6 +261,13 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
 
     qemu_co_rwlock_rdlock(&job->flush_rwlock);
 
+    if (!is_write_notifier) {
+        ret = write_buffer_reqs(job, error_is_read);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
     start = QEMU_ALIGN_DOWN(offset, job->cluster_size);
     end = QEMU_ALIGN_UP(bytes + offset, job->cluster_size);
 
@@ -451,6 +524,9 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
 
     QLIST_INIT(&s->inflight_reqs);
     qemu_co_rwlock_init(&s->flush_rwlock);
+    QTAILQ_INIT(&s->buf_reqs);
+    s->cow_buf_used = 0;
+    s->buf_cow_total = 0;
 
     nb_clusters = DIV_ROUND_UP(s->len, s->cluster_size);
     job_progress_set_remaining(job, s->len);
@@ -540,6 +616,14 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
 
     notifier_with_return_remove(&s->before_write);
 
+    while (!QTAILQ_EMPTY(&s->buf_reqs)) {
+        ret = write_buffer_reqs(s, NULL);
+        if (ret < 0) {
+            backup_error_action(s, false, -ret);
+            break;
+        }
+    }
+    info_report("backup buffered cow requests = %ld", s->buf_cow_total);
     /* wait until pending backup_do_cow() calls have completed */
     qemu_co_rwlock_wrlock(&s->flush_rwlock);
     qemu_co_rwlock_unlock(&s->flush_rwlock);
@@ -664,6 +748,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     job->sync_bitmap = sync_mode == MIRROR_SYNC_MODE_INCREMENTAL ?
                        sync_bitmap : NULL;
     job->compress = compress;
+    job->cow_buf_size = 0;
 
     /* Detect image-fleecing (and similar) schemes */
     job->serialize_target_writes = bdrv_chain_contains(target, bs);
@@ -694,7 +779,13 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     } else {
         job->cluster_size = MAX(BACKUP_CLUSTER_SIZE_DEFAULT, bdi.cluster_size);
     }
-    job->use_copy_range = true;
+
+    if (!job->cow_buf_size) {
+        job->use_copy_range = true;
+    } else {
+        job->use_copy_range = false;
+    }
+
     job->copy_range_size = MIN_NON_ZERO(blk_get_max_transfer(job->common.blk),
                                         blk_get_max_transfer(job->target));
     job->copy_range_size = MAX(job->cluster_size,
-- 
2.14.1
