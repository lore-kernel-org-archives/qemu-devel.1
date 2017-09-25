Received: from eggs.gnu.org ([2001:4830:134:3::10]:35233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwTdp-0005LG-1r
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:41:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwTdo-0006MU-6W
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:41:45 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 25 Sep 2017 08:41:29 -0500
Message-Id: <20170925134130.13262-5-eblake@redhat.com>
In-Reply-To: <20170925134130.13262-1-eblake@redhat.com>
References: <20170925134130.13262-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 4/4] block/nbd-client: nbd_co_send_request: fix
 return code
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

It's incorrect to return success rc >= 0 if we skip qio_channel_writev_all()
call due to s->quit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170920124507.18841-4-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd-client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index ac93c4c0d0..72651dcdb1 100644
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
2.13.5
