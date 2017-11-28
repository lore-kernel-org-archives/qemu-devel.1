Received: from eggs.gnu.org ([2001:4830:134:3::10]:33836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eJi3e-0004yo-34
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:44:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eJi3Z-0005Ue-He
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:44:26 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 28 Nov 2017 16:43:47 +0100
Message-Id: <20171128154350.21504-2-kwolf@redhat.com>
In-Reply-To: <20171128154350.21504-1-kwolf@redhat.com>
References: <20171128154350.21504-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 1/4] Revert "coroutine: abort if we
 try to schedule or enter a pending coroutine"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, jcody@redhat.com, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This reverts commit 6133b39f3c36623425a6ede9e89d93175fde15cd.

The commit checked conditions that would expose a bug, but there is no
real reason to forbid them apart from the bug, which we'll fix in a
minute.

In particular, reentering a coroutine during co_aio_sleep_ns() is fine;
the function is explicitly written to allow this.

aio_co_schedule() can indeed conflict with direct coroutine invocations,
but this is exactky what we want to fix, so remove that check again,
too.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qemu/coroutine_int.h | 13 +++----------
 util/async.c                 | 13 -------------
 util/qemu-coroutine-sleep.c  | 12 ------------
 util/qemu-coroutine.c        | 14 --------------
 4 files changed, 3 insertions(+), 49 deletions(-)

diff --git a/include/qemu/coroutine_int.h b/include/qemu/coroutine_int.h
index 59e8406398..cb98892bba 100644
--- a/include/qemu/coroutine_int.h
+++ b/include/qemu/coroutine_int.h
@@ -46,21 +46,14 @@ struct Coroutine {
 
     size_t locks_held;
 
-    /* Only used when the coroutine has yielded.  */
-    AioContext *ctx;
-
-    /* Used to catch and abort on illegal co-routine entry.
-     * Will contain the name of the function that had first
-     * scheduled the coroutine. */
-    const char *scheduled;
-
-    QSIMPLEQ_ENTRY(Coroutine) co_queue_next;
-
     /* Coroutines that should be woken up when we yield or terminate.
      * Only used when the coroutine is running.
      */
     QSIMPLEQ_HEAD(, Coroutine) co_queue_wakeup;
 
+    /* Only used when the coroutine has yielded.  */
+    AioContext *ctx;
+    QSIMPLEQ_ENTRY(Coroutine) co_queue_next;
     QSLIST_ENTRY(Coroutine) co_scheduled_next;
 };
 
diff --git a/util/async.c b/util/async.c
index 4dd9d95a9e..0e1bd8780a 100644
--- a/util/async.c
+++ b/util/async.c
@@ -388,9 +388,6 @@ static void co_schedule_bh_cb(void *opaque)
         QSLIST_REMOVE_HEAD(&straight, co_scheduled_next);
         trace_aio_co_schedule_bh_cb(ctx, co);
         aio_context_acquire(ctx);
-
-        /* Protected by write barrier in qemu_aio_coroutine_enter */
-        atomic_set(&co->scheduled, NULL);
         qemu_coroutine_enter(co);
         aio_context_release(ctx);
     }
@@ -441,16 +438,6 @@ fail:
 void aio_co_schedule(AioContext *ctx, Coroutine *co)
 {
     trace_aio_co_schedule(ctx, co);
-    const char *scheduled = atomic_cmpxchg(&co->scheduled, NULL,
-                                           __func__);
-
-    if (scheduled) {
-        fprintf(stderr,
-                "%s: Co-routine was already scheduled in '%s'\n",
-                __func__, scheduled);
-        abort();
-    }
-
     QSLIST_INSERT_HEAD_ATOMIC(&ctx->scheduled_coroutines,
                               co, co_scheduled_next);
     qemu_bh_schedule(ctx->co_schedule_bh);
diff --git a/util/qemu-coroutine-sleep.c b/util/qemu-coroutine-sleep.c
index 254349cdbb..9c5655041b 100644
--- a/util/qemu-coroutine-sleep.c
+++ b/util/qemu-coroutine-sleep.c
@@ -13,7 +13,6 @@
 
 #include "qemu/osdep.h"
 #include "qemu/coroutine.h"
-#include "qemu/coroutine_int.h"
 #include "qemu/timer.h"
 #include "block/aio.h"
 
@@ -26,8 +25,6 @@ static void co_sleep_cb(void *opaque)
 {
     CoSleepCB *sleep_cb = opaque;
 
-    /* Write of schedule protected by barrier write in aio_co_schedule */
-    atomic_set(&sleep_cb->co->scheduled, NULL);
     aio_co_wake(sleep_cb->co);
 }
 
@@ -37,15 +34,6 @@ void coroutine_fn co_aio_sleep_ns(AioContext *ctx, QEMUClockType type,
     CoSleepCB sleep_cb = {
         .co = qemu_coroutine_self(),
     };
-
-    const char *scheduled = atomic_cmpxchg(&sleep_cb.co->scheduled, NULL,
-                                           __func__);
-    if (scheduled) {
-        fprintf(stderr,
-                "%s: Co-routine was already scheduled in '%s'\n",
-                __func__, scheduled);
-        abort();
-    }
     sleep_cb.ts = aio_timer_new(ctx, type, SCALE_NS, co_sleep_cb, &sleep_cb);
     timer_mod(sleep_cb.ts, qemu_clock_get_ns(type) + ns);
     qemu_coroutine_yield();
diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index 9eff7fd450..d6095c1d5a 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -107,22 +107,8 @@ void qemu_aio_coroutine_enter(AioContext *ctx, Coroutine *co)
     Coroutine *self = qemu_coroutine_self();
     CoroutineAction ret;
 
-    /* Cannot rely on the read barrier for co in aio_co_wake(), as there are
-     * callers outside of aio_co_wake() */
-    const char *scheduled = atomic_mb_read(&co->scheduled);
-
     trace_qemu_aio_coroutine_enter(ctx, self, co, co->entry_arg);
 
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
     if (co->caller) {
         fprintf(stderr, "Co-routine re-entered recursively\n");
         abort();
-- 
2.13.6
