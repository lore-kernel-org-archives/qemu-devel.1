Received: from eggs.gnu.org ([2001:4830:134:3::10]:52402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOlhv-0007ak-Qt
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOlht-0000i0-N5
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cOlht-0000hk-Fk
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:21 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  4 Jan 2017 13:34:02 +0000
Message-Id: <20170104133414.6524-3-stefanha@redhat.com>
In-Reply-To: <20170104133414.6524-1-stefanha@redhat.com>
References: <20170104133414.6524-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 02/14] aio: add flag to skip fds to
 aio_dispatch()
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

Polling mode will not call ppoll(2)/epoll_wait(2).  Therefore we know
there are no fds ready and should avoid looping over fd handlers in
aio_dispatch().

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20161201192652.9509-2-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/aio.h |  6 +++++-
 aio-posix.c         | 14 ++++++++++----
 aio-win32.c         |  6 ++++--
 async.c             |  2 +-
 4 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index ca551e3..c1519ec 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -295,8 +295,12 @@ bool aio_pending(AioContext *ctx);
 /* Dispatch any pending callbacks from the GSource attached to the AioContext.
  *
  * This is used internally in the implementation of the GSource.
+ *
+ * @dispatch_fds: true to process fds, false to skip them
+ *                (can be used as an optimization by callers that know there
+ *                are no fds ready)
  */
-bool aio_dispatch(AioContext *ctx);
+bool aio_dispatch(AioContext *ctx, bool dispatch_fds);
 
 /* Progress in completing AIO work to occur.  This can issue new pending
  * aio as a result of executing I/O completion or bh callbacks.
diff --git a/aio-posix.c b/aio-posix.c
index e13b9ab..4ac2346 100644
--- a/aio-posix.c
+++ b/aio-posix.c
@@ -290,9 +290,13 @@ bool aio_pending(AioContext *ctx)
     return false;
 }
 
-bool aio_dispatch(AioContext *ctx)
+/*
+ * Note that dispatch_fds == false has the side-effect of post-poning the
+ * freeing of deleted handlers.
+ */
+bool aio_dispatch(AioContext *ctx, bool dispatch_fds)
 {
-    AioHandler *node;
+    AioHandler *node = NULL;
     bool progress = false;
 
     /*
@@ -308,7 +312,9 @@ bool aio_dispatch(AioContext *ctx)
      * We have to walk very carefully in case aio_set_fd_handler is
      * called while we're walking.
      */
-    node = QLIST_FIRST(&ctx->aio_handlers);
+    if (dispatch_fds) {
+        node = QLIST_FIRST(&ctx->aio_handlers);
+    }
     while (node) {
         AioHandler *tmp;
         int revents;
@@ -473,7 +479,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
     ctx->walking_handlers--;
 
     /* Run dispatch even if there were no readable fds to run timers */
-    if (aio_dispatch(ctx)) {
+    if (aio_dispatch(ctx, ret > 0)) {
         progress = true;
     }
 
diff --git a/aio-win32.c b/aio-win32.c
index c8c249e..3ef8ea4 100644
--- a/aio-win32.c
+++ b/aio-win32.c
@@ -271,12 +271,14 @@ static bool aio_dispatch_handlers(AioContext *ctx, HANDLE event)
     return progress;
 }
 
-bool aio_dispatch(AioContext *ctx)
+bool aio_dispatch(AioContext *ctx, bool dispatch_fds)
 {
     bool progress;
 
     progress = aio_bh_poll(ctx);
-    progress |= aio_dispatch_handlers(ctx, INVALID_HANDLE_VALUE);
+    if (dispatch_fds) {
+        progress |= aio_dispatch_handlers(ctx, INVALID_HANDLE_VALUE);
+    }
     progress |= timerlistgroup_run_timers(&ctx->tlg);
     return progress;
 }
diff --git a/async.c b/async.c
index b2de360..52bdb8f 100644
--- a/async.c
+++ b/async.c
@@ -251,7 +251,7 @@ aio_ctx_dispatch(GSource     *source,
     AioContext *ctx = (AioContext *) source;
 
     assert(callback == NULL);
-    aio_dispatch(ctx);
+    aio_dispatch(ctx, true);
     return true;
 }
 
-- 
2.9.3
