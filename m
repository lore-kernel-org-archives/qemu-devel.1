Received: from eggs.gnu.org ([2001:4830:134:3::10]:44151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEanU-00071J-Fa
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:30:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEanR-0003Ot-AA
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:30:52 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri,  4 May 2018 08:30:34 -0500
Message-Id: <20180504133034.1328397-5-eblake@redhat.com>
In-Reply-To: <20180504133034.1328397-1-eblake@redhat.com>
References: <20180504133034.1328397-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 4/4] nbd/client: Relax handling of large
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
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

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
---
 block/nbd-client.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index e7caf49fbb4..8d69eaaa32f 100644
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
2.14.3
