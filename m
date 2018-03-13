Received: from eggs.gnu.org ([2001:4830:134:3::10]:47177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evnUr-0007K9-2B
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evnUp-0000ru-BX
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:13:57 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 13 Mar 2018 12:13:35 -0500
Message-Id: <20180313171345.659672-8-eblake@redhat.com>
In-Reply-To: <20180313171345.659672-1-eblake@redhat.com>
References: <20180313171345.659672-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 07/17] nbd/server: Honor FUA request on
 NBD_CMD_TRIM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

The NBD spec states that since trim requests can affect disk contents,
then they should allow for FUA semantics just like writes for ensuring
the disk has settled before returning.  As bdrv_[co_]pdiscard() does
not support a flags argument, we can't pass FUA down the block layer
stack, and must therefore emulate it with a flush at the NBD layer.

Note that in all reality, generic well-behaved clients will never
send TRIM+FUA (in fact, qemu as a client never does, and we have no
intention to plumb flags into bdrv_pdiscard).  This is because the
NBD protocol states that it is unspecified to READ a trimmed area
(you might read stale data, all zeroes, or even random unrelated
data) without first rewriting it, and even the experimental
BLOCK_STATUS extension states that TRIM need not affect reported
status.  Thus, in the general case, a client cannot tell the
difference between an arbitrary server that ignores TRIM, a server
that had a power outage without flushing to disk, and a server that
actually affected the disk before returning; so waiting for the
trim actions to flush to disk makes little sense.  However, for a
specific client and server pair, where the client knows the server
treats TRIM'd areas as guaranteed reads-zero, waiting for a flush
makes sense, hence why the protocol documents that FUA is valid on
trim.  So, even though the NBD protocol doesn't have a way for the
server to advertise what effects (if any) TRIM will actually have,
and thus any client that relies on specific effects is probably
in error, we can at least support a client that requests TRIM+FUA.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180307225732.155835-1-eblake@redhat.com>
---
 nbd/server.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/nbd/server.c b/nbd/server.c
index 83f21c55912..4776009a2d1 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1638,6 +1638,9 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
     case NBD_CMD_TRIM:
         ret = blk_co_pdiscard(exp->blk, request->from + exp->dev_offset,
                               request->len);
+        if (ret == 0 && request->flags & NBD_CMD_FLAG_FUA) {
+            ret = blk_co_flush(exp->blk);
+        }
         return nbd_send_generic_reply(client, request->handle, ret,
                                       "discard failed", errp);

-- 
2.14.3
