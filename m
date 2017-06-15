Received: from eggs.gnu.org ([2001:4830:134:3::10]:40815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSOz-0008DS-1l
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSOx-0007XN-ST
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:25 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSOx-0007Wx-Ja
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:23 -0400
Received: by mail-wr0-x241.google.com with SMTP id x23so2767453wrb.0
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:23 -0700 (PDT)
Received: from 640k.lan (94-39-191-51.adsl-ull.clienti.tiscali.it.
	[94.39.191.51])
	by smtp.gmail.com with ESMTPSA id f21sm3258597wra.5.2017.06.15.03.53.21
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 15 Jun 2017 03:53:21 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:31 +0200
Message-Id: <1497523981-38449-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 11/41] megasas: do not read command more than
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

Avoid TOC-TOU bugs by passing the frame_cmd down, and checking
cmd->dcmd_opcode instead of cmd->frame->header.frame_cmd.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/megasas.c | 60 +++++++++++++++++++++++--------------------------------
 1 file changed, 25 insertions(+), 35 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index a3f75c1..38e0a2f 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -1591,12 +1591,13 @@ static int megasas_handle_dcmd(MegasasState *s, MegasasCmd *cmd)
 }
 
 static int megasas_finish_internal_dcmd(MegasasCmd *cmd,
-                                        SCSIRequest *req)
+                                        SCSIRequest *req, size_t resid)
 {
     int retval = MFI_STAT_OK;
     int lun = req->lun;
 
     trace_megasas_dcmd_internal_finish(cmd->index, cmd->dcmd_opcode, lun);
+    cmd->iov_size -= resid;
     switch (cmd->dcmd_opcode) {
     case MFI_DCMD_PD_GET_INFO:
         retval = megasas_pd_get_info_submit(req->dev, lun, cmd);
@@ -1649,11 +1650,12 @@ static int megasas_enqueue_req(MegasasCmd *cmd, bool is_write)
 }
 
 static int megasas_handle_scsi(MegasasState *s, MegasasCmd *cmd,
-                               bool is_logical)
+                               int frame_cmd)
 {
     uint8_t *cdb;
     bool is_write;
     struct SCSIDevice *sdev = NULL;
+    bool is_logical = (frame_cmd == MFI_CMD_LD_SCSI_IO);
 
     cdb = cmd->frame->pass.cdb;
 
@@ -1661,7 +1663,7 @@ static int megasas_handle_scsi(MegasasState *s, MegasasCmd *cmd,
         if (cmd->frame->header.target_id >= MFI_MAX_LD ||
             cmd->frame->header.lun_id != 0) {
             trace_megasas_scsi_target_not_present(
-                mfi_frame_desc[cmd->frame->header.frame_cmd], is_logical,
+                mfi_frame_desc[frame_cmd], is_logical,
                 cmd->frame->header.target_id, cmd->frame->header.lun_id);
             return MFI_STAT_DEVICE_NOT_FOUND;
         }
@@ -1671,19 +1673,20 @@ static int megasas_handle_scsi(MegasasState *s, MegasasCmd *cmd,
 
     cmd->iov_size = le32_to_cpu(cmd->frame->header.data_len);
     trace_megasas_handle_scsi(mfi_frame_desc[cmd->frame->header.frame_cmd],
-                              is_logical, cmd->frame->header.target_id,
+    trace_megasas_handle_scsi(mfi_frame_desc[frame_cmd], is_logical,
+                              cmd->frame->header.target_id,
                               cmd->frame->header.lun_id, sdev, cmd->iov_size);
 
     if (!sdev || (megasas_is_jbod(s) && is_logical)) {
         trace_megasas_scsi_target_not_present(
-            mfi_frame_desc[cmd->frame->header.frame_cmd], is_logical,
+            mfi_frame_desc[frame_cmd], is_logical,
             cmd->frame->header.target_id, cmd->frame->header.lun_id);
         return MFI_STAT_DEVICE_NOT_FOUND;
     }
 
     if (cmd->frame->header.cdb_len > 16) {
         trace_megasas_scsi_invalid_cdb_len(
-                mfi_frame_desc[cmd->frame->header.frame_cmd], is_logical,
+                mfi_frame_desc[frame_cmd], is_logical,
                 cmd->frame->header.target_id, cmd->frame->header.lun_id,
                 cmd->frame->header.cdb_len);
         megasas_write_sense(cmd, SENSE_CODE(INVALID_OPCODE));
@@ -1703,7 +1706,7 @@ static int megasas_handle_scsi(MegasasState *s, MegasasCmd *cmd,
                             cmd->frame->header.lun_id, cdb, cmd);
     if (!cmd->req) {
         trace_megasas_scsi_req_alloc_failed(
-                mfi_frame_desc[cmd->frame->header.frame_cmd],
+                mfi_frame_desc[frame_cmd],
                 cmd->frame->header.target_id, cmd->frame->header.lun_id);
         megasas_write_sense(cmd, SENSE_CODE(NO_SENSE));
         cmd->frame->header.scsi_status = BUSY;
@@ -1725,11 +1728,11 @@ static int megasas_handle_scsi(MegasasState *s, MegasasCmd *cmd,
     return MFI_STAT_INVALID_STATUS;
 }
 
-static int megasas_handle_io(MegasasState *s, MegasasCmd *cmd)
+static int megasas_handle_io(MegasasState *s, MegasasCmd *cmd, int frame_cmd)
 {
     uint32_t lba_count, lba_start_hi, lba_start_lo;
     uint64_t lba_start;
-    bool is_write = (cmd->frame->header.frame_cmd == MFI_CMD_LD_WRITE);
+    bool is_write = (frame_cmd == MFI_CMD_LD_WRITE);
     uint8_t cdb[16];
     int len;
     struct SCSIDevice *sdev = NULL;
@@ -1746,20 +1749,20 @@ static int megasas_handle_io(MegasasState *s, MegasasCmd *cmd)
     }
 
     trace_megasas_handle_io(cmd->index,
-                            mfi_frame_desc[cmd->frame->header.frame_cmd],
+                            mfi_frame_desc[frame_cmd],
                             cmd->frame->header.target_id,
                             cmd->frame->header.lun_id,
                             (unsigned long)lba_start, (unsigned long)lba_count);
     if (!sdev) {
         trace_megasas_io_target_not_present(cmd->index,
-            mfi_frame_desc[cmd->frame->header.frame_cmd],
+            mfi_frame_desc[frame_cmd],
             cmd->frame->header.target_id, cmd->frame->header.lun_id);
         return MFI_STAT_DEVICE_NOT_FOUND;
     }
 
     if (cmd->frame->header.cdb_len > 16) {
         trace_megasas_scsi_invalid_cdb_len(
-            mfi_frame_desc[cmd->frame->header.frame_cmd], 1,
+            mfi_frame_desc[frame_cmd], 1,
             cmd->frame->header.target_id, cmd->frame->header.lun_id,
             cmd->frame->header.cdb_len);
         megasas_write_sense(cmd, SENSE_CODE(INVALID_OPCODE));
@@ -1781,7 +1784,7 @@ static int megasas_handle_io(MegasasState *s, MegasasCmd *cmd)
                             cmd->frame->header.lun_id, cdb, cmd);
     if (!cmd->req) {
         trace_megasas_scsi_req_alloc_failed(
-            mfi_frame_desc[cmd->frame->header.frame_cmd],
+            mfi_frame_desc[frame_cmd],
             cmd->frame->header.target_id, cmd->frame->header.lun_id);
         megasas_write_sense(cmd, SENSE_CODE(NO_SENSE));
         cmd->frame->header.scsi_status = BUSY;
@@ -1799,23 +1802,11 @@ static int megasas_handle_io(MegasasState *s, MegasasCmd *cmd)
     return MFI_STAT_INVALID_STATUS;
 }
 
-static int megasas_finish_internal_command(MegasasCmd *cmd,
-                                           SCSIRequest *req, size_t resid)
-{
-    int retval = MFI_STAT_INVALID_CMD;
-
-    if (cmd->frame->header.frame_cmd == MFI_CMD_DCMD) {
-        cmd->iov_size -= resid;
-        retval = megasas_finish_internal_dcmd(cmd, req);
-    }
-    return retval;
-}
-
 static QEMUSGList *megasas_get_sg_list(SCSIRequest *req)
 {
     MegasasCmd *cmd = req->hba_private;
 
-    if (cmd->frame->header.frame_cmd == MFI_CMD_DCMD) {
+    if (cmd->dcmd_opcode != -1) {
         return NULL;
     } else {
         return &cmd->qsg;
@@ -1829,7 +1820,7 @@ static void megasas_xfer_complete(SCSIRequest *req, uint32_t len)
 
     trace_megasas_io_complete(cmd->index, len);
 
-    if (cmd->frame->header.frame_cmd != MFI_CMD_DCMD) {
+    if (cmd->dcmd_opcode != -1) {
         scsi_req_continue(req);
         return;
     }
@@ -1872,7 +1863,7 @@ static void megasas_command_complete(SCSIRequest *req, uint32_t status,
         /*
          * Internal command complete
          */
-        cmd_status = megasas_finish_internal_command(cmd, req, resid);
+        cmd_status = megasas_finish_internal_dcmd(cmd, req, resid);
         if (cmd_status == MFI_STAT_INVALID_STATUS) {
             return;
         }
@@ -1943,6 +1934,7 @@ static void megasas_handle_frame(MegasasState *s, uint64_t frame_addr,
 {
     uint8_t frame_status = MFI_STAT_INVALID_CMD;
     uint64_t frame_context;
+    int frame_cmd;
     MegasasCmd *cmd;
 
     /*
@@ -1961,7 +1953,8 @@ static void megasas_handle_frame(MegasasState *s, uint64_t frame_addr,
         s->event_count++;
         return;
     }
-    switch (cmd->frame->header.frame_cmd) {
+    frame_cmd = cmd->frame->header.frame_cmd;
+    switch (frame_cmd) {
     case MFI_CMD_INIT:
         frame_status = megasas_init_firmware(s, cmd);
         break;
@@ -1972,18 +1965,15 @@ static void megasas_handle_frame(MegasasState *s, uint64_t frame_addr,
         frame_status = megasas_handle_abort(s, cmd);
         break;
     case MFI_CMD_PD_SCSI_IO:
-        frame_status = megasas_handle_scsi(s, cmd, 0);
-        break;
     case MFI_CMD_LD_SCSI_IO:
-        frame_status = megasas_handle_scsi(s, cmd, 1);
+        frame_status = megasas_handle_scsi(s, cmd, frame_cmd);
         break;
     case MFI_CMD_LD_READ:
     case MFI_CMD_LD_WRITE:
-        frame_status = megasas_handle_io(s, cmd);
+        frame_status = megasas_handle_io(s, cmd, frame_cmd);
         break;
     default:
-        trace_megasas_unhandled_frame_cmd(cmd->index,
-                                          cmd->frame->header.frame_cmd);
+        trace_megasas_unhandled_frame_cmd(cmd->index, frame_cmd);
         s->event_count++;
         break;
     }
-- 
1.8.3.1
