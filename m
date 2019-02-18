Received: from eggs.gnu.org ([209.51.188.92]:34854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gvldQ-0006K8-N8
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:19:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gvldP-0002QK-Ca
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:19:12 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Feb 2019 17:18:13 +0100
Message-Id: <20190218161822.3573-4-kwolf@redhat.com>
In-Reply-To: <20190218161822.3573-1-kwolf@redhat.com>
References: <20190218161822.3573-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/12] nbd: Restrict connection_co reentrance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, stefanha@redhat.com, berrange@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

nbd_client_attach_aio_context() schedules connection_co in the new
AioContext and this way reenters it in any arbitrary place that has
yielded. We can restrict this a bit to the function call where the
coroutine actually sits waiting when it's idle.

This doesn't solve any bug yet, but it shows where in the code we need
to support this random reentrance and where we don't have to care.

Add FIXME comments for the existing bugs that the rest of this series
will fix.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/nbd-client.h |  1 +
 block/nbd-client.c | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index d990207a5c..09e03013d2 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -35,6 +35,7 @@ typedef struct NBDClientSession {
=20
     NBDClientRequest requests[MAX_NBD_REQUESTS];
     NBDReply reply;
+    BlockDriverState *bs;
     bool quit;
 } NBDClientSession;
=20
diff --git a/block/nbd-client.c b/block/nbd-client.c
index f0ad54ce21..e776785325 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -76,8 +76,24 @@ static coroutine_fn void nbd_connection_entry(void *op=
aque)
     Error *local_err =3D NULL;
=20
     while (!s->quit) {
+        /*
+         * The NBD client can only really be considered idle when it has
+         * yielded from qio_channel_readv_all_eof(), waiting for data. T=
his is
+         * the point where the additional scheduled coroutine entry happ=
ens
+         * after nbd_client_attach_aio_context().
+         *
+         * Therefore we keep an additional in_flight reference all the t=
ime and
+         * only drop it temporarily here.
+         *
+         * FIXME This is not safe because the QIOChannel could wake up t=
he
+         * coroutine for a second time; it is not prepared for coroutine
+         * resumption from external code.
+         */
+        bdrv_dec_in_flight(s->bs);
         assert(s->reply.handle =3D=3D 0);
         ret =3D nbd_receive_reply(s->ioc, &s->reply, &local_err);
+        bdrv_inc_in_flight(s->bs);
+
         if (local_err) {
             trace_nbd_read_reply_entry_fail(ret, error_get_pretty(local_=
err));
             error_free(local_err);
@@ -116,6 +132,8 @@ static coroutine_fn void nbd_connection_entry(void *o=
paque)
=20
     s->quit =3D true;
     nbd_recv_coroutines_wake_all(s);
+    bdrv_dec_in_flight(s->bs);
+
     s->connection_co =3D NULL;
     aio_wait_kick();
 }
@@ -970,6 +988,9 @@ void nbd_client_attach_aio_context(BlockDriverState *=
bs,
 {
     NBDClientSession *client =3D nbd_get_client_session(bs);
     qio_channel_attach_aio_context(QIO_CHANNEL(client->ioc), new_context=
);
+
+    /* FIXME Really need a bdrv_inc_in_flight() here, but the correspond=
ing
+     * bdrv_dec_in_flight() would have to be in QIOChannel code :-/ */
     aio_co_schedule(new_context, client->connection_co);
 }
=20
@@ -1076,6 +1097,7 @@ static int nbd_client_connect(BlockDriverState *bs,
      * kick the reply mechanism.  */
     qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
     client->connection_co =3D qemu_coroutine_create(nbd_connection_entry=
, client);
+    bdrv_inc_in_flight(bs);
     nbd_client_attach_aio_context(bs, bdrv_get_aio_context(bs));
=20
     logout("Established connection with NBD server\n");
@@ -1108,6 +1130,7 @@ int nbd_client_init(BlockDriverState *bs,
 {
     NBDClientSession *client =3D nbd_get_client_session(bs);
=20
+    client->bs =3D bs;
     qemu_co_mutex_init(&client->send_mutex);
     qemu_co_queue_init(&client->free_sema);
=20
--=20
2.20.1
