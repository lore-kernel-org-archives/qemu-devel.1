Received: from eggs.gnu.org ([2001:4830:134:3::10]:55868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dfrbC-00088l-8M
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 13:50:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dfrbA-0004WR-Sl
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 13:50:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dfrbA-0004UZ-MX
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 13:50:20 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 10 Aug 2017 18:48:22 +0100
Message-Id: <20170810174824.9580-2-stefanha@redhat.com>
In-Reply-To: <20170810174824.9580-1-stefanha@redhat.com>
References: <20170810174824.9580-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.10 1/3] IDE: Do not flush empty CDROM
 drives
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The block backend changed in a way that flushing empty CDROM drives now
crashes.  Amend IDE to avoid doing so until the root problem can be
addressed for 2.11.

Original patch by John Snow <jsnow@redhat.com>.

Reported-by: Kieron Shorrock <kshorrock@paloaltonetworks.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20170809160212.29976-2-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/ide/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 0b48b64d3a..bea39536b0 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -1063,7 +1063,15 @@ static void ide_flush_cache(IDEState *s)
     s->status |= BUSY_STAT;
     ide_set_retry(s);
     block_acct_start(blk_get_stats(s->blk), &s->acct, 0, BLOCK_ACCT_FLUSH);
-    s->pio_aiocb = blk_aio_flush(s->blk, ide_flush_cb, s);
+
+    if (blk_bs(s->blk)) {
+        s->pio_aiocb = blk_aio_flush(s->blk, ide_flush_cb, s);
+    } else {
+        /* XXX blk_aio_flush() crashes when blk_bs(blk) is NULL, remove this
+         * temporary workaround when blk_aio_*() functions handle NULL blk_bs.
+         */
+        ide_flush_cb(s, 0);
+    }
 }
 
 static void ide_cfata_metadata_inquiry(IDEState *s)
-- 
2.13.4
