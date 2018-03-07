Received: from eggs.gnu.org ([2001:4830:134:3::10]:55467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eti1K-0001Ry-JR
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 17:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eti1J-0000oO-NA
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 17:58:50 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed,  7 Mar 2018 16:57:32 -0600
Message-Id: <20180307225732.155835-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] nbd/server: Honor FUA request on NBD_CMD_TRIM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com, kwolf@redhat.com, pbonzini@redhat.com

The NBD spec states that since trim requests can affect disk contents,
then they should allow for FUA semantics just like writes for ensuring
the disk has settled before returning.  As bdrv_[co_]pdiscard() does
not (yet?) support a flags argument, we can't pass FUA down the block
layer stack, and must therefore emulate it with a flush at the NBD
layer.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

Question for Paolo: does ISCSI support the notion of FUA on a
TRIM request (where we could better emulate a guest TRIM request
with FUA all the way through our stack to the NBD server), or is
FUA just for normal writes?  Likewise, are you familiar enough
with the kernel's NBD module to know if the kernel as an NBD client
would ever request FUA on a discard request?

Question for Kevin: should we update the block layer to have a
flag arguments to bdrv_co_pdiscard (right now, the only valid
flag would be BDRV_REQ_FUA, and we'd probably need a
supported_discard_flags in parallel to supported_write_flags),
and implement qemu-io -c 'discard -f' for easily testing the use
of that flag?

Depending on answers to those questions, I may want to spin a
v2 patch that adds flag support throughout the block layer
discard implementation, rather than this patch which just does
it in NBD; but if nothing else, this is the shortest patch
possible to fix the (corner-case?) NBD spec non-compliance.

 nbd/server.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/nbd/server.c b/nbd/server.c
index 4990a5826e6..e098da819df 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1623,6 +1623,9 @@ static coroutine_fn void nbd_trip(void *opaque)
     case NBD_CMD_TRIM:
         ret = blk_co_pdiscard(exp->blk, request.from + exp->dev_offset,
                               request.len);
+        if (ret == 0 && request.flags & NBD_CMD_FLAG_FUA) {
+            ret = blk_co_flush(exp->blk);
+        }
         if (ret < 0) {
             error_setg_errno(&local_err, -ret, "discard failed");
         }
-- 
2.14.3
