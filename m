Received: from eggs.gnu.org ([2001:4830:134:3::10]:39623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1dVxOy-0007bb-OW
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:00:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1dVxOy-0000uI-3I
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:00:48 -0400
From: P J P <ppandit@redhat.com>
Date: Fri, 14 Jul 2017 15:30:29 +0530
Message-Id: <20170714100029.26288-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH] ide: check BlockBackend object in
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
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, Chensongnian <chensongnian@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

When cancelling pending DMA requests in ide_cancel_dma_sync,
the s->blk object could be null, leading to a null dereference.
Add check to avoid it.

Reported-by: Chensongnian <chensongnian@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/ide/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

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
