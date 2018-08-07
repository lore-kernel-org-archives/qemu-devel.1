Received: from eggs.gnu.org ([2001:4830:134:3::10]:42939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fn60u-0007Tk-6Q
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 13:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fn60r-00021P-50
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 13:43:20 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  7 Aug 2018 20:43:08 +0300
Message-Id: <20180807174311.32454-5-vsementsov@virtuozzo.com>
In-Reply-To: <20180807174311.32454-1-vsementsov@virtuozzo.com>
References: <20180807174311.32454-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 4/7] qcow2: async scheme for qcow2_co_preadv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Start several async requests instead of read chunk by chunk.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c | 208 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 204 insertions(+), 4 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 5e7f2ee318..a0df8d4e50 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1869,6 +1869,197 @@ out:
     return ret;
 }
 
+typedef struct Qcow2WorkerTask {
+    uint64_t file_cluster_offset;
+    uint64_t offset;
+    uint64_t bytes;
+    uint64_t bytes_done;
+} Qcow2WorkerTask;
+
+typedef int (*Qcow2DoWorkFunc)(BlockDriverState *bs, QEMUIOVector *qiov,
+                               Qcow2WorkerTask *task);
+
+typedef struct Qcow2RWState {
+    BlockDriverState *bs;
+    QEMUIOVector *qiov;
+    uint64_t bytes;
+    int ret;
+    bool waiting_one;
+    bool waiting_all;
+    bool finalize;
+    Coroutine *co;
+    QSIMPLEQ_HEAD(, Qcow2Worker) free_workers;
+    QSIMPLEQ_HEAD(, Qcow2Worker) busy_workers;
+    int online_workers;
+    Qcow2DoWorkFunc do_work_func;
+} Qcow2RWState;
+
+typedef struct Qcow2Worker {
+    Qcow2RWState *rws;
+    Coroutine *co;
+    Qcow2WorkerTask task;
+    bool busy;
+    QSIMPLEQ_ENTRY(Qcow2Worker) entry;
+} Qcow2Worker;
+#define QCOW2_MAX_WORKERS 64
+
+static coroutine_fn void qcow2_rw_worker(void *opaque);
+static Qcow2Worker *qcow2_new_worker(Qcow2RWState *rws)
+{
+    Qcow2Worker *w = g_new0(Qcow2Worker, 1);
+    w->rws = rws;
+    w->co = qemu_coroutine_create(qcow2_rw_worker, w);
+
+    return w;
+}
+
+static void qcow2_free_worker(Qcow2Worker *w)
+{
+    g_free(w);
+}
+
+static coroutine_fn void qcow2_rw_worker(void *opaque)
+{
+    Qcow2Worker *w = opaque;
+    Qcow2RWState *rws = w->rws;
+
+    rws->online_workers++;
+
+    while (!rws->finalize) {
+        int ret = rws->do_work_func(rws->bs, rws->qiov, &w->task);
+        if (ret < 0 && rws->ret == 0) {
+            rws->ret = ret;
+        }
+
+        if (rws->waiting_all || rws->ret < 0) {
+            break;
+        }
+
+        w->busy = false;
+        QSIMPLEQ_REMOVE(&rws->busy_workers, w, Qcow2Worker, entry);
+        QSIMPLEQ_INSERT_TAIL(&rws->free_workers, w, entry);
+        if (rws->waiting_one) {
+            rws->waiting_one = false;
+            /* we must unset it here, to prevent queuing rws->co in several
+             * workers (it may happen if other worker already waits us on mutex,
+             * so it will be entered after our yield and before rws->co enter)
+             *
+             * TODO: rethink this comment, as here (and in other places in the
+             * file) we moved from qemu_coroutine_add_next to aio_co_wake.
+             */
+            aio_co_wake(rws->co);
+        }
+
+        qemu_coroutine_yield();
+    }
+
+    if (w->busy) {
+        w->busy = false;
+        QSIMPLEQ_REMOVE(&rws->busy_workers, w, Qcow2Worker, entry);
+    }
+    qcow2_free_worker(w);
+    rws->online_workers--;
+
+    if (rws->waiting_all && rws->online_workers == 0) {
+        aio_co_wake(rws->co);
+    }
+}
+
+static coroutine_fn void qcow2_rws_add_task(Qcow2RWState *rws,
+                                            uint64_t file_cluster_offset,
+                                            uint64_t offset,
+                                            uint64_t bytes,
+                                            uint64_t bytes_done)
+{
+    Qcow2Worker *w;
+
+    assert(rws->co == qemu_coroutine_self());
+
+    if (bytes_done == 0 && bytes == rws->bytes) {
+        Qcow2WorkerTask task = {
+            .file_cluster_offset = file_cluster_offset,
+            .offset = offset,
+            .bytes = bytes,
+            .bytes_done = bytes_done
+        };
+        rws->ret = rws->do_work_func(rws->bs, rws->qiov, &task);
+        return;
+    }
+
+    if (!QSIMPLEQ_EMPTY(&rws->free_workers)) {
+        w = QSIMPLEQ_FIRST(&rws->free_workers);
+        QSIMPLEQ_REMOVE_HEAD(&rws->free_workers, entry);
+    } else if (rws->online_workers < QCOW2_MAX_WORKERS) {
+        w = qcow2_new_worker(rws);
+    } else {
+        rws->waiting_one = true;
+        qemu_coroutine_yield();
+        assert(!rws->waiting_one); /* already unset by worker */
+
+        w = QSIMPLEQ_FIRST(&rws->free_workers);
+        QSIMPLEQ_REMOVE_HEAD(&rws->free_workers, entry);
+    }
+    w->busy = true;
+    QSIMPLEQ_INSERT_TAIL(&rws->busy_workers, w, entry);
+
+    w->task.file_cluster_offset = file_cluster_offset;
+    w->task.offset = offset;
+    w->task.bytes = bytes;
+    w->task.bytes_done = bytes_done;
+
+    qemu_coroutine_enter(w->co);
+}
+
+static void qcow2_init_rws(Qcow2RWState *rws, BlockDriverState *bs,
+                           QEMUIOVector *qiov, uint64_t bytes,
+                           Qcow2DoWorkFunc do_work_func)
+{
+    memset(rws, 0, sizeof(*rws));
+    rws->bs = bs;
+    rws->qiov = qiov;
+    rws->bytes = bytes;
+    rws->co = qemu_coroutine_self();
+    rws->do_work_func = do_work_func;
+    QSIMPLEQ_INIT(&rws->free_workers);
+    QSIMPLEQ_INIT(&rws->busy_workers);
+}
+
+static void qcow2_finalize_rws(Qcow2RWState *rws)
+{
+    assert(rws->co == qemu_coroutine_self());
+
+    /* kill waiting workers */
+    rws->finalize = true;
+    while (!QSIMPLEQ_EMPTY(&rws->free_workers)) {
+        Qcow2Worker *w = QSIMPLEQ_FIRST(&rws->free_workers);
+        QSIMPLEQ_REMOVE_HEAD(&rws->free_workers, entry);
+        qemu_coroutine_enter(w->co);
+    }
+
+    /* wait others */
+    if (rws->online_workers > 0) {
+        rws->waiting_all = true;
+        qemu_coroutine_yield();
+        rws->waiting_all = false;
+    }
+
+    assert(rws->online_workers == 0);
+    assert(QSIMPLEQ_EMPTY(&rws->free_workers));
+    assert(QSIMPLEQ_EMPTY(&rws->busy_workers));
+}
+
+static coroutine_fn int qcow2_co_preadv_normal_task(BlockDriverState *bs,
+                                                    QEMUIOVector *qiov,
+                                                    Qcow2WorkerTask *task)
+{
+    return qcow2_co_preadv_normal(bs,
+                                  task->file_cluster_offset,
+                                  task->offset,
+                                  task->bytes,
+                                  qiov,
+                                  task->bytes_done);
+}
+
 static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
                                         uint64_t bytes, QEMUIOVector *qiov,
                                         int flags)
@@ -1880,12 +2071,15 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
     uint64_t cluster_offset = 0;
     uint64_t bytes_done = 0;
     QEMUIOVector hd_qiov;
+    Qcow2RWState rws = {0};
+
+    qcow2_init_rws(&rws, bs, qiov, bytes, qcow2_co_preadv_normal_task);
 
     qemu_iovec_init(&hd_qiov, qiov->niov);
 
     qemu_co_mutex_lock(&s->lock);
 
-    while (bytes != 0) {
+    while (bytes != 0 && rws.ret == 0) {
 
         /* prepare next request */
         cur_bytes = MIN(bytes, INT_MAX);
@@ -1942,9 +2136,10 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
         case QCOW2_CLUSTER_NORMAL:
             qemu_co_mutex_unlock(&s->lock);
 
-            ret = qcow2_co_preadv_normal(bs, cluster_offset,
-                                         offset, cur_bytes, qiov, bytes_done);
-            if (ret < 0) {
+            qcow2_rws_add_task(&rws, cluster_offset, offset, cur_bytes,
+                               bytes_done);
+            if (rws.ret < 0) {
+                ret = rws.ret;
                 goto fail_nolock;
             }
 
@@ -1967,6 +2162,11 @@ fail:
     qemu_co_mutex_unlock(&s->lock);
 
 fail_nolock:
+    qcow2_finalize_rws(&rws);
+    if (ret == 0) {
+        ret = rws.ret;
+    }
+
     qemu_iovec_destroy(&hd_qiov);
 
     return ret;
-- 
2.11.1
