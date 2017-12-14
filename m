Received: from eggs.gnu.org ([2001:4830:134:3::10]:51991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ePQXs-0001D1-Uy
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 05:15:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ePQXo-0004LD-VQ
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 05:15:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:59088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1ePQXo-0004HG-Oo
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 05:15:12 -0500
From: Hannes Reinecke <hare@suse.de>
Date: Thu, 14 Dec 2017 11:14:35 +0100
Message-Id: <20171214101435.26265-5-hare@suse.de>
In-Reply-To: <20171214101435.26265-1-hare@suse.de>
References: <20171214101435.26265-1-hare@suse.de>
Subject: [Qemu-devel] [PATCH 4/4] scsi: support REPORT_LUNS for LUNs != 0
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

SPC doesn't restrict the use of REPORT LUNS to LUN 0, so we
shouldn't be doing so, either.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 hw/scsi/scsi-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 83497ac916..67ac472c14 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -548,7 +548,7 @@ static int32_t scsi_target_send_command(SCSIRequest *req, uint8_t *buf)
     int fixed_sense = (req->cmd.buf[1] & 1) == 0;
 
     if (req->lun != 0 &&
-        buf[0] != INQUIRY && buf[0] != REQUEST_SENSE) {
+        buf[0] != INQUIRY && buf[0] != REQUEST_SENSE && buf[0] != REPORT_LUNS) {
         scsi_req_build_sense(req, SENSE_CODE(LUN_NOT_SUPPORTED));
         scsi_req_complete(req, CHECK_CONDITION);
         return 0;
-- 
2.12.3
