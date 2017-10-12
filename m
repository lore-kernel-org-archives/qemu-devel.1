Received: from eggs.gnu.org ([2001:4830:134:3::10]:35446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2aBI-0001FZ-5k
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e2aBE-0000Gw-W7
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:53:32 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:35715 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e2aBE-0000Da-Jy
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:53:28 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 12 Oct 2017 12:53:07 +0300
Message-Id: <20171012095319.136610-2-vsementsov@virtuozzo.com>
In-Reply-To: <20171012095319.136610-1-vsementsov@virtuozzo.com>
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 01/13] block/nbd-client: assert qiov len
 once in nbd_co_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Also improve the assertion: check that qiov is NULL for other commands
than CMD_READ and CMD_WRITE.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 72651dcdb1..ddf273a6a4 100644
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
@@ -231,8 +229,12 @@ static int nbd_co_request(BlockDriverState *bs,
     NBDClientSession *client = nbd_get_client_session(bs);
     int ret;
 
-    assert(!qiov || request->type == NBD_CMD_WRITE ||
-           request->type == NBD_CMD_READ);
+    if (qiov) {
+        assert(request->type == NBD_CMD_WRITE || request->type == NBD_CMD_READ);
+        assert(request->len == iov_size(qiov->iov, qiov->niov));
+    } else {
+        assert(request->type != NBD_CMD_WRITE && request->type != NBD_CMD_READ);
+    }
     ret = nbd_co_send_request(bs, request,
                               request->type == NBD_CMD_WRITE ? qiov : NULL);
     if (ret < 0) {
-- 
2.11.1
