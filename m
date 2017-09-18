Received: from eggs.gnu.org ([2001:4830:134:3::10]:38435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dtwaR-0001iJ-9T
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:59:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dtwaO-0001R1-Pn
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:59:47 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:14443 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dtwaO-0001PG-Ei
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:59:44 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 18 Sep 2017 16:59:33 +0300
Message-Id: <20170918135935.255591-6-vsementsov@virtuozzo.com>
In-Reply-To: <20170918135935.255591-1-vsementsov@virtuozzo.com>
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 5/7] block/nbd-client: nbd_co_send_request:
 return -EIO if s->quit was set in parallel
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

It's incorrect to return success rc >= 0 if we skip qio_channel_writev_all()
call due to s->quit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index f331f08a9a..280147e6a7 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -189,6 +189,9 @@ static int nbd_co_send_request(BlockDriverState *bs,
     }
 
 err:
+    if (rc >= 0 && s->quit) {
+        rc = -EIO;
+    }
     if (rc < 0) {
         s->quit = true;
         s->requests[i].coroutine = NULL;
-- 
2.11.1
