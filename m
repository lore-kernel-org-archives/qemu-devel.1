Received: from eggs.gnu.org ([2001:4830:134:3::10]:41064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cS1jg-0007UP-P1
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cS1jf-0002Tl-Ai
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:40 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cS1jf-0002T4-1u
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:39 -0500
Received: by mail-wm0-x244.google.com with SMTP id r126so11632897wmr.3
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 05:17:39 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 13 Jan 2017 14:17:20 +0100
Message-Id: <20170113131731.1246-6-pbonzini@redhat.com>
In-Reply-To: <20170113131731.1246-1-pbonzini@redhat.com>
References: <20170113131731.1246-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 05/16] io: make qio_channel_yield aware of
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
Cc: famz@redhat.com, stefanha@redhat.com

Support separate coroutines for reading and writing, and place the
read/write handlers on the AioContext that the QIOChannel is registered
with.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/io/channel.h   | 37 ++++++++++++++++++----
 io/channel.c           | 86 ++++++++++++++++++++++++++++++++++++++------------
 tests/Makefile.include |  2 +-
 3 files changed, 96 insertions(+), 29 deletions(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index 665edd7..d7bad94 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -23,6 +23,7 @@
 
 #include "qemu-common.h"
 #include "qom/object.h"
+#include "qemu/coroutine.h"
 #include "block/aio.h"
 
 #define TYPE_QIO_CHANNEL "qio-channel"
@@ -59,8 +60,6 @@ typedef gboolean (*QIOChannelFunc)(QIOChannel *ioc,
                                    GIOCondition condition,
                                    gpointer data);
 
-typedef struct QIOChannelRestart QIOChannelRestart;
-
 /**
  * QIOChannel:
  *
@@ -84,8 +83,8 @@ struct QIOChannel {
     unsigned int features; /* bitmask of QIOChannelFeatures */
     char *name;
     AioContext *ctx;
-    QIOChannelRestart *read_coroutine;
-    QIOChannelRestart *write_coroutine;
+    Coroutine *read_coroutine;
+    Coroutine *write_coroutine;
 #ifdef _WIN32
     HANDLE event; /* For use with GSource on Win32 */
 #endif
@@ -508,13 +507,37 @@ guint qio_channel_add_watch(QIOChannel *ioc,
 
 
 /**
+ * qio_channel_set_aio_context:
+ * @ioc: the channel object
+ * @ctx: the #AioContext to set the handlers on
+ *
+ * Request that qio_channel_yield() sets I/O handlers on
+ * the given #AioContext.  If @ctx is %NULL, qio_channel_yield()
+ * uses QEMU's main thread event loop.
+ */
+void qio_channel_set_aio_context(QIOChannel *ioc,
+                                 AioContext *ctx);
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
index ce470d7..1e043bf 100644
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
+	rd_handler = qio_channel_restart_read;
+    }
+    if (ioc->write_coroutine) {
+	rd_handler = qio_channel_restart_write;
+    }
+
+    ctx = ioc->ctx ? ioc->ctx : iohandler_get_aio_context();
+    qio_channel_set_aio_fd_handler(ioc, ctx, rd_handler, wr_handler, ioc);
+}
+
+void qio_channel_set_aio_context(QIOChannel *ioc,
+                                 AioContext *ctx)
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
 
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3b8ed9d..7d11bbb 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -493,7 +493,7 @@ tests/check-qjson$(EXESUF): tests/check-qjson.o $(test-util-obj-y)
 tests/check-qom-interface$(EXESUF): tests/check-qom-interface.o $(test-qom-obj-y)
 tests/check-qom-proplist$(EXESUF): tests/check-qom-proplist.o $(test-qom-obj-y)
 
-tests/test-char$(EXESUF): tests/test-char.o qemu-char.o qemu-timer.o $(test-util-obj-y) $(qtest-obj-y) $(test-io-obj-y)
+tests/test-char$(EXESUF): tests/test-char.o qemu-char.o qemu-timer.o $(test-util-obj-y) $(qtest-obj-y) $(test-io-obj-y) $(test-block-obj-y)
 tests/test-coroutine$(EXESUF): tests/test-coroutine.o $(test-block-obj-y)
 tests/test-aio$(EXESUF): tests/test-aio.o $(test-block-obj-y)
 tests/test-aio-multithread$(EXESUF): tests/test-aio-multithread.o $(test-block-obj-y)
-- 
2.9.3
