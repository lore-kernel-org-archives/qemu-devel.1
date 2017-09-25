Received: from eggs.gnu.org ([2001:4830:134:3::10]:39660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dwTtz-0006Yc-LR
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dwTtw-0007Dw-0e
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:58:27 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:45202 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dwTtv-0007CD-Kc
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:58:23 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 25 Sep 2017 16:57:54 +0300
Message-Id: <20170925135801.144261-2-vsementsov@virtuozzo.com>
In-Reply-To: <20170925135801.144261-1-vsementsov@virtuozzo.com>
References: <20170925135801.144261-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/8] block/nbd-client: assert qiov len once in
 nbd_co_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Hmreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 9d1e154feb..88fd10270e 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -156,7 +156,6 @@ static int nbd_co_send_request(BlockDriverState *bs,
         qio_channel_set_cork(s->ioc, true);
         rc = nbd_send_request(s->ioc, request);
         if (rc >= 0 && !s->quit) {
-            assert(request->len == iov_size(qiov->iov, qiov->niov));
             if (qio_channel_writev_all(s->ioc, qiov->iov, qiov->niov,
                                        NULL) < 0) {
                 rc = -EIO;
@@ -197,7 +196,6 @@ static int nbd_co_receive_reply(NBDClientSession *s,
         assert(s->reply.handle == request->handle);
         ret = -s->reply.error;
         if (qiov && s->reply.error == 0) {
-            assert(request->len == iov_size(qiov->iov, qiov->niov));
             if (qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
                                       NULL) < 0) {
                 ret = -EIO;
@@ -233,6 +231,7 @@ static int nbd_co_request(BlockDriverState *bs,
 
     assert(!qiov || request->type == NBD_CMD_WRITE ||
            request->type == NBD_CMD_READ);
+    assert(!qiov || request->len == iov_size(qiov->iov, qiov->niov));
     ret = nbd_co_send_request(bs, request,
                               request->type == NBD_CMD_WRITE ? qiov : NULL);
     if (ret < 0) {
-- 
2.11.1
