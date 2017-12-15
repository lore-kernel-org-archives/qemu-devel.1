Received: from eggs.gnu.org ([2001:4830:134:3::10]:58727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ePtQ5-00080e-EB
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ePtPy-0007wA-B5
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:05:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ePtPy-0007vJ-0n
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:05:02 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 15 Dec 2017 17:04:53 +0000
Message-Id: <20171215170453.8922-2-berrange@redhat.com>
In-Reply-To: <20171215170453.8922-1-berrange@redhat.com>
References: <20171215170453.8922-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 1/1] io: introduce a network socket listener
 API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

The existing QIOChannelSocket class provides the ability to
listen on a single socket at a time. This patch introduces
a QIONetListener class that provides a higher level API
concept around listening for network services, allowing
for listening on multiple sockets.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/io/net-listener.h | 174 ++++++++++++++++++++++++++
 io/Makefile.objs          |   1 +
 io/net-listener.c         | 307 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 482 insertions(+)
 create mode 100644 include/io/net-listener.h
 create mode 100644 io/net-listener.c

diff --git a/include/io/net-listener.h b/include/io/net-listener.h
new file mode 100644
index 0000000000..56d6da7a76
--- /dev/null
+++ b/include/io/net-listener.h
@@ -0,0 +1,174 @@
+/*
+ * QEMU network listener
+ *
+ * Copyright (c) 2016-2017 Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef QIO_NET_LISTENER_H
+#define QIO_NET_LISTENER_H
+
+#include "io/channel-socket.h"
+
+#define TYPE_QIO_NET_LISTENER "qio-net-listener"
+#define QIO_NET_LISTENER(obj)                                    \
+    OBJECT_CHECK(QIONetListener, (obj), TYPE_QIO_NET_LISTENER)
+#define QIO_NET_LISTENER_CLASS(klass)                                    \
+    OBJECT_CLASS_CHECK(QIONetListenerClass, klass, TYPE_QIO_NET_LISTENER)
+#define QIO_NET_LISTENER_GET_CLASS(obj)                                  \
+    OBJECT_GET_CLASS(QIONetListenerClass, obj, TYPE_QIO_NET_LISTENER)
+
+typedef struct QIONetListener QIONetListener;
+typedef struct QIONetListenerClass QIONetListenerClass;
+
+typedef void (*QIONetListenerClientFunc)(QIONetListener *listener,
+                                         QIOChannelSocket *sioc,
+                                         gpointer data);
+
+/**
+ * QIONetListener:
+ *
+ * The QIONetListener object encapsulates the management of a
+ * listening socket. It is able to listen on multiple sockets
+ * concurrently, to deal with the scenario where IPv4 / IPv6
+ * needs separate sockets, or there is a need to listen on a
+ * subset of interface IP addresses, instead of the wildcard
+ * address.
+ */
+struct QIONetListener {
+    Object parent;
+
+    char *name;
+    QIOChannelSocket **sioc;
+    gulong *io_tag;
+    size_t nsioc;
+
+    bool connected;
+
+    QIONetListenerClientFunc io_func;
+    gpointer io_data;
+    GDestroyNotify io_notify;
+};
+
+struct QIONetListenerClass {
+    ObjectClass parent;
+};
+
+
+/**
+ * qio_net_listener_new:
+ *
+ * Create a new network listener service, which is not
+ * listening on any sockets initially.
+ *
+ * Returns: the new listener
+ */
+QIONetListener *qio_net_listener_new(void);
+
+
+/**
+ * qio_net_listener_set_name:
+ * @listener: the network listener object
+ * @name: the listener name
+ *
+ * Set the name of the listener. This is used as a debugging
+ * aid, to set names on any GSource instances associated
+ * with the listener
+ */
+void qio_net_listener_set_name(QIONetListener *listener,
+                               const char *name);
+
+/**
+ * qio_net_listener_open_sync:
+ * @listener: the network listener object
+ * @addr: the address to listen on
+ * @errp: pointer to a NULL initialized error object
+ *
+ * Synchronously open a listening connection on all
+ * addresses associated with @addr. This method may
+ * also be invoked multiple times, in order to have a
+ * single listener on multiple distinct addresses.
+ */
+int qio_net_listener_open_sync(QIONetListener *listener,
+                               SocketAddress *addr,
+                               Error **errp);
+
+/**
+ * qio_net_listener_add:
+ * @listener: the network listener object
+ * @sioc: the socket I/O channel
+ *
+ * Associate a listening socket I/O channel with the
+ * listener. The listener will acquire a new reference
+ * on @sioc, so the caller should release its own reference
+ * if it no longer requires the object.
+ */
+void qio_net_listener_add(QIONetListener *listener,
+                          QIOChannelSocket *sioc);
+
+/**
+ * qio_net_listener_set_client_func:
+ * @listener: the network listener object
+ * @func: the callback function
+ * @data: opaque data to pass to @func
+ * @notify: callback to free @data
+ *
+ * Register @func to be invoked whenever a new client
+ * connects to the listener. @func will be invoked
+ * passing in the QIOChannelSocket instance for the
+ * client.
+ */
+void qio_net_listener_set_client_func(QIONetListener *listener,
+                                      QIONetListenerClientFunc func,
+                                      gpointer data,
+                                      GDestroyNotify notify);
+
+/**
+ * qio_net_listener_wait_client:
+ * @listener: the network listener object
+ *
+ * Block execution of the caller until a new client arrives
+ * on one of the listening sockets. If there was previously
+ * a callback registered with qio_net_listener_set_client_func
+ * it will be temporarily disabled, and re-enabled afterwards.
+ *
+ * Returns: the new client socket
+ */
+QIOChannelSocket *qio_net_listener_wait_client(QIONetListener *listener);
+
+
+/**
+ * qio_net_listener_disconnect:
+ * @listener: the network listener object
+ *
+ * Disconnect the listener, removing all I/O callback
+ * watches and closing the socket channels.
+ */
+void qio_net_listener_disconnect(QIONetListener *listener);
+
+
+/**
+ * qio_net_listener_is_connected:
+ * @listener: the network listener object
+ *
+ * Determine if the listener is connected to any socket
+ * channels
+ *
+ * Returns: true if connected, false otherwise
+ */
+bool qio_net_listener_is_connected(QIONetListener *listener);
+
+#endif /* QIO_NET_LISTENER_H */
diff --git a/io/Makefile.objs b/io/Makefile.objs
index 12983cca79..9a20fce4ed 100644
--- a/io/Makefile.objs
+++ b/io/Makefile.objs
@@ -8,4 +8,5 @@ io-obj-y += channel-watch.o
 io-obj-y += channel-websock.o
 io-obj-y += channel-util.o
 io-obj-y += dns-resolver.o
+io-obj-y += net-listener.o
 io-obj-y += task.o
diff --git a/io/net-listener.c b/io/net-listener.c
new file mode 100644
index 0000000000..77a4e2831c
--- /dev/null
+++ b/io/net-listener.c
@@ -0,0 +1,307 @@
+/*
+ * QEMU network listener
+ *
+ * Copyright (c) 2016-2017 Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "io/net-listener.h"
+#include "io/dns-resolver.h"
+#include "qapi/error.h"
+
+QIONetListener *qio_net_listener_new(void)
+{
+    QIONetListener *ret;
+
+    ret = QIO_NET_LISTENER(object_new(TYPE_QIO_NET_LISTENER));
+
+    return ret;
+}
+
+void qio_net_listener_set_name(QIONetListener *listener,
+                               const char *name)
+{
+    g_free(listener->name);
+    listener->name = g_strdup(name);
+}
+
+
+static gboolean qio_net_listener_channel_func(QIOChannel *ioc,
+                                              GIOCondition condition,
+                                              gpointer opaque)
+{
+    QIONetListener *listener = QIO_NET_LISTENER(opaque);
+    QIOChannelSocket *sioc;
+
+    sioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(ioc),
+                                     NULL);
+    if (!sioc) {
+        return TRUE;
+    }
+
+    if (listener->io_func) {
+        listener->io_func(listener, sioc, listener->io_data);
+    }
+
+    object_unref(OBJECT(sioc));
+
+    return TRUE;
+}
+
+
+int qio_net_listener_open_sync(QIONetListener *listener,
+                               SocketAddress *addr,
+                               Error **errp)
+{
+    QIODNSResolver *resolver = qio_dns_resolver_get_instance();
+    SocketAddress **resaddrs;
+    size_t nresaddrs;
+    size_t i;
+    Error *err = NULL;
+    bool success = false;
+
+    if (qio_dns_resolver_lookup_sync(resolver,
+                                     addr,
+                                     &nresaddrs,
+                                     &resaddrs,
+                                     errp) < 0) {
+        return -1;
+    }
+
+    for (i = 0; i < nresaddrs; i++) {
+        QIOChannelSocket *sioc = qio_channel_socket_new();
+
+        if (qio_channel_socket_listen_sync(sioc, resaddrs[i],
+                                           err ? NULL : &err) == 0) {
+            success = true;
+
+            qio_net_listener_add(listener, sioc);
+        }
+
+        qapi_free_SocketAddress(resaddrs[i]);
+        object_unref(OBJECT(sioc));
+    }
+    g_free(resaddrs);
+
+    if (success) {
+        error_free(err);
+        return 0;
+    } else {
+        error_propagate(errp, err);
+        return -1;
+    }
+}
+
+
+void qio_net_listener_add(QIONetListener *listener,
+                          QIOChannelSocket *sioc)
+{
+    if (listener->name) {
+        char *name = g_strdup_printf("%s-listen", listener->name);
+        qio_channel_set_name(QIO_CHANNEL(sioc), name);
+        g_free(name);
+    }
+
+    listener->sioc = g_renew(QIOChannelSocket *, listener->sioc,
+                             listener->nsioc + 1);
+    listener->io_tag = g_renew(gulong, listener->io_tag, listener->nsioc + 1);
+    listener->sioc[listener->nsioc] = sioc;
+    listener->io_tag[listener->nsioc] = 0;
+
+    object_ref(OBJECT(sioc));
+    listener->connected = true;
+
+    if (listener->io_func != NULL) {
+        object_ref(OBJECT(listener));
+        listener->io_tag[listener->nsioc] = qio_channel_add_watch(
+            QIO_CHANNEL(listener->sioc[listener->nsioc]), G_IO_IN,
+            qio_net_listener_channel_func,
+            listener, (GDestroyNotify)object_unref);
+    }
+
+    listener->nsioc++;
+}
+
+
+void qio_net_listener_set_client_func(QIONetListener *listener,
+                                      QIONetListenerClientFunc func,
+                                      gpointer data,
+                                      GDestroyNotify notify)
+{
+    size_t i;
+
+    if (listener->io_notify) {
+        listener->io_notify(listener->io_data);
+    }
+    listener->io_func = func;
+    listener->io_data = data;
+    listener->io_notify = notify;
+
+    for (i = 0; i < listener->nsioc; i++) {
+        if (listener->io_tag[i]) {
+            g_source_remove(listener->io_tag[i]);
+            listener->io_tag[i] = 0;
+        }
+    }
+
+    if (listener->io_func != NULL) {
+        for (i = 0; i < listener->nsioc; i++) {
+            object_ref(OBJECT(listener));
+            listener->io_tag[i] = qio_channel_add_watch(
+                QIO_CHANNEL(listener->sioc[i]), G_IO_IN,
+                qio_net_listener_channel_func,
+                listener, (GDestroyNotify)object_unref);
+        }
+    }
+}
+
+
+struct QIONetListenerClientWaitData {
+    QIOChannelSocket *sioc;
+    GMainLoop *loop;
+};
+
+
+static gboolean qio_net_listener_wait_client_func(QIOChannel *ioc,
+                                                  GIOCondition condition,
+                                                  gpointer opaque)
+{
+    struct QIONetListenerClientWaitData *data = opaque;
+    QIOChannelSocket *sioc;
+
+    sioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(ioc),
+                                     NULL);
+    if (!sioc) {
+        return TRUE;
+    }
+
+    if (data->sioc) {
+        object_unref(OBJECT(sioc));
+    } else {
+        data->sioc = sioc;
+        g_main_loop_quit(data->loop);
+    }
+
+    return TRUE;
+}
+
+QIOChannelSocket *qio_net_listener_wait_client(QIONetListener *listener)
+{
+    GMainContext *ctxt = g_main_context_new();
+    GMainLoop *loop = g_main_loop_new(ctxt, TRUE);
+    GSource **sources;
+    struct QIONetListenerClientWaitData data = {
+        .sioc = NULL,
+        .loop = loop
+    };
+    size_t i;
+
+    for (i = 0; i < listener->nsioc; i++) {
+        if (listener->io_tag[i]) {
+            g_source_remove(listener->io_tag[i]);
+            listener->io_tag[i] = 0;
+        }
+    }
+
+    sources = g_new0(GSource *, listener->nsioc);
+    for (i = 0; i < listener->nsioc; i++) {
+        sources[i] = qio_channel_create_watch(QIO_CHANNEL(listener->sioc[i]),
+                                              G_IO_IN);
+
+        g_source_set_callback(sources[i],
+                              (GSourceFunc)qio_net_listener_wait_client_func,
+                              &data,
+                              NULL);
+        g_source_attach(sources[i], ctxt);
+    }
+
+    g_main_loop_run(loop);
+
+    for (i = 0; i < listener->nsioc; i++) {
+        g_source_unref(sources[i]);
+    }
+    g_main_loop_unref(loop);
+    g_main_context_unref(ctxt);
+
+    if (listener->io_func != NULL) {
+        for (i = 0; i < listener->nsioc; i++) {
+            object_ref(OBJECT(listener));
+            listener->io_tag[i] = qio_channel_add_watch(
+                QIO_CHANNEL(listener->sioc[i]), G_IO_IN,
+                qio_net_listener_channel_func,
+                listener, (GDestroyNotify)object_unref);
+        }
+    }
+
+    return data.sioc;
+}
+
+void qio_net_listener_disconnect(QIONetListener *listener)
+{
+    size_t i;
+
+    if (!listener->connected) {
+        return;
+    }
+
+    for (i = 0; i < listener->nsioc; i++) {
+        if (listener->io_tag[i]) {
+            g_source_remove(listener->io_tag[i]);
+            listener->io_tag[i] = 0;
+        }
+        qio_channel_close(QIO_CHANNEL(listener->sioc[i]), NULL);
+    }
+    listener->connected = false;
+}
+
+
+bool qio_net_listener_is_connected(QIONetListener *listener)
+{
+    return listener->connected;
+}
+
+static void qio_net_listener_finalize(Object *obj)
+{
+    QIONetListener *listener = QIO_NET_LISTENER(obj);
+    size_t i;
+
+    qio_net_listener_disconnect(listener);
+
+    for (i = 0; i < listener->nsioc; i++) {
+        object_unref(OBJECT(listener->sioc[i]));
+    }
+    g_free(listener->io_tag);
+    g_free(listener->sioc);
+    g_free(listener->name);
+}
+
+static const TypeInfo qio_net_listener_info = {
+    .parent = TYPE_OBJECT,
+    .name = TYPE_QIO_NET_LISTENER,
+    .instance_size = sizeof(QIONetListener),
+    .instance_finalize = qio_net_listener_finalize,
+    .class_size = sizeof(QIONetListenerClass),
+};
+
+
+static void qio_net_listener_register_types(void)
+{
+    type_register_static(&qio_net_listener_info);
+}
+
+
+type_init(qio_net_listener_register_types);
-- 
2.14.3
