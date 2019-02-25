Received: from eggs.gnu.org ([209.51.188.92]:37347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI4o-0000I3-9y
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:21:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI4h-0000ud-5j
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:21:49 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Feb 2019 16:19:58 +0100
Message-Id: <20190225152053.15976-17-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-1-kwolf@redhat.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/71] nbd: Increase bs->in_flight during
 AioContext switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

bdrv_drain() must not leave connection_co scheduled, so bs->in_flight
needs to be increased while the coroutine is waiting to be scheduled
in the new AioContext after nbd_client_attach_aio_context().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/nbd-client.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 60f38f0320..bfbaf7ebe9 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -977,14 +977,30 @@ void nbd_client_detach_aio_context(BlockDriverState=
 *bs)
     qio_channel_detach_aio_context(QIO_CHANNEL(client->ioc));
 }
=20
+static void nbd_client_attach_aio_context_bh(void *opaque)
+{
+    BlockDriverState *bs =3D opaque;
+    NBDClientSession *client =3D nbd_get_client_session(bs);
+
+    /* The node is still drained, so we know the coroutine has yielded i=
n
+     * nbd_read_eof(), the only place where bs->in_flight can reach 0, o=
r it is
+     * entered for the first time. Both places are safe for entering the
+     * coroutine.*/
+    qemu_aio_coroutine_enter(bs->aio_context, client->connection_co);
+    bdrv_dec_in_flight(bs);
+}
+
 void nbd_client_attach_aio_context(BlockDriverState *bs,
                                    AioContext *new_context)
 {
     NBDClientSession *client =3D nbd_get_client_session(bs);
     qio_channel_attach_aio_context(QIO_CHANNEL(client->ioc), new_context=
);
=20
-    /* FIXME Really need a bdrv_inc_in_flight() here */
-    aio_co_schedule(new_context, client->connection_co);
+    bdrv_inc_in_flight(bs);
+
+    /* Need to wait here for the BH to run because the BH must run while=
 the
+     * node is still drained. */
+    aio_wait_bh_oneshot(new_context, nbd_client_attach_aio_context_bh, b=
s);
 }
=20
 void nbd_client_close(BlockDriverState *bs)
--=20
2.20.1
