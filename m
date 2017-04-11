Received: from eggs.gnu.org ([2001:4830:134:3::10]:39148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxuso-00046i-Qi
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:26:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxuso-0003uF-1d
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:26:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cxusn-0003tH-Ro
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:26:53 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 11 Apr 2017 20:26:26 +0800
Message-Id: <20170411122632.14050-6-famz@redhat.com>
In-Reply-To: <20170411122632.14050-1-famz@redhat.com>
References: <20170411122632.14050-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 05/11] async: Introduce aio_co_enter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, famz@redhat.com

They start the coroutine on the specified context.

Signed-off-by: Fam Zheng <famz@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/aio.h | 9 +++++++++
 util/async.c        | 7 ++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index 677b6ff..406e323 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -511,6 +511,15 @@ void aio_co_schedule(AioContext *ctx, struct Coroutine *co);
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
  * Return the AioContext whose event loop runs in the current thread.
  *
  * If called from an IOThread this will be the IOThread's AioContext.  If
diff --git a/util/async.c b/util/async.c
index 663e297..355af73 100644
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
@@ -464,7 +469,7 @@ void aio_co_wake(struct Coroutine *co)
         QSIMPLEQ_INSERT_TAIL(&self->co_queue_wakeup, co, co_queue_next);
     } else {
         aio_context_acquire(ctx);
-        qemu_coroutine_enter(co);
+        qemu_aio_coroutine_enter(ctx, co);
         aio_context_release(ctx);
     }
 }
-- 
2.9.3
