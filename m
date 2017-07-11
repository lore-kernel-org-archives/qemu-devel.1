Received: from eggs.gnu.org ([2001:4830:134:3::10]:37106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1dUyeM-0004Lj-3Q
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1dUyeL-0007BI-86
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:08:38 -0400
From: P J P <ppandit@redhat.com>
Date: Tue, 11 Jul 2017 22:38:21 +0530
Message-Id: <20170711170821.24669-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH] block: check BlockDriverState object before
 dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Kieron Shorrock <kshorrock@paloaltonetworks.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

When processing ATA_CACHE_FLUSH ide controller command,
BlockDriverState object could be null. Add check to avoid
null pointer dereference.

Reported-by: Kieron Shorrock <kshorrock@paloaltonetworks.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 block/block-backend.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 0df3457..6a543a4 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1168,8 +1168,13 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int bytes,
 {
     BlkAioEmAIOCB *acb;
     Coroutine *co;
+    BlockDriverState *bs = blk_bs(blk);
 
-    bdrv_inc_in_flight(blk_bs(blk));
+    if (!bs) {
+        return NULL;
+    }
+
+    bdrv_inc_in_flight(bs);
     acb = blk_aio_get(&blk_aio_em_aiocb_info, blk, cb, opaque);
     acb->rwco = (BlkRwCo) {
         .blk    = blk,
@@ -1182,7 +1187,7 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int bytes,
     acb->has_returned = false;
 
     co = qemu_coroutine_create(co_entry, acb);
-    bdrv_coroutine_enter(blk_bs(blk), co);
+    bdrv_coroutine_enter(bs, co);
 
     acb->has_returned = true;
     if (acb->rwco.ret != NOT_DONE) {
-- 
2.9.4
