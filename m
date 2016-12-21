Received: from eggs.gnu.org ([2001:4830:134:3::10]:47448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cJhV7-00062e-OE
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:04:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cJhV1-00016D-Jf
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:04:13 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 21 Dec 2016 15:03:48 +0100
Message-Id: <20161221140351.30652-8-pbonzini@redhat.com>
In-Reply-To: <20161221140351.30652-1-pbonzini@redhat.com>
References: <20161221140351.30652-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 07/10] aio-posix: remove walking_handlers,
 protecting AioHandler list with list_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 aio-posix.c | 64 ++++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/aio-posix.c b/aio-posix.c
index f83b7af..9b13182 100644
--- a/aio-posix.c
+++ b/aio-posix.c
@@ -16,7 +16,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "block/block.h"
-#include "qemu/queue.h"
+#include "qemu/rcu_queue.h"
 #include "qemu/sockets.h"
 #include "qemu/cutils.h"
 #include "trace.h"
@@ -66,7 +66,7 @@ static bool aio_epoll_try_enable(AioContext *ctx)
     AioHandler *node;
     struct epoll_event event;
 
-    QLIST_FOREACH(node, &ctx->aio_handlers, node) {
+    QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
         int r;
         if (node->deleted || !node->pfd.events) {
             continue;
@@ -212,6 +212,8 @@ void aio_set_fd_handler(AioContext *ctx,
     bool is_new = false;
     bool deleted = false;
 
+    qemu_lockcnt_lock(&ctx->list_lock);
+
     node = find_aio_handler(ctx, fd);
 
     /* Are we deleting the fd handler? */
@@ -223,13 +225,13 @@ void aio_set_fd_handler(AioContext *ctx,
         g_source_remove_poll(&ctx->source, &node->pfd);
 
         /* If the lock is held, just mark the node as deleted */
-        if (ctx->walking_handlers) {
+        if (qemu_lockcnt_count(&ctx->list_lock)) {
             node->deleted = 1;
             node->pfd.revents = 0;
         } else {
             /* Otherwise, delete it for real.  We can't just mark it as
-             * deleted because deleted nodes are only cleaned up after
-             * releasing the walking_handlers lock.
+             * deleted because deleted nodes are only cleaned up while
+             * no one is walking the handlers list.
              */
             QLIST_REMOVE(node, node);
             deleted = true;
@@ -243,7 +245,7 @@ void aio_set_fd_handler(AioContext *ctx,
             /* Alloc and insert if it's not already there */
             node = g_new0(AioHandler, 1);
             node->pfd.fd = fd;
-            QLIST_INSERT_HEAD(&ctx->aio_handlers, node, node);
+            QLIST_INSERT_HEAD_RCU(&ctx->aio_handlers, node, node);
 
             g_source_add_poll(&ctx->source, &node->pfd);
             is_new = true;
@@ -265,6 +267,7 @@ void aio_set_fd_handler(AioContext *ctx,
     }
 
     aio_epoll_update(ctx, node, is_new);
+    qemu_lockcnt_unlock(&ctx->list_lock);
     aio_notify(ctx);
 
     if (deleted) {
@@ -316,8 +319,8 @@ static void poll_set_started(AioContext *ctx, bool started)
 
     ctx->poll_started = started;
 
-    ctx->walking_handlers++;
-    QLIST_FOREACH(node, &ctx->aio_handlers, node) {
+    qemu_lockcnt_inc(&ctx->list_lock);
+    QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
         IOHandler *fn;
 
         if (node->deleted) {
@@ -334,7 +337,7 @@ static void poll_set_started(AioContext *ctx, bool started)
             fn(node->opaque);
         }
     }
-    ctx->walking_handlers--;
+    qemu_lockcnt_dec(&ctx->list_lock);
 }
 
 
@@ -349,22 +352,32 @@ bool aio_prepare(AioContext *ctx)
 bool aio_pending(AioContext *ctx)
 {
     AioHandler *node;
+    bool result = false;
 
-    QLIST_FOREACH(node, &ctx->aio_handlers, node) {
+    /*
+     * We have to walk very carefully in case aio_set_fd_handler is
+     * called while we're walking.
+     */
+    qemu_lockcnt_inc(&ctx->list_lock);
+
+    QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
         int revents;
 
         revents = node->pfd.revents & node->pfd.events;
         if (revents & (G_IO_IN | G_IO_HUP | G_IO_ERR) && node->io_read &&
             aio_node_check(ctx, node->is_external)) {
-            return true;
+            result = true;
+            break;
         }
         if (revents & (G_IO_OUT | G_IO_ERR) && node->io_write &&
             aio_node_check(ctx, node->is_external)) {
-            return true;
+            result = true;
+            break;
         }
     }
+    qemu_lockcnt_dec(&ctx->list_lock);
 
-    return false;
+    return result;
 }
 
 static bool aio_dispatch_handlers(AioContext *ctx)
@@ -376,9 +389,9 @@ static bool aio_dispatch_handlers(AioContext *ctx)
      * We have to walk very carefully in case aio_set_fd_handler is
      * called while we're walking.
      */
-    ctx->walking_handlers++;
+    qemu_lockcnt_inc(&ctx->list_lock);
 
-    QLIST_FOREACH_SAFE(node, &ctx->aio_handlers, node, tmp) {
+    QLIST_FOREACH_SAFE_RCU(node, &ctx->aio_handlers, node, tmp) {
         int revents;
 
         revents = node->pfd.revents & node->pfd.events;
@@ -404,16 +417,15 @@ static bool aio_dispatch_handlers(AioContext *ctx)
         }
 
         if (node->deleted) {
-            ctx->walking_handlers--;
-            if (!ctx->walking_handlers) {
+            if (qemu_lockcnt_dec_if_lock(&ctx->list_lock)) {
                 QLIST_REMOVE(node, node);
                 g_free(node);
+                qemu_lockcnt_inc_and_unlock(&ctx->list_lock);
             }
-            ctx->walking_handlers++;
         }
     }
 
-    ctx->walking_handlers--;
+    qemu_lockcnt_dec(&ctx->list_lock);
     return progress;
 }
 
@@ -493,7 +505,7 @@ static bool run_poll_handlers_once(AioContext *ctx)
     bool progress = false;
     AioHandler *node;
 
-    QLIST_FOREACH(node, &ctx->aio_handlers, node) {
+    QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
         if (!node->deleted && node->io_poll &&
                 node->io_poll(node->opaque)) {
             progress = true;
@@ -514,7 +526,7 @@ static bool run_poll_handlers_once(AioContext *ctx)
  * Note that ctx->notify_me must be non-zero so this function can detect
  * aio_notify().
  *
- * Note that the caller must have incremented ctx->walking_handlers.
+ * Note that the caller must have incremented ctx->list_lock.
  *
  * Returns: true if progress was made, false otherwise
  */
@@ -524,7 +536,7 @@ static bool run_poll_handlers(AioContext *ctx, int64_t max_ns)
     int64_t end_time;
 
     assert(ctx->notify_me);
-    assert(ctx->walking_handlers > 0);
+    assert(qemu_lockcnt_count(&ctx->list_lock) > 0);
     assert(ctx->poll_disable_cnt == 0);
 
     trace_run_poll_handlers_begin(ctx, max_ns);
@@ -546,7 +558,7 @@ static bool run_poll_handlers(AioContext *ctx, int64_t max_ns)
  *
  * ctx->notify_me must be non-zero so this function can detect aio_notify().
  *
- * Note that the caller must have incremented ctx->walking_handlers.
+ * Note that the caller must have incremented ctx->list_lock.
  *
  * Returns: true if progress was made, false otherwise
  */
@@ -597,7 +609,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
         atomic_add(&ctx->notify_me, 2);
     }
 
-    ctx->walking_handlers++;
+    qemu_lockcnt_inc(&ctx->list_lock);
 
     if (ctx->poll_max_ns) {
         start = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
@@ -611,7 +623,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
         /* fill pollfds */
 
         if (!aio_epoll_enabled(ctx)) {
-            QLIST_FOREACH(node, &ctx->aio_handlers, node) {
+            QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
                 if (!node->deleted && node->pfd.events
                     && aio_node_check(ctx, node->is_external)) {
                     add_pollfd(node);
@@ -696,7 +708,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
     }
 
     npfd = 0;
-    ctx->walking_handlers--;
+    qemu_lockcnt_dec(&ctx->list_lock);
 
     /* Run dispatch even if there were no readable fds to run timers */
     if (aio_dispatch(ctx, ret > 0)) {
-- 
2.9.3
