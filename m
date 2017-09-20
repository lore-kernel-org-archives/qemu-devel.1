Received: from eggs.gnu.org ([2001:4830:134:3::10]:36994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1duf2H-0003Pj-Qo
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:27:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1duf2G-0004bc-P0
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:27:29 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 20 Sep 2017 15:45:06 +0300
Message-Id: <20170920124507.18841-3-vsementsov@virtuozzo.com>
In-Reply-To: <20170920124507.18841-1-vsementsov@virtuozzo.com>
References: <20170920124507.18841-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 2/3] block/nbd-client: simplify check in
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

If we are woken up from while() loop in nbd_read_reply_entry
handles must be equal. If we are woken up from
nbd_recv_coroutines_wake_all s->quit must be true, so we do
not need checking handles equality.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index acd8e5d007..486bfff9f7 100644
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
2.11.1
