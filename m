Received: from eggs.gnu.org ([2001:4830:134:3::10]:59303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZx4S-0000n4-M1
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:00:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZx4O-0001i9-Pj
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:00:24 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:44739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eZx4O-0001Z9-HI
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:00:20 -0500
Received: by mail-wm0-f66.google.com with SMTP id t8so11206965wmc.3
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:00:14 -0800 (PST)
References: <20180112085555.14447-1-famz@redhat.com>
	<20180112085555.14447-4-famz@redhat.com>
	<20180112094429.GA7356@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <65840314-770e-df2b-a6a7-7508b4600d49@redhat.com>
Date: Fri, 12 Jan 2018 12:00:10 +0100
MIME-Version: 1.0
In-Reply-To: <20180112094429.GA7356@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 3/9] block: Add VFIO based
 NVMe driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>, alex.williamson@redhat.com, Karl Rister <krister@redhat.com>

On 12/01/2018 10:44, Stefan Hajnoczi wrote:
>> +    if (progress) {
>> +        /* Notify the device so it can post more completions. */
>> +        smp_mb_release();
>> +        *q->cq.doorbell = cpu_to_le32(q->cq.head);
>> +        if (!qemu_co_queue_empty(&q->free_req_queue)) {
>> +            aio_bh_schedule_oneshot(s->aio_context, nvme_free_req_queue_cb, q);
>> +        }
> This is not thread-safe because the queue producer does:
> 
> 1   qemu_mutex_unlock(&q->lock);
> 2   qemu_co_queue_wait(&q->free_req_queue, NULL);
> 3   qemu_mutex_lock(&q->lock);
> 
> We fail to call nvme_free_req_queue_cb() when if
> (!qemu_co_queue_empty(&q->free_req_queue)) runs after 1 but before 2.

Yes, it can happen.  The right solution would be to do like block/curl.c 
(which has more or less the same scenario):

    next = QSIMPLEQ_FIRST(&s->s->free_state_waitq);
    if (next) {
        QSIMPLEQ_REMOVE_HEAD(&s->s->free_state_waitq, next);
        qemu_mutex_unlock(&s->s->mutex);
        aio_co_wake(next->co);
        qemu_mutex_lock(&s->s->mutex);
    }

(where the "if" would be here, and the QSIMPLEQ_REMOVE_HEAD in 
nvme_free_req_queue_cb; by the way, nvme_free_req_queue_cb also needs to 
take q->lock).

I think we should have a variant of CoQueue that uses a QemuMutex.  Of 
course in C you have to choose between code duplication, lack of 
type-safety, or ugly code, while in C++ it would be an easy application 
of templates.  But maybe something like this (with QemuTypedMutex moved 
to another header file) is acceptable:

diff --git a/block/curl.c b/block/curl.c
index 35cf417..cd578d3 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -101,8 +101,6 @@ typedef struct CURLAIOCB {
 
     size_t start;
     size_t end;
-
-    QSIMPLEQ_ENTRY(CURLAIOCB) next;
 } CURLAIOCB;
 
 typedef struct CURLSocket {
@@ -138,7 +136,7 @@ typedef struct BDRVCURLState {
     bool accept_range;
     AioContext *aio_context;
     QemuMutex mutex;
-    QSIMPLEQ_HEAD(, CURLAIOCB) free_state_waitq;
+    CoQueue free_state_waitq;
     char *username;
     char *password;
     char *proxyusername;
@@ -538,7 +536,6 @@ static int curl_init_state(BDRVCURLState *s, CURLState *state)
 /* Called with s->mutex held.  */
 static void curl_clean_state(CURLState *s)
 {
-    CURLAIOCB *next;
     int j;
     for (j = 0; j < CURL_NUM_ACB; j++) {
         assert(!s->acb[j]);
@@ -556,13 +553,7 @@ static void curl_clean_state(CURLState *s)
 
     s->in_use = 0;
 
-    next = QSIMPLEQ_FIRST(&s->s->free_state_waitq);
-    if (next) {
-        QSIMPLEQ_REMOVE_HEAD(&s->s->free_state_waitq, next);
-        qemu_mutex_unlock(&s->s->mutex);
-        aio_co_wake(next->co);
-        qemu_mutex_lock(&s->s->mutex);
-    }
+    qemu_co_enter_next(&s->s->free_state_waitq, &s->s->mutex);
 }
 
 static void curl_parse_filename(const char *filename, QDict *options,
@@ -784,7 +775,7 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     DPRINTF("CURL: Opening %s\n", file);
-    QSIMPLEQ_INIT(&s->free_state_waitq);
+    qemu_co_queue_init(&s->free_state_waitq);
     s->aio_context = bdrv_get_aio_context(bs);
     s->url = g_strdup(file);
     qemu_mutex_lock(&s->mutex);
@@ -888,10 +879,7 @@ static void curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
         if (state) {
             break;
         }
-        QSIMPLEQ_INSERT_TAIL(&s->free_state_waitq, acb, next);
-        qemu_mutex_unlock(&s->mutex);
-        qemu_coroutine_yield();
-        qemu_mutex_lock(&s->mutex);
+        qemu_co_queue_wait(&s->free_state_waitq, &s->mutex);
     }
 
     if (curl_init_state(s, state) < 0) {
diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
index 49eebb5..1dc07fb 100644
--- a/fsdev/qemu-fsdev-throttle.c
+++ b/fsdev/qemu-fsdev-throttle.c
@@ -20,13 +20,13 @@
 static void fsdev_throttle_read_timer_cb(void *opaque)
 {
     FsThrottle *fst = opaque;
-    qemu_co_enter_next(&fst->throttled_reqs[false]);
+    qemu_co_enter_next(&fst->throttled_reqs[false], NULL);
 }
 
 static void fsdev_throttle_write_timer_cb(void *opaque)
 {
     FsThrottle *fst = opaque;
-    qemu_co_enter_next(&fst->throttled_reqs[true]);
+    qemu_co_enter_next(&fst->throttled_reqs[true], NULL);
 }
 
 void fsdev_throttle_parse_opts(QemuOpts *opts, FsThrottle *fst, Error **errp)
diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index ce2eb73..ec2831a 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -178,15 +178,46 @@ typedef struct CoQueue {
  */
 void qemu_co_queue_init(CoQueue *queue);
 
+typedef struct QemuTypedMutex {
+    void *mutex;
+    void (*lock)(void *);
+    void (*unlock)(void *);
+} QemuTypedMutex;
+
+extern void *qemu_unknown_mutex_type(void *);
+#define QEMU_LOCK_FUNC(mutex)                                                       \
+   ((void (*)(void *))                                                              \
+     __builtin_choose_expr(                                                         \
+        __builtin_types_compatible_p(typeof(mutex), QemuMutex *), qemu_mutex_lock,  \
+     __builtin_choose_expr(                                                         \
+        __builtin_types_compatible_p(typeof(mutex), CoMutex *), qemu_co_mutex_lock, \
+        (mutex) ? qemu_unknown_mutex_type : NULL)))
+
+#define QEMU_UNLOCK_FUNC(mutex)                                                       \
+   ((void (*)(void *))                                                                \
+     __builtin_choose_expr(                                                           \
+        __builtin_types_compatible_p(typeof(mutex), QemuMutex *), qemu_mutex_unlock,  \
+     __builtin_choose_expr(                                                           \
+        __builtin_types_compatible_p(typeof(mutex), CoMutex *), qemu_co_mutex_unlock, \
+        (mutex) ? qemu_unknown_mutex_type : NULL)))
+
+#define QEMU_TYPED_MUTEX(mutex)                                                     \
+    ((QemuTypedMutex) { mutex, QEMU_LOCK_FUNC(mutex), QEMU_UNLOCK_FUNC(mutex) })
+
+
 /**
  * Adds the current coroutine to the CoQueue and transfers control to the
  * caller of the coroutine.  The mutex is unlocked during the wait and
  * locked again afterwards.
  */
-void coroutine_fn qemu_co_queue_wait(CoQueue *queue, CoMutex *mutex);
+void coroutine_fn qemu_co_queue_wait_impl(CoQueue *queue, QemuTypedMutex mutex);
+
+#define qemu_co_queue_wait(queue, mutex)                                            \
+	qemu_co_queue_wait_impl(queue, QEMU_TYPED_MUTEX(mutex))
 
 /**
  * Restarts the next coroutine in the CoQueue and removes it from the queue.
+ * The mutex passed to qemu_co_queue_wait must be taken.
  *
  * Returns true if a coroutine was restarted, false if the queue is empty.
  */
@@ -198,9 +229,15 @@ bool coroutine_fn qemu_co_queue_next(CoQueue *queue);
 void coroutine_fn qemu_co_queue_restart_all(CoQueue *queue);
 
 /**
- * Enter the next coroutine in the queue
+ * Enter the next coroutine in the queue.
+ * The mutex passed to qemu_co_queue_wait must be taken.
+ *
+ * Returns true if a coroutine was restarted, false if the queue is empty.
  */
-bool qemu_co_enter_next(CoQueue *queue);
+bool qemu_co_enter_next_impl(CoQueue *queue, QemuTypedMutex mutex);
+
+#define qemu_co_enter_next(queue, mutex)                                            \
+	qemu_co_enter_next_impl(queue, QEMU_TYPED_MUTEX(mutex))
 
 /**
  * Checks if the CoQueue is empty.
diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
index 846ff91..f6bf952 100644
--- a/util/qemu-coroutine-lock.c
+++ b/util/qemu-coroutine-lock.c
@@ -40,13 +40,13 @@ void qemu_co_queue_init(CoQueue *queue)
     QSIMPLEQ_INIT(&queue->entries);
 }
 
-void coroutine_fn qemu_co_queue_wait(CoQueue *queue, CoMutex *mutex)
+void coroutine_fn qemu_co_queue_wait_impl(CoQueue *queue, QemuTypedMutex mutex)
 {
     Coroutine *self = qemu_coroutine_self();
     QSIMPLEQ_INSERT_TAIL(&queue->entries, self, co_queue_next);
 
-    if (mutex) {
-        qemu_co_mutex_unlock(mutex);
+    if (mutex.mutex) {
+        mutex.unlock(mutex.mutex);
     }
 
     /* There is no race condition here.  Other threads will call
@@ -61,8 +61,8 @@ void coroutine_fn qemu_co_queue_wait(CoQueue *queue, CoMutex *mutex)
      * primitive automatically places the woken coroutine on the
      * mutex's queue.  This avoids the thundering herd effect.
      */
-    if (mutex) {
-        qemu_co_mutex_lock(mutex);
+    if (mutex.mutex) {
+        mutex.lock(mutex.mutex);
     }
 }
 
@@ -130,7 +130,7 @@ void coroutine_fn qemu_co_queue_restart_all(CoQueue *queue)
     qemu_co_queue_do_restart(queue, false);
 }
 
-bool qemu_co_enter_next(CoQueue *queue)
+bool qemu_co_enter_next_impl(CoQueue *queue, QemuTypedMutex mutex)
 {
     Coroutine *next;
 
@@ -140,7 +140,16 @@ bool qemu_co_enter_next(CoQueue *queue)
     }
 
     QSIMPLEQ_REMOVE_HEAD(&queue->entries, co_queue_next);
-    qemu_coroutine_enter(next);
+    /* The coroutine will need the mutex: release it to
+     * avoid a deadlock.
+     */
+    if (mutex.mutex) {
+        mutex.unlock(mutex.mutex);
+    }
+    aio_co_wake(next);
+    if (mutex.mutex) {
+        mutex.lock(mutex.mutex);
+    }
     return true;
 }
 

If that's okay, I can prepare a proper series for Fam next week.

Paolo
