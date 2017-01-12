Received: from eggs.gnu.org ([2001:4830:134:3::10]:44275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRjnI-00007m-0V
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:08:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRjnH-0005F1-1k
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:08:11 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cRjnG-0005Ep-Ry
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:08:10 -0500
Received: by mail-wm0-x243.google.com with SMTP id r144so5491046wme.0
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 10:08:10 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 12 Jan 2017 19:07:55 +0100
Message-Id: <20170112180800.21085-6-pbonzini@redhat.com>
In-Reply-To: <20170112180800.21085-1-pbonzini@redhat.com>
References: <20170112180800.21085-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 05/10] aio-posix: split aio_dispatch_handlers
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
Cc: famz@redhat.com, stefanha@redhat.com

This simplifies the handling of dispatch_fds.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
