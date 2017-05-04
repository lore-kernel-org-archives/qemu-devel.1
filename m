Received: from eggs.gnu.org ([2001:4830:134:3::10]:56534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Ic7-0002BF-9w
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Ic0-0008Lb-Rl
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d6Ic0-0008J8-CK
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5335F80C31
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 15:24:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-149.ams2.redhat.com
	[10.36.116.149])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BFFD880DEC
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 15:24:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  4 May 2017 17:23:54 +0200
Message-Id: <1493911445-19568-18-git-send-email-armbru@redhat.com>
In-Reply-To: <1493911445-19568-1-git-send-email-armbru@redhat.com>
References: <1493911445-19568-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 17/28] sockets: Rename SocketAddressFlat to
 SocketAddress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1493192202-3184-6-git-send-email-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
---
 block/gluster.c        | 48 ++++++++++++++++++++++++------------------------
 block/nbd.c            | 26 +++++++++++++-------------
 block/sheepdog.c       |  6 +++---
 include/qemu/sockets.h |  4 ++--
 qapi-schema.json       | 14 +++++++-------
 qapi/block-core.json   |  6 +++---
 util/qemu-sockets.c    | 10 +++++-----
 7 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index cf29b5f..93eac87 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -321,7 +321,7 @@ static int parse_volume_options(BlockdevOptionsGluster *gconf, char *path)
 static int qemu_gluster_parse_uri(BlockdevOptionsGluster *gconf,
                                   const char *filename)
 {
-    SocketAddressFlat *gsconf;
+    SocketAddress *gsconf;
     URI *uri;
     QueryParams *qp = NULL;
     bool is_unix = false;
@@ -332,19 +332,19 @@ static int qemu_gluster_parse_uri(BlockdevOptionsGluster *gconf,
         return -EINVAL;
     }
 
-    gconf->server = g_new0(SocketAddressFlatList, 1);
-    gconf->server->value = gsconf = g_new0(SocketAddressFlat, 1);
+    gconf->server = g_new0(SocketAddressList, 1);
+    gconf->server->value = gsconf = g_new0(SocketAddress, 1);
 
     /* transport */
     if (!uri->scheme || !strcmp(uri->scheme, "gluster")) {
-        gsconf->type = SOCKET_ADDRESS_FLAT_TYPE_INET;
+        gsconf->type = SOCKET_ADDRESS_TYPE_INET;
     } else if (!strcmp(uri->scheme, "gluster+tcp")) {
-        gsconf->type = SOCKET_ADDRESS_FLAT_TYPE_INET;
+        gsconf->type = SOCKET_ADDRESS_TYPE_INET;
     } else if (!strcmp(uri->scheme, "gluster+unix")) {
-        gsconf->type = SOCKET_ADDRESS_FLAT_TYPE_UNIX;
+        gsconf->type = SOCKET_ADDRESS_TYPE_UNIX;
         is_unix = true;
     } else if (!strcmp(uri->scheme, "gluster+rdma")) {
-        gsconf->type = SOCKET_ADDRESS_FLAT_TYPE_INET;
+        gsconf->type = SOCKET_ADDRESS_TYPE_INET;
         error_report("Warning: rdma feature is not supported, falling "
                      "back to tcp");
     } else {
@@ -396,7 +396,7 @@ static struct glfs *qemu_gluster_glfs_init(BlockdevOptionsGluster *gconf,
     struct glfs *glfs;
     int ret;
     int old_errno;
-    SocketAddressFlatList *server;
+    SocketAddressList *server;
     unsigned long long port;
 
     glfs = glfs_find_preopened(gconf->volume);
@@ -413,11 +413,11 @@ static struct glfs *qemu_gluster_glfs_init(BlockdevOptionsGluster *gconf,
 
     for (server = gconf->server; server; server = server->next) {
         switch (server->value->type) {
-        case SOCKET_ADDRESS_FLAT_TYPE_UNIX:
+        case SOCKET_ADDRESS_TYPE_UNIX:
             ret = glfs_set_volfile_server(glfs, "unix",
                                    server->value->u.q_unix.path, 0);
             break;
-        case SOCKET_ADDRESS_FLAT_TYPE_INET:
+        case SOCKET_ADDRESS_TYPE_INET:
             if (parse_uint_full(server->value->u.inet.port, &port, 10) < 0 ||
                 port > 65535) {
                 error_setg(errp, "'%s' is not a valid port number",
@@ -429,8 +429,8 @@ static struct glfs *qemu_gluster_glfs_init(BlockdevOptionsGluster *gconf,
                                    server->value->u.inet.host,
                                    (int)port);
             break;
-        case SOCKET_ADDRESS_FLAT_TYPE_VSOCK:
-        case SOCKET_ADDRESS_FLAT_TYPE_FD:
+        case SOCKET_ADDRESS_TYPE_VSOCK:
+        case SOCKET_ADDRESS_TYPE_FD:
         default:
             abort();
         }
@@ -450,7 +450,7 @@ static struct glfs *qemu_gluster_glfs_init(BlockdevOptionsGluster *gconf,
         error_setg(errp, "Gluster connection for volume %s, path %s failed"
                          " to connect", gconf->volume, gconf->path);
         for (server = gconf->server; server; server = server->next) {
-            if (server->value->type  == SOCKET_ADDRESS_FLAT_TYPE_UNIX) {
+            if (server->value->type  == SOCKET_ADDRESS_TYPE_UNIX) {
                 error_append_hint(errp, "hint: failed on socket %s ",
                                   server->value->u.q_unix.path);
             } else {
@@ -487,8 +487,8 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
                                   QDict *options, Error **errp)
 {
     QemuOpts *opts;
-    SocketAddressFlat *gsconf = NULL;
-    SocketAddressFlatList *curr = NULL;
+    SocketAddress *gsconf = NULL;
+    SocketAddressList *curr = NULL;
     QDict *backing_options = NULL;
     Error *local_err = NULL;
     char *str = NULL;
@@ -542,14 +542,14 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
             goto out;
 
         }
-        gsconf = g_new0(SocketAddressFlat, 1);
+        gsconf = g_new0(SocketAddress, 1);
         if (!strcmp(ptr, "tcp")) {
             ptr = "inet";       /* accept legacy "tcp" */
         }
-        type = qapi_enum_parse(SocketAddressFlatType_lookup, ptr,
-                               SOCKET_ADDRESS_FLAT_TYPE__MAX, -1, NULL);
-        if (type != SOCKET_ADDRESS_FLAT_TYPE_INET
-            && type != SOCKET_ADDRESS_FLAT_TYPE_UNIX) {
+        type = qapi_enum_parse(SocketAddressType_lookup, ptr,
+                               SOCKET_ADDRESS_TYPE__MAX, -1, NULL);
+        if (type != SOCKET_ADDRESS_TYPE_INET
+            && type != SOCKET_ADDRESS_TYPE_UNIX) {
             error_setg(&local_err,
                        "Parameter '%s' may be 'inet' or 'unix'",
                        GLUSTER_OPT_TYPE);
@@ -559,7 +559,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
         gsconf->type = type;
         qemu_opts_del(opts);
 
-        if (gsconf->type == SOCKET_ADDRESS_FLAT_TYPE_INET) {
+        if (gsconf->type == SOCKET_ADDRESS_TYPE_INET) {
             /* create opts info from runtime_inet_opts list */
             opts = qemu_opts_create(&runtime_inet_opts, NULL, 0, &error_abort);
             qemu_opts_absorb_qdict(opts, backing_options, &local_err);
@@ -628,11 +628,11 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
         }
 
         if (gconf->server == NULL) {
-            gconf->server = g_new0(SocketAddressFlatList, 1);
+            gconf->server = g_new0(SocketAddressList, 1);
             gconf->server->value = gsconf;
             curr = gconf->server;
         } else {
-            curr->next = g_new0(SocketAddressFlatList, 1);
+            curr->next = g_new0(SocketAddressList, 1);
             curr->next->value = gsconf;
             curr = curr->next;
         }
@@ -648,7 +648,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
 
 out:
     error_propagate(errp, local_err);
-    qapi_free_SocketAddressFlat(gsconf);
+    qapi_free_SocketAddress(gsconf);
     qemu_opts_del(opts);
     g_free(str);
     QDECREF(backing_options);
diff --git a/block/nbd.c b/block/nbd.c
index 7f11a93..bbe0f99 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -47,7 +47,7 @@ typedef struct BDRVNBDState {
     NBDClientSession client;
 
     /* For nbd_refresh_filename() */
-    SocketAddressFlat *saddr;
+    SocketAddress *saddr;
     char *export, *tlscredsid;
 } BDRVNBDState;
 
@@ -258,10 +258,10 @@ static bool nbd_process_legacy_socket_options(QDict *output_options,
     return true;
 }
 
-static SocketAddressFlat *nbd_config(BDRVNBDState *s, QDict *options,
-                                     Error **errp)
+static SocketAddress *nbd_config(BDRVNBDState *s, QDict *options,
+                                 Error **errp)
 {
-    SocketAddressFlat *saddr = NULL;
+    SocketAddress *saddr = NULL;
     QDict *addr = NULL;
     QObject *crumpled_addr = NULL;
     Visitor *iv = NULL;
@@ -287,7 +287,7 @@ static SocketAddressFlat *nbd_config(BDRVNBDState *s, QDict *options,
      * visitor expects the former.
      */
     iv = qobject_input_visitor_new(crumpled_addr);
-    visit_type_SocketAddressFlat(iv, NULL, &saddr, &local_err);
+    visit_type_SocketAddress(iv, NULL, &saddr, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto done;
@@ -306,7 +306,7 @@ NBDClientSession *nbd_get_client_session(BlockDriverState *bs)
     return &s->client;
 }
 
-static QIOChannelSocket *nbd_establish_connection(SocketAddressFlat *saddr_flat,
+static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr_flat,
                                                   Error **errp)
 {
     SocketAddressLegacy *saddr = socket_address_crumple(saddr_flat);
@@ -412,7 +412,7 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
         goto error;
     }
 
-    /* Translate @host, @port, and @path to a SocketAddressFlat */
+    /* Translate @host, @port, and @path to a SocketAddress */
     if (!nbd_process_legacy_socket_options(options, opts, errp)) {
         goto error;
     }
@@ -433,7 +433,7 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
         }
 
         /* TODO SOCKET_ADDRESS_KIND_FD where fd has AF_INET or AF_INET6 */
-        if (s->saddr->type != SOCKET_ADDRESS_FLAT_TYPE_INET) {
+        if (s->saddr->type != SOCKET_ADDRESS_TYPE_INET) {
             error_setg(errp, "TLS only supported over IP sockets");
             goto error;
         }
@@ -460,7 +460,7 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
         object_unref(OBJECT(tlscreds));
     }
     if (ret < 0) {
-        qapi_free_SocketAddressFlat(s->saddr);
+        qapi_free_SocketAddress(s->saddr);
         g_free(s->export);
         g_free(s->tlscredsid);
     }
@@ -486,7 +486,7 @@ static void nbd_close(BlockDriverState *bs)
 
     nbd_client_close(bs);
 
-    qapi_free_SocketAddressFlat(s->saddr);
+    qapi_free_SocketAddress(s->saddr);
     g_free(s->export);
     g_free(s->tlscredsid);
 }
@@ -517,13 +517,13 @@ static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
     Visitor *ov;
     const char *host = NULL, *port = NULL, *path = NULL;
 
-    if (s->saddr->type == SOCKET_ADDRESS_FLAT_TYPE_INET) {
+    if (s->saddr->type == SOCKET_ADDRESS_TYPE_INET) {
         const InetSocketAddress *inet = &s->saddr->u.inet;
         if (!inet->has_ipv4 && !inet->has_ipv6 && !inet->has_to) {
             host = inet->host;
             port = inet->port;
         }
-    } else if (s->saddr->type == SOCKET_ADDRESS_FLAT_TYPE_UNIX) {
+    } else if (s->saddr->type == SOCKET_ADDRESS_TYPE_UNIX) {
         path = s->saddr->u.q_unix.path;
     } /* else can't represent as pseudo-filename */
 
@@ -544,7 +544,7 @@ static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
     }
 
     ov = qobject_output_visitor_new(&saddr_qdict);
-    visit_type_SocketAddressFlat(ov, NULL, &s->saddr, &error_abort);
+    visit_type_SocketAddress(ov, NULL, &s->saddr, &error_abort);
     visit_complete(ov, &saddr_qdict);
     visit_free(ov);
     qdict_put_obj(opts, "server", saddr_qdict);
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 7ee2e6e..547239a 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -554,7 +554,7 @@ static SocketAddressLegacy *sd_server_config(QDict *options, Error **errp)
     QDict *server = NULL;
     QObject *crumpled_server = NULL;
     Visitor *iv = NULL;
-    SocketAddressFlat *saddr_flat = NULL;
+    SocketAddress *saddr_flat = NULL;
     SocketAddressLegacy *saddr = NULL;
     Error *local_err = NULL;
 
@@ -574,7 +574,7 @@ static SocketAddressLegacy *sd_server_config(QDict *options, Error **errp)
      * visitor expects the former.
      */
     iv = qobject_input_visitor_new(crumpled_server);
-    visit_type_SocketAddressFlat(iv, NULL, &saddr_flat, &local_err);
+    visit_type_SocketAddress(iv, NULL, &saddr_flat, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto done;
@@ -583,7 +583,7 @@ static SocketAddressLegacy *sd_server_config(QDict *options, Error **errp)
     saddr = socket_address_crumple(saddr_flat);
 
 done:
-    qapi_free_SocketAddressFlat(saddr_flat);
+    qapi_free_SocketAddress(saddr_flat);
     visit_free(iv);
     qobject_decref(crumpled_server);
     QDECREF(server);
diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index f4a4b10..82b7460 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -124,11 +124,11 @@ char *socket_address_to_string(struct SocketAddressLegacy *addr, Error **errp);
  * socket_address_crumple:
  * @addr_flat: the socket address to crumple
  *
- * Convert SocketAddressFlat to SocketAddressLegacy.  Caller is responsible
+ * Convert SocketAddress to SocketAddressLegacy.  Caller is responsible
  * for freeing with qapi_free_SocketAddressLegacy().
  *
  * Returns: the argument converted to SocketAddressLegacy.
  */
-SocketAddressLegacy *socket_address_crumple(SocketAddressFlat *addr_flat);
+SocketAddressLegacy *socket_address_crumple(SocketAddress *addr);
 
 #endif /* QEMU_SOCKETS_H */
diff --git a/qapi-schema.json b/qapi-schema.json
index b5a042b..a741fdd 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4126,7 +4126,7 @@
 #
 # Captures the address of a socket, which could also be a named file descriptor
 #
-# Note: This type is deprecated in favor of SocketAddressFlat.
+# Note: This type is deprecated in favor of SocketAddress.
 #
 # Since: 1.3
 ##
@@ -4138,9 +4138,9 @@
     'fd': 'String' } }
 
 ##
-# @SocketAddressFlatType:
+# @SocketAddressType:
 #
-# Available SocketAddressFlat types
+# Available SocketAddress types
 #
 # @inet:  Internet address
 #
@@ -4148,11 +4148,11 @@
 #
 # Since: 2.9
 ##
-{ 'enum': 'SocketAddressFlatType',
+{ 'enum': 'SocketAddressType',
   'data': [ 'inet', 'unix', 'vsock', 'fd' ] }
 
 ##
-# @SocketAddressFlat:
+# @SocketAddress:
 #
 # Captures the address of a socket
 #
@@ -4164,8 +4164,8 @@
 #
 # Since: 2.9
 ##
-{ 'union': 'SocketAddressFlat',
-  'base': { 'type': 'SocketAddressFlatType' },
+{ 'union': 'SocketAddress',
+  'base': { 'type': 'SocketAddressType' },
   'discriminator': 'type',
   'data': { 'inet': 'InetSocketAddress',
             'unix': 'UnixSocketAddress',
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 87fb747..614181b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2522,7 +2522,7 @@
 { 'struct': 'BlockdevOptionsGluster',
   'data': { 'volume': 'str',
             'path': 'str',
-            'server': ['SocketAddressFlat'],
+            'server': ['SocketAddress'],
             '*debug': 'int',
             '*logfile': 'str' } }
 
@@ -2634,7 +2634,7 @@
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsSheepdog',
-  'data': { 'server': 'SocketAddressFlat',
+  'data': { 'server': 'SocketAddress',
             'vdi': 'str',
             '*snap-id': 'uint32',
             '*tag': 'str' } }
@@ -2849,7 +2849,7 @@
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsNbd',
-  'data': { 'server': 'SocketAddressFlat',
+  'data': { 'server': 'SocketAddress',
             '*export': 'str',
             '*tls-creds': 'str' } }
 
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 4c48203..801aa7a 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1341,27 +1341,27 @@ char *socket_address_to_string(struct SocketAddressLegacy *addr, Error **errp)
     return buf;
 }
 
-SocketAddressLegacy *socket_address_crumple(SocketAddressFlat *addr_flat)
+SocketAddressLegacy *socket_address_crumple(SocketAddress *addr_flat)
 {
     SocketAddressLegacy *addr = g_new(SocketAddressLegacy, 1);
 
     switch (addr_flat->type) {
-    case SOCKET_ADDRESS_FLAT_TYPE_INET:
+    case SOCKET_ADDRESS_TYPE_INET:
         addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
         addr->u.inet.data = QAPI_CLONE(InetSocketAddress,
                                        &addr_flat->u.inet);
         break;
-    case SOCKET_ADDRESS_FLAT_TYPE_UNIX:
+    case SOCKET_ADDRESS_TYPE_UNIX:
         addr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
         addr->u.q_unix.data = QAPI_CLONE(UnixSocketAddress,
                                          &addr_flat->u.q_unix);
         break;
-    case SOCKET_ADDRESS_FLAT_TYPE_VSOCK:
+    case SOCKET_ADDRESS_TYPE_VSOCK:
         addr->type = SOCKET_ADDRESS_LEGACY_KIND_VSOCK;
         addr->u.vsock.data = QAPI_CLONE(VsockSocketAddress,
                                         &addr_flat->u.vsock);
         break;
-    case SOCKET_ADDRESS_FLAT_TYPE_FD:
+    case SOCKET_ADDRESS_TYPE_FD:
         addr->type = SOCKET_ADDRESS_LEGACY_KIND_FD;
         addr->u.fd.data = QAPI_CLONE(String, &addr_flat->u.fd);
         break;
-- 
2.7.4
