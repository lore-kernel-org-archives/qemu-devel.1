Received: from eggs.gnu.org ([2001:4830:134:3::10]:45465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcI1-0003JG-97
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:43:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcHx-0003Hi-UT
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:43:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cUcHx-0003Gk-MJ
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:43:45 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D2C7E8046E
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 16:43:45 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jan 2017 17:43:20 +0100
Message-Id: <20170120164322.21851-16-pbonzini@redhat.com>
In-Reply-To: <20170120164322.21851-1-pbonzini@redhat.com>
References: <20170120164322.21851-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 15/17] aio-posix: partially inline aio_dispatch
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
Cc: stefanha@redhat.com, famz@redhat.com

This patch prepares for the removal of unnecessary lockcnt inc/dec pairs.
Extract the dispatching loop for file descriptor handlers into a new
function aio_dispatch_handlers, and then inline aio_dispatch into
aio_poll.

aio_dispatch can now become void.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/block/aio.h |  6 +-----
 util/aio-posix.c    | 44 ++++++++++++++------------------------------
 util/aio-win32.c    | 13 ++++---------
 util/async.c        |  2 +-
 4 files changed, 20 insertions(+), 45 deletions(-)

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
diff --git a/util/aio-posix.c b/util/aio-posix.c
index 6beebcd..51e92b8 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
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
 
diff --git a/util/aio-win32.c b/util/aio-win32.c
index 20b63ce..442a179 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
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
diff --git a/util/async.c b/util/async.c
index 99b9d7e..cc40735 100644
--- a/util/async.c
+++ b/util/async.c
@@ -258,7 +258,7 @@ aio_ctx_dispatch(GSource     *source,
     AioContext *ctx = (AioContext *) source;
 
     assert(callback == NULL);
-    aio_dispatch(ctx, true);
+    aio_dispatch(ctx);
     return true;
 }
 
-- 
2.9.3
