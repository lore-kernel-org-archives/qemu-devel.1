Received: from eggs.gnu.org ([2001:4830:134:3::10]:56762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fdeVk-0004gV-8b
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 12:32:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fdeVj-000678-97
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 12:32:08 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 12 Jul 2018 18:31:51 +0200
Message-Id: <20180712163152.12521-7-kwolf@redhat.com>
In-Reply-To: <20180712163152.12521-1-kwolf@redhat.com>
References: <20180712163152.12521-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 6/7] scsi-disk: Block Device Characteristics
 emulation fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Daniel Henrique Barboza <danielhb413@gmail.com>

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
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/scsi/scsi-disk.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index d7df357029..5bb390773b 100644
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
2.13.6
