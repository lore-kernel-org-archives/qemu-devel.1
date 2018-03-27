Received: from eggs.gnu.org ([2001:4830:134:3::10]:51469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f0pn4-0007qb-77
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f0pn2-0000wg-N9
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:41:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33518 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1f0pn2-0000wa-Hj
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:41:32 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 27 Mar 2018 15:41:22 +0100
Message-Id: <20180327144124.32533-3-stefanha@redhat.com>
In-Reply-To: <20180327144124.32533-1-stefanha@redhat.com>
References: <20180327144124.32533-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 2/4] coroutine: avoid co_queue_wakeup recursion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

qemu_aio_coroutine_enter() is (indirectly) called recursively when
processing co_queue_wakeup.  This can lead to stack exhaustion.

This patch rewrites co_queue_wakeup in an iterative fashion (instead of
recursive) with bounded memory usage to prevent stack exhaustion.

qemu_co_queue_run_restart() is inlined into qemu_aio_coroutine_enter()
and the qemu_coroutine_enter() call is turned into a loop to avoid
recursion.

There is one change that is worth mentioning:  Previously, when
coroutine A queued coroutine B, qemu_co_queue_run_restart() entered
coroutine B from coroutine A.  If A was terminating then it would still
stay alive until B yielded.  After this patch B is entered by A's parent
so that a A can be deleted immediately if it is terminating.

It is safe to make this change since B could never interact with A if it
was terminating anyway.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20180322152834.12656-3-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qemu/coroutine_int.h |   1 -
 block/io.c                   |   3 +-
 util/qemu-coroutine-lock.c   |  34 -------------
 util/qemu-coroutine.c        | 110 +++++++++++++++++++++++--------------------
 4 files changed, 60 insertions(+), 88 deletions(-)

diff --git a/include/qemu/coroutine_int.h b/include/qemu/coroutine_int.h
index 59e8406398..bd6b0468e1 100644
--- a/include/qemu/coroutine_int.h
+++ b/include/qemu/coroutine_int.h
@@ -68,6 +68,5 @@ Coroutine *qemu_coroutine_new(void);
 void qemu_coroutine_delete(Coroutine *co);
 CoroutineAction qemu_coroutine_switch(Coroutine *from, Coroutine *to,
                                       CoroutineAction action);
-void coroutine_fn qemu_co_queue_run_restart(Coroutine *co);
 
 #endif
diff --git a/block/io.c b/block/io.c
index 2b09c656d0..bd9a19a9c4 100644
--- a/block/io.c
+++ b/block/io.c
@@ -249,8 +249,7 @@ static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
     BdrvCoDrainData data;
 
     /* Calling bdrv_drain() from a BH ensures the current coroutine yields and
-     * other coroutines run if they were queued from
-     * qemu_co_queue_run_restart(). */
+     * other coroutines run if they were queued by aio_co_enter(). */
 
     assert(qemu_in_coroutine());
     data = (BdrvCoDrainData) {
diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
index 5a80c10690..27438a1858 100644
--- a/util/qemu-coroutine-lock.c
+++ b/util/qemu-coroutine-lock.c
@@ -68,40 +68,6 @@ void coroutine_fn qemu_co_queue_wait_impl(CoQueue *queue, QemuLockable *lock)
     }
 }
 
-/**
- * qemu_co_queue_run_restart:
- *
- * Enter each coroutine that was previously marked for restart by
- * qemu_co_queue_next() or qemu_co_queue_restart_all().  This function is
- * invoked by the core coroutine code when the current coroutine yields or
- * terminates.
- */
-void qemu_co_queue_run_restart(Coroutine *co)
-{
-    Coroutine *next;
-    QSIMPLEQ_HEAD(, Coroutine) tmp_queue_wakeup =
-        QSIMPLEQ_HEAD_INITIALIZER(tmp_queue_wakeup);
-
-    trace_qemu_co_queue_run_restart(co);
-
-    /* Because "co" has yielded, any coroutine that we wakeup can resume it.
-     * If this happens and "co" terminates, co->co_queue_wakeup becomes
-     * invalid memory.  Therefore, use a temporary queue and do not touch
-     * the "co" coroutine as soon as you enter another one.
-     *
-     * In its turn resumed "co" can populate "co_queue_wakeup" queue with
-     * new coroutines to be woken up.  The caller, who has resumed "co",
-     * will be responsible for traversing the same queue, which may cause
-     * a different wakeup order but not any missing wakeups.
-     */
-    QSIMPLEQ_CONCAT(&tmp_queue_wakeup, &co->co_queue_wakeup);
-
-    while ((next = QSIMPLEQ_FIRST(&tmp_queue_wakeup))) {
-        QSIMPLEQ_REMOVE_HEAD(&tmp_queue_wakeup, co_queue_next);
-        qemu_coroutine_enter(next);
-    }
-}
-
 static bool qemu_co_queue_do_restart(CoQueue *queue, bool single)
 {
     Coroutine *next;
diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index 9eff7fd450..1ba4191b84 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -104,57 +104,65 @@ static void coroutine_delete(Coroutine *co)
 
 void qemu_aio_coroutine_enter(AioContext *ctx, Coroutine *co)
 {
-    Coroutine *self = qemu_coroutine_self();
-    CoroutineAction ret;
-
-    /* Cannot rely on the read barrier for co in aio_co_wake(), as there are
-     * callers outside of aio_co_wake() */
-    const char *scheduled = atomic_mb_read(&co->scheduled);
-
-    trace_qemu_aio_coroutine_enter(ctx, self, co, co->entry_arg);
-
-    /* if the Coroutine has already been scheduled, entering it again will
-     * cause us to enter it twice, potentially even after the coroutine has
-     * been deleted */
-    if (scheduled) {
-        fprintf(stderr,
-                "%s: Co-routine was already scheduled in '%s'\n",
-                __func__, scheduled);
-        abort();
-    }
-
-    if (co->caller) {
-        fprintf(stderr, "Co-routine re-entered recursively\n");
-        abort();
-    }
-
-    co->caller = self;
-    co->ctx = ctx;
-
-    /* Store co->ctx before anything that stores co.  Matches
-     * barrier in aio_co_wake and qemu_co_mutex_wake.
-     */
-    smp_wmb();
-
-    ret = qemu_coroutine_switch(self, co, COROUTINE_ENTER);
-
-    qemu_co_queue_run_restart(co);
-
-    /* Beware, if ret == COROUTINE_YIELD and qemu_co_queue_run_restart()
-     * has started any other coroutine, "co" might have been reentered
-     * and even freed by now!  So be careful and do not touch it.
-     */
-
-    switch (ret) {
-    case COROUTINE_YIELD:
-        return;
-    case COROUTINE_TERMINATE:
-        assert(!co->locks_held);
-        trace_qemu_coroutine_terminate(co);
-        coroutine_delete(co);
-        return;
-    default:
-        abort();
+    QSIMPLEQ_HEAD(, Coroutine) pending = QSIMPLEQ_HEAD_INITIALIZER(pending);
+    Coroutine *from = qemu_coroutine_self();
+
+    QSIMPLEQ_INSERT_TAIL(&pending, co, co_queue_next);
+
+    /* Run co and any queued coroutines */
+    while (!QSIMPLEQ_EMPTY(&pending)) {
+        Coroutine *to = QSIMPLEQ_FIRST(&pending);
+        CoroutineAction ret;
+
+        /* Cannot rely on the read barrier for to in aio_co_wake(), as there are
+         * callers outside of aio_co_wake() */
+        const char *scheduled = atomic_mb_read(&to->scheduled);
+
+        QSIMPLEQ_REMOVE_HEAD(&pending, co_queue_next);
+
+        trace_qemu_aio_coroutine_enter(ctx, from, to, to->entry_arg);
+
+        /* if the Coroutine has already been scheduled, entering it again will
+         * cause us to enter it twice, potentially even after the coroutine has
+         * been deleted */
+        if (scheduled) {
+            fprintf(stderr,
+                    "%s: Co-routine was already scheduled in '%s'\n",
+                    __func__, scheduled);
+            abort();
+        }
+
+        if (to->caller) {
+            fprintf(stderr, "Co-routine re-entered recursively\n");
+            abort();
+        }
+
+        to->caller = from;
+        to->ctx = ctx;
+
+        /* Store to->ctx before anything that stores to.  Matches
+         * barrier in aio_co_wake and qemu_co_mutex_wake.
+         */
+        smp_wmb();
+
+        ret = qemu_coroutine_switch(from, to, COROUTINE_ENTER);
+
+        /* Queued coroutines are run depth-first; previously pending coroutines
+         * run after those queued more recently.
+         */
+        QSIMPLEQ_PREPEND(&pending, &to->co_queue_wakeup);
+
+        switch (ret) {
+        case COROUTINE_YIELD:
+            break;
+        case COROUTINE_TERMINATE:
+            assert(!to->locks_held);
+            trace_qemu_coroutine_terminate(to);
+            coroutine_delete(to);
+            break;
+        default:
+            abort();
+        }
     }
 }
 
-- 
2.14.3
