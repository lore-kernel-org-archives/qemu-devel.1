Received: from eggs.gnu.org ([2001:4830:134:3::10]:38602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cg942-0006PF-HV
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:57:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cg940-0005Q8-Ra
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:57:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cg940-0005Pr-JS
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:57:00 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 21 Feb 2017 11:56:26 +0000
Message-Id: <20170221115644.28264-7-stefanha@redhat.com>
In-Reply-To: <20170221115644.28264-1-stefanha@redhat.com>
References: <20170221115644.28264-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL v2 06/24] io: make qio_channel_yield aware of
 AioContexts
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

Support separate coroutines for reading and writing, and place the
read/write handlers on the AioContext that the QIOChannel is registered
with.

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-id: 20170213135235.12274-7-pbonzini@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/io/channel.h | 47 ++++++++++++++++++++++++++--
 io/channel.c         | 86 +++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 109 insertions(+), 24 deletions(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index 0bc7c3f..5d48906 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -23,6 +23,7 @@
 
 #include "qemu-common.h"
 #include "qom/object.h"
+#include "qemu/coroutine.h"
 #include "block/aio.h"
 
 #define TYPE_QIO_CHANNEL "qio-channel"
@@ -81,6 +82,9 @@ struct QIOChannel {
     Object parent;
     unsigned int features; /* bitmask of QIOChannelFeatures */
     char *name;
+    AioContext *ctx;
+    Coroutine *read_coroutine;
+    Coroutine *write_coroutine;
 #ifdef _WIN32
     HANDLE event; /* For use with GSource on Win32 */
 #endif
@@ -503,13 +507,50 @@ guint qio_channel_add_watch(QIOChannel *ioc,
 
 
 /**
+ * qio_channel_attach_aio_context:
+ * @ioc: the channel object
+ * @ctx: the #AioContext to set the handlers on
+ *
+ * Request that qio_channel_yield() sets I/O handlers on
+ * the given #AioContext.  If @ctx is %NULL, qio_channel_yield()
+ * uses QEMU's main thread event loop.
+ *
+ * You can move a #QIOChannel from one #AioContext to another even if
+ * I/O handlers are set for a coroutine.  However, #QIOChannel provides
+ * no synchronization between the calls to qio_channel_yield() and
+ * qio_channel_attach_aio_context().
+ *
+ * Therefore you should first call qio_channel_detach_aio_context()
+ * to ensure that the coroutine is not entered concurrently.  Then,
+ * while the coroutine has yielded, call qio_channel_attach_aio_context(),
+ * and then aio_co_schedule() to place the coroutine on the new
+ * #AioContext.  The calls to qio_channel_detach_aio_context()
+ * and qio_channel_attach_aio_context() should be protected with
+ * aio_context_acquire() and aio_context_release().
+ */
+void qio_channel_attach_aio_context(QIOChannel *ioc,
+                                    AioContext *ctx);
+
+/**
+ * qio_channel_detach_aio_context:
+ * @ioc: the channel object
+ *
+ * Disable any I/O handlers set by qio_channel_yield().  With the
+ * help of aio_co_schedule(), this allows moving a coroutine that was
+ * paused by qio_channel_yield() to another context.
+ */
+void qio_channel_detach_aio_context(QIOChannel *ioc);
+
+/**
  * qio_channel_yield:
  * @ioc: the channel object
  * @condition: the I/O condition to wait for
  *
- * Yields execution from the current coroutine until
- * the condition indicated by @condition becomes
- * available.
+ * Yields execution from the current coroutine until the condition
+ * indicated by @condition becomes available.  @condition must
+ * be either %G_IO_IN or %G_IO_OUT; it cannot contain both.  In
+ * addition, no two coroutine can be waiting on the same condition
+ * and channel at the same time.
  *
  * This must only be called from coroutine context
  */
diff --git a/io/channel.c b/io/channel.c
index ce470d7..cdf7454 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "io/channel.h"
 #include "qapi/error.h"
-#include "qemu/coroutine.h"
+#include "qemu/main-loop.h"
 
 bool qio_channel_has_feature(QIOChannel *ioc,
                              QIOChannelFeature feature)
@@ -238,36 +238,80 @@ off_t qio_channel_io_seek(QIOChannel *ioc,
 }
 
 
-typedef struct QIOChannelYieldData QIOChannelYieldData;
-struct QIOChannelYieldData {
-    QIOChannel *ioc;
-    Coroutine *co;
-};
+static void qio_channel_set_aio_fd_handlers(QIOChannel *ioc);
 
+static void qio_channel_restart_read(void *opaque)
+{
+    QIOChannel *ioc = opaque;
+    Coroutine *co = ioc->read_coroutine;
+
+    ioc->read_coroutine = NULL;
+    qio_channel_set_aio_fd_handlers(ioc);
+    aio_co_wake(co);
+}
 
-static gboolean qio_channel_yield_enter(QIOChannel *ioc,
-                                        GIOCondition condition,
-                                        gpointer opaque)
+static void qio_channel_restart_write(void *opaque)
 {
-    QIOChannelYieldData *data = opaque;
-    qemu_coroutine_enter(data->co);
-    return FALSE;
+    QIOChannel *ioc = opaque;
+    Coroutine *co = ioc->write_coroutine;
+
+    ioc->write_coroutine = NULL;
+    qio_channel_set_aio_fd_handlers(ioc);
+    aio_co_wake(co);
 }
 
+static void qio_channel_set_aio_fd_handlers(QIOChannel *ioc)
+{
+    IOHandler *rd_handler = NULL, *wr_handler = NULL;
+    AioContext *ctx;
+
+    if (ioc->read_coroutine) {
+        rd_handler = qio_channel_restart_read;
+    }
+    if (ioc->write_coroutine) {
+        wr_handler = qio_channel_restart_write;
+    }
+
+    ctx = ioc->ctx ? ioc->ctx : iohandler_get_aio_context();
+    qio_channel_set_aio_fd_handler(ioc, ctx, rd_handler, wr_handler, ioc);
+}
+
+void qio_channel_attach_aio_context(QIOChannel *ioc,
+                                    AioContext *ctx)
+{
+    AioContext *old_ctx;
+    if (ioc->ctx == ctx) {
+        return;
+    }
+
+    old_ctx = ioc->ctx ? ioc->ctx : iohandler_get_aio_context();
+    qio_channel_set_aio_fd_handler(ioc, old_ctx, NULL, NULL, NULL);
+    ioc->ctx = ctx;
+    qio_channel_set_aio_fd_handlers(ioc);
+}
+
+void qio_channel_detach_aio_context(QIOChannel *ioc)
+{
+    ioc->read_coroutine = NULL;
+    ioc->write_coroutine = NULL;
+    qio_channel_set_aio_fd_handlers(ioc);
+    ioc->ctx = NULL;
+}
 
 void coroutine_fn qio_channel_yield(QIOChannel *ioc,
                                     GIOCondition condition)
 {
-    QIOChannelYieldData data;
-
     assert(qemu_in_coroutine());
-    data.ioc = ioc;
-    data.co = qemu_coroutine_self();
-    qio_channel_add_watch(ioc,
-                          condition,
-                          qio_channel_yield_enter,
-                          &data,
-                          NULL);
+    if (condition == G_IO_IN) {
+        assert(!ioc->read_coroutine);
+        ioc->read_coroutine = qemu_coroutine_self();
+    } else if (condition == G_IO_OUT) {
+        assert(!ioc->write_coroutine);
+        ioc->write_coroutine = qemu_coroutine_self();
+    } else {
+        abort();
+    }
+    qio_channel_set_aio_fd_handlers(ioc);
     qemu_coroutine_yield();
 }
 
-- 
2.9.3
