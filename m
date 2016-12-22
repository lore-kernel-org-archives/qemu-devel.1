Received: from eggs.gnu.org ([2001:4830:134:3::10]:37926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5DU-0007x4-TK
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5DS-0007EJ-DK
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK5DS-0007E1-6O
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:34 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5083743A3C
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 15:23:33 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-19.ams2.redhat.com
	[10.36.116.19])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id uBMFN1xY027210
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 10:23:32 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Dec 2016 16:22:56 +0100
Message-Id: <20161222152300.32395-22-pbonzini@redhat.com>
In-Reply-To: <20161222152300.32395-1-pbonzini@redhat.com>
References: <20161222152300.32395-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 21/25] scsi-disk: fix VERIFY for scsi-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When a scsi-disk object receives VERIFY command with BYTCHK bit being zero,
scsi_block_is_passthrough returns false and finally makes req being proceeded
by scsi_block_dma_command. Because scsi_block_dma_command has removed process
of VERIFY, QEMU will abort in this function.

Reported-by: Junlian Bell <zhongjun@sangfor.com.cn>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index a963191..bdd1e5f 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2157,6 +2157,13 @@ static int32_t scsi_disk_dma_command(SCSIRequest *req, uint8_t *buf)
         DPRINTF("Write %s(sector %" PRId64 ", count %u)\n",
                 (command & 0xe) == 0xe ? "And Verify " : "",
                 r->req.cmd.lba, len);
+    case VERIFY_10:
+    case VERIFY_12:
+    case VERIFY_16:
+        /* We get here only for BYTCHK == 0x01 and only for scsi-block.
+         * As far as DMA is concerned, we can treat it the same as a write;
+         * scsi_block_do_sgio will send VERIFY commands.
+         */
         if (r->req.cmd.buf[1] & 0xe0) {
             goto illegal_request;
         }
@@ -2712,7 +2719,7 @@ static bool scsi_block_is_passthrough(SCSIDiskState *s, uint8_t *buf)
     case WRITE_VERIFY_16:
         /* MMC writing cannot be done via DMA helpers, because it sometimes
          * involves writing beyond the maximum LBA or to negative LBA (lead-in).
-         * We might use scsi_disk_dma_reqops as long as no writing commands are
+         * We might use scsi_block_dma_reqops as long as no writing commands are
          * seen, but performance usually isn't paramount on optical media.  So,
          * just make scsi-block operate the same as scsi-generic for them.
          */
-- 
2.9.3
