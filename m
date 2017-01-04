Received: from eggs.gnu.org ([2001:4830:134:3::10]:52561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOliK-0007yV-C4
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOliE-0000qq-Lc
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cOliE-0000qQ-Cq
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:42 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  4 Jan 2017 13:34:11 +0000
Message-Id: <20170104133414.6524-12-stefanha@redhat.com>
In-Reply-To: <20170104133414.6524-1-stefanha@redhat.com>
References: <20170104133414.6524-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 11/14] aio: add .io_poll_begin/end() callbacks
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

The begin and end callbacks can be used to prepare for the polling loop
and clean up when polling stops.  Note that they may only be called once
for multiple aio_poll() calls if polling continues to succeed.  Once
polling fails the end callback is invoked before aio_poll() resumes file
descriptor monitoring.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20161201192652.9509-11-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/aio.h |  20 ++++++++++
 aio-posix.c         | 105 ++++++++++++++++++++++++++++++++++++++++++++--------
 aio-win32.c         |  15 ++++++++
 3 files changed, 125 insertions(+), 15 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index 349143f..3817d17 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -137,6 +137,9 @@ struct AioContext {
     /* Maximum polling time in nanoseconds */
     int64_t poll_max_ns;
 
+    /* Are we in polling mode or monitoring file descriptors? */
+    bool poll_started;
+
     /* epoll(7) state used when built with CONFIG_EPOLL */
     int epollfd;
     bool epoll_enabled;
@@ -339,6 +342,14 @@ void aio_set_fd_handler(AioContext *ctx,
                         AioPollFn *io_poll,
                         void *opaque);
 
+/* Set polling begin/end callbacks for a file descriptor that has already been
+ * registered with aio_set_fd_handler.  Do nothing if the file descriptor is
+ * not registered.
+ */
+void aio_set_fd_poll(AioContext *ctx, int fd,
+                     IOHandler *io_poll_begin,
+                     IOHandler *io_poll_end);
+
 /* Register an event notifier and associated callbacks.  Behaves very similarly
  * to event_notifier_set_handler.  Unlike event_notifier_set_handler, these callbacks
  * will be invoked when using aio_poll().
@@ -352,6 +363,15 @@ void aio_set_event_notifier(AioContext *ctx,
                             EventNotifierHandler *io_read,
                             AioPollFn *io_poll);
 
+/* Set polling begin/end callbacks for an event notifier that has already been
+ * registered with aio_set_event_notifier.  Do nothing if the event notifier is
+ * not registered.
+ */
+void aio_set_event_notifier_poll(AioContext *ctx,
+                                 EventNotifier *notifier,
+                                 EventNotifierHandler *io_poll_begin,
+                                 EventNotifierHandler *io_poll_end);
+
 /* Return a GSource that lets the main loop poll the file descriptors attached
  * to this AioContext.
  */
diff --git a/aio-posix.c b/aio-posix.c
index c6adddb..5216d82 100644
--- a/aio-posix.c
+++ b/aio-posix.c
@@ -30,6 +30,8 @@ struct AioHandler
     IOHandler *io_read;
     IOHandler *io_write;
     AioPollFn *io_poll;
+    IOHandler *io_poll_begin;
+    IOHandler *io_poll_end;
     int deleted;
     void *opaque;
     bool is_external;
@@ -270,6 +272,20 @@ void aio_set_fd_handler(AioContext *ctx,
     }
 }
 
+void aio_set_fd_poll(AioContext *ctx, int fd,
+                     IOHandler *io_poll_begin,
+                     IOHandler *io_poll_end)
+{
+    AioHandler *node = find_aio_handler(ctx, fd);
+
+    if (!node) {
+        return;
+    }
+
+    node->io_poll_begin = io_poll_begin;
+    node->io_poll_end = io_poll_end;
+}
+
 void aio_set_event_notifier(AioContext *ctx,
                             EventNotifier *notifier,
                             bool is_external,
@@ -280,8 +296,53 @@ void aio_set_event_notifier(AioContext *ctx,
                        (IOHandler *)io_read, NULL, io_poll, notifier);
 }
 
+void aio_set_event_notifier_poll(AioContext *ctx,
+                                 EventNotifier *notifier,
+                                 EventNotifierHandler *io_poll_begin,
+                                 EventNotifierHandler *io_poll_end)
+{
+    aio_set_fd_poll(ctx, event_notifier_get_fd(notifier),
+                    (IOHandler *)io_poll_begin,
+                    (IOHandler *)io_poll_end);
+}
+
+static void poll_set_started(AioContext *ctx, bool started)
+{
+    AioHandler *node;
+
+    if (started == ctx->poll_started) {
+        return;
+    }
+
+    ctx->poll_started = started;
+
+    ctx->walking_handlers++;
+    QLIST_FOREACH(node, &ctx->aio_handlers, node) {
+        IOHandler *fn;
+
+        if (node->deleted) {
+            continue;
+        }
+
+        if (started) {
+            fn = node->io_poll_begin;
+        } else {
+            fn = node->io_poll_end;
+        }
+
+        if (fn) {
+            fn(node->opaque);
+        }
+    }
+    ctx->walking_handlers--;
+}
+
+
 bool aio_prepare(AioContext *ctx)
 {
+    /* Poll mode cannot be used with glib's event loop, disable it. */
+    poll_set_started(ctx, false);
+
     return false;
 }
 
@@ -422,6 +483,23 @@ static void add_pollfd(AioHandler *node)
     npfd++;
 }
 
+static bool run_poll_handlers_once(AioContext *ctx)
+{
+    bool progress = false;
+    AioHandler *node;
+
+    QLIST_FOREACH(node, &ctx->aio_handlers, node) {
+        if (!node->deleted && node->io_poll &&
+                node->io_poll(node->opaque)) {
+            progress = true;
+        }
+
+        /* Caller handles freeing deleted nodes.  Don't do it here. */
+    }
+
+    return progress;
+}
+
 /* run_poll_handlers:
  * @ctx: the AioContext
  * @max_ns: maximum time to poll for, in nanoseconds
@@ -437,7 +515,7 @@ static void add_pollfd(AioHandler *node)
  */
 static bool run_poll_handlers(AioContext *ctx, int64_t max_ns)
 {
-    bool progress = false;
+    bool progress;
     int64_t end_time;
 
     assert(ctx->notify_me);
@@ -449,16 +527,7 @@ static bool run_poll_handlers(AioContext *ctx, int64_t max_ns)
     end_time = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + max_ns;
 
     do {
-        AioHandler *node;
-
-        QLIST_FOREACH(node, &ctx->aio_handlers, node) {
-            if (!node->deleted && node->io_poll &&
-                node->io_poll(node->opaque)) {
-                progress = true;
-            }
-
-            /* Caller handles freeing deleted nodes.  Don't do it here. */
-        }
+        progress = run_poll_handlers_once(ctx);
     } while (!progress && qemu_clock_get_ns(QEMU_CLOCK_REALTIME) < end_time);
 
     trace_run_poll_handlers_end(ctx, progress);
@@ -468,10 +537,9 @@ static bool run_poll_handlers(AioContext *ctx, int64_t max_ns)
 
 /* try_poll_mode:
  * @ctx: the AioContext
- * @blocking: polling is only attempted when blocking is true
+ * @blocking: busy polling is only attempted when blocking is true
  *
- * If blocking is true then ctx->notify_me must be non-zero so this function
- * can detect aio_notify().
+ * ctx->notify_me must be non-zero so this function can detect aio_notify().
  *
  * Note that the caller must have incremented ctx->walking_handlers.
  *
@@ -485,13 +553,20 @@ static bool try_poll_mode(AioContext *ctx, bool blocking)
                              (uint64_t)ctx->poll_max_ns);
 
         if (max_ns) {
+            poll_set_started(ctx, true);
+
             if (run_poll_handlers(ctx, max_ns)) {
                 return true;
             }
         }
     }
 
-    return false;
+    poll_set_started(ctx, false);
+
+    /* Even if we don't run busy polling, try polling once in case it can make
+     * progress and the caller will be able to avoid ppoll(2)/epoll_wait(2).
+     */
+    return run_poll_handlers_once(ctx);
 }
 
 bool aio_poll(AioContext *ctx, bool blocking)
diff --git a/aio-win32.c b/aio-win32.c
index 0a6e91b..d0e40a8 100644
--- a/aio-win32.c
+++ b/aio-win32.c
@@ -102,6 +102,13 @@ void aio_set_fd_handler(AioContext *ctx,
     aio_notify(ctx);
 }
 
+void aio_set_fd_poll(AioContext *ctx, int fd,
+                     IOHandler *io_poll_begin,
+                     IOHandler *io_poll_end)
+{
+    /* Not implemented */
+}
+
 void aio_set_event_notifier(AioContext *ctx,
                             EventNotifier *e,
                             bool is_external,
@@ -153,6 +160,14 @@ void aio_set_event_notifier(AioContext *ctx,
     aio_notify(ctx);
 }
 
+void aio_set_event_notifier_poll(AioContext *ctx,
+                                 EventNotifier *notifier,
+                                 EventNotifierHandler *io_poll_begin,
+                                 EventNotifierHandler *io_poll_end)
+{
+    /* Not implemented */
+}
+
 bool aio_prepare(AioContext *ctx)
 {
     static struct timeval tv0;
-- 
2.9.3
