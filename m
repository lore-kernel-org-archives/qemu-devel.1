Received: from eggs.gnu.org ([2001:4830:134:3::10]:45186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgK-00032e-NG
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgJ-0003Hb-AF
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:36 -0500
Received: from mail-wj0-x244.google.com ([2a00:1450:400c:c01::244]:35476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cROgJ-0003Gy-0D
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:35 -0500
Received: by mail-wj0-x244.google.com with SMTP id ey1so12923121wjd.2
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 11:35:34 -0800 (PST)
Received: from 640k.lan (94-39-158-71.adsl-ull.clienti.tiscali.it.
	[94.39.158.71]) by smtp.gmail.com with ESMTPSA id
	k11sm10463101wmb.18.2017.01.11.11.35.32 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 11 Jan 2017 11:35:32 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Jan 2017 20:34:56 +0100
Message-Id: <1484163327-111841-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
References: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/33] megasas: fix guest-triggered memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

If the guest sets the sglist size to a value >=2GB, megasas_handle_dcmd
will return MFI_STAT_MEMORY_NOT_AVAILABLE without freeing the memory.
Avoid this by returning only the status from map_dcmd, and loading
cmd->iov_size in the caller.

Reported-by: Li Qiang <liqiang6-s@360.cn>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/megasas.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 67fc1e7..6233865 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -683,14 +683,14 @@ static int megasas_map_dcmd(MegasasState *s, MegasasCmd *cmd)
         trace_megasas_dcmd_invalid_sge(cmd->index,
                                        cmd->frame->header.sge_count);
         cmd->iov_size = 0;
-        return -1;
+        return -EINVAL;
     }
     iov_pa = megasas_sgl_get_addr(cmd, &cmd->frame->dcmd.sgl);
     iov_size = megasas_sgl_get_len(cmd, &cmd->frame->dcmd.sgl);
     pci_dma_sglist_init(&cmd->qsg, PCI_DEVICE(s), 1);
     qemu_sglist_add(&cmd->qsg, iov_pa, iov_size);
     cmd->iov_size = iov_size;
-    return cmd->iov_size;
+    return 0;
 }
 
 static void megasas_finish_dcmd(MegasasCmd *cmd, uint32_t iov_size)
@@ -1559,19 +1559,20 @@ static const struct dcmd_cmd_tbl_t {
 
 static int megasas_handle_dcmd(MegasasState *s, MegasasCmd *cmd)
 {
-    int opcode, len;
+    int opcode;
     int retval = 0;
+    size_t len;
     const struct dcmd_cmd_tbl_t *cmdptr = dcmd_cmd_tbl;
 
     opcode = le32_to_cpu(cmd->frame->dcmd.opcode);
     trace_megasas_handle_dcmd(cmd->index, opcode);
-    len = megasas_map_dcmd(s, cmd);
-    if (len < 0) {
+    if (megasas_map_dcmd(s, cmd) < 0) {
         return MFI_STAT_MEMORY_NOT_AVAILABLE;
     }
     while (cmdptr->opcode != -1 && cmdptr->opcode != opcode) {
         cmdptr++;
     }
+    len = cmd->iov_size;
     if (cmdptr->opcode == -1) {
         trace_megasas_dcmd_unhandled(cmd->index, opcode, len);
         retval = megasas_dcmd_dummy(s, cmd);
-- 
1.8.3.1
