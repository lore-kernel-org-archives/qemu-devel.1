Received: from eggs.gnu.org ([2001:4830:134:3::10]:59680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHf4-0003la-DZ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:29:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHey-0005DA-II
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:29:58 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:28:56 +0200
Message-Id: <1505824179-21541-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 07/50] scsi-bus: correct responses for INQUIRY
 and REQUEST SENSE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>, qemu-stable@nongnu.org

From: Hannes Reinecke <hare@suse.de>

According to SPC-3 INQUIRY and REQUEST SENSE should return GOOD
even on unsupported LUNS.

Signed-off-by: Hannes Reinecke <hare@suse.com>
Message-Id: <1503049022-14749-1-git-send-email-hare@suse.de>
Reported-by: Laszlo Ersek <lersek@redhat.com>
Fixes: ded6ddc5a7b95217557fa360913d1213e12d4a6d
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 hw/scsi/scsi-bus.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index e364410..ade31c1 100644
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
1.8.3.1
