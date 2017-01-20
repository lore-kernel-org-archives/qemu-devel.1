Received: from eggs.gnu.org ([2001:4830:134:3::10]:52961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUZI9-0003lw-PA
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:31:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUZI7-0005tc-Gg
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:31:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cUZI7-0005tA-BB
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:31:43 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 88F9F83F3F
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 13:31:43 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-138.ams2.redhat.com
	[10.36.117.138])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v0KDVeVA014401
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 08:31:42 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jan 2017 14:31:06 +0100
Message-Id: <20170120133139.31080-3-pbonzini@redhat.com>
In-Reply-To: <20170120133139.31080-1-pbonzini@redhat.com>
References: <20170120133139.31080-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/35] megasas: fix guest-triggered memory leak
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
2.9.3
