Received: from eggs.gnu.org ([2001:4830:134:3::10]:38036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etXCi-0002Jj-Bw
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:25:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etXCh-0000Pt-1M
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:25:52 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed,  7 Mar 2018 11:25:29 +0000
Message-Id: <20180307112532.24248-4-berrange@redhat.com>
In-Reply-To: <20180307112532.24248-1-berrange@redhat.com>
References: <20180307112532.24248-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/6] qio: store gsources for net listeners
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

Originally we were storing the GSources tag IDs.  That'll be not enough
if we are going to support non-default gcontext for QIO code.  Switch to
GSources without changing anything real.  Now we still always pass in
NULL, which means the default gcontext.

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 include/io/net-listener.h | 22 ++++++++++++++++--
 io/net-listener.c         | 58 +++++++++++++++++++++++++++++------------=
------
 2 files changed, 56 insertions(+), 24 deletions(-)

diff --git a/include/io/net-listener.h b/include/io/net-listener.h
index 56d6da7a76..8081ac58a2 100644
--- a/include/io/net-listener.h
+++ b/include/io/net-listener.h
@@ -53,7 +53,7 @@ struct QIONetListener {
=20
     char *name;
     QIOChannelSocket **sioc;
-    gulong *io_tag;
+    GSource **io_source;
     size_t nsioc;
=20
     bool connected;
@@ -120,17 +120,35 @@ void qio_net_listener_add(QIONetListener *listener,
                           QIOChannelSocket *sioc);
=20
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
+                                           QIONetListenerClientFunc func=
,
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
=20
     listener->sioc =3D g_renew(QIOChannelSocket *, listener->sioc,
                              listener->nsioc + 1);
-    listener->io_tag =3D g_renew(gulong, listener->io_tag, listener->nsi=
oc + 1);
+    listener->io_source =3D g_renew(typeof(listener->io_source[0]),
+                                  listener->io_source,
+                                  listener->nsioc + 1);
     listener->sioc[listener->nsioc] =3D sioc;
-    listener->io_tag[listener->nsioc] =3D 0;
+    listener->io_source[listener->nsioc] =3D NULL;
=20
     object_ref(OBJECT(sioc));
     listener->connected =3D true;
=20
     if (listener->io_func !=3D NULL) {
         object_ref(OBJECT(listener));
-        listener->io_tag[listener->nsioc] =3D qio_channel_add_watch(
+        listener->io_source[listener->nsioc] =3D qio_channel_add_watch_s=
ource(
             QIO_CHANNEL(listener->sioc[listener->nsioc]), G_IO_IN,
             qio_net_listener_channel_func,
-            listener, (GDestroyNotify)object_unref);
+            listener, (GDestroyNotify)object_unref, NULL);
     }
=20
     listener->nsioc++;
 }
=20
=20
-void qio_net_listener_set_client_func(QIONetListener *listener,
-                                      QIONetListenerClientFunc func,
-                                      gpointer data,
-                                      GDestroyNotify notify)
+void qio_net_listener_set_client_func_full(QIONetListener *listener,
+                                           QIONetListenerClientFunc func=
,
+                                           gpointer data,
+                                           GDestroyNotify notify,
+                                           GMainContext *context)
 {
     size_t i;
=20
@@ -152,23 +155,32 @@ void qio_net_listener_set_client_func(QIONetListene=
r *listener,
     listener->io_notify =3D notify;
=20
     for (i =3D 0; i < listener->nsioc; i++) {
-        if (listener->io_tag[i]) {
-            g_source_remove(listener->io_tag[i]);
-            listener->io_tag[i] =3D 0;
+        if (listener->io_source[i]) {
+            g_source_destroy(listener->io_source[i]);
+            g_source_unref(listener->io_source[i]);
+            listener->io_source[i] =3D NULL;
         }
     }
=20
     if (listener->io_func !=3D NULL) {
         for (i =3D 0; i < listener->nsioc; i++) {
             object_ref(OBJECT(listener));
-            listener->io_tag[i] =3D qio_channel_add_watch(
+            listener->io_source[i] =3D qio_channel_add_watch_source(
                 QIO_CHANNEL(listener->sioc[i]), G_IO_IN,
                 qio_net_listener_channel_func,
-                listener, (GDestroyNotify)object_unref);
+                listener, (GDestroyNotify)object_unref, context);
         }
     }
 }
=20
+void qio_net_listener_set_client_func(QIONetListener *listener,
+                                      QIONetListenerClientFunc func,
+                                      gpointer data,
+                                      GDestroyNotify notify)
+{
+    qio_net_listener_set_client_func_full(listener, func, data,
+                                          notify, NULL);
+}
=20
 struct QIONetListenerClientWaitData {
     QIOChannelSocket *sioc;
@@ -211,9 +223,10 @@ QIOChannelSocket *qio_net_listener_wait_client(QIONe=
tListener *listener)
     size_t i;
=20
     for (i =3D 0; i < listener->nsioc; i++) {
-        if (listener->io_tag[i]) {
-            g_source_remove(listener->io_tag[i]);
-            listener->io_tag[i] =3D 0;
+        if (listener->io_source[i]) {
+            g_source_destroy(listener->io_source[i]);
+            g_source_unref(listener->io_source[i]);
+            listener->io_source[i] =3D NULL;
         }
     }
=20
@@ -241,10 +254,10 @@ QIOChannelSocket *qio_net_listener_wait_client(QION=
etListener *listener)
     if (listener->io_func !=3D NULL) {
         for (i =3D 0; i < listener->nsioc; i++) {
             object_ref(OBJECT(listener));
-            listener->io_tag[i] =3D qio_channel_add_watch(
+            listener->io_source[i] =3D qio_channel_add_watch_source(
                 QIO_CHANNEL(listener->sioc[i]), G_IO_IN,
                 qio_net_listener_channel_func,
-                listener, (GDestroyNotify)object_unref);
+                listener, (GDestroyNotify)object_unref, NULL);
         }
     }
=20
@@ -260,9 +273,10 @@ void qio_net_listener_disconnect(QIONetListener *lis=
tener)
     }
=20
     for (i =3D 0; i < listener->nsioc; i++) {
-        if (listener->io_tag[i]) {
-            g_source_remove(listener->io_tag[i]);
-            listener->io_tag[i] =3D 0;
+        if (listener->io_source[i]) {
+            g_source_destroy(listener->io_source[i]);
+            g_source_unref(listener->io_source[i]);
+            listener->io_source[i] =3D NULL;
         }
         qio_channel_close(QIO_CHANNEL(listener->sioc[i]), NULL);
     }
@@ -285,7 +299,7 @@ static void qio_net_listener_finalize(Object *obj)
     for (i =3D 0; i < listener->nsioc; i++) {
         object_unref(OBJECT(listener->sioc[i]));
     }
-    g_free(listener->io_tag);
+    g_free(listener->io_source);
     g_free(listener->sioc);
     g_free(listener->name);
 }
--=20
2.14.3
