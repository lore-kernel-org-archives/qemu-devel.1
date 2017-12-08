Received: from eggs.gnu.org ([2001:4830:134:3::10]:39020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eNHVP-0007OZ-5R
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 07:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eNHVL-00044c-1m
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 07:11:51 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri,  8 Dec 2017 15:10:34 +0300
Message-Id: <1512735034-35327-4-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1512735034-35327-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1512735034-35327-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/3] ide: abort TRIM operation for invalid range
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

ATA8-ACS3, 7.9 DATA SET MANAGEMENT - 06h, DMA

    7.9.5 Error Outputs
    If the Trim bit is set to one and:
      a) the device detects an invalid LBA Range Entry; or
      b) count is greater than IDENTIFY DEVICE data word 105
         (see 7.16.7.55),
    then the device shall return command aborted.
    A device may trim one or more LBA Range Entries before it returns
    command aborted. See table 209.

This check is not in the common ide_dma_cb() as the range for TRIM
is harder to reach: it is not in LBA/count registers and the buffer has
to be parsed first.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 hw/ide/core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 23c71fa..3d1494f 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -401,6 +401,7 @@ typedef struct TrimAIOCB {
     QEMUIOVector *qiov;
     BlockAIOCB *aiocb;
     int i, j;
+    bool is_invalid;
 } TrimAIOCB;
 
 static void trim_aio_cancel(BlockAIOCB *acb)
@@ -428,8 +429,11 @@ static void ide_trim_bh_cb(void *opaque)
 {
     TrimAIOCB *iocb = opaque;
 
-    iocb->common.cb(iocb->common.opaque, iocb->ret);
-
+    if (iocb->is_invalid) {
+        ide_dma_error(iocb->s);
+    } else {
+        iocb->common.cb(iocb->common.opaque, iocb->ret);
+    }
     qemu_bh_delete(iocb->bh);
     iocb->bh = NULL;
     qemu_aio_unref(iocb);
@@ -456,6 +460,11 @@ static void ide_issue_trim_cb(void *opaque, int ret)
                     continue;
                 }
 
+                if (!ide_sect_range_ok(s, sector, count)) {
+                    iocb->is_invalid = true;
+                    goto done;
+                }
+
                 /* Got an entry! Submit and exit.  */
                 iocb->aiocb = blk_aio_pdiscard(s->blk,
                                                sector << BDRV_SECTOR_BITS,
@@ -471,6 +480,7 @@ static void ide_issue_trim_cb(void *opaque, int ret)
         iocb->ret = ret;
     }
 
+done:
     iocb->aiocb = NULL;
     if (iocb->bh) {
         qemu_bh_schedule(iocb->bh);
@@ -491,6 +501,7 @@ BlockAIOCB *ide_issue_trim(
     iocb->qiov = qiov;
     iocb->i = -1;
     iocb->j = 0;
+    iocb->is_invalid = false;
     ide_issue_trim_cb(iocb, 0);
     return &iocb->common;
 }
-- 
2.7.4
