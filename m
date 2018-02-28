Received: from eggs.gnu.org ([2001:4830:134:3::10]:33757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqtxs-0008V8-So
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:07:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqtxp-0000tt-MJ
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:07:40 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37846 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eqtxp-0000tb-G7
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:07:37 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 271E340744C6
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 05:07:37 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 28 Feb 2018 13:06:33 +0800
Message-Id: <20180228050633.7410-15-peterx@redhat.com>
In-Reply-To: <20180228050633.7410-1-peterx@redhat.com>
References: <20180228050633.7410-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 14/14] qio/chardev: specify gcontext for TLS
 handshake
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, peterx@redhat.com, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

We allow the TLS code to be run with non-default gcontext by providing a
new qio_channel_tls_handshake_full() API.

With the new API, we can re-setup the TLS handshake GSource by calling
it again with the correct gcontext.  Any call to the function will clean
up existing GSource tasks, and re-setup using the new gcontext.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 chardev/char-socket.c    | 30 +++++++++++++---
 include/io/channel-tls.h | 22 +++++++++++-
 io/channel-tls.c         | 91 ++++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 123 insertions(+), 20 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 164a64ff34..406d33c04f 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -72,6 +72,9 @@ typedef struct {
 
 static gboolean socket_reconnect_timeout(gpointer opaque);
 static void tcp_chr_telnet_init(Chardev *chr);
+static void tcp_chr_tls_handshake_setup(Chardev *chr,
+                                        QIOChannelTLS *tioc,
+                                        GMainContext *context);
 
 static void tcp_chr_reconn_timer_cancel(SocketChardev *s)
 {
@@ -570,6 +573,7 @@ static void tcp_chr_telnet_destroy(SocketChardev *s)
 static void tcp_chr_update_read_handler(Chardev *chr)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
+    QIOChannelTLS *tioc;
 
     if (s->listener) {
         /*
@@ -589,6 +593,17 @@ static void tcp_chr_update_read_handler(Chardev *chr)
         qio_task_context_set(s->thread_task, chr->gcontext);
     }
 
+    tioc = (QIOChannelTLS *)object_dynamic_cast(OBJECT(s->ioc),
+                                                TYPE_QIO_CHANNEL_TLS);
+    if (tioc) {
+        /*
+         * TLS session enabled; reconfigure things up.  Note that, if
+         * there is existing handshake task, it'll be cleaned up first
+         * in QIO code.
+         */
+        tcp_chr_tls_handshake_setup(chr, tioc, chr->gcontext);
+    }
+
     if (!s->connected) {
         return;
     }
@@ -704,6 +719,16 @@ static void tcp_chr_tls_handshake(QIOTask *task,
     }
 }
 
+static void tcp_chr_tls_handshake_setup(Chardev *chr,
+                                        QIOChannelTLS *tioc,
+                                        GMainContext *context)
+{
+    qio_channel_tls_handshake_full(tioc,
+                                   tcp_chr_tls_handshake,
+                                   chr,
+                                   NULL,
+                                   context);
+}
 
 static void tcp_chr_tls_init(Chardev *chr)
 {
@@ -736,10 +761,7 @@ static void tcp_chr_tls_init(Chardev *chr)
     object_unref(OBJECT(s->ioc));
     s->ioc = QIO_CHANNEL(tioc);
 
-    qio_channel_tls_handshake(tioc,
-                              tcp_chr_tls_handshake,
-                              chr,
-                              NULL);
+    tcp_chr_tls_handshake_setup(chr, tioc, NULL);
 }
 
 
diff --git a/include/io/channel-tls.h b/include/io/channel-tls.h
index d157eb10e8..98b7cd1e51 100644
--- a/include/io/channel-tls.h
+++ b/include/io/channel-tls.h
@@ -48,6 +48,9 @@ struct QIOChannelTLS {
     QIOChannel parent;
     QIOChannel *master;
     QCryptoTLSSession *session;
+    GMainContext *context;
+    GSource *tls_source;
+    QIOTask *task;
 };
 
 /**
@@ -111,11 +114,12 @@ qio_channel_tls_new_client(QIOChannel *master,
                            Error **errp);
 
 /**
- * qio_channel_tls_handshake:
+ * qio_channel_tls_handshake_full:
  * @ioc: the TLS channel object
  * @func: the callback to invoke when completed
  * @opaque: opaque data to pass to @func
  * @destroy: optional callback to free @opaque
+ * @context: the context that will run the handshake task
  *
  * Perform the TLS session handshake. This method
  * will return immediately and the handshake will
@@ -123,6 +127,22 @@ qio_channel_tls_new_client(QIOChannel *master,
  * loop is running. When the handshake is complete,
  * or fails, the @func callback will be invoked.
  */
+void qio_channel_tls_handshake_full(QIOChannelTLS *ioc,
+                                    QIOTaskFunc func,
+                                    gpointer opaque,
+                                    GDestroyNotify destroy,
+                                    GMainContext *context);
+
+/**
+ * qio_channel_tls_handshake:
+ * @ioc: the TLS channel object
+ * @func: the callback to invoke when completed
+ * @opaque: opaque data to pass to @func
+ * @destroy: optional callback to free @opaque
+ *
+ * Wrapper of qio_channel_tls_handshake_full(), only that we are
+ * running the handshake always on default main context.
+ */
 void qio_channel_tls_handshake(QIOChannelTLS *ioc,
                                QIOTaskFunc func,
                                gpointer opaque,
diff --git a/io/channel-tls.c b/io/channel-tls.c
index 6182702dab..b173680526 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -145,8 +145,12 @@ static gboolean qio_channel_tls_handshake_io(QIOChannel *ioc,
                                              GIOCondition condition,
                                              gpointer user_data);
 
-static void qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
-                                           QIOTask *task)
+/*
+ * Returns NULL if handshake completed, or a GSource pointer of the
+ * pending handshake task to be executed.
+ */
+static GSource *qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
+                                               QIOTask *task)
 {
     Error *err = NULL;
     QCryptoTLSSessionHandshakeStatus status;
@@ -155,7 +159,7 @@ static void qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
         trace_qio_channel_tls_handshake_fail(ioc);
         qio_task_set_error(task, err);
         qio_task_complete(task);
-        return;
+        return NULL;
     }
 
     status = qcrypto_tls_session_get_handshake_status(ioc->session);
@@ -169,6 +173,7 @@ static void qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
             trace_qio_channel_tls_credentials_allow(ioc);
         }
         qio_task_complete(task);
+        return NULL;
     } else {
         GIOCondition condition;
         if (status == QCRYPTO_TLS_HANDSHAKE_SENDING) {
@@ -178,14 +183,36 @@ static void qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
         }
 
         trace_qio_channel_tls_handshake_pending(ioc, status);
-        qio_channel_add_watch(ioc->master,
-                              condition,
-                              qio_channel_tls_handshake_io,
-                              task,
-                              NULL);
+        return qio_channel_add_watch_full(ioc->master,
+                                          condition,
+                                          qio_channel_tls_handshake_io,
+                                          task,
+                                          NULL,
+                                          ioc->context);
+    }
+}
+
+static void qio_channel_tls_context_set(QIOChannelTLS *ioc,
+                                        GMainContext *context)
+{
+    if (ioc->context) {
+        g_main_context_unref(ioc->context);
+        ioc->context = NULL;
+    }
+    if (context) {
+        g_main_context_ref(context);
+        ioc->context = context;
     }
 }
 
+static void qio_channel_tls_source_destroy(QIOChannelTLS *ioc)
+{
+    if (ioc->tls_source) {
+        g_source_destroy(ioc->tls_source);
+        g_source_unref(ioc->tls_source);
+        ioc->tls_source = NULL;
+    }
+}
 
 static gboolean qio_channel_tls_handshake_io(QIOChannel *ioc,
                                              GIOCondition condition,
@@ -194,27 +221,59 @@ static gboolean qio_channel_tls_handshake_io(QIOChannel *ioc,
     QIOTask *task = user_data;
     QIOChannelTLS *tioc = QIO_CHANNEL_TLS(
         qio_task_get_source(task));
+    GSource *source;
 
-    qio_channel_tls_handshake_task(
-       tioc, task);
+    source = qio_channel_tls_handshake_task(tioc, task);
+    /* Release existing GSource and cache the new one */
+    g_source_unref(tioc->tls_source);
+    tioc->tls_source = source;
 
     return FALSE;
 }
 
-void qio_channel_tls_handshake(QIOChannelTLS *ioc,
-                               QIOTaskFunc func,
-                               gpointer opaque,
-                               GDestroyNotify destroy)
+static void qio_channel_tls_cleanup(QIOChannelTLS *ioc)
+{
+    if (ioc->task) {
+        qio_task_unref(ioc->task);
+        ioc->task = NULL;
+    }
+
+    qio_channel_tls_source_destroy(ioc);
+    qio_channel_tls_context_set(ioc, NULL);
+}
+
+void qio_channel_tls_handshake_full(QIOChannelTLS *ioc,
+                                    QIOTaskFunc func,
+                                    gpointer opaque,
+                                    GDestroyNotify destroy,
+                                    GMainContext *context)
 {
     QIOTask *task;
+    GSource *source;
+
+    /* Drop existing tasks if there is */
+    qio_channel_tls_cleanup(ioc);
 
     task = qio_task_new(OBJECT(ioc),
                         func, opaque, destroy);
+    qio_task_ref(ioc->task);
+    ioc->task = task;
 
     trace_qio_channel_tls_handshake_start(ioc);
-    qio_channel_tls_handshake_task(ioc, task);
+
+    assert(ioc->tls_source == NULL);
+    qio_channel_tls_context_set(ioc, context);
+    source = qio_channel_tls_handshake_task(ioc, task);
+    ioc->tls_source = source;
 }
 
+void qio_channel_tls_handshake(QIOChannelTLS *ioc,
+                               QIOTaskFunc func,
+                               gpointer opaque,
+                               GDestroyNotify destroy)
+{
+    qio_channel_tls_handshake_full(ioc, func, opaque, destroy, NULL);
+}
 
 static void qio_channel_tls_init(Object *obj G_GNUC_UNUSED)
 {
@@ -225,6 +284,8 @@ static void qio_channel_tls_finalize(Object *obj)
 {
     QIOChannelTLS *ioc = QIO_CHANNEL_TLS(obj);
 
+    qio_channel_tls_source_destroy(ioc);
+    qio_channel_tls_context_set(ioc, NULL);
     object_unref(OBJECT(ioc->master));
     qcrypto_tls_session_free(ioc->session);
 }
-- 
2.14.3
