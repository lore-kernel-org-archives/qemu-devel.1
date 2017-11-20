Received: from eggs.gnu.org ([2001:4830:134:3::10]:56928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eGc71-0000ax-9j
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 21:47:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eGc70-0008ON-Dd
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 21:47:07 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Sun, 19 Nov 2017 21:46:43 -0500
Message-Id: <5bec37564f83e39e216d2ebcf7a380b0c7704e0e.1511145863.git.jcody@redhat.com>
In-Reply-To: <cover.1511145863.git.jcody@redhat.com>
References: <cover.1511145863.git.jcody@redhat.com>
In-Reply-To: <cover.1511145863.git.jcody@redhat.com>
References: <cover.1511145863.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] coroutine: abort if we try to enter
 coroutine scheduled for another ctx
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
and abort before we corrupt memory / data, or segfault.

This patch will abort if an attempt to enter a coroutine is made while
it is currently pending execution in a different AioContext.

We cannot rely on the existing co->caller check for recursive re-entry
to catch this, as the coroutine may run and exit with
COROUTINE_TERMINATE before the AioContext scheduled event happens.

(This is the scenario that was occuring and fixed in the previous
patch).

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 include/qemu/coroutine_int.h | 3 +++
 util/async.c                 | 7 +++++++
 util/qemu-coroutine.c        | 9 +++++++++
 3 files changed, 19 insertions(+)

diff --git a/include/qemu/coroutine_int.h b/include/qemu/coroutine_int.h
index cb98892..931cdc9 100644
--- a/include/qemu/coroutine_int.h
+++ b/include/qemu/coroutine_int.h
@@ -53,6 +53,9 @@ struct Coroutine {
 
     /* Only used when the coroutine has yielded.  */
     AioContext *ctx;
+
+    int scheduled;
+
     QSIMPLEQ_ENTRY(Coroutine) co_queue_next;
     QSLIST_ENTRY(Coroutine) co_scheduled_next;
 };
diff --git a/util/async.c b/util/async.c
index 0e1bd87..d459684 100644
--- a/util/async.c
+++ b/util/async.c
@@ -388,6 +388,7 @@ static void co_schedule_bh_cb(void *opaque)
         QSLIST_REMOVE_HEAD(&straight, co_scheduled_next);
         trace_aio_co_schedule_bh_cb(ctx, co);
         aio_context_acquire(ctx);
+        co->scheduled = 0;
         qemu_coroutine_enter(co);
         aio_context_release(ctx);
     }
@@ -438,6 +439,12 @@ fail:
 void aio_co_schedule(AioContext *ctx, Coroutine *co)
 {
     trace_aio_co_schedule(ctx, co);
+    if (co->scheduled == 1) {
+        fprintf(stderr,
+                "Cannot schedule a co-routine that is already scheduled\n");
+        abort();
+    }
+    co->scheduled = 1;
     QSLIST_INSERT_HEAD_ATOMIC(&ctx->scheduled_coroutines,
                               co, co_scheduled_next);
     qemu_bh_schedule(ctx->co_schedule_bh);
diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index d6095c1..2edab63 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -109,6 +109,15 @@ void qemu_aio_coroutine_enter(AioContext *ctx, Coroutine *co)
 
     trace_qemu_aio_coroutine_enter(ctx, self, co, co->entry_arg);
 
+    /* if the Coroutine has already been scheduled, entering it again will
+     * cause us to enter it twice, potentially even after the coroutine has
+     * been deleted */
+    if (co->scheduled == 1) {
+        fprintf(stderr, "Cannot enter a co-routine that has already "
+                        "been scheduled to run in a different AioContext\n");
+        abort();
+    }
+
     if (co->caller) {
         fprintf(stderr, "Co-routine re-entered recursively\n");
         abort();
-- 
2.9.5
