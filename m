Received: from eggs.gnu.org ([209.51.188.92]:48141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gtB82-0001x1-Oh
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 07:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gtB81-0007Rc-Rh
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 07:56:06 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 11 Feb 2019 15:56:01 +0300
Message-Id: <20190211125601.86533-5-vsementsov@virtuozzo.com>
In-Reply-To: <20190211125601.86533-1-vsementsov@virtuozzo.com>
References: <20190211125601.86533-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 4/4] block/nbd-client: use non-blocking io
 channel for nbd negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: berrange@redhat.com, mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Now negotiation is done in coroutine, so to take benefit of it let's
use non-blocking model.

Note that QIOChannel handle synchronous io calls correctly anyway, so
it's not a problem to send final NBD_CMD_DISC to non-blocking channel
but using sync qio interface, even not in coroutine.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index f0ad54ce21..79bc6b7e29 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -1029,7 +1029,7 @@ static int nbd_client_connect(BlockDriverState *bs,
 
     /* NBD handshake */
     logout("session init %s\n", export);
-    qio_channel_set_blocking(QIO_CHANNEL(sioc), true, NULL);
+    qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
 
     client->info.request_sizes = true;
     client->info.structured_reply = true;
@@ -1072,9 +1072,6 @@ static int nbd_client_connect(BlockDriverState *bs,
         object_ref(OBJECT(client->ioc));
     }
 
-    /* Now that we're connected, set the socket to be non-blocking and
-     * kick the reply mechanism.  */
-    qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
     client->connection_co = qemu_coroutine_create(nbd_connection_entry, client);
     nbd_client_attach_aio_context(bs, bdrv_get_aio_context(bs));
 
@@ -1083,9 +1080,8 @@ static int nbd_client_connect(BlockDriverState *bs,
 
  fail:
     /*
-     * We have connected, but must fail for other reasons. The
-     * connection is still blocking; send NBD_CMD_DISC as a courtesy
-     * to the server.
+     * We have connected, but must fail for other reasons.
+     * Send NBD_CMD_DISC as a courtesy to the server.
      */
     {
         NBDRequest request = { .type = NBD_CMD_DISC };
-- 
2.18.0
