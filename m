Received: from eggs.gnu.org ([2001:4830:134:3::10]:49043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKSVD-0003Bh-Lj
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 11:15:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKSVA-0004SG-7p
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 11:15:27 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 23 Dec 2016 17:29:01 +0300
Message-ID: <1482503344-6424-19-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 18/21] backup: new async architecture
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

New async scheme: all copying is done by worker coroutines. Main
block-job coroutine serves initial skipping of unallocated clusters, and
also all pauses, error handling, throttling.

Notifiers just mark clusters as awaited (by adding NotifierRequest to
the list) and wait for some time (5 sec) for these clusters.

Because of the imporvements (async, fast, skipping unallocated) some
tests failed, so they are fixed here too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c           | 641 ++++++++++++++++++++++++++++++++++++-----------
 block/trace-events       |  31 ++-
 blockjob.c               |  29 ++-
 include/block/blockjob.h |  15 +-
 tests/qemu-iotests/055   |   2 +-
 tests/qemu-iotests/129   |   6 +-
 6 files changed, 569 insertions(+), 155 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index c2f7665..558b871 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -27,6 +27,18 @@
 
 #define BACKUP_CLUSTER_SIZE_DEFAULT (1 << 16)
 #define SLICE_TIME 100000000ULL /* ns */
+#define BACKUP_LOOP_DELAY 100000000ULL /* ns */
+#define WRITE_NOTIFY_TIMEOUT_NS 5000000000LL
+
+#define NB_WORKERS 24
+
+typedef struct NotifierRequest {
+    int64_t start; /* in clusters */
+    int64_t end; /* in clusters */
+    int nb_wait; /* awaited clusters */
+    Coroutine *notif;
+    QSIMPLEQ_ENTRY(NotifierRequest) list;
+} NotifierRequest;
 
 typedef struct BackupBlockJob {
     BlockJob common;
@@ -37,7 +49,6 @@ typedef struct BackupBlockJob {
     RateLimit limit;
     BlockdevOnError on_source_error;
     BlockdevOnError on_target_error;
-    CoRwlock flush_rwlock;
     uint64_t sectors_read;
     int64_t cluster_size;
     bool compress;
@@ -45,19 +56,26 @@ typedef struct BackupBlockJob {
     QLIST_HEAD(, CowRequest) inflight_reqs;
 
     HBitmap *copy_bitmap;
+    HBitmapIter linear_hbi;
+
+    CoQueue paused_workers;
+    int running_workers;
+    int nb_busy_workers;
+
+    bool delayed;
+    bool waiting_for_workers;
+    bool error_exit;
+    bool has_errors;
+    BlockErrorAction error_action;
+    int main_error;
+    bool main_error_is_read;
+
+    unsigned long *notif_wait_bitmap;
+    QSIMPLEQ_HEAD(, NotifierRequest) notifier_reqs;
+    NotifierRequest *current_notif;
+    HBitmapIter current_notif_hbi;
 } BackupBlockJob;
 
-/* Size of a cluster in sectors, instead of bytes. */
-static inline int64_t cluster_size_sectors(BackupBlockJob *job)
-{
-  return job->cluster_size / BDRV_SECTOR_SIZE;
-}
-
-static inline int64_t max_query_sectors(BackupBlockJob *job)
-{
-    return (INT_MAX & ~(job->cluster_size - 1)) >> BDRV_SECTOR_BITS;
-}
-
 /* See if in-flight requests overlap and wait for them to complete */
 static void coroutine_fn wait_for_overlapping_requests(BackupBlockJob *job,
                                                        int64_t start,
@@ -95,6 +113,129 @@ static void cow_request_end(CowRequest *req)
     qemu_co_queue_restart_all(&req->wait_queue);
 }
 
+static inline void set_notif_cur(BackupBlockJob *job, NotifierRequest *nr)
+{
+    if (nr != NULL) {
+        hbitmap_iter_init(&job->current_notif_hbi, job->copy_bitmap, nr->start);
+    }
+    job->current_notif = nr;
+}
+
+/* NULL result means that request is already done */
+static NotifierRequest *add_notif_req(BackupBlockJob *job,
+                                      int64_t start, int64_t end,
+                                      Coroutine *notif)
+{
+    NotifierRequest *nr;
+    int nb_wait = bitmap_count_between(job->notif_wait_bitmap, start, end) +
+                  hbitmap_count_between(job->copy_bitmap, start, end);
+
+    if (nb_wait == 0) {
+        return NULL;
+    }
+
+    nr = g_new0(NotifierRequest, 1);
+
+    nr->start = start;
+    nr->end = end;
+    nr->notif = notif;
+    nr->nb_wait = nb_wait;
+
+    QSIMPLEQ_INSERT_TAIL(&job->notifier_reqs, nr, list);
+    if (job->current_notif == NULL) {
+        set_notif_cur(job, nr);
+    }
+
+    return nr;
+}
+
+static void detach_notif_req(BackupBlockJob *job, NotifierRequest *req)
+{
+    assert(req);
+
+    if (job->current_notif == req) {
+        set_notif_cur(job, QSIMPLEQ_NEXT(req, list));
+    }
+
+    QSIMPLEQ_REMOVE(&job->notifier_reqs, req, NotifierRequest, list);
+}
+
+static int64_t next_notif_cluster(BackupBlockJob *job)
+{
+    while (job->current_notif != NULL) {
+        int64_t cluster = hbitmap_iter_next(&job->current_notif_hbi);
+        if (cluster != -1 && cluster < job->current_notif->end) {
+            return cluster;
+        }
+
+        /* nothing to do for current notifier */
+        set_notif_cur(job, QSIMPLEQ_NEXT(job->current_notif, list));
+    }
+
+    /* nothing to do for notifiers */
+    return -1;
+}
+
+static void finish_cluster_for_notif(BackupBlockJob *job, int64_t cluster)
+{
+    NotifierRequest *req, *next;
+    QSIMPLEQ_HEAD(, NotifierRequest) finished_reqs;
+    QSIMPLEQ_INIT(&finished_reqs);
+
+    trace_backup_finish_cluster_for_notif(job, cluster);
+
+    clear_bit(cluster, job->notif_wait_bitmap);
+
+    /* handle notifiers */
+    QSIMPLEQ_FOREACH_SAFE(req, &job->notifier_reqs, list, next) {
+        if (cluster >= req->start && cluster < req->end) {
+            assert(req->nb_wait > 0);
+            req->nb_wait--;
+            if (req->nb_wait == 0) {
+                detach_notif_req(job, req);
+                QSIMPLEQ_INSERT_TAIL(&finished_reqs, req, list);
+            }
+        }
+    }
+
+    while ((req = QSIMPLEQ_FIRST(&finished_reqs))) {
+        QSIMPLEQ_REMOVE(&finished_reqs, req, NotifierRequest, list);
+        qemu_coroutine_enter(req->notif);
+    }
+}
+
+static void release_pending_notifiers(BackupBlockJob *job)
+{
+    NotifierRequest *req, *next;
+    QSIMPLEQ_HEAD(, NotifierRequest) finished_reqs;
+    QSIMPLEQ_INIT(&finished_reqs);
+
+    QSIMPLEQ_FOREACH_SAFE(req, &job->notifier_reqs, list, next) {
+        req->nb_wait = 0;
+        detach_notif_req(job, req);
+        QSIMPLEQ_INSERT_TAIL(&finished_reqs, req, list);
+    }
+
+    while ((req = QSIMPLEQ_FIRST(&finished_reqs))) {
+        QSIMPLEQ_REMOVE(&finished_reqs, req, NotifierRequest, list);
+        qemu_coroutine_enter(req->notif);
+    }
+}
+
+static void coroutine_fn backup_do_cow(BackupBlockJob *job,
+                                       int64_t sector_num, int nb_sectors);
+
+/* Size of a cluster in sectors, instead of bytes. */
+static inline int64_t cluster_size_sectors(BackupBlockJob *job)
+{
+    return job->cluster_size / BDRV_SECTOR_SIZE;
+}
+
+static inline int64_t max_query_sectors(BackupBlockJob *job)
+{
+    return (INT_MAX & ~(job->cluster_size - 1)) >> BDRV_SECTOR_BITS;
+}
+
 static BlockErrorAction backup_error_action(BackupBlockJob *job,
                                             bool read, int error)
 {
@@ -107,12 +248,8 @@ static BlockErrorAction backup_error_action(BackupBlockJob *job,
     }
 }
 
-static bool coroutine_fn yield_and_check(BackupBlockJob *job)
+static void backup_job_sleep(BackupBlockJob *job)
 {
-    if (block_job_is_cancelled(&job->common)) {
-        return true;
-    }
-
     /* we need to yield so that bdrv_drain_all() returns.
      * (without, VM does not reboot)
      */
@@ -120,11 +257,42 @@ static bool coroutine_fn yield_and_check(BackupBlockJob *job)
         uint64_t delay_ns = ratelimit_calculate_delay(&job->limit,
                                                       job->sectors_read);
         job->sectors_read = 0;
+        job->delayed = true;
+        trace_backup_sleep_delay(block_job_is_cancelled(&job->common),
+                                 block_job_should_pause(&job->common));
         block_job_sleep_ns(&job->common, QEMU_CLOCK_REALTIME, delay_ns);
+        job->delayed = false;
     } else {
-        block_job_sleep_ns(&job->common, QEMU_CLOCK_REALTIME, 0);
+        trace_backup_sleep_zero(block_job_is_cancelled(&job->common),
+                                block_job_should_pause(&job->common));
+        block_job_pause_point(&job->common);
+    }
+
+    trace_backup_sleep_finish();
+}
+
+/* backup_busy_sleep
+ * Just yield, without setting busy=false
+ */
+static void backup_busy_sleep(BackupBlockJob *job)
+{
+    trace_backup_loop_busy_sleep_start();
+
+    job->waiting_for_workers = true;
+    qemu_coroutine_yield();
+    job->waiting_for_workers = false;
+
+    trace_backup_loop_busy_sleep_finish();
+}
+
+static bool coroutine_fn yield_and_check(BackupBlockJob *job)
+{
+    if (block_job_is_cancelled(&job->common)) {
+        return true;
     }
 
+    backup_job_sleep(job);
+
     if (block_job_is_cancelled(&job->common)) {
         return true;
     }
@@ -132,69 +300,246 @@ static bool coroutine_fn yield_and_check(BackupBlockJob *job)
     return false;
 }
 
-static int coroutine_fn backup_do_read(BackupBlockJob *job,
-                                       int64_t offset, unsigned int bytes,
-                                       QEMUIOVector *qiov)
+static void backup_job_wait_workers(BackupBlockJob *job)
 {
-    int ret;
+    if (job->nb_busy_workers == 0) {
+        return;
+    }
 
-retry:
-    ret = blk_co_preadv(job->common.blk, offset, bytes, qiov,
-                        BDRV_REQ_NO_SERIALISING);
-    if (ret < 0) {
-        trace_backup_do_read_fail(job, offset, bytes, ret);
+    job->waiting_for_workers = true;
+
+    trace_backup_job_wait_workers_start();
+    qemu_coroutine_yield();
+    trace_backup_job_wait_workers_end();
+
+    assert(job->nb_busy_workers == 0);
+    job->waiting_for_workers = false;
+}
 
-        BlockErrorAction action = backup_error_action(job, true, -ret);
-        if (action != BLOCK_ERROR_ACTION_REPORT && !yield_and_check(job)) {
-            goto retry;
+static void backup_worker_pause(BackupBlockJob *job)
+{
+    job->nb_busy_workers--;
+
+    trace_backup_worker_pause(qemu_coroutine_self(), job->nb_busy_workers,
+                              job->waiting_for_workers);
+
+    if (job->nb_busy_workers == 0 && job->waiting_for_workers) {
+        qemu_coroutine_add_next(job->common.co);
+    }
+
+    qemu_co_queue_wait(&job->paused_workers);
+
+    trace_backup_worker_unpause(qemu_coroutine_self());
+
+    job->nb_busy_workers++;
+}
+
+static void backup_worker_error(BackupBlockJob *job, int error, bool is_read)
+{
+    BlockErrorAction action =
+        block_job_get_error_action(&job->common, job->on_target_error, error);
+
+    if (!job->has_errors || job->error_action == BLOCK_ERROR_ACTION_IGNORE ||
+            action == BLOCK_ERROR_ACTION_REPORT) {
+        job->has_errors = true;
+        job->error_action = action;
+        job->main_error = error;
+        job->main_error_is_read = is_read;
+    }
+
+    backup_worker_pause(job);
+}
+
+#define BACKUP_WORKER_STOP -1
+#define BACKUP_WORKER_PAUSE -2
+
+static inline bool check_delay(BackupBlockJob *job)
+{
+    uint64_t delay_ns;
+
+    if (!job->common.speed) {
+        return false;
+    }
+
+    delay_ns = ratelimit_calculate_delay(&job->limit, job->sectors_read);
+    job->sectors_read = 0;
+
+    if (delay_ns == 0) {
+        if (job->delayed) {
+            job->delayed = false;
+            qemu_co_queue_restart_all(&job->paused_workers);
         }
+        return false;
+    }
 
-        return ret;
+    return job->delayed = true;
+}
+
+static inline int64_t backup_get_work(BackupBlockJob *job)
+{
+    int64_t cluster;
+
+    if (block_job_is_cancelled(&job->common) || job->error_exit) {
+        return BACKUP_WORKER_STOP;
     }
 
-    return 0;
+    cluster = next_notif_cluster(job);
+    if (cluster != -1) {
+        return cluster;
+    }
+
+    if (block_job_should_pause(&job->common) ||
+        job->sync_mode == MIRROR_SYNC_MODE_NONE || check_delay(job))
+    {
+        return BACKUP_WORKER_PAUSE;
+    }
+
+    cluster = hbitmap_iter_next(&job->linear_hbi);
+
+    return cluster == -1 ? BACKUP_WORKER_STOP : cluster;
+}
+
+static void coroutine_fn backup_worker_co(void *opaque)
+{
+    BackupBlockJob *job = opaque;
+
+    job->running_workers++;
+    job->nb_busy_workers++;
+
+    while (true) {
+        int64_t cluster = backup_get_work(job);
+        trace_backup_worker_got_work(job, qemu_coroutine_self(), cluster);
+
+        switch (cluster) {
+        case BACKUP_WORKER_STOP:
+            job->nb_busy_workers--;
+            job->running_workers--;
+            if (job->nb_busy_workers == 0 && job->waiting_for_workers) {
+                qemu_coroutine_add_next(job->common.co);
+            }
+            trace_backup_worker_stop(qemu_coroutine_self(),
+                                     job->nb_busy_workers, job->running_workers,
+                                     job->waiting_for_workers);
+            return;
+        case BACKUP_WORKER_PAUSE:
+            backup_worker_pause(job);
+            break;
+        default:
+            backup_do_cow(job, cluster * cluster_size_sectors(job),
+                          cluster_size_sectors(job));
+        }
+    }
+}
+
+static bool coroutine_fn handle_errors(BackupBlockJob *job)
+{
+    BlockErrorAction action;
+
+    if (!job->has_errors) {
+        return false;
+    }
+
+    backup_job_wait_workers(job);
+
+    action = backup_error_action(job, job->main_error_is_read,
+                                 -job->main_error);
+
+    if (action == BLOCK_ERROR_ACTION_REPORT) {
+        return true;
+    }
+
+    job->has_errors = false;
+    return false;
+}
+
+
+
+/* this loop runs in block job coroutine (job->common.co) and handles
+ * block-job specific pauses, delays and yields. It doesn't do real data copy.
+ */
+static void coroutine_fn backup_loop(BackupBlockJob *job)
+{
+    bool err_ret;
+
+    trace_backup_loop_enter();
+
+    while (job->running_workers > 0) {
+        if (handle_errors(job)) {
+            trace_backup_loop_error_exit();
+            return;
+        }
+
+        backup_job_sleep(job);
+
+        if (job->running_workers == 0) {
+            break;
+        }
+
+        if (handle_errors(job)) {
+            trace_backup_loop_error_exit();
+            return;
+        }
+
+        /* we may be resumed after pause or delay, so we should resume paused
+         * workers */
+        qemu_co_queue_restart_all(&job->paused_workers);
+
+        backup_busy_sleep(job);
+    }
+
+    err_ret = handle_errors(job);
+    trace_backup_loop_finish(err_ret);
 }
 
-static int coroutine_fn backup_do_write(BackupBlockJob *job,
+static void coroutine_fn backup_do_read(BackupBlockJob *job,
                                         int64_t offset, unsigned int bytes,
                                         QEMUIOVector *qiov)
 {
     int ret;
-    bool zeroes;
-
-    assert(qiov->niov == 1);
-    zeroes = buffer_is_zero(qiov->iov->iov_base, qiov->iov->iov_len);
 
-retry:
-    if (zeroes) {
-        ret = blk_co_pwrite_zeroes(job->target, offset, bytes,
-                                   BDRV_REQ_MAY_UNMAP);
-    } else {
-        ret = blk_co_pwritev(job->target, offset, bytes, qiov,
-                             job->compress ? BDRV_REQ_WRITE_COMPRESSED : 0);
+    while (!job->error_exit &&
+           (ret = blk_co_preadv(job->common.blk, offset, bytes, qiov,
+                                BDRV_REQ_NO_SERIALISING)) < 0)
+    {
+        trace_backup_do_read_fail(job, qemu_coroutine_self(), offset, bytes,
+                                  ret);
+        backup_worker_error(job, ret, true);
     }
-    if (ret < 0) {
-        trace_backup_do_write_fail(job, offset, bytes, ret);
+}
 
-        BlockErrorAction action = backup_error_action(job, false, -ret);
-        if (action != BLOCK_ERROR_ACTION_REPORT && !yield_and_check(job)) {
-            goto retry;
-        }
+static void coroutine_fn backup_do_write(BackupBlockJob *job,
+                                        int64_t offset, unsigned int bytes,
+                                        QEMUIOVector *qiov)
+{
+    int ret;
+    BdrvRequestFlags flags = 0;
 
-        return ret;
+    assert(qiov->niov == 1);
+
+    if (buffer_is_zero(qiov->iov->iov_base, qiov->iov->iov_len)) {
+        flags = BDRV_REQ_MAY_UNMAP | BDRV_REQ_ZERO_WRITE;
+        qiov = NULL;
+    } else if (job->compress) {
+        flags = BDRV_REQ_WRITE_COMPRESSED;
     }
 
-    return 0;
+    while (!job->error_exit &&
+           (ret = blk_co_pwritev(job->target, offset,
+                                 bytes, qiov, flags)) < 0)
+    {
+        trace_backup_do_write_fail(job, qemu_coroutine_self(), offset, bytes,
+                                   ret);
+        backup_worker_error(job, ret, false);
+    }
 }
 
-static int coroutine_fn backup_copy_cluster(BackupBlockJob *job,
+static void coroutine_fn backup_copy_cluster(BackupBlockJob *job,
                                             int64_t cluster,
                                             void *bounce_buffer)
 {
     int n;
     struct iovec iov;
     QEMUIOVector bounce_qiov;
-    int ret = 0;
     int64_t sectors_per_cluster = cluster_size_sectors(job);
     int64_t offset = cluster * job->cluster_size;
 
@@ -208,14 +553,22 @@ static int coroutine_fn backup_copy_cluster(BackupBlockJob *job,
     iov.iov_len = n * BDRV_SECTOR_SIZE;
     qemu_iovec_init_external(&bounce_qiov, &iov, 1);
 
-    ret = backup_do_read(job, offset, bounce_qiov.size, &bounce_qiov);
-    if (ret < 0) {
-        return ret;
+    backup_do_read(job, offset, bounce_qiov.size, &bounce_qiov);
+    if (job->error_exit) {
+        return;
     }
 
-    ret = backup_do_write(job, offset, bounce_qiov.size, &bounce_qiov);
-    if (ret < 0) {
-        return ret;
+    if (job->sync_mode != MIRROR_SYNC_MODE_NONE) {
+        finish_cluster_for_notif(job, cluster);
+    }
+
+    backup_do_write(job, offset, bounce_qiov.size, &bounce_qiov);
+    if (job->error_exit) {
+        return;
+    }
+
+    if (job->sync_mode == MIRROR_SYNC_MODE_NONE) {
+        finish_cluster_for_notif(job, cluster);
     }
 
     /* Publish progress, guest I/O counts as progress too.  Note that the
@@ -223,29 +576,21 @@ static int coroutine_fn backup_copy_cluster(BackupBlockJob *job,
      */
     job->sectors_read += n;
     job->common.offset += n * BDRV_SECTOR_SIZE;
-
-    return 0;
 }
 
-static int coroutine_fn backup_do_cow(BackupBlockJob *job,
-                                      int64_t sector_num, int nb_sectors)
+static void coroutine_fn backup_do_cow(BackupBlockJob *job,
+                                       int64_t sector_num, int nb_sectors)
 {
     BlockBackend *blk = job->common.blk;
-    CowRequest cow_request;
     void *bounce_buffer = NULL;
-    int ret = 0;
     int64_t sectors_per_cluster = cluster_size_sectors(job);
     int64_t start, end;
 
-    qemu_co_rwlock_rdlock(&job->flush_rwlock);
-
     start = sector_num / sectors_per_cluster;
     end = DIV_ROUND_UP(sector_num + nb_sectors, sectors_per_cluster);
 
-    trace_backup_do_cow_enter(job, start, sector_num, nb_sectors);
-
-    wait_for_overlapping_requests(job, start, end);
-    cow_request_begin(&cow_request, job, start, end);
+    trace_backup_do_cow_enter(job, qemu_coroutine_self(),  start, sector_num,
+                              nb_sectors);
 
     for (; start < end; start++) {
         if (!hbitmap_get(job->copy_bitmap, start)) {
@@ -253,46 +598,64 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
             continue; /* already copied */
         }
         hbitmap_reset(job->copy_bitmap, start, 1);
+        set_bit(start, job->notif_wait_bitmap);
 
         if (!bounce_buffer) {
             bounce_buffer = blk_blockalign(blk, job->cluster_size);
         }
 
-        ret = backup_copy_cluster(job, start, bounce_buffer);
-        if (ret < 0) {
-            hbitmap_set(job->copy_bitmap, start, 1);
-            goto out;
-        }
+        backup_copy_cluster(job, start, bounce_buffer);
     }
 
-out:
     if (bounce_buffer) {
         qemu_vfree(bounce_buffer);
     }
 
-    cow_request_end(&cow_request);
-
-    trace_backup_do_cow_return(job, sector_num, nb_sectors, ret);
-
-    qemu_co_rwlock_unlock(&job->flush_rwlock);
-
-    return ret;
+    trace_backup_do_cow_return(job, qemu_coroutine_self(), sector_num,
+                               nb_sectors);
 }
 
 static int coroutine_fn backup_before_write_notify(
         NotifierWithReturn *notifier,
         void *opaque)
 {
-    BackupBlockJob *job = container_of(notifier, BackupBlockJob, before_write);
-    BdrvTrackedRequest *req = opaque;
-    int64_t sector_num = req->offset >> BDRV_SECTOR_BITS;
-    int nb_sectors = req->bytes >> BDRV_SECTOR_BITS;
+    BdrvTrackedRequest *tr = opaque;
+    NotifierRequest *nr;
+    BackupBlockJob *job = (BackupBlockJob *)tr->bs->job;
+    int64_t start = tr->offset / job->cluster_size;
+    int64_t end = DIV_ROUND_UP(tr->offset + tr->bytes, job->cluster_size);
+    int ret = 0;
+
+    assert((tr->offset & (BDRV_SECTOR_SIZE - 1)) == 0);
+    assert((tr->bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
+
+    nr = add_notif_req(job, start, end, qemu_coroutine_self());
 
-    assert(req->bs == blk_bs(job->common.blk));
-    assert((req->offset & (BDRV_SECTOR_SIZE - 1)) == 0);
-    assert((req->bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
+    if (nr == NULL) {
+        trace_backup_before_write_notify_skip(job, tr->offset, tr->bytes);
+    } else {
+        trace_backup_before_write_notify_start(job, tr->offset, tr->bytes, nr,
+                                               nr->start, nr->end, nr->nb_wait);
+
+        if (!job->has_errors) {
+            qemu_co_queue_restart_all(&job->paused_workers);
+        }
+        co_aio_sleep_ns(blk_get_aio_context(job->common.blk),
+                        QEMU_CLOCK_REALTIME, WRITE_NOTIFY_TIMEOUT_NS);
+        if (nr->nb_wait > 0) {
+            /* timer expired and read request not finished */
+            ret = -EINVAL;
+            detach_notif_req(job, nr);
+            trace_backup_before_write_notify_timeout(job, nr, nr->start,
+                                                     nr->end, nr->nb_wait);
+        } else {
+            trace_backup_before_write_notify_success(job, nr, nr->start,
+                                                     nr->end, nr->nb_wait);
+        }
+        g_free(nr);
+    }
 
-    return backup_do_cow(job, sector_num, nb_sectors);
+    return ret;
 }
 
 static void backup_set_speed(BlockJob *job, int64_t speed, Error **errp)
@@ -434,11 +797,6 @@ static void backup_complete(BlockJob *job, void *opaque)
 static void backup_skip_clusters(BackupBlockJob *job,
                                  int64_t start, int64_t end)
 {
-    CowRequest cow_request;
-
-    wait_for_overlapping_requests(job, start, end);
-    cow_request_begin(&cow_request, job, start, end);
-
     if (end * job->cluster_size > job->common.len) {
         int64_t n;
         end--;
@@ -446,8 +804,10 @@ static void backup_skip_clusters(BackupBlockJob *job,
         assert(n > 0);
 
         if (hbitmap_get(job->copy_bitmap, end)) {
+            trace_backup_skip_cluster(job, end);
             hbitmap_reset(job->copy_bitmap, end, 1);
             job->common.offset += n;
+            finish_cluster_for_notif(job, end);
         }
     }
 
@@ -456,11 +816,11 @@ static void backup_skip_clusters(BackupBlockJob *job,
             continue;
         }
 
+        trace_backup_skip_cluster(job, start);
         hbitmap_reset(job->copy_bitmap, start, 1);
         job->common.offset += job->cluster_size;
+        finish_cluster_for_notif(job, start);
     }
-
-    cow_request_end(&cow_request);
 }
 
 static int backup_skip_unallocated_clusters(BackupBlockJob *job,
@@ -526,29 +886,6 @@ static void backup_skip_loop(BackupBlockJob *job, BlockDriverState *base)
     }
 }
 
-static int coroutine_fn backup_loop(BackupBlockJob *job)
-{
-    int ret;
-    int64_t sectors_per_cluster = cluster_size_sectors(job);
-    int64_t cluster;
-    HBitmapIter hbi;
-
-    hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
-    while ((cluster = hbitmap_iter_next(&hbi)) != -1) {
-        if (yield_and_check(job)) {
-            return 0;
-        }
-
-        ret = backup_do_cow(job, cluster * sectors_per_cluster,
-                            sectors_per_cluster);
-        if (ret < 0) {
-            return ret;
-        }
-    }
-
-    return 0;
-}
-
 /* init copy_bitmap from sync_bitmap */
 static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
 {
@@ -586,50 +923,62 @@ static void coroutine_fn backup_run(void *opaque)
     BackupCompleteData *data;
     BlockDriverState *bs = blk_bs(job->common.blk);
     int64_t end;
-    int ret = 0;
+    int i;
+    bool is_top = job->sync_mode == MIRROR_SYNC_MODE_TOP;
+    bool is_full = job->sync_mode == MIRROR_SYNC_MODE_FULL;
+
+    trace_backup_run();
 
+    qemu_co_queue_init(&job->paused_workers);
     QLIST_INIT(&job->inflight_reqs);
-    qemu_co_rwlock_init(&job->flush_rwlock);
+    QSIMPLEQ_INIT(&job->notifier_reqs);
 
     end = DIV_ROUND_UP(job->common.len, job->cluster_size);
 
     job->copy_bitmap = hbitmap_alloc(end, 0);
+    job->notif_wait_bitmap = bitmap_new(end);
 
     job->before_write.notify = backup_before_write_notify;
     bdrv_add_before_write_notifier(bs, &job->before_write);
 
-    if (job->sync_mode == MIRROR_SYNC_MODE_NONE) {
+    /* init copy_bitmap */
+    if (job->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
+        backup_incremental_init_copy_bitmap(job);
+    } else {
         hbitmap_set(job->copy_bitmap, 0, end);
+    }
+    hbitmap_iter_init(&job->linear_hbi, job->copy_bitmap, 0);
+
+    for (i = 0; i < NB_WORKERS; ++i) {
+        Coroutine *co = qemu_coroutine_create(backup_worker_co, job);
+        qemu_coroutine_enter(co);
+    }
+
+    if (job->sync_mode == MIRROR_SYNC_MODE_NONE) {
         while (!block_job_is_cancelled(&job->common)) {
-            /* Yield until the job is cancelled.  We just let our before_write
-             * notify callback service CoW requests. */
+            /* Yield until the job is cancelled.  We just let backup workers
+             * service CoW requests. */
             block_job_yield(&job->common);
         }
-    } else {
-        if (job->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
-            backup_incremental_init_copy_bitmap(job);
-        } else {
-            /* top or full mode */
-            bool is_top = job->sync_mode == MIRROR_SYNC_MODE_TOP;
-            BlockDriverState *base =
-                    is_top ? backing_bs(blk_bs(job->common.blk)) : NULL;
-            hbitmap_set(job->copy_bitmap, 0, end);
-            if (is_top || bdrv_has_zero_init(blk_bs(job->target))) {
-                backup_skip_loop(job, base);
-            }
-        }
-        ret = backup_loop(job);
+    } else if (is_top || (is_full && bdrv_has_zero_init(blk_bs(job->target)))) {
+        BlockDriverState *base =
+                is_top ? backing_bs(blk_bs(job->common.blk)) : NULL;
+        backup_skip_loop(job, base);
     }
 
+    /* wait for all workers to exit */
+    backup_loop(job);
+
     notifier_with_return_remove(&job->before_write);
 
-    /* wait until pending backup_do_cow() calls have completed */
-    qemu_co_rwlock_wrlock(&job->flush_rwlock);
-    qemu_co_rwlock_unlock(&job->flush_rwlock);
+    /* in case of error or cancel there may be pending notifiers */
+    release_pending_notifiers(job);
+
     hbitmap_free(job->copy_bitmap);
+    g_free(job->notif_wait_bitmap);
 
     data = g_malloc(sizeof(*data));
-    data->ret = ret;
+    data->ret = job->main_error;
     block_job_defer_to_main_loop(&job->common, backup_complete, data);
 }
 
diff --git a/block/trace-events b/block/trace-events
index e7a7372..a55297d 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -40,12 +40,35 @@ mirror_yield_buf_busy(void *s, int nb_chunks, int in_flight) "s %p requested chu
 mirror_break_buf_busy(void *s, int nb_chunks, int in_flight) "s %p requested chunks %d in_flight %d"
 
 # block/backup.c
-backup_do_cow_enter(void *job, int64_t start, int64_t sector_num, int nb_sectors) "job %p start %"PRId64" sector_num %"PRId64" nb_sectors %d"
-backup_do_cow_return(void *job, int64_t sector_num, int nb_sectors, int ret) "job %p sector_num %"PRId64" nb_sectors %d ret %d"
+backup_do_cow_enter(void *job, void *self, int64_t start, int64_t sector_num, int nb_sectors) "job %p self %p start %"PRId64" sector_num %"PRId64" nb_sectors %d"
+backup_do_cow_return(void *job, void *self, int64_t sector_num, int nb_sectors) "job %p self %p sector_num %"PRId64" nb_sectors %d"
 backup_do_cow_skip(void *job, int64_t start) "job %p start %"PRId64
 backup_do_cow_process(void *job, int64_t start) "job %p start %"PRId64
-backup_do_read_fail(void *job, int64_t offset, unsigned bytes, int ret) "job %p offset %"PRId64" bytes %u ret %d"
-backup_do_write_fail(void *job, int64_t offset, unsigned bytes, int ret) "job %p offset %"PRId64" bytes %u ret %d"
+backup_do_read_fail(void *job, void *self, int64_t offset, unsigned bytes, int ret) "job %p self %p offset %"PRId64" bytes %u ret %d"
+backup_do_write_fail(void *job, void *self, int64_t offset, unsigned bytes, int ret) "job %p self %p offset %"PRId64" bytes %u ret %d"
+backup_job_wait_workers_start(void) ""
+backup_job_wait_workers_end(void) ""
+backup_loop_enter(void) ""
+backup_loop_error_exit(void) ""
+backup_loop_sleep_start(void) ""
+backup_loop_sleep_finish(void) ""
+backup_loop_busy_sleep_start(void) ""
+backup_loop_busy_sleep_finish(void) ""
+backup_loop_finish(bool with_err) "with_err: %d"
+backup_run(void) ""
+backup_sleep_delay(bool cancelled, bool pause) "cancelled %d pause %d"
+backup_sleep_zero(bool cancelled, bool pause) "cancelled %d pause %d"
+backup_sleep_finish(void) ""
+backup_worker_pause(void *p, int nb_busy_workers, bool waiting) "co %p nb_busy_workers %d waiting %d"
+backup_worker_unpause(void *p) "co %p"
+backup_worker_stop(void *p, int nb_busy_workers, int running_workers, bool waiting) "co %p nb_busy_workers %d running_workers %d waiting %d"
+backup_worker_got_work(void *job, void *worker, int64_t cluster) "job %p worker %p cluster %ld"
+backup_before_write_notify_skip(void *job, int64_t offset, int64_t bytes) "job %p offset %"PRId64" bytes %"PRId64
+backup_before_write_notify_start(void *job, int64_t offset, int64_t bytes, void *nr, int64_t start, int64_t end, int nb_wait) "job %p offset %"PRId64" bytes %"PRId64" notif %p start %"PRId64" end %"PRId64" nb_wait %d"
+backup_before_write_notify_timeout(void *job, void *nr, int64_t start, int64_t end, int nb_wait) "job %p notif %p start %"PRId64" end %"PRId64" nb_wait %d"
+backup_before_write_notify_success(void *job, void *nr, int64_t start, int64_t end, int nb_wait) "job %p notif %p start %"PRId64" end %"PRId64" nb_wait %d"
+backup_skip_cluster(void *job, int64_t cluster) "job %p cluster %"PRId64
+backup_finish_cluster_for_notif(void *job, int64_t cluster) "job %p cluster %"PRId64
 
 # blockdev.c
 qmp_block_job_cancel(void *job) "job %p"
diff --git a/blockjob.c b/blockjob.c
index 513620c..1f384c6 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -407,7 +407,7 @@ void block_job_user_pause(BlockJob *job)
     block_job_pause(job);
 }
 
-static bool block_job_should_pause(BlockJob *job)
+bool block_job_should_pause(BlockJob *job)
 {
     return job->pause_count > 0;
 }
@@ -666,6 +666,33 @@ void block_job_event_ready(BlockJob *job)
                                     job->speed, &error_abort);
 }
 
+BlockErrorAction block_job_get_error_action(BlockJob *job,
+                                            BlockdevOnError on_err, int error)
+{
+    BlockErrorAction action;
+
+    switch (on_err) {
+    case BLOCKDEV_ON_ERROR_ENOSPC:
+    case BLOCKDEV_ON_ERROR_AUTO:
+        action = (error == ENOSPC) ?
+                 BLOCK_ERROR_ACTION_STOP : BLOCK_ERROR_ACTION_REPORT;
+        break;
+    case BLOCKDEV_ON_ERROR_STOP:
+        action = BLOCK_ERROR_ACTION_STOP;
+        break;
+    case BLOCKDEV_ON_ERROR_REPORT:
+        action = BLOCK_ERROR_ACTION_REPORT;
+        break;
+    case BLOCKDEV_ON_ERROR_IGNORE:
+        action = BLOCK_ERROR_ACTION_IGNORE;
+        break;
+    default:
+        abort();
+    }
+
+    return action;
+}
+
 BlockErrorAction block_job_error_action(BlockJob *job, BlockdevOnError on_err,
                                         int is_read, int error)
 {
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 1acb256..7d24cf6 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -248,6 +248,15 @@ void block_job_user_pause(BlockJob *job);
 bool block_job_user_paused(BlockJob *job);
 
 /**
+ * block_job_should_pause:
+ * @job: The job being queried.
+ *
+ * Returns whether the job is currently paused, or will pause
+ * as soon as it reaches a sleeping point.
+ */
+bool block_job_should_pause(BlockJob *job);
+
+/**
  * block_job_resume:
  * @job: The job to be resumed.
  *
@@ -309,7 +318,11 @@ int block_job_complete_sync(BlockJob *job, Error **errp);
  */
 void block_job_iostatus_reset(BlockJob *job);
 
-/**
+
+BlockErrorAction block_job_get_error_action(BlockJob *job,
+                                            BlockdevOnError on_err, int error);
+
+/*
  * block_job_txn_new:
  *
  * Allocate and return a new block job transaction.  Jobs can be added to the
diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
index 388b7b2..e15905f 100755
--- a/tests/qemu-iotests/055
+++ b/tests/qemu-iotests/055
@@ -553,4 +553,4 @@ class TestDriveCompression(iotests.QMPTestCase):
             self.do_test_compress_pause('blockdev-backup', format, target='drive1')
 
 if __name__ == '__main__':
-    iotests.main(supported_fmts=['raw', 'qcow2'])
+    iotests.main(supported_fmts=['raw', 'qcow2'], supported_cache_modes=['none'])
diff --git a/tests/qemu-iotests/129 b/tests/qemu-iotests/129
index 9e87e1c..3d5e137 100644
--- a/tests/qemu-iotests/129
+++ b/tests/qemu-iotests/129
@@ -66,8 +66,10 @@ class TestStopWithBlockJob(iotests.QMPTestCase):
         result = self.vm.qmp("stop")
         self.assert_qmp(result, 'return', {})
         result = self.vm.qmp("query-block-jobs")
-        self.assert_qmp(result, 'return[0]/busy', True)
-        self.assert_qmp(result, 'return[0]/ready', False)
+        if result['return']:
+            # make additional check if block job is not released yet
+            self.assert_qmp(result, 'return[0]/busy', True)
+            self.assert_qmp(result, 'return[0]/ready', False)
 
     def test_drive_mirror(self):
         self.do_test_stop("drive-mirror", device="drive0",
-- 
1.8.3.1
