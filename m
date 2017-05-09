Received: from eggs.gnu.org ([2001:4830:134:3::10]:44287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d80Ah-0008CO-T2
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d80AW-0007aT-PS
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:07:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d80AW-0007ZY-9p
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:06:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 59042ED249
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 08:06:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-149.ams2.redhat.com
	[10.36.116.149])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BD2D5C7A4
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 08:06:50 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  9 May 2017 10:06:33 +0200
Message-Id: <1494317205-2211-17-git-send-email-armbru@redhat.com>
In-Reply-To: <1494317205-2211-1-git-send-email-armbru@redhat.com>
References: <1494317205-2211-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v3 16/28] sockets: Rename SocketAddress to
 SocketAddressLegacy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The next commit will rename SocketAddressFlat to SocketAddress, and
the commit after that will replace most uses of SocketAddressLegacy by
SocketAddress, replacing most of this commit's renames right back.

Note that checkpatch emits a few "line over 80 characters" warnings.
The long lines are all temporary; the SocketAddressLegacy replacement
will shorten them again.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1493192202-3184-5-git-send-email-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/nbd.c                    |   4 +-
 block/sheepdog.c               |  18 +++----
 blockdev-nbd.c                 |   6 +--
 chardev/char-socket.c          |  34 +++++++-------
 chardev/char-udp.c             |  10 ++--
 hmp.c                          |   4 +-
 include/io/channel-socket.h    |  24 +++++-----
 include/io/dns-resolver.h      |  22 ++++-----
 include/io/task.h              |  10 ++--
 include/qemu/sockets.h         |  30 ++++++------
 io/channel-socket.c            |  48 +++++++++----------
 io/dns-resolver.c              |  48 +++++++++----------
 migration/socket.c             |  36 +++++++-------
 net/socket.c                   |  10 ++--
 qapi-schema.json               |  14 +++---
 qapi/block.json                |   2 +-
 qemu-nbd.c                     |  12 ++---
 qga/channel-posix.c            |   4 +-
 qga/main.c                     |   8 ++--
 tests/test-io-channel-socket.c |  72 ++++++++++++++--------------
 ui/vnc-auth-sasl.c             |   6 +--
 ui/vnc.c                       | 104 ++++++++++++++++++++---------------------
 util/qemu-sockets.c            | 100 +++++++++++++++++++--------------------
 23 files changed, 314 insertions(+), 312 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 37969eb..7f11a93 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -309,7 +309,7 @@ NBDClientSession *nbd_get_client_session(BlockDriverState *bs)
 static QIOChannelSocket *nbd_establish_connection(SocketAddressFlat *saddr_flat,
                                                   Error **errp)
 {
-    SocketAddress *saddr = socket_address_crumple(saddr_flat);
+    SocketAddressLegacy *saddr = socket_address_crumple(saddr_flat);
     QIOChannelSocket *sioc;
     Error *local_err = NULL;
 
@@ -319,7 +319,7 @@ static QIOChannelSocket *nbd_establish_connection(SocketAddressFlat *saddr_flat,
     qio_channel_socket_connect_sync(sioc,
                                     saddr,
                                     &local_err);
-    qapi_free_SocketAddress(saddr);
+    qapi_free_SocketAddressLegacy(saddr);
     if (local_err) {
         object_unref(OBJECT(sioc));
         error_propagate(errp, local_err);
diff --git a/block/sheepdog.c b/block/sheepdog.c
index fe8fd92..055d10b 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -378,7 +378,7 @@ struct BDRVSheepdogState {
     uint32_t cache_flags;
     bool discard_supported;
 
-    SocketAddress *addr;
+    SocketAddressLegacy *addr;
     int fd;
 
     CoMutex lock;
@@ -530,17 +530,17 @@ static void sd_aio_setup(SheepdogAIOCB *acb, BDRVSheepdogState *s,
     QLIST_INSERT_HEAD(&s->inflight_aiocb_head, acb, aiocb_siblings);
 }
 
-static SocketAddress *sd_socket_address(const char *path,
+static SocketAddressLegacy *sd_socket_address(const char *path,
                                         const char *host, const char *port)
 {
-    SocketAddress *addr = g_new0(SocketAddress, 1);
+    SocketAddressLegacy *addr = g_new0(SocketAddressLegacy, 1);
 
     if (path) {
-        addr->type = SOCKET_ADDRESS_KIND_UNIX;
+        addr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
         addr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
         addr->u.q_unix.data->path = g_strdup(path);
     } else {
-        addr->type = SOCKET_ADDRESS_KIND_INET;
+        addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
         addr->u.inet.data = g_new0(InetSocketAddress, 1);
         addr->u.inet.data->host = g_strdup(host ?: SD_DEFAULT_ADDR);
         addr->u.inet.data->port = g_strdup(port ?: stringify(SD_DEFAULT_PORT));
@@ -549,13 +549,13 @@ static SocketAddress *sd_socket_address(const char *path,
     return addr;
 }
 
-static SocketAddress *sd_server_config(QDict *options, Error **errp)
+static SocketAddressLegacy *sd_server_config(QDict *options, Error **errp)
 {
     QDict *server = NULL;
     QObject *crumpled_server = NULL;
     Visitor *iv = NULL;
     SocketAddressFlat *saddr_flat = NULL;
-    SocketAddress *saddr = NULL;
+    SocketAddressLegacy *saddr = NULL;
     Error *local_err = NULL;
 
     qdict_extract_subqdict(options, &server, "server.");
@@ -597,7 +597,7 @@ static int connect_to_sdog(BDRVSheepdogState *s, Error **errp)
 
     fd = socket_connect(s->addr, NULL, NULL, errp);
 
-    if (s->addr->type == SOCKET_ADDRESS_KIND_INET && fd >= 0) {
+    if (s->addr->type == SOCKET_ADDRESS_LEGACY_KIND_INET && fd >= 0) {
         int ret = socket_set_nodelay(fd);
         if (ret < 0) {
             error_report("%s", strerror(errno));
@@ -2149,7 +2149,7 @@ static void sd_close(BlockDriverState *bs)
     aio_set_fd_handler(bdrv_get_aio_context(bs), s->fd,
                        false, NULL, NULL, NULL, NULL);
     closesocket(s->fd);
-    qapi_free_SocketAddress(s->addr);
+    qapi_free_SocketAddressLegacy(s->addr);
 }
 
 static int64_t sd_getlength(BlockDriverState *bs)
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 8a11807..6b0c699 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -99,7 +99,7 @@ static QCryptoTLSCreds *nbd_get_tls_creds(const char *id, Error **errp)
 }
 
 
-void qmp_nbd_server_start(SocketAddress *addr,
+void qmp_nbd_server_start(SocketAddressLegacy *addr,
                           bool has_tls_creds, const char *tls_creds,
                           Error **errp)
 {
@@ -124,8 +124,8 @@ void qmp_nbd_server_start(SocketAddress *addr,
             goto error;
         }
 
-        /* TODO SOCKET_ADDRESS_KIND_FD where fd has AF_INET or AF_INET6 */
-        if (addr->type != SOCKET_ADDRESS_KIND_INET) {
+        /* TODO SOCKET_ADDRESS_LEGACY_KIND_FD where fd has AF_INET or AF_INET6 */
+        if (addr->type != SOCKET_ADDRESS_LEGACY_KIND_INET) {
             error_setg(errp, "TLS is only supported with IPv4/IPv6");
             goto error;
         }
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 9d5f062..f872f48 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -52,7 +52,7 @@ typedef struct {
     int *write_msgfds;
     size_t write_msgfds_num;
 
-    SocketAddress *addr;
+    SocketAddressLegacy *addr;
     bool is_listen;
     bool is_telnet;
     bool is_tn3270;
@@ -356,27 +356,27 @@ static void tcp_chr_free_connection(Chardev *chr)
     s->connected = 0;
 }
 
-static char *SocketAddress_to_str(const char *prefix, SocketAddress *addr,
+static char *SocketAddress_to_str(const char *prefix, SocketAddressLegacy *addr,
                                   bool is_listen, bool is_telnet)
 {
     switch (addr->type) {
-    case SOCKET_ADDRESS_KIND_INET:
+    case SOCKET_ADDRESS_LEGACY_KIND_INET:
         return g_strdup_printf("%s%s:%s:%s%s", prefix,
                                is_telnet ? "telnet" : "tcp",
                                addr->u.inet.data->host,
                                addr->u.inet.data->port,
                                is_listen ? ",server" : "");
         break;
-    case SOCKET_ADDRESS_KIND_UNIX:
+    case SOCKET_ADDRESS_LEGACY_KIND_UNIX:
         return g_strdup_printf("%sunix:%s%s", prefix,
                                addr->u.q_unix.data->path,
                                is_listen ? ",server" : "");
         break;
-    case SOCKET_ADDRESS_KIND_FD:
+    case SOCKET_ADDRESS_LEGACY_KIND_FD:
         return g_strdup_printf("%sfd:%s%s", prefix, addr->u.fd.data->str,
                                is_listen ? ",server" : "");
         break;
-    case SOCKET_ADDRESS_KIND_VSOCK:
+    case SOCKET_ADDRESS_LEGACY_KIND_VSOCK:
         return g_strdup_printf("%svsock:%s:%s", prefix,
                                addr->u.vsock.data->cid,
                                addr->u.vsock.data->port);
@@ -796,7 +796,7 @@ static void char_socket_finalize(Object *obj)
         g_source_remove(s->reconnect_timer);
         s->reconnect_timer = 0;
     }
-    qapi_free_SocketAddress(s->addr);
+    qapi_free_SocketAddressLegacy(s->addr);
     if (s->listen_tag) {
         g_source_remove(s->listen_tag);
         s->listen_tag = 0;
@@ -859,7 +859,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
     ChardevSocket *sock = backend->u.socket.data;
-    SocketAddress *addr = sock->addr;
+    SocketAddressLegacy *addr = sock->addr;
     bool do_nodelay     = sock->has_nodelay ? sock->nodelay : false;
     bool is_listen      = sock->has_server  ? sock->server  : true;
     bool is_telnet      = sock->has_telnet  ? sock->telnet  : false;
@@ -905,11 +905,11 @@ static void qmp_chardev_open_socket(Chardev *chr,
         }
     }
 
-    s->addr = QAPI_CLONE(SocketAddress, sock->addr);
+    s->addr = QAPI_CLONE(SocketAddressLegacy, sock->addr);
 
     qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_RECONNECTABLE);
     /* TODO SOCKET_ADDRESS_FD where fd has AF_UNIX */
-    if (addr->type == SOCKET_ADDRESS_KIND_UNIX) {
+    if (addr->type == SOCKET_ADDRESS_LEGACY_KIND_UNIX) {
         qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_FD_PASS);
     }
 
@@ -945,7 +945,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
                 goto error;
             }
 
-            qapi_free_SocketAddress(s->addr);
+            qapi_free_SocketAddressLegacy(s->addr);
             s->addr = socket_local_address(sioc->fd, errp);
             update_disconnected_filename(s);
 
@@ -985,7 +985,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
     const char *host = qemu_opt_get(opts, "host");
     const char *port = qemu_opt_get(opts, "port");
     const char *tls_creds = qemu_opt_get(opts, "tls-creds");
-    SocketAddress *addr;
+    SocketAddressLegacy *addr;
     ChardevSocket *sock;
 
     backend->type = CHARDEV_BACKEND_KIND_SOCKET;
@@ -1022,14 +1022,14 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
     sock->reconnect = reconnect;
     sock->tls_creds = g_strdup(tls_creds);
 
-    addr = g_new0(SocketAddress, 1);
+    addr = g_new0(SocketAddressLegacy, 1);
     if (path) {
         UnixSocketAddress *q_unix;
-        addr->type = SOCKET_ADDRESS_KIND_UNIX;
+        addr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
         q_unix = addr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
         q_unix->path = g_strdup(path);
     } else {
-        addr->type = SOCKET_ADDRESS_KIND_INET;
+        addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
         addr->u.inet.data = g_new(InetSocketAddress, 1);
         *addr->u.inet.data = (InetSocketAddress) {
             .host = g_strdup(host),
@@ -1051,7 +1051,7 @@ char_socket_get_addr(Object *obj, Visitor *v, const char *name,
 {
     SocketChardev *s = SOCKET_CHARDEV(obj);
 
-    visit_type_SocketAddress(v, name, &s->addr, errp);
+    visit_type_SocketAddressLegacy(v, name, &s->addr, errp);
 }
 
 static bool
@@ -1078,7 +1078,7 @@ static void char_socket_class_init(ObjectClass *oc, void *data)
     cc->chr_add_watch = tcp_chr_add_watch;
     cc->chr_update_read_handler = tcp_chr_update_read_handler;
 
-    object_class_property_add(oc, "addr", "SocketAddress",
+    object_class_property_add(oc, "addr", "SocketAddressLegacy",
                               char_socket_get_addr, NULL,
                               NULL, NULL, &error_abort);
 
diff --git a/chardev/char-udp.c b/chardev/char-udp.c
index 1958c36..d705c4f 100644
--- a/chardev/char-udp.c
+++ b/chardev/char-udp.c
@@ -134,7 +134,7 @@ static void qemu_chr_parse_udp(QemuOpts *opts, ChardevBackend *backend,
     const char *localaddr = qemu_opt_get(opts, "localaddr");
     const char *localport = qemu_opt_get(opts, "localport");
     bool has_local = false;
-    SocketAddress *addr;
+    SocketAddressLegacy *addr;
     ChardevUdp *udp;
 
     backend->type = CHARDEV_BACKEND_KIND_UDP;
@@ -159,8 +159,8 @@ static void qemu_chr_parse_udp(QemuOpts *opts, ChardevBackend *backend,
     udp = backend->u.udp.data = g_new0(ChardevUdp, 1);
     qemu_chr_parse_common(opts, qapi_ChardevUdp_base(udp));
 
-    addr = g_new0(SocketAddress, 1);
-    addr->type = SOCKET_ADDRESS_KIND_INET;
+    addr = g_new0(SocketAddressLegacy, 1);
+    addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
     addr->u.inet.data = g_new(InetSocketAddress, 1);
     *addr->u.inet.data = (InetSocketAddress) {
         .host = g_strdup(host),
@@ -174,8 +174,8 @@ static void qemu_chr_parse_udp(QemuOpts *opts, ChardevBackend *backend,
 
     if (has_local) {
         udp->has_local = true;
-        addr = g_new0(SocketAddress, 1);
-        addr->type = SOCKET_ADDRESS_KIND_INET;
+        addr = g_new0(SocketAddressLegacy, 1);
+        addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
         addr->u.inet.data = g_new(InetSocketAddress, 1);
         *addr->u.inet.data = (InetSocketAddress) {
             .host = g_strdup(localaddr),
diff --git a/hmp.c b/hmp.c
index bd7b1ca..c7f161d 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2108,7 +2108,7 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
     bool all = qdict_get_try_bool(qdict, "all", false);
     Error *local_err = NULL;
     BlockInfoList *block_list, *info;
-    SocketAddress *addr;
+    SocketAddressLegacy *addr;
 
     if (writable && !all) {
         error_setg(&local_err, "-w only valid together with -a");
@@ -2122,7 +2122,7 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
     }
 
     qmp_nbd_server_start(addr, false, NULL, &local_err);
-    qapi_free_SocketAddress(addr);
+    qapi_free_SocketAddressLegacy(addr);
     if (local_err != NULL) {
         goto exit;
     }
diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index 711f8bf..c1aaa72 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -91,7 +91,7 @@ qio_channel_socket_new_fd(int fd,
  * an error occurs.
  */
 int qio_channel_socket_connect_sync(QIOChannelSocket *ioc,
-                                    SocketAddress *addr,
+                                    SocketAddressLegacy *addr,
                                     Error **errp);
 
 /**
@@ -110,7 +110,7 @@ int qio_channel_socket_connect_sync(QIOChannelSocket *ioc,
  * as this function returns without waiting for completion.
  */
 void qio_channel_socket_connect_async(QIOChannelSocket *ioc,
-                                      SocketAddress *addr,
+                                      SocketAddressLegacy *addr,
                                       QIOTaskFunc callback,
                                       gpointer opaque,
                                       GDestroyNotify destroy);
@@ -128,7 +128,7 @@ void qio_channel_socket_connect_async(QIOChannelSocket *ioc,
  * an error occurs.
  */
 int qio_channel_socket_listen_sync(QIOChannelSocket *ioc,
-                                   SocketAddress *addr,
+                                   SocketAddressLegacy *addr,
                                    Error **errp);
 
 /**
@@ -147,7 +147,7 @@ int qio_channel_socket_listen_sync(QIOChannelSocket *ioc,
  * as this function returns without waiting for completion.
  */
 void qio_channel_socket_listen_async(QIOChannelSocket *ioc,
-                                     SocketAddress *addr,
+                                     SocketAddressLegacy *addr,
                                      QIOTaskFunc callback,
                                      gpointer opaque,
                                      GDestroyNotify destroy);
@@ -167,8 +167,8 @@ void qio_channel_socket_listen_async(QIOChannelSocket *ioc,
  * is established or an error occurs.
  */
 int qio_channel_socket_dgram_sync(QIOChannelSocket *ioc,
-                                  SocketAddress *localAddr,
-                                  SocketAddress *remoteAddr,
+                                  SocketAddressLegacy *localAddr,
+                                  SocketAddressLegacy *remoteAddr,
                                   Error **errp);
 
 /**
@@ -190,8 +190,8 @@ int qio_channel_socket_dgram_sync(QIOChannelSocket *ioc,
  * waiting for completion.
  */
 void qio_channel_socket_dgram_async(QIOChannelSocket *ioc,
-                                    SocketAddress *localAddr,
-                                    SocketAddress *remoteAddr,
+                                    SocketAddressLegacy *localAddr,
+                                    SocketAddressLegacy *remoteAddr,
                                     QIOTaskFunc callback,
                                     gpointer opaque,
                                     GDestroyNotify destroy);
@@ -205,12 +205,12 @@ void qio_channel_socket_dgram_async(QIOChannelSocket *ioc,
  * Get the string representation of the local socket
  * address. A pointer to the allocated address information
  * struct will be returned, which the caller is required to
- * release with a call qapi_free_SocketAddress when no
+ * release with a call qapi_free_SocketAddressLegacy() when no
  * longer required.
  *
  * Returns: 0 on success, -1 on error
  */
-SocketAddress *
+SocketAddressLegacy *
 qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
                                      Error **errp);
 
@@ -222,12 +222,12 @@ qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
  * Get the string representation of the local socket
  * address. A pointer to the allocated address information
  * struct will be returned, which the caller is required to
- * release with a call qapi_free_SocketAddress when no
+ * release with a call qapi_free_SocketAddressLegacy() when no
  * longer required.
  *
  * Returns: the socket address struct, or NULL on error
  */
-SocketAddress *
+SocketAddressLegacy *
 qio_channel_socket_get_remote_address(QIOChannelSocket *ioc,
                                       Error **errp);
 
diff --git a/include/io/dns-resolver.h b/include/io/dns-resolver.h
index 2f69c08..aac46ca 100644
--- a/include/io/dns-resolver.h
+++ b/include/io/dns-resolver.h
@@ -40,15 +40,15 @@ typedef struct QIODNSResolverClass QIODNSResolverClass;
  * QIODNSResolver:
  *
  * The QIODNSResolver class provides a framework for doing
- * DNS resolution on SocketAddress objects, independently
+ * DNS resolution on SocketAddressLegacy objects, independently
  * of socket creation.
  *
  * <example>
  *   <title>Resolving addresses synchronously</title>
  *   <programlisting>
- *    int mylisten(SocketAddress *addr, Error **errp) {
+ *    int mylisten(SocketAddressLegacy *addr, Error **errp) {
  *      QIODNSResolver *resolver = qio_dns_resolver_get_instance();
- *      SocketAddress **rawaddrs = NULL;
+ *      SocketAddressLegacy **rawaddrs = NULL;
  *      size_t nrawaddrs = 0;
  *      Error *err = NULL;
  *      QIOChannel **socks = NULL;
@@ -69,7 +69,7 @@ typedef struct QIODNSResolverClass QIODNSResolverClass;
  *            socks = g_renew(QIOChannelSocket *, socks, nsocks + 1);
  *            socks[nsocks++] = sock;
  *         }
- *         qapi_free_SocketAddress(rawaddrs[i]);
+ *         qapi_free_SocketAddressLegacy(rawaddrs[i]);
  *      }
  *      g_free(rawaddrs);
  *
@@ -95,7 +95,7 @@ typedef struct QIODNSResolverClass QIODNSResolverClass;
  *      MyListenData *data = opaque;
  *      QIODNSResolver *resolver =
  *         QIO_DNS_RESOLVER(qio_task_get_source(task);
- *      SocketAddress **rawaddrs = NULL;
+ *      SocketAddressLegacy **rawaddrs = NULL;
  *      size_t nrawaddrs = 0;
  *      Error *err = NULL;
  *
@@ -116,7 +116,7 @@ typedef struct QIODNSResolverClass QIODNSResolverClass;
  *            socks = g_renew(QIOChannelSocket *, socks, nsocks + 1);
  *            socks[nsocks++] = sock;
  *         }
- *         qapi_free_SocketAddress(rawaddrs[i]);
+ *         qapi_free_SocketAddressLegacy(rawaddrs[i]);
  *      }
  *      g_free(rawaddrs);
  *
@@ -127,7 +127,7 @@ typedef struct QIODNSResolverClass QIODNSResolverClass;
  *      }
  *    }
  *
- *    void mylisten(SocketAddress *addr, MyListenData *data) {
+ *    void mylisten(SocketAddressLegacy *addr, MyListenData *data) {
  *      QIODNSResolver *resolver = qio_dns_resolver_get_instance();
  *      qio_dns_resolver_lookup_async(dns, addr,
  *                                    mylistenresult, data, NULL);
@@ -177,9 +177,9 @@ QIODNSResolver *qio_dns_resolver_get_instance(void);
  * Returns: 0 if resolution was successful, -1 on error
  */
 int qio_dns_resolver_lookup_sync(QIODNSResolver *resolver,
-                                 SocketAddress *addr,
+                                 SocketAddressLegacy *addr,
                                  size_t *naddrs,
-                                 SocketAddress ***addrs,
+                                 SocketAddressLegacy ***addrs,
                                  Error **errp);
 
 /**
@@ -201,7 +201,7 @@ int qio_dns_resolver_lookup_sync(QIODNSResolver *resolver,
  * of the caller will not be blocked.
  */
 void qio_dns_resolver_lookup_async(QIODNSResolver *resolver,
-                                   SocketAddress *addr,
+                                   SocketAddressLegacy *addr,
                                    QIOTaskFunc func,
                                    gpointer opaque,
                                    GDestroyNotify notify);
@@ -223,6 +223,6 @@ void qio_dns_resolver_lookup_async(QIODNSResolver *resolver,
 void qio_dns_resolver_lookup_result(QIODNSResolver *resolver,
                                     QIOTask *task,
                                     size_t *naddrs,
-                                    SocketAddress ***addrs);
+                                    SocketAddressLegacy ***addrs);
 
 #endif /* QIO_DNS_RESOLVER_H */
diff --git a/include/io/task.h b/include/io/task.h
index 6021f51..f65ec7a 100644
--- a/include/io/task.h
+++ b/include/io/task.h
@@ -166,7 +166,7 @@ typedef void (*QIOTaskWorker)(QIOTask *task,
  *                                       gpointer opaque)
  *    {
  *       QMyObject obj = QMY_OBJECT(qio_task_get_source(task));
- *       SocketAddress *addr = opaque;
+ *       SocketAddressLegacy *addr = opaque;
  *       Error *err = NULL;
  *
  *       obj->fd = socket_listen(addr, &err);
@@ -175,20 +175,20 @@ typedef void (*QIOTaskWorker)(QIOTask *task,
  *    }
  *
  *    void myobject_listen_async(QMyObject *obj,
- *                               SocketAddress *addr,
+ *                               SocketAddressLegacy *addr,
  *                               QIOTaskFunc *func,
  *                               gpointer opaque,
  *                               GDestroyNotify notify)
  *    {
  *      QIOTask *task;
- *      SocketAddress *addrCopy;
+ *      SocketAddressLegacy *addrCopy;
  *
- *      addrCopy = QAPI_CLONE(SocketAddress, addr);
+ *      addrCopy = QAPI_CLONE(SocketAddressLegacy, addr);
  *      task = qio_task_new(OBJECT(obj), func, opaque, notify);
  *
  *      qio_task_run_in_thread(task, myobject_listen_worker,
  *                             addrCopy,
- *                             qapi_free_SocketAddress);
+ *                             qapi_free_SocketAddressLegacy);
  *    }
  * </example>
  *
diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index 8b9325c..f4a4b10 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -45,12 +45,12 @@ NetworkAddressFamily inet_netfamily(int family);
 int unix_listen(const char *path, char *ostr, int olen, Error **errp);
 int unix_connect(const char *path, Error **errp);
 
-SocketAddress *socket_parse(const char *str, Error **errp);
-int socket_connect(SocketAddress *addr, NonBlockingConnectHandler *callback,
+SocketAddressLegacy *socket_parse(const char *str, Error **errp);
+int socket_connect(SocketAddressLegacy *addr, NonBlockingConnectHandler *callback,
                    void *opaque, Error **errp);
-int socket_listen(SocketAddress *addr, Error **errp);
+int socket_listen(SocketAddressLegacy *addr, Error **errp);
 void socket_listen_cleanup(int fd, Error **errp);
-int socket_dgram(SocketAddress *remote, SocketAddress *local, Error **errp);
+int socket_dgram(SocketAddressLegacy *remote, SocketAddressLegacy *local, Error **errp);
 
 /* Old, ipv4 only bits.  Don't use for new code. */
 int parse_host_port(struct sockaddr_in *saddr, const char *str);
@@ -65,12 +65,12 @@ int socket_init(void);
  * Get the string representation of the socket
  * address. A pointer to the allocated address information
  * struct will be returned, which the caller is required to
- * release with a call qapi_free_SocketAddress when no
+ * release with a call qapi_free_SocketAddressLegacy() when no
  * longer required.
  *
  * Returns: the socket address struct, or NULL on error
  */
-SocketAddress *
+SocketAddressLegacy *
 socket_sockaddr_to_address(struct sockaddr_storage *sa,
                            socklen_t salen,
                            Error **errp);
@@ -83,12 +83,12 @@ socket_sockaddr_to_address(struct sockaddr_storage *sa,
  * Get the string representation of the local socket
  * address. A pointer to the allocated address information
  * struct will be returned, which the caller is required to
- * release with a call qapi_free_SocketAddress when no
+ * release with a call qapi_free_SocketAddressLegacy() when no
  * longer required.
  *
  * Returns: the socket address struct, or NULL on error
  */
-SocketAddress *socket_local_address(int fd, Error **errp);
+SocketAddressLegacy *socket_local_address(int fd, Error **errp);
 
 /**
  * socket_remote_address:
@@ -98,12 +98,12 @@ SocketAddress *socket_local_address(int fd, Error **errp);
  * Get the string representation of the remote socket
  * address. A pointer to the allocated address information
  * struct will be returned, which the caller is required to
- * release with a call qapi_free_SocketAddress when no
+ * release with a call qapi_free_SocketAddressLegacy() when no
  * longer required.
  *
  * Returns: the socket address struct, or NULL on error
  */
-SocketAddress *socket_remote_address(int fd, Error **errp);
+SocketAddressLegacy *socket_remote_address(int fd, Error **errp);
 
 /**
  * socket_address_to_string:
@@ -118,17 +118,17 @@ SocketAddress *socket_remote_address(int fd, Error **errp);
  *
  * Returns: the socket address in string format, or NULL on error
  */
-char *socket_address_to_string(struct SocketAddress *addr, Error **errp);
+char *socket_address_to_string(struct SocketAddressLegacy *addr, Error **errp);
 
 /**
  * socket_address_crumple:
  * @addr_flat: the socket address to crumple
  *
- * Convert SocketAddressFlat to SocketAddress.  Caller is responsible
- * for freeing with qapi_free_SocketAddress().
+ * Convert SocketAddressFlat to SocketAddressLegacy.  Caller is responsible
+ * for freeing with qapi_free_SocketAddressLegacy().
  *
- * Returns: the argument converted to SocketAddress.
+ * Returns: the argument converted to SocketAddressLegacy.
  */
-SocketAddress *socket_address_crumple(SocketAddressFlat *addr_flat);
+SocketAddressLegacy *socket_address_crumple(SocketAddressFlat *addr_flat);
 
 #endif /* QEMU_SOCKETS_H */
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 53386b7..a21dab6 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -27,7 +27,7 @@
 
 #define SOCKET_MAX_FDS 16
 
-SocketAddress *
+SocketAddressLegacy *
 qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
                                      Error **errp)
 {
@@ -36,7 +36,7 @@ qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
                                       errp);
 }
 
-SocketAddress *
+SocketAddressLegacy *
 qio_channel_socket_get_remote_address(QIOChannelSocket *ioc,
                                       Error **errp)
 {
@@ -134,7 +134,7 @@ qio_channel_socket_new_fd(int fd,
 
 
 int qio_channel_socket_connect_sync(QIOChannelSocket *ioc,
-                                    SocketAddress *addr,
+                                    SocketAddressLegacy *addr,
                                     Error **errp)
 {
     int fd;
@@ -160,7 +160,7 @@ static void qio_channel_socket_connect_worker(QIOTask *task,
                                               gpointer opaque)
 {
     QIOChannelSocket *ioc = QIO_CHANNEL_SOCKET(qio_task_get_source(task));
-    SocketAddress *addr = opaque;
+    SocketAddressLegacy *addr = opaque;
     Error *err = NULL;
 
     qio_channel_socket_connect_sync(ioc, addr, &err);
@@ -170,16 +170,16 @@ static void qio_channel_socket_connect_worker(QIOTask *task,
 
 
 void qio_channel_socket_connect_async(QIOChannelSocket *ioc,
-                                      SocketAddress *addr,
+                                      SocketAddressLegacy *addr,
                                       QIOTaskFunc callback,
                                       gpointer opaque,
                                       GDestroyNotify destroy)
 {
     QIOTask *task = qio_task_new(
         OBJECT(ioc), callback, opaque, destroy);
-    SocketAddress *addrCopy;
+    SocketAddressLegacy *addrCopy;
 
-    addrCopy = QAPI_CLONE(SocketAddress, addr);
+    addrCopy = QAPI_CLONE(SocketAddressLegacy, addr);
 
     /* socket_connect() does a non-blocking connect(), but it
      * still blocks in DNS lookups, so we must use a thread */
@@ -187,12 +187,12 @@ void qio_channel_socket_connect_async(QIOChannelSocket *ioc,
     qio_task_run_in_thread(task,
                            qio_channel_socket_connect_worker,
                            addrCopy,
-                           (GDestroyNotify)qapi_free_SocketAddress);
+                           (GDestroyNotify)qapi_free_SocketAddressLegacy);
 }
 
 
 int qio_channel_socket_listen_sync(QIOChannelSocket *ioc,
-                                   SocketAddress *addr,
+                                   SocketAddressLegacy *addr,
                                    Error **errp)
 {
     int fd;
@@ -219,7 +219,7 @@ static void qio_channel_socket_listen_worker(QIOTask *task,
                                              gpointer opaque)
 {
     QIOChannelSocket *ioc = QIO_CHANNEL_SOCKET(qio_task_get_source(task));
-    SocketAddress *addr = opaque;
+    SocketAddressLegacy *addr = opaque;
     Error *err = NULL;
 
     qio_channel_socket_listen_sync(ioc, addr, &err);
@@ -229,29 +229,29 @@ static void qio_channel_socket_listen_worker(QIOTask *task,
 
 
 void qio_channel_socket_listen_async(QIOChannelSocket *ioc,
-                                     SocketAddress *addr,
+                                     SocketAddressLegacy *addr,
                                      QIOTaskFunc callback,
                                      gpointer opaque,
                                      GDestroyNotify destroy)
 {
     QIOTask *task = qio_task_new(
         OBJECT(ioc), callback, opaque, destroy);
-    SocketAddress *addrCopy;
+    SocketAddressLegacy *addrCopy;
 
-    addrCopy = QAPI_CLONE(SocketAddress, addr);
+    addrCopy = QAPI_CLONE(SocketAddressLegacy, addr);
 
     /* socket_listen() blocks in DNS lookups, so we must use a thread */
     trace_qio_channel_socket_listen_async(ioc, addr);
     qio_task_run_in_thread(task,
                            qio_channel_socket_listen_worker,
                            addrCopy,
-                           (GDestroyNotify)qapi_free_SocketAddress);
+                           (GDestroyNotify)qapi_free_SocketAddressLegacy);
 }
 
 
 int qio_channel_socket_dgram_sync(QIOChannelSocket *ioc,
-                                  SocketAddress *localAddr,
-                                  SocketAddress *remoteAddr,
+                                  SocketAddressLegacy *localAddr,
+                                  SocketAddressLegacy *remoteAddr,
                                   Error **errp)
 {
     int fd;
@@ -274,16 +274,16 @@ int qio_channel_socket_dgram_sync(QIOChannelSocket *ioc,
 
 
 struct QIOChannelSocketDGramWorkerData {
-    SocketAddress *localAddr;
-    SocketAddress *remoteAddr;
+    SocketAddressLegacy *localAddr;
+    SocketAddressLegacy *remoteAddr;
 };
 
 
 static void qio_channel_socket_dgram_worker_free(gpointer opaque)
 {
     struct QIOChannelSocketDGramWorkerData *data = opaque;
-    qapi_free_SocketAddress(data->localAddr);
-    qapi_free_SocketAddress(data->remoteAddr);
+    qapi_free_SocketAddressLegacy(data->localAddr);
+    qapi_free_SocketAddressLegacy(data->remoteAddr);
     g_free(data);
 }
 
@@ -303,8 +303,8 @@ static void qio_channel_socket_dgram_worker(QIOTask *task,
 
 
 void qio_channel_socket_dgram_async(QIOChannelSocket *ioc,
-                                    SocketAddress *localAddr,
-                                    SocketAddress *remoteAddr,
+                                    SocketAddressLegacy *localAddr,
+                                    SocketAddressLegacy *remoteAddr,
                                     QIOTaskFunc callback,
                                     gpointer opaque,
                                     GDestroyNotify destroy)
@@ -314,8 +314,8 @@ void qio_channel_socket_dgram_async(QIOChannelSocket *ioc,
     struct QIOChannelSocketDGramWorkerData *data = g_new0(
         struct QIOChannelSocketDGramWorkerData, 1);
 
-    data->localAddr = QAPI_CLONE(SocketAddress, localAddr);
-    data->remoteAddr = QAPI_CLONE(SocketAddress, remoteAddr);
+    data->localAddr = QAPI_CLONE(SocketAddressLegacy, localAddr);
+    data->remoteAddr = QAPI_CLONE(SocketAddressLegacy, remoteAddr);
 
     trace_qio_channel_socket_dgram_async(ioc, localAddr, remoteAddr);
     qio_task_run_in_thread(task,
diff --git a/io/dns-resolver.c b/io/dns-resolver.c
index 759d1b4..d3f0cbf 100644
--- a/io/dns-resolver.c
+++ b/io/dns-resolver.c
@@ -45,9 +45,9 @@ QIODNSResolver *qio_dns_resolver_get_instance(void)
 }
 
 static int qio_dns_resolver_lookup_sync_inet(QIODNSResolver *resolver,
-                                             SocketAddress *addr,
+                                             SocketAddressLegacy *addr,
                                              size_t *naddrs,
-                                             SocketAddress ***addrs,
+                                             SocketAddressLegacy ***addrs,
                                              Error **errp)
 {
     struct addrinfo ai, *res, *e;
@@ -97,14 +97,14 @@ static int qio_dns_resolver_lookup_sync_inet(QIODNSResolver *resolver,
         (*naddrs)++;
     }
 
-    *addrs = g_new0(SocketAddress *, *naddrs);
+    *addrs = g_new0(SocketAddressLegacy *, *naddrs);
 
     /* create socket + bind */
     for (i = 0, e = res; e != NULL; i++, e = e->ai_next) {
-        SocketAddress *newaddr = g_new0(SocketAddress, 1);
+        SocketAddressLegacy *newaddr = g_new0(SocketAddressLegacy, 1);
         InetSocketAddress *newiaddr = g_new0(InetSocketAddress, 1);
         newaddr->u.inet.data = newiaddr;
-        newaddr->type = SOCKET_ADDRESS_KIND_INET;
+        newaddr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
 
         getnameinfo((struct sockaddr *)e->ai_addr, e->ai_addrlen,
                     uaddr, INET6_ADDRSTRLEN, uport, 32,
@@ -129,36 +129,36 @@ static int qio_dns_resolver_lookup_sync_inet(QIODNSResolver *resolver,
 
 
 static int qio_dns_resolver_lookup_sync_nop(QIODNSResolver *resolver,
-                                            SocketAddress *addr,
+                                            SocketAddressLegacy *addr,
                                             size_t *naddrs,
-                                            SocketAddress ***addrs,
+                                            SocketAddressLegacy ***addrs,
                                             Error **errp)
 {
     *naddrs = 1;
-    *addrs = g_new0(SocketAddress *, 1);
-    (*addrs)[0] = QAPI_CLONE(SocketAddress, addr);
+    *addrs = g_new0(SocketAddressLegacy *, 1);
+    (*addrs)[0] = QAPI_CLONE(SocketAddressLegacy, addr);
 
     return 0;
 }
 
 
 int qio_dns_resolver_lookup_sync(QIODNSResolver *resolver,
-                                 SocketAddress *addr,
+                                 SocketAddressLegacy *addr,
                                  size_t *naddrs,
-                                 SocketAddress ***addrs,
+                                 SocketAddressLegacy ***addrs,
                                  Error **errp)
 {
     switch (addr->type) {
-    case SOCKET_ADDRESS_KIND_INET:
+    case SOCKET_ADDRESS_LEGACY_KIND_INET:
         return qio_dns_resolver_lookup_sync_inet(resolver,
                                                  addr,
                                                  naddrs,
                                                  addrs,
                                                  errp);
 
-    case SOCKET_ADDRESS_KIND_UNIX:
-    case SOCKET_ADDRESS_KIND_VSOCK:
-    case SOCKET_ADDRESS_KIND_FD:
+    case SOCKET_ADDRESS_LEGACY_KIND_UNIX:
+    case SOCKET_ADDRESS_LEGACY_KIND_VSOCK:
+    case SOCKET_ADDRESS_LEGACY_KIND_FD:
         return qio_dns_resolver_lookup_sync_nop(resolver,
                                                 addr,
                                                 naddrs,
@@ -172,8 +172,8 @@ int qio_dns_resolver_lookup_sync(QIODNSResolver *resolver,
 
 
 struct QIODNSResolverLookupData {
-    SocketAddress *addr;
-    SocketAddress **addrs;
+    SocketAddressLegacy *addr;
+    SocketAddressLegacy **addrs;
     size_t naddrs;
 };
 
@@ -183,9 +183,9 @@ static void qio_dns_resolver_lookup_data_free(gpointer opaque)
     struct QIODNSResolverLookupData *data = opaque;
     size_t i;
 
-    qapi_free_SocketAddress(data->addr);
+    qapi_free_SocketAddressLegacy(data->addr);
     for (i = 0; i < data->naddrs; i++) {
-        qapi_free_SocketAddress(data->addrs[i]);
+        qapi_free_SocketAddressLegacy(data->addrs[i]);
     }
 
     g_free(data->addrs);
@@ -216,7 +216,7 @@ static void qio_dns_resolver_lookup_worker(QIOTask *task,
 
 
 void qio_dns_resolver_lookup_async(QIODNSResolver *resolver,
-                                   SocketAddress *addr,
+                                   SocketAddressLegacy *addr,
                                    QIOTaskFunc func,
                                    gpointer opaque,
                                    GDestroyNotify notify)
@@ -225,7 +225,7 @@ void qio_dns_resolver_lookup_async(QIODNSResolver *resolver,
     struct QIODNSResolverLookupData *data =
         g_new0(struct QIODNSResolverLookupData, 1);
 
-    data->addr = QAPI_CLONE(SocketAddress, addr);
+    data->addr = QAPI_CLONE(SocketAddressLegacy, addr);
 
     task = qio_task_new(OBJECT(resolver), func, opaque, notify);
 
@@ -239,7 +239,7 @@ void qio_dns_resolver_lookup_async(QIODNSResolver *resolver,
 void qio_dns_resolver_lookup_result(QIODNSResolver *resolver,
                                     QIOTask *task,
                                     size_t *naddrs,
-                                    SocketAddress ***addrs)
+                                    SocketAddressLegacy ***addrs)
 {
     struct QIODNSResolverLookupData *data =
         qio_task_get_result_pointer(task);
@@ -252,9 +252,9 @@ void qio_dns_resolver_lookup_result(QIODNSResolver *resolver,
     }
 
     *naddrs = data->naddrs;
-    *addrs = g_new0(SocketAddress *, data->naddrs);
+    *addrs = g_new0(SocketAddressLegacy *, data->naddrs);
     for (i = 0; i < data->naddrs; i++) {
-        (*addrs)[i] = QAPI_CLONE(SocketAddress, data->addrs[i]);
+        (*addrs)[i] = QAPI_CLONE(SocketAddressLegacy, data->addrs[i]);
     }
 }
 
diff --git a/migration/socket.c b/migration/socket.c
index 5fdc723..3203276 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -25,30 +25,30 @@
 #include "trace.h"
 
 
-static SocketAddress *tcp_build_address(const char *host_port, Error **errp)
+static SocketAddressLegacy *tcp_build_address(const char *host_port, Error **errp)
 {
     InetSocketAddress *iaddr = g_new(InetSocketAddress, 1);
-    SocketAddress *saddr;
+    SocketAddressLegacy *saddr;
 
     if (inet_parse(iaddr, host_port, errp)) {
         qapi_free_InetSocketAddress(iaddr);
         return NULL;
     }
 
-    saddr = g_new0(SocketAddress, 1);
-    saddr->type = SOCKET_ADDRESS_KIND_INET;
+    saddr = g_new0(SocketAddressLegacy, 1);
+    saddr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
     saddr->u.inet.data = iaddr;
 
     return saddr;
 }
 
 
-static SocketAddress *unix_build_address(const char *path)
+static SocketAddressLegacy *unix_build_address(const char *path)
 {
-    SocketAddress *saddr;
+    SocketAddressLegacy *saddr;
 
-    saddr = g_new0(SocketAddress, 1);
-    saddr->type = SOCKET_ADDRESS_KIND_UNIX;
+    saddr = g_new0(SocketAddressLegacy, 1);
+    saddr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
     saddr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
     saddr->u.q_unix.data->path = g_strdup(path);
 
@@ -90,14 +90,14 @@ static void socket_outgoing_migration(QIOTask *task,
 }
 
 static void socket_start_outgoing_migration(MigrationState *s,
-                                            SocketAddress *saddr,
+                                            SocketAddressLegacy *saddr,
                                             Error **errp)
 {
     QIOChannelSocket *sioc = qio_channel_socket_new();
     struct SocketConnectData *data = g_new0(struct SocketConnectData, 1);
 
     data->s = s;
-    if (saddr->type == SOCKET_ADDRESS_KIND_INET) {
+    if (saddr->type == SOCKET_ADDRESS_LEGACY_KIND_INET) {
         data->hostname = g_strdup(saddr->u.inet.data->host);
     }
 
@@ -107,7 +107,7 @@ static void socket_start_outgoing_migration(MigrationState *s,
                                      socket_outgoing_migration,
                                      data,
                                      socket_connect_data_free);
-    qapi_free_SocketAddress(saddr);
+    qapi_free_SocketAddressLegacy(saddr);
 }
 
 void tcp_start_outgoing_migration(MigrationState *s,
@@ -115,7 +115,7 @@ void tcp_start_outgoing_migration(MigrationState *s,
                                   Error **errp)
 {
     Error *err = NULL;
-    SocketAddress *saddr = tcp_build_address(host_port, &err);
+    SocketAddressLegacy *saddr = tcp_build_address(host_port, &err);
     if (!err) {
         socket_start_outgoing_migration(s, saddr, &err);
     }
@@ -126,7 +126,7 @@ void unix_start_outgoing_migration(MigrationState *s,
                                    const char *path,
                                    Error **errp)
 {
-    SocketAddress *saddr = unix_build_address(path);
+    SocketAddressLegacy *saddr = unix_build_address(path);
     socket_start_outgoing_migration(s, saddr, errp);
 }
 
@@ -160,7 +160,7 @@ out:
 }
 
 
-static void socket_start_incoming_migration(SocketAddress *saddr,
+static void socket_start_incoming_migration(SocketAddressLegacy *saddr,
                                             Error **errp)
 {
     QIOChannelSocket *listen_ioc = qio_channel_socket_new();
@@ -170,7 +170,7 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
 
     if (qio_channel_socket_listen_sync(listen_ioc, saddr, errp) < 0) {
         object_unref(OBJECT(listen_ioc));
-        qapi_free_SocketAddress(saddr);
+        qapi_free_SocketAddressLegacy(saddr);
         return;
     }
 
@@ -179,13 +179,13 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
                           socket_accept_incoming_migration,
                           listen_ioc,
                           (GDestroyNotify)object_unref);
-    qapi_free_SocketAddress(saddr);
+    qapi_free_SocketAddressLegacy(saddr);
 }
 
 void tcp_start_incoming_migration(const char *host_port, Error **errp)
 {
     Error *err = NULL;
-    SocketAddress *saddr = tcp_build_address(host_port, &err);
+    SocketAddressLegacy *saddr = tcp_build_address(host_port, &err);
     if (!err) {
         socket_start_incoming_migration(saddr, &err);
     }
@@ -194,6 +194,6 @@ void tcp_start_incoming_migration(const char *host_port, Error **errp)
 
 void unix_start_incoming_migration(const char *path, Error **errp)
 {
-    SocketAddress *saddr = unix_build_address(path);
+    SocketAddressLegacy *saddr = unix_build_address(path);
     socket_start_incoming_migration(saddr, errp);
 }
diff --git a/net/socket.c b/net/socket.c
index b8c931e..ecd165f 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -489,7 +489,7 @@ static int net_socket_listen_init(NetClientState *peer,
 {
     NetClientState *nc;
     NetSocketState *s;
-    SocketAddress *saddr;
+    SocketAddressLegacy *saddr;
     int ret;
     Error *local_error = NULL;
 
@@ -501,7 +501,7 @@ static int net_socket_listen_init(NetClientState *peer,
 
     ret = socket_listen(saddr, &local_error);
     if (ret < 0) {
-        qapi_free_SocketAddress(saddr);
+        qapi_free_SocketAddressLegacy(saddr);
         error_report_err(local_error);
         return -1;
     }
@@ -514,20 +514,20 @@ static int net_socket_listen_init(NetClientState *peer,
     net_socket_rs_init(&s->rs, net_socket_rs_finalize);
 
     qemu_set_fd_handler(s->listen_fd, net_socket_accept, NULL, s);
-    qapi_free_SocketAddress(saddr);
+    qapi_free_SocketAddressLegacy(saddr);
     return 0;
 }
 
 typedef struct {
     NetClientState *peer;
-    SocketAddress *saddr;
+    SocketAddressLegacy *saddr;
     char *model;
     char *name;
 } socket_connect_data;
 
 static void socket_connect_data_free(socket_connect_data *c)
 {
-    qapi_free_SocketAddress(c->saddr);
+    qapi_free_SocketAddressLegacy(c->saddr);
     g_free(c->model);
     g_free(c->name);
     g_free(c);
diff --git a/qapi-schema.json b/qapi-schema.json
index 5bb8cb7..56646e0 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4122,13 +4122,15 @@
     'port': 'str' } }
 
 ##
-# @SocketAddress:
+# @SocketAddressLegacy:
 #
 # Captures the address of a socket, which could also be a named file descriptor
 #
+# Note: This type is deprecated in favor of SocketAddressFlat.
+#
 # Since: 1.3
 ##
-{ 'union': 'SocketAddress',
+{ 'union': 'SocketAddressLegacy',
   'data': {
     'inet': 'InetSocketAddress',
     'unix': 'UnixSocketAddress',
@@ -4156,7 +4158,7 @@
 #
 # @type:       Transport type
 #
-# This is just like SocketAddress, except it's a flat union rather
+# This is just like SocketAddressLegacy, except it's a flat union rather
 # than a simple union.  Nicer because it avoids nesting on the wire,
 # i.e. this form has fewer {}.
 #
@@ -4886,7 +4888,7 @@
 #
 # Since: 1.4
 ##
-{ 'struct': 'ChardevSocket', 'data': { 'addr'       : 'SocketAddress',
+{ 'struct': 'ChardevSocket', 'data': { 'addr'       : 'SocketAddressLegacy',
                                      '*tls-creds'  : 'str',
                                      '*server'    : 'bool',
                                      '*wait'      : 'bool',
@@ -4906,8 +4908,8 @@
 #
 # Since: 1.5
 ##
-{ 'struct': 'ChardevUdp', 'data': { 'remote' : 'SocketAddress',
-                                  '*local' : 'SocketAddress' },
+{ 'struct': 'ChardevUdp', 'data': { 'remote' : 'SocketAddressLegacy',
+                                  '*local' : 'SocketAddressLegacy' },
   'base': 'ChardevCommon' }
 
 ##
diff --git a/qapi/block.json b/qapi/block.json
index 46fca0e..6a2fdc7 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -204,7 +204,7 @@
 # Since: 1.3.0
 ##
 { 'command': 'nbd-server-start',
-  'data': { 'addr': 'SocketAddress',
+  'data': { 'addr': 'SocketAddressLegacy',
             '*tls-creds': 'str'} }
 
 ##
diff --git a/qemu-nbd.c b/qemu-nbd.c
index e4f00e2..82d0859 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -57,7 +57,7 @@ static NBDExport *exp;
 static bool newproto;
 static int verbose;
 static char *srcpath;
-static SocketAddress *saddr;
+static SocketAddressLegacy *saddr;
 static int persistent = 0;
 static enum { RUNNING, TERMINATE, TERMINATING, TERMINATED } state;
 static int shared = 1;
@@ -387,20 +387,20 @@ static void nbd_update_server_watch(void)
 }
 
 
-static SocketAddress *nbd_build_socket_address(const char *sockpath,
+static SocketAddressLegacy *nbd_build_socket_address(const char *sockpath,
                                                const char *bindto,
                                                const char *port)
 {
-    SocketAddress *saddr;
+    SocketAddressLegacy *saddr;
 
-    saddr = g_new0(SocketAddress, 1);
+    saddr = g_new0(SocketAddressLegacy, 1);
     if (sockpath) {
-        saddr->type = SOCKET_ADDRESS_KIND_UNIX;
+        saddr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
         saddr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
         saddr->u.q_unix.data->path = g_strdup(sockpath);
     } else {
         InetSocketAddress *inet;
-        saddr->type = SOCKET_ADDRESS_KIND_INET;
+        saddr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
         inet = saddr->u.inet.data = g_new0(InetSocketAddress, 1);
         inet->host = g_strdup(bindto);
         if (port) {
diff --git a/qga/channel-posix.c b/qga/channel-posix.c
index 3f34465..65ab8eb 100644
--- a/qga/channel-posix.c
+++ b/qga/channel-posix.c
@@ -203,7 +203,7 @@ static gboolean ga_channel_open(GAChannel *c, const gchar *path,
     case GA_CHANNEL_VSOCK_LISTEN: {
         if (fd < 0) {
             Error *local_err = NULL;
-            SocketAddress *addr;
+            SocketAddressLegacy *addr;
             char *addr_str;
 
             addr_str = g_strdup_printf("vsock:%s", path);
@@ -216,7 +216,7 @@ static gboolean ga_channel_open(GAChannel *c, const gchar *path,
             }
 
             fd = socket_listen(addr, &local_err);
-            qapi_free_SocketAddress(addr);
+            qapi_free_SocketAddressLegacy(addr);
             if (local_err != NULL) {
                 g_critical("%s", error_get_pretty(local_err));
                 error_free(local_err);
diff --git a/qga/main.c b/qga/main.c
index ad6f68f..cae4d7b 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -1379,7 +1379,7 @@ int main(int argc, char **argv)
         goto end;
     }
     if (socket_activation) {
-        SocketAddress *addr;
+        SocketAddressLegacy *addr;
 
         g_free(config->method);
         g_free(config->channel_path);
@@ -1388,13 +1388,13 @@ int main(int argc, char **argv)
 
         addr = socket_local_address(FIRST_SOCKET_ACTIVATION_FD, NULL);
         if (addr) {
-            if (addr->type == SOCKET_ADDRESS_KIND_UNIX) {
+            if (addr->type == SOCKET_ADDRESS_LEGACY_KIND_UNIX) {
                 config->method = g_strdup("unix-listen");
-            } else if (addr->type == SOCKET_ADDRESS_KIND_VSOCK) {
+            } else if (addr->type == SOCKET_ADDRESS_LEGACY_KIND_VSOCK) {
                 config->method = g_strdup("vsock-listen");
             }
 
-            qapi_free_SocketAddress(addr);
+            qapi_free_SocketAddressLegacy(addr);
         }
 
         if (!config->method) {
diff --git a/tests/test-io-channel-socket.c b/tests/test-io-channel-socket.c
index c5c1314..a66ffc2 100644
--- a/tests/test-io-channel-socket.c
+++ b/tests/test-io-channel-socket.c
@@ -115,8 +115,8 @@ static void test_io_channel_set_socket_bufs(QIOChannel *src,
 }
 
 
-static void test_io_channel_setup_sync(SocketAddress *listen_addr,
-                                       SocketAddress *connect_addr,
+static void test_io_channel_setup_sync(SocketAddressLegacy *listen_addr,
+                                       SocketAddressLegacy *connect_addr,
                                        QIOChannel **src,
                                        QIOChannel **dst)
 {
@@ -125,14 +125,14 @@ static void test_io_channel_setup_sync(SocketAddress *listen_addr,
     lioc = qio_channel_socket_new();
     qio_channel_socket_listen_sync(lioc, listen_addr, &error_abort);
 
-    if (listen_addr->type == SOCKET_ADDRESS_KIND_INET) {
-        SocketAddress *laddr = qio_channel_socket_get_local_address(
+    if (listen_addr->type == SOCKET_ADDRESS_LEGACY_KIND_INET) {
+        SocketAddressLegacy *laddr = qio_channel_socket_get_local_address(
             lioc, &error_abort);
 
         g_free(connect_addr->u.inet.data->port);
         connect_addr->u.inet.data->port = g_strdup(laddr->u.inet.data->port);
 
-        qapi_free_SocketAddress(laddr);
+        qapi_free_SocketAddressLegacy(laddr);
     }
 
     *src = QIO_CHANNEL(qio_channel_socket_new());
@@ -165,8 +165,8 @@ static void test_io_channel_complete(QIOTask *task,
 }
 
 
-static void test_io_channel_setup_async(SocketAddress *listen_addr,
-                                        SocketAddress *connect_addr,
+static void test_io_channel_setup_async(SocketAddressLegacy *listen_addr,
+                                        SocketAddressLegacy *connect_addr,
                                         QIOChannel **src,
                                         QIOChannel **dst)
 {
@@ -186,14 +186,14 @@ static void test_io_channel_setup_async(SocketAddress *listen_addr,
 
     g_assert(!data.err);
 
-    if (listen_addr->type == SOCKET_ADDRESS_KIND_INET) {
-        SocketAddress *laddr = qio_channel_socket_get_local_address(
+    if (listen_addr->type == SOCKET_ADDRESS_LEGACY_KIND_INET) {
+        SocketAddressLegacy *laddr = qio_channel_socket_get_local_address(
             lioc, &error_abort);
 
         g_free(connect_addr->u.inet.data->port);
         connect_addr->u.inet.data->port = g_strdup(laddr->u.inet.data->port);
 
-        qapi_free_SocketAddress(laddr);
+        qapi_free_SocketAddressLegacy(laddr);
     }
 
     *src = QIO_CHANNEL(qio_channel_socket_new());
@@ -221,8 +221,8 @@ static void test_io_channel_setup_async(SocketAddress *listen_addr,
 
 
 static void test_io_channel(bool async,
-                            SocketAddress *listen_addr,
-                            SocketAddress *connect_addr,
+                            SocketAddressLegacy *listen_addr,
+                            SocketAddressLegacy *connect_addr,
                             bool passFD)
 {
     QIOChannel *src, *dst;
@@ -297,17 +297,17 @@ static void test_io_channel(bool async,
 
 static void test_io_channel_ipv4(bool async)
 {
-    SocketAddress *listen_addr = g_new0(SocketAddress, 1);
-    SocketAddress *connect_addr = g_new0(SocketAddress, 1);
+    SocketAddressLegacy *listen_addr = g_new0(SocketAddressLegacy, 1);
+    SocketAddressLegacy *connect_addr = g_new0(SocketAddressLegacy, 1);
 
-    listen_addr->type = SOCKET_ADDRESS_KIND_INET;
+    listen_addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
     listen_addr->u.inet.data = g_new(InetSocketAddress, 1);
     *listen_addr->u.inet.data = (InetSocketAddress) {
         .host = g_strdup("127.0.0.1"),
         .port = NULL, /* Auto-select */
     };
 
-    connect_addr->type = SOCKET_ADDRESS_KIND_INET;
+    connect_addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
     connect_addr->u.inet.data = g_new(InetSocketAddress, 1);
     *connect_addr->u.inet.data = (InetSocketAddress) {
         .host = g_strdup("127.0.0.1"),
@@ -316,8 +316,8 @@ static void test_io_channel_ipv4(bool async)
 
     test_io_channel(async, listen_addr, connect_addr, false);
 
-    qapi_free_SocketAddress(listen_addr);
-    qapi_free_SocketAddress(connect_addr);
+    qapi_free_SocketAddressLegacy(listen_addr);
+    qapi_free_SocketAddressLegacy(connect_addr);
 }
 
 
@@ -335,17 +335,17 @@ static void test_io_channel_ipv4_async(void)
 
 static void test_io_channel_ipv6(bool async)
 {
-    SocketAddress *listen_addr = g_new0(SocketAddress, 1);
-    SocketAddress *connect_addr = g_new0(SocketAddress, 1);
+    SocketAddressLegacy *listen_addr = g_new0(SocketAddressLegacy, 1);
+    SocketAddressLegacy *connect_addr = g_new0(SocketAddressLegacy, 1);
 
-    listen_addr->type = SOCKET_ADDRESS_KIND_INET;
+    listen_addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
     listen_addr->u.inet.data = g_new(InetSocketAddress, 1);
     *listen_addr->u.inet.data = (InetSocketAddress) {
         .host = g_strdup("::1"),
         .port = NULL, /* Auto-select */
     };
 
-    connect_addr->type = SOCKET_ADDRESS_KIND_INET;
+    connect_addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
     connect_addr->u.inet.data = g_new(InetSocketAddress, 1);
     *connect_addr->u.inet.data = (InetSocketAddress) {
         .host = g_strdup("::1"),
@@ -354,8 +354,8 @@ static void test_io_channel_ipv6(bool async)
 
     test_io_channel(async, listen_addr, connect_addr, false);
 
-    qapi_free_SocketAddress(listen_addr);
-    qapi_free_SocketAddress(connect_addr);
+    qapi_free_SocketAddressLegacy(listen_addr);
+    qapi_free_SocketAddressLegacy(connect_addr);
 }
 
 
@@ -374,22 +374,22 @@ static void test_io_channel_ipv6_async(void)
 #ifndef _WIN32
 static void test_io_channel_unix(bool async)
 {
-    SocketAddress *listen_addr = g_new0(SocketAddress, 1);
-    SocketAddress *connect_addr = g_new0(SocketAddress, 1);
+    SocketAddressLegacy *listen_addr = g_new0(SocketAddressLegacy, 1);
+    SocketAddressLegacy *connect_addr = g_new0(SocketAddressLegacy, 1);
 
 #define TEST_SOCKET "test-io-channel-socket.sock"
-    listen_addr->type = SOCKET_ADDRESS_KIND_UNIX;
+    listen_addr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
     listen_addr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
     listen_addr->u.q_unix.data->path = g_strdup(TEST_SOCKET);
 
-    connect_addr->type = SOCKET_ADDRESS_KIND_UNIX;
+    connect_addr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
     connect_addr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
     connect_addr->u.q_unix.data->path = g_strdup(TEST_SOCKET);
 
     test_io_channel(async, listen_addr, connect_addr, true);
 
-    qapi_free_SocketAddress(listen_addr);
-    qapi_free_SocketAddress(connect_addr);
+    qapi_free_SocketAddressLegacy(listen_addr);
+    qapi_free_SocketAddressLegacy(connect_addr);
     g_assert(g_file_test(TEST_SOCKET, G_FILE_TEST_EXISTS) == FALSE);
 }
 
@@ -407,8 +407,8 @@ static void test_io_channel_unix_async(void)
 
 static void test_io_channel_unix_fd_pass(void)
 {
-    SocketAddress *listen_addr = g_new0(SocketAddress, 1);
-    SocketAddress *connect_addr = g_new0(SocketAddress, 1);
+    SocketAddressLegacy *listen_addr = g_new0(SocketAddressLegacy, 1);
+    SocketAddressLegacy *connect_addr = g_new0(SocketAddressLegacy, 1);
     QIOChannel *src, *dst;
     int testfd;
     int fdsend[3];
@@ -427,11 +427,11 @@ static void test_io_channel_unix_fd_pass(void)
     fdsend[1] = testfd;
     fdsend[2] = testfd;
 
-    listen_addr->type = SOCKET_ADDRESS_KIND_UNIX;
+    listen_addr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
     listen_addr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
     listen_addr->u.q_unix.data->path = g_strdup(TEST_SOCKET);
 
-    connect_addr->type = SOCKET_ADDRESS_KIND_UNIX;
+    connect_addr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
     connect_addr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
     connect_addr->u.q_unix.data->path = g_strdup(TEST_SOCKET);
 
@@ -488,8 +488,8 @@ static void test_io_channel_unix_fd_pass(void)
 
     object_unref(OBJECT(src));
     object_unref(OBJECT(dst));
-    qapi_free_SocketAddress(listen_addr);
-    qapi_free_SocketAddress(connect_addr);
+    qapi_free_SocketAddressLegacy(listen_addr);
+    qapi_free_SocketAddressLegacy(connect_addr);
     unlink(TEST_SOCKET);
     unlink(TEST_FILE);
     close(testfd);
diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
index 5ae29c1..c7fa9b6 100644
--- a/ui/vnc-auth-sasl.c
+++ b/ui/vnc-auth-sasl.c
@@ -498,7 +498,7 @@ vnc_socket_ip_addr_string(QIOChannelSocket *ioc,
                           bool local,
                           Error **errp)
 {
-    SocketAddress *addr;
+    SocketAddressLegacy *addr;
     char *ret;
 
     if (local) {
@@ -510,13 +510,13 @@ vnc_socket_ip_addr_string(QIOChannelSocket *ioc,
         return NULL;
     }
 
-    if (addr->type != SOCKET_ADDRESS_KIND_INET) {
+    if (addr->type != SOCKET_ADDRESS_LEGACY_KIND_INET) {
         error_setg(errp, "Not an inet socket type");
         return NULL;
     }
     ret = g_strdup_printf("%s;%s", addr->u.inet.data->host,
                           addr->u.inet.data->port);
-    qapi_free_SocketAddress(addr);
+    qapi_free_SocketAddressLegacy(addr);
     return ret;
 }
 
diff --git a/ui/vnc.c b/ui/vnc.c
index 349cfc9..5090a25 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -108,12 +108,12 @@ static void vnc_set_share_mode(VncState *vs, VncShareMode mode)
 }
 
 
-static void vnc_init_basic_info(SocketAddress *addr,
+static void vnc_init_basic_info(SocketAddressLegacy *addr,
                                 VncBasicInfo *info,
                                 Error **errp)
 {
     switch (addr->type) {
-    case SOCKET_ADDRESS_KIND_INET:
+    case SOCKET_ADDRESS_LEGACY_KIND_INET:
         info->host = g_strdup(addr->u.inet.data->host);
         info->service = g_strdup(addr->u.inet.data->port);
         if (addr->u.inet.data->ipv6) {
@@ -123,16 +123,16 @@ static void vnc_init_basic_info(SocketAddress *addr,
         }
         break;
 
-    case SOCKET_ADDRESS_KIND_UNIX:
+    case SOCKET_ADDRESS_LEGACY_KIND_UNIX:
         info->host = g_strdup("");
         info->service = g_strdup(addr->u.q_unix.data->path);
         info->family = NETWORK_ADDRESS_FAMILY_UNIX;
         break;
 
-    case SOCKET_ADDRESS_KIND_VSOCK:
-    case SOCKET_ADDRESS_KIND_FD:
+    case SOCKET_ADDRESS_LEGACY_KIND_VSOCK:
+    case SOCKET_ADDRESS_LEGACY_KIND_FD:
         error_setg(errp, "Unsupported socket address type %s",
-                   SocketAddressKind_lookup[addr->type]);
+                   SocketAddressLegacyKind_lookup[addr->type]);
         break;
     default:
         abort();
@@ -145,7 +145,7 @@ static void vnc_init_basic_info_from_server_addr(QIOChannelSocket *ioc,
                                                  VncBasicInfo *info,
                                                  Error **errp)
 {
-    SocketAddress *addr = NULL;
+    SocketAddressLegacy *addr = NULL;
 
     if (!ioc) {
         error_setg(errp, "No listener socket available");
@@ -158,14 +158,14 @@ static void vnc_init_basic_info_from_server_addr(QIOChannelSocket *ioc,
     }
 
     vnc_init_basic_info(addr, info, errp);
-    qapi_free_SocketAddress(addr);
+    qapi_free_SocketAddressLegacy(addr);
 }
 
 static void vnc_init_basic_info_from_remote_addr(QIOChannelSocket *ioc,
                                                  VncBasicInfo *info,
                                                  Error **errp)
 {
-    SocketAddress *addr = NULL;
+    SocketAddressLegacy *addr = NULL;
 
     addr = qio_channel_socket_get_remote_address(ioc, errp);
     if (!addr) {
@@ -173,7 +173,7 @@ static void vnc_init_basic_info_from_remote_addr(QIOChannelSocket *ioc,
     }
 
     vnc_init_basic_info(addr, info, errp);
-    qapi_free_SocketAddress(addr);
+    qapi_free_SocketAddressLegacy(addr);
 }
 
 static const char *vnc_auth_name(VncDisplay *vd) {
@@ -377,7 +377,7 @@ VncInfo *qmp_query_vnc(Error **errp)
 {
     VncInfo *info = g_malloc0(sizeof(*info));
     VncDisplay *vd = vnc_display_find(NULL);
-    SocketAddress *addr = NULL;
+    SocketAddressLegacy *addr = NULL;
 
     if (vd == NULL || !vd->nlsock) {
         info->enabled = false;
@@ -398,7 +398,7 @@ VncInfo *qmp_query_vnc(Error **errp)
         }
 
         switch (addr->type) {
-        case SOCKET_ADDRESS_KIND_INET:
+        case SOCKET_ADDRESS_LEGACY_KIND_INET:
             info->host = g_strdup(addr->u.inet.data->host);
             info->service = g_strdup(addr->u.inet.data->port);
             if (addr->u.inet.data->ipv6) {
@@ -408,16 +408,16 @@ VncInfo *qmp_query_vnc(Error **errp)
             }
             break;
 
-        case SOCKET_ADDRESS_KIND_UNIX:
+        case SOCKET_ADDRESS_LEGACY_KIND_UNIX:
             info->host = g_strdup("");
             info->service = g_strdup(addr->u.q_unix.data->path);
             info->family = NETWORK_ADDRESS_FAMILY_UNIX;
             break;
 
-        case SOCKET_ADDRESS_KIND_VSOCK:
-        case SOCKET_ADDRESS_KIND_FD:
+        case SOCKET_ADDRESS_LEGACY_KIND_VSOCK:
+        case SOCKET_ADDRESS_LEGACY_KIND_FD:
             error_setg(errp, "Unsupported socket address type %s",
-                       SocketAddressKind_lookup[addr->type]);
+                       SocketAddressLegacyKind_lookup[addr->type]);
             goto out_error;
         default:
             abort();
@@ -431,11 +431,11 @@ VncInfo *qmp_query_vnc(Error **errp)
         info->auth = g_strdup(vnc_auth_name(vd));
     }
 
-    qapi_free_SocketAddress(addr);
+    qapi_free_SocketAddressLegacy(addr);
     return info;
 
 out_error:
-    qapi_free_SocketAddress(addr);
+    qapi_free_SocketAddressLegacy(addr);
     qapi_free_VncInfo(info);
     return NULL;
 }
@@ -455,7 +455,7 @@ static VncServerInfo2List *qmp_query_server_entry(QIOChannelSocket *ioc,
     VncServerInfo2List *list;
     VncServerInfo2 *info;
     Error *err = NULL;
-    SocketAddress *addr;
+    SocketAddressLegacy *addr;
 
     addr = qio_channel_socket_get_local_address(ioc, &err);
     if (!addr) {
@@ -465,7 +465,7 @@ static VncServerInfo2List *qmp_query_server_entry(QIOChannelSocket *ioc,
 
     info = g_new0(VncServerInfo2, 1);
     vnc_init_basic_info(addr, qapi_VncServerInfo2_base(info), &err);
-    qapi_free_SocketAddress(addr);
+    qapi_free_SocketAddressLegacy(addr);
     if (err) {
         qapi_free_VncServerInfo2(info);
         error_free(err);
@@ -3149,7 +3149,7 @@ int vnc_display_pw_expire(const char *id, time_t expires)
 
 static void vnc_display_print_local_addr(VncDisplay *vd)
 {
-    SocketAddress *addr;
+    SocketAddressLegacy *addr;
     Error *err = NULL;
 
     if (!vd->nlsock) {
@@ -3161,14 +3161,14 @@ static void vnc_display_print_local_addr(VncDisplay *vd)
         return;
     }
 
-    if (addr->type != SOCKET_ADDRESS_KIND_INET) {
-        qapi_free_SocketAddress(addr);
+    if (addr->type != SOCKET_ADDRESS_LEGACY_KIND_INET) {
+        qapi_free_SocketAddressLegacy(addr);
         return;
     }
     error_printf_unless_qmp("VNC server running on %s:%s\n",
                             addr->u.inet.data->host,
                             addr->u.inet.data->port);
-    qapi_free_SocketAddress(addr);
+    qapi_free_SocketAddressLegacy(addr);
 }
 
 static QemuOptsList qemu_vnc_opts = {
@@ -3414,16 +3414,16 @@ static int vnc_display_get_address(const char *addrstr,
                                    bool has_ipv6,
                                    bool ipv4,
                                    bool ipv6,
-                                   SocketAddress **retaddr,
+                                   SocketAddressLegacy **retaddr,
                                    Error **errp)
 {
     int ret = -1;
-    SocketAddress *addr = NULL;
+    SocketAddressLegacy *addr = NULL;
 
-    addr = g_new0(SocketAddress, 1);
+    addr = g_new0(SocketAddressLegacy, 1);
 
     if (strncmp(addrstr, "unix:", 5) == 0) {
-        addr->type = SOCKET_ADDRESS_KIND_UNIX;
+        addr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
         addr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
         addr->u.q_unix.data->path = g_strdup(addrstr + 5);
 
@@ -3461,7 +3461,7 @@ static int vnc_display_get_address(const char *addrstr,
             }
         }
 
-        addr->type = SOCKET_ADDRESS_KIND_INET;
+        addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
         inet = addr->u.inet.data = g_new0(InetSocketAddress, 1);
         if (addrstr[0] == '[' && addrstr[hostlen - 1] == ']') {
             inet->host = g_strndup(addrstr + 1, hostlen - 2);
@@ -3518,21 +3518,21 @@ static int vnc_display_get_address(const char *addrstr,
 
  cleanup:
     if (ret < 0) {
-        qapi_free_SocketAddress(addr);
+        qapi_free_SocketAddressLegacy(addr);
     }
     return ret;
 }
 
 static int vnc_display_get_addresses(QemuOpts *opts,
                                      bool reverse,
-                                     SocketAddress ***retsaddr,
+                                     SocketAddressLegacy ***retsaddr,
                                      size_t *retnsaddr,
-                                     SocketAddress ***retwsaddr,
+                                     SocketAddressLegacy ***retwsaddr,
                                      size_t *retnwsaddr,
                                      Error **errp)
 {
-    SocketAddress *saddr = NULL;
-    SocketAddress *wsaddr = NULL;
+    SocketAddressLegacy *saddr = NULL;
+    SocketAddressLegacy *wsaddr = NULL;
     QemuOptsIter addriter;
     const char *addr;
     int to = qemu_opt_get_number(opts, "to", 0);
@@ -3577,7 +3577,7 @@ static int vnc_display_get_addresses(QemuOpts *opts,
         if (displaynum == -1) {
             displaynum = rv;
         }
-        *retsaddr = g_renew(SocketAddress *, *retsaddr, *retnsaddr + 1);
+        *retsaddr = g_renew(SocketAddressLegacy *, *retsaddr, *retnsaddr + 1);
         (*retsaddr)[(*retnsaddr)++] = saddr;
     }
 
@@ -3601,8 +3601,8 @@ static int vnc_display_get_addresses(QemuOpts *opts,
          * address for websocket too
          */
         if (*retnsaddr == 1 &&
-            (*retsaddr)[0]->type == SOCKET_ADDRESS_KIND_INET &&
-            wsaddr->type == SOCKET_ADDRESS_KIND_INET &&
+            (*retsaddr)[0]->type == SOCKET_ADDRESS_LEGACY_KIND_INET &&
+            wsaddr->type == SOCKET_ADDRESS_LEGACY_KIND_INET &&
             g_str_equal(wsaddr->u.inet.data->host, "") &&
             !g_str_equal((*retsaddr)[0]->u.inet.data->host, "")) {
             g_free(wsaddr->u.inet.data->host);
@@ -3610,7 +3610,7 @@ static int vnc_display_get_addresses(QemuOpts *opts,
                 g_strdup((*retsaddr)[0]->u.inet.data->host);
         }
 
-        *retwsaddr = g_renew(SocketAddress *, *retwsaddr, *retnwsaddr + 1);
+        *retwsaddr = g_renew(SocketAddressLegacy *, *retwsaddr, *retnwsaddr + 1);
         (*retwsaddr)[(*retnwsaddr)++] = wsaddr;
     }
 
@@ -3618,11 +3618,11 @@ static int vnc_display_get_addresses(QemuOpts *opts,
  cleanup:
     if (ret < 0) {
         for (i = 0; i < *retnsaddr; i++) {
-            qapi_free_SocketAddress((*retsaddr)[i]);
+            qapi_free_SocketAddressLegacy((*retsaddr)[i]);
         }
         g_free(*retsaddr);
         for (i = 0; i < *retnwsaddr; i++) {
-            qapi_free_SocketAddress((*retwsaddr)[i]);
+            qapi_free_SocketAddressLegacy((*retwsaddr)[i]);
         }
         g_free(*retwsaddr);
         *retsaddr = *retwsaddr = NULL;
@@ -3632,9 +3632,9 @@ static int vnc_display_get_addresses(QemuOpts *opts,
 }
 
 static int vnc_display_connect(VncDisplay *vd,
-                               SocketAddress **saddr,
+                               SocketAddressLegacy **saddr,
                                size_t nsaddr,
-                               SocketAddress **wsaddr,
+                               SocketAddressLegacy **wsaddr,
                                size_t nwsaddr,
                                Error **errp)
 {
@@ -3648,8 +3648,8 @@ static int vnc_display_connect(VncDisplay *vd,
         error_setg(errp, "Expected a single address in reverse mode");
         return -1;
     }
-    /* TODO SOCKET_ADDRESS_KIND_FD when fd has AF_UNIX */
-    vd->is_unix = saddr[0]->type == SOCKET_ADDRESS_KIND_UNIX;
+    /* TODO SOCKET_ADDRESS_LEGACY_KIND_FD when fd has AF_UNIX */
+    vd->is_unix = saddr[0]->type == SOCKET_ADDRESS_LEGACY_KIND_UNIX;
     sioc = qio_channel_socket_new();
     qio_channel_set_name(QIO_CHANNEL(sioc), "vnc-reverse");
     if (qio_channel_socket_connect_sync(sioc, saddr[0], errp) < 0) {
@@ -3662,7 +3662,7 @@ static int vnc_display_connect(VncDisplay *vd,
 
 
 static int vnc_display_listen_addr(VncDisplay *vd,
-                                   SocketAddress *addr,
+                                   SocketAddressLegacy *addr,
                                    const char *name,
                                    QIOChannelSocket ***lsock,
                                    guint **lsock_tag,
@@ -3670,7 +3670,7 @@ static int vnc_display_listen_addr(VncDisplay *vd,
                                    Error **errp)
 {
     QIODNSResolver *resolver = qio_dns_resolver_get_instance();
-    SocketAddress **rawaddrs = NULL;
+    SocketAddressLegacy **rawaddrs = NULL;
     size_t nrawaddrs = 0;
     Error *listenerr = NULL;
     bool listening = false;
@@ -3700,7 +3700,7 @@ static int vnc_display_listen_addr(VncDisplay *vd,
     }
 
     for (i = 0; i < nrawaddrs; i++) {
-        qapi_free_SocketAddress(rawaddrs[i]);
+        qapi_free_SocketAddressLegacy(rawaddrs[i]);
     }
     g_free(rawaddrs);
 
@@ -3724,9 +3724,9 @@ static int vnc_display_listen_addr(VncDisplay *vd,
 
 
 static int vnc_display_listen(VncDisplay *vd,
-                              SocketAddress **saddr,
+                              SocketAddressLegacy **saddr,
                               size_t nsaddr,
-                              SocketAddress **wsaddr,
+                              SocketAddressLegacy **wsaddr,
                               size_t nwsaddr,
                               Error **errp)
 {
@@ -3761,7 +3761,7 @@ void vnc_display_open(const char *id, Error **errp)
 {
     VncDisplay *vd = vnc_display_find(id);
     QemuOpts *opts = qemu_opts_find(&qemu_vnc_opts, id);
-    SocketAddress **saddr = NULL, **wsaddr = NULL;
+    SocketAddressLegacy **saddr = NULL, **wsaddr = NULL;
     size_t nsaddr, nwsaddr;
     const char *share, *device_id;
     QemuConsole *con;
@@ -3997,10 +3997,10 @@ void vnc_display_open(const char *id, Error **errp)
 
  cleanup:
     for (i = 0; i < nsaddr; i++) {
-        qapi_free_SocketAddress(saddr[i]);
+        qapi_free_SocketAddressLegacy(saddr[i]);
     }
     for (i = 0; i < nwsaddr; i++) {
-        qapi_free_SocketAddress(wsaddr[i]);
+        qapi_free_SocketAddressLegacy(wsaddr[i]);
     }
     return;
 
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 62c93ba..4c48203 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1029,17 +1029,17 @@ int unix_connect(const char *path, Error **errp)
 }
 
 
-SocketAddress *socket_parse(const char *str, Error **errp)
+SocketAddressLegacy *socket_parse(const char *str, Error **errp)
 {
-    SocketAddress *addr;
+    SocketAddressLegacy *addr;
 
-    addr = g_new0(SocketAddress, 1);
+    addr = g_new0(SocketAddressLegacy, 1);
     if (strstart(str, "unix:", NULL)) {
         if (str[5] == '\0') {
             error_setg(errp, "invalid Unix socket address");
             goto fail;
         } else {
-            addr->type = SOCKET_ADDRESS_KIND_UNIX;
+            addr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
             addr->u.q_unix.data = g_new(UnixSocketAddress, 1);
             addr->u.q_unix.data->path = g_strdup(str + 5);
         }
@@ -1048,18 +1048,18 @@ SocketAddress *socket_parse(const char *str, Error **errp)
             error_setg(errp, "invalid file descriptor address");
             goto fail;
         } else {
-            addr->type = SOCKET_ADDRESS_KIND_FD;
+            addr->type = SOCKET_ADDRESS_LEGACY_KIND_FD;
             addr->u.fd.data = g_new(String, 1);
             addr->u.fd.data->str = g_strdup(str + 3);
         }
     } else if (strstart(str, "vsock:", NULL)) {
-        addr->type = SOCKET_ADDRESS_KIND_VSOCK;
+        addr->type = SOCKET_ADDRESS_LEGACY_KIND_VSOCK;
         addr->u.vsock.data = g_new(VsockSocketAddress, 1);
         if (vsock_parse(addr->u.vsock.data, str + strlen("vsock:"), errp)) {
             goto fail;
         }
     } else {
-        addr->type = SOCKET_ADDRESS_KIND_INET;
+        addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
         addr->u.inet.data = g_new(InetSocketAddress, 1);
         if (inet_parse(addr->u.inet.data, str, errp)) {
             goto fail;
@@ -1068,25 +1068,25 @@ SocketAddress *socket_parse(const char *str, Error **errp)
     return addr;
 
 fail:
-    qapi_free_SocketAddress(addr);
+    qapi_free_SocketAddressLegacy(addr);
     return NULL;
 }
 
-int socket_connect(SocketAddress *addr, NonBlockingConnectHandler *callback,
+int socket_connect(SocketAddressLegacy *addr, NonBlockingConnectHandler *callback,
                    void *opaque, Error **errp)
 {
     int fd;
 
     switch (addr->type) {
-    case SOCKET_ADDRESS_KIND_INET:
+    case SOCKET_ADDRESS_LEGACY_KIND_INET:
         fd = inet_connect_saddr(addr->u.inet.data, callback, opaque, errp);
         break;
 
-    case SOCKET_ADDRESS_KIND_UNIX:
+    case SOCKET_ADDRESS_LEGACY_KIND_UNIX:
         fd = unix_connect_saddr(addr->u.q_unix.data, callback, opaque, errp);
         break;
 
-    case SOCKET_ADDRESS_KIND_FD:
+    case SOCKET_ADDRESS_LEGACY_KIND_FD:
         fd = monitor_get_fd(cur_mon, addr->u.fd.data->str, errp);
         if (fd >= 0 && callback) {
             qemu_set_nonblock(fd);
@@ -1094,7 +1094,7 @@ int socket_connect(SocketAddress *addr, NonBlockingConnectHandler *callback,
         }
         break;
 
-    case SOCKET_ADDRESS_KIND_VSOCK:
+    case SOCKET_ADDRESS_LEGACY_KIND_VSOCK:
         fd = vsock_connect_saddr(addr->u.vsock.data, callback, opaque, errp);
         break;
 
@@ -1104,24 +1104,24 @@ int socket_connect(SocketAddress *addr, NonBlockingConnectHandler *callback,
     return fd;
 }
 
-int socket_listen(SocketAddress *addr, Error **errp)
+int socket_listen(SocketAddressLegacy *addr, Error **errp)
 {
     int fd;
 
     switch (addr->type) {
-    case SOCKET_ADDRESS_KIND_INET:
+    case SOCKET_ADDRESS_LEGACY_KIND_INET:
         fd = inet_listen_saddr(addr->u.inet.data, 0, false, errp);
         break;
 
-    case SOCKET_ADDRESS_KIND_UNIX:
+    case SOCKET_ADDRESS_LEGACY_KIND_UNIX:
         fd = unix_listen_saddr(addr->u.q_unix.data, false, errp);
         break;
 
-    case SOCKET_ADDRESS_KIND_FD:
+    case SOCKET_ADDRESS_LEGACY_KIND_FD:
         fd = monitor_get_fd(cur_mon, addr->u.fd.data->str, errp);
         break;
 
-    case SOCKET_ADDRESS_KIND_VSOCK:
+    case SOCKET_ADDRESS_LEGACY_KIND_VSOCK:
         fd = vsock_listen_saddr(addr->u.vsock.data, errp);
         break;
 
@@ -1133,11 +1133,11 @@ int socket_listen(SocketAddress *addr, Error **errp)
 
 void socket_listen_cleanup(int fd, Error **errp)
 {
-    SocketAddress *addr;
+    SocketAddressLegacy *addr;
 
     addr = socket_local_address(fd, errp);
 
-    if (addr->type == SOCKET_ADDRESS_KIND_UNIX
+    if (addr->type == SOCKET_ADDRESS_LEGACY_KIND_UNIX
         && addr->u.q_unix.data->path) {
         if (unlink(addr->u.q_unix.data->path) < 0 && errno != ENOENT) {
             error_setg_errno(errp, errno,
@@ -1146,19 +1146,19 @@ void socket_listen_cleanup(int fd, Error **errp)
         }
     }
 
-    qapi_free_SocketAddress(addr);
+    qapi_free_SocketAddressLegacy(addr);
 }
 
-int socket_dgram(SocketAddress *remote, SocketAddress *local, Error **errp)
+int socket_dgram(SocketAddressLegacy *remote, SocketAddressLegacy *local, Error **errp)
 {
     int fd;
 
     /*
-     * TODO SOCKET_ADDRESS_KIND_FD when fd is AF_INET or AF_INET6
+     * TODO SOCKET_ADDRESS_LEGACY_KIND_FD when fd is AF_INET or AF_INET6
      * (although other address families can do SOCK_DGRAM, too)
      */
     switch (remote->type) {
-    case SOCKET_ADDRESS_KIND_INET:
+    case SOCKET_ADDRESS_LEGACY_KIND_INET:
         fd = inet_dgram_saddr(remote->u.inet.data,
                               local ? local->u.inet.data : NULL, errp);
         break;
@@ -1171,14 +1171,14 @@ int socket_dgram(SocketAddress *remote, SocketAddress *local, Error **errp)
 }
 
 
-static SocketAddress *
+static SocketAddressLegacy *
 socket_sockaddr_to_address_inet(struct sockaddr_storage *sa,
                                 socklen_t salen,
                                 Error **errp)
 {
     char host[NI_MAXHOST];
     char serv[NI_MAXSERV];
-    SocketAddress *addr;
+    SocketAddressLegacy *addr;
     InetSocketAddress *inet;
     int ret;
 
@@ -1192,8 +1192,8 @@ socket_sockaddr_to_address_inet(struct sockaddr_storage *sa,
         return NULL;
     }
 
-    addr = g_new0(SocketAddress, 1);
-    addr->type = SOCKET_ADDRESS_KIND_INET;
+    addr = g_new0(SocketAddressLegacy, 1);
+    addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
     inet = addr->u.inet.data = g_new0(InetSocketAddress, 1);
     inet->host = g_strdup(host);
     inet->port = g_strdup(serv);
@@ -1208,16 +1208,16 @@ socket_sockaddr_to_address_inet(struct sockaddr_storage *sa,
 
 
 #ifndef WIN32
-static SocketAddress *
+static SocketAddressLegacy *
 socket_sockaddr_to_address_unix(struct sockaddr_storage *sa,
                                 socklen_t salen,
                                 Error **errp)
 {
-    SocketAddress *addr;
+    SocketAddressLegacy *addr;
     struct sockaddr_un *su = (struct sockaddr_un *)sa;
 
-    addr = g_new0(SocketAddress, 1);
-    addr->type = SOCKET_ADDRESS_KIND_UNIX;
+    addr = g_new0(SocketAddressLegacy, 1);
+    addr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
     addr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
     if (su->sun_path[0]) {
         addr->u.q_unix.data->path = g_strndup(su->sun_path,
@@ -1229,17 +1229,17 @@ socket_sockaddr_to_address_unix(struct sockaddr_storage *sa,
 #endif /* WIN32 */
 
 #ifdef CONFIG_AF_VSOCK
-static SocketAddress *
+static SocketAddressLegacy *
 socket_sockaddr_to_address_vsock(struct sockaddr_storage *sa,
                                  socklen_t salen,
                                  Error **errp)
 {
-    SocketAddress *addr;
+    SocketAddressLegacy *addr;
     VsockSocketAddress *vaddr;
     struct sockaddr_vm *svm = (struct sockaddr_vm *)sa;
 
-    addr = g_new0(SocketAddress, 1);
-    addr->type = SOCKET_ADDRESS_KIND_VSOCK;
+    addr = g_new0(SocketAddressLegacy, 1);
+    addr->type = SOCKET_ADDRESS_LEGACY_KIND_VSOCK;
     addr->u.vsock.data = vaddr = g_new0(VsockSocketAddress, 1);
     vaddr->cid = g_strdup_printf("%u", svm->svm_cid);
     vaddr->port = g_strdup_printf("%u", svm->svm_port);
@@ -1248,7 +1248,7 @@ socket_sockaddr_to_address_vsock(struct sockaddr_storage *sa,
 }
 #endif /* CONFIG_AF_VSOCK */
 
-SocketAddress *
+SocketAddressLegacy *
 socket_sockaddr_to_address(struct sockaddr_storage *sa,
                            socklen_t salen,
                            Error **errp)
@@ -1277,7 +1277,7 @@ socket_sockaddr_to_address(struct sockaddr_storage *sa,
 }
 
 
-SocketAddress *socket_local_address(int fd, Error **errp)
+SocketAddressLegacy *socket_local_address(int fd, Error **errp)
 {
     struct sockaddr_storage ss;
     socklen_t sslen = sizeof(ss);
@@ -1292,7 +1292,7 @@ SocketAddress *socket_local_address(int fd, Error **errp)
 }
 
 
-SocketAddress *socket_remote_address(int fd, Error **errp)
+SocketAddressLegacy *socket_remote_address(int fd, Error **errp)
 {
     struct sockaddr_storage ss;
     socklen_t sslen = sizeof(ss);
@@ -1306,13 +1306,13 @@ SocketAddress *socket_remote_address(int fd, Error **errp)
     return socket_sockaddr_to_address(&ss, sslen, errp);
 }
 
-char *socket_address_to_string(struct SocketAddress *addr, Error **errp)
+char *socket_address_to_string(struct SocketAddressLegacy *addr, Error **errp)
 {
     char *buf;
     InetSocketAddress *inet;
 
     switch (addr->type) {
-    case SOCKET_ADDRESS_KIND_INET:
+    case SOCKET_ADDRESS_LEGACY_KIND_INET:
         inet = addr->u.inet.data;
         if (strchr(inet->host, ':') == NULL) {
             buf = g_strdup_printf("%s:%s", inet->host, inet->port);
@@ -1321,15 +1321,15 @@ char *socket_address_to_string(struct SocketAddress *addr, Error **errp)
         }
         break;
 
-    case SOCKET_ADDRESS_KIND_UNIX:
+    case SOCKET_ADDRESS_LEGACY_KIND_UNIX:
         buf = g_strdup(addr->u.q_unix.data->path);
         break;
 
-    case SOCKET_ADDRESS_KIND_FD:
+    case SOCKET_ADDRESS_LEGACY_KIND_FD:
         buf = g_strdup(addr->u.fd.data->str);
         break;
 
-    case SOCKET_ADDRESS_KIND_VSOCK:
+    case SOCKET_ADDRESS_LEGACY_KIND_VSOCK:
         buf = g_strdup_printf("%s:%s",
                               addr->u.vsock.data->cid,
                               addr->u.vsock.data->port);
@@ -1341,28 +1341,28 @@ char *socket_address_to_string(struct SocketAddress *addr, Error **errp)
     return buf;
 }
 
-SocketAddress *socket_address_crumple(SocketAddressFlat *addr_flat)
+SocketAddressLegacy *socket_address_crumple(SocketAddressFlat *addr_flat)
 {
-    SocketAddress *addr = g_new(SocketAddress, 1);
+    SocketAddressLegacy *addr = g_new(SocketAddressLegacy, 1);
 
     switch (addr_flat->type) {
     case SOCKET_ADDRESS_FLAT_TYPE_INET:
-        addr->type = SOCKET_ADDRESS_KIND_INET;
+        addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
         addr->u.inet.data = QAPI_CLONE(InetSocketAddress,
                                        &addr_flat->u.inet);
         break;
     case SOCKET_ADDRESS_FLAT_TYPE_UNIX:
-        addr->type = SOCKET_ADDRESS_KIND_UNIX;
+        addr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
         addr->u.q_unix.data = QAPI_CLONE(UnixSocketAddress,
                                          &addr_flat->u.q_unix);
         break;
     case SOCKET_ADDRESS_FLAT_TYPE_VSOCK:
-        addr->type = SOCKET_ADDRESS_KIND_VSOCK;
+        addr->type = SOCKET_ADDRESS_LEGACY_KIND_VSOCK;
         addr->u.vsock.data = QAPI_CLONE(VsockSocketAddress,
                                         &addr_flat->u.vsock);
         break;
     case SOCKET_ADDRESS_FLAT_TYPE_FD:
-        addr->type = SOCKET_ADDRESS_KIND_FD;
+        addr->type = SOCKET_ADDRESS_LEGACY_KIND_FD;
         addr->u.fd.data = QAPI_CLONE(String, &addr_flat->u.fd);
         break;
     default:
-- 
2.7.4
