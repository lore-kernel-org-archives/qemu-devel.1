Received: from eggs.gnu.org ([2001:4830:134:3::10]:41197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cS1jp-0007dt-Fn
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cS1jo-0002bh-FQ
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:49 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34947)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cS1jo-0002bW-95
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:48 -0500
Received: by mail-wm0-x244.google.com with SMTP id l2so11690069wml.2
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 05:17:48 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 13 Jan 2017 14:17:29 +0100
Message-Id: <20170113131731.1246-15-pbonzini@redhat.com>
In-Reply-To: <20170113131731.1246-1-pbonzini@redhat.com>
References: <20170113131731.1246-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 14/16] aio-posix: partially inline aio_dispatch
 into aio_poll
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

This patch prepares for the removal of unnecessary lockcnt inc/dec pairs.
Extract the dispatching loop for file descriptor handlers into a new
function aio_dispatch_handlers, and then inline aio_dispatch into
aio_poll.

aio_dispatch can now become void.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 aio-posix.c         | 44 ++++++++++++++------------------------------
 aio-win32.c         | 13 ++++---------
 async.c             |  2 +-
 include/block/aio.h |  6 +-----
 4 files changed, 20 insertions(+), 45 deletions(-)

diff --git a/aio-posix.c b/aio-posix.c
index 6beebcd..51e92b8 100644
--- a/aio-posix.c
+++ b/aio-posix.c
@@ -386,12 +386,6 @@ static bool aio_dispatch_handlers(AioContext *ctx)
     AioHandler *node, *tmp;
     bool progress = false;
 
-    /*
-     * We have to walk very carefully in case aio_set_fd_handler is
-     * called while we're walking.
-     */
-    qemu_lockcnt_inc(&ctx->list_lock);
-
     QLIST_FOREACH_SAFE_RCU(node, &ctx->aio_handlers, node, tmp) {
         int revents;
 
@@ -426,33 +420,18 @@ static bool aio_dispatch_handlers(AioContext *ctx)
         }
     }
 
-    qemu_lockcnt_dec(&ctx->list_lock);
     return progress;
 }
 
-/*
- * Note that dispatch_fds == false has the side-effect of post-poning the
- * freeing of deleted handlers.
- */
-bool aio_dispatch(AioContext *ctx, bool dispatch_fds)
+void aio_dispatch(AioContext *ctx)
 {
-    bool progress;
-
-    /*
-     * If there are callbacks left that have been queued, we need to call them.
-     * Do not call select in this case, because it is possible that the caller
-     * does not need a complete flush (as is the case for aio_poll loops).
-     */
-    progress = aio_bh_poll(ctx);
+    aio_bh_poll(ctx);
 
-    if (dispatch_fds) {
-        progress |= aio_dispatch_handlers(ctx);
-    }
-
-    /* Run our timers */
-    progress |= timerlistgroup_run_timers(&ctx->tlg);
+    qemu_lockcnt_inc(&ctx->list_lock);
+    aio_dispatch_handlers(ctx);
+    qemu_lockcnt_dec(&ctx->list_lock);
 
-    return progress;
+    timerlistgroup_run_timers(&ctx->tlg);
 }
 
 /* These thread-local variables are used only in a small part of aio_poll
@@ -701,11 +680,16 @@ bool aio_poll(AioContext *ctx, bool blocking)
     npfd = 0;
     qemu_lockcnt_dec(&ctx->list_lock);
 
-    /* Run dispatch even if there were no readable fds to run timers */
-    if (aio_dispatch(ctx, ret > 0)) {
-        progress = true;
+    progress |= aio_bh_poll(ctx);
+
+    if (ret > 0) {
+        qemu_lockcnt_inc(&ctx->list_lock);
+        progress |= aio_dispatch_handlers(ctx);
+        qemu_lockcnt_dec(&ctx->list_lock);
     }
 
+    progress |= timerlistgroup_run_timers(&ctx->tlg);
+
     return progress;
 }
 
diff --git a/aio-win32.c b/aio-win32.c
index 20b63ce..442a179 100644
--- a/aio-win32.c
+++ b/aio-win32.c
@@ -309,16 +309,11 @@ static bool aio_dispatch_handlers(AioContext *ctx, HANDLE event)
     return progress;
 }
 
-bool aio_dispatch(AioContext *ctx, bool dispatch_fds)
+void aio_dispatch(AioContext *ctx)
 {
-    bool progress;
-
-    progress = aio_bh_poll(ctx);
-    if (dispatch_fds) {
-        progress |= aio_dispatch_handlers(ctx, INVALID_HANDLE_VALUE);
-    }
-    progress |= timerlistgroup_run_timers(&ctx->tlg);
-    return progress;
+    aio_bh_poll(ctx);
+    aio_dispatch_handlers(ctx, INVALID_HANDLE_VALUE);
+    timerlistgroup_run_timers(&ctx->tlg);
 }
 
 bool aio_poll(AioContext *ctx, bool blocking)
diff --git a/async.c b/async.c
index 0243ca9..1839aa5 100644
--- a/async.c
+++ b/async.c
@@ -257,7 +257,7 @@ aio_ctx_dispatch(GSource     *source,
     AioContext *ctx = (AioContext *) source;
 
     assert(callback == NULL);
-    aio_dispatch(ctx, true);
+    aio_dispatch(ctx);
     return true;
 }
 
diff --git a/include/block/aio.h b/include/block/aio.h
index 614cbc6..677b6ff 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -310,12 +310,8 @@ bool aio_pending(AioContext *ctx);
 /* Dispatch any pending callbacks from the GSource attached to the AioContext.
  *
  * This is used internally in the implementation of the GSource.
- *
- * @dispatch_fds: true to process fds, false to skip them
- *                (can be used as an optimization by callers that know there
- *                are no fds ready)
  */
-bool aio_dispatch(AioContext *ctx, bool dispatch_fds);
+void aio_dispatch(AioContext *ctx);
 
 /* Progress in completing AIO work to occur.  This can issue new pending
  * aio as a result of executing I/O completion or bh callbacks.
-- 
2.9.3
