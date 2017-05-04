Received: from eggs.gnu.org ([2001:4830:134:3::10]:56693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6IcE-0002Jr-SA
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Ic1-0008Mt-Mi
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d6Ic0-0008JU-RO
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA423C05974C
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 15:24:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-149.ams2.redhat.com
	[10.36.116.149])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C00F05DD6E
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 15:24:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  4 May 2017 17:23:55 +0200
Message-Id: <1493911445-19568-19-git-send-email-armbru@redhat.com>
In-Reply-To: <1493911445-19568-1-git-send-email-armbru@redhat.com>
References: <1493911445-19568-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 18/28] sockets: Limit SocketAddressLegacy to
 external interfaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

SocketAddressLegacy is a simple union, and simple unions are awkward:
they have their variant members wrapped in a "data" object on the
wire, and require additional indirections in C.  SocketAddress is the
equivalent flat union.  Convert all users of SocketAddressLegacy to
SocketAddress, except for existing external interfaces.

See also commit fce5d53..9445673 and 85a82e8..c5f1ae3.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1493192202-3184-7-git-send-email-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[Minor editing accident fixed, commit message and a comment tweaked]
---
 block/nbd.c                    |   4 +-
 block/sheepdog.c               |  32 +++-----
 blockdev-nbd.c                 |  21 +++--
 chardev/char-socket.c          |  34 ++++----
 chardev/char-udp.c             |  10 ++-
 hmp.c                          |   7 +-
 include/block/nbd.h            |   3 +
 include/io/channel-socket.h    |  24 +++---
 include/io/dns-resolver.h      |  22 +++---
 include/io/task.h              |  10 +--
 include/qemu/sockets.h         |  33 +++++---
 io/channel-socket.c            |  48 +++++------
 io/dns-resolver.c              |  55 +++++++------
 migration/socket.c             |  49 ++++++------
 net/socket.c                   |  10 +--
 qapi-schema.json               |  13 +--
 qemu-nbd.c                     |  17 ++--
 qga/channel-posix.c            |   4 +-
 qga/main.c                     |   8 +-
 tests/test-io-channel-socket.c | 104 +++++++++++-------------
 ui/vnc-auth-sasl.c             |   9 +--
 ui/vnc.c                       | 138 ++++++++++++++++----------------
 util/qemu-sockets.c            | 176 +++++++++++++++++++++++------------------
 23 files changed, 431 insertions(+), 400 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index bbe0f99..975faab 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -306,10 +306,9 @@ NBDClientSession *nbd_get_client_session(BlockDriverState *bs)
     return &s->client;
 }
 
-static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr_flat,
+static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
                                                   Error **errp)
 {
-    SocketAddressLegacy *saddr = socket_address_crumple(saddr_flat);
     QIOChannelSocket *sioc;
     Error *local_err = NULL;
 
@@ -319,7 +318,6 @@ static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr_flat,
     qio_channel_socket_connect_sync(sioc,
                                     saddr,
                                     &local_err);
-    qapi_free_SocketAddressLegacy(saddr);
     if (local_err) {
         object_unref(OBJECT(sioc));
         error_propagate(errp, local_err);
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 547239a..17c4ef5 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -378,7 +378,7 @@ struct BDRVSheepdogState {
     uint32_t cache_flags;
     bool discard_supported;
 
-    SocketAddressLegacy *addr;
+    SocketAddress *addr;
     int fd;
 
     CoMutex lock;
@@ -530,32 +530,29 @@ static void sd_aio_setup(SheepdogAIOCB *acb, BDRVSheepdogState *s,
     QLIST_INSERT_HEAD(&s->inflight_aiocb_head, acb, aiocb_siblings);
 }
 
-static SocketAddressLegacy *sd_socket_address(const char *path,
+static SocketAddress *sd_socket_address(const char *path,
                                         const char *host, const char *port)
 {
-    SocketAddressLegacy *addr = g_new0(SocketAddressLegacy, 1);
+    SocketAddress *addr = g_new0(SocketAddress, 1);
 
     if (path) {
-        addr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
-        addr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
-        addr->u.q_unix.data->path = g_strdup(path);
+        addr->type = SOCKET_ADDRESS_TYPE_UNIX;
+        addr->u.q_unix.path = g_strdup(path);
     } else {
-        addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
-        addr->u.inet.data = g_new0(InetSocketAddress, 1);
-        addr->u.inet.data->host = g_strdup(host ?: SD_DEFAULT_ADDR);
-        addr->u.inet.data->port = g_strdup(port ?: stringify(SD_DEFAULT_PORT));
+        addr->type = SOCKET_ADDRESS_TYPE_INET;
+        addr->u.inet.host = g_strdup(host ?: SD_DEFAULT_ADDR);
+        addr->u.inet.port = g_strdup(port ?: stringify(SD_DEFAULT_PORT));
     }
 
     return addr;
 }
 
-static SocketAddressLegacy *sd_server_config(QDict *options, Error **errp)
+static SocketAddress *sd_server_config(QDict *options, Error **errp)
 {
     QDict *server = NULL;
     QObject *crumpled_server = NULL;
     Visitor *iv = NULL;
-    SocketAddress *saddr_flat = NULL;
-    SocketAddressLegacy *saddr = NULL;
+    SocketAddress *saddr = NULL;
     Error *local_err = NULL;
 
     qdict_extract_subqdict(options, &server, "server.");
@@ -574,16 +571,13 @@ static SocketAddressLegacy *sd_server_config(QDict *options, Error **errp)
      * visitor expects the former.
      */
     iv = qobject_input_visitor_new(crumpled_server);
-    visit_type_SocketAddress(iv, NULL, &saddr_flat, &local_err);
+    visit_type_SocketAddress(iv, NULL, &saddr, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto done;
     }
 
-    saddr = socket_address_crumple(saddr_flat);
-
 done:
-    qapi_free_SocketAddress(saddr_flat);
     visit_free(iv);
     qobject_decref(crumpled_server);
     QDECREF(server);
@@ -597,7 +591,7 @@ static int connect_to_sdog(BDRVSheepdogState *s, Error **errp)
 
     fd = socket_connect(s->addr, NULL, NULL, errp);
 
-    if (s->addr->type == SOCKET_ADDRESS_LEGACY_KIND_INET && fd >= 0) {
+    if (s->addr->type == SOCKET_ADDRESS_TYPE_INET && fd >= 0) {
         int ret = socket_set_nodelay(fd);
         if (ret < 0) {
             error_report("%s", strerror(errno));
@@ -2149,7 +2143,7 @@ static void sd_close(BlockDriverState *bs)
     aio_set_fd_handler(bdrv_get_aio_context(bs), s->fd,
                        false, NULL, NULL, NULL, NULL);
     closesocket(s->fd);
-    qapi_free_SocketAddressLegacy(s->addr);
+    qapi_free_SocketAddress(s->addr);
 }
 
 static int64_t sd_getlength(BlockDriverState *bs)
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 6b0c699..dd0860f 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -99,9 +99,8 @@ static QCryptoTLSCreds *nbd_get_tls_creds(const char *id, Error **errp)
 }
 
 
-void qmp_nbd_server_start(SocketAddressLegacy *addr,
-                          bool has_tls_creds, const char *tls_creds,
-                          Error **errp)
+void nbd_server_start(SocketAddress *addr, const char *tls_creds,
+                      Error **errp)
 {
     if (nbd_server) {
         error_setg(errp, "NBD server already running");
@@ -118,14 +117,14 @@ void qmp_nbd_server_start(SocketAddressLegacy *addr,
         goto error;
     }
 
-    if (has_tls_creds) {
+    if (tls_creds) {
         nbd_server->tlscreds = nbd_get_tls_creds(tls_creds, errp);
         if (!nbd_server->tlscreds) {
             goto error;
         }
 
-        /* TODO SOCKET_ADDRESS_LEGACY_KIND_FD where fd has AF_INET or AF_INET6 */
-        if (addr->type != SOCKET_ADDRESS_LEGACY_KIND_INET) {
+        /* TODO SOCKET_ADDRESS_TYPE_FD where fd has AF_INET or AF_INET6 */
+        if (addr->type != SOCKET_ADDRESS_TYPE_INET) {
             error_setg(errp, "TLS is only supported with IPv4/IPv6");
             goto error;
         }
@@ -145,6 +144,16 @@ void qmp_nbd_server_start(SocketAddressLegacy *addr,
     nbd_server = NULL;
 }
 
+void qmp_nbd_server_start(SocketAddressLegacy *addr,
+                          bool has_tls_creds, const char *tls_creds,
+                          Error **errp)
+{
+    SocketAddress *addr_flat = socket_address_flatten(addr);
+
+    nbd_server_start(addr_flat, tls_creds, errp);
+    qapi_free_SocketAddress(addr_flat);
+}
+
 void qmp_nbd_server_add(const char *device, bool has_writable, bool writable,
                         Error **errp)
 {
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 9eca786..a37fe18 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -52,7 +52,7 @@ typedef struct {
     int *write_msgfds;
     size_t write_msgfds_num;
 
-    SocketAddressLegacy *addr;
+    SocketAddress *addr;
     bool is_listen;
     bool is_telnet;
 
@@ -337,30 +337,30 @@ static void tcp_chr_free_connection(Chardev *chr)
     s->connected = 0;
 }
 
-static char *SocketAddress_to_str(const char *prefix, SocketAddressLegacy *addr,
+static char *SocketAddress_to_str(const char *prefix, SocketAddress *addr,
                                   bool is_listen, bool is_telnet)
 {
     switch (addr->type) {
-    case SOCKET_ADDRESS_LEGACY_KIND_INET:
+    case SOCKET_ADDRESS_TYPE_INET:
         return g_strdup_printf("%s%s:%s:%s%s", prefix,
                                is_telnet ? "telnet" : "tcp",
-                               addr->u.inet.data->host,
-                               addr->u.inet.data->port,
+                               addr->u.inet.host,
+                               addr->u.inet.port,
                                is_listen ? ",server" : "");
         break;
-    case SOCKET_ADDRESS_LEGACY_KIND_UNIX:
+    case SOCKET_ADDRESS_TYPE_UNIX:
         return g_strdup_printf("%sunix:%s%s", prefix,
-                               addr->u.q_unix.data->path,
+                               addr->u.q_unix.path,
                                is_listen ? ",server" : "");
         break;
-    case SOCKET_ADDRESS_LEGACY_KIND_FD:
-        return g_strdup_printf("%sfd:%s%s", prefix, addr->u.fd.data->str,
+    case SOCKET_ADDRESS_TYPE_FD:
+        return g_strdup_printf("%sfd:%s%s", prefix, addr->u.fd.str,
                                is_listen ? ",server" : "");
         break;
-    case SOCKET_ADDRESS_LEGACY_KIND_VSOCK:
+    case SOCKET_ADDRESS_TYPE_VSOCK:
         return g_strdup_printf("%svsock:%s:%s", prefix,
-                               addr->u.vsock.data->cid,
-                               addr->u.vsock.data->port);
+                               addr->u.vsock.cid,
+                               addr->u.vsock.port);
     default:
         abort();
     }
@@ -609,7 +609,7 @@ static void tcp_chr_tls_init(Chardev *chr)
     } else {
         tioc = qio_channel_tls_new_client(
             s->ioc, s->tls_creds,
-            s->addr->u.inet.data->host,
+            s->addr->u.inet.host,
             &err);
     }
     if (tioc == NULL) {
@@ -757,7 +757,7 @@ static void char_socket_finalize(Object *obj)
         g_source_remove(s->reconnect_timer);
         s->reconnect_timer = 0;
     }
-    qapi_free_SocketAddressLegacy(s->addr);
+    qapi_free_SocketAddress(s->addr);
     if (s->listen_tag) {
         g_source_remove(s->listen_tag);
         s->listen_tag = 0;
@@ -820,13 +820,13 @@ static void qmp_chardev_open_socket(Chardev *chr,
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
     ChardevSocket *sock = backend->u.socket.data;
-    SocketAddressLegacy *addr = sock->addr;
     bool do_nodelay     = sock->has_nodelay ? sock->nodelay : false;
     bool is_listen      = sock->has_server  ? sock->server  : true;
     bool is_telnet      = sock->has_telnet  ? sock->telnet  : false;
     bool is_waitconnect = sock->has_wait    ? sock->wait    : false;
     int64_t reconnect   = sock->has_reconnect ? sock->reconnect : 0;
     QIOChannelSocket *sioc = NULL;
+    SocketAddress *addr;
 
     s->is_listen = is_listen;
     s->is_telnet = is_telnet;
@@ -864,11 +864,11 @@ static void qmp_chardev_open_socket(Chardev *chr,
         }
     }
 
-    s->addr = QAPI_CLONE(SocketAddressLegacy, sock->addr);
+    s->addr = addr = socket_address_flatten(sock->addr);
 
     qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_RECONNECTABLE);
     /* TODO SOCKET_ADDRESS_FD where fd has AF_UNIX */
-    if (addr->type == SOCKET_ADDRESS_LEGACY_KIND_UNIX) {
+    if (addr->type == SOCKET_ADDRESS_TYPE_UNIX) {
         qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_FD_PASS);
     }
 
diff --git a/chardev/char-udp.c b/chardev/char-udp.c
index d9bcfc5..6c32021 100644
--- a/chardev/char-udp.c
+++ b/chardev/char-udp.c
@@ -187,13 +187,17 @@ static void qmp_chardev_open_udp(Chardev *chr,
                                  Error **errp)
 {
     ChardevUdp *udp = backend->u.udp.data;
+    SocketAddress *local_addr = socket_address_flatten(udp->local);
+    SocketAddress *remote_addr = socket_address_flatten(udp->remote);
     QIOChannelSocket *sioc = qio_channel_socket_new();
     char *name;
     UdpChardev *s = UDP_CHARDEV(chr);
+    int ret;
 
-    if (qio_channel_socket_dgram_sync(sioc,
-                                      udp->local, udp->remote,
-                                      errp) < 0) {
+    ret = qio_channel_socket_dgram_sync(sioc, local_addr, remote_addr, errp);
+    qapi_free_SocketAddress(local_addr);
+    qapi_free_SocketAddress(remote_addr);
+    if (ret < 0) {
         object_unref(OBJECT(sioc));
         return;
     }
diff --git a/hmp.c b/hmp.c
index 1fe109d..5dacde8 100644
--- a/hmp.c
+++ b/hmp.c
@@ -33,6 +33,7 @@
 #include "qapi-visit.h"
 #include "qom/object_interfaces.h"
 #include "ui/console.h"
+#include "block/nbd.h"
 #include "block/qapi.h"
 #include "qemu-io.h"
 #include "qemu/cutils.h"
@@ -1934,7 +1935,7 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
     bool all = qdict_get_try_bool(qdict, "all", false);
     Error *local_err = NULL;
     BlockInfoList *block_list, *info;
-    SocketAddressLegacy *addr;
+    SocketAddress *addr;
 
     if (writable && !all) {
         error_setg(&local_err, "-w only valid together with -a");
@@ -1947,8 +1948,8 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
         goto exit;
     }
 
-    qmp_nbd_server_start(addr, false, NULL, &local_err);
-    qapi_free_SocketAddressLegacy(addr);
+    nbd_server_start(addr, NULL, &local_err);
+    qapi_free_SocketAddress(addr);
     if (local_err != NULL) {
         goto exit;
     }
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 3e373f0..0ed0775 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -164,4 +164,7 @@ void nbd_client_new(NBDExport *exp,
 void nbd_client_get(NBDClient *client);
 void nbd_client_put(NBDClient *client);
 
+void nbd_server_start(SocketAddress *addr, const char *tls_creds,
+                      Error **errp);
+
 #endif
diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index c1aaa72..53801f6 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -91,7 +91,7 @@ qio_channel_socket_new_fd(int fd,
  * an error occurs.
  */
 int qio_channel_socket_connect_sync(QIOChannelSocket *ioc,
-                                    SocketAddressLegacy *addr,
+                                    SocketAddress *addr,
                                     Error **errp);
 
 /**
@@ -110,7 +110,7 @@ int qio_channel_socket_connect_sync(QIOChannelSocket *ioc,
  * as this function returns without waiting for completion.
  */
 void qio_channel_socket_connect_async(QIOChannelSocket *ioc,
-                                      SocketAddressLegacy *addr,
+                                      SocketAddress *addr,
                                       QIOTaskFunc callback,
                                       gpointer opaque,
                                       GDestroyNotify destroy);
@@ -128,7 +128,7 @@ void qio_channel_socket_connect_async(QIOChannelSocket *ioc,
  * an error occurs.
  */
 int qio_channel_socket_listen_sync(QIOChannelSocket *ioc,
-                                   SocketAddressLegacy *addr,
+                                   SocketAddress *addr,
                                    Error **errp);
 
 /**
@@ -147,7 +147,7 @@ int qio_channel_socket_listen_sync(QIOChannelSocket *ioc,
  * as this function returns without waiting for completion.
  */
 void qio_channel_socket_listen_async(QIOChannelSocket *ioc,
-                                     SocketAddressLegacy *addr,
+                                     SocketAddress *addr,
                                      QIOTaskFunc callback,
                                      gpointer opaque,
                                      GDestroyNotify destroy);
@@ -167,8 +167,8 @@ void qio_channel_socket_listen_async(QIOChannelSocket *ioc,
  * is established or an error occurs.
  */
 int qio_channel_socket_dgram_sync(QIOChannelSocket *ioc,
-                                  SocketAddressLegacy *localAddr,
-                                  SocketAddressLegacy *remoteAddr,
+                                  SocketAddress *localAddr,
+                                  SocketAddress *remoteAddr,
                                   Error **errp);
 
 /**
@@ -190,8 +190,8 @@ int qio_channel_socket_dgram_sync(QIOChannelSocket *ioc,
  * waiting for completion.
  */
 void qio_channel_socket_dgram_async(QIOChannelSocket *ioc,
-                                    SocketAddressLegacy *localAddr,
-                                    SocketAddressLegacy *remoteAddr,
+                                    SocketAddress *localAddr,
+                                    SocketAddress *remoteAddr,
                                     QIOTaskFunc callback,
                                     gpointer opaque,
                                     GDestroyNotify destroy);
@@ -205,12 +205,12 @@ void qio_channel_socket_dgram_async(QIOChannelSocket *ioc,
  * Get the string representation of the local socket
  * address. A pointer to the allocated address information
  * struct will be returned, which the caller is required to
- * release with a call qapi_free_SocketAddressLegacy() when no
+ * release with a call qapi_free_SocketAddress() when no
  * longer required.
  *
  * Returns: 0 on success, -1 on error
  */
-SocketAddressLegacy *
+SocketAddress *
 qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
                                      Error **errp);
 
@@ -222,12 +222,12 @@ qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
  * Get the string representation of the local socket
  * address. A pointer to the allocated address information
  * struct will be returned, which the caller is required to
- * release with a call qapi_free_SocketAddressLegacy() when no
+ * release with a call qapi_free_SocketAddress() when no
  * longer required.
  *
  * Returns: the socket address struct, or NULL on error
  */
-SocketAddressLegacy *
+SocketAddress *
 qio_channel_socket_get_remote_address(QIOChannelSocket *ioc,
                                       Error **errp);
 
diff --git a/include/io/dns-resolver.h b/include/io/dns-resolver.h
index aac46ca..2f69c08 100644
--- a/include/io/dns-resolver.h
+++ b/include/io/dns-resolver.h
@@ -40,15 +40,15 @@ typedef struct QIODNSResolverClass QIODNSResolverClass;
  * QIODNSResolver:
  *
  * The QIODNSResolver class provides a framework for doing
- * DNS resolution on SocketAddressLegacy objects, independently
+ * DNS resolution on SocketAddress objects, independently
  * of socket creation.
  *
  * <example>
  *   <title>Resolving addresses synchronously</title>
  *   <programlisting>
- *    int mylisten(SocketAddressLegacy *addr, Error **errp) {
+ *    int mylisten(SocketAddress *addr, Error **errp) {
  *      QIODNSResolver *resolver = qio_dns_resolver_get_instance();
- *      SocketAddressLegacy **rawaddrs = NULL;
+ *      SocketAddress **rawaddrs = NULL;
  *      size_t nrawaddrs = 0;
  *      Error *err = NULL;
  *      QIOChannel **socks = NULL;
@@ -69,7 +69,7 @@ typedef struct QIODNSResolverClass QIODNSResolverClass;
  *            socks = g_renew(QIOChannelSocket *, socks, nsocks + 1);
  *            socks[nsocks++] = sock;
  *         }
- *         qapi_free_SocketAddressLegacy(rawaddrs[i]);
+ *         qapi_free_SocketAddress(rawaddrs[i]);
  *      }
  *      g_free(rawaddrs);
  *
@@ -95,7 +95,7 @@ typedef struct QIODNSResolverClass QIODNSResolverClass;
  *      MyListenData *data = opaque;
  *      QIODNSResolver *resolver =
  *         QIO_DNS_RESOLVER(qio_task_get_source(task);
- *      SocketAddressLegacy **rawaddrs = NULL;
+ *      SocketAddress **rawaddrs = NULL;
  *      size_t nrawaddrs = 0;
  *      Error *err = NULL;
  *
@@ -116,7 +116,7 @@ typedef struct QIODNSResolverClass QIODNSResolverClass;
  *            socks = g_renew(QIOChannelSocket *, socks, nsocks + 1);
  *            socks[nsocks++] = sock;
  *         }
- *         qapi_free_SocketAddressLegacy(rawaddrs[i]);
+ *         qapi_free_SocketAddress(rawaddrs[i]);
  *      }
  *      g_free(rawaddrs);
  *
@@ -127,7 +127,7 @@ typedef struct QIODNSResolverClass QIODNSResolverClass;
  *      }
  *    }
  *
- *    void mylisten(SocketAddressLegacy *addr, MyListenData *data) {
+ *    void mylisten(SocketAddress *addr, MyListenData *data) {
  *      QIODNSResolver *resolver = qio_dns_resolver_get_instance();
  *      qio_dns_resolver_lookup_async(dns, addr,
  *                                    mylistenresult, data, NULL);
@@ -177,9 +177,9 @@ QIODNSResolver *qio_dns_resolver_get_instance(void);
  * Returns: 0 if resolution was successful, -1 on error
  */
 int qio_dns_resolver_lookup_sync(QIODNSResolver *resolver,
-                                 SocketAddressLegacy *addr,
+                                 SocketAddress *addr,
                                  size_t *naddrs,
-                                 SocketAddressLegacy ***addrs,
+                                 SocketAddress ***addrs,
                                  Error **errp);
 
 /**
@@ -201,7 +201,7 @@ int qio_dns_resolver_lookup_sync(QIODNSResolver *resolver,
  * of the caller will not be blocked.
  */
 void qio_dns_resolver_lookup_async(QIODNSResolver *resolver,
-                                   SocketAddressLegacy *addr,
+                                   SocketAddress *addr,
                                    QIOTaskFunc func,
                                    gpointer opaque,
                                    GDestroyNotify notify);
@@ -223,6 +223,6 @@ void qio_dns_resolver_lookup_async(QIODNSResolver *resolver,
 void qio_dns_resolver_lookup_result(QIODNSResolver *resolver,
                                     QIOTask *task,
                                     size_t *naddrs,
-                                    SocketAddressLegacy ***addrs);
+                                    SocketAddress ***addrs);
 
 #endif /* QIO_DNS_RESOLVER_H */
diff --git a/include/io/task.h b/include/io/task.h
index f65ec7a..6021f51 100644
--- a/include/io/task.h
+++ b/include/io/task.h
@@ -166,7 +166,7 @@ typedef void (*QIOTaskWorker)(QIOTask *task,
  *                                       gpointer opaque)
  *    {
  *       QMyObject obj = QMY_OBJECT(qio_task_get_source(task));
- *       SocketAddressLegacy *addr = opaque;
+ *       SocketAddress *addr = opaque;
  *       Error *err = NULL;
  *
  *       obj->fd = socket_listen(addr, &err);
@@ -175,20 +175,20 @@ typedef void (*QIOTaskWorker)(QIOTask *task,
  *    }
  *
  *    void myobject_listen_async(QMyObject *obj,
- *                               SocketAddressLegacy *addr,
+ *                               SocketAddress *addr,
  *                               QIOTaskFunc *func,
  *                               gpointer opaque,
  *                               GDestroyNotify notify)
  *    {
  *      QIOTask *task;
- *      SocketAddressLegacy *addrCopy;
+ *      SocketAddress *addrCopy;
  *
- *      addrCopy = QAPI_CLONE(SocketAddressLegacy, addr);
+ *      addrCopy = QAPI_CLONE(SocketAddress, addr);
  *      task = qio_task_new(OBJECT(obj), func, opaque, notify);
  *
  *      qio_task_run_in_thread(task, myobject_listen_worker,
  *                             addrCopy,
- *                             qapi_free_SocketAddressLegacy);
+ *                             qapi_free_SocketAddress);
  *    }
  * </example>
  *
diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index 82b7460..a0b5cae 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -45,12 +45,12 @@ NetworkAddressFamily inet_netfamily(int family);
 int unix_listen(const char *path, char *ostr, int olen, Error **errp);
 int unix_connect(const char *path, Error **errp);
 
-SocketAddressLegacy *socket_parse(const char *str, Error **errp);
-int socket_connect(SocketAddressLegacy *addr, NonBlockingConnectHandler *callback,
+SocketAddress *socket_parse(const char *str, Error **errp);
+int socket_connect(SocketAddress *addr, NonBlockingConnectHandler *callback,
                    void *opaque, Error **errp);
-int socket_listen(SocketAddressLegacy *addr, Error **errp);
+int socket_listen(SocketAddress *addr, Error **errp);
 void socket_listen_cleanup(int fd, Error **errp);
-int socket_dgram(SocketAddressLegacy *remote, SocketAddressLegacy *local, Error **errp);
+int socket_dgram(SocketAddress *remote, SocketAddress *local, Error **errp);
 
 /* Old, ipv4 only bits.  Don't use for new code. */
 int parse_host_port(struct sockaddr_in *saddr, const char *str);
@@ -65,12 +65,12 @@ int socket_init(void);
  * Get the string representation of the socket
  * address. A pointer to the allocated address information
  * struct will be returned, which the caller is required to
- * release with a call qapi_free_SocketAddressLegacy() when no
+ * release with a call qapi_free_SocketAddress() when no
  * longer required.
  *
  * Returns: the socket address struct, or NULL on error
  */
-SocketAddressLegacy *
+SocketAddress *
 socket_sockaddr_to_address(struct sockaddr_storage *sa,
                            socklen_t salen,
                            Error **errp);
@@ -83,12 +83,12 @@ socket_sockaddr_to_address(struct sockaddr_storage *sa,
  * Get the string representation of the local socket
  * address. A pointer to the allocated address information
  * struct will be returned, which the caller is required to
- * release with a call qapi_free_SocketAddressLegacy() when no
+ * release with a call qapi_free_SocketAddress() when no
  * longer required.
  *
  * Returns: the socket address struct, or NULL on error
  */
-SocketAddressLegacy *socket_local_address(int fd, Error **errp);
+SocketAddress *socket_local_address(int fd, Error **errp);
 
 /**
  * socket_remote_address:
@@ -98,12 +98,12 @@ SocketAddressLegacy *socket_local_address(int fd, Error **errp);
  * Get the string representation of the remote socket
  * address. A pointer to the allocated address information
  * struct will be returned, which the caller is required to
- * release with a call qapi_free_SocketAddressLegacy() when no
+ * release with a call qapi_free_SocketAddress() when no
  * longer required.
  *
  * Returns: the socket address struct, or NULL on error
  */
-SocketAddressLegacy *socket_remote_address(int fd, Error **errp);
+SocketAddress *socket_remote_address(int fd, Error **errp);
 
 /**
  * socket_address_to_string:
@@ -118,7 +118,7 @@ SocketAddressLegacy *socket_remote_address(int fd, Error **errp);
  *
  * Returns: the socket address in string format, or NULL on error
  */
-char *socket_address_to_string(struct SocketAddressLegacy *addr, Error **errp);
+char *socket_address_to_string(struct SocketAddress *addr, Error **errp);
 
 /**
  * socket_address_crumple:
@@ -131,4 +131,15 @@ char *socket_address_to_string(struct SocketAddressLegacy *addr, Error **errp);
  */
 SocketAddressLegacy *socket_address_crumple(SocketAddress *addr);
 
+/**
+ * socket_address_flatten:
+ * @addr: the socket address to flatten
+ *
+ * Convert SocketAddressLegacy to SocketAddress.  Caller is responsible
+ * for freeing with qapi_free_SocketAddress().
+ *
+ * Returns: the argument converted to SocketAddress.
+ */
+SocketAddress *socket_address_flatten(SocketAddressLegacy *addr);
+
 #endif /* QEMU_SOCKETS_H */
diff --git a/io/channel-socket.c b/io/channel-socket.c
index a21dab6..53386b7 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -27,7 +27,7 @@
 
 #define SOCKET_MAX_FDS 16
 
-SocketAddressLegacy *
+SocketAddress *
 qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
                                      Error **errp)
 {
@@ -36,7 +36,7 @@ qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
                                       errp);
 }
 
-SocketAddressLegacy *
+SocketAddress *
 qio_channel_socket_get_remote_address(QIOChannelSocket *ioc,
                                       Error **errp)
 {
@@ -134,7 +134,7 @@ qio_channel_socket_new_fd(int fd,
 
 
 int qio_channel_socket_connect_sync(QIOChannelSocket *ioc,
-                                    SocketAddressLegacy *addr,
+                                    SocketAddress *addr,
                                     Error **errp)
 {
     int fd;
@@ -160,7 +160,7 @@ static void qio_channel_socket_connect_worker(QIOTask *task,
                                               gpointer opaque)
 {
     QIOChannelSocket *ioc = QIO_CHANNEL_SOCKET(qio_task_get_source(task));
-    SocketAddressLegacy *addr = opaque;
+    SocketAddress *addr = opaque;
     Error *err = NULL;
 
     qio_channel_socket_connect_sync(ioc, addr, &err);
@@ -170,16 +170,16 @@ static void qio_channel_socket_connect_worker(QIOTask *task,
 
 
 void qio_channel_socket_connect_async(QIOChannelSocket *ioc,
-                                      SocketAddressLegacy *addr,
+                                      SocketAddress *addr,
                                       QIOTaskFunc callback,
                                       gpointer opaque,
                                       GDestroyNotify destroy)
 {
     QIOTask *task = qio_task_new(
         OBJECT(ioc), callback, opaque, destroy);
-    SocketAddressLegacy *addrCopy;
+    SocketAddress *addrCopy;
 
-    addrCopy = QAPI_CLONE(SocketAddressLegacy, addr);
+    addrCopy = QAPI_CLONE(SocketAddress, addr);
 
     /* socket_connect() does a non-blocking connect(), but it
      * still blocks in DNS lookups, so we must use a thread */
@@ -187,12 +187,12 @@ void qio_channel_socket_connect_async(QIOChannelSocket *ioc,
     qio_task_run_in_thread(task,
                            qio_channel_socket_connect_worker,
                            addrCopy,
-                           (GDestroyNotify)qapi_free_SocketAddressLegacy);
+                           (GDestroyNotify)qapi_free_SocketAddress);
 }
 
 
 int qio_channel_socket_listen_sync(QIOChannelSocket *ioc,
-                                   SocketAddressLegacy *addr,
+                                   SocketAddress *addr,
                                    Error **errp)
 {
     int fd;
@@ -219,7 +219,7 @@ static void qio_channel_socket_listen_worker(QIOTask *task,
                                              gpointer opaque)
 {
     QIOChannelSocket *ioc = QIO_CHANNEL_SOCKET(qio_task_get_source(task));
-    SocketAddressLegacy *addr = opaque;
+    SocketAddress *addr = opaque;
     Error *err = NULL;
 
     qio_channel_socket_listen_sync(ioc, addr, &err);
@@ -229,29 +229,29 @@ static void qio_channel_socket_listen_worker(QIOTask *task,
 
 
 void qio_channel_socket_listen_async(QIOChannelSocket *ioc,
-                                     SocketAddressLegacy *addr,
+                                     SocketAddress *addr,
                                      QIOTaskFunc callback,
                                      gpointer opaque,
                                      GDestroyNotify destroy)
 {
     QIOTask *task = qio_task_new(
         OBJECT(ioc), callback, opaque, destroy);
-    SocketAddressLegacy *addrCopy;
+    SocketAddress *addrCopy;
 
-    addrCopy = QAPI_CLONE(SocketAddressLegacy, addr);
+    addrCopy = QAPI_CLONE(SocketAddress, addr);
 
     /* socket_listen() blocks in DNS lookups, so we must use a thread */
     trace_qio_channel_socket_listen_async(ioc, addr);
     qio_task_run_in_thread(task,
                            qio_channel_socket_listen_worker,
                            addrCopy,
-                           (GDestroyNotify)qapi_free_SocketAddressLegacy);
+                           (GDestroyNotify)qapi_free_SocketAddress);
 }
 
 
 int qio_channel_socket_dgram_sync(QIOChannelSocket *ioc,
-                                  SocketAddressLegacy *localAddr,
-                                  SocketAddressLegacy *remoteAddr,
+                                  SocketAddress *localAddr,
+                                  SocketAddress *remoteAddr,
                                   Error **errp)
 {
     int fd;
@@ -274,16 +274,16 @@ int qio_channel_socket_dgram_sync(QIOChannelSocket *ioc,
 
 
 struct QIOChannelSocketDGramWorkerData {
-    SocketAddressLegacy *localAddr;
-    SocketAddressLegacy *remoteAddr;
+    SocketAddress *localAddr;
+    SocketAddress *remoteAddr;
 };
 
 
 static void qio_channel_socket_dgram_worker_free(gpointer opaque)
 {
     struct QIOChannelSocketDGramWorkerData *data = opaque;
-    qapi_free_SocketAddressLegacy(data->localAddr);
-    qapi_free_SocketAddressLegacy(data->remoteAddr);
+    qapi_free_SocketAddress(data->localAddr);
+    qapi_free_SocketAddress(data->remoteAddr);
     g_free(data);
 }
 
@@ -303,8 +303,8 @@ static void qio_channel_socket_dgram_worker(QIOTask *task,
 
 
 void qio_channel_socket_dgram_async(QIOChannelSocket *ioc,
-                                    SocketAddressLegacy *localAddr,
-                                    SocketAddressLegacy *remoteAddr,
+                                    SocketAddress *localAddr,
+                                    SocketAddress *remoteAddr,
                                     QIOTaskFunc callback,
                                     gpointer opaque,
                                     GDestroyNotify destroy)
@@ -314,8 +314,8 @@ void qio_channel_socket_dgram_async(QIOChannelSocket *ioc,
     struct QIOChannelSocketDGramWorkerData *data = g_new0(
         struct QIOChannelSocketDGramWorkerData, 1);
 
-    data->localAddr = QAPI_CLONE(SocketAddressLegacy, localAddr);
-    data->remoteAddr = QAPI_CLONE(SocketAddressLegacy, remoteAddr);
+    data->localAddr = QAPI_CLONE(SocketAddress, localAddr);
+    data->remoteAddr = QAPI_CLONE(SocketAddress, remoteAddr);
 
     trace_qio_channel_socket_dgram_async(ioc, localAddr, remoteAddr);
     qio_task_run_in_thread(task,
diff --git a/io/dns-resolver.c b/io/dns-resolver.c
index d3f0cbf..57a8896 100644
--- a/io/dns-resolver.c
+++ b/io/dns-resolver.c
@@ -45,13 +45,13 @@ QIODNSResolver *qio_dns_resolver_get_instance(void)
 }
 
 static int qio_dns_resolver_lookup_sync_inet(QIODNSResolver *resolver,
-                                             SocketAddressLegacy *addr,
+                                             SocketAddress *addr,
                                              size_t *naddrs,
-                                             SocketAddressLegacy ***addrs,
+                                             SocketAddress ***addrs,
                                              Error **errp)
 {
     struct addrinfo ai, *res, *e;
-    InetSocketAddress *iaddr = addr->u.inet.data;
+    InetSocketAddress *iaddr = &addr->u.inet;
     char port[33];
     char uaddr[INET6_ADDRSTRLEN + 1];
     char uport[33];
@@ -97,20 +97,19 @@ static int qio_dns_resolver_lookup_sync_inet(QIODNSResolver *resolver,
         (*naddrs)++;
     }
 
-    *addrs = g_new0(SocketAddressLegacy *, *naddrs);
+    *addrs = g_new0(SocketAddress *, *naddrs);
 
     /* create socket + bind */
     for (i = 0, e = res; e != NULL; i++, e = e->ai_next) {
-        SocketAddressLegacy *newaddr = g_new0(SocketAddressLegacy, 1);
-        InetSocketAddress *newiaddr = g_new0(InetSocketAddress, 1);
-        newaddr->u.inet.data = newiaddr;
-        newaddr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
+        SocketAddress *newaddr = g_new0(SocketAddress, 1);
+
+        newaddr->type = SOCKET_ADDRESS_TYPE_INET;
 
         getnameinfo((struct sockaddr *)e->ai_addr, e->ai_addrlen,
                     uaddr, INET6_ADDRSTRLEN, uport, 32,
                     NI_NUMERICHOST | NI_NUMERICSERV);
 
-        *newiaddr = (InetSocketAddress){
+        newaddr->u.inet = (InetSocketAddress){
             .host = g_strdup(uaddr),
             .port = g_strdup(uport),
             .has_numeric = true,
@@ -129,36 +128,36 @@ static int qio_dns_resolver_lookup_sync_inet(QIODNSResolver *resolver,
 
 
 static int qio_dns_resolver_lookup_sync_nop(QIODNSResolver *resolver,
-                                            SocketAddressLegacy *addr,
+                                            SocketAddress *addr,
                                             size_t *naddrs,
-                                            SocketAddressLegacy ***addrs,
+                                            SocketAddress ***addrs,
                                             Error **errp)
 {
     *naddrs = 1;
-    *addrs = g_new0(SocketAddressLegacy *, 1);
-    (*addrs)[0] = QAPI_CLONE(SocketAddressLegacy, addr);
+    *addrs = g_new0(SocketAddress *, 1);
+    (*addrs)[0] = QAPI_CLONE(SocketAddress, addr);
 
     return 0;
 }
 
 
 int qio_dns_resolver_lookup_sync(QIODNSResolver *resolver,
-                                 SocketAddressLegacy *addr,
+                                 SocketAddress *addr,
                                  size_t *naddrs,
-                                 SocketAddressLegacy ***addrs,
+                                 SocketAddress ***addrs,
                                  Error **errp)
 {
     switch (addr->type) {
-    case SOCKET_ADDRESS_LEGACY_KIND_INET:
+    case SOCKET_ADDRESS_TYPE_INET:
         return qio_dns_resolver_lookup_sync_inet(resolver,
                                                  addr,
                                                  naddrs,
                                                  addrs,
                                                  errp);
 
-    case SOCKET_ADDRESS_LEGACY_KIND_UNIX:
-    case SOCKET_ADDRESS_LEGACY_KIND_VSOCK:
-    case SOCKET_ADDRESS_LEGACY_KIND_FD:
+    case SOCKET_ADDRESS_TYPE_UNIX:
+    case SOCKET_ADDRESS_TYPE_VSOCK:
+    case SOCKET_ADDRESS_TYPE_FD:
         return qio_dns_resolver_lookup_sync_nop(resolver,
                                                 addr,
                                                 naddrs,
@@ -172,8 +171,8 @@ int qio_dns_resolver_lookup_sync(QIODNSResolver *resolver,
 
 
 struct QIODNSResolverLookupData {
-    SocketAddressLegacy *addr;
-    SocketAddressLegacy **addrs;
+    SocketAddress *addr;
+    SocketAddress **addrs;
     size_t naddrs;
 };
 
@@ -183,9 +182,9 @@ static void qio_dns_resolver_lookup_data_free(gpointer opaque)
     struct QIODNSResolverLookupData *data = opaque;
     size_t i;
 
-    qapi_free_SocketAddressLegacy(data->addr);
+    qapi_free_SocketAddress(data->addr);
     for (i = 0; i < data->naddrs; i++) {
-        qapi_free_SocketAddressLegacy(data->addrs[i]);
+        qapi_free_SocketAddress(data->addrs[i]);
     }
 
     g_free(data->addrs);
@@ -216,7 +215,7 @@ static void qio_dns_resolver_lookup_worker(QIOTask *task,
 
 
 void qio_dns_resolver_lookup_async(QIODNSResolver *resolver,
-                                   SocketAddressLegacy *addr,
+                                   SocketAddress *addr,
                                    QIOTaskFunc func,
                                    gpointer opaque,
                                    GDestroyNotify notify)
@@ -225,7 +224,7 @@ void qio_dns_resolver_lookup_async(QIODNSResolver *resolver,
     struct QIODNSResolverLookupData *data =
         g_new0(struct QIODNSResolverLookupData, 1);
 
-    data->addr = QAPI_CLONE(SocketAddressLegacy, addr);
+    data->addr = QAPI_CLONE(SocketAddress, addr);
 
     task = qio_task_new(OBJECT(resolver), func, opaque, notify);
 
@@ -239,7 +238,7 @@ void qio_dns_resolver_lookup_async(QIODNSResolver *resolver,
 void qio_dns_resolver_lookup_result(QIODNSResolver *resolver,
                                     QIOTask *task,
                                     size_t *naddrs,
-                                    SocketAddressLegacy ***addrs)
+                                    SocketAddress ***addrs)
 {
     struct QIODNSResolverLookupData *data =
         qio_task_get_result_pointer(task);
@@ -252,9 +251,9 @@ void qio_dns_resolver_lookup_result(QIODNSResolver *resolver,
     }
 
     *naddrs = data->naddrs;
-    *addrs = g_new0(SocketAddressLegacy *, data->naddrs);
+    *addrs = g_new0(SocketAddress *, data->naddrs);
     for (i = 0; i < data->naddrs; i++) {
-        (*addrs)[i] = QAPI_CLONE(SocketAddressLegacy, data->addrs[i]);
+        (*addrs)[i] = QAPI_CLONE(SocketAddress, data->addrs[i]);
     }
 }
 
diff --git a/migration/socket.c b/migration/socket.c
index c556b63..2c2573f 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -25,32 +25,29 @@
 #include "trace.h"
 
 
-static SocketAddressLegacy *tcp_build_address(const char *host_port, Error **errp)
+static SocketAddress *tcp_build_address(const char *host_port, Error **errp)
 {
-    InetSocketAddress *iaddr = g_new(InetSocketAddress, 1);
-    SocketAddressLegacy *saddr;
+    SocketAddress *saddr;
 
-    if (inet_parse(iaddr, host_port, errp)) {
-        qapi_free_InetSocketAddress(iaddr);
+    saddr = g_new0(SocketAddress, 1);
+    saddr->type = SOCKET_ADDRESS_TYPE_INET;
+
+    if (inet_parse(&saddr->u.inet, host_port, errp)) {
+        qapi_free_SocketAddress(saddr);
         return NULL;
     }
 
-    saddr = g_new0(SocketAddressLegacy, 1);
-    saddr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
-    saddr->u.inet.data = iaddr;
-
     return saddr;
 }
 
 
-static SocketAddressLegacy *unix_build_address(const char *path)
+static SocketAddress *unix_build_address(const char *path)
 {
-    SocketAddressLegacy *saddr;
+    SocketAddress *saddr;
 
-    saddr = g_new0(SocketAddressLegacy, 1);
-    saddr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
-    saddr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
-    saddr->u.q_unix.data->path = g_strdup(path);
+    saddr = g_new0(SocketAddress, 1);
+    saddr->type = SOCKET_ADDRESS_TYPE_UNIX;
+    saddr->u.q_unix.path = g_strdup(path);
 
     return saddr;
 }
@@ -91,15 +88,15 @@ static void socket_outgoing_migration(QIOTask *task,
 }
 
 static void socket_start_outgoing_migration(MigrationState *s,
-                                            SocketAddressLegacy *saddr,
+                                            SocketAddress *saddr,
                                             Error **errp)
 {
     QIOChannelSocket *sioc = qio_channel_socket_new();
     struct SocketConnectData *data = g_new0(struct SocketConnectData, 1);
 
     data->s = s;
-    if (saddr->type == SOCKET_ADDRESS_LEGACY_KIND_INET) {
-        data->hostname = g_strdup(saddr->u.inet.data->host);
+    if (saddr->type == SOCKET_ADDRESS_TYPE_INET) {
+        data->hostname = g_strdup(saddr->u.inet.host);
     }
 
     qio_channel_set_name(QIO_CHANNEL(sioc), "migration-socket-outgoing");
@@ -108,7 +105,7 @@ static void socket_start_outgoing_migration(MigrationState *s,
                                      socket_outgoing_migration,
                                      data,
                                      socket_connect_data_free);
-    qapi_free_SocketAddressLegacy(saddr);
+    qapi_free_SocketAddress(saddr);
 }
 
 void tcp_start_outgoing_migration(MigrationState *s,
@@ -116,7 +113,7 @@ void tcp_start_outgoing_migration(MigrationState *s,
                                   Error **errp)
 {
     Error *err = NULL;
-    SocketAddressLegacy *saddr = tcp_build_address(host_port, &err);
+    SocketAddress *saddr = tcp_build_address(host_port, &err);
     if (!err) {
         socket_start_outgoing_migration(s, saddr, &err);
     }
@@ -127,7 +124,7 @@ void unix_start_outgoing_migration(MigrationState *s,
                                    const char *path,
                                    Error **errp)
 {
-    SocketAddressLegacy *saddr = unix_build_address(path);
+    SocketAddress *saddr = unix_build_address(path);
     socket_start_outgoing_migration(s, saddr, errp);
 }
 
@@ -161,7 +158,7 @@ out:
 }
 
 
-static void socket_start_incoming_migration(SocketAddressLegacy *saddr,
+static void socket_start_incoming_migration(SocketAddress *saddr,
                                             Error **errp)
 {
     QIOChannelSocket *listen_ioc = qio_channel_socket_new();
@@ -171,7 +168,7 @@ static void socket_start_incoming_migration(SocketAddressLegacy *saddr,
 
     if (qio_channel_socket_listen_sync(listen_ioc, saddr, errp) < 0) {
         object_unref(OBJECT(listen_ioc));
-        qapi_free_SocketAddressLegacy(saddr);
+        qapi_free_SocketAddress(saddr);
         return;
     }
 
@@ -180,13 +177,13 @@ static void socket_start_incoming_migration(SocketAddressLegacy *saddr,
                           socket_accept_incoming_migration,
                           listen_ioc,
                           (GDestroyNotify)object_unref);
-    qapi_free_SocketAddressLegacy(saddr);
+    qapi_free_SocketAddress(saddr);
 }
 
 void tcp_start_incoming_migration(const char *host_port, Error **errp)
 {
     Error *err = NULL;
-    SocketAddressLegacy *saddr = tcp_build_address(host_port, &err);
+    SocketAddress *saddr = tcp_build_address(host_port, &err);
     if (!err) {
         socket_start_incoming_migration(saddr, &err);
     }
@@ -195,6 +192,6 @@ void tcp_start_incoming_migration(const char *host_port, Error **errp)
 
 void unix_start_incoming_migration(const char *path, Error **errp)
 {
-    SocketAddressLegacy *saddr = unix_build_address(path);
+    SocketAddress *saddr = unix_build_address(path);
     socket_start_incoming_migration(saddr, errp);
 }
diff --git a/net/socket.c b/net/socket.c
index ecd165f..b8c931e 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -489,7 +489,7 @@ static int net_socket_listen_init(NetClientState *peer,
 {
     NetClientState *nc;
     NetSocketState *s;
-    SocketAddressLegacy *saddr;
+    SocketAddress *saddr;
     int ret;
     Error *local_error = NULL;
 
@@ -501,7 +501,7 @@ static int net_socket_listen_init(NetClientState *peer,
 
     ret = socket_listen(saddr, &local_error);
     if (ret < 0) {
-        qapi_free_SocketAddressLegacy(saddr);
+        qapi_free_SocketAddress(saddr);
         error_report_err(local_error);
         return -1;
     }
@@ -514,20 +514,20 @@ static int net_socket_listen_init(NetClientState *peer,
     net_socket_rs_init(&s->rs, net_socket_rs_finalize);
 
     qemu_set_fd_handler(s->listen_fd, net_socket_accept, NULL, s);
-    qapi_free_SocketAddressLegacy(saddr);
+    qapi_free_SocketAddress(saddr);
     return 0;
 }
 
 typedef struct {
     NetClientState *peer;
-    SocketAddressLegacy *saddr;
+    SocketAddress *saddr;
     char *model;
     char *name;
 } socket_connect_data;
 
 static void socket_connect_data_free(socket_connect_data *c)
 {
-    qapi_free_SocketAddressLegacy(c->saddr);
+    qapi_free_SocketAddress(c->saddr);
     g_free(c->model);
     g_free(c->name);
     g_free(c);
diff --git a/qapi-schema.json b/qapi-schema.json
index a741fdd..148279d 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4126,7 +4126,11 @@
 #
 # Captures the address of a socket, which could also be a named file descriptor
 #
-# Note: This type is deprecated in favor of SocketAddress.
+# Note: This type is deprecated in favor of SocketAddress.  The
+# difference between SocketAddressLegacy and SocketAddress is that the
+# latter is a flat union rather than a simple union. Flat is nicer
+# because it avoids nesting on the wire, i.e. that form has fewer {}.
+
 #
 # Since: 1.3
 ##
@@ -4154,14 +4158,11 @@
 ##
 # @SocketAddress:
 #
-# Captures the address of a socket
+# Captures the address of a socket, which could also be a named file
+# descriptor
 #
 # @type:       Transport type
 #
-# This is just like SocketAddressLegacy, except it's a flat union rather
-# than a simple union.  Nicer because it avoids nesting on the wire,
-# i.e. this form has fewer {}.
-#
 # Since: 2.9
 ##
 { 'union': 'SocketAddress',
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 82d0859..b7ab86b 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -57,7 +57,7 @@ static NBDExport *exp;
 static bool newproto;
 static int verbose;
 static char *srcpath;
-static SocketAddressLegacy *saddr;
+static SocketAddress *saddr;
 static int persistent = 0;
 static enum { RUNNING, TERMINATE, TERMINATING, TERMINATED } state;
 static int shared = 1;
@@ -387,21 +387,20 @@ static void nbd_update_server_watch(void)
 }
 
 
-static SocketAddressLegacy *nbd_build_socket_address(const char *sockpath,
+static SocketAddress *nbd_build_socket_address(const char *sockpath,
                                                const char *bindto,
                                                const char *port)
 {
-    SocketAddressLegacy *saddr;
+    SocketAddress *saddr;
 
-    saddr = g_new0(SocketAddressLegacy, 1);
+    saddr = g_new0(SocketAddress, 1);
     if (sockpath) {
-        saddr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
-        saddr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
-        saddr->u.q_unix.data->path = g_strdup(sockpath);
+        saddr->type = SOCKET_ADDRESS_TYPE_UNIX;
+        saddr->u.q_unix.path = g_strdup(sockpath);
     } else {
         InetSocketAddress *inet;
-        saddr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
-        inet = saddr->u.inet.data = g_new0(InetSocketAddress, 1);
+        saddr->type = SOCKET_ADDRESS_TYPE_INET;
+        inet = &saddr->u.inet;
         inet->host = g_strdup(bindto);
         if (port) {
             inet->port = g_strdup(port);
diff --git a/qga/channel-posix.c b/qga/channel-posix.c
index 65ab8eb..3f34465 100644
--- a/qga/channel-posix.c
+++ b/qga/channel-posix.c
@@ -203,7 +203,7 @@ static gboolean ga_channel_open(GAChannel *c, const gchar *path,
     case GA_CHANNEL_VSOCK_LISTEN: {
         if (fd < 0) {
             Error *local_err = NULL;
-            SocketAddressLegacy *addr;
+            SocketAddress *addr;
             char *addr_str;
 
             addr_str = g_strdup_printf("vsock:%s", path);
@@ -216,7 +216,7 @@ static gboolean ga_channel_open(GAChannel *c, const gchar *path,
             }
 
             fd = socket_listen(addr, &local_err);
-            qapi_free_SocketAddressLegacy(addr);
+            qapi_free_SocketAddress(addr);
             if (local_err != NULL) {
                 g_critical("%s", error_get_pretty(local_err));
                 error_free(local_err);
diff --git a/qga/main.c b/qga/main.c
index cae4d7b..cc58d2b 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -1379,7 +1379,7 @@ int main(int argc, char **argv)
         goto end;
     }
     if (socket_activation) {
-        SocketAddressLegacy *addr;
+        SocketAddress *addr;
 
         g_free(config->method);
         g_free(config->channel_path);
@@ -1388,13 +1388,13 @@ int main(int argc, char **argv)
 
         addr = socket_local_address(FIRST_SOCKET_ACTIVATION_FD, NULL);
         if (addr) {
-            if (addr->type == SOCKET_ADDRESS_LEGACY_KIND_UNIX) {
+            if (addr->type == SOCKET_ADDRESS_TYPE_UNIX) {
                 config->method = g_strdup("unix-listen");
-            } else if (addr->type == SOCKET_ADDRESS_LEGACY_KIND_VSOCK) {
+            } else if (addr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
                 config->method = g_strdup("vsock-listen");
             }
 
-            qapi_free_SocketAddressLegacy(addr);
+            qapi_free_SocketAddress(addr);
         }
 
         if (!config->method) {
diff --git a/tests/test-io-channel-socket.c b/tests/test-io-channel-socket.c
index a66ffc2..d357cd2 100644
--- a/tests/test-io-channel-socket.c
+++ b/tests/test-io-channel-socket.c
@@ -115,8 +115,8 @@ static void test_io_channel_set_socket_bufs(QIOChannel *src,
 }
 
 
-static void test_io_channel_setup_sync(SocketAddressLegacy *listen_addr,
-                                       SocketAddressLegacy *connect_addr,
+static void test_io_channel_setup_sync(SocketAddress *listen_addr,
+                                       SocketAddress *connect_addr,
                                        QIOChannel **src,
                                        QIOChannel **dst)
 {
@@ -125,14 +125,14 @@ static void test_io_channel_setup_sync(SocketAddressLegacy *listen_addr,
     lioc = qio_channel_socket_new();
     qio_channel_socket_listen_sync(lioc, listen_addr, &error_abort);
 
-    if (listen_addr->type == SOCKET_ADDRESS_LEGACY_KIND_INET) {
-        SocketAddressLegacy *laddr = qio_channel_socket_get_local_address(
+    if (listen_addr->type == SOCKET_ADDRESS_TYPE_INET) {
+        SocketAddress *laddr = qio_channel_socket_get_local_address(
             lioc, &error_abort);
 
-        g_free(connect_addr->u.inet.data->port);
-        connect_addr->u.inet.data->port = g_strdup(laddr->u.inet.data->port);
+        g_free(connect_addr->u.inet.port);
+        connect_addr->u.inet.port = g_strdup(laddr->u.inet.port);
 
-        qapi_free_SocketAddressLegacy(laddr);
+        qapi_free_SocketAddress(laddr);
     }
 
     *src = QIO_CHANNEL(qio_channel_socket_new());
@@ -165,8 +165,8 @@ static void test_io_channel_complete(QIOTask *task,
 }
 
 
-static void test_io_channel_setup_async(SocketAddressLegacy *listen_addr,
-                                        SocketAddressLegacy *connect_addr,
+static void test_io_channel_setup_async(SocketAddress *listen_addr,
+                                        SocketAddress *connect_addr,
                                         QIOChannel **src,
                                         QIOChannel **dst)
 {
@@ -186,14 +186,14 @@ static void test_io_channel_setup_async(SocketAddressLegacy *listen_addr,
 
     g_assert(!data.err);
 
-    if (listen_addr->type == SOCKET_ADDRESS_LEGACY_KIND_INET) {
-        SocketAddressLegacy *laddr = qio_channel_socket_get_local_address(
+    if (listen_addr->type == SOCKET_ADDRESS_TYPE_INET) {
+        SocketAddress *laddr = qio_channel_socket_get_local_address(
             lioc, &error_abort);
 
-        g_free(connect_addr->u.inet.data->port);
-        connect_addr->u.inet.data->port = g_strdup(laddr->u.inet.data->port);
+        g_free(connect_addr->u.inet.port);
+        connect_addr->u.inet.port = g_strdup(laddr->u.inet.port);
 
-        qapi_free_SocketAddressLegacy(laddr);
+        qapi_free_SocketAddress(laddr);
     }
 
     *src = QIO_CHANNEL(qio_channel_socket_new());
@@ -221,8 +221,8 @@ static void test_io_channel_setup_async(SocketAddressLegacy *listen_addr,
 
 
 static void test_io_channel(bool async,
-                            SocketAddressLegacy *listen_addr,
-                            SocketAddressLegacy *connect_addr,
+                            SocketAddress *listen_addr,
+                            SocketAddress *connect_addr,
                             bool passFD)
 {
     QIOChannel *src, *dst;
@@ -297,27 +297,25 @@ static void test_io_channel(bool async,
 
 static void test_io_channel_ipv4(bool async)
 {
-    SocketAddressLegacy *listen_addr = g_new0(SocketAddressLegacy, 1);
-    SocketAddressLegacy *connect_addr = g_new0(SocketAddressLegacy, 1);
+    SocketAddress *listen_addr = g_new0(SocketAddress, 1);
+    SocketAddress *connect_addr = g_new0(SocketAddress, 1);
 
-    listen_addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
-    listen_addr->u.inet.data = g_new(InetSocketAddress, 1);
-    *listen_addr->u.inet.data = (InetSocketAddress) {
+    listen_addr->type = SOCKET_ADDRESS_TYPE_INET;
+    listen_addr->u.inet = (InetSocketAddress) {
         .host = g_strdup("127.0.0.1"),
         .port = NULL, /* Auto-select */
     };
 
-    connect_addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
-    connect_addr->u.inet.data = g_new(InetSocketAddress, 1);
-    *connect_addr->u.inet.data = (InetSocketAddress) {
+    connect_addr->type = SOCKET_ADDRESS_TYPE_INET;
+    connect_addr->u.inet = (InetSocketAddress) {
         .host = g_strdup("127.0.0.1"),
         .port = NULL, /* Filled in later */
     };
 
     test_io_channel(async, listen_addr, connect_addr, false);
 
-    qapi_free_SocketAddressLegacy(listen_addr);
-    qapi_free_SocketAddressLegacy(connect_addr);
+    qapi_free_SocketAddress(listen_addr);
+    qapi_free_SocketAddress(connect_addr);
 }
 
 
@@ -335,27 +333,25 @@ static void test_io_channel_ipv4_async(void)
 
 static void test_io_channel_ipv6(bool async)
 {
-    SocketAddressLegacy *listen_addr = g_new0(SocketAddressLegacy, 1);
-    SocketAddressLegacy *connect_addr = g_new0(SocketAddressLegacy, 1);
+    SocketAddress *listen_addr = g_new0(SocketAddress, 1);
+    SocketAddress *connect_addr = g_new0(SocketAddress, 1);
 
-    listen_addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
-    listen_addr->u.inet.data = g_new(InetSocketAddress, 1);
-    *listen_addr->u.inet.data = (InetSocketAddress) {
+    listen_addr->type = SOCKET_ADDRESS_TYPE_INET;
+    listen_addr->u.inet = (InetSocketAddress) {
         .host = g_strdup("::1"),
         .port = NULL, /* Auto-select */
     };
 
-    connect_addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
-    connect_addr->u.inet.data = g_new(InetSocketAddress, 1);
-    *connect_addr->u.inet.data = (InetSocketAddress) {
+    connect_addr->type = SOCKET_ADDRESS_TYPE_INET;
+    connect_addr->u.inet = (InetSocketAddress) {
         .host = g_strdup("::1"),
         .port = NULL, /* Filled in later */
     };
 
     test_io_channel(async, listen_addr, connect_addr, false);
 
-    qapi_free_SocketAddressLegacy(listen_addr);
-    qapi_free_SocketAddressLegacy(connect_addr);
+    qapi_free_SocketAddress(listen_addr);
+    qapi_free_SocketAddress(connect_addr);
 }
 
 
@@ -374,22 +370,20 @@ static void test_io_channel_ipv6_async(void)
 #ifndef _WIN32
 static void test_io_channel_unix(bool async)
 {
-    SocketAddressLegacy *listen_addr = g_new0(SocketAddressLegacy, 1);
-    SocketAddressLegacy *connect_addr = g_new0(SocketAddressLegacy, 1);
+    SocketAddress *listen_addr = g_new0(SocketAddress, 1);
+    SocketAddress *connect_addr = g_new0(SocketAddress, 1);
 
 #define TEST_SOCKET "test-io-channel-socket.sock"
-    listen_addr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
-    listen_addr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
-    listen_addr->u.q_unix.data->path = g_strdup(TEST_SOCKET);
+    listen_addr->type = SOCKET_ADDRESS_TYPE_UNIX;
+    listen_addr->u.q_unix.path = g_strdup(TEST_SOCKET);
 
-    connect_addr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
-    connect_addr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
-    connect_addr->u.q_unix.data->path = g_strdup(TEST_SOCKET);
+    connect_addr->type = SOCKET_ADDRESS_TYPE_UNIX;
+    connect_addr->u.q_unix.path = g_strdup(TEST_SOCKET);
 
     test_io_channel(async, listen_addr, connect_addr, true);
 
-    qapi_free_SocketAddressLegacy(listen_addr);
-    qapi_free_SocketAddressLegacy(connect_addr);
+    qapi_free_SocketAddress(listen_addr);
+    qapi_free_SocketAddress(connect_addr);
     g_assert(g_file_test(TEST_SOCKET, G_FILE_TEST_EXISTS) == FALSE);
 }
 
@@ -407,8 +401,8 @@ static void test_io_channel_unix_async(void)
 
 static void test_io_channel_unix_fd_pass(void)
 {
-    SocketAddressLegacy *listen_addr = g_new0(SocketAddressLegacy, 1);
-    SocketAddressLegacy *connect_addr = g_new0(SocketAddressLegacy, 1);
+    SocketAddress *listen_addr = g_new0(SocketAddress, 1);
+    SocketAddress *connect_addr = g_new0(SocketAddress, 1);
     QIOChannel *src, *dst;
     int testfd;
     int fdsend[3];
@@ -427,13 +421,11 @@ static void test_io_channel_unix_fd_pass(void)
     fdsend[1] = testfd;
     fdsend[2] = testfd;
 
-    listen_addr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
-    listen_addr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
-    listen_addr->u.q_unix.data->path = g_strdup(TEST_SOCKET);
+    listen_addr->type = SOCKET_ADDRESS_TYPE_UNIX;
+    listen_addr->u.q_unix.path = g_strdup(TEST_SOCKET);
 
-    connect_addr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
-    connect_addr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
-    connect_addr->u.q_unix.data->path = g_strdup(TEST_SOCKET);
+    connect_addr->type = SOCKET_ADDRESS_TYPE_UNIX;
+    connect_addr->u.q_unix.path = g_strdup(TEST_SOCKET);
 
     test_io_channel_setup_sync(listen_addr, connect_addr, &src, &dst);
 
@@ -488,8 +480,8 @@ static void test_io_channel_unix_fd_pass(void)
 
     object_unref(OBJECT(src));
     object_unref(OBJECT(dst));
-    qapi_free_SocketAddressLegacy(listen_addr);
-    qapi_free_SocketAddressLegacy(connect_addr);
+    qapi_free_SocketAddress(listen_addr);
+    qapi_free_SocketAddress(connect_addr);
     unlink(TEST_SOCKET);
     unlink(TEST_FILE);
     close(testfd);
diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
index c7fa9b6..3ade4a4 100644
--- a/ui/vnc-auth-sasl.c
+++ b/ui/vnc-auth-sasl.c
@@ -498,7 +498,7 @@ vnc_socket_ip_addr_string(QIOChannelSocket *ioc,
                           bool local,
                           Error **errp)
 {
-    SocketAddressLegacy *addr;
+    SocketAddress *addr;
     char *ret;
 
     if (local) {
@@ -510,13 +510,12 @@ vnc_socket_ip_addr_string(QIOChannelSocket *ioc,
         return NULL;
     }
 
-    if (addr->type != SOCKET_ADDRESS_LEGACY_KIND_INET) {
+    if (addr->type != SOCKET_ADDRESS_TYPE_INET) {
         error_setg(errp, "Not an inet socket type");
         return NULL;
     }
-    ret = g_strdup_printf("%s;%s", addr->u.inet.data->host,
-                          addr->u.inet.data->port);
-    qapi_free_SocketAddressLegacy(addr);
+    ret = g_strdup_printf("%s;%s", addr->u.inet.host, addr->u.inet.port);
+    qapi_free_SocketAddress(addr);
     return ret;
 }
 
diff --git a/ui/vnc.c b/ui/vnc.c
index 5090a25..9c4edcd 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -108,31 +108,31 @@ static void vnc_set_share_mode(VncState *vs, VncShareMode mode)
 }
 
 
-static void vnc_init_basic_info(SocketAddressLegacy *addr,
+static void vnc_init_basic_info(SocketAddress *addr,
                                 VncBasicInfo *info,
                                 Error **errp)
 {
     switch (addr->type) {
-    case SOCKET_ADDRESS_LEGACY_KIND_INET:
-        info->host = g_strdup(addr->u.inet.data->host);
-        info->service = g_strdup(addr->u.inet.data->port);
-        if (addr->u.inet.data->ipv6) {
+    case SOCKET_ADDRESS_TYPE_INET:
+        info->host = g_strdup(addr->u.inet.host);
+        info->service = g_strdup(addr->u.inet.port);
+        if (addr->u.inet.ipv6) {
             info->family = NETWORK_ADDRESS_FAMILY_IPV6;
         } else {
             info->family = NETWORK_ADDRESS_FAMILY_IPV4;
         }
         break;
 
-    case SOCKET_ADDRESS_LEGACY_KIND_UNIX:
+    case SOCKET_ADDRESS_TYPE_UNIX:
         info->host = g_strdup("");
-        info->service = g_strdup(addr->u.q_unix.data->path);
+        info->service = g_strdup(addr->u.q_unix.path);
         info->family = NETWORK_ADDRESS_FAMILY_UNIX;
         break;
 
-    case SOCKET_ADDRESS_LEGACY_KIND_VSOCK:
-    case SOCKET_ADDRESS_LEGACY_KIND_FD:
+    case SOCKET_ADDRESS_TYPE_VSOCK:
+    case SOCKET_ADDRESS_TYPE_FD:
         error_setg(errp, "Unsupported socket address type %s",
-                   SocketAddressLegacyKind_lookup[addr->type]);
+                   SocketAddressType_lookup[addr->type]);
         break;
     default:
         abort();
@@ -145,7 +145,7 @@ static void vnc_init_basic_info_from_server_addr(QIOChannelSocket *ioc,
                                                  VncBasicInfo *info,
                                                  Error **errp)
 {
-    SocketAddressLegacy *addr = NULL;
+    SocketAddress *addr = NULL;
 
     if (!ioc) {
         error_setg(errp, "No listener socket available");
@@ -158,14 +158,14 @@ static void vnc_init_basic_info_from_server_addr(QIOChannelSocket *ioc,
     }
 
     vnc_init_basic_info(addr, info, errp);
-    qapi_free_SocketAddressLegacy(addr);
+    qapi_free_SocketAddress(addr);
 }
 
 static void vnc_init_basic_info_from_remote_addr(QIOChannelSocket *ioc,
                                                  VncBasicInfo *info,
                                                  Error **errp)
 {
-    SocketAddressLegacy *addr = NULL;
+    SocketAddress *addr = NULL;
 
     addr = qio_channel_socket_get_remote_address(ioc, errp);
     if (!addr) {
@@ -173,7 +173,7 @@ static void vnc_init_basic_info_from_remote_addr(QIOChannelSocket *ioc,
     }
 
     vnc_init_basic_info(addr, info, errp);
-    qapi_free_SocketAddressLegacy(addr);
+    qapi_free_SocketAddress(addr);
 }
 
 static const char *vnc_auth_name(VncDisplay *vd) {
@@ -377,7 +377,7 @@ VncInfo *qmp_query_vnc(Error **errp)
 {
     VncInfo *info = g_malloc0(sizeof(*info));
     VncDisplay *vd = vnc_display_find(NULL);
-    SocketAddressLegacy *addr = NULL;
+    SocketAddress *addr = NULL;
 
     if (vd == NULL || !vd->nlsock) {
         info->enabled = false;
@@ -398,26 +398,26 @@ VncInfo *qmp_query_vnc(Error **errp)
         }
 
         switch (addr->type) {
-        case SOCKET_ADDRESS_LEGACY_KIND_INET:
-            info->host = g_strdup(addr->u.inet.data->host);
-            info->service = g_strdup(addr->u.inet.data->port);
-            if (addr->u.inet.data->ipv6) {
+        case SOCKET_ADDRESS_TYPE_INET:
+            info->host = g_strdup(addr->u.inet.host);
+            info->service = g_strdup(addr->u.inet.port);
+            if (addr->u.inet.ipv6) {
                 info->family = NETWORK_ADDRESS_FAMILY_IPV6;
             } else {
                 info->family = NETWORK_ADDRESS_FAMILY_IPV4;
             }
             break;
 
-        case SOCKET_ADDRESS_LEGACY_KIND_UNIX:
+        case SOCKET_ADDRESS_TYPE_UNIX:
             info->host = g_strdup("");
-            info->service = g_strdup(addr->u.q_unix.data->path);
+            info->service = g_strdup(addr->u.q_unix.path);
             info->family = NETWORK_ADDRESS_FAMILY_UNIX;
             break;
 
-        case SOCKET_ADDRESS_LEGACY_KIND_VSOCK:
-        case SOCKET_ADDRESS_LEGACY_KIND_FD:
+        case SOCKET_ADDRESS_TYPE_VSOCK:
+        case SOCKET_ADDRESS_TYPE_FD:
             error_setg(errp, "Unsupported socket address type %s",
-                       SocketAddressLegacyKind_lookup[addr->type]);
+                       SocketAddressType_lookup[addr->type]);
             goto out_error;
         default:
             abort();
@@ -431,11 +431,11 @@ VncInfo *qmp_query_vnc(Error **errp)
         info->auth = g_strdup(vnc_auth_name(vd));
     }
 
-    qapi_free_SocketAddressLegacy(addr);
+    qapi_free_SocketAddress(addr);
     return info;
 
 out_error:
-    qapi_free_SocketAddressLegacy(addr);
+    qapi_free_SocketAddress(addr);
     qapi_free_VncInfo(info);
     return NULL;
 }
@@ -455,7 +455,7 @@ static VncServerInfo2List *qmp_query_server_entry(QIOChannelSocket *ioc,
     VncServerInfo2List *list;
     VncServerInfo2 *info;
     Error *err = NULL;
-    SocketAddressLegacy *addr;
+    SocketAddress *addr;
 
     addr = qio_channel_socket_get_local_address(ioc, &err);
     if (!addr) {
@@ -465,7 +465,7 @@ static VncServerInfo2List *qmp_query_server_entry(QIOChannelSocket *ioc,
 
     info = g_new0(VncServerInfo2, 1);
     vnc_init_basic_info(addr, qapi_VncServerInfo2_base(info), &err);
-    qapi_free_SocketAddressLegacy(addr);
+    qapi_free_SocketAddress(addr);
     if (err) {
         qapi_free_VncServerInfo2(info);
         error_free(err);
@@ -3149,7 +3149,7 @@ int vnc_display_pw_expire(const char *id, time_t expires)
 
 static void vnc_display_print_local_addr(VncDisplay *vd)
 {
-    SocketAddressLegacy *addr;
+    SocketAddress *addr;
     Error *err = NULL;
 
     if (!vd->nlsock) {
@@ -3161,14 +3161,14 @@ static void vnc_display_print_local_addr(VncDisplay *vd)
         return;
     }
 
-    if (addr->type != SOCKET_ADDRESS_LEGACY_KIND_INET) {
-        qapi_free_SocketAddressLegacy(addr);
+    if (addr->type != SOCKET_ADDRESS_TYPE_INET) {
+        qapi_free_SocketAddress(addr);
         return;
     }
     error_printf_unless_qmp("VNC server running on %s:%s\n",
-                            addr->u.inet.data->host,
-                            addr->u.inet.data->port);
-    qapi_free_SocketAddressLegacy(addr);
+                            addr->u.inet.host,
+                            addr->u.inet.port);
+    qapi_free_SocketAddress(addr);
 }
 
 static QemuOptsList qemu_vnc_opts = {
@@ -3414,18 +3414,17 @@ static int vnc_display_get_address(const char *addrstr,
                                    bool has_ipv6,
                                    bool ipv4,
                                    bool ipv6,
-                                   SocketAddressLegacy **retaddr,
+                                   SocketAddress **retaddr,
                                    Error **errp)
 {
     int ret = -1;
-    SocketAddressLegacy *addr = NULL;
+    SocketAddress *addr = NULL;
 
-    addr = g_new0(SocketAddressLegacy, 1);
+    addr = g_new0(SocketAddress, 1);
 
     if (strncmp(addrstr, "unix:", 5) == 0) {
-        addr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
-        addr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
-        addr->u.q_unix.data->path = g_strdup(addrstr + 5);
+        addr->type = SOCKET_ADDRESS_TYPE_UNIX;
+        addr->u.q_unix.path = g_strdup(addrstr + 5);
 
         if (websocket) {
             error_setg(errp, "UNIX sockets not supported with websock");
@@ -3461,8 +3460,8 @@ static int vnc_display_get_address(const char *addrstr,
             }
         }
 
-        addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
-        inet = addr->u.inet.data = g_new0(InetSocketAddress, 1);
+        addr->type = SOCKET_ADDRESS_TYPE_INET;
+        inet = &addr->u.inet;
         if (addrstr[0] == '[' && addrstr[hostlen - 1] == ']') {
             inet->host = g_strndup(addrstr + 1, hostlen - 2);
         } else {
@@ -3518,21 +3517,21 @@ static int vnc_display_get_address(const char *addrstr,
 
  cleanup:
     if (ret < 0) {
-        qapi_free_SocketAddressLegacy(addr);
+        qapi_free_SocketAddress(addr);
     }
     return ret;
 }
 
 static int vnc_display_get_addresses(QemuOpts *opts,
                                      bool reverse,
-                                     SocketAddressLegacy ***retsaddr,
+                                     SocketAddress ***retsaddr,
                                      size_t *retnsaddr,
-                                     SocketAddressLegacy ***retwsaddr,
+                                     SocketAddress ***retwsaddr,
                                      size_t *retnwsaddr,
                                      Error **errp)
 {
-    SocketAddressLegacy *saddr = NULL;
-    SocketAddressLegacy *wsaddr = NULL;
+    SocketAddress *saddr = NULL;
+    SocketAddress *wsaddr = NULL;
     QemuOptsIter addriter;
     const char *addr;
     int to = qemu_opt_get_number(opts, "to", 0);
@@ -3577,7 +3576,7 @@ static int vnc_display_get_addresses(QemuOpts *opts,
         if (displaynum == -1) {
             displaynum = rv;
         }
-        *retsaddr = g_renew(SocketAddressLegacy *, *retsaddr, *retnsaddr + 1);
+        *retsaddr = g_renew(SocketAddress *, *retsaddr, *retnsaddr + 1);
         (*retsaddr)[(*retnsaddr)++] = saddr;
     }
 
@@ -3601,16 +3600,15 @@ static int vnc_display_get_addresses(QemuOpts *opts,
          * address for websocket too
          */
         if (*retnsaddr == 1 &&
-            (*retsaddr)[0]->type == SOCKET_ADDRESS_LEGACY_KIND_INET &&
-            wsaddr->type == SOCKET_ADDRESS_LEGACY_KIND_INET &&
-            g_str_equal(wsaddr->u.inet.data->host, "") &&
-            !g_str_equal((*retsaddr)[0]->u.inet.data->host, "")) {
-            g_free(wsaddr->u.inet.data->host);
-            wsaddr->u.inet.data->host =
-                g_strdup((*retsaddr)[0]->u.inet.data->host);
+            (*retsaddr)[0]->type == SOCKET_ADDRESS_TYPE_INET &&
+            wsaddr->type == SOCKET_ADDRESS_TYPE_INET &&
+            g_str_equal(wsaddr->u.inet.host, "") &&
+            !g_str_equal((*retsaddr)[0]->u.inet.host, "")) {
+            g_free(wsaddr->u.inet.host);
+            wsaddr->u.inet.host = g_strdup((*retsaddr)[0]->u.inet.host);
         }
 
-        *retwsaddr = g_renew(SocketAddressLegacy *, *retwsaddr, *retnwsaddr + 1);
+        *retwsaddr = g_renew(SocketAddress *, *retwsaddr, *retnwsaddr + 1);
         (*retwsaddr)[(*retnwsaddr)++] = wsaddr;
     }
 
@@ -3618,11 +3616,11 @@ static int vnc_display_get_addresses(QemuOpts *opts,
  cleanup:
     if (ret < 0) {
         for (i = 0; i < *retnsaddr; i++) {
-            qapi_free_SocketAddressLegacy((*retsaddr)[i]);
+            qapi_free_SocketAddress((*retsaddr)[i]);
         }
         g_free(*retsaddr);
         for (i = 0; i < *retnwsaddr; i++) {
-            qapi_free_SocketAddressLegacy((*retwsaddr)[i]);
+            qapi_free_SocketAddress((*retwsaddr)[i]);
         }
         g_free(*retwsaddr);
         *retsaddr = *retwsaddr = NULL;
@@ -3632,9 +3630,9 @@ static int vnc_display_get_addresses(QemuOpts *opts,
 }
 
 static int vnc_display_connect(VncDisplay *vd,
-                               SocketAddressLegacy **saddr,
+                               SocketAddress **saddr,
                                size_t nsaddr,
-                               SocketAddressLegacy **wsaddr,
+                               SocketAddress **wsaddr,
                                size_t nwsaddr,
                                Error **errp)
 {
@@ -3648,8 +3646,8 @@ static int vnc_display_connect(VncDisplay *vd,
         error_setg(errp, "Expected a single address in reverse mode");
         return -1;
     }
-    /* TODO SOCKET_ADDRESS_LEGACY_KIND_FD when fd has AF_UNIX */
-    vd->is_unix = saddr[0]->type == SOCKET_ADDRESS_LEGACY_KIND_UNIX;
+    /* TODO SOCKET_ADDRESS_TYPE_FD when fd has AF_UNIX */
+    vd->is_unix = saddr[0]->type == SOCKET_ADDRESS_TYPE_UNIX;
     sioc = qio_channel_socket_new();
     qio_channel_set_name(QIO_CHANNEL(sioc), "vnc-reverse");
     if (qio_channel_socket_connect_sync(sioc, saddr[0], errp) < 0) {
@@ -3662,7 +3660,7 @@ static int vnc_display_connect(VncDisplay *vd,
 
 
 static int vnc_display_listen_addr(VncDisplay *vd,
-                                   SocketAddressLegacy *addr,
+                                   SocketAddress *addr,
                                    const char *name,
                                    QIOChannelSocket ***lsock,
                                    guint **lsock_tag,
@@ -3670,7 +3668,7 @@ static int vnc_display_listen_addr(VncDisplay *vd,
                                    Error **errp)
 {
     QIODNSResolver *resolver = qio_dns_resolver_get_instance();
-    SocketAddressLegacy **rawaddrs = NULL;
+    SocketAddress **rawaddrs = NULL;
     size_t nrawaddrs = 0;
     Error *listenerr = NULL;
     bool listening = false;
@@ -3700,7 +3698,7 @@ static int vnc_display_listen_addr(VncDisplay *vd,
     }
 
     for (i = 0; i < nrawaddrs; i++) {
-        qapi_free_SocketAddressLegacy(rawaddrs[i]);
+        qapi_free_SocketAddress(rawaddrs[i]);
     }
     g_free(rawaddrs);
 
@@ -3724,9 +3722,9 @@ static int vnc_display_listen_addr(VncDisplay *vd,
 
 
 static int vnc_display_listen(VncDisplay *vd,
-                              SocketAddressLegacy **saddr,
+                              SocketAddress **saddr,
                               size_t nsaddr,
-                              SocketAddressLegacy **wsaddr,
+                              SocketAddress **wsaddr,
                               size_t nwsaddr,
                               Error **errp)
 {
@@ -3761,7 +3759,7 @@ void vnc_display_open(const char *id, Error **errp)
 {
     VncDisplay *vd = vnc_display_find(id);
     QemuOpts *opts = qemu_opts_find(&qemu_vnc_opts, id);
-    SocketAddressLegacy **saddr = NULL, **wsaddr = NULL;
+    SocketAddress **saddr = NULL, **wsaddr = NULL;
     size_t nsaddr, nwsaddr;
     const char *share, *device_id;
     QemuConsole *con;
@@ -3997,10 +3995,10 @@ void vnc_display_open(const char *id, Error **errp)
 
  cleanup:
     for (i = 0; i < nsaddr; i++) {
-        qapi_free_SocketAddressLegacy(saddr[i]);
+        qapi_free_SocketAddress(saddr[i]);
     }
     for (i = 0; i < nwsaddr; i++) {
-        qapi_free_SocketAddressLegacy(wsaddr[i]);
+        qapi_free_SocketAddress(wsaddr[i]);
     }
     return;
 
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 801aa7a..ad3ce65 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -22,6 +22,7 @@
 #endif /* CONFIG_AF_VSOCK */
 
 #include "monitor/monitor.h"
+#include "qapi/clone-visitor.h"
 #include "qapi/error.h"
 #include "qemu/sockets.h"
 #include "qemu/main-loop.h"
@@ -1029,73 +1030,69 @@ int unix_connect(const char *path, Error **errp)
 }
 
 
-SocketAddressLegacy *socket_parse(const char *str, Error **errp)
+SocketAddress *socket_parse(const char *str, Error **errp)
 {
-    SocketAddressLegacy *addr;
+    SocketAddress *addr;
 
-    addr = g_new0(SocketAddressLegacy, 1);
+    addr = g_new0(SocketAddress, 1);
     if (strstart(str, "unix:", NULL)) {
         if (str[5] == '\0') {
             error_setg(errp, "invalid Unix socket address");
             goto fail;
         } else {
-            addr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
-            addr->u.q_unix.data = g_new(UnixSocketAddress, 1);
-            addr->u.q_unix.data->path = g_strdup(str + 5);
+            addr->type = SOCKET_ADDRESS_TYPE_UNIX;
+            addr->u.q_unix.path = g_strdup(str + 5);
         }
     } else if (strstart(str, "fd:", NULL)) {
         if (str[3] == '\0') {
             error_setg(errp, "invalid file descriptor address");
             goto fail;
         } else {
-            addr->type = SOCKET_ADDRESS_LEGACY_KIND_FD;
-            addr->u.fd.data = g_new(String, 1);
-            addr->u.fd.data->str = g_strdup(str + 3);
+            addr->type = SOCKET_ADDRESS_TYPE_FD;
+            addr->u.fd.str = g_strdup(str + 3);
         }
     } else if (strstart(str, "vsock:", NULL)) {
-        addr->type = SOCKET_ADDRESS_LEGACY_KIND_VSOCK;
-        addr->u.vsock.data = g_new(VsockSocketAddress, 1);
-        if (vsock_parse(addr->u.vsock.data, str + strlen("vsock:"), errp)) {
+        addr->type = SOCKET_ADDRESS_TYPE_VSOCK;
+        if (vsock_parse(&addr->u.vsock, str + strlen("vsock:"), errp)) {
             goto fail;
         }
     } else {
-        addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
-        addr->u.inet.data = g_new(InetSocketAddress, 1);
-        if (inet_parse(addr->u.inet.data, str, errp)) {
+        addr->type = SOCKET_ADDRESS_TYPE_INET;
+        if (inet_parse(&addr->u.inet, str, errp)) {
             goto fail;
         }
     }
     return addr;
 
 fail:
-    qapi_free_SocketAddressLegacy(addr);
+    qapi_free_SocketAddress(addr);
     return NULL;
 }
 
-int socket_connect(SocketAddressLegacy *addr, NonBlockingConnectHandler *callback,
+int socket_connect(SocketAddress *addr, NonBlockingConnectHandler *callback,
                    void *opaque, Error **errp)
 {
     int fd;
 
     switch (addr->type) {
-    case SOCKET_ADDRESS_LEGACY_KIND_INET:
-        fd = inet_connect_saddr(addr->u.inet.data, callback, opaque, errp);
+    case SOCKET_ADDRESS_TYPE_INET:
+        fd = inet_connect_saddr(&addr->u.inet, callback, opaque, errp);
         break;
 
-    case SOCKET_ADDRESS_LEGACY_KIND_UNIX:
-        fd = unix_connect_saddr(addr->u.q_unix.data, callback, opaque, errp);
+    case SOCKET_ADDRESS_TYPE_UNIX:
+        fd = unix_connect_saddr(&addr->u.q_unix, callback, opaque, errp);
         break;
 
-    case SOCKET_ADDRESS_LEGACY_KIND_FD:
-        fd = monitor_get_fd(cur_mon, addr->u.fd.data->str, errp);
+    case SOCKET_ADDRESS_TYPE_FD:
+        fd = monitor_get_fd(cur_mon, addr->u.fd.str, errp);
         if (fd >= 0 && callback) {
             qemu_set_nonblock(fd);
             callback(fd, NULL, opaque);
         }
         break;
 
-    case SOCKET_ADDRESS_LEGACY_KIND_VSOCK:
-        fd = vsock_connect_saddr(addr->u.vsock.data, callback, opaque, errp);
+    case SOCKET_ADDRESS_TYPE_VSOCK:
+        fd = vsock_connect_saddr(&addr->u.vsock, callback, opaque, errp);
         break;
 
     default:
@@ -1104,25 +1101,25 @@ int socket_connect(SocketAddressLegacy *addr, NonBlockingConnectHandler *callbac
     return fd;
 }
 
-int socket_listen(SocketAddressLegacy *addr, Error **errp)
+int socket_listen(SocketAddress *addr, Error **errp)
 {
     int fd;
 
     switch (addr->type) {
-    case SOCKET_ADDRESS_LEGACY_KIND_INET:
-        fd = inet_listen_saddr(addr->u.inet.data, 0, false, errp);
+    case SOCKET_ADDRESS_TYPE_INET:
+        fd = inet_listen_saddr(&addr->u.inet, 0, false, errp);
         break;
 
-    case SOCKET_ADDRESS_LEGACY_KIND_UNIX:
-        fd = unix_listen_saddr(addr->u.q_unix.data, false, errp);
+    case SOCKET_ADDRESS_TYPE_UNIX:
+        fd = unix_listen_saddr(&addr->u.q_unix, false, errp);
         break;
 
-    case SOCKET_ADDRESS_LEGACY_KIND_FD:
-        fd = monitor_get_fd(cur_mon, addr->u.fd.data->str, errp);
+    case SOCKET_ADDRESS_TYPE_FD:
+        fd = monitor_get_fd(cur_mon, addr->u.fd.str, errp);
         break;
 
-    case SOCKET_ADDRESS_LEGACY_KIND_VSOCK:
-        fd = vsock_listen_saddr(addr->u.vsock.data, errp);
+    case SOCKET_ADDRESS_TYPE_VSOCK:
+        fd = vsock_listen_saddr(&addr->u.vsock, errp);
         break;
 
     default:
@@ -1133,34 +1130,34 @@ int socket_listen(SocketAddressLegacy *addr, Error **errp)
 
 void socket_listen_cleanup(int fd, Error **errp)
 {
-    SocketAddressLegacy *addr;
+    SocketAddress *addr;
 
     addr = socket_local_address(fd, errp);
 
-    if (addr->type == SOCKET_ADDRESS_LEGACY_KIND_UNIX
-        && addr->u.q_unix.data->path) {
-        if (unlink(addr->u.q_unix.data->path) < 0 && errno != ENOENT) {
+    if (addr->type == SOCKET_ADDRESS_TYPE_UNIX
+        && addr->u.q_unix.path) {
+        if (unlink(addr->u.q_unix.path) < 0 && errno != ENOENT) {
             error_setg_errno(errp, errno,
                              "Failed to unlink socket %s",
-                             addr->u.q_unix.data->path);
+                             addr->u.q_unix.path);
         }
     }
 
-    qapi_free_SocketAddressLegacy(addr);
+    qapi_free_SocketAddress(addr);
 }
 
-int socket_dgram(SocketAddressLegacy *remote, SocketAddressLegacy *local, Error **errp)
+int socket_dgram(SocketAddress *remote, SocketAddress *local, Error **errp)
 {
     int fd;
 
     /*
-     * TODO SOCKET_ADDRESS_LEGACY_KIND_FD when fd is AF_INET or AF_INET6
+     * TODO SOCKET_ADDRESS_TYPE_FD when fd is AF_INET or AF_INET6
      * (although other address families can do SOCK_DGRAM, too)
      */
     switch (remote->type) {
-    case SOCKET_ADDRESS_LEGACY_KIND_INET:
-        fd = inet_dgram_saddr(remote->u.inet.data,
-                              local ? local->u.inet.data : NULL, errp);
+    case SOCKET_ADDRESS_TYPE_INET:
+        fd = inet_dgram_saddr(&remote->u.inet,
+                              local ? &local->u.inet : NULL, errp);
         break;
 
     default:
@@ -1171,14 +1168,14 @@ int socket_dgram(SocketAddressLegacy *remote, SocketAddressLegacy *local, Error
 }
 
 
-static SocketAddressLegacy *
+static SocketAddress *
 socket_sockaddr_to_address_inet(struct sockaddr_storage *sa,
                                 socklen_t salen,
                                 Error **errp)
 {
     char host[NI_MAXHOST];
     char serv[NI_MAXSERV];
-    SocketAddressLegacy *addr;
+    SocketAddress *addr;
     InetSocketAddress *inet;
     int ret;
 
@@ -1192,9 +1189,9 @@ socket_sockaddr_to_address_inet(struct sockaddr_storage *sa,
         return NULL;
     }
 
-    addr = g_new0(SocketAddressLegacy, 1);
-    addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
-    inet = addr->u.inet.data = g_new0(InetSocketAddress, 1);
+    addr = g_new0(SocketAddress, 1);
+    addr->type = SOCKET_ADDRESS_TYPE_INET;
+    inet = &addr->u.inet;
     inet->host = g_strdup(host);
     inet->port = g_strdup(serv);
     if (sa->ss_family == AF_INET) {
@@ -1208,20 +1205,18 @@ socket_sockaddr_to_address_inet(struct sockaddr_storage *sa,
 
 
 #ifndef WIN32
-static SocketAddressLegacy *
+static SocketAddress *
 socket_sockaddr_to_address_unix(struct sockaddr_storage *sa,
                                 socklen_t salen,
                                 Error **errp)
 {
-    SocketAddressLegacy *addr;
+    SocketAddress *addr;
     struct sockaddr_un *su = (struct sockaddr_un *)sa;
 
-    addr = g_new0(SocketAddressLegacy, 1);
-    addr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
-    addr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
+    addr = g_new0(SocketAddress, 1);
+    addr->type = SOCKET_ADDRESS_TYPE_UNIX;
     if (su->sun_path[0]) {
-        addr->u.q_unix.data->path = g_strndup(su->sun_path,
-                                              sizeof(su->sun_path));
+        addr->u.q_unix.path = g_strndup(su->sun_path, sizeof(su->sun_path));
     }
 
     return addr;
@@ -1229,18 +1224,18 @@ socket_sockaddr_to_address_unix(struct sockaddr_storage *sa,
 #endif /* WIN32 */
 
 #ifdef CONFIG_AF_VSOCK
-static SocketAddressLegacy *
+static SocketAddress *
 socket_sockaddr_to_address_vsock(struct sockaddr_storage *sa,
                                  socklen_t salen,
                                  Error **errp)
 {
-    SocketAddressLegacy *addr;
+    SocketAddress *addr;
     VsockSocketAddress *vaddr;
     struct sockaddr_vm *svm = (struct sockaddr_vm *)sa;
 
-    addr = g_new0(SocketAddressLegacy, 1);
-    addr->type = SOCKET_ADDRESS_LEGACY_KIND_VSOCK;
-    addr->u.vsock.data = vaddr = g_new0(VsockSocketAddress, 1);
+    addr = g_new0(SocketAddress, 1);
+    addr->type = SOCKET_ADDRESS_TYPE_VSOCK;
+    vaddr = &addr->u.vsock;
     vaddr->cid = g_strdup_printf("%u", svm->svm_cid);
     vaddr->port = g_strdup_printf("%u", svm->svm_port);
 
@@ -1248,7 +1243,7 @@ socket_sockaddr_to_address_vsock(struct sockaddr_storage *sa,
 }
 #endif /* CONFIG_AF_VSOCK */
 
-SocketAddressLegacy *
+SocketAddress *
 socket_sockaddr_to_address(struct sockaddr_storage *sa,
                            socklen_t salen,
                            Error **errp)
@@ -1277,7 +1272,7 @@ socket_sockaddr_to_address(struct sockaddr_storage *sa,
 }
 
 
-SocketAddressLegacy *socket_local_address(int fd, Error **errp)
+SocketAddress *socket_local_address(int fd, Error **errp)
 {
     struct sockaddr_storage ss;
     socklen_t sslen = sizeof(ss);
@@ -1292,7 +1287,7 @@ SocketAddressLegacy *socket_local_address(int fd, Error **errp)
 }
 
 
-SocketAddressLegacy *socket_remote_address(int fd, Error **errp)
+SocketAddress *socket_remote_address(int fd, Error **errp)
 {
     struct sockaddr_storage ss;
     socklen_t sslen = sizeof(ss);
@@ -1306,14 +1301,14 @@ SocketAddressLegacy *socket_remote_address(int fd, Error **errp)
     return socket_sockaddr_to_address(&ss, sslen, errp);
 }
 
-char *socket_address_to_string(struct SocketAddressLegacy *addr, Error **errp)
+char *socket_address_to_string(struct SocketAddress *addr, Error **errp)
 {
     char *buf;
     InetSocketAddress *inet;
 
     switch (addr->type) {
-    case SOCKET_ADDRESS_LEGACY_KIND_INET:
-        inet = addr->u.inet.data;
+    case SOCKET_ADDRESS_TYPE_INET:
+        inet = &addr->u.inet;
         if (strchr(inet->host, ':') == NULL) {
             buf = g_strdup_printf("%s:%s", inet->host, inet->port);
         } else {
@@ -1321,18 +1316,18 @@ char *socket_address_to_string(struct SocketAddressLegacy *addr, Error **errp)
         }
         break;
 
-    case SOCKET_ADDRESS_LEGACY_KIND_UNIX:
-        buf = g_strdup(addr->u.q_unix.data->path);
+    case SOCKET_ADDRESS_TYPE_UNIX:
+        buf = g_strdup(addr->u.q_unix.path);
         break;
 
-    case SOCKET_ADDRESS_LEGACY_KIND_FD:
-        buf = g_strdup(addr->u.fd.data->str);
+    case SOCKET_ADDRESS_TYPE_FD:
+        buf = g_strdup(addr->u.fd.str);
         break;
 
-    case SOCKET_ADDRESS_LEGACY_KIND_VSOCK:
+    case SOCKET_ADDRESS_TYPE_VSOCK:
         buf = g_strdup_printf("%s:%s",
-                              addr->u.vsock.data->cid,
-                              addr->u.vsock.data->port);
+                              addr->u.vsock.cid,
+                              addr->u.vsock.port);
         break;
 
     default:
@@ -1371,3 +1366,34 @@ SocketAddressLegacy *socket_address_crumple(SocketAddress *addr_flat)
 
     return addr;
 }
+
+SocketAddress *socket_address_flatten(SocketAddressLegacy *addr_legacy)
+{
+    SocketAddress *addr = g_new(SocketAddress, 1);
+
+    switch (addr_legacy->type) {
+    case SOCKET_ADDRESS_LEGACY_KIND_INET:
+        addr->type = SOCKET_ADDRESS_TYPE_INET;
+        QAPI_CLONE_MEMBERS(InetSocketAddress, &addr->u.inet,
+                           addr_legacy->u.inet.data);
+        break;
+    case SOCKET_ADDRESS_LEGACY_KIND_UNIX:
+        addr->type = SOCKET_ADDRESS_TYPE_UNIX;
+        QAPI_CLONE_MEMBERS(UnixSocketAddress, &addr->u.q_unix,
+                           addr_legacy->u.q_unix.data);
+        break;
+    case SOCKET_ADDRESS_LEGACY_KIND_VSOCK:
+        addr->type = SOCKET_ADDRESS_TYPE_VSOCK;
+        QAPI_CLONE_MEMBERS(VsockSocketAddress, &addr->u.vsock,
+                           addr_legacy->u.vsock.data);
+        break;
+    case SOCKET_ADDRESS_LEGACY_KIND_FD:
+        addr->type = SOCKET_ADDRESS_TYPE_FD;
+        QAPI_CLONE_MEMBERS(String, &addr->u.fd, addr_legacy->u.fd.data);
+        break;
+    default:
+        abort();
+    }
+
+    return addr;
+}
-- 
2.7.4
