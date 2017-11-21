Received: from eggs.gnu.org ([2001:4830:134:3::10]:58868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eGyE2-0002sy-W7
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 21:23:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eGyDz-0003ar-1m
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 21:23:51 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Mon, 20 Nov 2017 21:23:24 -0500
Message-Id: <1f0fd95c2096688add2c7b3cfcd7016756ef19fb.1511230683.git.jcody@redhat.com>
In-Reply-To: <cover.1511230683.git.jcody@redhat.com>
References: <cover.1511230683.git.jcody@redhat.com>
In-Reply-To: <cover.1511230683.git.jcody@redhat.com>
References: <cover.1511230683.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.11 2/4] coroutine: abort if we try to
 schedule or enter a pending coroutine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, pbonzini@redhat.com, kwolf@redhat.com

The previous patch fixed a race condition, in which there were
coroutines being executing doubly, or after coroutine deletion.

We can detect common scenarios when this happens, and print an error
message and abort before we corrupt memory / data, or segfault.

This patch will abort if an attempt to enter a coroutine is made while
it is currently pending execution, either in a specific AioContext bh,
or pending execution via a timer.  It will also abort if a coroutine
is scheduled, before a prior scheduled run has occured.

We cannot rely on the existing co->caller check for recursive re-entry
to catch this, as the coroutine may run and exit with
COROUTINE_TERMINATE before the scheduled coroutine executes.

(This is the scenario that was occuring and fixed in the previous
patch).

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 include/qemu/coroutine_int.h |  6 ++++++
 util/async.c                 | 11 +++++++++++
 util/qemu-coroutine-sleep.c  | 11 +++++++++++
 util/qemu-coroutine.c        | 11 +++++++++++
 4 files changed, 39 insertions(+)

diff --git a/include/qemu/coroutine_int.h b/include/qemu/coroutine_int.h
index cb98892..56e4c48 100644
--- a/include/qemu/coroutine_int.h
+++ b/include/qemu/coroutine_int.h
@@ -53,6 +53,12 @@ struct Coroutine {
 
     /* Only used when the coroutine has yielded.  */
     AioContext *ctx;
+
+    /* Used to catch and abort on illegal co-routine entry.
+     * Will contain the name of the function that had first
+     * scheduled the coroutine. */
+    const char *scheduled;
+
     QSIMPLEQ_ENTRY(Coroutine) co_queue_next;
     QSLIST_ENTRY(Coroutine) co_scheduled_next;
 };
diff --git a/util/async.c b/util/async.c
index 0e1bd87..49174b3 100644
--- a/util/async.c
+++ b/util/async.c
@@ -388,6 +388,7 @@ static void co_schedule_bh_cb(void *opaque)
         QSLIST_REMOVE_HEAD(&straight, co_scheduled_next);
         trace_aio_co_schedule_bh_cb(ctx, co);
         aio_context_acquire(ctx);
+        atomic_set(&co->scheduled, NULL);
         qemu_coroutine_enter(co);
         aio_context_release(ctx);
     }
@@ -438,6 +439,16 @@ fail:
 void aio_co_schedule(AioContext *ctx, Coroutine *co)
 {
     trace_aio_co_schedule(ctx, co);
+    const char *scheduled = atomic_read(&co->scheduled);
+
+    if (scheduled) {
+        fprintf(stderr,
+                "%s: Co-routine was already scheduled in '%s'\n",
+                __func__, scheduled);
+        abort();
+    }
+    atomic_set(&co->scheduled, __func__);
+
     QSLIST_INSERT_HEAD_ATOMIC(&ctx->scheduled_coroutines,
                               co, co_scheduled_next);
     qemu_bh_schedule(ctx->co_schedule_bh);
diff --git a/util/qemu-coroutine-sleep.c b/util/qemu-coroutine-sleep.c
index 9c56550..38dc4c8 100644
--- a/util/qemu-coroutine-sleep.c
+++ b/util/qemu-coroutine-sleep.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/coroutine.h"
+#include "qemu/coroutine_int.h"
 #include "qemu/timer.h"
 #include "block/aio.h"
 
@@ -25,6 +26,7 @@ static void co_sleep_cb(void *opaque)
 {
     CoSleepCB *sleep_cb = opaque;
 
+    atomic_set(&sleep_cb->co->scheduled, NULL);
     aio_co_wake(sleep_cb->co);
 }
 
@@ -34,6 +36,15 @@ void coroutine_fn co_aio_sleep_ns(AioContext *ctx, QEMUClockType type,
     CoSleepCB sleep_cb = {
         .co = qemu_coroutine_self(),
     };
+    const char *scheduled = atomic_read(&sleep_cb.co->scheduled);
+
+    if (scheduled) {
+        fprintf(stderr,
+                "%s: Co-routine was already scheduled in '%s'\n",
+                __func__, scheduled);
+        abort();
+    }
+    atomic_set(&sleep_cb.co->scheduled, __func__);
     sleep_cb.ts = aio_timer_new(ctx, type, SCALE_NS, co_sleep_cb, &sleep_cb);
     timer_mod(sleep_cb.ts, qemu_clock_get_ns(type) + ns);
     qemu_coroutine_yield();
diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index d6095c1..fbfd0ad 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -106,9 +106,20 @@ void qemu_aio_coroutine_enter(AioContext *ctx, Coroutine *co)
 {
     Coroutine *self = qemu_coroutine_self();
     CoroutineAction ret;
+    const char *scheduled = atomic_read(&co->scheduled);
 
     trace_qemu_aio_coroutine_enter(ctx, self, co, co->entry_arg);
 
+    /* if the Coroutine has already been scheduled, entering it again will
+     * cause us to enter it twice, potentially even after the coroutine has
+     * been deleted */
+    if (scheduled) {
+        fprintf(stderr,
+                "%s: Co-routine was already scheduled in '%s'\n",
+                __func__, scheduled);
+        abort();
+    }
+
     if (co->caller) {
         fprintf(stderr, "Co-routine re-entered recursively\n");
         abort();
-- 
2.9.5
