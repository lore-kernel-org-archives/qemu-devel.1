Received: from eggs.gnu.org ([2001:4830:134:3::10]:40792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSOx-0008Cc-FA
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSOw-0007Wd-HU
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:23 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSOw-0007WB-B5
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:22 -0400
Received: by mail-wr0-x241.google.com with SMTP id y25so545516wrd.1
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:22 -0700 (PDT)
Received: from 640k.lan (94-39-191-51.adsl-ull.clienti.tiscali.it.
	[94.39.191.51])
	by smtp.gmail.com with ESMTPSA id f21sm3258597wra.5.2017.06.15.03.53.20
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 15 Jun 2017 03:53:20 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:30 +0200
Message-Id: <1497523981-38449-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 10/41] megasas: do not read DCMD opcode more
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

Avoid TOC-TOU bugs by storing the DCMD opcode in the MegasasCmd

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/megasas.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index c353118..a3f75c1 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -63,6 +63,7 @@ typedef struct MegasasCmd {
 
     hwaddr pa;
     hwaddr pa_size;
+    uint32_t dcmd_opcode;
     union mfi_frame *frame;
     SCSIRequest *req;
     QEMUSGList qsg;
@@ -513,6 +514,7 @@ static MegasasCmd *megasas_enqueue_frame(MegasasState *s,
         cmd->context &= (uint64_t)0xFFFFFFFF;
     }
     cmd->count = count;
+    cmd->dcmd_opcode = -1;
     s->busy++;
 
     if (s->consumer_pa) {
@@ -1562,22 +1564,21 @@ static const struct dcmd_cmd_tbl_t {
 
 static int megasas_handle_dcmd(MegasasState *s, MegasasCmd *cmd)
 {
-    int opcode;
     int retval = 0;
     size_t len;
     const struct dcmd_cmd_tbl_t *cmdptr = dcmd_cmd_tbl;
 
-    opcode = le32_to_cpu(cmd->frame->dcmd.opcode);
-    trace_megasas_handle_dcmd(cmd->index, opcode);
+    cmd->dcmd_opcode = le32_to_cpu(cmd->frame->dcmd.opcode);
+    trace_megasas_handle_dcmd(cmd->index, cmd->dcmd_opcode);
     if (megasas_map_dcmd(s, cmd) < 0) {
         return MFI_STAT_MEMORY_NOT_AVAILABLE;
     }
-    while (cmdptr->opcode != -1 && cmdptr->opcode != opcode) {
+    while (cmdptr->opcode != -1 && cmdptr->opcode != cmd->dcmd_opcode) {
         cmdptr++;
     }
     len = cmd->iov_size;
     if (cmdptr->opcode == -1) {
-        trace_megasas_dcmd_unhandled(cmd->index, opcode, len);
+        trace_megasas_dcmd_unhandled(cmd->index, cmd->dcmd_opcode, len);
         retval = megasas_dcmd_dummy(s, cmd);
     } else {
         trace_megasas_dcmd_enter(cmd->index, cmdptr->desc, len);
@@ -1592,13 +1593,11 @@ static int megasas_handle_dcmd(MegasasState *s, MegasasCmd *cmd)
 static int megasas_finish_internal_dcmd(MegasasCmd *cmd,
                                         SCSIRequest *req)
 {
-    int opcode;
     int retval = MFI_STAT_OK;
     int lun = req->lun;
 
-    opcode = le32_to_cpu(cmd->frame->dcmd.opcode);
-    trace_megasas_dcmd_internal_finish(cmd->index, opcode, lun);
-    switch (opcode) {
+    trace_megasas_dcmd_internal_finish(cmd->index, cmd->dcmd_opcode, lun);
+    switch (cmd->dcmd_opcode) {
     case MFI_DCMD_PD_GET_INFO:
         retval = megasas_pd_get_info_submit(req->dev, lun, cmd);
         break;
@@ -1606,7 +1605,7 @@ static int megasas_finish_internal_dcmd(MegasasCmd *cmd,
         retval = megasas_ld_get_info_submit(req->dev, lun, cmd);
         break;
     default:
-        trace_megasas_dcmd_internal_invalid(cmd->index, opcode);
+        trace_megasas_dcmd_internal_invalid(cmd->index, cmd->dcmd_opcode);
         retval = MFI_STAT_INVALID_DCMD;
         break;
     }
@@ -1827,7 +1826,6 @@ static void megasas_xfer_complete(SCSIRequest *req, uint32_t len)
 {
     MegasasCmd *cmd = req->hba_private;
     uint8_t *buf;
-    uint32_t opcode;
 
     trace_megasas_io_complete(cmd->index, len);
 
@@ -1837,8 +1835,7 @@ static void megasas_xfer_complete(SCSIRequest *req, uint32_t len)
     }
 
     buf = scsi_req_get_buf(req);
-    opcode = le32_to_cpu(cmd->frame->dcmd.opcode);
-    if (opcode == MFI_DCMD_PD_GET_INFO && cmd->iov_buf) {
+    if (cmd->dcmd_opcode == MFI_DCMD_PD_GET_INFO && cmd->iov_buf) {
         struct mfi_pd_info *info = cmd->iov_buf;
 
         if (info->inquiry_data[0] == 0x7f) {
@@ -1849,7 +1846,7 @@ static void megasas_xfer_complete(SCSIRequest *req, uint32_t len)
             memcpy(info->vpd_page83, buf, len);
         }
         scsi_req_continue(req);
-    } else if (opcode == MFI_DCMD_LD_GET_INFO) {
+    } else if (cmd->dcmd_opcode == MFI_DCMD_LD_GET_INFO) {
         struct mfi_ld_info *info = cmd->iov_buf;
 
         if (cmd->iov_buf) {
-- 
1.8.3.1
