Received: from eggs.gnu.org ([209.51.188.92]:51194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqrrk-000123-D9
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 22:57:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqrrU-0002w1-AJ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 22:57:34 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon,  4 Feb 2019 21:57:03 -0600
Message-Id: <20190205035704.26014-8-eblake@redhat.com>
In-Reply-To: <20190205035704.26014-1-eblake@redhat.com>
References: <20190205035704.26014-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 7/8] block/nbd-client: don't check ioc
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

We have several paranoid checks for ioc !=3D NULL. But ioc may become
NULL only on close, which should not happen during requests handling.
Also, we check ioc only sometimes, not after each yield, which is
inconsistent. Let's drop these checks. However, for safety, let's leave
asserts instead.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190201130138.94525-6-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd-client.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 65e56000681..386c3feb14f 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -53,9 +53,7 @@ static void nbd_teardown_connection(BlockDriverState *b=
s)
 {
     NBDClientSession *client =3D nbd_get_client_session(bs);

-    if (!client->ioc) { /* Already closed */
-        return;
-    }
+    assert(client->ioc);

     /* finish any pending coroutines */
     qio_channel_shutdown(client->ioc,
@@ -154,10 +152,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
         rc =3D -EIO;
         goto err;
     }
-    if (!s->ioc) {
-        rc =3D -EPIPE;
-        goto err;
-    }
+    assert(s->ioc);

     if (qiov) {
         qio_channel_set_cork(s->ioc, true);
@@ -429,10 +424,11 @@ static coroutine_fn int nbd_co_do_receive_one_chunk=
(
     s->requests[i].receiving =3D true;
     qemu_coroutine_yield();
     s->requests[i].receiving =3D false;
-    if (!s->ioc || s->quit) {
+    if (s->quit) {
         error_setg(errp, "Connection closed");
         return -EIO;
     }
+    assert(s->ioc);

     assert(s->reply.handle =3D=3D handle);

@@ -982,9 +978,7 @@ void nbd_client_close(BlockDriverState *bs)
     NBDClientSession *client =3D nbd_get_client_session(bs);
     NBDRequest request =3D { .type =3D NBD_CMD_DISC };

-    if (client->ioc =3D=3D NULL) {
-        return;
-    }
+    assert(client->ioc);

     nbd_send_request(client->ioc, &request);

--=20
2.20.1
