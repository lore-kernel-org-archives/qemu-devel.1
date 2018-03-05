Received: from eggs.gnu.org ([2001:4830:134:3::10]:45527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1esjqc-0002l7-BQ
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:43:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1esjqb-0005va-7k
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:43:46 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35398 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1esjqb-0005v2-1p
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 01:43:45 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8EC928D6C7
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 06:43:44 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon,  5 Mar 2018 14:43:21 +0800
Message-Id: <20180305064324.9238-4-peterx@redhat.com>
In-Reply-To: <20180305064324.9238-1-peterx@redhat.com>
References: <20180305064324.9238-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/6] qio: store gsources for net listeners
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

Originally we were storing the GSources tag IDs.  That'll be not enough
if we are going to support non-default gcontext for QIO code.  Switch to
GSources without changing anything real.  Now we still always pass in
NULL, which means the default gcontext.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/io/net-listener.h | 22 ++++++++++++++++--
 io/net-listener.c         | 58 +++++++++++++++++++++++++++++------------------
 2 files changed, 56 insertions(+), 24 deletions(-)

diff --git a/include/io/net-listener.h b/include/io/net-listener.h
index 56d6da7a76..8081ac58a2 100644
--- a/include/io/net-listener.h
+++ b/include/io/net-listener.h
@@ -53,7 +53,7 @@ struct QIONetListener {
 
     char *name;
     QIOChannelSocket **sioc;
-    gulong *io_tag;
+    GSource **io_source;
     size_t nsioc;
 
     bool connected;
@@ -120,17 +120,35 @@ void qio_net_listener_add(QIONetListener *listener,
                           QIOChannelSocket *sioc);
 
 /**
- * qio_net_listener_set_client_func:
+ * qio_net_listener_set_client_func_full:
  * @listener: the network listener object
  * @func: the callback function
  * @data: opaque data to pass to @func
  * @notify: callback to free @data
+ * @context: the context that the sources will be bound to.  If %NULL,
+ *           the default context will be used.
  *
  * Register @func to be invoked whenever a new client
  * connects to the listener. @func will be invoked
  * passing in the QIOChannelSocket instance for the
  * client.
  */
+void qio_net_listener_set_client_func_full(QIONetListener *listener,
+                                           QIONetListenerClientFunc func,
+                                           gpointer data,
+                                           GDestroyNotify notify,
+                                           GMainContext *context);
+
+/**
+ * qio_net_listener_set_client_func:
+ * @listener: the network listener object
+ * @func: the callback function
+ * @data: opaque data to pass to @func
+ * @notify: callback to free @data
+ *
+ * Wrapper of qio_net_listener_set_client_func_full(), only that the
+ * sources will always be bound to default main context.
+ */
 void qio_net_listener_set_client_func(QIONetListener *listener,
                                       QIONetListenerClientFunc func,
                                       gpointer data,
diff --git a/io/net-listener.c b/io/net-listener.c
index de38dfae99..555e8acaa4 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -118,29 +118,32 @@ void qio_net_listener_add(QIONetListener *listener,
 
     listener->sioc = g_renew(QIOChannelSocket *, listener->sioc,
                              listener->nsioc + 1);
-    listener->io_tag = g_renew(gulong, listener->io_tag, listener->nsioc + 1);
+    listener->io_source = g_renew(typeof(listener->io_source[0]),
+                                  listener->io_source,
+                                  listener->nsioc + 1);
     listener->sioc[listener->nsioc] = sioc;
-    listener->io_tag[listener->nsioc] = 0;
+    listener->io_source[listener->nsioc] = NULL;
 
     object_ref(OBJECT(sioc));
     listener->connected = true;
 
     if (listener->io_func != NULL) {
         object_ref(OBJECT(listener));
-        listener->io_tag[listener->nsioc] = qio_channel_add_watch(
+        listener->io_source[listener->nsioc] = qio_channel_add_watch_source(
             QIO_CHANNEL(listener->sioc[listener->nsioc]), G_IO_IN,
             qio_net_listener_channel_func,
-            listener, (GDestroyNotify)object_unref);
+            listener, (GDestroyNotify)object_unref, NULL);
     }
 
     listener->nsioc++;
 }
 
 
-void qio_net_listener_set_client_func(QIONetListener *listener,
-                                      QIONetListenerClientFunc func,
-                                      gpointer data,
-                                      GDestroyNotify notify)
+void qio_net_listener_set_client_func_full(QIONetListener *listener,
+                                           QIONetListenerClientFunc func,
+                                           gpointer data,
+                                           GDestroyNotify notify,
+                                           GMainContext *context)
 {
     size_t i;
 
@@ -152,23 +155,32 @@ void qio_net_listener_set_client_func(QIONetListener *listener,
     listener->io_notify = notify;
 
     for (i = 0; i < listener->nsioc; i++) {
-        if (listener->io_tag[i]) {
-            g_source_remove(listener->io_tag[i]);
-            listener->io_tag[i] = 0;
+        if (listener->io_source[i]) {
+            g_source_destroy(listener->io_source[i]);
+            g_source_unref(listener->io_source[i]);
+            listener->io_source[i] = NULL;
         }
     }
 
     if (listener->io_func != NULL) {
         for (i = 0; i < listener->nsioc; i++) {
             object_ref(OBJECT(listener));
-            listener->io_tag[i] = qio_channel_add_watch(
+            listener->io_source[i] = qio_channel_add_watch_source(
                 QIO_CHANNEL(listener->sioc[i]), G_IO_IN,
                 qio_net_listener_channel_func,
-                listener, (GDestroyNotify)object_unref);
+                listener, (GDestroyNotify)object_unref, context);
         }
     }
 }
 
+void qio_net_listener_set_client_func(QIONetListener *listener,
+                                      QIONetListenerClientFunc func,
+                                      gpointer data,
+                                      GDestroyNotify notify)
+{
+    qio_net_listener_set_client_func_full(listener, func, data,
+                                          notify, NULL);
+}
 
 struct QIONetListenerClientWaitData {
     QIOChannelSocket *sioc;
@@ -211,9 +223,10 @@ QIOChannelSocket *qio_net_listener_wait_client(QIONetListener *listener)
     size_t i;
 
     for (i = 0; i < listener->nsioc; i++) {
-        if (listener->io_tag[i]) {
-            g_source_remove(listener->io_tag[i]);
-            listener->io_tag[i] = 0;
+        if (listener->io_source[i]) {
+            g_source_destroy(listener->io_source[i]);
+            g_source_unref(listener->io_source[i]);
+            listener->io_source[i] = NULL;
         }
     }
 
@@ -241,10 +254,10 @@ QIOChannelSocket *qio_net_listener_wait_client(QIONetListener *listener)
     if (listener->io_func != NULL) {
         for (i = 0; i < listener->nsioc; i++) {
             object_ref(OBJECT(listener));
-            listener->io_tag[i] = qio_channel_add_watch(
+            listener->io_source[i] = qio_channel_add_watch_source(
                 QIO_CHANNEL(listener->sioc[i]), G_IO_IN,
                 qio_net_listener_channel_func,
-                listener, (GDestroyNotify)object_unref);
+                listener, (GDestroyNotify)object_unref, NULL);
         }
     }
 
@@ -260,9 +273,10 @@ void qio_net_listener_disconnect(QIONetListener *listener)
     }
 
     for (i = 0; i < listener->nsioc; i++) {
-        if (listener->io_tag[i]) {
-            g_source_remove(listener->io_tag[i]);
-            listener->io_tag[i] = 0;
+        if (listener->io_source[i]) {
+            g_source_destroy(listener->io_source[i]);
+            g_source_unref(listener->io_source[i]);
+            listener->io_source[i] = NULL;
         }
         qio_channel_close(QIO_CHANNEL(listener->sioc[i]), NULL);
     }
@@ -285,7 +299,7 @@ static void qio_net_listener_finalize(Object *obj)
     for (i = 0; i < listener->nsioc; i++) {
         object_unref(OBJECT(listener->sioc[i]));
     }
-    g_free(listener->io_tag);
+    g_free(listener->io_source);
     g_free(listener->sioc);
     g_free(listener->name);
 }
-- 
2.14.3
