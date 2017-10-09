Received: from eggs.gnu.org ([2001:4830:134:3::10]:50521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e1bq5-0000V2-0R
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e1bq0-0004cr-RU
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:27:36 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:25945 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1e1bq0-0004ZD-F6
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:27:32 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  9 Oct 2017 20:27:15 +0300
Message-Id: <20171009172723.190282-10-vsementsov@virtuozzo.com>
In-Reply-To: <20171009172723.190282-1-vsementsov@virtuozzo.com>
References: <20171009172723.190282-1-vsementsov@virtuozzo.com>
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
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

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
