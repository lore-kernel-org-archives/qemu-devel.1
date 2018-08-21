Received: from eggs.gnu.org ([2001:4830:134:3::10]:48646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fs3FR-0003qq-2f
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fs3FP-0007vl-Gq
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:46:48 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 21 Aug 2018 12:46:14 +0300
Message-Id: <1534844779-118784-4-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1534844779-118784-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1534844779-118784-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 3/8] ide: account UNMAP (TRIM) operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, famz@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 hw/ide/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 2c62efc..352429b 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -440,6 +440,14 @@ static void ide_issue_trim_cb(void *opaque, int ret)
     TrimAIOCB *iocb = opaque;
     IDEState *s = iocb->s;
 
+    if (iocb->i >= 0) {
+        if (ret >= 0) {
+            block_acct_done(blk_get_stats(s->blk), &s->acct);
+        } else {
+            block_acct_failed(blk_get_stats(s->blk), &s->acct);
+        }
+    }
+
     if (ret >= 0) {
         while (iocb->j < iocb->qiov->niov) {
             int j = iocb->j;
@@ -461,6 +469,9 @@ static void ide_issue_trim_cb(void *opaque, int ret)
                     goto done;
                 }
 
+                block_acct_start(blk_get_stats(s->blk), &s->acct,
+                                 count << BDRV_SECTOR_BITS, BLOCK_ACCT_UNMAP);
+
                 /* Got an entry! Submit and exit.  */
                 iocb->aiocb = blk_aio_pdiscard(s->blk,
                                                sector << BDRV_SECTOR_BITS,
@@ -845,6 +856,7 @@ static void ide_dma_cb(void *opaque, int ret)
     }
 
     if (ret == -EINVAL) {
+        block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_UNMAP);
         ide_dma_error(s);
         return;
     }
-- 
2.7.4
