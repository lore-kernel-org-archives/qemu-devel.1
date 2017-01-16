Received: from eggs.gnu.org ([2001:4830:134:3::10]:41221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT7VP-00085w-3m
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:39:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT7VO-0003kb-5X
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:39:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cT7VO-0003kV-06
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:39:26 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 16 Jan 2017 13:39:06 +0000
Message-Id: <20170116133911.21684-7-stefanha@redhat.com>
In-Reply-To: <20170116133911.21684-1-stefanha@redhat.com>
References: <20170116133911.21684-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 06/11] aio-posix: split aio_dispatch_handlers
 out of aio_dispatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

This simplifies the handling of dispatch_fds.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20170112180800.21085-6-pbonzini@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 aio-posix.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/aio-posix.c b/aio-posix.c
index 1585571..25198d9 100644
--- a/aio-posix.c
+++ b/aio-posix.c
@@ -367,31 +367,16 @@ bool aio_pending(AioContext *ctx)
     return false;
 }
 
-/*
- * Note that dispatch_fds == false has the side-effect of post-poning the
- * freeing of deleted handlers.
- */
-bool aio_dispatch(AioContext *ctx, bool dispatch_fds)
+static bool aio_dispatch_handlers(AioContext *ctx)
 {
-    AioHandler *node = NULL;
+    AioHandler *node;
     bool progress = false;
 
     /*
-     * If there are callbacks left that have been queued, we need to call them.
-     * Do not call select in this case, because it is possible that the caller
-     * does not need a complete flush (as is the case for aio_poll loops).
-     */
-    if (aio_bh_poll(ctx)) {
-        progress = true;
-    }
-
-    /*
      * We have to walk very carefully in case aio_set_fd_handler is
      * called while we're walking.
      */
-    if (dispatch_fds) {
-        node = QLIST_FIRST(&ctx->aio_handlers);
-    }
+    node = QLIST_FIRST(&ctx->aio_handlers);
     while (node) {
         AioHandler *tmp;
         int revents;
@@ -431,6 +416,28 @@ bool aio_dispatch(AioContext *ctx, bool dispatch_fds)
         }
     }
 
+    return progress;
+}
+
+/*
+ * Note that dispatch_fds == false has the side-effect of post-poning the
+ * freeing of deleted handlers.
+ */
+bool aio_dispatch(AioContext *ctx, bool dispatch_fds)
+{
+    bool progress;
+
+    /*
+     * If there are callbacks left that have been queued, we need to call them.
+     * Do not call select in this case, because it is possible that the caller
+     * does not need a complete flush (as is the case for aio_poll loops).
+     */
+    progress = aio_bh_poll(ctx);
+
+    if (dispatch_fds) {
+        progress |= aio_dispatch_handlers(ctx);
+    }
+
     /* Run our timers */
     progress |= timerlistgroup_run_timers(&ctx->tlg);
 
-- 
2.9.3
