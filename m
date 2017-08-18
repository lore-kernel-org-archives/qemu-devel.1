Received: from eggs.gnu.org ([2001:4830:134:3::10]:54908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1didiL-0006vF-70
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 05:37:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1didiI-0000B9-3p
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 05:37:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:49712 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1didiH-0000Am-TN
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 05:37:10 -0400
From: Hannes Reinecke <hare@suse.de>
Date: Fri, 18 Aug 2017 11:37:02 +0200
Message-Id: <1503049022-14749-1-git-send-email-hare@suse.de>
Subject: [Qemu-devel] [PATCH] scsi-bus: correct responses for INQUIRY and
 REQUEST SENSE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Lazlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>

According to SPC-3 INQUIRY and REQUEST SENSE should return GOOD
even on unsupported LUNS.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 hw/scsi/scsi-bus.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index e364410a23..ade31c11f5 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -516,8 +516,10 @@ static size_t scsi_sense_len(SCSIRequest *req)
 static int32_t scsi_target_send_command(SCSIRequest *req, uint8_t *buf)
 {
     SCSITargetReq *r = DO_UPCAST(SCSITargetReq, req, req);
+    int fixed_sense = (req->cmd.buf[1] & 1) == 0;
 
-    if (req->lun != 0) {
+    if (req->lun != 0 &&
+        buf[0] != INQUIRY && buf[0] != REQUEST_SENSE) {
         scsi_req_build_sense(req, SENSE_CODE(LUN_NOT_SUPPORTED));
         scsi_req_complete(req, CHECK_CONDITION);
         return 0;
@@ -535,9 +537,28 @@ static int32_t scsi_target_send_command(SCSIRequest *req, uint8_t *buf)
         break;
     case REQUEST_SENSE:
         scsi_target_alloc_buf(&r->req, scsi_sense_len(req));
-        r->len = scsi_device_get_sense(r->req.dev, r->buf,
-                                       MIN(req->cmd.xfer, r->buf_len),
-                                       (req->cmd.buf[1] & 1) == 0);
+        if (req->lun != 0) {
+            const struct SCSISense sense = SENSE_CODE(LUN_NOT_SUPPORTED);
+
+            if (fixed_sense) {
+                r->buf[0] = 0x70;
+                r->buf[2] = sense.key;
+                r->buf[10] = 10;
+                r->buf[12] = sense.asc;
+                r->buf[13] = sense.ascq;
+                r->len = MIN(req->cmd.xfer, SCSI_SENSE_LEN);
+            } else {
+                r->buf[0] = 0x72;
+                r->buf[1] = sense.key;
+                r->buf[2] = sense.asc;
+                r->buf[3] = sense.ascq;
+                r->len = 8;
+            }
+        } else {
+            r->len = scsi_device_get_sense(r->req.dev, r->buf,
+                                           MIN(req->cmd.xfer, r->buf_len),
+                                           fixed_sense);
+        }
         if (r->req.dev->sense_is_ua) {
             scsi_device_unit_attention_reported(req->dev);
             r->req.dev->sense_len = 0;
-- 
2.12.0
