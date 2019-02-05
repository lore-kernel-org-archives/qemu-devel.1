Received: from eggs.gnu.org ([209.51.188.92]:51097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqrrL-0000gQ-7Q
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 22:57:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqrrJ-0002on-Jr
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 22:57:18 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon,  4 Feb 2019 21:57:00 -0600
Message-Id: <20190205035704.26014-5-eblake@redhat.com>
In-Reply-To: <20190205035704.26014-1-eblake@redhat.com>
References: <20190205035704.26014-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/8] block/nbd: move connection code from
 block/nbd to block/nbd-client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Keep all connection code in one file, to be able to implement reconnect
in further patches.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20190201130138.94525-3-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: format tweak]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd-client.h |  2 +-
 block/nbd-client.c | 38 ++++++++++++++++++++++++++++++++++++--
 block/nbd.c        | 40 ++--------------------------------------
 3 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index cfc90550b99..2f047ba6142 100644
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
index fd58cda2f17..80dc8cff473 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -991,8 +991,29 @@ void nbd_client_close(BlockDriverState *bs)
     nbd_teardown_connection(bs);
 }

+static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
+                                                  Error **errp)
+{
+    QIOChannelSocket *sioc;
+    Error *local_err =3D NULL;
+
+    sioc =3D qio_channel_socket_new();
+    qio_channel_set_name(QIO_CHANNEL(sioc), "nbd-client");
+
+    qio_channel_socket_connect_sync(sioc, saddr, &local_err);
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
@@ -1002,6 +1023,16 @@ int nbd_client_init(BlockDriverState *bs,
     NBDClientSession *client =3D nbd_get_client_session(bs);
     int ret;

+    /*
+     * establish TCP connection, return error if it fails
+     * TODO: Configurable retry-until-timeout behaviour.
+     */
+    QIOChannelSocket *sioc =3D nbd_establish_connection(saddr, errp);
+
+    if (!sioc) {
+        return -ECONNREFUSED;
+    }
+
     /* NBD handshake */
     logout("session init %s\n", export);
     qio_channel_set_blocking(QIO_CHANNEL(sioc), true, NULL);
@@ -1017,6 +1048,7 @@ int nbd_client_init(BlockDriverState *bs,
     g_free(client->info.name);
     if (ret < 0) {
         logout("Failed to negotiate with the NBD server\n");
+        object_unref(OBJECT(sioc));
         return ret;
     }
     if (x_dirty_bitmap && !client->info.base_allocation) {
@@ -1042,7 +1074,6 @@ int nbd_client_init(BlockDriverState *bs,
     qemu_co_mutex_init(&client->send_mutex);
     qemu_co_queue_init(&client->free_sema);
     client->sioc =3D sioc;
-    object_ref(OBJECT(client->sioc));

     if (!client->ioc) {
         client->ioc =3D QIO_CHANNEL(sioc);
@@ -1068,6 +1099,9 @@ int nbd_client_init(BlockDriverState *bs,
         NBDRequest request =3D { .type =3D NBD_CMD_DISC };

         nbd_send_request(client->ioc ?: QIO_CHANNEL(sioc), &request);
+
+        object_unref(OBJECT(sioc));
+
         return ret;
     }
 }
diff --git a/block/nbd.c b/block/nbd.c
index e87699fb73b..9db5eded892 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -295,30 +295,6 @@ NBDClientSession *nbd_get_client_session(BlockDriver=
State *bs)
     return &s->client;
 }

-static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
-                                                  Error **errp)
-{
-    QIOChannelSocket *sioc;
-    Error *local_err =3D NULL;
-
-    sioc =3D qio_channel_socket_new();
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
@@ -394,7 +370,6 @@ static int nbd_open(BlockDriverState *bs, QDict *opti=
ons, int flags,
     BDRVNBDState *s =3D bs->opaque;
     QemuOpts *opts =3D NULL;
     Error *local_err =3D NULL;
-    QIOChannelSocket *sioc =3D NULL;
     QCryptoTLSCreds *tlscreds =3D NULL;
     const char *hostname =3D NULL;
     int ret =3D -EINVAL;
@@ -434,22 +409,11 @@ static int nbd_open(BlockDriverState *bs, QDict *op=
tions, int flags,
         hostname =3D s->saddr->u.inet.host;
     }

-    /* establish TCP connection, return error if it fails
-     * TODO: Configurable retry-until-timeout behaviour.
-     */
-    sioc =3D nbd_establish_connection(s->saddr, errp);
-    if (!sioc) {
-        ret =3D -ECONNREFUSED;
-        goto error;
-    }
-
     /* NBD handshake */
-    ret =3D nbd_client_init(bs, sioc, s->export, tlscreds, hostname,
+    ret =3D nbd_client_init(bs, s->saddr, s->export, tlscreds, hostname,
                           qemu_opt_get(opts, "x-dirty-bitmap"), errp);
+
  error:
-    if (sioc) {
-        object_unref(OBJECT(sioc));
-    }
     if (tlscreds) {
         object_unref(OBJECT(tlscreds));
     }
--=20
2.20.1
