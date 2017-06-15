Received: from eggs.gnu.org ([2001:4830:134:3::10]:40832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSP0-0008E8-Iz
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSOz-0007Xz-FO
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:26 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:33445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSOz-0007Xl-61
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:25 -0400
Received: by mail-wr0-x243.google.com with SMTP id x23so2767556wrb.0
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:24 -0700 (PDT)
Received: from 640k.lan (94-39-191-51.adsl-ull.clienti.tiscali.it.
	[94.39.191.51])
	by smtp.gmail.com with ESMTPSA id f21sm3258597wra.5.2017.06.15.03.53.22
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 15 Jun 2017 03:53:23 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:32 +0200
Message-Id: <1497523981-38449-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 12/41] megasas: do not read SCSI req parameters
 more than once from frame
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/megasas.c | 60 ++++++++++++++++++++++++-------------------------------
 1 file changed, 26 insertions(+), 34 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 38e0a2f..135662d 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -1653,42 +1653,39 @@ static int megasas_handle_scsi(MegasasState *s, MegasasCmd *cmd,
                                int frame_cmd)
 {
     uint8_t *cdb;
+    int target_id, lun_id, cdb_len;
     bool is_write;
     struct SCSIDevice *sdev = NULL;
     bool is_logical = (frame_cmd == MFI_CMD_LD_SCSI_IO);
 
     cdb = cmd->frame->pass.cdb;
+    target_id = cmd->frame->header.target_id;
+    lun_id = cmd->frame->header.lun_id;
+    cdb_len = cmd->frame->header.cdb_len;
 
     if (is_logical) {
-        if (cmd->frame->header.target_id >= MFI_MAX_LD ||
-            cmd->frame->header.lun_id != 0) {
+        if (target_id >= MFI_MAX_LD || lun_id != 0) {
             trace_megasas_scsi_target_not_present(
-                mfi_frame_desc[frame_cmd], is_logical,
-                cmd->frame->header.target_id, cmd->frame->header.lun_id);
+                mfi_frame_desc[frame_cmd], is_logical, target_id, lun_id);
             return MFI_STAT_DEVICE_NOT_FOUND;
         }
     }
-    sdev = scsi_device_find(&s->bus, 0, cmd->frame->header.target_id,
-                            cmd->frame->header.lun_id);
+    sdev = scsi_device_find(&s->bus, 0, target_id, lun_id);
 
     cmd->iov_size = le32_to_cpu(cmd->frame->header.data_len);
-    trace_megasas_handle_scsi(mfi_frame_desc[cmd->frame->header.frame_cmd],
     trace_megasas_handle_scsi(mfi_frame_desc[frame_cmd], is_logical,
-                              cmd->frame->header.target_id,
-                              cmd->frame->header.lun_id, sdev, cmd->iov_size);
+                              target_id, lun_id, sdev, cmd->iov_size);
 
     if (!sdev || (megasas_is_jbod(s) && is_logical)) {
         trace_megasas_scsi_target_not_present(
-            mfi_frame_desc[frame_cmd], is_logical,
-            cmd->frame->header.target_id, cmd->frame->header.lun_id);
+            mfi_frame_desc[frame_cmd], is_logical, target_id, lun_id);
         return MFI_STAT_DEVICE_NOT_FOUND;
     }
 
-    if (cmd->frame->header.cdb_len > 16) {
+    if (cdb_len > 16) {
         trace_megasas_scsi_invalid_cdb_len(
                 mfi_frame_desc[frame_cmd], is_logical,
-                cmd->frame->header.target_id, cmd->frame->header.lun_id,
-                cmd->frame->header.cdb_len);
+                target_id, lun_id, cdb_len);
         megasas_write_sense(cmd, SENSE_CODE(INVALID_OPCODE));
         cmd->frame->header.scsi_status = CHECK_CONDITION;
         s->event_count++;
@@ -1702,12 +1699,10 @@ static int megasas_handle_scsi(MegasasState *s, MegasasCmd *cmd,
         return MFI_STAT_SCSI_DONE_WITH_ERROR;
     }
 
-    cmd->req = scsi_req_new(sdev, cmd->index,
-                            cmd->frame->header.lun_id, cdb, cmd);
+    cmd->req = scsi_req_new(sdev, cmd->index, lun_id, cdb, cmd);
     if (!cmd->req) {
         trace_megasas_scsi_req_alloc_failed(
-                mfi_frame_desc[frame_cmd],
-                cmd->frame->header.target_id, cmd->frame->header.lun_id);
+                mfi_frame_desc[frame_cmd], target_id, lun_id);
         megasas_write_sense(cmd, SENSE_CODE(NO_SENSE));
         cmd->frame->header.scsi_status = BUSY;
         s->event_count++;
@@ -1736,35 +1731,33 @@ static int megasas_handle_io(MegasasState *s, MegasasCmd *cmd, int frame_cmd)
     uint8_t cdb[16];
     int len;
     struct SCSIDevice *sdev = NULL;
+    int target_id, lun_id, cdb_len;
 
     lba_count = le32_to_cpu(cmd->frame->io.header.data_len);
     lba_start_lo = le32_to_cpu(cmd->frame->io.lba_lo);
     lba_start_hi = le32_to_cpu(cmd->frame->io.lba_hi);
     lba_start = ((uint64_t)lba_start_hi << 32) | lba_start_lo;
 
-    if (cmd->frame->header.target_id < MFI_MAX_LD &&
-        cmd->frame->header.lun_id == 0) {
-        sdev = scsi_device_find(&s->bus, 0, cmd->frame->header.target_id,
-                                cmd->frame->header.lun_id);
+    target_id = cmd->frame->header.target_id;
+    lun_id = cmd->frame->header.lun_id;
+    cdb_len = cmd->frame->header.cdb_len;
+
+    if (target_id < MFI_MAX_LD && lun_id == 0) {
+        sdev = scsi_device_find(&s->bus, 0, target_id, lun_id);
     }
 
     trace_megasas_handle_io(cmd->index,
-                            mfi_frame_desc[frame_cmd],
-                            cmd->frame->header.target_id,
-                            cmd->frame->header.lun_id,
+                            mfi_frame_desc[frame_cmd], target_id, lun_id,
                             (unsigned long)lba_start, (unsigned long)lba_count);
     if (!sdev) {
         trace_megasas_io_target_not_present(cmd->index,
-            mfi_frame_desc[frame_cmd],
-            cmd->frame->header.target_id, cmd->frame->header.lun_id);
+            mfi_frame_desc[frame_cmd], target_id, lun_id);
         return MFI_STAT_DEVICE_NOT_FOUND;
     }
 
-    if (cmd->frame->header.cdb_len > 16) {
+    if (cdb_len > 16) {
         trace_megasas_scsi_invalid_cdb_len(
-            mfi_frame_desc[frame_cmd], 1,
-            cmd->frame->header.target_id, cmd->frame->header.lun_id,
-            cmd->frame->header.cdb_len);
+            mfi_frame_desc[frame_cmd], 1, target_id, lun_id, cdb_len);
         megasas_write_sense(cmd, SENSE_CODE(INVALID_OPCODE));
         cmd->frame->header.scsi_status = CHECK_CONDITION;
         s->event_count++;
@@ -1781,11 +1774,10 @@ static int megasas_handle_io(MegasasState *s, MegasasCmd *cmd, int frame_cmd)
 
     megasas_encode_lba(cdb, lba_start, lba_count, is_write);
     cmd->req = scsi_req_new(sdev, cmd->index,
-                            cmd->frame->header.lun_id, cdb, cmd);
+                            lun_id, cdb, cmd);
     if (!cmd->req) {
         trace_megasas_scsi_req_alloc_failed(
-            mfi_frame_desc[frame_cmd],
-            cmd->frame->header.target_id, cmd->frame->header.lun_id);
+            mfi_frame_desc[frame_cmd], target_id, lun_id);
         megasas_write_sense(cmd, SENSE_CODE(NO_SENSE));
         cmd->frame->header.scsi_status = BUSY;
         s->event_count++;
-- 
1.8.3.1
