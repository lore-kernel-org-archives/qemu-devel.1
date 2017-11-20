Received: from eggs.gnu.org ([2001:4830:134:3::10]:51369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eGpI3-0002f6-Dm
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 11:51:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eGpHz-0003px-HX
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 11:51:23 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 20 Nov 2017 19:50:59 +0300
Message-Id: <1511196664-85304-3-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1511196664-85304-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1511196664-85304-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/7] ide: account UNMAP (TRIM) operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, eblake@redhat.com, den@virtuozzo.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 hw/ide/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 471d0c9..2e4dea7 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -389,6 +389,7 @@ typedef struct TrimAIOCB {
     QEMUIOVector *qiov;
     BlockAIOCB *aiocb;
     int i, j;
+    BlockAcctCookie acct;
 } TrimAIOCB;
 
 static void trim_aio_cancel(BlockAIOCB *acb)
@@ -426,6 +427,14 @@ static void ide_trim_bh_cb(void *opaque)
 static void ide_issue_trim_cb(void *opaque, int ret)
 {
     TrimAIOCB *iocb = opaque;
+    if (iocb->i >= 0) {
+        if (ret >= 0) {
+            block_acct_done(blk_get_stats(iocb->blk), &iocb->acct);
+        } else {
+            block_acct_failed(blk_get_stats(iocb->blk), &iocb->acct);
+        }
+    }
+
     if (ret >= 0) {
         while (iocb->j < iocb->qiov->niov) {
             int j = iocb->j;
@@ -442,6 +451,9 @@ static void ide_issue_trim_cb(void *opaque, int ret)
                     continue;
                 }
 
+                block_acct_start(blk_get_stats(iocb->blk), &iocb->acct,
+                                 count << BDRV_SECTOR_BITS, BLOCK_ACCT_UNMAP);
+
                 /* Got an entry! Submit and exit.  */
                 iocb->aiocb = blk_aio_pdiscard(iocb->blk,
                                                sector << BDRV_SECTOR_BITS,
-- 
2.7.4
