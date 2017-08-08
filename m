Received: from eggs.gnu.org ([2001:4830:134:3::10]:42284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1df8l4-0000tt-6I
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 13:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1df8l3-0002Lb-76
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 13:57:34 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  8 Aug 2017 13:57:08 -0400
Message-Id: <20170808175711.12203-2-jsnow@redhat.com>
In-Reply-To: <20170808175711.12203-1-jsnow@redhat.com>
References: <20170808175711.12203-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] IDE: Do not flush empty CDROM drives
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, pjp@redhat.com, John Snow <jsnow@redhat.com>

The block backend changed in a way that flushing empty CDROM drives
is now an error. Amend IDE to avoid doing so until the root problem
can be addressed for 2.11.

Reported-by: Kieron Shorrock <kshorrock@paloaltonetworks.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 0b48b64..6cbca43 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -1053,17 +1053,21 @@ static void ide_flush_cb(void *opaque, int ret)
     ide_set_irq(s->bus);
 }
 
-static void ide_flush_cache(IDEState *s)
+static bool ide_flush_cache(IDEState *s)
 {
     if (s->blk == NULL) {
         ide_flush_cb(s, 0);
-        return;
+        return false;
+    } else if (!blk_bs(s->blk)) {
+        /* Nothing to flush */
+        return true;
     }
 
     s->status |= BUSY_STAT;
     ide_set_retry(s);
     block_acct_start(blk_get_stats(s->blk), &s->acct, 0, BLOCK_ACCT_FLUSH);
     s->pio_aiocb = blk_aio_flush(s->blk, ide_flush_cb, s);
+    return false;
 }
 
 static void ide_cfata_metadata_inquiry(IDEState *s)
@@ -1508,8 +1512,7 @@ static bool cmd_write_dma(IDEState *s, uint8_t cmd)
 
 static bool cmd_flush_cache(IDEState *s, uint8_t cmd)
 {
-    ide_flush_cache(s);
-    return false;
+    return ide_flush_cache(s);
 }
 
 static bool cmd_seek(IDEState *s, uint8_t cmd)
-- 
2.9.4
