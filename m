Received: from eggs.gnu.org ([2001:4830:134:3::10]:44309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRjnM-0000Cs-SR
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:08:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRjnL-0005GA-BW
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:08:16 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cRjnL-0005Fs-1z
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:08:15 -0500
Received: by mail-wm0-x243.google.com with SMTP id l2so5513007wml.2
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 10:08:15 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 12 Jan 2017 19:07:58 +0100
Message-Id: <20170112180800.21085-9-pbonzini@redhat.com>
In-Reply-To: <20170112180800.21085-1-pbonzini@redhat.com>
References: <20170112180800.21085-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 08/10] aio-win32: remove walking_handlers,
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
Cc: famz@redhat.com, stefanha@redhat.com

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 aio-win32.c | 73 +++++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 26 deletions(-)

diff --git a/aio-win32.c b/aio-win32.c
index 1ad459d..900524c 100644
--- a/aio-win32.c
+++ b/aio-win32.c
@@ -21,6 +21,7 @@
 #include "qemu/queue.h"
 #include "qemu/sockets.h"
 #include "qapi/error.h"
+#include "qemu/rcu_queue.h"
 
 struct AioHandler {
     EventNotifier *e;
@@ -45,6 +46,7 @@ void aio_set_fd_handler(AioContext *ctx,
     /* fd is a SOCKET in our case */
     AioHandler *node;
 
+    qemu_lockcnt_lock(&ctx->list_lock);
     QLIST_FOREACH(node, &ctx->aio_handlers, node) {
         if (node->pfd.fd == fd && !node->deleted) {
             break;
@@ -54,14 +56,14 @@ void aio_set_fd_handler(AioContext *ctx,
     /* Are we deleting the fd handler? */
     if (!io_read && !io_write) {
         if (node) {
-            /* If the lock is held, just mark the node as deleted */
-            if (ctx->walking_handlers) {
+            /* If aio_poll is in progress, just mark the node as deleted */
+            if (qemu_lockcnt_count(&ctx->list_lock)) {
                 node->deleted = 1;
                 node->pfd.revents = 0;
             } else {
                 /* Otherwise, delete it for real.  We can't just mark it as
                  * deleted because deleted nodes are only cleaned up after
-                 * releasing the walking_handlers lock.
+                 * releasing the list_lock.
                  */
                 QLIST_REMOVE(node, node);
                 g_free(node);
@@ -74,7 +76,7 @@ void aio_set_fd_handler(AioContext *ctx,
             /* Alloc and insert if it's not already there */
             node = g_new0(AioHandler, 1);
             node->pfd.fd = fd;
-            QLIST_INSERT_HEAD(&ctx->aio_handlers, node, node);
+            QLIST_INSERT_HEAD_RCU(&ctx->aio_handlers, node, node);
         }
 
         node->pfd.events = 0;
@@ -99,6 +101,7 @@ void aio_set_fd_handler(AioContext *ctx,
                        FD_CONNECT | FD_WRITE | FD_OOB);
     }
 
+    qemu_lockcnt_unlock(&ctx->list_lock);
     aio_notify(ctx);
 }
 
@@ -117,6 +120,7 @@ void aio_set_event_notifier(AioContext *ctx,
 {
     AioHandler *node;
 
+    qemu_lockcnt_lock(&ctx->list_lock);
     QLIST_FOREACH(node, &ctx->aio_handlers, node) {
         if (node->e == e && !node->deleted) {
             break;
@@ -128,14 +132,14 @@ void aio_set_event_notifier(AioContext *ctx,
         if (node) {
             g_source_remove_poll(&ctx->source, &node->pfd);
 
-            /* If the lock is held, just mark the node as deleted */
-            if (ctx->walking_handlers) {
+            /* aio_poll is in progress, just mark the node as deleted */
+            if (qemu_lockcnt_count(&ctx->list_lock)) {
                 node->deleted = 1;
                 node->pfd.revents = 0;
             } else {
                 /* Otherwise, delete it for real.  We can't just mark it as
                  * deleted because deleted nodes are only cleaned up after
-                 * releasing the walking_handlers lock.
+                 * releasing the list_lock.
                  */
                 QLIST_REMOVE(node, node);
                 g_free(node);
@@ -149,7 +153,7 @@ void aio_set_event_notifier(AioContext *ctx,
             node->pfd.fd = (uintptr_t)event_notifier_get_handle(e);
             node->pfd.events = G_IO_IN;
             node->is_external = is_external;
-            QLIST_INSERT_HEAD(&ctx->aio_handlers, node, node);
+            QLIST_INSERT_HEAD_RCU(&ctx->aio_handlers, node, node);
 
             g_source_add_poll(&ctx->source, &node->pfd);
         }
@@ -157,6 +161,7 @@ void aio_set_event_notifier(AioContext *ctx,
         node->io_notify = io_notify;
     }
 
+    qemu_lockcnt_unlock(&ctx->list_lock);
     aio_notify(ctx);
 }
 
@@ -175,10 +180,16 @@ bool aio_prepare(AioContext *ctx)
     bool have_select_revents = false;
     fd_set rfds, wfds;
 
+    /*
+     * We have to walk very carefully in case aio_set_fd_handler is
+     * called while we're walking.
+     */
+    qemu_lockcnt_inc(&ctx->list_lock);
+
     /* fill fd sets */
     FD_ZERO(&rfds);
     FD_ZERO(&wfds);
-    QLIST_FOREACH(node, &ctx->aio_handlers, node) {
+    QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
         if (node->io_read) {
             FD_SET ((SOCKET)node->pfd.fd, &rfds);
         }
@@ -188,7 +199,7 @@ bool aio_prepare(AioContext *ctx)
     }
 
     if (select(0, &rfds, &wfds, NULL, &tv0) > 0) {
-        QLIST_FOREACH(node, &ctx->aio_handlers, node) {
+        QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
             node->pfd.revents = 0;
             if (FD_ISSET(node->pfd.fd, &rfds)) {
                 node->pfd.revents |= G_IO_IN;
@@ -202,41 +213,53 @@ bool aio_prepare(AioContext *ctx)
         }
     }
 
+    qemu_lockcnt_dec(&ctx->list_lock);
     return have_select_revents;
 }
 
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
+    QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
         if (node->pfd.revents && node->io_notify) {
-            return true;
+            result = true;
+            break;
         }
 
         if ((node->pfd.revents & G_IO_IN) && node->io_read) {
-            return true;
+            result = true;
+            break;
         }
         if ((node->pfd.revents & G_IO_OUT) && node->io_write) {
-            return true;
+            result = true;
+            break;
         }
     }
 
-    return false;
+    qemu_lockcnt_dec(&ctx->list_lock);
+    return result;
 }
 
 static bool aio_dispatch_handlers(AioContext *ctx, HANDLE event)
 {
-    AioHandler *node, *tmp;
+    AioHandler *node;
     bool progress = false;
+    AioHandler *tmp;
 
-    ctx->walking_handlers++;
+    qemu_lockcnt_inc(&ctx->list_lock);
 
     /*
      * We have to walk very carefully in case aio_set_fd_handler is
      * called while we're walking.
      */
-    QLIST_FOREACH_SAFE(node, &ctx->aio_handlers, node, tmp) {
+    QLIST_FOREACH_SAFE_RCU(node, &ctx->aio_handlers, node, tmp) {
         int revents = node->pfd.revents;
 
         if (!node->deleted &&
@@ -274,16 +297,15 @@ static bool aio_dispatch_handlers(AioContext *ctx, HANDLE event)
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
 
@@ -321,20 +343,19 @@ bool aio_poll(AioContext *ctx, bool blocking)
         atomic_add(&ctx->notify_me, 2);
     }
 
+    qemu_lockcnt_inc(&ctx->list_lock);
     have_select_revents = aio_prepare(ctx);
 
-    ctx->walking_handlers++;
-
     /* fill fd sets */
     count = 0;
-    QLIST_FOREACH(node, &ctx->aio_handlers, node) {
+    QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
         if (!node->deleted && node->io_notify
             && aio_node_check(ctx, node->is_external)) {
             events[count++] = event_notifier_get_handle(node->e);
         }
     }
 
-    ctx->walking_handlers--;
+    qemu_lockcnt_dec(&ctx->list_lock);
     first = true;
 
     /* ctx->notifier is always registered.  */
-- 
2.9.3
