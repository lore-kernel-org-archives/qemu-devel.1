Received: from eggs.gnu.org ([2001:4830:134:3::10]:53233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn7Ou-00025h-CR
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn7Op-0001eU-Fy
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:07:40 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 30 Aug 2017 13:07:10 -0500
Message-Id: <20170830180711.7974-11-eblake@redhat.com>
In-Reply-To: <20170830180711.7974-1-eblake@redhat.com>
References: <20170830180711.7974-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 10/11] block/nbd-client: rename
 nbd_recv_coroutines_enter_all
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

Rename nbd_recv_coroutines_enter_all to nbd_recv_coroutines_wake_all,
as it most probably just adds all recv coroutines into co_queue_wakeup,
rather than directly enter them.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20170804151440.320927-9-vsementsov@virtuozzo.com>
[eblake: tweak commit message]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd-client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 1e393cf26f..322b725ff9 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -34,7 +34,7 @@
 #define HANDLE_TO_INDEX(bs, handle) ((handle) ^ ((uint64_t)(intptr_t)bs))
 #define INDEX_TO_HANDLE(bs, index)  ((index)  ^ ((uint64_t)(intptr_t)bs))

-static void nbd_recv_coroutines_enter_all(NBDClientSession *s)
+static void nbd_recv_coroutines_wake_all(NBDClientSession *s)
 {
     int i;

@@ -112,7 +112,7 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
     }

     s->quit = true;
-    nbd_recv_coroutines_enter_all(s);
+    nbd_recv_coroutines_wake_all(s);
     s->read_reply_co = NULL;
 }

-- 
2.13.5
