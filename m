Received: from eggs.gnu.org ([2001:4830:134:3::10]:49394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ddY68-0005HJ-5a
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 04:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ddY63-00067I-KW
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 04:36:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:50539 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1ddY63-00065L-DV
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 04:36:39 -0400
From: Hannes Reinecke <hare@suse.de>
Date: Fri,  4 Aug 2017 10:36:34 +0200
Message-Id: <1501835795-92331-4-git-send-email-hare@suse.de>
In-Reply-To: <1501835795-92331-1-git-send-email-hare@suse.de>
References: <1501835795-92331-1-git-send-email-hare@suse.de>
Subject: [Qemu-devel] [PATCHv2 3/4] scsi: clarify sense codes for LUN0
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>

The LUN0 emulation is just that, an emulation for a non-existing
LUN0. So we should be returning LUN_NOT_SUPPORTED for any request
coming from any other LUN.
And we should be aborting unhandled commands with INVALID OPCODE,
not LUN NOT SUPPORTED.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 hw/scsi/scsi-bus.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 8419c75..79a222f 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -583,6 +583,11 @@ static int32_t scsi_target_send_command(SCSIRequest *req, uint8_t *buf)
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
@@ -613,7 +618,7 @@ static int32_t scsi_target_send_command(SCSIRequest *req, uint8_t *buf)
     case TEST_UNIT_READY:
         break;
     default:
-        scsi_req_build_sense(req, SENSE_CODE(LUN_NOT_SUPPORTED));
+        scsi_req_build_sense(req, SENSE_CODE(INVALID_OPCODE));
         scsi_req_complete(req, CHECK_CONDITION);
         return 0;
     illegal_request:
-- 
1.8.5.6
