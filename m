Received: from eggs.gnu.org ([209.51.188.92]:51209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqrrn-00015L-LG
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 22:57:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqrrg-0002zr-7g
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 22:57:44 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon,  4 Feb 2019 21:57:04 -0600
Message-Id: <20190205035704.26014-9-eblake@redhat.com>
In-Reply-To: <20190205035704.26014-1-eblake@redhat.com>
References: <20190205035704.26014-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 8/8] block/nbd-client: rename read_reply_co to
 connection_co
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

This coroutine will serve nbd reconnects, so, rename it to be something
more generic.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190201130138.94525-7-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd-client.h |  4 ++--
 block/nbd-client.c | 24 ++++++++++++------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index 2f047ba6142..d990207a5cb 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -20,7 +20,7 @@
 typedef struct {
     Coroutine *coroutine;
     uint64_t offset;        /* original offset of the request */
-    bool receiving;         /* waiting for read_reply_co? */
+    bool receiving;         /* waiting for connection_co? */
 } NBDClientRequest;

 typedef struct NBDClientSession {
@@ -30,7 +30,7 @@ typedef struct NBDClientSession {

     CoMutex send_mutex;
     CoQueue free_sema;
-    Coroutine *read_reply_co;
+    Coroutine *connection_co;
     int in_flight;

     NBDClientRequest requests[MAX_NBD_REQUESTS];
diff --git a/block/nbd-client.c b/block/nbd-client.c
index 386c3feb14f..f0ad54ce21d 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -59,7 +59,7 @@ static void nbd_teardown_connection(BlockDriverState *b=
s)
     qio_channel_shutdown(client->ioc,
                          QIO_CHANNEL_SHUTDOWN_BOTH,
                          NULL);
-    BDRV_POLL_WHILE(bs, client->read_reply_co);
+    BDRV_POLL_WHILE(bs, client->connection_co);

     nbd_client_detach_aio_context(bs);
     object_unref(OBJECT(client->sioc));
@@ -68,7 +68,7 @@ static void nbd_teardown_connection(BlockDriverState *b=
s)
     client->ioc =3D NULL;
 }

-static coroutine_fn void nbd_read_reply_entry(void *opaque)
+static coroutine_fn void nbd_connection_entry(void *opaque)
 {
     NBDClientSession *s =3D opaque;
     uint64_t i;
@@ -100,14 +100,14 @@ static coroutine_fn void nbd_read_reply_entry(void =
*opaque)
         }

         /* We're woken up again by the request itself.  Note that there
-         * is no race between yielding and reentering read_reply_co.  Th=
is
+         * is no race between yielding and reentering connection_co.  Th=
is
          * is because:
          *
          * - if the request runs on the same AioContext, it is only
          *   entered after we yield
          *
          * - if the request runs on a different AioContext, reentering
-         *   read_reply_co happens through a bottom half, which can only
+         *   connection_co happens through a bottom half, which can only
          *   run after we yield.
          */
         aio_co_wake(s->requests[i].coroutine);
@@ -116,7 +116,7 @@ static coroutine_fn void nbd_read_reply_entry(void *o=
paque)

     s->quit =3D true;
     nbd_recv_coroutines_wake_all(s);
-    s->read_reply_co =3D NULL;
+    s->connection_co =3D NULL;
     aio_wait_kick();
 }

@@ -420,7 +420,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
     }
     *request_ret =3D 0;

-    /* Wait until we're woken up by nbd_read_reply_entry.  */
+    /* Wait until we're woken up by nbd_connection_entry.  */
     s->requests[i].receiving =3D true;
     qemu_coroutine_yield();
     s->requests[i].receiving =3D false;
@@ -495,7 +495,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
 }

 /* nbd_co_receive_one_chunk
- * Read reply, wake up read_reply_co and set s->quit if needed.
+ * Read reply, wake up connection_co and set s->quit if needed.
  * Return value is a fatal error code or normal nbd reply error code
  */
 static coroutine_fn int nbd_co_receive_one_chunk(
@@ -509,15 +509,15 @@ static coroutine_fn int nbd_co_receive_one_chunk(
     if (ret < 0) {
         s->quit =3D true;
     } else {
-        /* For assert at loop start in nbd_read_reply_entry */
+        /* For assert at loop start in nbd_connection_entry */
         if (reply) {
             *reply =3D s->reply;
         }
         s->reply.handle =3D 0;
     }

-    if (s->read_reply_co) {
-        aio_co_wake(s->read_reply_co);
+    if (s->connection_co) {
+        aio_co_wake(s->connection_co);
     }

     return ret;
@@ -970,7 +970,7 @@ void nbd_client_attach_aio_context(BlockDriverState *=
bs,
 {
     NBDClientSession *client =3D nbd_get_client_session(bs);
     qio_channel_attach_aio_context(QIO_CHANNEL(client->ioc), new_context=
);
-    aio_co_schedule(new_context, client->read_reply_co);
+    aio_co_schedule(new_context, client->connection_co);
 }

 void nbd_client_close(BlockDriverState *bs)
@@ -1075,7 +1075,7 @@ static int nbd_client_connect(BlockDriverState *bs,
     /* Now that we're connected, set the socket to be non-blocking and
      * kick the reply mechanism.  */
     qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
-    client->read_reply_co =3D qemu_coroutine_create(nbd_read_reply_entry=
, client);
+    client->connection_co =3D qemu_coroutine_create(nbd_connection_entry=
, client);
     nbd_client_attach_aio_context(bs, bdrv_get_aio_context(bs));

     logout("Established connection with NBD server\n");
--=20
2.20.1
