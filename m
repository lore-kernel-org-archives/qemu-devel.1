Received: from eggs.gnu.org ([2001:4830:134:3::10]:34513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxatw-0003l4-4K
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:06:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxatv-0002FB-7N
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:06:44 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 10 Apr 2017 23:05:37 +0800
Message-Id: <20170410150542.30376-6-famz@redhat.com>
In-Reply-To: <20170410150542.30376-1-famz@redhat.com>
References: <20170410150542.30376-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for 2.9 v3 05/10] async: Introduce aio_co_enter
 and aio_co_enter_if_inactive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

They start the coroutine on the specified context.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 include/block/aio.h | 18 ++++++++++++++++++
 util/async.c        | 14 +++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index 677b6ff..b0a6bb3 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -511,6 +511,24 @@ void aio_co_schedule(AioContext *ctx, struct Coroutine *co);
 void aio_co_wake(struct Coroutine *co);
 
 /**
+ * aio_co_enter:
+ * @ctx: the context to run the coroutine
+ * @co: the coroutine to run
+ *
+ * Enter a coroutine in the specified AioContext.
+ */
+void aio_co_enter(AioContext *ctx, struct Coroutine *co);
+
+/**
+ * aio_co_enter_if_inactive:
+ * @ctx: the context to run the coroutine
+ * @co: the coroutine to run
+ *
+ * Enter a coroutine in the specified AioContext, if it's not already entered.
+ */
+void aio_co_enter_if_inactive(AioContext *ctx, struct Coroutine *co);
+
+/**
  * Return the AioContext whose event loop runs in the current thread.
  *
  * If called from an IOThread this will be the IOThread's AioContext.  If
diff --git a/util/async.c b/util/async.c
index 663e297..507671a 100644
--- a/util/async.c
+++ b/util/async.c
@@ -453,6 +453,11 @@ void aio_co_wake(struct Coroutine *co)
     smp_read_barrier_depends();
     ctx = atomic_read(&co->ctx);
 
+    aio_co_enter(ctx, co);
+}
+
+void aio_co_enter(AioContext *ctx, struct Coroutine *co)
+{
     if (ctx != qemu_get_current_aio_context()) {
         aio_co_schedule(ctx, co);
         return;
@@ -464,11 +469,18 @@ void aio_co_wake(struct Coroutine *co)
         QSIMPLEQ_INSERT_TAIL(&self->co_queue_wakeup, co, co_queue_next);
     } else {
         aio_context_acquire(ctx);
-        qemu_coroutine_enter(co);
+        qemu_aio_coroutine_enter(ctx, co);
         aio_context_release(ctx);
     }
 }
 
+void aio_co_enter_if_inactive(AioContext *ctx, struct Coroutine *co)
+{
+    if (!qemu_coroutine_entered(co)) {
+        aio_co_enter(ctx, co);
+    }
+}
+
 void aio_context_ref(AioContext *ctx)
 {
     g_source_ref(&ctx->source);
-- 
2.9.3
