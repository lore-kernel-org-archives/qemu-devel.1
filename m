Received: from eggs.gnu.org ([2001:4830:134:3::10]:54651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJN-0005US-M4
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJL-0007DP-3n
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:49 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:37279 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1ddeJK-0007AQ-Iw
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:46 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  4 Aug 2017 18:14:32 +0300
Message-Id: <20170804151440.320927-10-vsementsov@virtuozzo.com>
In-Reply-To: <20170804151440.320927-1-vsementsov@virtuozzo.com>
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 09/17] block/nbd-client: move
 nbd_co_receive_reply content into nbd_co_request
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

Move code from nbd_co_receive_reply into nbd_co_request. This simplify
things, makes further refactoring possible. Also, a function starting
with qemu_coroutine_yield is weird.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 8ad2264a40..db1d7025fa 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -112,10 +112,6 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
     s->read_reply_co = NULL;
 }
 
-static void nbd_co_receive_reply(NBDClientSession *s,
-                                 NBDRequest *request,
-                                 NBDReply *reply,
-                                 QEMUIOVector *qiov);
 static void nbd_coroutine_end(BlockDriverState *bs,
                               NBDRequest *request);
 
@@ -175,39 +171,30 @@ static int nbd_co_request(BlockDriverState *bs,
     } else {
         qiov = NULL;
     }
-    nbd_co_receive_reply(s, request, &reply, qiov);
-    rc = -reply.error;
-
-out:
-    nbd_coroutine_end(bs, request);
-    return rc;
-}
-
-static void nbd_co_receive_reply(NBDClientSession *s,
-                                 NBDRequest *request,
-                                 NBDReply *reply,
-                                 QEMUIOVector *qiov)
-{
-    int ret;
 
     /* Wait until we're woken up by nbd_read_reply_entry.  */
     qemu_coroutine_yield();
-    *reply = s->reply;
-    if (reply->handle != request->handle ||
+    reply = s->reply;
+    if (reply.handle != request->handle ||
         !s->ioc) {
-        reply->error = EIO;
+        reply.error = EIO;
     } else {
-        if (qiov && reply->error == 0) {
+        if (qiov && reply.error == 0) {
             ret = nbd_rwv(s->ioc, qiov->iov, qiov->niov, request->len, true,
                           NULL);
             if (ret != request->len) {
-                reply->error = EIO;
+                reply.error = EIO;
             }
         }
 
         /* Tell the read handler to read another header.  */
         s->reply.handle = 0;
     }
+    rc = -reply.error;
+
+out:
+    nbd_coroutine_end(bs, request);
+    return rc;
 }
 
 static void nbd_coroutine_end(BlockDriverState *bs,
-- 
2.11.1
