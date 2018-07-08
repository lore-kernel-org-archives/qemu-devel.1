Received: from eggs.gnu.org ([2001:4830:134:3::10]:45789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fbyvl-0000LI-OD
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 21:56:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fbyvk-00059D-VM
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 21:56:05 -0400
From: Eric Blake <eblake@redhat.com>
Date: Sat,  7 Jul 2018 20:55:54 -0500
Message-Id: <20180708015554.297823-2-eblake@redhat.com>
In-Reply-To: <20180708015554.297823-1-eblake@redhat.com>
References: <20180708015554.297823-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] nbd/server: fix nbd_co_send_block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Call nbd_co_send_extents() with correct length parameter
(extent.length may be smaller than original length).

Also, switch length parameter type to uint32_t, to correspond with
request->len and similar nbd_co_send_bitmap().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20180704112302.471456-2-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index e52b76bd1a4..ea5fe0eb336 100644
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
2.14.4
