Received: from eggs.gnu.org ([2001:4830:134:3::10]:52549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eu0Yu-0004YP-Pf
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:46:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eu0Yp-0003J6-S6
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:46:44 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  8 Mar 2018 21:46:34 +0300
Message-Id: <20180308184636.178534-4-vsementsov@virtuozzo.com>
In-Reply-To: <20180308184636.178534-1-vsementsov@virtuozzo.com>
References: <20180308184636.178534-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 3/5] nbd/server: fix: check client->closing
 before reply sending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

It's like an RFC. I'm not sure, but this place looks like a bug. Shouldn't
we chack client-closing even before nbd_client_receive_next_request() call?

 nbd/server.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index e0de431e10..97b45a21fa 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1547,10 +1547,6 @@ static coroutine_fn void nbd_trip(void *opaque)
         goto disconnect;
     }
 
-    if (ret < 0) {
-        goto reply;
-    }
-
     if (client->closing) {
         /*
          * The client may be closed when we are blocked in
@@ -1559,6 +1555,10 @@ static coroutine_fn void nbd_trip(void *opaque)
         goto done;
     }
 
+    if (ret < 0) {
+        goto reply;
+    }
+
     switch (request.type) {
     case NBD_CMD_READ:
         /* XXX: NBD Protocol only documents use of FUA with WRITE */
-- 
2.11.1
