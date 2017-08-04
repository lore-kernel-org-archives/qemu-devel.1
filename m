Received: from eggs.gnu.org ([2001:4830:134:3::10]:49398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ddY68-0005HO-6C
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 04:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ddY63-00067O-LT
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 04:36:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:50541 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1ddY63-00065Q-Dp
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 04:36:39 -0400
From: Hannes Reinecke <hare@suse.de>
Date: Fri,  4 Aug 2017 10:36:32 +0200
Message-Id: <1501835795-92331-2-git-send-email-hare@suse.de>
In-Reply-To: <1501835795-92331-1-git-send-email-hare@suse.de>
References: <1501835795-92331-1-git-send-email-hare@suse.de>
Subject: [Qemu-devel] [PATCHv2 1/4] scsi: Make LUN 0 a simple enclosure
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

Instead of having an 'invisible' LUN0 (in case LUN 0 is not connected)
this patch maks LUN0 a enclosure service, exposing it to the OS.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 hw/scsi/scsi-bus.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 23c51de..c89e82d 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -493,10 +493,11 @@ static bool scsi_target_emulate_inquiry(SCSITargetReq *r)
     if (r->req.lun != 0) {
         r->buf[0] = TYPE_NO_LUN;
     } else {
-        r->buf[0] = TYPE_NOT_PRESENT | TYPE_INACTIVE;
+        r->buf[0] = TYPE_ENCLOSURE;
         r->buf[2] = 5; /* Version */
         r->buf[3] = 2 | 0x10; /* HiSup, response data format */
         r->buf[4] = r->len - 5; /* Additional Length = (Len - 1) - 4 */
+        r->buf[6] = 0x40; /* Enclosure service */
         r->buf[7] = 0x10 | (r->req.bus->info->tcq ? 0x02 : 0); /* Sync, TCQ.  */
         memcpy(&r->buf[8], "QEMU    ", 8);
         memcpy(&r->buf[16], "QEMU TARGET     ", 16);
@@ -505,6 +506,54 @@ static bool scsi_target_emulate_inquiry(SCSITargetReq *r)
     return true;
 }
 
+static bool scsi_target_emulate_receive_diagnostic(SCSITargetReq *r)
+{
+    uint8_t page_code = r->req.cmd.buf[2];
+    unsigned char *enc_desc, *type_desc;
+
+    assert(r->req.dev->lun != r->req.lun);
+
+    scsi_target_alloc_buf(&r->req, 0x38);
+
+    switch (page_code) {
+    case 0x00:
+        r->buf[r->len++] = page_code ; /* this page */
+        r->buf[r->len++] = 0x00;
+        r->buf[r->len++] = 0x00;
+        r->buf[r->len++] = 0x03;
+        r->buf[r->len++] = 0x00;
+        r->buf[r->len++] = 0x01;
+        r->buf[r->len++] = 0x08;
+        break;
+    case 0x01:
+        memset(r->buf, 0, 0x38);
+        r->buf[0] = page_code;
+        r->buf[3] = 0x30;
+        enc_desc = &r->buf[8];
+        enc_desc[0] = 0x09;
+        enc_desc[2] = 1;
+        enc_desc[3] = 0x24;
+        memcpy(&enc_desc[12], "QEMU    ", 8);
+        memcpy(&enc_desc[20], "QEMU TARGET     ", 16);
+        pstrcpy((char *)&enc_desc[36], 4, qemu_hw_version());
+        type_desc = &r->buf[48];
+        type_desc[1] = 1;
+        r->len = 0x38;
+        break;
+    case 0x08:
+        r->buf[0] = page_code;
+        r->buf[1] = 0x00;
+        r->buf[2] = 0x00;
+        r->buf[3] = 0x00;
+        r->len = 4;
+        break;
+    default:
+        return false;
+    }
+    r->len = MIN(r->req.cmd.xfer, r->len);
+    return true;
+}
+
 static size_t scsi_sense_len(SCSIRequest *req)
 {
     if (req->dev->type == TYPE_SCANNER)
@@ -528,6 +577,11 @@ static int32_t scsi_target_send_command(SCSIRequest *req, uint8_t *buf)
             goto illegal_request;
         }
         break;
+    case RECEIVE_DIAGNOSTIC:
+        if (!scsi_target_emulate_receive_diagnostic(r)) {
+            goto illegal_request;
+        }
+        break;
     case REQUEST_SENSE:
         scsi_target_alloc_buf(&r->req, scsi_sense_len(req));
         r->len = scsi_device_get_sense(r->req.dev, r->buf,
-- 
1.8.5.6
