Received: from eggs.gnu.org ([2001:4830:134:3::10]:57945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ecW7s-0006pn-Ql
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:50:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ecW7p-00037x-LN
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:50:32 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri, 19 Jan 2018 15:50:02 +0300
Message-Id: <1516366207-109842-4-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1516366207-109842-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1516366207-109842-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 3/8] ide: account UNMAP (TRIM) operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, eblake@redhat.com, den@virtuozzo.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 hw/ide/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 5be72d4..6fdc936 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -443,6 +443,14 @@ static void ide_issue_trim_cb(void *opaque, int ret)
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
@@ -460,10 +468,15 @@ static void ide_issue_trim_cb(void *opaque, int ret)
                 }
 
                 if (!ide_sect_range_ok(s, sector, count)) {
+                    block_acct_invalid(blk_get_stats(s->blk),
+                                       BLOCK_ACCT_UNMAP);
                     iocb->is_invalid = true;
                     goto done;
                 }
 
+                block_acct_start(blk_get_stats(s->blk), &s->acct,
+                                 count << BDRV_SECTOR_BITS, BLOCK_ACCT_UNMAP);
+
                 /* Got an entry! Submit and exit.  */
                 iocb->aiocb = blk_aio_pdiscard(s->blk,
                                                sector << BDRV_SECTOR_BITS,
-- 
2.7.4
