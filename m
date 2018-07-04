Received: from eggs.gnu.org ([2001:4830:134:3::10]:57230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fafsL-0007OM-53
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 07:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fafsI-0004eW-1p
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 07:23:09 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed,  4 Jul 2018 14:23:01 +0300
Message-Id: <20180704112302.471456-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180704112302.471456-1-vsementsov@virtuozzo.com>
References: <20180704112302.471456-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/2] nbd/server: fix nbd_co_send_block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Call nbd_co_send_extents() with correct length parameter
(extent.length may be smaller than original length).

Also, switch length parameter type to uint32_t, to correspond with
request->len and similar nbd_co_send_bitmap().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index e52b76bd1a..ea5fe0eb33 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1910,7 +1910,7 @@ static int nbd_co_send_extents(NBDClient *client, uint64_t handle,
 /* Get block status from the exported device and send it to the client */
 static int nbd_co_send_block_status(NBDClient *client, uint64_t handle,
                                     BlockDriverState *bs, uint64_t offset,
-                                    uint64_t length, bool last,
+                                    uint32_t length, bool last,
                                     uint32_t context_id, Error **errp)
 {
     int ret;
@@ -1922,7 +1922,8 @@ static int nbd_co_send_block_status(NBDClient *client, uint64_t handle,
                 client, handle, -ret, "can't get block status", errp);
     }
 
-    return nbd_co_send_extents(client, handle, &extent, 1, length, last,
+    return nbd_co_send_extents(client, handle, &extent, 1,
+                               be32_to_cpu(extent.length), last,
                                context_id, errp);
 }
 
-- 
2.11.1
