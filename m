Received: from eggs.gnu.org ([2001:4830:134:3::10]:60928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1df6S5-00017r-Is
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1df6S4-0006fZ-GU
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:29:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1df6S4-0006f3-AE
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:29:48 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  8 Aug 2017 17:29:36 +0200
Message-Id: <20170808152941.11247-5-pbonzini@redhat.com>
In-Reply-To: <20170808152941.11247-1-pbonzini@redhat.com>
References: <20170808152941.11247-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 4/9] scsi: clarify sense codes for LUN0 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>

From: Hannes Reinecke <hare@suse.de>

The LUN0 emulation is just that, an emulation for a non-existing
LUN0. So we should be returning LUN_NOT_SUPPORTED for any request
coming from any other LUN.
And we should be aborting unhandled commands with INVALID OPCODE,
not LUN NOT SUPPORTED.

Signed-off-by: Hannes Reinecke <hare@suse.com>
Message-Id: <1501835795-92331-4-git-send-email-hare@suse.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-bus.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 23c51de66a..e364410a23 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -517,6 +517,11 @@ static int32_t scsi_target_send_command(SCSIRequest *req, uint8_t *buf)
 {
     SCSITargetReq *r = DO_UPCAST(SCSITargetReq, req, req);
 
+    if (req->lun != 0) {
+        scsi_req_build_sense(req, SENSE_CODE(LUN_NOT_SUPPORTED));
+        scsi_req_complete(req, CHECK_CONDITION);
+        return 0;
+    }
     switch (buf[0]) {
     case REPORT_LUNS:
         if (!scsi_target_emulate_report_luns(r)) {
@@ -542,7 +547,7 @@ static int32_t scsi_target_send_command(SCSIRequest *req, uint8_t *buf)
     case TEST_UNIT_READY:
         break;
     default:
-        scsi_req_build_sense(req, SENSE_CODE(LUN_NOT_SUPPORTED));
+        scsi_req_build_sense(req, SENSE_CODE(INVALID_OPCODE));
         scsi_req_complete(req, CHECK_CONDITION);
         return 0;
     illegal_request:
-- 
2.13.3
