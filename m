Received: from eggs.gnu.org ([2001:4830:134:3::10]:38847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cg94V-000793-95
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:57:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cg94T-0005Wh-HI
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:57:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cg94T-0005Wc-8W
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:57:29 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 21 Feb 2017 11:56:39 +0000
Message-Id: <20170221115644.28264-20-stefanha@redhat.com>
In-Reply-To: <20170221115644.28264-1-stefanha@redhat.com>
References: <20170221115644.28264-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL v2 19/24] coroutine-lock: make CoMutex
 thread-safe
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

This uses the lock-free mutex described in the paper '"Blocking without
Locking", or LFTHREADS: A lock-free thread library' by Gidenstam and
Papatriantafilou.  The same technique is used in OSv, and in fact
the code is essentially a conversion to C of OSv's code.

[Added missing coroutine_fn in tests/test-aio-multithread.c.
--Stefan]

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-id: 20170213181244.16297-2-pbonzini@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qemu/coroutine.h     |  17 ++++-
 tests/test-aio-multithread.c |  86 ++++++++++++++++++++++++
 util/qemu-coroutine-lock.c   | 155 ++++++++++++++++++++++++++++++++++++++++---
 util/trace-events            |   1 +
 4 files changed, 246 insertions(+), 13 deletions(-)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index 12584ed..fce228f 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -160,10 +160,23 @@ bool qemu_co_queue_empty(CoQueue *queue);
 /**
  * Provides a mutex that can be used to synchronise coroutines
  */
+struct CoWaitRecord;
 typedef struct CoMutex {
-    bool locked;
+    /* Count of pending lockers; 0 for a free mutex, 1 for an
+     * uncontended mutex.
+     */
+    unsigned locked;
+
+    /* A queue of waiters.  Elements are added atomically in front of
+     * from_push.  to_pop is only populated, and popped from, by whoever
+     * is in charge of the next wakeup.  This can be an unlocker or,
+     * through the handoff protocol, a locker that is about to go to sleep.
+     */
+    QSLIST_HEAD(, CoWaitRecord) from_push, to_pop;
+
+    unsigned handoff, sequence;
+
     Coroutine *holder;
-    CoQueue queue;
 } CoMutex;
 
 /**
diff --git a/tests/test-aio-multithread.c b/tests/test-aio-multithread.c
index 534807d..4fa2e9b 100644
--- a/tests/test-aio-multithread.c
+++ b/tests/test-aio-multithread.c
@@ -196,6 +196,88 @@ static void test_multi_co_schedule_10(void)
     test_multi_co_schedule(10);
 }
 
+/* CoMutex thread-safety.  */
+
+static uint32_t atomic_counter;
+static uint32_t running;
+static uint32_t counter;
+static CoMutex comutex;
+
+static void coroutine_fn test_multi_co_mutex_entry(void *opaque)
+{
+    while (!atomic_mb_read(&now_stopping)) {
+        qemu_co_mutex_lock(&comutex);
+        counter++;
+        qemu_co_mutex_unlock(&comutex);
+
+        /* Increase atomic_counter *after* releasing the mutex.  Otherwise
+         * there is a chance (it happens about 1 in 3 runs) that the iothread
+         * exits before the coroutine is woken up, causing a spurious
+         * assertion failure.
+         */
+        atomic_inc(&atomic_counter);
+    }
+    atomic_dec(&running);
+}
+
+static void test_multi_co_mutex(int threads, int seconds)
+{
+    int i;
+
+    qemu_co_mutex_init(&comutex);
+    counter = 0;
+    atomic_counter = 0;
+    now_stopping = false;
+
+    create_aio_contexts();
+    assert(threads <= NUM_CONTEXTS);
+    running = threads;
+    for (i = 0; i < threads; i++) {
+        Coroutine *co1 = qemu_coroutine_create(test_multi_co_mutex_entry, NULL);
+        aio_co_schedule(ctx[i], co1);
+    }
+
+    g_usleep(seconds * 1000000);
+
+    atomic_mb_set(&now_stopping, true);
+    while (running > 0) {
+        g_usleep(100000);
+    }
+
+    join_aio_contexts();
+    g_test_message("%d iterations/second\n", counter / seconds);
+    g_assert_cmpint(counter, ==, atomic_counter);
+}
+
+/* Testing with NUM_CONTEXTS threads focuses on the queue.  The mutex however
+ * is too contended (and the threads spend too much time in aio_poll)
+ * to actually stress the handoff protocol.
+ */
+static void test_multi_co_mutex_1(void)
+{
+    test_multi_co_mutex(NUM_CONTEXTS, 1);
+}
+
+static void test_multi_co_mutex_10(void)
+{
+    test_multi_co_mutex(NUM_CONTEXTS, 10);
+}
+
+/* Testing with fewer threads stresses the handoff protocol too.  Still, the
+ * case where the locker _can_ pick up a handoff is very rare, happening
+ * about 10 times in 1 million, so increase the runtime a bit compared to
+ * other "quick" testcases that only run for 1 second.
+ */
+static void test_multi_co_mutex_2_3(void)
+{
+    test_multi_co_mutex(2, 3);
+}
+
+static void test_multi_co_mutex_2_30(void)
+{
+    test_multi_co_mutex(2, 30);
+}
+
 /* End of tests.  */
 
 int main(int argc, char **argv)
@@ -206,8 +288,12 @@ int main(int argc, char **argv)
     g_test_add_func("/aio/multi/lifecycle", test_lifecycle);
     if (g_test_quick()) {
         g_test_add_func("/aio/multi/schedule", test_multi_co_schedule_1);
+        g_test_add_func("/aio/multi/mutex/contended", test_multi_co_mutex_1);
+        g_test_add_func("/aio/multi/mutex/handoff", test_multi_co_mutex_2_3);
     } else {
         g_test_add_func("/aio/multi/schedule", test_multi_co_schedule_10);
+        g_test_add_func("/aio/multi/mutex/contended", test_multi_co_mutex_10);
+        g_test_add_func("/aio/multi/mutex/handoff", test_multi_co_mutex_2_30);
     }
     return g_test_run();
 }
diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
index e6afd1a..25da9fa 100644
--- a/util/qemu-coroutine-lock.c
+++ b/util/qemu-coroutine-lock.c
@@ -20,6 +20,10 @@
  * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
+ *
+ * The lock-free mutex implementation is based on OSv
+ * (core/lfmutex.cc, include/lockfree/mutex.hh).
+ * Copyright (C) 2013 Cloudius Systems, Ltd.
  */
 
 #include "qemu/osdep.h"
@@ -111,43 +115,172 @@ bool qemu_co_queue_empty(CoQueue *queue)
     return QSIMPLEQ_FIRST(&queue->entries) == NULL;
 }
 
+/* The wait records are handled with a multiple-producer, single-consumer
+ * lock-free queue.  There cannot be two concurrent pop_waiter() calls
+ * because pop_waiter() can only be called while mutex->handoff is zero.
+ * This can happen in three cases:
+ * - in qemu_co_mutex_unlock, before the hand-off protocol has started.
+ *   In this case, qemu_co_mutex_lock will see mutex->handoff == 0 and
+ *   not take part in the handoff.
+ * - in qemu_co_mutex_lock, if it steals the hand-off responsibility from
+ *   qemu_co_mutex_unlock.  In this case, qemu_co_mutex_unlock will fail
+ *   the cmpxchg (it will see either 0 or the next sequence value) and
+ *   exit.  The next hand-off cannot begin until qemu_co_mutex_lock has
+ *   woken up someone.
+ * - in qemu_co_mutex_unlock, if it takes the hand-off token itself.
+ *   In this case another iteration starts with mutex->handoff == 0;
+ *   a concurrent qemu_co_mutex_lock will fail the cmpxchg, and
+ *   qemu_co_mutex_unlock will go back to case (1).
+ *
+ * The following functions manage this queue.
+ */
+typedef struct CoWaitRecord {
+    Coroutine *co;
+    QSLIST_ENTRY(CoWaitRecord) next;
+} CoWaitRecord;
+
+static void push_waiter(CoMutex *mutex, CoWaitRecord *w)
+{
+    w->co = qemu_coroutine_self();
+    QSLIST_INSERT_HEAD_ATOMIC(&mutex->from_push, w, next);
+}
+
+static void move_waiters(CoMutex *mutex)
+{
+    QSLIST_HEAD(, CoWaitRecord) reversed;
+    QSLIST_MOVE_ATOMIC(&reversed, &mutex->from_push);
+    while (!QSLIST_EMPTY(&reversed)) {
+        CoWaitRecord *w = QSLIST_FIRST(&reversed);
+        QSLIST_REMOVE_HEAD(&reversed, next);
+        QSLIST_INSERT_HEAD(&mutex->to_pop, w, next);
+    }
+}
+
+static CoWaitRecord *pop_waiter(CoMutex *mutex)
+{
+    CoWaitRecord *w;
+
+    if (QSLIST_EMPTY(&mutex->to_pop)) {
+        move_waiters(mutex);
+        if (QSLIST_EMPTY(&mutex->to_pop)) {
+            return NULL;
+        }
+    }
+    w = QSLIST_FIRST(&mutex->to_pop);
+    QSLIST_REMOVE_HEAD(&mutex->to_pop, next);
+    return w;
+}
+
+static bool has_waiters(CoMutex *mutex)
+{
+    return QSLIST_EMPTY(&mutex->to_pop) || QSLIST_EMPTY(&mutex->from_push);
+}
+
 void qemu_co_mutex_init(CoMutex *mutex)
 {
     memset(mutex, 0, sizeof(*mutex));
-    qemu_co_queue_init(&mutex->queue);
 }
 
-void coroutine_fn qemu_co_mutex_lock(CoMutex *mutex)
+static void coroutine_fn qemu_co_mutex_lock_slowpath(CoMutex *mutex)
 {
     Coroutine *self = qemu_coroutine_self();
+    CoWaitRecord w;
+    unsigned old_handoff;
 
     trace_qemu_co_mutex_lock_entry(mutex, self);
+    w.co = self;
+    push_waiter(mutex, &w);
 
-    while (mutex->locked) {
-        qemu_co_queue_wait(&mutex->queue);
+    /* This is the "Responsibility Hand-Off" protocol; a lock() picks from
+     * a concurrent unlock() the responsibility of waking somebody up.
+     */
+    old_handoff = atomic_mb_read(&mutex->handoff);
+    if (old_handoff &&
+        has_waiters(mutex) &&
+        atomic_cmpxchg(&mutex->handoff, old_handoff, 0) == old_handoff) {
+        /* There can be no concurrent pops, because there can be only
+         * one active handoff at a time.
+         */
+        CoWaitRecord *to_wake = pop_waiter(mutex);
+        Coroutine *co = to_wake->co;
+        if (co == self) {
+            /* We got the lock ourselves!  */
+            assert(to_wake == &w);
+            return;
+        }
+
+        aio_co_wake(co);
     }
 
-    mutex->locked = true;
-    mutex->holder = self;
-    self->locks_held++;
-
+    qemu_coroutine_yield();
     trace_qemu_co_mutex_lock_return(mutex, self);
 }
 
+void coroutine_fn qemu_co_mutex_lock(CoMutex *mutex)
+{
+    Coroutine *self = qemu_coroutine_self();
+
+    if (atomic_fetch_inc(&mutex->locked) == 0) {
+        /* Uncontended.  */
+        trace_qemu_co_mutex_lock_uncontended(mutex, self);
+    } else {
+        qemu_co_mutex_lock_slowpath(mutex);
+    }
+    mutex->holder = self;
+    self->locks_held++;
+}
+
 void coroutine_fn qemu_co_mutex_unlock(CoMutex *mutex)
 {
     Coroutine *self = qemu_coroutine_self();
 
     trace_qemu_co_mutex_unlock_entry(mutex, self);
 
-    assert(mutex->locked == true);
+    assert(mutex->locked);
     assert(mutex->holder == self);
     assert(qemu_in_coroutine());
 
-    mutex->locked = false;
     mutex->holder = NULL;
     self->locks_held--;
-    qemu_co_queue_next(&mutex->queue);
+    if (atomic_fetch_dec(&mutex->locked) == 1) {
+        /* No waiting qemu_co_mutex_lock().  Pfew, that was easy!  */
+        return;
+    }
+
+    for (;;) {
+        CoWaitRecord *to_wake = pop_waiter(mutex);
+        unsigned our_handoff;
+
+        if (to_wake) {
+            Coroutine *co = to_wake->co;
+            aio_co_wake(co);
+            break;
+        }
+
+        /* Some concurrent lock() is in progress (we know this because
+         * mutex->locked was >1) but it hasn't yet put itself on the wait
+         * queue.  Pick a sequence number for the handoff protocol (not 0).
+         */
+        if (++mutex->sequence == 0) {
+            mutex->sequence = 1;
+        }
+
+        our_handoff = mutex->sequence;
+        atomic_mb_set(&mutex->handoff, our_handoff);
+        if (!has_waiters(mutex)) {
+            /* The concurrent lock has not added itself yet, so it
+             * will be able to pick our handoff.
+             */
+            break;
+        }
+
+        /* Try to do the handoff protocol ourselves; if somebody else has
+         * already taken it, however, we're done and they're responsible.
+         */
+        if (atomic_cmpxchg(&mutex->handoff, our_handoff, 0) != our_handoff) {
+            break;
+        }
+    }
 
     trace_qemu_co_mutex_unlock_return(mutex, self);
 }
diff --git a/util/trace-events b/util/trace-events
index 65c9787..ac27d94 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -28,6 +28,7 @@ qemu_coroutine_terminate(void *co) "self %p"
 
 # util/qemu-coroutine-lock.c
 qemu_co_queue_run_restart(void *co) "co %p"
+qemu_co_mutex_lock_uncontended(void *mutex, void *self) "mutex %p self %p"
 qemu_co_mutex_lock_entry(void *mutex, void *self) "mutex %p self %p"
 qemu_co_mutex_lock_return(void *mutex, void *self) "mutex %p self %p"
 qemu_co_mutex_unlock_entry(void *mutex, void *self) "mutex %p self %p"
-- 
2.9.3
