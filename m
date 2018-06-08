Received: from eggs.gnu.org ([2001:4830:134:3::10]:48239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fRNfy-00005V-2K
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 16:07:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fRNfw-0007MU-Rl
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 16:07:58 -0400
Received: from mail-qk0-x22e.google.com ([2607:f8b0:400d:c09::22e]:35098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1fRNfw-0007MJ-ME
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 16:07:56 -0400
Received: by mail-qk0-x22e.google.com with SMTP id d130-v6so9525521qkc.2
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 13:07:56 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Fri,  8 Jun 2018 17:07:39 -0300
Message-Id: <20180608200740.24915-3-danielhb413@gmail.com>
In-Reply-To: <20180608200740.24915-1-danielhb413@gmail.com>
References: <20180608200740.24915-1-danielhb413@gmail.com>
Subject: [Qemu-devel] [PATCH v1 2/3] scsi-block: add VPD Block Limits in
 INQUIRY Supported Pages reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>

The previous commit added Block Limits emulation for scsi-block devices
if the underlying hardware does not implement it. But this is not
enough to fix the issue of max_io_sectors mismatch between the
guest and the host - the guest is not aware of the Block
Limits support we're now providing.

This patch changes the INQUIRY Supported Pages reply to add Block
Limits support. If the host device already supports it, nothing changes.
If it doesn't, add it manually in the reply.

With this patch, the guest now queries the Block Limits page during the
device configuration because it is being advertised in the Supported
Pages response. It will either receive the Block Limits page from the
hardware, if it supports it, or will receive an emulated response
from QEMU. At any rate, the guest now has the information to set the
max_sectors_kb parameter accordingly, sparing the user of SCSI sense
errors that would happen without the emulated response and in the absence
of Block Limits support from the hardware.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1566195
Reported-by: Dac Nguyen <dacng@us.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/scsi/scsi-generic.c | 80 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 52 insertions(+), 28 deletions(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 579872908c..64d3b79518 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -244,7 +244,8 @@ static void scsi_read_complete(void * opaque, int ret)
     SCSIGenericReq *r = (SCSIGenericReq *)opaque;
     SCSIDevice *s = r->req.dev;
     SCSISense sense;
-    int len;
+    uint8_t page, page_len;
+    int len, i;
 
     assert(r->req.aiocb != NULL);
     r->req.aiocb = NULL;
@@ -315,33 +316,56 @@ static void scsi_read_complete(void * opaque, int ret)
                 s->scsi_version = r->buf[2];
             }
         }
-        if (s->type == TYPE_DISK && r->req.cmd.buf[2] == 0xb0) {
-            /*
-             * Take a look to see if this VPD Block Limits request will
-             * result in a sense error in scsi_command_complete_noio.
-             * In this case, emulate a valid VPD response.
-             *
-             * After that, given that now there are valid contents in the
-             * buffer, clean up the io_header to avoid firing up the
-             * sense error.
-             */
-            if (sg_io_sense_from_errno(-ret, &r->io_header, &sense)) {
-                r->buflen = scsi_emulate_vpd_bl_page(s, r->buf);
-                r->io_header.sb_len_wr = 0;
-
-                /* Clean sg_io_sense */
-                r->io_header.driver_status = 0;
-                r->io_header.status = 0;
-
-            }  else {
-                uint32_t max_transfer =
-                    blk_get_max_transfer(s->conf.blk) / s->blocksize;
-
-                assert(max_transfer);
-                stl_be_p(&r->buf[8], max_transfer);
-                /* Also take care of the opt xfer len. */
-                stl_be_p(&r->buf[12],
-                         MIN_NON_ZERO(max_transfer, ldl_be_p(&r->buf[12])));
+        if (s->type == TYPE_DISK && (r->req.cmd.buf[1] & 0x01)) {
+            page = r->req.cmd.buf[2];
+            if (page == 0xb0) {
+                /*
+                 * Take a look to see if this VPD Block Limits request will
+                 * result in a sense error in scsi_command_complete_noio.
+                 * In this case, emulate a valid VPD response.
+                 *
+                 * After that, given that now there are valid contents in
+                 * the buffer, clean up the io_header to avoid firing up
+                 * the sense error.
+                 */
+                if (sg_io_sense_from_errno(-ret, &r->io_header, &sense)) {
+                    r->buflen = scsi_emulate_vpd_bl_page(s, r->buf);
+                    r->io_header.sb_len_wr = 0;
+
+                    /* Clean sg_io_sense */
+                    r->io_header.driver_status = 0;
+                    r->io_header.status = 0;
+
+                }  else {
+                    uint32_t max_transfer =
+                        blk_get_max_transfer(s->conf.blk) / s->blocksize;
+
+                    assert(max_transfer);
+                    stl_be_p(&r->buf[8], max_transfer);
+                    /* Also take care of the opt xfer len. */
+                    stl_be_p(&r->buf[12],
+                             MIN_NON_ZERO(max_transfer, ldl_be_p(&r->buf[12])));
+                }
+            } else if (page == 0x00) {
+                /*
+                 * Now we're capable of supplying the VPD Block Limits
+                 * response if the hardware can't. Inspect if the INQUIRY
+                 * response contains support for the VPD Block Limits page.
+                 * Add it if it doesn't.
+                 *
+                 * This way, the guest kernel will be aware of the support
+                 * and will use it to proper setup the SCSI device.
+                 */
+                page_len = r->buf[3];
+                for (i = 4; i < page_len + 4; i++) {
+                    if (r->buf[i] == 0xb0) {
+                        break;
+                    }
+                }
+                if (i == page_len + 4) {
+                    r->buf[i] = 0xb0;
+                    r->buf[3] = ++page_len;
+                }
             }
         }
     }
-- 
2.14.3
