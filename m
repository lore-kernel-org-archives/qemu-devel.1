Received: from eggs.gnu.org ([2001:4830:134:3::10]:53098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0mAw-0004xu-7q
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:45:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0mAv-00067G-Hu
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:45:26 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 19 Apr 2017 17:43:55 +0800
Message-Id: <20170419094356.19826-16-famz@redhat.com>
In-Reply-To: <20170419094356.19826-1-famz@redhat.com>
References: <20170419094356.19826-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 15/16] block: Add perm assertion on
 blk_set_aio_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Now that all BB users comply with the BLK_PERM_AIO_CONTEXT_CHANGE
rule, we can assert it.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/block-backend.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 6133917..166edac 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1670,8 +1670,12 @@ static AioContext *blk_aiocb_get_aio_context(BlockAIOCB *acb)
 
 void blk_set_aio_context(BlockBackend *blk, AioContext *new_context)
 {
+    uint64_t perm, shared_perm;
     BlockDriverState *bs = blk_bs(blk);
 
+    blk_get_perm(blk, &perm, &shared_perm);
+    assert(perm & BLK_PERM_AIO_CONTEXT_CHANGE);
+
     blk->aio_context = new_context;
     if (bs) {
         if (blk->public.throttle_state) {
-- 
2.9.3
