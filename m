Received: from eggs.gnu.org ([2001:4830:134:3::10]:38563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fdMCo-0000f6-IU
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 16:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fdMCn-0005ge-Go
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 16:59:22 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:41826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1fdMCn-0005ff-Ck
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 16:59:21 -0400
Received: by mail-qt0-x241.google.com with SMTP id e19-v6so8129822qtp.8
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 13:59:21 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Wed, 11 Jul 2018 17:58:13 -0300
Message-Id: <20180711205813.22346-1-danielhb413@gmail.com>
Subject: [Qemu-devel] [PATCH v1 1/1] scsi-disk: Block Device Characteristics
 emulation fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>

The current BDC VPD page (page 0xb1) is too short. This can be
seen running sg_utils:

$ sg_vpd --page=bdc /dev/sda
Block device characteristics VPD page (SBC):
Block device characteristics VPD page length too short=8

By the SCSI spec, the expected size of the SBC page is 0x40.
There is no telling how the guest will behave with a shorter
message - it can ignore it, or worse, make (wrong)
assumptions.

This patch fixes the emulation by setting the size to 0x40.
This is the output of the previous sg_vpd command after
applying it:

$ sg_vpd --page=bdc /dev/sda -v
    inquiry cdb: 12 01 b1 00 fc 00
Block device characteristics VPD page (SBC):
   [PQual=0  Peripheral device type: disk]
  Medium rotation rate is not reported
  Product type: Not specified
  WABEREQ=0
  WACEREQ=0
  Nominal form factor not reported
  FUAB=0
  VBULS=0

To improve readability, this patch also adds the VBULS value
explictly and add comments on the existing fields we're
setting.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/scsi/scsi-disk.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 32f3f96ff8..5ae7baa082 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -775,11 +775,12 @@ int scsi_disk_emulate_vpd_page(SCSIRequest *req, uint8_t *outbuf)
     }
     case 0xb1: /* block device characteristics */
     {
-        buflen = 8;
+        buflen = 0x40;
         outbuf[4] = (s->rotation_rate >> 8) & 0xff;
         outbuf[5] = s->rotation_rate & 0xff;
-        outbuf[6] = 0;
-        outbuf[7] = 0;
+        outbuf[6] = 0; /* PRODUCT TYPE */
+        outbuf[7] = 0; /* WABEREQ | WACEREQ | NOMINAL FORM FACTOR */
+        outbuf[8] = 0; /* VBULS */
         break;
     }
     case 0xb2: /* thin provisioning */
-- 
2.17.1
