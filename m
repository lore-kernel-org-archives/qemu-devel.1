Received: from eggs.gnu.org ([2001:4830:134:3::10]:38911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cg94c-0007Sj-LY
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:57:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cg94b-0005YR-Jh
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:57:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cg94b-0005YI-A7
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:57:37 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 21 Feb 2017 11:56:43 +0000
Message-Id: <20170221115644.28264-24-stefanha@redhat.com>
In-Reply-To: <20170221115644.28264-1-stefanha@redhat.com>
References: <20170221115644.28264-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL v2 23/24] coroutine-lock: add mutex argument to
 CoQueue APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

All that CoQueue needs in order to become thread-safe is help
from an external mutex.  Add this to the API.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-id: 20170213181244.16297-6-pbonzini@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qemu/coroutine.h   |  8 +++++---
 block/backup.c             |  2 +-
 block/io.c                 |  4 ++--
 block/nbd-client.c         |  2 +-
 block/qcow2-cluster.c      |  4 +---
 block/sheepdog.c           |  2 +-
 block/throttle-groups.c    |  2 +-
 hw/9pfs/9p.c               |  2 +-
 util/qemu-coroutine-lock.c | 24 +++++++++++++++++++++---
 9 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index 9f68579..d2de268 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -160,7 +160,8 @@ void coroutine_fn qemu_co_mutex_unlock(CoMutex *mutex);
 
 /**
  * CoQueues are a mechanism to queue coroutines in order to continue executing
- * them later.
+ * them later.  They are similar to condition variables, but they need help
+ * from an external mutex in order to maintain thread-safety.
  */
 typedef struct CoQueue {
     QSIMPLEQ_HEAD(, Coroutine) entries;
@@ -174,9 +175,10 @@ void qemu_co_queue_init(CoQueue *queue);
 
 /**
  * Adds the current coroutine to the CoQueue and transfers control to the
- * caller of the coroutine.
+ * caller of the coroutine.  The mutex is unlocked during the wait and
+ * locked again afterwards.
  */
-void coroutine_fn qemu_co_queue_wait(CoQueue *queue);
+void coroutine_fn qemu_co_queue_wait(CoQueue *queue, CoMutex *mutex);
 
 /**
  * Restarts the next coroutine in the CoQueue and removes it from the queue.
diff --git a/block/backup.c b/block/backup.c
index ea38733..fe010e7 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -64,7 +64,7 @@ static void coroutine_fn wait_for_overlapping_requests(BackupBlockJob *job,
         retry = false;
         QLIST_FOREACH(req, &job->inflight_reqs, list) {
             if (end > req->start && start < req->end) {
-                qemu_co_queue_wait(&req->wait_queue);
+                qemu_co_queue_wait(&req->wait_queue, NULL);
                 retry = true;
                 break;
             }
diff --git a/block/io.c b/block/io.c
index a5c7d36..d5c4544 100644
--- a/block/io.c
+++ b/block/io.c
@@ -539,7 +539,7 @@ static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
                  * (instead of producing a deadlock in the former case). */
                 if (!req->waiting_for) {
                     self->waiting_for = req;
-                    qemu_co_queue_wait(&req->wait_queue);
+                    qemu_co_queue_wait(&req->wait_queue, NULL);
                     self->waiting_for = NULL;
                     retry = true;
                     waited = true;
@@ -2275,7 +2275,7 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
 
     /* Wait until any previous flushes are completed */
     while (bs->active_flush_req) {
-        qemu_co_queue_wait(&bs->flush_queue);
+        qemu_co_queue_wait(&bs->flush_queue, NULL);
     }
 
     bs->active_flush_req = true;
diff --git a/block/nbd-client.c b/block/nbd-client.c
index 10fcc9e..0dc12c2 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -182,7 +182,7 @@ static void nbd_coroutine_start(NBDClientSession *s,
     /* Poor man semaphore.  The free_sema is locked when no other request
      * can be accepted, and unlocked after receiving one reply.  */
     if (s->in_flight == MAX_NBD_REQUESTS) {
-        qemu_co_queue_wait(&s->free_sema);
+        qemu_co_queue_wait(&s->free_sema, NULL);
         assert(s->in_flight < MAX_NBD_REQUESTS);
     }
     s->in_flight++;
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 928c1e2..78c11d4 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -932,9 +932,7 @@ static int handle_dependencies(BlockDriverState *bs, uint64_t guest_offset,
             if (bytes == 0) {
                 /* Wait for the dependency to complete. We need to recheck
                  * the free/allocated clusters when we continue. */
-                qemu_co_mutex_unlock(&s->lock);
-                qemu_co_queue_wait(&old_alloc->dependent_requests);
-                qemu_co_mutex_lock(&s->lock);
+                qemu_co_queue_wait(&old_alloc->dependent_requests, &s->lock);
                 return -EAGAIN;
             }
         }
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 32c4e4c..860ba61 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -486,7 +486,7 @@ static void wait_for_overlapping_aiocb(BDRVSheepdogState *s, SheepdogAIOCB *acb)
 retry:
     QLIST_FOREACH(cb, &s->inflight_aiocb_head, aiocb_siblings) {
         if (AIOCBOverlapping(acb, cb)) {
-            qemu_co_queue_wait(&s->overlapping_queue);
+            qemu_co_queue_wait(&s->overlapping_queue, NULL);
             goto retry;
         }
     }
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index aade5de..b73e7a8 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -326,7 +326,7 @@ void coroutine_fn throttle_group_co_io_limits_intercept(BlockBackend *blk,
     if (must_wait || blkp->pending_reqs[is_write]) {
         blkp->pending_reqs[is_write]++;
         qemu_mutex_unlock(&tg->lock);
-        qemu_co_queue_wait(&blkp->throttled_reqs[is_write]);
+        qemu_co_queue_wait(&blkp->throttled_reqs[is_write], NULL);
         qemu_mutex_lock(&tg->lock);
         blkp->pending_reqs[is_write]--;
     }
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 99e9472..3af1c93 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2374,7 +2374,7 @@ static void coroutine_fn v9fs_flush(void *opaque)
         /*
          * Wait for pdu to complete.
          */
-        qemu_co_queue_wait(&cancel_pdu->complete);
+        qemu_co_queue_wait(&cancel_pdu->complete, NULL);
         cancel_pdu->cancelled = 0;
         pdu_free(cancel_pdu);
     }
diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
index 73fe77c..b0a554f 100644
--- a/util/qemu-coroutine-lock.c
+++ b/util/qemu-coroutine-lock.c
@@ -40,12 +40,30 @@ void qemu_co_queue_init(CoQueue *queue)
     QSIMPLEQ_INIT(&queue->entries);
 }
 
-void coroutine_fn qemu_co_queue_wait(CoQueue *queue)
+void coroutine_fn qemu_co_queue_wait(CoQueue *queue, CoMutex *mutex)
 {
     Coroutine *self = qemu_coroutine_self();
     QSIMPLEQ_INSERT_TAIL(&queue->entries, self, co_queue_next);
+
+    if (mutex) {
+        qemu_co_mutex_unlock(mutex);
+    }
+
+    /* There is no race condition here.  Other threads will call
+     * aio_co_schedule on our AioContext, which can reenter this
+     * coroutine but only after this yield and after the main loop
+     * has gone through the next iteration.
+     */
     qemu_coroutine_yield();
     assert(qemu_in_coroutine());
+
+    /* TODO: OSv implements wait morphing here, where the wakeup
+     * primitive automatically places the woken coroutine on the
+     * mutex's queue.  This avoids the thundering herd effect.
+     */
+    if (mutex) {
+        qemu_co_mutex_lock(mutex);
+    }
 }
 
 /**
@@ -335,7 +353,7 @@ void qemu_co_rwlock_rdlock(CoRwlock *lock)
     Coroutine *self = qemu_coroutine_self();
 
     while (lock->writer) {
-        qemu_co_queue_wait(&lock->queue);
+        qemu_co_queue_wait(&lock->queue, NULL);
     }
     lock->reader++;
     self->locks_held++;
@@ -365,7 +383,7 @@ void qemu_co_rwlock_wrlock(CoRwlock *lock)
     Coroutine *self = qemu_coroutine_self();
 
     while (lock->writer || lock->reader) {
-        qemu_co_queue_wait(&lock->queue);
+        qemu_co_queue_wait(&lock->queue, NULL);
     }
     lock->writer = true;
     self->locks_held++;
-- 
2.9.3
