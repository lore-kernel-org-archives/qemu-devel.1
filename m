Received: from eggs.gnu.org ([2001:4830:134:3::10]:37020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1duf2I-0003Qb-LA
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1duf2H-0004cK-RC
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:27:30 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 20 Sep 2017 15:45:07 +0300
Message-Id: <20170920124507.18841-4-vsementsov@virtuozzo.com>
In-Reply-To: <20170920124507.18841-1-vsementsov@virtuozzo.com>
References: <20170920124507.18841-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 3/3] block/nbd-client: nbd_co_send_request:
 fix return code
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
 block/nbd-client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 486bfff9f7..9d1e154feb 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -161,6 +161,8 @@ static int nbd_co_send_request(BlockDriverState *bs,
                                        NULL) < 0) {
                 rc = -EIO;
             }
+        } else if (rc >= 0) {
+            rc = -EIO;
         }
         qio_channel_set_cork(s->ioc, false);
     } else {
-- 
2.11.1
