Received: from eggs.gnu.org ([2001:4830:134:3::10]:52119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e3Wz2-0006WQ-HJ
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 20:40:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e3Wz1-0003oA-Mi
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 20:40:48 -0400
From: Eric Blake <eblake@redhat.com>
Date: Sat, 14 Oct 2017 19:40:27 -0500
Message-Id: <20171015004033.3248-4-eblake@redhat.com>
In-Reply-To: <20171015004033.3248-1-eblake@redhat.com>
References: <20171015004033.3248-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 3/9] block/nbd-client: refactor
 nbd_co_receive_reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Pass handle parameter directly, as the whole request isn't needed.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20171012095319.136610-3-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
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
2.13.6
