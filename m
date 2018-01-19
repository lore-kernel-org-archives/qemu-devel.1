Received: from eggs.gnu.org ([2001:4830:134:3::10]:57632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecfCf-0007jw-Rd
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 17:32:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecfCe-0005IH-0J
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 17:32:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1ecfCd-0005FN-Qh
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 17:32:03 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 19 Jan 2018 17:31:56 -0500
Message-Id: <20180119223159.29890-2-jsnow@redhat.com>
In-Reply-To: <20180119223159.29890-1-jsnow@redhat.com>
References: <20180119223159.29890-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 1/4] ide: pass IDEState to trim AIO callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

It will be needed to handle invalid requests

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-id: 1512735034-35327-2-git-send-email-anton.nefedov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 1ea5812b7e..875f7b442d 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -382,7 +382,7 @@ static void ide_set_signature(IDEState *s)
 
 typedef struct TrimAIOCB {
     BlockAIOCB common;
-    BlockBackend *blk;
+    IDEState *s;
     QEMUBH *bh;
     int ret;
     QEMUIOVector *qiov;
@@ -425,6 +425,8 @@ static void ide_trim_bh_cb(void *opaque)
 static void ide_issue_trim_cb(void *opaque, int ret)
 {
     TrimAIOCB *iocb = opaque;
+    IDEState *s = iocb->s;
+
     if (ret >= 0) {
         while (iocb->j < iocb->qiov->niov) {
             int j = iocb->j;
@@ -442,7 +444,7 @@ static void ide_issue_trim_cb(void *opaque, int ret)
                 }
 
                 /* Got an entry! Submit and exit.  */
-                iocb->aiocb = blk_aio_pdiscard(iocb->blk,
+                iocb->aiocb = blk_aio_pdiscard(s->blk,
                                                sector << BDRV_SECTOR_BITS,
                                                count << BDRV_SECTOR_BITS,
                                                ide_issue_trim_cb, opaque);
@@ -466,11 +468,11 @@ BlockAIOCB *ide_issue_trim(
         int64_t offset, QEMUIOVector *qiov,
         BlockCompletionFunc *cb, void *cb_opaque, void *opaque)
 {
-    BlockBackend *blk = opaque;
+    IDEState *s = opaque;
     TrimAIOCB *iocb;
 
-    iocb = blk_aio_get(&trim_aiocb_info, blk, cb, cb_opaque);
-    iocb->blk = blk;
+    iocb = blk_aio_get(&trim_aiocb_info, s->blk, cb, cb_opaque);
+    iocb->s = s;
     iocb->bh = qemu_bh_new(ide_trim_bh_cb, iocb);
     iocb->ret = 0;
     iocb->qiov = qiov;
@@ -900,7 +902,7 @@ static void ide_dma_cb(void *opaque, int ret)
     case IDE_DMA_TRIM:
         s->bus->dma->aiocb = dma_blk_io(blk_get_aio_context(s->blk),
                                         &s->sg, offset, BDRV_SECTOR_SIZE,
-                                        ide_issue_trim, s->blk, ide_dma_cb, s,
+                                        ide_issue_trim, s, ide_dma_cb, s,
                                         DMA_DIRECTION_TO_DEVICE);
         break;
     default:
-- 
2.14.3
