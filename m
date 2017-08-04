Received: from eggs.gnu.org ([2001:4830:134:3::10]:54647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJN-0005UR-Hg
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJL-0007FG-UR
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:49 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:9706 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1ddeJL-00079Z-GE
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:47 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  4 Aug 2017 18:14:31 +0300
Message-Id: <20170804151440.320927-9-vsementsov@virtuozzo.com>
In-Reply-To: <20170804151440.320927-1-vsementsov@virtuozzo.com>
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 08/17] block/nbd-client: rename
 nbd_recv_coroutines_enter_all
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

Rename nbd_recv_coroutines_enter_all to nbd_recv_coroutines_wake_all,
as it most probably just add all recv coroutines into co_queue_wakeup,
not directly enter them.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index c9ade9b517..8ad2264a40 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -34,7 +34,7 @@
 #define HANDLE_TO_INDEX(bs, handle) ((handle) ^ ((uint64_t)(intptr_t)bs))
 #define INDEX_TO_HANDLE(bs, index)  ((index)  ^ ((uint64_t)(intptr_t)bs))
 
-static void nbd_recv_coroutines_enter_all(NBDClientSession *s)
+static void nbd_recv_coroutines_wake_all(NBDClientSession *s)
 {
     int i;
 
@@ -108,7 +108,7 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
     }
 
     s->reply.handle = 0;
-    nbd_recv_coroutines_enter_all(s);
+    nbd_recv_coroutines_wake_all(s);
     s->read_reply_co = NULL;
 }
 
-- 
2.11.1
