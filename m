Received: from eggs.gnu.org ([2001:4830:134:3::10]:45325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcHm-00034m-Qc
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:43:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcHl-0003A7-EB
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:43:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cUcHl-00039n-5m
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:43:33 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 46C9EC704D
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 16:43:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jan 2017 17:43:11 +0100
Message-Id: <20170120164322.21851-7-pbonzini@redhat.com>
In-Reply-To: <20170120164322.21851-1-pbonzini@redhat.com>
References: <20170120164322.21851-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 06/17] io: make qio_channel_yield aware of
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
Cc: stefanha@redhat.com, famz@redhat.com, "Daniel P . Berrange" <berrange@redhat.com>

Support separate coroutines for reading and writing, and place the
read/write handlers on the AioContext that the QIOChannel is registered
with.

Cc: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
        v1->v2:
        improved qio_channel_set_aio_context docs, renamed to
                qio_channel_attach_aio_context [Daniel, Stefan]
        fixed pasto in "io: make qio_channel_yield aware of AioContexts"

 include/io/channel.h | 47 ++++++++++++++++++++++++++--
 io/channel.c         | 86 +++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 109 insertions(+), 24 deletions(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index 0bc7c3f..8e5f721 100644
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
index ce470d7..31a6d39 100644
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
+
+static void qio_channel_restart_read(void *opaque)
+{
+    QIOChannel *ioc = opaque;
+    Coroutine *co = ioc->read_coroutine;
 
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
