Received: from eggs.gnu.org ([2001:4830:134:3::10]:38993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eNHVN-0007NB-5Q
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 07:11:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eNHVJ-000449-Tn
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 07:11:49 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri,  8 Dec 2017 15:10:32 +0300
Message-Id: <1512735034-35327-2-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1512735034-35327-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1512735034-35327-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/3] ide: pass IDEState to trim AIO callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

It will be needed to handle invalid requests

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 hw/ide/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 471d0c9..02a6b2c 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -383,7 +383,7 @@ static void ide_set_signature(IDEState *s)
 
 typedef struct TrimAIOCB {
     BlockAIOCB common;
-    BlockBackend *blk;
+    IDEState *s;
     QEMUBH *bh;
     int ret;
     QEMUIOVector *qiov;
@@ -426,6 +426,8 @@ static void ide_trim_bh_cb(void *opaque)
 static void ide_issue_trim_cb(void *opaque, int ret)
 {
     TrimAIOCB *iocb = opaque;
+    IDEState *s = iocb->s;
+
     if (ret >= 0) {
         while (iocb->j < iocb->qiov->niov) {
             int j = iocb->j;
@@ -443,7 +445,7 @@ static void ide_issue_trim_cb(void *opaque, int ret)
                 }
 
                 /* Got an entry! Submit and exit.  */
-                iocb->aiocb = blk_aio_pdiscard(iocb->blk,
+                iocb->aiocb = blk_aio_pdiscard(s->blk,
                                                sector << BDRV_SECTOR_BITS,
                                                count << BDRV_SECTOR_BITS,
                                                ide_issue_trim_cb, opaque);
@@ -467,11 +469,11 @@ BlockAIOCB *ide_issue_trim(
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
@@ -901,7 +903,7 @@ static void ide_dma_cb(void *opaque, int ret)
     case IDE_DMA_TRIM:
         s->bus->dma->aiocb = dma_blk_io(blk_get_aio_context(s->blk),
                                         &s->sg, offset, BDRV_SECTOR_SIZE,
-                                        ide_issue_trim, s->blk, ide_dma_cb, s,
+                                        ide_issue_trim, s, ide_dma_cb, s,
                                         DMA_DIRECTION_TO_DEVICE);
         break;
     default:
-- 
2.7.4
