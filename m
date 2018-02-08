Received: from eggs.gnu.org ([2001:4830:134:3::10]:49350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ejpqA-0007jo-PJ
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:18:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ejpq9-0003eR-VD
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:18:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48904 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ejpq9-0003Yi-Q8
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:18:29 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu,  8 Feb 2018 17:18:07 +0000
Message-Id: <20180208171807.24267-4-stefanha@redhat.com>
In-Reply-To: <20180208171807.24267-1-stefanha@redhat.com>
References: <20180208171807.24267-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] Revert "IDE: Do not flush empty CDROM
 drives"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, mark.kanda@oracle.com, Stefan Hajnoczi <stefanha@redhat.com>

This reverts commit 4da97120d51a4383aa96d741a2b837f8c4bbcd0b.

blk_aio_flush() now handles the blk->root == NULL case, so we no longer
need this workaround.

Cc: John Snow <jsnow@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/ide/core.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 5be72d41dc..6154bc6ad7 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -1085,15 +1085,7 @@ static void ide_flush_cache(IDEState *s)
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
2.14.3
