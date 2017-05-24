Received: from eggs.gnu.org ([2001:4830:134:3::10]:34388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDMQk-0000ze-NG
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDMQj-0007Ck-Vz
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:53:46 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 24 May 2017 10:52:34 +0800
Message-Id: <20170524025235.32190-16-famz@redhat.com>
In-Reply-To: <20170524025235.32190-1-famz@redhat.com>
References: <20170524025235.32190-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 15/16] block: Add perm assertion on
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
index dfe577d..51c62ea 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1695,8 +1695,12 @@ static AioContext *blk_aiocb_get_aio_context(BlockAIOCB *acb)
 
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
2.9.4
