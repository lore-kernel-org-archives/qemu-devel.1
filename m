Received: from eggs.gnu.org ([2001:4830:134:3::10]:36937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fkYTs-0001Uj-BJ
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fkYTo-0004FB-5P
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:30:44 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 31 Jul 2018 20:30:28 +0300
Message-Id: <20180731173033.75467-6-vsementsov@virtuozzo.com>
In-Reply-To: <20180731173033.75467-1-vsementsov@virtuozzo.com>
References: <20180731173033.75467-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 05/10] block/nbd-client: don't check ioc
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

We have several paranoiac checks for ioc != NULL. But ioc may become
NULL only on close, which should not happen during requests handling.
Also, we check ioc only sometimes, not after each yield, which is
inconsistent. Let's drop these checks. However, for safety, lets leave
asserts instead.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 263d1721f9..7eaf0149f0 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -51,9 +51,7 @@ static void nbd_teardown_connection(BlockDriverState *bs)
 {
     NBDClientSession *client = nbd_get_client_session(bs);
 
-    if (!client->ioc) { /* Already closed */
-        return;
-    }
+    assert(client->ioc);
 
     /* finish any pending coroutines */
     qio_channel_shutdown(client->ioc,
@@ -150,10 +148,7 @@ static int nbd_co_send_request(BlockDriverState *bs,
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
@@ -426,10 +421,11 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
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
 
@@ -967,9 +963,7 @@ void nbd_client_close(BlockDriverState *bs)
     NBDClientSession *client = nbd_get_client_session(bs);
     NBDRequest request = { .type = NBD_CMD_DISC };
 
-    if (client->ioc == NULL) {
-        return;
-    }
+    assert(client->ioc);
 
     nbd_send_request(client->ioc, &request);
 
-- 
2.11.1
