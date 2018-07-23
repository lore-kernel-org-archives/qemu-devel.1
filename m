Received: from eggs.gnu.org ([2001:4830:134:3::10]:43592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhLL-0004Vj-4P
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhLH-0005iL-V0
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:22:07 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:42 -0500
Message-Id: <20180723201748.25573-94-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 93/99] nbd/server: Reject 0-length block status
 request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>

From: Eric Blake <eblake@redhat.com>

The NBD spec says that behavior is unspecified if the client
requests 0 length for block status; but since the structured
reply is documenting as returning a non-zero length, it's
easier to just diagnose this with an EINVAL error than to
figure out what to return.

CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180621124937.166549-1-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
(cherry picked from commit d8b20291cba6aa9bb295885a34f2b5f05d59d1b2)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 nbd/server.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/nbd/server.c b/nbd/server.c
index 9e1f227178..493a926e06 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2007,6 +2007,10 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
                                       "discard failed", errp);
 
     case NBD_CMD_BLOCK_STATUS:
+        if (!request->len) {
+            return nbd_send_generic_reply(client, request->handle, -EINVAL,
+                                          "need non-zero length", errp);
+        }
         if (client->export_meta.valid && client->export_meta.base_allocation) {
             return nbd_co_send_block_status(client, request->handle,
                                             blk_bs(exp->blk), request->from,
-- 
2.17.1
