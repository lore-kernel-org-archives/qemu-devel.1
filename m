Received: from eggs.gnu.org ([2001:4830:134:3::10]:56987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIDQy-0001wW-89
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 08:18:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIDQw-0005I1-Tc
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 08:18:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dIDQw-0005Hp-LH
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 08:18:02 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Jun 2017 14:17:46 +0200
Message-Id: <20170606121747.25356-7-pbonzini@redhat.com>
In-Reply-To: <20170606121747.25356-1-pbonzini@redhat.com>
References: <20170606121747.25356-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 6/7] megasas: do not read SCSI req parameters
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
Cc: zyy4013@stu.ouc.edu.cn, ppandit@redhat.com, hare@suse.de

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/megasas.c | 60 ++++++++++++++++++++++++-------------------------------
 1 file changed, 26 insertions(+), 34 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 38e0a2f5ef..135662df31 100644
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
2.13.0
