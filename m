Received: from eggs.gnu.org ([2001:4830:134:3::10]:53741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRifD-00027Q-PW
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:55:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRif9-0007yF-8P
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:55:47 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cRif8-0007xL-SV
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:55:43 -0500
Received: by mail-wm0-x241.google.com with SMTP id c85so4977489wmi.1
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 08:55:42 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 12 Jan 2017 17:55:27 +0100
Message-Id: <20170112165531.11882-7-pbonzini@redhat.com>
In-Reply-To: <20170112165531.11882-1-pbonzini@redhat.com>
References: <20170112165531.11882-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 06/10] aio: tweak walking in dispatch phase
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

Preparing for the following patch, use QLIST_FOREACH_SAFE and
modify the placement of walking_handlers increment/decrement.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
