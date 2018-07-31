Received: from eggs.gnu.org ([2001:4830:134:3::10]:36935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fkYTs-0001Uh-Ah
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fkYTo-0004F3-5c
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:30:44 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 31 Jul 2018 20:30:25 +0300
Message-Id: <20180731173033.75467-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180731173033.75467-1-vsementsov@virtuozzo.com>
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 02/10] block/nbd: move connection code from
 block/nbd to block/nbd-client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Keep all connection code in one file, to be able to implement reconnect
in further patches.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.h |  2 +-
 block/nbd-client.c | 37 +++++++++++++++++++++++++++++++++++--
 block/nbd.c        | 40 ++--------------------------------------
 3 files changed, 38 insertions(+), 41 deletions(-)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index cfc90550b9..2f047ba614 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -41,7 +41,7 @@ typedef struct NBDClientSession {
 NBDClientSession *nbd_get_client_session(BlockDriverState *bs);
 
 int nbd_client_init(BlockDriverState *bs,
-                    QIOChannelSocket *sock,
+                    SocketAddress *saddr,
                     const char *export_name,
                     QCryptoTLSCreds *tlscreds,
                     const char *hostname,
diff --git a/block/nbd-client.c b/block/nbd-client.c
index 1efc3d36cc..a0d8f2523e 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -976,8 +976,31 @@ void nbd_client_close(BlockDriverState *bs)
     nbd_teardown_connection(bs);
 }
 
+static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
+                                                  Error **errp)
+{
+    QIOChannelSocket *sioc;
+    Error *local_err = NULL;
+
+    sioc = qio_channel_socket_new();
+    qio_channel_set_name(QIO_CHANNEL(sioc), "nbd-client");
+
+    qio_channel_socket_connect_sync(sioc,
+                                    saddr,
+                                    &local_err);
+    if (local_err) {
+        object_unref(OBJECT(sioc));
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+
+    qio_channel_set_delay(QIO_CHANNEL(sioc), false);
+
+    return sioc;
+}
+
 int nbd_client_init(BlockDriverState *bs,
-                    QIOChannelSocket *sioc,
+                    SocketAddress *saddr,
                     const char *export,
                     QCryptoTLSCreds *tlscreds,
                     const char *hostname,
@@ -987,6 +1010,15 @@ int nbd_client_init(BlockDriverState *bs,
     NBDClientSession *client = nbd_get_client_session(bs);
     int ret;
 
+    /* establish TCP connection, return error if it fails
+     * TODO: Configurable retry-until-timeout behaviour.
+     */
+    QIOChannelSocket *sioc = nbd_establish_connection(saddr, errp);
+
+    if (!sioc) {
+        return -ECONNREFUSED;
+    }
+
     /* NBD handshake */
     logout("session init %s\n", export);
     qio_channel_set_blocking(QIO_CHANNEL(sioc), true, NULL);
@@ -1001,12 +1033,14 @@ int nbd_client_init(BlockDriverState *bs,
     g_free(client->info.x_dirty_bitmap);
     if (ret < 0) {
         logout("Failed to negotiate with the NBD server\n");
+        object_unref(OBJECT(sioc));
         return ret;
     }
     if (client->info.flags & NBD_FLAG_READ_ONLY &&
         !bdrv_is_read_only(bs)) {
         error_setg(errp,
                    "request for write access conflicts with read-only export");
+        object_unref(OBJECT(sioc));
         return -EACCES;
     }
     if (client->info.flags & NBD_FLAG_SEND_FUA) {
@@ -1020,7 +1054,6 @@ int nbd_client_init(BlockDriverState *bs,
     qemu_co_mutex_init(&client->send_mutex);
     qemu_co_queue_init(&client->free_sema);
     client->sioc = sioc;
-    object_ref(OBJECT(client->sioc));
 
     if (!client->ioc) {
         client->ioc = QIO_CHANNEL(sioc);
diff --git a/block/nbd.c b/block/nbd.c
index e87699fb73..9db5eded89 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -295,30 +295,6 @@ NBDClientSession *nbd_get_client_session(BlockDriverState *bs)
     return &s->client;
 }
 
-static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
-                                                  Error **errp)
-{
-    QIOChannelSocket *sioc;
-    Error *local_err = NULL;
-
-    sioc = qio_channel_socket_new();
-    qio_channel_set_name(QIO_CHANNEL(sioc), "nbd-client");
-
-    qio_channel_socket_connect_sync(sioc,
-                                    saddr,
-                                    &local_err);
-    if (local_err) {
-        object_unref(OBJECT(sioc));
-        error_propagate(errp, local_err);
-        return NULL;
-    }
-
-    qio_channel_set_delay(QIO_CHANNEL(sioc), false);
-
-    return sioc;
-}
-
-
 static QCryptoTLSCreds *nbd_get_tls_creds(const char *id, Error **errp)
 {
     Object *obj;
@@ -394,7 +370,6 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
     BDRVNBDState *s = bs->opaque;
     QemuOpts *opts = NULL;
     Error *local_err = NULL;
-    QIOChannelSocket *sioc = NULL;
     QCryptoTLSCreds *tlscreds = NULL;
     const char *hostname = NULL;
     int ret = -EINVAL;
@@ -434,22 +409,11 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
         hostname = s->saddr->u.inet.host;
     }
 
-    /* establish TCP connection, return error if it fails
-     * TODO: Configurable retry-until-timeout behaviour.
-     */
-    sioc = nbd_establish_connection(s->saddr, errp);
-    if (!sioc) {
-        ret = -ECONNREFUSED;
-        goto error;
-    }
-
     /* NBD handshake */
-    ret = nbd_client_init(bs, sioc, s->export, tlscreds, hostname,
+    ret = nbd_client_init(bs, s->saddr, s->export, tlscreds, hostname,
                           qemu_opt_get(opts, "x-dirty-bitmap"), errp);
+
  error:
-    if (sioc) {
-        object_unref(OBJECT(sioc));
-    }
     if (tlscreds) {
         object_unref(OBJECT(tlscreds));
     }
-- 
2.11.1
