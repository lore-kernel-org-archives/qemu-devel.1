Received: from eggs.gnu.org ([2001:4830:134:3::10]:43066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHFA-0002fY-ES
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHF9-0002zS-40
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:44 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  7 Mar 2017 16:40:47 +0100
Message-Id: <1488901251-16214-24-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
References: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 23/27] qapi-schema: Rename GlusterServer to
 SocketAddressFlat
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

As its documentation says, it's not specific to Gluster.  Rename it,
as I'm going to use it for something else.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/gluster.c      | 38 +++++++++++++++++++-------------------
 qapi-schema.json     | 38 ++++++++++++++++++++++++++++++++++++++
 qapi/block-core.json | 46 +---------------------------------------------
 3 files changed, 58 insertions(+), 64 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index 991f18f..64b0217 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -321,7 +321,7 @@ static int parse_volume_options(BlockdevOptionsGluster *gconf, char *path)
 static int qemu_gluster_parse_uri(BlockdevOptionsGluster *gconf,
                                   const char *filename)
 {
-    GlusterServer *gsconf;
+    SocketAddressFlat *gsconf;
     URI *uri;
     QueryParams *qp = NULL;
     bool is_unix = false;
@@ -332,19 +332,19 @@ static int qemu_gluster_parse_uri(BlockdevOptionsGluster *gconf,
         return -EINVAL;
     }
 
-    gconf->server = g_new0(GlusterServerList, 1);
-    gconf->server->value = gsconf = g_new0(GlusterServer, 1);
+    gconf->server = g_new0(SocketAddressFlatList, 1);
+    gconf->server->value = gsconf = g_new0(SocketAddressFlat, 1);
 
     /* transport */
     if (!uri->scheme || !strcmp(uri->scheme, "gluster")) {
-        gsconf->type = GLUSTER_TRANSPORT_TCP;
+        gsconf->type = SOCKET_ADDRESS_FLAT_TYPE_TCP;
     } else if (!strcmp(uri->scheme, "gluster+tcp")) {
-        gsconf->type = GLUSTER_TRANSPORT_TCP;
+        gsconf->type = SOCKET_ADDRESS_FLAT_TYPE_TCP;
     } else if (!strcmp(uri->scheme, "gluster+unix")) {
-        gsconf->type = GLUSTER_TRANSPORT_UNIX;
+        gsconf->type = SOCKET_ADDRESS_FLAT_TYPE_UNIX;
         is_unix = true;
     } else if (!strcmp(uri->scheme, "gluster+rdma")) {
-        gsconf->type = GLUSTER_TRANSPORT_TCP;
+        gsconf->type = SOCKET_ADDRESS_FLAT_TYPE_TCP;
         error_report("Warning: rdma feature is not supported, falling "
                      "back to tcp");
     } else {
@@ -396,7 +396,7 @@ static struct glfs *qemu_gluster_glfs_init(BlockdevOptionsGluster *gconf,
     struct glfs *glfs;
     int ret;
     int old_errno;
-    GlusterServerList *server;
+    SocketAddressFlatList *server;
     unsigned long long port;
 
     glfs = glfs_find_preopened(gconf->volume);
@@ -412,7 +412,7 @@ static struct glfs *qemu_gluster_glfs_init(BlockdevOptionsGluster *gconf,
     glfs_set_preopened(gconf->volume, glfs);
 
     for (server = gconf->server; server; server = server->next) {
-        if (server->value->type  == GLUSTER_TRANSPORT_UNIX) {
+        if (server->value->type  == SOCKET_ADDRESS_FLAT_TYPE_UNIX) {
             ret = glfs_set_volfile_server(glfs, "unix",
                                    server->value->u.q_unix.path, 0);
         } else {
@@ -443,7 +443,7 @@ static struct glfs *qemu_gluster_glfs_init(BlockdevOptionsGluster *gconf,
         error_setg(errp, "Gluster connection for volume %s, path %s failed"
                          " to connect", gconf->volume, gconf->path);
         for (server = gconf->server; server; server = server->next) {
-            if (server->value->type  == GLUSTER_TRANSPORT_UNIX) {
+            if (server->value->type  == SOCKET_ADDRESS_FLAT_TYPE_UNIX) {
                 error_append_hint(errp, "hint: failed on socket %s ",
                                   server->value->u.q_unix.path);
             } else {
@@ -480,8 +480,8 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
                                   QDict *options, Error **errp)
 {
     QemuOpts *opts;
-    GlusterServer *gsconf = NULL;
-    GlusterServerList *curr = NULL;
+    SocketAddressFlat *gsconf = NULL;
+    SocketAddressFlatList *curr = NULL;
     QDict *backing_options = NULL;
     Error *local_err = NULL;
     char *str = NULL;
@@ -535,9 +535,9 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
             goto out;
 
         }
-        gsconf = g_new0(GlusterServer, 1);
-        gsconf->type = qapi_enum_parse(GlusterTransport_lookup, ptr,
-                                       GLUSTER_TRANSPORT__MAX, -1,
+        gsconf = g_new0(SocketAddressFlat, 1);
+        gsconf->type = qapi_enum_parse(SocketAddressFlatType_lookup, ptr,
+                                       SOCKET_ADDRESS_FLAT_TYPE__MAX, -1,
                                        &local_err);
         if (local_err) {
             error_append_hint(&local_err,
@@ -548,7 +548,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
         }
         qemu_opts_del(opts);
 
-        if (gsconf->type == GLUSTER_TRANSPORT_TCP) {
+        if (gsconf->type == SOCKET_ADDRESS_FLAT_TYPE_TCP) {
             /* create opts info from runtime_tcp_opts list */
             opts = qemu_opts_create(&runtime_tcp_opts, NULL, 0, &error_abort);
             qemu_opts_absorb_qdict(opts, backing_options, &local_err);
@@ -617,11 +617,11 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
         }
 
         if (gconf->server == NULL) {
-            gconf->server = g_new0(GlusterServerList, 1);
+            gconf->server = g_new0(SocketAddressFlatList, 1);
             gconf->server->value = gsconf;
             curr = gconf->server;
         } else {
-            curr->next = g_new0(GlusterServerList, 1);
+            curr->next = g_new0(SocketAddressFlatList, 1);
             curr->next->value = gsconf;
             curr = curr->next;
         }
@@ -637,7 +637,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
 
 out:
     error_propagate(errp, local_err);
-    qapi_free_GlusterServer(gsconf);
+    qapi_free_SocketAddressFlat(gsconf);
     qemu_opts_del(opts);
     g_free(str);
     QDECREF(backing_options);
diff --git a/qapi-schema.json b/qapi-schema.json
index 6febfa7..15a8f7d 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4101,6 +4101,44 @@
     'fd': 'String' } }
 
 ##
+# @SocketAddressFlatType:
+#
+# Available SocketAddressFlat types
+#
+# @tcp:   Internet address
+#
+# @unix:  Unix domain socket
+#
+# Since: 2.9
+##
+{ 'enum': 'SocketAddressFlatType',
+  'data': [ 'unix', 'tcp' ] }
+
+##
+# @SocketAddressFlat:
+#
+# Captures the address of a socket
+#
+# @type:       Transport type
+#
+# This is similar to SocketAddress, only distinction:
+#
+# 1. SocketAddressFlat is a flat union, SocketAddress is a simple union.
+#    A flat union is nicer than simple because it avoids nesting
+#    (i.e. more {}) on the wire.
+#
+# 2. SocketAddressFlat supports only types 'unix' and 'tcp', because
+#    that's what its current users need.
+#
+# Since: 2.9
+##
+{ 'union': 'SocketAddressFlat',
+  'base': { 'type': 'SocketAddressFlatType' },
+  'discriminator': 'type',
+  'data': { 'unix': 'UnixSocketAddress',
+            'tcp': 'InetSocketAddress' } }
+
+##
 # @getfd:
 #
 # Receive a file descriptor via SCM rights and assign it a name
diff --git a/qapi/block-core.json b/qapi/block-core.json
index bc0ccd6..d63be0a 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2546,50 +2546,6 @@
             '*read-pattern': 'QuorumReadPattern' } }
 
 ##
-# @GlusterTransport:
-#
-# An enumeration of Gluster transport types
-#
-# @tcp:   TCP   - Transmission Control Protocol
-#
-# @unix:  UNIX  - Unix domain socket
-#
-# Since: 2.7
-##
-{ 'enum': 'GlusterTransport',
-  'data': [ 'unix', 'tcp' ] }
-
-
-##
-# @GlusterServer:
-#
-# Captures the address of a socket
-#
-# Details for connecting to a gluster server
-#
-# @type:       Transport type used for gluster connection
-#
-# This is similar to SocketAddress, only distinction:
-#
-# 1. GlusterServer is a flat union, SocketAddress is a simple union.
-#    A flat union is nicer than simple because it avoids nesting
-#    (i.e. more {}) on the wire.
-#
-# 2. GlusterServer lacks case 'fd', since gluster doesn't let you
-#    pass in a file descriptor.
-#
-# GlusterServer is actually not Gluster-specific, its a
-# compatibility evolved into an alternate for SocketAddress.
-#
-# Since: 2.7
-##
-{ 'union': 'GlusterServer',
-  'base': { 'type': 'GlusterTransport' },
-  'discriminator': 'type',
-  'data': { 'unix': 'UnixSocketAddress',
-            'tcp': 'InetSocketAddress' } }
-
-##
 # @BlockdevOptionsGluster:
 #
 # Driver specific block device options for Gluster
@@ -2610,7 +2566,7 @@
 { 'struct': 'BlockdevOptionsGluster',
   'data': { 'volume': 'str',
             'path': 'str',
-            'server': ['GlusterServer'],
+            'server': ['SocketAddressFlat'],
             '*debug': 'int',
             '*logfile': 'str' } }
 
-- 
1.8.3.1
