Received: from eggs.gnu.org ([2001:4830:134:3::10]:40768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSOw-0008Bx-9M
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSOv-0007W7-HW
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:22 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSOv-0007Ve-CA
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:21 -0400
Received: by mail-wr0-x242.google.com with SMTP id z45so2761739wrb.2
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:21 -0700 (PDT)
Received: from 640k.lan (94-39-191-51.adsl-ull.clienti.tiscali.it.
	[94.39.191.51])
	by smtp.gmail.com with ESMTPSA id f21sm3258597wra.5.2017.06.15.03.53.19
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 15 Jun 2017 03:53:19 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:29 +0200
Message-Id: <1497523981-38449-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 09/41] megasas: do not read iovec count more
 than once from frame
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Avoid TOC-TOU bugs depending on how the compiler behaves.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/megasas.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 1888118..c353118 100644
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
1.8.3.1
