Received: from eggs.gnu.org ([209.51.188.92]:38688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gpYSH-0007Wv-0e
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:02:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gpYS9-0002zT-SW
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:02:00 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  1 Feb 2019 16:01:37 +0300
Message-Id: <20190201130138.94525-6-vsementsov@virtuozzo.com>
In-Reply-To: <20190201130138.94525-1-vsementsov@virtuozzo.com>
References: <20190201130138.94525-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 5/6] block/nbd-client: don't check ioc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com

We have several paranoid checks for ioc != NULL. But ioc may become
NULL only on close, which should not happen during requests handling.
Also, we check ioc only sometimes, not after each yield, which is
inconsistent. Let's drop these checks. However, for safety, let's leave
asserts instead.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---

Notes:
    v5: fix commit message a bit [Eric]

 block/nbd-client.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 8e9b3dbedd..d8bf1bbb8b 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -53,9 +53,7 @@ static void nbd_teardown_connection(BlockDriverState *bs)
 {
     NBDClientSession *client = nbd_get_client_session(bs);
 
-    if (!client->ioc) { /* Already closed */
-        return;
-    }
+    assert(client->ioc);
 
     /* finish any pending coroutines */
     qio_channel_shutdown(client->ioc,
@@ -153,10 +151,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
         rc = -EIO;
         goto err;
     }
-    if (!s->ioc) {
-        rc = -EPIPE;
-        goto err;
-    }
+    assert(s->ioc);
 
     if (qiov) {
         qio_channel_set_cork(s->ioc, true);
@@ -429,10 +424,11 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
     s->requests[i].receiving = true;
     qemu_coroutine_yield();
     s->requests[i].receiving = false;
-    if (!s->ioc || s->quit) {
+    if (s->quit) {
         error_setg(errp, "Connection closed");
         return -EIO;
     }
+    assert(s->ioc);
 
     assert(s->reply.handle == handle);
 
@@ -982,9 +978,7 @@ void nbd_client_close(BlockDriverState *bs)
     NBDClientSession *client = nbd_get_client_session(bs);
     NBDRequest request = { .type = NBD_CMD_DISC };
 
-    if (client->ioc == NULL) {
-        return;
-    }
+    assert(client->ioc);
 
     nbd_send_request(client->ioc, &request);
 
-- 
2.18.0
