Received: from eggs.gnu.org ([2001:4830:134:3::10]:38437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dtwaR-0001iL-A0
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dtwaN-0001QQ-Ms
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:59:47 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:37069 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dtwaN-0001P3-B3
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:59:43 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 18 Sep 2017 16:59:29 +0300
Message-Id: <20170918135935.255591-2-vsementsov@virtuozzo.com>
In-Reply-To: <20170918135935.255591-1-vsementsov@virtuozzo.com>
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 1/7] block/nbd-client: refactor
 nbd_co_receive_reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

"NBDReply *reply" parameter of nbd_co_receive_reply is used only
to pass return value for nbd_co_request (reply.error). Remove it
and use function return value instead.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index ee7f758e68..acd8e5d007 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -178,26 +178,26 @@ err:
     return rc;
 }
 
-static void nbd_co_receive_reply(NBDClientSession *s,
-                                 NBDRequest *request,
-                                 NBDReply *reply,
-                                 QEMUIOVector *qiov)
+static int nbd_co_receive_reply(NBDClientSession *s,
+                                NBDRequest *request,
+                                QEMUIOVector *qiov)
 {
+    int ret;
     int i = HANDLE_TO_INDEX(s, request->handle);
 
     /* Wait until we're woken up by nbd_read_reply_entry.  */
     s->requests[i].receiving = true;
     qemu_coroutine_yield();
     s->requests[i].receiving = false;
-    *reply = s->reply;
-    if (reply->handle != request->handle || !s->ioc || s->quit) {
-        reply->error = EIO;
+    if (s->reply.handle != request->handle || !s->ioc || s->quit) {
+        ret = -EIO;
     } else {
-        if (qiov && reply->error == 0) {
+        ret = -s->reply.error;
+        if (qiov && s->reply.error == 0) {
             assert(request->len == iov_size(qiov->iov, qiov->niov));
             if (qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
                                       NULL) < 0) {
-                reply->error = EIO;
+                ret = -EIO;
                 s->quit = true;
             }
         }
@@ -217,6 +217,8 @@ static void nbd_co_receive_reply(NBDClientSession *s,
     s->in_flight--;
     qemu_co_queue_next(&s->free_sema);
     qemu_co_mutex_unlock(&s->send_mutex);
+
+    return ret;
 }
 
 static int nbd_co_request(BlockDriverState *bs,
@@ -224,7 +226,6 @@ static int nbd_co_request(BlockDriverState *bs,
                           QEMUIOVector *qiov)
 {
     NBDClientSession *client = nbd_get_client_session(bs);
-    NBDReply reply;
     int ret;
 
     assert(!qiov || request->type == NBD_CMD_WRITE ||
@@ -232,12 +233,11 @@ static int nbd_co_request(BlockDriverState *bs,
     ret = nbd_co_send_request(bs, request,
                               request->type == NBD_CMD_WRITE ? qiov : NULL);
     if (ret < 0) {
-        reply.error = -ret;
-    } else {
-        nbd_co_receive_reply(client, request, &reply,
-                             request->type == NBD_CMD_READ ? qiov : NULL);
+        return ret;
     }
-    return -reply.error;
+
+    return nbd_co_receive_reply(client, request,
+                                request->type == NBD_CMD_READ ? qiov : NULL);
 }
 
 int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
-- 
2.11.1
