Received: from eggs.gnu.org ([2001:4830:134:3::10]:57009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVz28-0006Ul-2S
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVz27-0004LO-8R
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:49:52 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 21 Jun 2018 07:49:37 -0500
Message-Id: <20180621124937.166549-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] nbd/server: Reject 0-length block status
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
Cc: jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

The NBD spec says that behavior is unspecified if the client
requests 0 length for block status; but since the structured
reply is documenting as returning a non-zero length, it's
easier to just diagnose this with an EINVAL error than to
figure out what to return.

CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/nbd/server.c b/nbd/server.c
index 9e1f2271784..493a926e063 100644
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
2.14.4
