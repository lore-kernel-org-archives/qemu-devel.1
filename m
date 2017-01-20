Received: from eggs.gnu.org ([2001:4830:134:3::10]:45420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcHv-0003DZ-My
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:43:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcHq-0003Ci-Rb
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:43:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cUcHq-0003CV-IC
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:43:38 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A6F9881252
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 16:43:38 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jan 2017 17:43:15 +0100
Message-Id: <20170120164322.21851-11-pbonzini@redhat.com>
In-Reply-To: <20170120164322.21851-1-pbonzini@redhat.com>
References: <20170120164322.21851-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 10/17] aio: push aio_context_acquire/release
 down to dispatching
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

The AioContext data structures are now protected by list_lock and/or
they are walked with FOREACH_RCU primitives.  There is no need anymore
to acquire the AioContext for the entire duration of aio_dispatch.
Instead, just acquire it before and after invoking the callbacks.
The next step is then to push it further down.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/aio-posix.c | 25 +++++++++++--------------
 util/aio-win32.c | 15 +++++++--------
 util/async.c     |  2 ++
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 9453d83..3fd64fb 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -402,7 +402,9 @@ static bool aio_dispatch_handlers(AioContext *ctx)
             (revents & (G_IO_IN | G_IO_HUP | G_IO_ERR)) &&
             aio_node_check(ctx, node->is_external) &&
             node->io_read) {
+            aio_context_acquire(ctx);
             node->io_read(node->opaque);
+            aio_context_release(ctx);
 
             /* aio_notify() does not count as progress */
             if (node->opaque != &ctx->notifier) {
@@ -413,7 +415,9 @@ static bool aio_dispatch_handlers(AioContext *ctx)
             (revents & (G_IO_OUT | G_IO_ERR)) &&
             aio_node_check(ctx, node->is_external) &&
             node->io_write) {
+            aio_context_acquire(ctx);
             node->io_write(node->opaque);
+            aio_context_release(ctx);
             progress = true;
         }
 
@@ -450,7 +454,9 @@ bool aio_dispatch(AioContext *ctx, bool dispatch_fds)
     }
 
     /* Run our timers */
+    aio_context_acquire(ctx);
     progress |= timerlistgroup_run_timers(&ctx->tlg);
+    aio_context_release(ctx);
 
     return progress;
 }
@@ -596,9 +602,6 @@ bool aio_poll(AioContext *ctx, bool blocking)
     int64_t timeout;
     int64_t start = 0;
 
-    aio_context_acquire(ctx);
-    progress = false;
-
     /* aio_notify can avoid the expensive event_notifier_set if
      * everything (file descriptors, bottom halves, timers) will
      * be re-evaluated before the next blocking poll().  This is
@@ -616,9 +619,11 @@ bool aio_poll(AioContext *ctx, bool blocking)
         start = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
     }
 
-    if (try_poll_mode(ctx, blocking)) {
-        progress = true;
-    } else {
+    aio_context_acquire(ctx);
+    progress = try_poll_mode(ctx, blocking);
+    aio_context_release(ctx);
+
+    if (!progress) {
         assert(npfd == 0);
 
         /* fill pollfds */
@@ -635,9 +640,6 @@ bool aio_poll(AioContext *ctx, bool blocking)
         timeout = blocking ? aio_compute_timeout(ctx) : 0;
 
         /* wait until next event */
-        if (timeout) {
-            aio_context_release(ctx);
-        }
         if (aio_epoll_check_poll(ctx, pollfds, npfd, timeout)) {
             AioHandler epoll_handler;
 
@@ -649,9 +651,6 @@ bool aio_poll(AioContext *ctx, bool blocking)
         } else  {
             ret = qemu_poll_ns(pollfds, npfd, timeout);
         }
-        if (timeout) {
-            aio_context_acquire(ctx);
-        }
     }
 
     if (blocking) {
@@ -716,8 +715,6 @@ bool aio_poll(AioContext *ctx, bool blocking)
         progress = true;
     }
 
-    aio_context_release(ctx);
-
     return progress;
 }
 
diff --git a/util/aio-win32.c b/util/aio-win32.c
index 900524c..ab6d0e5 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
@@ -266,7 +266,9 @@ static bool aio_dispatch_handlers(AioContext *ctx, HANDLE event)
             (revents || event_notifier_get_handle(node->e) == event) &&
             node->io_notify) {
             node->pfd.revents = 0;
+            aio_context_acquire(ctx);
             node->io_notify(node->e);
+            aio_context_release(ctx);
 
             /* aio_notify() does not count as progress */
             if (node->e != &ctx->notifier) {
@@ -278,11 +280,15 @@ static bool aio_dispatch_handlers(AioContext *ctx, HANDLE event)
             (node->io_read || node->io_write)) {
             node->pfd.revents = 0;
             if ((revents & G_IO_IN) && node->io_read) {
+                aio_context_acquire(ctx);
                 node->io_read(node->opaque);
+                aio_context_release(ctx);
                 progress = true;
             }
             if ((revents & G_IO_OUT) && node->io_write) {
+                aio_context_acquire(ctx);
                 node->io_write(node->opaque);
+                aio_context_release(ctx);
                 progress = true;
             }
 
@@ -329,7 +335,6 @@ bool aio_poll(AioContext *ctx, bool blocking)
     int count;
     int timeout;
 
-    aio_context_acquire(ctx);
     progress = false;
 
     /* aio_notify can avoid the expensive event_notifier_set if
@@ -371,17 +376,11 @@ bool aio_poll(AioContext *ctx, bool blocking)
 
         timeout = blocking && !have_select_revents
             ? qemu_timeout_ns_to_ms(aio_compute_timeout(ctx)) : 0;
-        if (timeout) {
-            aio_context_release(ctx);
-        }
         ret = WaitForMultipleObjects(count, events, FALSE, timeout);
         if (blocking) {
             assert(first);
             atomic_sub(&ctx->notify_me, 2);
         }
-        if (timeout) {
-            aio_context_acquire(ctx);
-        }
 
         if (first) {
             aio_notify_accept(ctx);
@@ -404,8 +403,8 @@ bool aio_poll(AioContext *ctx, bool blocking)
         progress |= aio_dispatch_handlers(ctx, event);
     } while (count > 0);
 
+    aio_context_acquire(ctx);
     progress |= timerlistgroup_run_timers(&ctx->tlg);
-
     aio_context_release(ctx);
     return progress;
 }
diff --git a/util/async.c b/util/async.c
index 44c9c3b..8e65e4b 100644
--- a/util/async.c
+++ b/util/async.c
@@ -114,7 +114,9 @@ int aio_bh_poll(AioContext *ctx)
                 ret = 1;
             }
             bh->idle = 0;
+            aio_context_acquire(ctx);
             aio_bh_call(bh);
+            aio_context_release(ctx);
         }
         if (bh->deleted) {
             deleted = true;
-- 
2.9.3
