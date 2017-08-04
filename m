Received: from eggs.gnu.org ([2001:4830:134:3::10]:54630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJN-0005UK-3l
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJL-0007DE-2L
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:48 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:1711 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1ddeJK-0007AF-J6
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:46 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  4 Aug 2017 18:14:33 +0300
Message-Id: <20170804151440.320927-11-vsementsov@virtuozzo.com>
In-Reply-To: <20170804151440.320927-1-vsementsov@virtuozzo.com>
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 10/17] block/nbd-client: move nbd_coroutine_end
 content into nbd_co_request
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

Move code from nbd_coroutine_end into nbd_co_request. The function
nbd_coroutine_end is not needed separately, also it is better to
have in_flight-- in nbd_co_request as in_flight++ lives in nbd_co_request
too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index db1d7025fa..d6965d24db 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -112,9 +112,6 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
     s->read_reply_co = NULL;
 }
 
-static void nbd_coroutine_end(BlockDriverState *bs,
-                              NBDRequest *request);
-
 static int nbd_co_request(BlockDriverState *bs,
                           NBDRequest *request,
                           QEMUIOVector *qiov)
@@ -193,16 +190,6 @@ static int nbd_co_request(BlockDriverState *bs,
     rc = -reply.error;
 
 out:
-    nbd_coroutine_end(bs, request);
-    return rc;
-}
-
-static void nbd_coroutine_end(BlockDriverState *bs,
-                              NBDRequest *request)
-{
-    NBDClientSession *s = nbd_get_client_session(bs);
-    int i = HANDLE_TO_INDEX(s, request->handle);
-
     s->recv_coroutine[i] = NULL;
 
     /* Kick the read_reply_co to get the next reply.  */
@@ -214,6 +201,7 @@ static void nbd_coroutine_end(BlockDriverState *bs,
     s->in_flight--;
     qemu_co_queue_next(&s->free_sema);
     qemu_co_mutex_unlock(&s->send_mutex);
+    return rc;
 }
 
 int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
-- 
2.11.1
