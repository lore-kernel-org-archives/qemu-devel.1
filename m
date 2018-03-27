Received: from eggs.gnu.org ([2001:4830:134:3::10]:56651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f0gfO-0007Q7-Fo
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 00:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f0gfK-0002wu-PX
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 00:57:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57000 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1f0gfK-0002ue-Kd
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 00:56:58 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 27 Mar 2018 00:56:46 -0400
Message-Id: <20180327045646.21112-3-jsnow@redhat.com>
In-Reply-To: <20180327045646.21112-1-jsnow@redhat.com>
References: <20180327045646.21112-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] macio: fix NULL pointer dereference when
 issuing IDE trim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Commit ef0e64a983 "ide: pass IDEState to trim AIO callback" changed the
IDE trim callback from using a BlockBackend to an IDEState but forgot to update
the dma_blk_io() call in hw/ide/macio.c accordingly.

Without this fix qemu-system-ppc segfaults when issuing an IDE trim command on
any of the PPC Mac machines (easily triggered by running the Debian installer).

Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-id: 20180223184700.28854-1-mark.cave-ayland@ilande.co.uk
Signed-off-by: John Snow <jsnow@redhat.com>
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
2.14.3
