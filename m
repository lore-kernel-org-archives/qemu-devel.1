Received: from eggs.gnu.org ([2001:4830:134:3::10]:53104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpqh-0001re-Hz
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:56:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpqg-0003Hp-ON
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:56:07 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  2 Mar 2018 19:54:41 +0100
Message-Id: <20180302185448.6314-31-kwolf@redhat.com>
In-Reply-To: <20180302185448.6314-1-kwolf@redhat.com>
References: <20180302185448.6314-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 30/37] Revert "IDE: Do not flush empty CDROM
 drives"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Stefan Hajnoczi <stefanha@redhat.com>

This reverts commit 4da97120d51a4383aa96d741a2b837f8c4bbcd0b.

blk_aio_flush() now handles the blk->root == NULL case, so we no longer
need this workaround.

Cc: John Snow <jsnow@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/ide/core.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 257b429381..139c843514 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -1087,15 +1087,7 @@ static void ide_flush_cache(IDEState *s)
     s->status |= BUSY_STAT;
     ide_set_retry(s);
     block_acct_start(blk_get_stats(s->blk), &s->acct, 0, BLOCK_ACCT_FLUSH);
-
-    if (blk_bs(s->blk)) {
-        s->pio_aiocb = blk_aio_flush(s->blk, ide_flush_cb, s);
-    } else {
-        /* XXX blk_aio_flush() crashes when blk_bs(blk) is NULL, remove this
-         * temporary workaround when blk_aio_*() functions handle NULL blk_bs.
-         */
-        ide_flush_cb(s, 0);
-    }
+    s->pio_aiocb = blk_aio_flush(s->blk, ide_flush_cb, s);
 }
 
 static void ide_cfata_metadata_inquiry(IDEState *s)
-- 
2.13.6
