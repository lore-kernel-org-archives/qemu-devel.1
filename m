Received: from eggs.gnu.org ([2001:4830:134:3::10]:35160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjYWH-0005Yr-Lm
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:44:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjYWG-0002s0-BO
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:44:17 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  2 Mar 2017 22:43:59 +0100
Message-Id: <1488491046-2549-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1488491046-2549-1-git-send-email-armbru@redhat.com>
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 08/15] sheepdog: Use SocketAddress and
 socket_connect()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com

sd_parse_uri() builds a string from host and port parts for
inet_connect().  inet_connect() parses it into host, port and options.
Whether this gets exactly the same host, port and no options for all
inputs is not obvious.

Cut out the string middleman and build a SocketAddress for
socket_connect() instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/sheepdog.c | 53 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index ac62225..43317b3 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -374,8 +374,7 @@ struct BDRVSheepdogState {
     uint32_t cache_flags;
     bool discard_supported;
 
-    char *host_spec;
-    bool is_unix;
+    SocketAddress *addr;
     int fd;
 
     CoMutex lock;
@@ -532,16 +531,12 @@ static int connect_to_sdog(BDRVSheepdogState *s, Error **errp)
 {
     int fd;
 
-    if (s->is_unix) {
-        fd = unix_connect(s->host_spec, errp);
-    } else {
-        fd = inet_connect(s->host_spec, errp);
+    fd = socket_connect(s->addr, errp, NULL, NULL);
 
-        if (fd >= 0) {
-            int ret = socket_set_nodelay(fd);
-            if (ret < 0) {
-                error_report("%s", strerror(errno));
-            }
+    if (s->addr->type == SOCKET_ADDRESS_KIND_INET && fd >= 0) {
+        int ret = socket_set_nodelay(fd);
+        if (ret < 0) {
+            error_report("%s", strerror(errno));
         }
     }
 
@@ -820,8 +815,7 @@ static void coroutine_fn aio_read_response(void *opaque)
     case AIOCB_DISCARD_OBJ:
         switch (rsp.result) {
         case SD_RES_INVALID_PARMS:
-            error_report("sheep(%s) doesn't support discard command",
-                         s->host_spec);
+            error_report("server doesn't support discard command");
             rsp.result = SD_RES_SUCCESS;
             s->discard_supported = false;
             break;
@@ -962,8 +956,10 @@ static void sd_parse_uri(BDRVSheepdogState *s, const char *filename,
                          Error **errp)
 {
     Error *err = NULL;
-    URI *uri;
     QueryParams *qp = NULL;
+    SocketAddress *addr = NULL;
+    bool is_unix;
+    URI *uri;
 
     uri = uri_parse(filename);
     if (!uri) {
@@ -973,11 +969,11 @@ static void sd_parse_uri(BDRVSheepdogState *s, const char *filename,
 
     /* transport */
     if (!strcmp(uri->scheme, "sheepdog")) {
-        s->is_unix = false;
+        is_unix = false;
     } else if (!strcmp(uri->scheme, "sheepdog+tcp")) {
-        s->is_unix = false;
+        is_unix = false;
     } else if (!strcmp(uri->scheme, "sheepdog+unix")) {
-        s->is_unix = true;
+        is_unix = true;
     } else {
         error_setg(&err, "URI scheme must be 'sheepdog', 'sheepdog+tcp',"
                    " or 'sheepdog+unix'");
@@ -994,8 +990,9 @@ static void sd_parse_uri(BDRVSheepdogState *s, const char *filename,
     }
 
     qp = query_params_parse(uri->query);
+    addr = g_new0(SocketAddress, 1);
 
-    if (s->is_unix) {
+    if (is_unix) {
         /* sheepdog+unix:///vdiname?socket=path */
         if (uri->server || uri->port) {
             error_setg(&err, "URI scheme %s doesn't accept a server address",
@@ -1012,15 +1009,20 @@ static void sd_parse_uri(BDRVSheepdogState *s, const char *filename,
             error_setg(&err, "unexpected query parameters");
             goto out;
         }
-        s->host_spec = g_strdup(qp->p[0].value);
+        addr->type = SOCKET_ADDRESS_KIND_UNIX;
+        addr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
+        addr->u.q_unix.data->path = g_strdup(qp->p[0].value);
     } else {
         /* sheepdog[+tcp]://[host:port]/vdiname */
         if (qp->n) {
             error_setg(&err, "unexpected query parameters");
             goto out;
         }
-        s->host_spec = g_strdup_printf("%s:%d", uri->server ?: SD_DEFAULT_ADDR,
-                                       uri->port ?: SD_DEFAULT_PORT);
+        addr->type = SOCKET_ADDRESS_KIND_INET;
+        addr->u.inet.data = g_new0(InetSocketAddress, 1);
+        addr->u.inet.data->host = g_strdup(uri->server ?: SD_DEFAULT_ADDR);
+        addr->u.inet.data->port = g_strdup_printf("%d",
+                                        uri->port ?: SD_DEFAULT_PORT);
     }
 
     /* snapshot tag */
@@ -1035,7 +1037,12 @@ static void sd_parse_uri(BDRVSheepdogState *s, const char *filename,
     }
 
 out:
-    error_propagate(errp, err);
+    if (err) {
+        error_propagate(errp, err);
+        qapi_free_SocketAddress(addr);
+    } else {
+        s->addr = addr;
+    }
     if (qp) {
         query_params_free(qp);
     }
@@ -1998,7 +2005,7 @@ static void sd_close(BlockDriverState *bs)
     aio_set_fd_handler(bdrv_get_aio_context(bs), s->fd,
                        false, NULL, NULL, NULL, NULL);
     closesocket(s->fd);
-    g_free(s->host_spec);
+    qapi_free_SocketAddress(s->addr);
 }
 
 static int64_t sd_getlength(BlockDriverState *bs)
-- 
2.7.4
