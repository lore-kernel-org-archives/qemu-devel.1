Received: from eggs.gnu.org ([2001:4830:134:3::10]:53721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRifC-000265-Ak
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:55:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRif7-0007vF-FN
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:55:46 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cRif7-0007u0-6n
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:55:41 -0500
Received: by mail-wm0-x241.google.com with SMTP id l2so5029972wml.2
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 08:55:41 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 12 Jan 2017 17:55:26 +0100
Message-Id: <20170112165531.11882-6-pbonzini@redhat.com>
In-Reply-To: <20170112165531.11882-1-pbonzini@redhat.com>
References: <20170112165531.11882-1-pbonzini@redhat.com>
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
