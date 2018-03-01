Received: from eggs.gnu.org ([2001:4830:134:3::10]:52600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erJqd-0008VZ-Ok
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:45:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erJqc-0007Nk-LJ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:45:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42120 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1erJqc-0007NS-FM
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:45:54 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D492F87ABA
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 08:45:53 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu,  1 Mar 2018 16:44:34 +0800
Message-Id: <20180301084438.13594-12-peterx@redhat.com>
In-Reply-To: <20180301084438.13594-1-peterx@redhat.com>
References: <20180301084438.13594-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 11/15] qio: non-default context for TLS
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

qio_channel_tls_handshake_full() is introduced to allow the TLS to be
run on a non-default context.  Still, no functional change.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/io/channel-tls.h | 17 ++++++++++++++++
 io/channel-tls.c         | 51 +++++++++++++++++++++++++++++++++++-------------
 2 files changed, 54 insertions(+), 14 deletions(-)

diff --git a/include/io/channel-tls.h b/include/io/channel-tls.h
index d157eb10e8..d6f5271088 100644
--- a/include/io/channel-tls.h
+++ b/include/io/channel-tls.h
@@ -128,6 +128,23 @@ void qio_channel_tls_handshake(QIOChannelTLS *ioc,
                                gpointer opaque,
                                GDestroyNotify destroy);
 
+/**
+ * qio_channel_tls_handshake_full:
+ * @ioc: the TLS channel object
+ * @func: the callback to invoke when completed
+ * @opaque: opaque data to pass to @func
+ * @destroy: optional callback to free @opaque
+ * @context: the context that TLS handshake will run with
+ *
+ * Similar to qio_channel_tls_handshake(), but allows the task to be
+ * run on a specific context.
+ */
+void qio_channel_tls_handshake_full(QIOChannelTLS *ioc,
+                                    QIOTaskFunc func,
+                                    gpointer opaque,
+                                    GDestroyNotify destroy,
+                                    GMainContext *context);
+
 /**
  * qio_channel_tls_get_session:
  * @ioc: the TLS channel object
diff --git a/io/channel-tls.c b/io/channel-tls.c
index 6182702dab..4fe03d9c6c 100644
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
@@ -171,6 +177,11 @@ static void qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
         qio_task_complete(task);
     } else {
         GIOCondition condition;
+        QIOChannelTLSData *data = g_new0(typeof(*data), 1);
+
+        data->task = task;
+        data->context = context;
+
         if (status == QCRYPTO_TLS_HANDSHAKE_SENDING) {
             condition = G_IO_OUT;
         } else {
@@ -178,11 +189,12 @@ static void qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
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
 
@@ -191,20 +203,23 @@ static gboolean qio_channel_tls_handshake_io(QIOChannel *ioc,
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
 
     return FALSE;
 }
 
-void qio_channel_tls_handshake(QIOChannelTLS *ioc,
-                               QIOTaskFunc func,
-                               gpointer opaque,
-                               GDestroyNotify destroy)
+void qio_channel_tls_handshake_full(QIOChannelTLS *ioc,
+                                    QIOTaskFunc func,
+                                    gpointer opaque,
+                                    GDestroyNotify destroy,
+                                    GMainContext *context)
 {
     QIOTask *task;
 
@@ -212,7 +227,15 @@ void qio_channel_tls_handshake(QIOChannelTLS *ioc,
                         func, opaque, destroy);
 
     trace_qio_channel_tls_handshake_start(ioc);
-    qio_channel_tls_handshake_task(ioc, task);
+    qio_channel_tls_handshake_task(ioc, task, context);
+}
+
+void qio_channel_tls_handshake(QIOChannelTLS *ioc,
+                               QIOTaskFunc func,
+                               gpointer opaque,
+                               GDestroyNotify destroy)
+{
+    qio_channel_tls_handshake_full(ioc, func, opaque, destroy, NULL);
 }
 
 
-- 
2.14.3
