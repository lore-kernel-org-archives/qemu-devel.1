Received: from eggs.gnu.org ([2001:4830:134:3::10]:35248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwTdq-0005Ow-CR
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:41:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwTdp-0006Nx-HJ
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:41:46 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 25 Sep 2017 08:41:28 -0500
Message-Id: <20170925134130.13262-4-eblake@redhat.com>
In-Reply-To: <20170925134130.13262-1-eblake@redhat.com>
References: <20170925134130.13262-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 3/4] block/nbd-client: simplify check in
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

If we are woken up from while() loop in nbd_read_reply_entry
handles must be equal. If we are woken up from
nbd_recv_coroutines_wake_all s->quit must be true, so we do
not need checking handles equality.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170920124507.18841-3-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd-client.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 5168a2cab6..ac93c4c0d0 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -189,9 +189,10 @@ static int nbd_co_receive_reply(NBDClientSession *s,
     s->requests[i].receiving = true;
     qemu_coroutine_yield();
     s->requests[i].receiving = false;
-    if (s->reply.handle != request->handle || !s->ioc || s->quit) {
+    if (!s->ioc || s->quit) {
         ret = -EIO;
     } else {
+        assert(s->reply.handle == request->handle);
         ret = -s->reply.error;
         if (qiov && s->reply.error == 0) {
             assert(request->len == iov_size(qiov->iov, qiov->niov));
-- 
2.13.5
