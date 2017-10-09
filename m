Received: from eggs.gnu.org ([2001:4830:134:3::10]:50586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e1bq6-0000VF-Mo
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e1bq1-0004eC-50
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:27:38 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:26309 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e1bq0-0004ZH-O7
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:27:33 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  9 Oct 2017 20:27:10 +0300
Message-Id: <20171009172723.190282-5-vsementsov@virtuozzo.com>
In-Reply-To: <20171009172723.190282-1-vsementsov@virtuozzo.com>
References: <20171009172723.190282-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 02/10] block/nbd-client: refactor
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
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Pass handle parameter directly, as the whole request isn't needed.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/nbd-client.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index ddf273a6a4..c0683c3c83 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -180,11 +180,11 @@ err:
 }
 
 static int nbd_co_receive_reply(NBDClientSession *s,
-                                NBDRequest *request,
+                                uint64_t handle,
                                 QEMUIOVector *qiov)
 {
     int ret;
-    int i = HANDLE_TO_INDEX(s, request->handle);
+    int i = HANDLE_TO_INDEX(s, handle);
 
     /* Wait until we're woken up by nbd_read_reply_entry.  */
     s->requests[i].receiving = true;
@@ -193,7 +193,7 @@ static int nbd_co_receive_reply(NBDClientSession *s,
     if (!s->ioc || s->quit) {
         ret = -EIO;
     } else {
-        assert(s->reply.handle == request->handle);
+        assert(s->reply.handle == handle);
         ret = -s->reply.error;
         if (qiov && s->reply.error == 0) {
             if (qio_channel_readv_all(s->ioc, qiov->iov, qiov->niov,
@@ -241,7 +241,7 @@ static int nbd_co_request(BlockDriverState *bs,
         return ret;
     }
 
-    return nbd_co_receive_reply(client, request,
+    return nbd_co_receive_reply(client, request->handle,
                                 request->type == NBD_CMD_READ ? qiov : NULL);
 }
 
-- 
2.11.1
