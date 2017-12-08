Received: from eggs.gnu.org ([2001:4830:134:3::10]:47610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eNGKC-000153-KT
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:56:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eNGKB-0001nM-NI
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:56:12 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:41262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eNGKB-0001n9-Gg
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:56:11 -0500
Received: by mail-wm0-x241.google.com with SMTP id g75so2682490wme.0
	for <qemu-devel@nongnu.org>; Fri, 08 Dec 2017 02:56:11 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  8 Dec 2017 11:55:53 +0100
Message-Id: <20171208105553.12249-6-pbonzini@redhat.com>
In-Reply-To: <20171208105553.12249-1-pbonzini@redhat.com>
References: <20171208105553.12249-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] thread-pool: convert to use lock guards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G . Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/thread-pool.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/util/thread-pool.c b/util/thread-pool.c
index 610646d131..06ada38376 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -78,7 +78,7 @@ static void *worker_thread(void *opaque)
 {
     ThreadPool *pool = opaque;
 
-    qemu_mutex_lock(&pool->lock);
+    QEMU_LOCK_GUARD(QemuMutex, pool_guard, &pool->lock);
     pool->pending_threads--;
     do_spawn_thread(pool);
 
@@ -88,9 +88,9 @@ static void *worker_thread(void *opaque)
 
         do {
             pool->idle_threads++;
-            qemu_mutex_unlock(&pool->lock);
+            qemu_lock_guard_unlock(&pool_guard);
             ret = qemu_sem_timedwait(&pool->sem, 10000);
-            qemu_mutex_lock(&pool->lock);
+            qemu_lock_guard_lock(&pool_guard);
             pool->idle_threads--;
         } while (ret == -1 && !QTAILQ_EMPTY(&pool->request_list));
         if (ret == -1 || pool->stopping) {
@@ -100,7 +100,7 @@ static void *worker_thread(void *opaque)
         req = QTAILQ_FIRST(&pool->request_list);
         QTAILQ_REMOVE(&pool->request_list, req, reqs);
         req->state = THREAD_ACTIVE;
-        qemu_mutex_unlock(&pool->lock);
+        qemu_lock_guard_unlock(&pool_guard);
 
         ret = req->func(req->arg);
 
@@ -109,14 +109,13 @@ static void *worker_thread(void *opaque)
         smp_wmb();
         req->state = THREAD_DONE;
 
-        qemu_mutex_lock(&pool->lock);
+        qemu_lock_guard_lock(&pool_guard);
 
         qemu_bh_schedule(pool->completion_bh);
     }
 
     pool->cur_threads--;
     qemu_cond_signal(&pool->worker_stopped);
-    qemu_mutex_unlock(&pool->lock);
     return NULL;
 }
 
@@ -139,9 +138,8 @@ static void spawn_thread_bh_fn(void *opaque)
 {
     ThreadPool *pool = opaque;
 
-    qemu_mutex_lock(&pool->lock);
+    QEMU_LOCK_GUARD(QemuMutex, pool_guard, &pool->lock);
     do_spawn_thread(pool);
-    qemu_mutex_unlock(&pool->lock);
 }
 
 static void spawn_thread(ThreadPool *pool)
@@ -208,10 +206,10 @@ static void thread_pool_cancel(BlockAIOCB *acb)
 {
     ThreadPoolElement *elem = (ThreadPoolElement *)acb;
     ThreadPool *pool = elem->pool;
+    QEMU_LOCK_GUARD(QemuMutex, pool_guard, &pool->lock);
 
     trace_thread_pool_cancel(elem, elem->common.opaque);
 
-    qemu_mutex_lock(&pool->lock);
     if (elem->state == THREAD_QUEUED &&
         /* No thread has yet started working on elem. we can try to "steal"
          * the item from the worker if we can get a signal from the
@@ -225,8 +223,6 @@ static void thread_pool_cancel(BlockAIOCB *acb)
         elem->state = THREAD_DONE;
         elem->ret = -ECANCELED;
     }
-
-    qemu_mutex_unlock(&pool->lock);
 }
 
 static AioContext *thread_pool_get_aio_context(BlockAIOCB *acb)
@@ -258,12 +254,12 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPool *pool,
 
     trace_thread_pool_submit(pool, req, arg);
 
-    qemu_mutex_lock(&pool->lock);
+    QEMU_LOCK_GUARD(QemuMutex, pool_guard, &pool->lock);
     if (pool->idle_threads == 0 && pool->cur_threads < pool->max_threads) {
         spawn_thread(pool);
     }
     QTAILQ_INSERT_TAIL(&pool->request_list, req, reqs);
-    qemu_mutex_unlock(&pool->lock);
+    qemu_lock_guard_unlock(&pool_guard);
     qemu_sem_post(&pool->sem);
     return &req->common;
 }
@@ -330,7 +326,7 @@ void thread_pool_free(ThreadPool *pool)
 
     assert(QLIST_EMPTY(&pool->head));
 
-    qemu_mutex_lock(&pool->lock);
+    QEMU_LOCK_GUARD(QemuMutex, pool_guard, &pool->lock);
 
     /* Stop new threads from spawning */
     qemu_bh_delete(pool->new_thread_bh);
@@ -344,7 +340,7 @@ void thread_pool_free(ThreadPool *pool)
         qemu_cond_wait(&pool->worker_stopped, &pool->lock);
     }
 
-    qemu_mutex_unlock(&pool->lock);
+    qemu_lock_guard_unlock(&pool_guard);
 
     qemu_bh_delete(pool->completion_bh);
     qemu_sem_destroy(&pool->sem);
-- 
2.14.3
