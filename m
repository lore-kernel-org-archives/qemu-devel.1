Received: from eggs.gnu.org ([2001:4830:134:3::10]:45579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1esjqo-00034Z-Rv
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:44:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1esjqm-0006BS-MJ
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:43:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53400 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1esjqm-0006B8-Gn
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:43:56 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1523340FB64A
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 06:43:56 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon,  5 Mar 2018 14:43:24 +0800
Message-Id: <20180305064324.9238-7-peterx@redhat.com>
In-Reply-To: <20180305064324.9238-1-peterx@redhat.com>
References: <20180305064324.9238-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 6/6] qio: non-default context for TLS
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

A new parameter "context" is added to qio_channel_tls_handshake() is to
allow the TLS to be run on a non-default context.  Still, no functional
change.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 chardev/char-socket.c       |  1 +
 include/io/channel-tls.h    |  5 ++++-
 io/channel-tls.c            | 45 ++++++++++++++++++++++++++++++++++-----------
 migration/tls.c             |  2 ++
 nbd/client.c                |  1 +
 nbd/server.c                |  1 +
 tests/test-io-channel-tls.c |  2 ++
 ui/vnc-auth-vencrypt.c      |  1 +
 ui/vnc-ws.c                 |  1 +
 9 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 754d82679a..113feaf948 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -702,6 +702,7 @@ static void tcp_chr_tls_init(Chardev *chr)
     qio_channel_tls_handshake(tioc,
                               tcp_chr_tls_handshake,
                               chr,
+                              NULL,
                               NULL);
 }
 
diff --git a/include/io/channel-tls.h b/include/io/channel-tls.h
index d157eb10e8..87fcaf9146 100644
--- a/include/io/channel-tls.h
+++ b/include/io/channel-tls.h
@@ -116,6 +116,8 @@ qio_channel_tls_new_client(QIOChannel *master,
  * @func: the callback to invoke when completed
  * @opaque: opaque data to pass to @func
  * @destroy: optional callback to free @opaque
+ * @context: the context that TLS handshake will run with. If %NULL,
+ *           the default context will be used
  *
  * Perform the TLS session handshake. This method
  * will return immediately and the handshake will
@@ -126,7 +128,8 @@ qio_channel_tls_new_client(QIOChannel *master,
 void qio_channel_tls_handshake(QIOChannelTLS *ioc,
                                QIOTaskFunc func,
                                gpointer opaque,
-                               GDestroyNotify destroy);
+                               GDestroyNotify destroy,
+                               GMainContext *context);
 
 /**
  * qio_channel_tls_get_session:
diff --git a/io/channel-tls.c b/io/channel-tls.c
index 6182702dab..9628e6fa47 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -140,13 +140,19 @@ qio_channel_tls_new_client(QIOChannel *master,
     return NULL;
 }
 
+struct QIOChannelTLSData {
+    QIOTask *task;
+    GMainContext *context;
+};
+typedef struct QIOChannelTLSData QIOChannelTLSData;
 
 static gboolean qio_channel_tls_handshake_io(QIOChannel *ioc,
                                              GIOCondition condition,
                                              gpointer user_data);
 
 static void qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
-                                           QIOTask *task)
+                                           QIOTask *task,
+                                           GMainContext *context)
 {
     Error *err = NULL;
     QCryptoTLSSessionHandshakeStatus status;
@@ -171,6 +177,15 @@ static void qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
         qio_task_complete(task);
     } else {
         GIOCondition condition;
+        QIOChannelTLSData *data = g_new0(typeof(*data), 1);
+
+        data->task = task;
+        data->context = context;
+
+        if (context) {
+            g_main_context_ref(context);
+        }
+
         if (status == QCRYPTO_TLS_HANDSHAKE_SENDING) {
             condition = G_IO_OUT;
         } else {
@@ -178,11 +193,12 @@ static void qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
         }
 
         trace_qio_channel_tls_handshake_pending(ioc, status);
-        qio_channel_add_watch(ioc->master,
-                              condition,
-                              qio_channel_tls_handshake_io,
-                              task,
-                              NULL);
+        qio_channel_add_watch_full(ioc->master,
+                                   condition,
+                                   qio_channel_tls_handshake_io,
+                                   data,
+                                   NULL,
+                                   context);
     }
 }
 
@@ -191,12 +207,18 @@ static gboolean qio_channel_tls_handshake_io(QIOChannel *ioc,
                                              GIOCondition condition,
                                              gpointer user_data)
 {
-    QIOTask *task = user_data;
+    QIOChannelTLSData *data = user_data;
+    QIOTask *task = data->task;
+    GMainContext *context = data->context;
     QIOChannelTLS *tioc = QIO_CHANNEL_TLS(
         qio_task_get_source(task));
 
-    qio_channel_tls_handshake_task(
-       tioc, task);
+    g_free(data);
+    qio_channel_tls_handshake_task(tioc, task, context);
+
+    if (context) {
+        g_main_context_unref(context);
+    }
 
     return FALSE;
 }
@@ -204,7 +226,8 @@ static gboolean qio_channel_tls_handshake_io(QIOChannel *ioc,
 void qio_channel_tls_handshake(QIOChannelTLS *ioc,
                                QIOTaskFunc func,
                                gpointer opaque,
-                               GDestroyNotify destroy)
+                               GDestroyNotify destroy,
+                               GMainContext *context)
 {
     QIOTask *task;
 
@@ -212,7 +235,7 @@ void qio_channel_tls_handshake(QIOChannelTLS *ioc,
                         func, opaque, destroy);
 
     trace_qio_channel_tls_handshake_start(ioc);
-    qio_channel_tls_handshake_task(ioc, task);
+    qio_channel_tls_handshake_task(ioc, task, context);
 }
 
 
diff --git a/migration/tls.c b/migration/tls.c
index a29b35b33c..3b9e8c9263 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -105,6 +105,7 @@ void migration_tls_channel_process_incoming(MigrationState *s,
     qio_channel_tls_handshake(tioc,
                               migration_tls_incoming_handshake,
                               NULL,
+                              NULL,
                               NULL);
 }
 
@@ -159,5 +160,6 @@ void migration_tls_channel_connect(MigrationState *s,
     qio_channel_tls_handshake(tioc,
                               migration_tls_outgoing_handshake,
                               s,
+                              NULL,
                               NULL);
 }
diff --git a/nbd/client.c b/nbd/client.c
index 9c3fe4aaa6..dcad23a053 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -579,6 +579,7 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
     qio_channel_tls_handshake(tioc,
                               nbd_tls_handshake,
                               &data,
+                              NULL,
                               NULL);
 
     if (!data.complete) {
diff --git a/nbd/server.c b/nbd/server.c
index 4990a5826e..e714bfe6a1 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -599,6 +599,7 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
     qio_channel_tls_handshake(tioc,
                               nbd_tls_handshake,
                               &data,
+                              NULL,
                               NULL);
 
     if (!data.complete) {
diff --git a/tests/test-io-channel-tls.c b/tests/test-io-channel-tls.c
index a210d01ba5..32743b2c96 100644
--- a/tests/test-io-channel-tls.c
+++ b/tests/test-io-channel-tls.c
@@ -203,10 +203,12 @@ static void test_io_channel_tls(const void *opaque)
     qio_channel_tls_handshake(clientChanTLS,
                               test_tls_handshake_done,
                               &clientHandshake,
+                              NULL,
                               NULL);
     qio_channel_tls_handshake(serverChanTLS,
                               test_tls_handshake_done,
                               &serverHandshake,
+                              NULL,
                               NULL);
 
     /*
diff --git a/ui/vnc-auth-vencrypt.c b/ui/vnc-auth-vencrypt.c
index 7833631275..d99ea362c1 100644
--- a/ui/vnc-auth-vencrypt.c
+++ b/ui/vnc-auth-vencrypt.c
@@ -128,6 +128,7 @@ static int protocol_client_vencrypt_auth(VncState *vs, uint8_t *data, size_t len
         qio_channel_tls_handshake(tls,
                                   vnc_tls_handshake_done,
                                   vs,
+                                  NULL,
                                   NULL);
     }
     return 0;
diff --git a/ui/vnc-ws.c b/ui/vnc-ws.c
index 6ccad22cef..950f1cd2ac 100644
--- a/ui/vnc-ws.c
+++ b/ui/vnc-ws.c
@@ -81,6 +81,7 @@ gboolean vncws_tls_handshake_io(QIOChannel *ioc G_GNUC_UNUSED,
     qio_channel_tls_handshake(tls,
                               vncws_tls_handshake_done,
                               vs,
+                              NULL,
                               NULL);
 
     return TRUE;
-- 
2.14.3
