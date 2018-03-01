Received: from eggs.gnu.org ([2001:4830:134:3::10]:52514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erJqH-0008A7-Op
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:45:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erJqC-0007CD-Rr
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:45:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42100 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1erJqC-0007C4-JU
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:45:28 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 07AC4FB640
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 08:45:28 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu,  1 Mar 2018 16:44:29 +0800
Message-Id: <20180301084438.13594-7-peterx@redhat.com>
In-Reply-To: <20180301084438.13594-1-peterx@redhat.com>
References: <20180301084438.13594-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 06/15] qio: store gsources for net listeners
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

Originally we were storing the GSources tag IDs.  That'll be not enough
if we are going to support non-default gcontext for QIO code.  Switch to
GSources without changing anything real.  Now we still always pass in
NULL, which means the default gcontext.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/io/net-listener.h | 21 ++++++++++++++--
 io/net-listener.c         | 62 +++++++++++++++++++++++++++++------------------
 2 files changed, 58 insertions(+), 25 deletions(-)

diff --git a/include/io/net-listener.h b/include/io/net-listener.h
index 56d6da7a76..566be283b3 100644
--- a/include/io/net-listener.h
+++ b/include/io/net-listener.h
@@ -53,7 +53,7 @@ struct QIONetListener {
 
     char *name;
     QIOChannelSocket **sioc;
-    gulong *io_tag;
+    GSource **io_source;
     size_t nsioc;
 
     bool connected;
@@ -120,17 +120,34 @@ void qio_net_listener_add(QIONetListener *listener,
                           QIOChannelSocket *sioc);
 
 /**
- * qio_net_listener_set_client_func:
+ * qio_net_listener_set_client_func_full:
  * @listener: the network listener object
  * @func: the callback function
  * @data: opaque data to pass to @func
  * @notify: callback to free @data
+ * @context: the context that the sources will be bound to
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
index 3e9ac51b0e..14fd47db6c 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -106,12 +106,15 @@ int qio_net_listener_open_sync(QIONetListener *listener,
     }
 }
 
-static guint qio_net_listener_source_add(QIONetListener *listener,
-                                         QIOChannelSocket *sioc)
+static GSource *qio_net_listener_source_add(QIONetListener *listener,
+                                            QIOChannelSocket *sioc,
+                                            GMainContext *context)
 {
-    return qio_channel_add_watch(QIO_CHANNEL(sioc), G_IO_IN,
-                                 qio_net_listener_channel_func,
-                                 listener, (GDestroyNotify)object_unref);
+    return qio_channel_add_watch_source(QIO_CHANNEL(sioc), G_IO_IN,
+                                        qio_net_listener_channel_func,
+                                        listener,
+                                        (GDestroyNotify)object_unref,
+                                        context);
 }
 
 static void qio_net_listener_sources_clear(QIONetListener *listener)
@@ -119,23 +122,25 @@ static void qio_net_listener_sources_clear(QIONetListener *listener)
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
 }
 
-static void qio_net_listener_sources_update(QIONetListener *listener)
+static void qio_net_listener_sources_update(QIONetListener *listener,
+                                            GMainContext *context)
 {
     size_t i;
 
     if (listener->io_func != NULL) {
         for (i = 0; i < listener->nsioc; i++) {
-            assert(listener->io_tag[i] == 0);
+            assert(listener->io_source[i] == NULL);
             object_ref(OBJECT(listener));
-            listener->io_tag[i] = qio_net_listener_source_add(
-                listener, listener->sioc[i]);
+            listener->io_source[i] = qio_net_listener_source_add(
+                listener, listener->sioc[i], context);
         }
     }
 }
@@ -151,27 +156,30 @@ void qio_net_listener_add(QIONetListener *listener,
 
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
-        listener->io_tag[listener->nsioc] = qio_net_listener_source_add(
-            listener, listener->sioc[listener->nsioc]);
+        listener->io_source[listener->nsioc] = qio_net_listener_source_add(
+            listener, listener->sioc[listener->nsioc], NULL);
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
     if (listener->io_notify) {
         listener->io_notify(listener->io_data);
@@ -181,9 +189,17 @@ void qio_net_listener_set_client_func(QIONetListener *listener,
     listener->io_notify = notify;
 
     qio_net_listener_sources_clear(listener);
-    qio_net_listener_sources_update(listener);
+    qio_net_listener_sources_update(listener, context);
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
@@ -248,7 +264,7 @@ QIOChannelSocket *qio_net_listener_wait_client(QIONetListener *listener)
     g_main_loop_unref(loop);
     g_main_context_unref(ctxt);
 
-    qio_net_listener_sources_update(listener);
+    qio_net_listener_sources_update(listener, NULL);
 
     return data.sioc;
 }
@@ -285,7 +301,7 @@ static void qio_net_listener_finalize(Object *obj)
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
