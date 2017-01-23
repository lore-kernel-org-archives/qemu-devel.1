Received: from eggs.gnu.org ([2001:4830:134:3::10]:43863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVfa8-0001Dv-Ty
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:26:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVfa5-0006NA-Ub
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:26:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cVfa5-0006Mx-MT
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:26:49 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 23 Jan 2017 14:26:29 +0000
Message-Id: <20170123142629.11110-9-berrange@redhat.com>
In-Reply-To: <20170123142629.11110-1-berrange@redhat.com>
References: <20170123142629.11110-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 8/8] io: introduce a DNS resolver API
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

Currently DNS resolution is done automatically as part
of the creation of a QIOChannelSocket object instance.
This works ok for network clients where you just end
up a single network socket, but for servers, the results
of DNS resolution may require creation of multiple
sockets.

Introducing a DNS resolver API allows DNS resolution
to be separated from the socket object creation. This
will make it practical to create multiple QIOChannelSocket
instances for servers.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/io/dns-resolver.h | 228 ++++++++++++++++++++++++++++++++++++++
 include/qemu/sockets.h    |   2 +
 io/Makefile.objs          |   1 +
 io/dns-resolver.c         | 272 ++++++++++++++++++++++++++++++++++++++++++++++
 util/qemu-sockets.c       |   4 +-
 5 files changed, 505 insertions(+), 2 deletions(-)
 create mode 100644 include/io/dns-resolver.h
 create mode 100644 io/dns-resolver.c

diff --git a/include/io/dns-resolver.h b/include/io/dns-resolver.h
new file mode 100644
index 0000000..2f69c08
--- /dev/null
+++ b/include/io/dns-resolver.h
@@ -0,0 +1,228 @@
+/*
+ * QEMU DNS resolver
+ *
+ * Copyright (c) 2016-2017 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef QIO_DNS_RESOLVER_H
+#define QIO_DNS_RESOLVER_H
+
+#include "qemu-common.h"
+#include "qom/object.h"
+#include "io/task.h"
+
+#define TYPE_QIO_DNS_RESOLVER "qio-dns-resolver"
+#define QIO_DNS_RESOLVER(obj)                                    \
+    OBJECT_CHECK(QIODNSResolver, (obj), TYPE_QIO_DNS_RESOLVER)
+#define QIO_DNS_RESOLVER_CLASS(klass)                                    \
+    OBJECT_CLASS_CHECK(QIODNSResolverClass, klass, TYPE_QIO_DNS_RESOLVER)
+#define QIO_DNS_RESOLVER_GET_CLASS(obj)                                  \
+    OBJECT_GET_CLASS(QIODNSResolverClass, obj, TYPE_QIO_DNS_RESOLVER)
+
+typedef struct QIODNSResolver QIODNSResolver;
+typedef struct QIODNSResolverClass QIODNSResolverClass;
+
+/**
+ * QIODNSResolver:
+ *
+ * The QIODNSResolver class provides a framework for doing
+ * DNS resolution on SocketAddress objects, independently
+ * of socket creation.
+ *
+ * <example>
+ *   <title>Resolving addresses synchronously</title>
+ *   <programlisting>
+ *    int mylisten(SocketAddress *addr, Error **errp) {
+ *      QIODNSResolver *resolver = qio_dns_resolver_get_instance();
+ *      SocketAddress **rawaddrs = NULL;
+ *      size_t nrawaddrs = 0;
+ *      Error *err = NULL;
+ *      QIOChannel **socks = NULL;
+ *      size_t nsocks = 0;
+ *
+ *      if (qio_dns_resolver_lookup_sync(dns, addr, &nrawaddrs,
+ *                                       &rawaddrs, errp) < 0) {
+ *          return -1;
+ *      }
+ *
+ *      for (i = 0; i < nrawaddrs; i++) {
+ *         QIOChannel *sock = qio_channel_new();
+ *         Error *local_err = NULL;
+ *         qio_channel_listen_sync(sock, rawaddrs[i], &local_err);
+ *         if (local_err) {
+ *            error_propagate(&err, local_err);
+ *         } else {
+ *            socks = g_renew(QIOChannelSocket *, socks, nsocks + 1);
+ *            socks[nsocks++] = sock;
+ *         }
+ *         qapi_free_SocketAddress(rawaddrs[i]);
+ *      }
+ *      g_free(rawaddrs);
+ *
+ *      if (nsocks == 0) {
+ *         error_propagate(errp, err);
+ *      } else {
+ *         error_free(err);
+ *      }
+ *   }
+ *   </programlisting>
+ * </example>
+ *
+ * <example>
+ *   <title>Resolving addresses asynchronously</title>
+ *   <programlisting>
+ *    typedef struct MyListenData {
+ *       Error *err;
+ *       QIOChannelSocket **socks;
+ *       size_t nsocks;
+ *    } MyListenData;
+ *
+ *    void mylistenresult(QIOTask *task, void *opaque) {
+ *      MyListenData *data = opaque;
+ *      QIODNSResolver *resolver =
+ *         QIO_DNS_RESOLVER(qio_task_get_source(task);
+ *      SocketAddress **rawaddrs = NULL;
+ *      size_t nrawaddrs = 0;
+ *      Error *err = NULL;
+ *
+ *      if (qio_task_propagate_error(task, &data->err)) {
+ *         return;
+ *      }
+ *
+ *      qio_dns_resolver_lookup_result(resolver, task,
+ *                                     &nrawaddrs, &rawaddrs);
+ *
+ *      for (i = 0; i < nrawaddrs; i++) {
+ *         QIOChannel *sock = qio_channel_new();
+ *         Error *local_err = NULL;
+ *         qio_channel_listen_sync(sock, rawaddrs[i], &local_err);
+ *         if (local_err) {
+ *            error_propagate(&err, local_err);
+ *         } else {
+ *            socks = g_renew(QIOChannelSocket *, socks, nsocks + 1);
+ *            socks[nsocks++] = sock;
+ *         }
+ *         qapi_free_SocketAddress(rawaddrs[i]);
+ *      }
+ *      g_free(rawaddrs);
+ *
+ *      if (nsocks == 0) {
+ *         error_propagate(&data->err, err);
+ *      } else {
+ *         error_free(err);
+ *      }
+ *    }
+ *
+ *    void mylisten(SocketAddress *addr, MyListenData *data) {
+ *      QIODNSResolver *resolver = qio_dns_resolver_get_instance();
+ *      qio_dns_resolver_lookup_async(dns, addr,
+ *                                    mylistenresult, data, NULL);
+ *    }
+ *   </programlisting>
+ * </example>
+ */
+struct QIODNSResolver {
+    Object parent;
+};
+
+struct QIODNSResolverClass {
+    ObjectClass parent;
+};
+
+
+/**
+ * qio_dns_resolver_get_instance:
+ *
+ * Get the singleton dns resolver instance. The caller
+ * does not own a reference on the returned object.
+ *
+ * Returns: the single dns resolver instance
+ */
+QIODNSResolver *qio_dns_resolver_get_instance(void);
+
+/**
+ * qio_dns_resolver_lookup_sync:
+ * @resolver: the DNS resolver instance
+ * @addr: the address to resolve
+ * @naddr: pointer to hold number of resolved addresses
+ * @addrs: pointer to hold resolved addresses
+ * @errp: pointer to NULL initialized error object
+ *
+ * This will attempt to resolve the address provided
+ * in @addr. If resolution succeeds, @addrs will be filled
+ * with all the resolved addresses. @naddrs will specify
+ * the number of entries allocated in @addrs. The caller
+ * is responsible for freeing each entry in @addrs, as
+ * well as @addrs itself. @naddrs is guaranteed to be
+ * greater than zero on success.
+ *
+ * DNS resolution will be done synchronously so execution
+ * of the caller may be blocked for an arbitrary length
+ * of time.
+ *
+ * Returns: 0 if resolution was successful, -1 on error
+ */
+int qio_dns_resolver_lookup_sync(QIODNSResolver *resolver,
+                                 SocketAddress *addr,
+                                 size_t *naddrs,
+                                 SocketAddress ***addrs,
+                                 Error **errp);
+
+/**
+ * qio_dns_resolver_lookup_async:
+ * @resolver: the DNS resolver instance
+ * @addr: the address to resolve
+ * @func: the callback to invoke on lookup completion
+ * @opaque: data blob to pass to @func
+ * @notify: the callback to free @opaque, or NULL
+ *
+ * This will attempt to resolve the address provided
+ * in @addr. The callback @func will be invoked when
+ * resolution has either completed or failed. On
+ * success, the @func should call the method
+ * qio_dns_resolver_lookup_result() to obtain the
+ * results.
+ *
+ * DNS resolution will be done asynchronously so execution
+ * of the caller will not be blocked.
+ */
+void qio_dns_resolver_lookup_async(QIODNSResolver *resolver,
+                                   SocketAddress *addr,
+                                   QIOTaskFunc func,
+                                   gpointer opaque,
+                                   GDestroyNotify notify);
+
+/**
+ * qio_dns_resolver_lookup_result:
+ * @resolver: the DNS resolver instance
+ * @task: the task object to get results for
+ * @naddr: pointer to hold number of resolved addresses
+ * @addrs: pointer to hold resolved addresses
+ *
+ * This method should be called from the callback passed
+ * to qio_dns_resolver_lookup_async() in order to obtain
+ * results.  @addrs will be filled with all the resolved
+ * addresses. @naddrs will specify the number of entries
+ * allocated in @addrs. The caller is responsible for
+ * freeing each entry in @addrs, as well as @addrs itself.
+ */
+void qio_dns_resolver_lookup_result(QIODNSResolver *resolver,
+                                    QIOTask *task,
+                                    size_t *naddrs,
+                                    SocketAddress ***addrs);
+
+#endif /* QIO_DNS_RESOLVER_H */
diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index 5589e68..5f1bab9 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -32,6 +32,8 @@ int socket_set_fast_reuse(int fd);
  */
 typedef void NonBlockingConnectHandler(int fd, Error *err, void *opaque);
 
+int inet_ai_family_from_address(InetSocketAddress *addr,
+                                Error **errp);
 InetSocketAddress *inet_parse(const char *str, Error **errp);
 int inet_connect(const char *str, Error **errp);
 int inet_connect_saddr(InetSocketAddress *saddr, Error **errp,
diff --git a/io/Makefile.objs b/io/Makefile.objs
index 9d8337d..12983cc 100644
--- a/io/Makefile.objs
+++ b/io/Makefile.objs
@@ -7,4 +7,5 @@ io-obj-y += channel-tls.o
 io-obj-y += channel-watch.o
 io-obj-y += channel-websock.o
 io-obj-y += channel-util.o
+io-obj-y += dns-resolver.o
 io-obj-y += task.o
diff --git a/io/dns-resolver.c b/io/dns-resolver.c
new file mode 100644
index 0000000..cf2b1c5
--- /dev/null
+++ b/io/dns-resolver.c
@@ -0,0 +1,272 @@
+/*
+ * QEMU DNS resolver
+ *
+ * Copyright (c) 2016 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "io/dns-resolver.h"
+#include "qapi/clone-visitor.h"
+#include "qemu/sockets.h"
+#include "qapi/error.h"
+#include "qemu/cutils.h"
+
+
+static QIODNSResolver *instance;
+static pthread_once_t instance_init = PTHREAD_ONCE_INIT;
+
+static void qio_dns_resolve_init_instance(void)
+{
+    instance = QIO_DNS_RESOLVER(object_new(TYPE_QIO_DNS_RESOLVER));
+}
+
+QIODNSResolver *qio_dns_resolver_get_instance(void)
+{
+    pthread_once(&instance_init, qio_dns_resolve_init_instance);
+    return instance;
+}
+
+static int qio_dns_resolver_lookup_sync_inet(QIODNSResolver *resolver,
+                                             SocketAddress *addr,
+                                             size_t *naddrs,
+                                             SocketAddress ***addrs,
+                                             Error **errp)
+{
+    struct addrinfo ai, *res, *e;
+    InetSocketAddress *iaddr = addr->u.inet.data;
+    char port[33];
+    char uaddr[INET6_ADDRSTRLEN + 1];
+    char uport[33];
+    int rc;
+    Error *err = NULL;
+    size_t i;
+
+    *naddrs = 0;
+    *addrs = NULL;
+
+    memset(&ai, 0, sizeof(ai));
+    ai.ai_flags = AI_PASSIVE;
+    if (iaddr->has_numeric && iaddr->numeric) {
+        ai.ai_flags |= AI_NUMERICHOST | AI_NUMERICSERV;
+    }
+    ai.ai_family = inet_ai_family_from_address(iaddr, &err);
+    ai.ai_socktype = SOCK_STREAM;
+
+    if (err) {
+        error_propagate(errp, err);
+        return -1;
+    }
+
+    if (iaddr->host == NULL) {
+        error_setg(errp, "host not specified");
+        return -1;
+    }
+    if (iaddr->port != NULL) {
+        pstrcpy(port, sizeof(port), iaddr->port);
+    } else {
+        port[0] = '\0';
+    }
+
+    rc = getaddrinfo(strlen(iaddr->host) ? iaddr->host : NULL,
+                     strlen(port) ? port : NULL, &ai, &res);
+    if (rc != 0) {
+        error_setg(errp, "address resolution failed for %s:%s: %s",
+                   iaddr->host, port, gai_strerror(rc));
+        return -1;
+    }
+
+    for (e = res; e != NULL; e = e->ai_next) {
+        (*naddrs)++;
+    }
+
+    *addrs = g_new0(SocketAddress *, *naddrs);
+
+    /* create socket + bind */
+    for (i = 0, e = res; e != NULL; i++, e = e->ai_next) {
+        SocketAddress *newaddr = g_new0(SocketAddress, 1);
+        InetSocketAddress *newiaddr = g_new0(InetSocketAddress, 1);
+        newaddr->u.inet.data = newiaddr;
+        newaddr->type = SOCKET_ADDRESS_KIND_INET;
+
+        getnameinfo((struct sockaddr *)e->ai_addr, e->ai_addrlen,
+                    uaddr, INET6_ADDRSTRLEN, uport, 32,
+                    NI_NUMERICHOST | NI_NUMERICSERV);
+
+        *newiaddr = (InetSocketAddress){
+            .host = g_strdup(uaddr),
+            .port = g_strdup(uport),
+            .has_numeric = true,
+            .numeric = true,
+            .has_to = iaddr->has_to,
+            .to = iaddr->to,
+            .has_ipv4 = false,
+            .has_ipv6 = false,
+        };
+
+        (*addrs)[i] = newaddr;
+    }
+    freeaddrinfo(res);
+    return 0;
+}
+
+
+static int qio_dns_resolver_lookup_sync_nop(QIODNSResolver *resolver,
+                                            SocketAddress *addr,
+                                            size_t *naddrs,
+                                            SocketAddress ***addrs,
+                                            Error **errp)
+{
+    *naddrs = 1;
+    *addrs = g_new0(SocketAddress *, 1);
+    (*addrs)[0] = QAPI_CLONE(SocketAddress, addr);
+
+    return 0;
+}
+
+
+int qio_dns_resolver_lookup_sync(QIODNSResolver *resolver,
+                                 SocketAddress *addr,
+                                 size_t *naddrs,
+                                 SocketAddress ***addrs,
+                                 Error **errp)
+{
+    switch (addr->type) {
+    case SOCKET_ADDRESS_KIND_INET:
+        return qio_dns_resolver_lookup_sync_inet(resolver,
+                                                 addr,
+                                                 naddrs,
+                                                 addrs,
+                                                 errp);
+
+    case SOCKET_ADDRESS_KIND_UNIX:
+    case SOCKET_ADDRESS_KIND_VSOCK:
+        return qio_dns_resolver_lookup_sync_nop(resolver,
+                                                addr,
+                                                naddrs,
+                                                addrs,
+                                                errp);
+
+    default:
+        error_setg(errp, "Unknown socket address kind");
+        return -1;
+    }
+}
+
+
+struct QIODNSResolverLookupData {
+    SocketAddress *addr;
+    SocketAddress **addrs;
+    size_t naddrs;
+};
+
+
+static void qio_dns_resolver_lookup_data_free(gpointer opaque)
+{
+    struct QIODNSResolverLookupData *data = opaque;
+    size_t i;
+
+    qapi_free_SocketAddress(data->addr);
+    for (i = 0; i < data->naddrs; i++) {
+        qapi_free_SocketAddress(data->addrs[i]);
+    }
+
+    g_free(data->addrs);
+    g_free(data);
+}
+
+
+static void qio_dns_resolver_lookup_worker(QIOTask *task,
+                                           gpointer opaque)
+{
+    QIODNSResolver *resolver = QIO_DNS_RESOLVER(qio_task_get_source(task));
+    struct QIODNSResolverLookupData *data = opaque;
+    Error *err = NULL;
+
+    qio_dns_resolver_lookup_sync(resolver,
+                                 data->addr,
+                                 &data->naddrs,
+                                 &data->addrs,
+                                 &err);
+    if (err) {
+        qio_task_set_error(task, err);
+    } else {
+        qio_task_set_result_pointer(task, opaque, NULL);
+    }
+
+    object_unref(OBJECT(resolver));
+}
+
+
+void qio_dns_resolver_lookup_async(QIODNSResolver *resolver,
+                                   SocketAddress *addr,
+                                   QIOTaskFunc func,
+                                   gpointer opaque,
+                                   GDestroyNotify notify)
+{
+    QIOTask *task;
+    struct QIODNSResolverLookupData *data =
+        g_new0(struct QIODNSResolverLookupData, 1);
+
+    data->addr = QAPI_CLONE(SocketAddress, addr);
+
+    task = qio_task_new(OBJECT(resolver), func, opaque, notify);
+
+    qio_task_run_in_thread(task,
+                           qio_dns_resolver_lookup_worker,
+                           data,
+                           qio_dns_resolver_lookup_data_free);
+}
+
+
+void qio_dns_resolver_lookup_result(QIODNSResolver *resolver,
+                                    QIOTask *task,
+                                    size_t *naddrs,
+                                    SocketAddress ***addrs)
+{
+    struct QIODNSResolverLookupData *data =
+        qio_task_get_result_pointer(task);
+    size_t i;
+
+    *naddrs = 0;
+    *addrs = NULL;
+    if (!data) {
+        return;
+    }
+
+    *naddrs = data->naddrs;
+    *addrs = g_new0(SocketAddress *, data->naddrs);
+    for (i = 0; i < data->naddrs; i++) {
+        (*addrs)[i] = QAPI_CLONE(SocketAddress, data->addrs[i]);
+    }
+}
+
+
+static const TypeInfo qio_dns_resolver_info = {
+    .parent = TYPE_OBJECT,
+    .name = TYPE_QIO_DNS_RESOLVER,
+    .instance_size = sizeof(QIODNSResolver),
+    .class_size = sizeof(QIODNSResolverClass),
+};
+
+
+static void qio_dns_resolver_register_types(void)
+{
+    type_register_static(&qio_dns_resolver_info);
+}
+
+
+type_init(qio_dns_resolver_register_types);
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index d63b011..6a0cc24 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -110,8 +110,8 @@ NetworkAddressFamily inet_netfamily(int family)
  * outside scope of this method and not currently handled by
  * callers at all.
  */
-static int inet_ai_family_from_address(InetSocketAddress *addr,
-                                       Error **errp)
+int inet_ai_family_from_address(InetSocketAddress *addr,
+                                Error **errp)
 {
     if (addr->has_ipv6 && addr->has_ipv4 &&
         !addr->ipv6 && !addr->ipv4) {
-- 
2.9.3
