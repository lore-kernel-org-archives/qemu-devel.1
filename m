Received: from eggs.gnu.org ([2001:4830:134:3::10]:43074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHFA-0002gC-SB
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHF9-0002ze-AU
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:44 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  7 Mar 2017 16:40:48 +0100
Message-Id: <1488901251-16214-25-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
References: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 24/27] qapi-schema: Rename SocketAddressFlat's
 variant tcp to inet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Markus Armbruster <armbru@redhat.com>

QAPI type SocketAddressFlat differs from SocketAddress pointlessly:
the discriminator value for variant InetSocketAddress is 'tcp' instead
of 'inet'.  Rename.

The type is so far only used by the Gluster block drivers.  Take care
to keep 'tcp' working in things like -drive's file.server.0.type=tcp.
The "gluster+tcp" URI scheme in pseudo-filenames stays the same.
blockdev-add changes, but it has changed incompatibly since 2.8
already.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/gluster.c  | 59 +++++++++++++++++++++++++++++---------------------------
 qapi-schema.json |  8 ++++----
 2 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index 64b0217..a577dae 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -152,7 +152,7 @@ static QemuOptsList runtime_type_opts = {
         {
             .name = GLUSTER_OPT_TYPE,
             .type = QEMU_OPT_STRING,
-            .help = "tcp|unix",
+            .help = "inet|unix",
         },
         { /* end of list */ }
     },
@@ -171,14 +171,14 @@ static QemuOptsList runtime_unix_opts = {
     },
 };
 
-static QemuOptsList runtime_tcp_opts = {
-    .name = "gluster_tcp",
-    .head = QTAILQ_HEAD_INITIALIZER(runtime_tcp_opts.head),
+static QemuOptsList runtime_inet_opts = {
+    .name = "gluster_inet",
+    .head = QTAILQ_HEAD_INITIALIZER(runtime_inet_opts.head),
     .desc = {
         {
             .name = GLUSTER_OPT_TYPE,
             .type = QEMU_OPT_STRING,
-            .help = "tcp|unix",
+            .help = "inet|unix",
         },
         {
             .name = GLUSTER_OPT_HOST,
@@ -337,14 +337,14 @@ static int qemu_gluster_parse_uri(BlockdevOptionsGluster *gconf,
 
     /* transport */
     if (!uri->scheme || !strcmp(uri->scheme, "gluster")) {
-        gsconf->type = SOCKET_ADDRESS_FLAT_TYPE_TCP;
+        gsconf->type = SOCKET_ADDRESS_FLAT_TYPE_INET;
     } else if (!strcmp(uri->scheme, "gluster+tcp")) {
-        gsconf->type = SOCKET_ADDRESS_FLAT_TYPE_TCP;
+        gsconf->type = SOCKET_ADDRESS_FLAT_TYPE_INET;
     } else if (!strcmp(uri->scheme, "gluster+unix")) {
         gsconf->type = SOCKET_ADDRESS_FLAT_TYPE_UNIX;
         is_unix = true;
     } else if (!strcmp(uri->scheme, "gluster+rdma")) {
-        gsconf->type = SOCKET_ADDRESS_FLAT_TYPE_TCP;
+        gsconf->type = SOCKET_ADDRESS_FLAT_TYPE_INET;
         error_report("Warning: rdma feature is not supported, falling "
                      "back to tcp");
     } else {
@@ -374,11 +374,11 @@ static int qemu_gluster_parse_uri(BlockdevOptionsGluster *gconf,
         }
         gsconf->u.q_unix.path = g_strdup(qp->p[0].value);
     } else {
-        gsconf->u.tcp.host = g_strdup(uri->server ? uri->server : "localhost");
+        gsconf->u.inet.host = g_strdup(uri->server ? uri->server : "localhost");
         if (uri->port) {
-            gsconf->u.tcp.port = g_strdup_printf("%d", uri->port);
+            gsconf->u.inet.port = g_strdup_printf("%d", uri->port);
         } else {
-            gsconf->u.tcp.port = g_strdup_printf("%d", GLUSTER_DEFAULT_PORT);
+            gsconf->u.inet.port = g_strdup_printf("%d", GLUSTER_DEFAULT_PORT);
         }
     }
 
@@ -416,15 +416,15 @@ static struct glfs *qemu_gluster_glfs_init(BlockdevOptionsGluster *gconf,
             ret = glfs_set_volfile_server(glfs, "unix",
                                    server->value->u.q_unix.path, 0);
         } else {
-            if (parse_uint_full(server->value->u.tcp.port, &port, 10) < 0 ||
+            if (parse_uint_full(server->value->u.inet.port, &port, 10) < 0 ||
                 port > 65535) {
                 error_setg(errp, "'%s' is not a valid port number",
-                           server->value->u.tcp.port);
+                           server->value->u.inet.port);
                 errno = EINVAL;
                 goto out;
             }
             ret = glfs_set_volfile_server(glfs, "tcp",
-                                   server->value->u.tcp.host,
+                                   server->value->u.inet.host,
                                    (int)port);
         }
 
@@ -448,8 +448,8 @@ static struct glfs *qemu_gluster_glfs_init(BlockdevOptionsGluster *gconf,
                                   server->value->u.q_unix.path);
             } else {
                 error_append_hint(errp, "hint: failed on host %s and port %s ",
-                                  server->value->u.tcp.host,
-                                  server->value->u.tcp.port);
+                                  server->value->u.inet.host,
+                                  server->value->u.inet.port);
             }
         }
 
@@ -536,21 +536,24 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
 
         }
         gsconf = g_new0(SocketAddressFlat, 1);
+        if (!strcmp(ptr, "tcp")) {
+            ptr = "inet";       /* accept legacy "tcp" */
+        }
         gsconf->type = qapi_enum_parse(SocketAddressFlatType_lookup, ptr,
                                        SOCKET_ADDRESS_FLAT_TYPE__MAX, -1,
                                        &local_err);
         if (local_err) {
             error_append_hint(&local_err,
-                              "Parameter '%s' may be 'tcp' or 'unix'\n",
+                              "Parameter '%s' may be 'inet' or 'unix'\n",
                               GLUSTER_OPT_TYPE);
             error_append_hint(&local_err, GERR_INDEX_HINT, i);
             goto out;
         }
         qemu_opts_del(opts);
 
-        if (gsconf->type == SOCKET_ADDRESS_FLAT_TYPE_TCP) {
-            /* create opts info from runtime_tcp_opts list */
-            opts = qemu_opts_create(&runtime_tcp_opts, NULL, 0, &error_abort);
+        if (gsconf->type == SOCKET_ADDRESS_FLAT_TYPE_INET) {
+            /* create opts info from runtime_inet_opts list */
+            opts = qemu_opts_create(&runtime_inet_opts, NULL, 0, &error_abort);
             qemu_opts_absorb_qdict(opts, backing_options, &local_err);
             if (local_err) {
                 goto out;
@@ -563,7 +566,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
                 error_append_hint(&local_err, GERR_INDEX_HINT, i);
                 goto out;
             }
-            gsconf->u.tcp.host = g_strdup(ptr);
+            gsconf->u.inet.host = g_strdup(ptr);
             ptr = qemu_opt_get(opts, GLUSTER_OPT_PORT);
             if (!ptr) {
                 error_setg(&local_err, QERR_MISSING_PARAMETER,
@@ -571,28 +574,28 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
                 error_append_hint(&local_err, GERR_INDEX_HINT, i);
                 goto out;
             }
-            gsconf->u.tcp.port = g_strdup(ptr);
+            gsconf->u.inet.port = g_strdup(ptr);
 
             /* defend for unsupported fields in InetSocketAddress,
              * i.e. @ipv4, @ipv6  and @to
              */
             ptr = qemu_opt_get(opts, GLUSTER_OPT_TO);
             if (ptr) {
-                gsconf->u.tcp.has_to = true;
+                gsconf->u.inet.has_to = true;
             }
             ptr = qemu_opt_get(opts, GLUSTER_OPT_IPV4);
             if (ptr) {
-                gsconf->u.tcp.has_ipv4 = true;
+                gsconf->u.inet.has_ipv4 = true;
             }
             ptr = qemu_opt_get(opts, GLUSTER_OPT_IPV6);
             if (ptr) {
-                gsconf->u.tcp.has_ipv6 = true;
+                gsconf->u.inet.has_ipv6 = true;
             }
-            if (gsconf->u.tcp.has_to) {
+            if (gsconf->u.inet.has_to) {
                 error_setg(&local_err, "Parameter 'to' not supported");
                 goto out;
             }
-            if (gsconf->u.tcp.has_ipv4 || gsconf->u.tcp.has_ipv6) {
+            if (gsconf->u.inet.has_ipv4 || gsconf->u.inet.has_ipv6) {
                 error_setg(&local_err, "Parameters 'ipv4/ipv6' not supported");
                 goto out;
             }
@@ -669,7 +672,7 @@ static struct glfs *qemu_gluster_init(BlockdevOptionsGluster *gconf,
                              "file.volume=testvol,file.path=/path/a.qcow2"
                              "[,file.debug=9]"
                              "[,file.logfile=/path/filename.log],"
-                             "file.server.0.type=tcp,"
+                             "file.server.0.type=inet,"
                              "file.server.0.host=1.2.3.4,"
                              "file.server.0.port=24007,"
                              "file.server.1.transport=unix,"
diff --git a/qapi-schema.json b/qapi-schema.json
index 15a8f7d..32b4a4b 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4105,14 +4105,14 @@
 #
 # Available SocketAddressFlat types
 #
-# @tcp:   Internet address
+# @inet:  Internet address
 #
 # @unix:  Unix domain socket
 #
 # Since: 2.9
 ##
 { 'enum': 'SocketAddressFlatType',
-  'data': [ 'unix', 'tcp' ] }
+  'data': [ 'unix', 'inet' ] }
 
 ##
 # @SocketAddressFlat:
@@ -4127,7 +4127,7 @@
 #    A flat union is nicer than simple because it avoids nesting
 #    (i.e. more {}) on the wire.
 #
-# 2. SocketAddressFlat supports only types 'unix' and 'tcp', because
+# 2. SocketAddressFlat supports only types 'unix' and 'inet', because
 #    that's what its current users need.
 #
 # Since: 2.9
@@ -4136,7 +4136,7 @@
   'base': { 'type': 'SocketAddressFlatType' },
   'discriminator': 'type',
   'data': { 'unix': 'UnixSocketAddress',
-            'tcp': 'InetSocketAddress' } }
+            'inet': 'InetSocketAddress' } }
 
 ##
 # @getfd:
-- 
1.8.3.1
