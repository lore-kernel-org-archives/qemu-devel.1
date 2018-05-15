Received: from eggs.gnu.org ([2001:4830:134:3::10]:38640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4O-0006cI-Ag
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4J-0001M1-NV
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:40:56 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 15 May 2018 17:39:57 +0200
Message-Id: <20180515154033.19899-2-kwolf@redhat.com>
In-Reply-To: <20180515154033.19899-1-kwolf@redhat.com>
References: <20180515154033.19899-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 01/37] block-backend: simplify
 blk_get_aio_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

blk_get_aio_context verifies if BlockDriverState bs is not NULL,
return bdrv_get_aio_context(bs) if true or qemu_get_aio_context()
otherwise. However, bdrv_get_aio_context from block.c already does
this verification itself, also returning qemu_get_aio_context()
if bs is NULL:

AioContext *bdrv_get_aio_context(BlockDriverState *bs)
{
    return bs ? bs->aio_context : qemu_get_aio_context();
}

This patch simplifies blk_get_aio_context to simply call
bdrv_get_aio_context instead of replicating the same logic.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/block-backend.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 681b240b12..89f47b00ea 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1865,13 +1865,7 @@ void blk_op_unblock_all(BlockBackend *blk, Error *reason)
 
 AioContext *blk_get_aio_context(BlockBackend *blk)
 {
-    BlockDriverState *bs = blk_bs(blk);
-
-    if (bs) {
-        return bdrv_get_aio_context(bs);
-    } else {
-        return qemu_get_aio_context();
-    }
+    return bdrv_get_aio_context(blk_bs(blk));
 }
 
 static AioContext *blk_aiocb_get_aio_context(BlockAIOCB *acb)
-- 
2.13.6
