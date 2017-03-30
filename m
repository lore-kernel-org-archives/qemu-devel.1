Received: from eggs.gnu.org ([2001:4830:134:3::10]:58744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctZv6-0002bH-F7
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctZv4-0002Rv-HV
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:15:20 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 30 Mar 2017 15:15:05 +0200
Message-Id: <1490879707-6060-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1490879707-6060-1-git-send-email-armbru@redhat.com>
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC v2 for-2.9 08/10] nbd: Tidy up blockdev-add
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pbonzini@redhat.com

SocketAddress is a simple union, and simple unions are awkward: they
have their variant members wrapped in a "data" object on the wire, and
require additional indirections in C.  I intend to limit its use to
existing external interfaces, and convert all internal interfaces to
SocketAddressFlat.

BlockdevOptionsNbd is an external interface using SocketAddress.  We
already use SocketAddressFlat elsewhere in blockdev=add.  Replace it
by SocketAddressFlat while we can (it's new in 2.9) for simplicity and
consistency.  For example,

    { "execute": "blockdev-add",
      "arguments": { "node-name": "foo", "driver": "nbd",
                     "server": { "type": "inet",
		                 "data": { "host": "localhost",
				           "port": "12345" } } } }

becomes

    { "execute": "blockdev-add",
      "arguments": { "node-name": "foo", "driver": "nbd",
                     "server": { "type": "inet",
		                 "host": "localhost", "port": "12345" } } }

Since the internal interfaces still take SocketAddress, this requires
conversion function socket_address_crumple().  It'll go away when I
update the interfaces.

Unfortunately, SocketAddress is also visible in -drive since 2.8.  Add
still more gunk to nbd_process_legacy_socket_options().  You can now
shorten

    -drive if=none,driver=nbd,server.type=inet,server.data.host=127.0.0.1,server.data.port=12345

to

    -drive if=none,driver=nbd,server.type=inet,server.host=127.0.0.1,server.port=12345

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/nbd.c          | 94 +++++++++++++++++++++++++++++++++++++---------------
 qapi/block-core.json |  2 +-
 2 files changed, 69 insertions(+), 27 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 11e3ba7..ea9d8dc 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -47,7 +47,7 @@ typedef struct BDRVNBDState {
     NBDClientSession client;
 
     /* For nbd_refresh_filename() */
-    SocketAddress *saddr;
+    SocketAddressFlat *saddr;
     char *export, *tlscredsid;
 } BDRVNBDState;
 
@@ -95,7 +95,7 @@ static int nbd_parse_uri(const char *filename, QDict *options)
             goto out;
         }
         qdict_put(options, "server.type", qstring_from_str("unix"));
-        qdict_put(options, "server.data.path",
+        qdict_put(options, "server.path",
                   qstring_from_str(qp->p[0].value));
     } else {
         QString *host;
@@ -116,10 +116,10 @@ static int nbd_parse_uri(const char *filename, QDict *options)
         }
 
         qdict_put(options, "server.type", qstring_from_str("inet"));
-        qdict_put(options, "server.data.host", host);
+        qdict_put(options, "server.host", host);
 
         port_str = g_strdup_printf("%d", uri->port ?: NBD_DEFAULT_PORT);
-        qdict_put(options, "server.data.port", qstring_from_str(port_str));
+        qdict_put(options, "server.port", qstring_from_str(port_str));
         g_free(port_str);
     }
 
@@ -197,7 +197,7 @@ static void nbd_parse_filename(const char *filename, QDict *options,
     /* are we a UNIX or TCP socket? */
     if (strstart(host_spec, "unix:", &unixpath)) {
         qdict_put(options, "server.type", qstring_from_str("unix"));
-        qdict_put(options, "server.data.path", qstring_from_str(unixpath));
+        qdict_put(options, "server.path", qstring_from_str(unixpath));
     } else {
         InetSocketAddress *addr = NULL;
 
@@ -207,8 +207,8 @@ static void nbd_parse_filename(const char *filename, QDict *options,
         }
 
         qdict_put(options, "server.type", qstring_from_str("inet"));
-        qdict_put(options, "server.data.host", qstring_from_str(addr->host));
-        qdict_put(options, "server.data.port", qstring_from_str(addr->port));
+        qdict_put(options, "server.host", qstring_from_str(addr->host));
+        qdict_put(options, "server.port", qstring_from_str(addr->port));
         qapi_free_InetSocketAddress(addr);
     }
 
@@ -223,12 +223,51 @@ static bool nbd_process_legacy_socket_options(QDict *output_options,
     const char *path = qemu_opt_get(legacy_opts, "path");
     const char *host = qemu_opt_get(legacy_opts, "host");
     const char *port = qemu_opt_get(legacy_opts, "port");
+    const char *sd_path = qdict_get_try_str(output_options,
+                                            "server.data.path");
+    const char *sd_host = qdict_get_try_str(output_options,
+                                            "server.data.host");
+    const char *sd_port = qdict_get_try_str(output_options,
+                                            "server.data.port");
+    bool bare = path || host || port;
+    bool server_data = sd_path || sd_host || sd_port;
+    QObject *val;
     const QDictEntry *e;
 
-    if (!path && !host && !port) {
+    if (!bare && !server_data) {
         return true;
     }
 
+    if (bare && server_data) {
+        error_setg(errp, "Cannot use 'server' and path/host/port at the "
+                   "same time");
+        return false;
+    }
+
+    if (server_data) {
+        if (sd_host) {
+            val = qdict_get(output_options, "server.data.host");
+            qobject_incref(val);
+            qdict_put_obj(output_options, "server.host", val);
+            qdict_del(output_options, "server.data.host");
+        }
+        if (sd_port) {
+            val = qdict_get(output_options, "server.data.port");
+            qobject_incref(val);
+            qdict_put_obj(output_options, "server.port", val);
+            qdict_del(output_options, "server.data.port");
+        }
+        if (sd_path) {
+            val = qdict_get(output_options, "server.data.path");
+            qobject_incref(val);
+            qdict_put_obj(output_options, "server.path", val);
+            qdict_del(output_options, "server.data.path");
+        }
+        return true;
+    }
+
+    assert(bare);
+
     for (e = qdict_first(output_options); e; e = qdict_next(output_options, e))
     {
         if (strstart(e->key, "server.", NULL)) {
@@ -248,20 +287,21 @@ static bool nbd_process_legacy_socket_options(QDict *output_options,
         }
 
         qdict_put(output_options, "server.type", qstring_from_str("unix"));
-        qdict_put(output_options, "server.data.path", qstring_from_str(path));
+        qdict_put(output_options, "server.path", qstring_from_str(path));
     } else if (host) {
         qdict_put(output_options, "server.type", qstring_from_str("inet"));
-        qdict_put(output_options, "server.data.host", qstring_from_str(host));
-        qdict_put(output_options, "server.data.port",
+        qdict_put(output_options, "server.host", qstring_from_str(host));
+        qdict_put(output_options, "server.port",
                   qstring_from_str(port ?: stringify(NBD_DEFAULT_PORT)));
     }
 
     return true;
 }
 
-static SocketAddress *nbd_config(BDRVNBDState *s, QDict *options, Error **errp)
+static SocketAddressFlat *nbd_config(BDRVNBDState *s, QDict *options,
+                                     Error **errp)
 {
-    SocketAddress *saddr = NULL;
+    SocketAddressFlat *saddr = NULL;
     QDict *addr = NULL;
     QObject *crumpled_addr = NULL;
     Visitor *iv = NULL;
@@ -287,7 +327,7 @@ static SocketAddress *nbd_config(BDRVNBDState *s, QDict *options, Error **errp)
      * visitor expects the former.
      */
     iv = qobject_input_visitor_new(crumpled_addr);
-    visit_type_SocketAddress(iv, NULL, &saddr, &local_err);
+    visit_type_SocketAddressFlat(iv, NULL, &saddr, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto done;
@@ -306,9 +346,10 @@ NBDClientSession *nbd_get_client_session(BlockDriverState *bs)
     return &s->client;
 }
 
-static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
+static QIOChannelSocket *nbd_establish_connection(SocketAddressFlat *saddr_flat,
                                                   Error **errp)
 {
+    SocketAddress *saddr = socket_address_crumple(saddr_flat);
     QIOChannelSocket *sioc;
     Error *local_err = NULL;
 
@@ -318,6 +359,7 @@ static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
     qio_channel_socket_connect_sync(sioc,
                                     saddr,
                                     &local_err);
+    qapi_free_SocketAddress(saddr);
     if (local_err) {
         error_propagate(errp, local_err);
         return NULL;
@@ -409,7 +451,7 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
         goto error;
     }
 
-    /* Translate @host, @port, and @path to a SocketAddress */
+    /* Translate @host, @port, and @path to a SocketAddressFlat */
     if (!nbd_process_legacy_socket_options(options, opts, errp)) {
         goto error;
     }
@@ -430,11 +472,11 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
         }
 
         /* TODO SOCKET_ADDRESS_KIND_FD where fd has AF_INET or AF_INET6 */
-        if (s->saddr->type != SOCKET_ADDRESS_KIND_INET) {
+        if (s->saddr->type != SOCKET_ADDRESS_FLAT_TYPE_INET) {
             error_setg(errp, "TLS only supported over IP sockets");
             goto error;
         }
-        hostname = s->saddr->u.inet.data->host;
+        hostname = s->saddr->u.inet.host;
     }
 
     /* establish TCP connection, return error if it fails
@@ -457,7 +499,7 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
         object_unref(OBJECT(tlscreds));
     }
     if (ret < 0) {
-        qapi_free_SocketAddress(s->saddr);
+        qapi_free_SocketAddressFlat(s->saddr);
         g_free(s->export);
         g_free(s->tlscredsid);
     }
@@ -483,7 +525,7 @@ static void nbd_close(BlockDriverState *bs)
 
     nbd_client_close(bs);
 
-    qapi_free_SocketAddress(s->saddr);
+    qapi_free_SocketAddressFlat(s->saddr);
     g_free(s->export);
     g_free(s->tlscredsid);
 }
@@ -514,15 +556,15 @@ static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
     Visitor *ov;
     const char *host = NULL, *port = NULL, *path = NULL;
 
-    if (s->saddr->type == SOCKET_ADDRESS_KIND_INET) {
-        const InetSocketAddress *inet = s->saddr->u.inet.data;
+    if (s->saddr->type == SOCKET_ADDRESS_FLAT_TYPE_INET) {
+        const InetSocketAddress *inet = &s->saddr->u.inet;
         if (!inet->has_ipv4 && !inet->has_ipv6 && !inet->has_to) {
             host = inet->host;
             port = inet->port;
         }
-    } else if (s->saddr->type == SOCKET_ADDRESS_KIND_UNIX) {
-        path = s->saddr->u.q_unix.data->path;
-    }
+    } else if (s->saddr->type == SOCKET_ADDRESS_FLAT_TYPE_UNIX) {
+        path = s->saddr->u.q_unix.path;
+    } /* else can't represent as pseudo-filename */
 
     qdict_put(opts, "driver", qstring_from_str("nbd"));
 
@@ -541,7 +583,7 @@ static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
     }
 
     ov = qobject_output_visitor_new(&saddr_qdict);
-    visit_type_SocketAddress(ov, NULL, &s->saddr, &error_abort);
+    visit_type_SocketAddressFlat(ov, NULL, &s->saddr, &error_abort);
     visit_complete(ov, &saddr_qdict);
     visit_free(ov);
     qdict_put_obj(opts, "server", saddr_qdict);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 4e8e4e3..8d87962 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2762,7 +2762,7 @@
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsNbd',
-  'data': { 'server': 'SocketAddress',
+  'data': { 'server': 'SocketAddressFlat',
             '*export': 'str',
             '*tls-creds': 'str' } }
 
-- 
2.7.4
