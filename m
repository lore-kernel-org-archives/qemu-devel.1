Received: from eggs.gnu.org ([2001:4830:134:3::10]:56937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIDQu-0001tQ-HA
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 08:18:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIDQs-0005Gd-4g
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 08:18:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dIDQr-0005GQ-VH
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 08:17:58 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Jun 2017 14:17:43 +0200
Message-Id: <20170606121747.25356-4-pbonzini@redhat.com>
In-Reply-To: <20170606121747.25356-1-pbonzini@redhat.com>
References: <20170606121747.25356-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 3/7] megasas: do not read iovec count more than
 once from frame
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: zyy4013@stu.ouc.edu.cn, ppandit@redhat.com, hare@suse.de

Avoid TOC-TOU bugs depending on how the compiler behaves.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/megasas.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 1888118e5f..c353118882 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -675,15 +675,16 @@ out:
 static int megasas_map_dcmd(MegasasState *s, MegasasCmd *cmd)
 {
     dma_addr_t iov_pa, iov_size;
+    int iov_count;
 
     cmd->flags = le16_to_cpu(cmd->frame->header.flags);
-    if (!cmd->frame->header.sge_count) {
+    iov_count = cmd->frame->header.sge_count;
+    if (!iov_count) {
         trace_megasas_dcmd_zero_sge(cmd->index);
         cmd->iov_size = 0;
         return 0;
-    } else if (cmd->frame->header.sge_count > 1) {
-        trace_megasas_dcmd_invalid_sge(cmd->index,
-                                       cmd->frame->header.sge_count);
+    } else if (iov_count > 1) {
+        trace_megasas_dcmd_invalid_sge(cmd->index, iov_count);
         cmd->iov_size = 0;
         return -EINVAL;
     }
-- 
2.13.0
