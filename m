Received: from eggs.gnu.org ([2001:4830:134:3::10]:40966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1epINI-0006yj-KI
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:47:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1epINF-0002zD-JN
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:47:16 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 23 Feb 2018 18:47:00 +0000
Message-Id: <20180223184700.28854-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH] macio: fix NULL pointer dereference when
 issuing IDE trim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jsnow@redhat.com, anton.nefedov@virtuozzo.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

Commit ef0e64a983 "ide: pass IDEState to trim AIO callback" changed the
IDE trim callback from using a BlockBackend to an IDEState but forgot to update
the dma_blk_io() call in hw/ide/macio.c accordingly.

Without this fix qemu-system-ppc segfaults when issuing an IDE trim command on
any of the PPC Mac machines (easily triggered by running the Debian installer).

Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ide/macio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index 2e043ef1ea..d3a85cba3b 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -187,7 +187,7 @@ static void pmac_ide_transfer_cb(void *opaque, int ret)
         break;
     case IDE_DMA_TRIM:
         s->bus->dma->aiocb = dma_blk_io(blk_get_aio_context(s->blk), &s->sg,
-                                        offset, 0x1, ide_issue_trim, s->blk,
+                                        offset, 0x1, ide_issue_trim, s,
                                         pmac_ide_transfer_cb, io,
                                         DMA_DIRECTION_TO_DEVICE);
         break;
-- 
2.11.0
