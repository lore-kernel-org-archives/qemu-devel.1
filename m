Received: from eggs.gnu.org ([2001:4830:134:3::10]:40522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1duT9N-0004KK-Nz
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1duT9I-0005YL-SY
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34158
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1duT9I-0005Xl-Ms
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:45:56 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8K0hcvT015487
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 20:45:56 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d3akjtpaq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 20:45:55 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 19 Sep 2017 20:45:55 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 19 Sep 2017 19:45:19 -0500
In-Reply-To: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
References: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20170920004521.9417-11-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 10/12] scsi-bus: correct responses for INQUIRY
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
Cc: qemu-stable@nongnu.org, Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>, Paolo Bonzini <pbonzini@redhat.com>

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
(cherry picked from commit b07fbce6349c7b84642e7ed56c7a1ac3c1caca61)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
2.11.0
