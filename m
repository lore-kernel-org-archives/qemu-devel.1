Received: from eggs.gnu.org ([2001:4830:134:3::10]:52558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOliK-0007yR-Am
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOliJ-0000tN-0I
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cOliI-0000sh-Nd
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:46 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  4 Jan 2017 13:34:13 +0000
Message-Id: <20170104133414.6524-14-stefanha@redhat.com>
In-Reply-To: <20170104133414.6524-1-stefanha@redhat.com>
References: <20170104133414.6524-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 13/14] aio: self-tune polling time
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

This patch is based on the algorithm for the kvm.ko halt_poll_ns
parameter in Linux.  The initial polling time is zero.

If the event loop is woken up within the maximum polling time it means
polling could be effective, so grow polling time.

If the event loop is woken up beyond the maximum polling time it means
polling is not effective, so shrink polling time.

If the event loop makes progress within the current polling time then
the sweet spot has been reached.

This algorithm adjusts the polling time so it can adapt to variations in
workloads.  The goal is to reach the sweet spot while also recognizing
when polling would hurt more than help.

Two new trace events, poll_grow and poll_shrink, are added for observing
polling time adjustment.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20161201192652.9509-13-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/aio.h | 10 +++++++--
 aio-posix.c         | 58 +++++++++++++++++++++++++++++++++++++++++++++++++----
 aio-win32.c         |  3 ++-
 async.c             |  3 +++
 iothread.c          |  4 ++--
 trace-events        |  2 ++
 6 files changed, 71 insertions(+), 9 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index 3817d17..4dca54d 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -134,8 +134,11 @@ struct AioContext {
     /* Number of AioHandlers without .io_poll() */
     int poll_disable_cnt;
 
-    /* Maximum polling time in nanoseconds */
-    int64_t poll_max_ns;
+    /* Polling mode parameters */
+    int64_t poll_ns;        /* current polling time in nanoseconds */
+    int64_t poll_max_ns;    /* maximum polling time in nanoseconds */
+    int64_t poll_grow;      /* polling time growth factor */
+    int64_t poll_shrink;    /* polling time shrink factor */
 
     /* Are we in polling mode or monitoring file descriptors? */
     bool poll_started;
@@ -511,10 +514,13 @@ void aio_context_setup(AioContext *ctx);
  * aio_context_set_poll_params:
  * @ctx: the aio context
  * @max_ns: how long to busy poll for, in nanoseconds
+ * @grow: polling time growth factor
+ * @shrink: polling time shrink factor
  *
  * Poll mode can be disabled by setting poll_max_ns to 0.
  */
 void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
+                                 int64_t grow, int64_t shrink,
                                  Error **errp);
 
 #endif
diff --git a/aio-posix.c b/aio-posix.c
index 5216d82..1585571 100644
--- a/aio-posix.c
+++ b/aio-posix.c
@@ -550,7 +550,7 @@ static bool try_poll_mode(AioContext *ctx, bool blocking)
     if (blocking && ctx->poll_max_ns && ctx->poll_disable_cnt == 0) {
         /* See qemu_soonest_timeout() uint64_t hack */
         int64_t max_ns = MIN((uint64_t)aio_compute_timeout(ctx),
-                             (uint64_t)ctx->poll_max_ns);
+                             (uint64_t)ctx->poll_ns);
 
         if (max_ns) {
             poll_set_started(ctx, true);
@@ -576,6 +576,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
     int ret = 0;
     bool progress;
     int64_t timeout;
+    int64_t start = 0;
 
     aio_context_acquire(ctx);
     progress = false;
@@ -593,6 +594,10 @@ bool aio_poll(AioContext *ctx, bool blocking)
 
     ctx->walking_handlers++;
 
+    if (ctx->poll_max_ns) {
+        start = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+    }
+
     if (try_poll_mode(ctx, blocking)) {
         progress = true;
     } else {
@@ -635,6 +640,47 @@ bool aio_poll(AioContext *ctx, bool blocking)
         atomic_sub(&ctx->notify_me, 2);
     }
 
+    /* Adjust polling time */
+    if (ctx->poll_max_ns) {
+        int64_t block_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start;
+
+        if (block_ns <= ctx->poll_ns) {
+            /* This is the sweet spot, no adjustment needed */
+        } else if (block_ns > ctx->poll_max_ns) {
+            /* We'd have to poll for too long, poll less */
+            int64_t old = ctx->poll_ns;
+
+            if (ctx->poll_shrink) {
+                ctx->poll_ns /= ctx->poll_shrink;
+            } else {
+                ctx->poll_ns = 0;
+            }
+
+            trace_poll_shrink(ctx, old, ctx->poll_ns);
+        } else if (ctx->poll_ns < ctx->poll_max_ns &&
+                   block_ns < ctx->poll_max_ns) {
+            /* There is room to grow, poll longer */
+            int64_t old = ctx->poll_ns;
+            int64_t grow = ctx->poll_grow;
+
+            if (grow == 0) {
+                grow = 2;
+            }
+
+            if (ctx->poll_ns) {
+                ctx->poll_ns *= grow;
+            } else {
+                ctx->poll_ns = 4000; /* start polling at 4 microseconds */
+            }
+
+            if (ctx->poll_ns > ctx->poll_max_ns) {
+                ctx->poll_ns = ctx->poll_max_ns;
+            }
+
+            trace_poll_grow(ctx, old, ctx->poll_ns);
+        }
+    }
+
     aio_notify_accept(ctx);
 
     /* if we have any readable fds, dispatch event */
@@ -678,12 +724,16 @@ void aio_context_setup(AioContext *ctx)
 #endif
 }
 
-void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns, Error **errp)
+void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
+                                 int64_t grow, int64_t shrink, Error **errp)
 {
-    /* No thread synchronization here, it doesn't matter if an incorrect poll
-     * timeout is used once.
+    /* No thread synchronization here, it doesn't matter if an incorrect value
+     * is used once.
      */
     ctx->poll_max_ns = max_ns;
+    ctx->poll_ns = 0;
+    ctx->poll_grow = grow;
+    ctx->poll_shrink = shrink;
 
     aio_notify(ctx);
 }
diff --git a/aio-win32.c b/aio-win32.c
index d0e40a8..d19dc42 100644
--- a/aio-win32.c
+++ b/aio-win32.c
@@ -395,7 +395,8 @@ void aio_context_setup(AioContext *ctx)
 {
 }
 
-void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns, Error **errp)
+void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
+                                 int64_t grow, int64_t shrink, Error **errp)
 {
     error_setg(errp, "AioContext polling is not implemented on Windows");
 }
diff --git a/async.c b/async.c
index 29abf40..2960171 100644
--- a/async.c
+++ b/async.c
@@ -385,7 +385,10 @@ AioContext *aio_context_new(Error **errp)
     qemu_rec_mutex_init(&ctx->lock);
     timerlistgroup_init(&ctx->tlg, aio_timerlist_notify, ctx);
 
+    ctx->poll_ns = 0;
     ctx->poll_max_ns = 0;
+    ctx->poll_grow = 0;
+    ctx->poll_shrink = 0;
 
     return ctx;
 fail:
diff --git a/iothread.c b/iothread.c
index 8dfd10d..28598b5 100644
--- a/iothread.c
+++ b/iothread.c
@@ -98,7 +98,7 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
         return;
     }
 
-    aio_context_set_poll_params(iothread->ctx, iothread->poll_max_ns,
+    aio_context_set_poll_params(iothread->ctx, iothread->poll_max_ns, 0, 0,
                                 &local_error);
     if (local_error) {
         error_propagate(errp, local_error);
@@ -158,7 +158,7 @@ static void iothread_set_poll_max_ns(Object *obj, Visitor *v,
     iothread->poll_max_ns = value;
 
     if (iothread->ctx) {
-        aio_context_set_poll_params(iothread->ctx, value, &local_err);
+        aio_context_set_poll_params(iothread->ctx, value, 0, 0, &local_err);
     }
 
 out:
diff --git a/trace-events b/trace-events
index 7fe3a1b..1181486 100644
--- a/trace-events
+++ b/trace-events
@@ -28,6 +28,8 @@
 # aio-posix.c
 run_poll_handlers_begin(void *ctx, int64_t max_ns) "ctx %p max_ns %"PRId64
 run_poll_handlers_end(void *ctx, bool progress) "ctx %p progress %d"
+poll_shrink(void *ctx, int64_t old, int64_t new) "ctx %p old %"PRId64" new %"PRId64
+poll_grow(void *ctx, int64_t old, int64_t new) "ctx %p old %"PRId64" new %"PRId64
 
 # thread-pool.c
 thread_pool_submit(void *pool, void *req, void *opaque) "pool %p req %p opaque %p"
-- 
2.9.3
