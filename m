Received: from eggs.gnu.org ([2001:4830:134:3::10]:38863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cg94W-0007AO-Qs
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:57:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cg94V-0005XD-L6
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:57:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cg94V-0005X3-D2
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:57:31 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 21 Feb 2017 11:56:40 +0000
Message-Id: <20170221115644.28264-21-stefanha@redhat.com>
In-Reply-To: <20170221115644.28264-1-stefanha@redhat.com>
References: <20170221115644.28264-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL v2 20/24] coroutine-lock: add limited spinning
 to CoMutex
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

Running a very small critical section on pthread_mutex_t and CoMutex
shows that pthread_mutex_t is much faster because it doesn't actually
go to sleep.  What happens is that the critical section is shorter
than the latency of entering the kernel and thus FUTEX_WAIT always
fails.  With CoMutex there is no such latency but you still want to
avoid wait and wakeup.  So introduce it artificially.

This only works with one waiters; because CoMutex is fair, it will
always have more waits and wakeups than a pthread_mutex_t.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-id: 20170213181244.16297-3-pbonzini@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qemu/coroutine.h   |  5 +++++
 util/qemu-coroutine-lock.c | 51 ++++++++++++++++++++++++++++++++++++++++------
 util/qemu-coroutine.c      |  2 +-
 3 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index fce228f..12ce8e1 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -167,6 +167,11 @@ typedef struct CoMutex {
      */
     unsigned locked;
 
+    /* Context that is holding the lock.  Useful to avoid spinning
+     * when two coroutines on the same AioContext try to get the lock. :)
+     */
+    AioContext *ctx;
+
     /* A queue of waiters.  Elements are added atomically in front of
      * from_push.  to_pop is only populated, and popped from, by whoever
      * is in charge of the next wakeup.  This can be an unlocker or,
diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
index 25da9fa..73fe77c 100644
--- a/util/qemu-coroutine-lock.c
+++ b/util/qemu-coroutine-lock.c
@@ -30,6 +30,7 @@
 #include "qemu-common.h"
 #include "qemu/coroutine.h"
 #include "qemu/coroutine_int.h"
+#include "qemu/processor.h"
 #include "qemu/queue.h"
 #include "block/aio.h"
 #include "trace.h"
@@ -181,7 +182,18 @@ void qemu_co_mutex_init(CoMutex *mutex)
     memset(mutex, 0, sizeof(*mutex));
 }
 
-static void coroutine_fn qemu_co_mutex_lock_slowpath(CoMutex *mutex)
+static void coroutine_fn qemu_co_mutex_wake(CoMutex *mutex, Coroutine *co)
+{
+    /* Read co before co->ctx; pairs with smp_wmb() in
+     * qemu_coroutine_enter().
+     */
+    smp_read_barrier_depends();
+    mutex->ctx = co->ctx;
+    aio_co_wake(co);
+}
+
+static void coroutine_fn qemu_co_mutex_lock_slowpath(AioContext *ctx,
+                                                     CoMutex *mutex)
 {
     Coroutine *self = qemu_coroutine_self();
     CoWaitRecord w;
@@ -206,10 +218,11 @@ static void coroutine_fn qemu_co_mutex_lock_slowpath(CoMutex *mutex)
         if (co == self) {
             /* We got the lock ourselves!  */
             assert(to_wake == &w);
+            mutex->ctx = ctx;
             return;
         }
 
-        aio_co_wake(co);
+        qemu_co_mutex_wake(mutex, co);
     }
 
     qemu_coroutine_yield();
@@ -218,13 +231,39 @@ static void coroutine_fn qemu_co_mutex_lock_slowpath(CoMutex *mutex)
 
 void coroutine_fn qemu_co_mutex_lock(CoMutex *mutex)
 {
+    AioContext *ctx = qemu_get_current_aio_context();
     Coroutine *self = qemu_coroutine_self();
+    int waiters, i;
 
-    if (atomic_fetch_inc(&mutex->locked) == 0) {
+    /* Running a very small critical section on pthread_mutex_t and CoMutex
+     * shows that pthread_mutex_t is much faster because it doesn't actually
+     * go to sleep.  What happens is that the critical section is shorter
+     * than the latency of entering the kernel and thus FUTEX_WAIT always
+     * fails.  With CoMutex there is no such latency but you still want to
+     * avoid wait and wakeup.  So introduce it artificially.
+     */
+    i = 0;
+retry_fast_path:
+    waiters = atomic_cmpxchg(&mutex->locked, 0, 1);
+    if (waiters != 0) {
+        while (waiters == 1 && ++i < 1000) {
+            if (atomic_read(&mutex->ctx) == ctx) {
+                break;
+            }
+            if (atomic_read(&mutex->locked) == 0) {
+                goto retry_fast_path;
+            }
+            cpu_relax();
+        }
+        waiters = atomic_fetch_inc(&mutex->locked);
+    }
+
+    if (waiters == 0) {
         /* Uncontended.  */
         trace_qemu_co_mutex_lock_uncontended(mutex, self);
+        mutex->ctx = ctx;
     } else {
-        qemu_co_mutex_lock_slowpath(mutex);
+        qemu_co_mutex_lock_slowpath(ctx, mutex);
     }
     mutex->holder = self;
     self->locks_held++;
@@ -240,6 +279,7 @@ void coroutine_fn qemu_co_mutex_unlock(CoMutex *mutex)
     assert(mutex->holder == self);
     assert(qemu_in_coroutine());
 
+    mutex->ctx = NULL;
     mutex->holder = NULL;
     self->locks_held--;
     if (atomic_fetch_dec(&mutex->locked) == 1) {
@@ -252,8 +292,7 @@ void coroutine_fn qemu_co_mutex_unlock(CoMutex *mutex)
         unsigned our_handoff;
 
         if (to_wake) {
-            Coroutine *co = to_wake->co;
-            aio_co_wake(co);
+            qemu_co_mutex_wake(mutex, to_wake->co);
             break;
         }
 
diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index 415600d..72412e5 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -118,7 +118,7 @@ void qemu_coroutine_enter(Coroutine *co)
     co->ctx = qemu_get_current_aio_context();
 
     /* Store co->ctx before anything that stores co.  Matches
-     * barrier in aio_co_wake.
+     * barrier in aio_co_wake and qemu_co_mutex_wake.
      */
     smp_wmb();
 
-- 
2.9.3
