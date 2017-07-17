Received: from eggs.gnu.org ([2001:4830:134:3::10]:35327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1dX5eo-0004X3-Ly
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1dX5en-0000wC-AT
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:01:50 -0400
From: P J P <ppandit@redhat.com>
Date: Mon, 17 Jul 2017 18:31:30 +0530
Message-Id: <20170717130130.29211-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH v1] ide: check BlockBackend object in
 ide_cancel_dma_sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, John Snow <jsnow@redhat.com>, Chensongnian <chensongnian@huawei.com>, qemu-block@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

When cancelling pending DMA requests in ide_cancel_dma_sync,
the s->blk object could be null, leading to a null dereference.
Add check to avoid it.

  blk_bs (blk=0x0) at block/block-backend.c:389
  blk_drain (blk=0x0) at block/block-backend.c:1232
  ide_cancel_dma_sync (s=0x7f203241c1a8) at hw/ide/core.c:684
  bmdma_cmd_writeb (bm=0x7f203241cf20, val=104) at hw/ide/pci.c:237
  bmdma_write (opaque=0x7f203241cf20, addr=0, val=104, size=1) at hw/ide/piix.c:77

Reported-by: Chensongnian <chensongnian@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/ide/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Update: add call stack trace leading the null dereference.

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 0b48b64..04474b3 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -681,8 +681,10 @@ void ide_cancel_dma_sync(IDEState *s)
 #ifdef DEBUG_IDE
         printf("%s: draining all remaining requests", __func__);
 #endif
-        blk_drain(s->blk);
-        assert(s->bus->dma->aiocb == NULL);
+        if (s->blk) {
+            blk_drain(s->blk);
+            assert(s->bus->dma->aiocb == NULL);
+        }
     }
 }
 
-- 
2.9.4
