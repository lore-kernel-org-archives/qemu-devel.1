Received: from eggs.gnu.org ([2001:4830:134:3::10]:52426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOli0-0007g5-NS
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOlhy-0000jf-VS
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cOlhy-0000jM-Mp
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:26 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  4 Jan 2017 13:34:04 +0000
Message-Id: <20170104133414.6524-5-stefanha@redhat.com>
In-Reply-To: <20170104133414.6524-1-stefanha@redhat.com>
References: <20170104133414.6524-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 04/14] aio: add polling mode to AioContext
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

The AioContext event loop uses ppoll(2) or epoll_wait(2) to monitor file
descriptors or until a timer expires.  In cases like virtqueues, Linux
AIO, and ThreadPool it is technically possible to wait for events via
polling (i.e. continuously checking for events without blocking).

Polling can be faster than blocking syscalls because file descriptors,
the process scheduler, and system calls are bypassed.

The main disadvantage to polling is that it increases CPU utilization.
In classic polling configuration a full host CPU thread might run at
100% to respond to events as quickly as possible.  This patch implements
a timeout so we fall back to blocking syscalls if polling detects no
activity.  After the timeout no CPU cycles are wasted on polling until
the next event loop iteration.

The run_poll_handlers_begin() and run_poll_handlers_end() trace events
are added to aid performance analysis and troubleshooting.  If you need
to know whether polling mode is being used, trace these events to find
out.

Note that the AioContext is now re-acquired before disabling notify_me
in the non-polling case.  This makes the code cleaner since notify_me
was enabled outside the non-polling AioContext release region.  This
change is correct since it's safe to keep notify_me enabled longer
(disabling is an optimization) but potentially causes unnecessary
event_notifer_set() calls.  I think the chance of performance regression
is small here.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20161201192652.9509-4-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/aio.h |  16 ++++++
 aio-posix.c         | 163 +++++++++++++++++++++++++++++++++++++++++++---------
 aio-win32.c         |  10 +++-
 async.c             |  13 ++++-
 trace-events        |   4 ++
 5 files changed, 177 insertions(+), 29 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index 7d9cd0d..349143f 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -131,6 +131,12 @@ struct AioContext {
 
     int external_disable_cnt;
 
+    /* Number of AioHandlers without .io_poll() */
+    int poll_disable_cnt;
+
+    /* Maximum polling time in nanoseconds */
+    int64_t poll_max_ns;
+
     /* epoll(7) state used when built with CONFIG_EPOLL */
     int epollfd;
     bool epoll_enabled;
@@ -481,4 +487,14 @@ static inline bool aio_context_in_iothread(AioContext *ctx)
  */
 void aio_context_setup(AioContext *ctx);
 
+/**
+ * aio_context_set_poll_params:
+ * @ctx: the aio context
+ * @max_ns: how long to busy poll for, in nanoseconds
+ *
+ * Poll mode can be disabled by setting poll_max_ns to 0.
+ */
+void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
+                                 Error **errp);
+
 #endif
diff --git a/aio-posix.c b/aio-posix.c
index feab8e8..c6adddb 100644
--- a/aio-posix.c
+++ b/aio-posix.c
@@ -18,6 +18,8 @@
 #include "block/block.h"
 #include "qemu/queue.h"
 #include "qemu/sockets.h"
+#include "qemu/cutils.h"
+#include "trace.h"
 #ifdef CONFIG_EPOLL_CREATE1
 #include <sys/epoll.h>
 #endif
@@ -27,6 +29,7 @@ struct AioHandler
     GPollFD pfd;
     IOHandler *io_read;
     IOHandler *io_write;
+    AioPollFn *io_poll;
     int deleted;
     void *opaque;
     bool is_external;
@@ -210,7 +213,7 @@ void aio_set_fd_handler(AioContext *ctx,
     node = find_aio_handler(ctx, fd);
 
     /* Are we deleting the fd handler? */
-    if (!io_read && !io_write) {
+    if (!io_read && !io_write && !io_poll) {
         if (node == NULL) {
             return;
         }
@@ -229,6 +232,10 @@ void aio_set_fd_handler(AioContext *ctx,
             QLIST_REMOVE(node, node);
             deleted = true;
         }
+
+        if (!node->io_poll) {
+            ctx->poll_disable_cnt--;
+        }
     } else {
         if (node == NULL) {
             /* Alloc and insert if it's not already there */
@@ -238,10 +245,16 @@ void aio_set_fd_handler(AioContext *ctx,
 
             g_source_add_poll(&ctx->source, &node->pfd);
             is_new = true;
+
+            ctx->poll_disable_cnt += !io_poll;
+        } else {
+            ctx->poll_disable_cnt += !io_poll - !node->io_poll;
         }
+
         /* Update handler with latest information */
         node->io_read = io_read;
         node->io_write = io_write;
+        node->io_poll = io_poll;
         node->opaque = opaque;
         node->is_external = is_external;
 
@@ -251,6 +264,7 @@ void aio_set_fd_handler(AioContext *ctx,
 
     aio_epoll_update(ctx, node, is_new);
     aio_notify(ctx);
+
     if (deleted) {
         g_free(node);
     }
@@ -408,10 +422,83 @@ static void add_pollfd(AioHandler *node)
     npfd++;
 }
 
+/* run_poll_handlers:
+ * @ctx: the AioContext
+ * @max_ns: maximum time to poll for, in nanoseconds
+ *
+ * Polls for a given time.
+ *
+ * Note that ctx->notify_me must be non-zero so this function can detect
+ * aio_notify().
+ *
+ * Note that the caller must have incremented ctx->walking_handlers.
+ *
+ * Returns: true if progress was made, false otherwise
+ */
+static bool run_poll_handlers(AioContext *ctx, int64_t max_ns)
+{
+    bool progress = false;
+    int64_t end_time;
+
+    assert(ctx->notify_me);
+    assert(ctx->walking_handlers > 0);
+    assert(ctx->poll_disable_cnt == 0);
+
+    trace_run_poll_handlers_begin(ctx, max_ns);
+
+    end_time = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + max_ns;
+
+    do {
+        AioHandler *node;
+
+        QLIST_FOREACH(node, &ctx->aio_handlers, node) {
+            if (!node->deleted && node->io_poll &&
+                node->io_poll(node->opaque)) {
+                progress = true;
+            }
+
+            /* Caller handles freeing deleted nodes.  Don't do it here. */
+        }
+    } while (!progress && qemu_clock_get_ns(QEMU_CLOCK_REALTIME) < end_time);
+
+    trace_run_poll_handlers_end(ctx, progress);
+
+    return progress;
+}
+
+/* try_poll_mode:
+ * @ctx: the AioContext
+ * @blocking: polling is only attempted when blocking is true
+ *
+ * If blocking is true then ctx->notify_me must be non-zero so this function
+ * can detect aio_notify().
+ *
+ * Note that the caller must have incremented ctx->walking_handlers.
+ *
+ * Returns: true if progress was made, false otherwise
+ */
+static bool try_poll_mode(AioContext *ctx, bool blocking)
+{
+    if (blocking && ctx->poll_max_ns && ctx->poll_disable_cnt == 0) {
+        /* See qemu_soonest_timeout() uint64_t hack */
+        int64_t max_ns = MIN((uint64_t)aio_compute_timeout(ctx),
+                             (uint64_t)ctx->poll_max_ns);
+
+        if (max_ns) {
+            if (run_poll_handlers(ctx, max_ns)) {
+                return true;
+            }
+        }
+    }
+
+    return false;
+}
+
 bool aio_poll(AioContext *ctx, bool blocking)
 {
     AioHandler *node;
-    int i, ret;
+    int i;
+    int ret = 0;
     bool progress;
     int64_t timeout;
 
@@ -431,42 +518,47 @@ bool aio_poll(AioContext *ctx, bool blocking)
 
     ctx->walking_handlers++;
 
-    assert(npfd == 0);
+    if (try_poll_mode(ctx, blocking)) {
+        progress = true;
+    } else {
+        assert(npfd == 0);
 
-    /* fill pollfds */
+        /* fill pollfds */
 
-    if (!aio_epoll_enabled(ctx)) {
-        QLIST_FOREACH(node, &ctx->aio_handlers, node) {
-            if (!node->deleted && node->pfd.events
-                && aio_node_check(ctx, node->is_external)) {
-                add_pollfd(node);
+        if (!aio_epoll_enabled(ctx)) {
+            QLIST_FOREACH(node, &ctx->aio_handlers, node) {
+                if (!node->deleted && node->pfd.events
+                    && aio_node_check(ctx, node->is_external)) {
+                    add_pollfd(node);
+                }
             }
         }
-    }
 
-    timeout = blocking ? aio_compute_timeout(ctx) : 0;
+        timeout = blocking ? aio_compute_timeout(ctx) : 0;
 
-    /* wait until next event */
-    if (timeout) {
-        aio_context_release(ctx);
-    }
-    if (aio_epoll_check_poll(ctx, pollfds, npfd, timeout)) {
-        AioHandler epoll_handler;
+        /* wait until next event */
+        if (timeout) {
+            aio_context_release(ctx);
+        }
+        if (aio_epoll_check_poll(ctx, pollfds, npfd, timeout)) {
+            AioHandler epoll_handler;
 
-        epoll_handler.pfd.fd = ctx->epollfd;
-        epoll_handler.pfd.events = G_IO_IN | G_IO_OUT | G_IO_HUP | G_IO_ERR;
-        npfd = 0;
-        add_pollfd(&epoll_handler);
-        ret = aio_epoll(ctx, pollfds, npfd, timeout);
-    } else  {
-        ret = qemu_poll_ns(pollfds, npfd, timeout);
+            epoll_handler.pfd.fd = ctx->epollfd;
+            epoll_handler.pfd.events = G_IO_IN | G_IO_OUT | G_IO_HUP | G_IO_ERR;
+            npfd = 0;
+            add_pollfd(&epoll_handler);
+            ret = aio_epoll(ctx, pollfds, npfd, timeout);
+        } else  {
+            ret = qemu_poll_ns(pollfds, npfd, timeout);
+        }
+        if (timeout) {
+            aio_context_acquire(ctx);
+        }
     }
+
     if (blocking) {
         atomic_sub(&ctx->notify_me, 2);
     }
-    if (timeout) {
-        aio_context_acquire(ctx);
-    }
 
     aio_notify_accept(ctx);
 
@@ -492,6 +584,13 @@ bool aio_poll(AioContext *ctx, bool blocking)
 
 void aio_context_setup(AioContext *ctx)
 {
+    /* TODO remove this in final patch submission */
+    if (getenv("QEMU_AIO_POLL_MAX_NS")) {
+        fprintf(stderr, "The QEMU_AIO_POLL_MAX_NS environment variable has "
+                "been replaced with -object iothread,poll-max-ns=NUM\n");
+        exit(1);
+    }
+
 #ifdef CONFIG_EPOLL_CREATE1
     assert(!ctx->epollfd);
     ctx->epollfd = epoll_create1(EPOLL_CLOEXEC);
@@ -503,3 +602,13 @@ void aio_context_setup(AioContext *ctx)
     }
 #endif
 }
+
+void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns, Error **errp)
+{
+    /* No thread synchronization here, it doesn't matter if an incorrect poll
+     * timeout is used once.
+     */
+    ctx->poll_max_ns = max_ns;
+
+    aio_notify(ctx);
+}
diff --git a/aio-win32.c b/aio-win32.c
index 3ef8ea4..0a6e91b 100644
--- a/aio-win32.c
+++ b/aio-win32.c
@@ -20,6 +20,7 @@
 #include "block/block.h"
 #include "qemu/queue.h"
 #include "qemu/sockets.h"
+#include "qapi/error.h"
 
 struct AioHandler {
     EventNotifier *e;
@@ -38,6 +39,7 @@ void aio_set_fd_handler(AioContext *ctx,
                         bool is_external,
                         IOHandler *io_read,
                         IOHandler *io_write,
+                        AioPollFn *io_poll,
                         void *opaque)
 {
     /* fd is a SOCKET in our case */
@@ -103,7 +105,8 @@ void aio_set_fd_handler(AioContext *ctx,
 void aio_set_event_notifier(AioContext *ctx,
                             EventNotifier *e,
                             bool is_external,
-                            EventNotifierHandler *io_notify)
+                            EventNotifierHandler *io_notify,
+                            AioPollFn *io_poll)
 {
     AioHandler *node;
 
@@ -376,3 +379,8 @@ bool aio_poll(AioContext *ctx, bool blocking)
 void aio_context_setup(AioContext *ctx)
 {
 }
+
+void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns, Error **errp)
+{
+    error_setg(errp, "AioContext polling is not implemented on Windows");
+}
diff --git a/async.c b/async.c
index 678845f..29abf40 100644
--- a/async.c
+++ b/async.c
@@ -349,6 +349,15 @@ static void event_notifier_dummy_cb(EventNotifier *e)
 {
 }
 
+/* Returns true if aio_notify() was called (e.g. a BH was scheduled) */
+static bool event_notifier_poll(void *opaque)
+{
+    EventNotifier *e = opaque;
+    AioContext *ctx = container_of(e, AioContext, notifier);
+
+    return atomic_read(&ctx->notified);
+}
+
 AioContext *aio_context_new(Error **errp)
 {
     int ret;
@@ -367,7 +376,7 @@ AioContext *aio_context_new(Error **errp)
                            false,
                            (EventNotifierHandler *)
                            event_notifier_dummy_cb,
-                           NULL);
+                           event_notifier_poll);
 #ifdef CONFIG_LINUX_AIO
     ctx->linux_aio = NULL;
 #endif
@@ -376,6 +385,8 @@ AioContext *aio_context_new(Error **errp)
     qemu_rec_mutex_init(&ctx->lock);
     timerlistgroup_init(&ctx->tlg, aio_timerlist_notify, ctx);
 
+    ctx->poll_max_ns = 0;
+
     return ctx;
 fail:
     g_source_destroy(&ctx->source);
diff --git a/trace-events b/trace-events
index f74e1d3..7fe3a1b 100644
--- a/trace-events
+++ b/trace-events
@@ -25,6 +25,10 @@
 #
 # The <format-string> should be a sprintf()-compatible format string.
 
+# aio-posix.c
+run_poll_handlers_begin(void *ctx, int64_t max_ns) "ctx %p max_ns %"PRId64
+run_poll_handlers_end(void *ctx, bool progress) "ctx %p progress %d"
+
 # thread-pool.c
 thread_pool_submit(void *pool, void *req, void *opaque) "pool %p req %p opaque %p"
 thread_pool_complete(void *pool, void *req, void *opaque, int ret) "pool %p req %p opaque %p ret %d"
-- 
2.9.3
