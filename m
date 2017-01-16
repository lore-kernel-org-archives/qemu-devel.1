Received: from eggs.gnu.org ([2001:4830:134:3::10]:41245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT7VR-00087v-27
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:39:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT7VQ-0003l3-1r
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:39:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cT7VP-0003kq-RH
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:39:27 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 16 Jan 2017 13:39:07 +0000
Message-Id: <20170116133911.21684-8-stefanha@redhat.com>
In-Reply-To: <20170116133911.21684-1-stefanha@redhat.com>
References: <20170116133911.21684-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 07/11] aio: tweak walking in dispatch phase
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

Preparing for the following patch, use QLIST_FOREACH_SAFE and
modify the placement of walking_handlers increment/decrement.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-id: 20170112180800.21085-7-pbonzini@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 aio-posix.c | 26 ++++++++++++--------------
 aio-win32.c | 26 ++++++++++++--------------
 2 files changed, 24 insertions(+), 28 deletions(-)

diff --git a/aio-posix.c b/aio-posix.c
index 25198d9..f83b7af 100644
--- a/aio-posix.c
+++ b/aio-posix.c
@@ -369,19 +369,17 @@ bool aio_pending(AioContext *ctx)
 
 static bool aio_dispatch_handlers(AioContext *ctx)
 {
-    AioHandler *node;
+    AioHandler *node, *tmp;
     bool progress = false;
 
     /*
      * We have to walk very carefully in case aio_set_fd_handler is
      * called while we're walking.
      */
-    node = QLIST_FIRST(&ctx->aio_handlers);
-    while (node) {
-        AioHandler *tmp;
-        int revents;
+    ctx->walking_handlers++;
 
-        ctx->walking_handlers++;
+    QLIST_FOREACH_SAFE(node, &ctx->aio_handlers, node, tmp) {
+        int revents;
 
         revents = node->pfd.revents & node->pfd.events;
         node->pfd.revents = 0;
@@ -405,17 +403,17 @@ static bool aio_dispatch_handlers(AioContext *ctx)
             progress = true;
         }
 
-        tmp = node;
-        node = QLIST_NEXT(node, node);
-
-        ctx->walking_handlers--;
-
-        if (!ctx->walking_handlers && tmp->deleted) {
-            QLIST_REMOVE(tmp, node);
-            g_free(tmp);
+        if (node->deleted) {
+            ctx->walking_handlers--;
+            if (!ctx->walking_handlers) {
+                QLIST_REMOVE(node, node);
+                g_free(node);
+            }
+            ctx->walking_handlers++;
         }
     }
 
+    ctx->walking_handlers--;
     return progress;
 }
 
diff --git a/aio-win32.c b/aio-win32.c
index d19dc42..1ad459d 100644
--- a/aio-win32.c
+++ b/aio-win32.c
@@ -227,20 +227,18 @@ bool aio_pending(AioContext *ctx)
 
 static bool aio_dispatch_handlers(AioContext *ctx, HANDLE event)
 {
-    AioHandler *node;
+    AioHandler *node, *tmp;
     bool progress = false;
 
+    ctx->walking_handlers++;
+
     /*
      * We have to walk very carefully in case aio_set_fd_handler is
      * called while we're walking.
      */
-    node = QLIST_FIRST(&ctx->aio_handlers);
-    while (node) {
-        AioHandler *tmp;
+    QLIST_FOREACH_SAFE(node, &ctx->aio_handlers, node, tmp) {
         int revents = node->pfd.revents;
 
-        ctx->walking_handlers++;
-
         if (!node->deleted &&
             (revents || event_notifier_get_handle(node->e) == event) &&
             node->io_notify) {
@@ -275,17 +273,17 @@ static bool aio_dispatch_handlers(AioContext *ctx, HANDLE event)
             }
         }
 
-        tmp = node;
-        node = QLIST_NEXT(node, node);
-
-        ctx->walking_handlers--;
-
-        if (!ctx->walking_handlers && tmp->deleted) {
-            QLIST_REMOVE(tmp, node);
-            g_free(tmp);
+        if (node->deleted) {
+            ctx->walking_handlers--;
+            if (!ctx->walking_handlers) {
+                QLIST_REMOVE(node, node);
+                g_free(node);
+            }
+            ctx->walking_handlers++;
         }
     }
 
+    ctx->walking_handlers--;
     return progress;
 }
 
-- 
2.9.3
