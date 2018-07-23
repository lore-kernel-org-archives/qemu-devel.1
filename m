Received: from eggs.gnu.org ([2001:4830:134:3::10]:42629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhK7-0003Kt-AG
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhK6-00051I-9v
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:51 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:12 -0500
Message-Id: <20180723201748.25573-64-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 63/99] nbd/client: Relax handling of large
 NBD_CMD_BLOCK_STATUS reply
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

The NBD spec is proposing a relaxation of NBD_CMD_BLOCK_STATUS
where a server may have the final extent per context give a
length beyond the original request, if it can easily prove that
subsequent bytes have the same status, on the grounds that a
client can take advantage of this information for fewer block
status requests.  Since qemu 2.12 as a client always sends
NBD_CMD_FLAG_REQ_ONE, and rejects a server that sends extra
length, the upstream NBD spec will probably limit this behavior
to clients that don't request REQ_ONE semantics; but it doesn't
hurt to relax qemu to always be permissive of this server
behavior, even if it continues to use REQ_ONE.

CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180503222626.1303410-1-eblake@redhat.com>
Reviewed-by:  Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
(cherry picked from commit acfd8f7a5f92e703d2d046cbe3d510008a697194)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/nbd-client.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index e7caf49fbb..8d69eaaa32 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -259,14 +259,18 @@ static int nbd_parse_blockstatus_payload(NBDClientSession *client,
 
     if (extent->length == 0 ||
         (client->info.min_block && !QEMU_IS_ALIGNED(extent->length,
-                                                    client->info.min_block)) ||
-        extent->length > orig_length)
-    {
+                                                    client->info.min_block))) {
         error_setg(errp, "Protocol error: server sent status chunk with "
                    "invalid length");
         return -EINVAL;
     }
 
+    /* The server is allowed to send us extra information on the final
+     * extent; just clamp it to the length we requested. */
+    if (extent->length > orig_length) {
+        extent->length = orig_length;
+    }
+
     return 0;
 }
 
-- 
2.17.1
