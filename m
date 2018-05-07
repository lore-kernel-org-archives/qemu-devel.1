Received: from eggs.gnu.org ([2001:4830:134:3::10]:44815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fFiK4-0006Ob-It
	for qemu-devel@nongnu.org; Mon, 07 May 2018 11:45:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fFiK0-0005ps-4I
	for qemu-devel@nongnu.org; Mon, 07 May 2018 11:45:08 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  7 May 2018 18:44:58 +0300
Message-Id: <20180507154458.73945-6-vsementsov@virtuozzo.com>
In-Reply-To: <20180507154458.73945-1-vsementsov@virtuozzo.com>
References: <20180507154458.73945-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 5/5] block/nbd-client: don't check ioc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

We have several paranoiac checks for ioc != NULL. But ioc may become
NULL only on close, which should not happen during requests handling.
Also, we check ioc only sometimes, not after each yield, which is
inconsistent. Let's drop these checks.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index dd712c59b3..87d90d9026 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -51,10 +51,6 @@ static void nbd_teardown_connection(BlockDriverState *bs)
 {
     NBDClientSession *client = nbd_get_client_session(bs);
 
-    if (!client->ioc) { /* Already closed */
-        return;
-    }
-
     /* finish any pending coroutines */
     qio_channel_shutdown(client->ioc,
                          QIO_CHANNEL_SHUTDOWN_BOTH,
@@ -150,10 +146,6 @@ static int nbd_co_send_request(BlockDriverState *bs,
         rc = -EIO;
         goto err;
     }
-    if (!s->ioc) {
-        rc = -EPIPE;
-        goto err;
-    }
 
     if (qiov) {
         qio_channel_set_cork(s->ioc, true);
@@ -426,7 +418,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
     s->requests[i].receiving = true;
     qemu_coroutine_yield();
     s->requests[i].receiving = false;
-    if (!s->ioc || s->quit) {
+    if (s->quit) {
         error_setg(errp, "Connection closed");
         return -EIO;
     }
@@ -967,10 +959,6 @@ void nbd_client_close(BlockDriverState *bs)
     NBDClientSession *client = nbd_get_client_session(bs);
     NBDRequest request = { .type = NBD_CMD_DISC };
 
-    if (client->ioc == NULL) {
-        return;
-    }
-
     nbd_send_request(client->ioc, &request);
 
     nbd_teardown_connection(bs);
-- 
2.11.1
