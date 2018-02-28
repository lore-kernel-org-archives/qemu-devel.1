Received: from eggs.gnu.org ([2001:4830:134:3::10]:33568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqtxI-00081P-Ba
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:07:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eqtxH-0000hf-6a
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:07:04 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54546 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eqtxH-0000hV-1p
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:07:03 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1FF140FB650
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 05:07:02 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 28 Feb 2018 13:06:24 +0800
Message-Id: <20180228050633.7410-6-peterx@redhat.com>
In-Reply-To: <20180228050633.7410-1-peterx@redhat.com>
References: <20180228050633.7410-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 05/14] qio: refactor net listener source
 operations
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

Three functions are abstracted from the old code:

- qio_net_listener_source_add(): create one source for listener
- qio_net_listener_sources_clear(): unset existing net lister sources
- qio_net_listener_sources_update(): setup all sources for listener

Use them where possible.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 io/net-listener.c | 82 +++++++++++++++++++++++++++----------------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/io/net-listener.c b/io/net-listener.c
index de38dfae99..3e9ac51b0e 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -106,6 +106,39 @@ int qio_net_listener_open_sync(QIONetListener *listener,
     }
 }
 
+static guint qio_net_listener_source_add(QIONetListener *listener,
+                                         QIOChannelSocket *sioc)
+{
+    return qio_channel_add_watch(QIO_CHANNEL(sioc), G_IO_IN,
+                                 qio_net_listener_channel_func,
+                                 listener, (GDestroyNotify)object_unref);
+}
+
+static void qio_net_listener_sources_clear(QIONetListener *listener)
+{
+    size_t i;
+
+    for (i = 0; i < listener->nsioc; i++) {
+        if (listener->io_tag[i]) {
+            g_source_remove(listener->io_tag[i]);
+            listener->io_tag[i] = 0;
+        }
+    }
+}
+
+static void qio_net_listener_sources_update(QIONetListener *listener)
+{
+    size_t i;
+
+    if (listener->io_func != NULL) {
+        for (i = 0; i < listener->nsioc; i++) {
+            assert(listener->io_tag[i] == 0);
+            object_ref(OBJECT(listener));
+            listener->io_tag[i] = qio_net_listener_source_add(
+                listener, listener->sioc[i]);
+        }
+    }
+}
 
 void qio_net_listener_add(QIONetListener *listener,
                           QIOChannelSocket *sioc)
@@ -127,10 +160,8 @@ void qio_net_listener_add(QIONetListener *listener,
 
     if (listener->io_func != NULL) {
         object_ref(OBJECT(listener));
-        listener->io_tag[listener->nsioc] = qio_channel_add_watch(
-            QIO_CHANNEL(listener->sioc[listener->nsioc]), G_IO_IN,
-            qio_net_listener_channel_func,
-            listener, (GDestroyNotify)object_unref);
+        listener->io_tag[listener->nsioc] = qio_net_listener_source_add(
+            listener, listener->sioc[listener->nsioc]);
     }
 
     listener->nsioc++;
@@ -142,8 +173,6 @@ void qio_net_listener_set_client_func(QIONetListener *listener,
                                       gpointer data,
                                       GDestroyNotify notify)
 {
-    size_t i;
-
     if (listener->io_notify) {
         listener->io_notify(listener->io_data);
     }
@@ -151,22 +180,8 @@ void qio_net_listener_set_client_func(QIONetListener *listener,
     listener->io_data = data;
     listener->io_notify = notify;
 
-    for (i = 0; i < listener->nsioc; i++) {
-        if (listener->io_tag[i]) {
-            g_source_remove(listener->io_tag[i]);
-            listener->io_tag[i] = 0;
-        }
-    }
-
-    if (listener->io_func != NULL) {
-        for (i = 0; i < listener->nsioc; i++) {
-            object_ref(OBJECT(listener));
-            listener->io_tag[i] = qio_channel_add_watch(
-                QIO_CHANNEL(listener->sioc[i]), G_IO_IN,
-                qio_net_listener_channel_func,
-                listener, (GDestroyNotify)object_unref);
-        }
-    }
+    qio_net_listener_sources_clear(listener);
+    qio_net_listener_sources_update(listener);
 }
 
 
@@ -210,12 +225,7 @@ QIOChannelSocket *qio_net_listener_wait_client(QIONetListener *listener)
     };
     size_t i;
 
-    for (i = 0; i < listener->nsioc; i++) {
-        if (listener->io_tag[i]) {
-            g_source_remove(listener->io_tag[i]);
-            listener->io_tag[i] = 0;
-        }
-    }
+    qio_net_listener_sources_clear(listener);
 
     sources = g_new0(GSource *, listener->nsioc);
     for (i = 0; i < listener->nsioc; i++) {
@@ -238,15 +248,7 @@ QIOChannelSocket *qio_net_listener_wait_client(QIONetListener *listener)
     g_main_loop_unref(loop);
     g_main_context_unref(ctxt);
 
-    if (listener->io_func != NULL) {
-        for (i = 0; i < listener->nsioc; i++) {
-            object_ref(OBJECT(listener));
-            listener->io_tag[i] = qio_channel_add_watch(
-                QIO_CHANNEL(listener->sioc[i]), G_IO_IN,
-                qio_net_listener_channel_func,
-                listener, (GDestroyNotify)object_unref);
-        }
-    }
+    qio_net_listener_sources_update(listener);
 
     return data.sioc;
 }
@@ -259,11 +261,9 @@ void qio_net_listener_disconnect(QIONetListener *listener)
         return;
     }
 
+    qio_net_listener_sources_clear(listener);
+
     for (i = 0; i < listener->nsioc; i++) {
-        if (listener->io_tag[i]) {
-            g_source_remove(listener->io_tag[i]);
-            listener->io_tag[i] = 0;
-        }
         qio_channel_close(QIO_CHANNEL(listener->sioc[i]), NULL);
     }
     listener->connected = false;
-- 
2.14.3
