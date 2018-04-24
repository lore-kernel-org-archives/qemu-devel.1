Received: from eggs.gnu.org ([2001:4830:134:3::10]:35574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fAxgL-0007gn-72
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 09:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fAxgG-0005Tb-1n
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 09:08:29 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 24 Apr 2018 16:08:20 +0300
Message-Id: <20180424130821.50987-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180424130821.50987-1-vsementsov@virtuozzo.com>
References: <20180424130821.50987-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [RFC 2/3] nbd: add .bdrv_reconnect handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, famz@redhat.com, pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Add handler, which reconnects to NBD server. For it:

 - separate connection code to nbd_reconnect()
 - store tlscreds and hostname in BDRVNBDState

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd.c | 60 ++++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 16 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 1e2b3ba2d3..371341dbcf 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -48,6 +48,10 @@ typedef struct BDRVNBDState {
     /* For nbd_refresh_filename() */
     SocketAddress *saddr;
     char *export, *tlscredsid;
+
+    /* For nbd_reconnect() */
+    QCryptoTLSCreds *tlscreds;
+    const char *hostname;
 } BDRVNBDState;
 
 static int nbd_parse_uri(const char *filename, QDict *options)
@@ -392,6 +396,33 @@ static QemuOptsList nbd_runtime_opts = {
     },
 };
 
+static int nbd_reconnect(BlockDriverState *bs, Error **errp)
+{
+    int ret;
+    BDRVNBDState *s = bs->opaque;
+    QIOChannelSocket *sioc;
+
+    /* close current connection if any */
+    nbd_client_close(bs);
+
+    memset(&s->client, 0, sizeof(s->client));
+    s->client.quit = true;
+
+    sioc = nbd_establish_connection(s->saddr, errp);
+    if (!sioc) {
+        return -ECONNREFUSED;
+    }
+
+    ret = nbd_client_init(bs, sioc, s->export, s->tlscreds, s->hostname, errp);
+    object_unref(OBJECT(sioc));
+    if (ret < 0) {
+        return ret;
+    }
+
+    s->client.quit = false;
+    return ret;
+}
+
 static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
                     Error **errp)
 {
@@ -399,8 +430,6 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
     QemuOpts *opts = NULL;
     Error *local_err = NULL;
     QIOChannelSocket *sioc = NULL;
-    QCryptoTLSCreds *tlscreds = NULL;
-    const char *hostname = NULL;
     int ret = -EINVAL;
 
     opts = qemu_opts_create(&nbd_runtime_opts, NULL, 0, &error_abort);
@@ -425,8 +454,8 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
 
     s->tlscredsid = g_strdup(qemu_opt_get(opts, "tls-creds"));
     if (s->tlscredsid) {
-        tlscreds = nbd_get_tls_creds(s->tlscredsid, errp);
-        if (!tlscreds) {
+        s->tlscreds = nbd_get_tls_creds(s->tlscredsid, errp);
+        if (!s->tlscreds) {
             goto error;
         }
 
@@ -435,29 +464,22 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
             error_setg(errp, "TLS only supported over IP sockets");
             goto error;
         }
-        hostname = s->saddr->u.inet.host;
+        s->hostname = s->saddr->u.inet.host;
     }
 
     /* establish TCP connection, return error if it fails
      * TODO: Configurable retry-until-timeout behaviour.
      */
-    sioc = nbd_establish_connection(s->saddr, errp);
-    if (!sioc) {
-        ret = -ECONNREFUSED;
-        goto error;
-    }
+    ret = nbd_reconnect(bs, errp);
 
-    /* NBD handshake */
-    ret = nbd_client_init(bs, sioc, s->export,
-                          tlscreds, hostname, errp);
  error:
     if (sioc) {
         object_unref(OBJECT(sioc));
     }
-    if (tlscreds) {
-        object_unref(OBJECT(tlscreds));
-    }
     if (ret < 0) {
+        if (s->tlscreds) {
+            object_unref(OBJECT(s->tlscreds));
+        }
         qapi_free_SocketAddress(s->saddr);
         g_free(s->export);
         g_free(s->tlscredsid);
@@ -494,6 +516,9 @@ static void nbd_close(BlockDriverState *bs)
 
     nbd_client_close(bs);
 
+    if (s->tlscreds) {
+        object_unref(OBJECT(s->tlscreds));
+    }
     qapi_free_SocketAddress(s->saddr);
     g_free(s->export);
     g_free(s->tlscredsid);
@@ -574,6 +599,7 @@ static BlockDriver bdrv_nbd = {
     .instance_size              = sizeof(BDRVNBDState),
     .bdrv_parse_filename        = nbd_parse_filename,
     .bdrv_file_open             = nbd_open,
+    .bdrv_reconnect             = nbd_reconnect,
     .bdrv_co_preadv             = nbd_client_co_preadv,
     .bdrv_co_pwritev            = nbd_client_co_pwritev,
     .bdrv_co_pwrite_zeroes      = nbd_client_co_pwrite_zeroes,
@@ -594,6 +620,7 @@ static BlockDriver bdrv_nbd_tcp = {
     .instance_size              = sizeof(BDRVNBDState),
     .bdrv_parse_filename        = nbd_parse_filename,
     .bdrv_file_open             = nbd_open,
+    .bdrv_reconnect             = nbd_reconnect,
     .bdrv_co_preadv             = nbd_client_co_preadv,
     .bdrv_co_pwritev            = nbd_client_co_pwritev,
     .bdrv_co_pwrite_zeroes      = nbd_client_co_pwrite_zeroes,
@@ -614,6 +641,7 @@ static BlockDriver bdrv_nbd_unix = {
     .instance_size              = sizeof(BDRVNBDState),
     .bdrv_parse_filename        = nbd_parse_filename,
     .bdrv_file_open             = nbd_open,
+    .bdrv_reconnect             = nbd_reconnect,
     .bdrv_co_preadv             = nbd_client_co_preadv,
     .bdrv_co_pwritev            = nbd_client_co_pwritev,
     .bdrv_co_pwrite_zeroes      = nbd_client_co_pwrite_zeroes,
-- 
2.11.1
