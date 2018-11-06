Received: from eggs.gnu.org ([2001:4830:134:3::10]:41308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gK9Ck-0003Nh-MJ
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:48:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gK93W-0001Py-GF
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:38:45 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:32881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gK93V-0000Zn-Hv
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:38:38 -0500
Received: by mail-wr1-x444.google.com with SMTP id u9-v6so4866022wrr.0
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 13:38:23 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	l186-v6sm3223526wma.13.2018.11.06.13.38.21
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 06 Nov 2018 13:38:21 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Nov 2018 22:38:00 +0100
Message-Id: <1541540283-45699-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1541540283-45699-1-git-send-email-pbonzini@redhat.com>
References: <1541540283-45699-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 14/17] scsi-generic: avoid invalid access to
 struct when emulating block limits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Emulation of the block limits VPD page called back into scsi-disk.c,
which however expected the request to be for a SCSIDiskState and
accessed a scsi-generic device outside the bounds of its struct
(namely to retrieve s->max_unmap_size and s->max_io_size).

To avoid this, move the emulation code to a separate function that
takes a new SCSIBlockLimits struct and marshals it into the VPD
response format.

Reported-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/Makefile.objs       |  2 +-
 hw/scsi/emulation.c         | 42 +++++++++++++++++++++
 hw/scsi/scsi-disk.c         | 92 ++++++++++-----------------------------------
 hw/scsi/scsi-generic.c      | 35 ++++++++++++-----
 include/hw/scsi/emulation.h | 16 ++++++++
 include/hw/scsi/scsi.h      |  1 -
 6 files changed, 104 insertions(+), 84 deletions(-)
 create mode 100644 hw/scsi/emulation.c
 create mode 100644 include/hw/scsi/emulation.h

diff --git a/hw/scsi/Makefile.objs b/hw/scsi/Makefile.objs
index 718b4c2..45167ba 100644
--- a/hw/scsi/Makefile.objs
+++ b/hw/scsi/Makefile.objs
@@ -1,4 +1,4 @@
-common-obj-y += scsi-disk.o
+common-obj-y += scsi-disk.o emulation.o
 common-obj-y += scsi-generic.o scsi-bus.o
 common-obj-$(CONFIG_LSI_SCSI_PCI) += lsi53c895a.o
 common-obj-$(CONFIG_MPTSAS_SCSI_PCI) += mptsas.o mptconfig.o mptendian.o
diff --git a/hw/scsi/emulation.c b/hw/scsi/emulation.c
new file mode 100644
index 0000000..06d62f3
--- /dev/null
+++ b/hw/scsi/emulation.c
@@ -0,0 +1,42 @@
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/bswap.h"
+#include "hw/scsi/emulation.h"
+
+int scsi_emulate_block_limits(uint8_t *outbuf, const SCSIBlockLimits *bl)
+{
+    /* required VPD size with unmap support */
+    memset(outbuf, 0, 0x3c);
+
+    outbuf[0] = bl->wsnz; /* wsnz */
+
+    if (bl->max_io_sectors) {
+        /* optimal transfer length granularity.  This field and the optimal
+         * transfer length can't be greater than maximum transfer length.
+         */
+        stw_be_p(outbuf + 2, MIN(bl->min_io_size, bl->max_io_sectors));
+
+        /* maximum transfer length */
+        stl_be_p(outbuf + 4, bl->max_io_sectors);
+
+        /* optimal transfer length */
+        stl_be_p(outbuf + 8, MIN(bl->opt_io_size, bl->max_io_sectors));
+    } else {
+        stw_be_p(outbuf + 2, bl->min_io_size);
+        stl_be_p(outbuf + 8, bl->opt_io_size);
+    }
+
+    /* max unmap LBA count */
+    stl_be_p(outbuf + 16, bl->max_unmap_sectors);
+
+    /* max unmap descriptors */
+    stl_be_p(outbuf + 20, bl->max_unmap_descr);
+
+    /* optimal unmap granularity; alignment is zero */
+    stl_be_p(outbuf + 24, bl->unmap_sectors);
+
+    /* max write same size, make it the same as maximum transfer length */
+    stl_be_p(outbuf + 36, bl->max_io_sectors);
+
+    return 0x3c;
+}
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index e2c5408..6eb258d 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -33,6 +33,7 @@ do { printf("scsi-disk: " fmt , ## __VA_ARGS__); } while (0)
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/scsi/scsi.h"
+#include "hw/scsi/emulation.h"
 #include "scsi/constants.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/block-backend.h"
@@ -589,7 +590,7 @@ static uint8_t *scsi_get_buf(SCSIRequest *req)
     return (uint8_t *)r->iov.iov_base;
 }
 
-int scsi_disk_emulate_vpd_page(SCSIRequest *req, uint8_t *outbuf)
+static int scsi_disk_emulate_vpd_page(SCSIRequest *req, uint8_t *outbuf)
 {
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
     uint8_t page_code = req->cmd.buf[2];
@@ -691,89 +692,36 @@ int scsi_disk_emulate_vpd_page(SCSIRequest *req, uint8_t *outbuf)
     }
     case 0xb0: /* block limits */
     {
-        unsigned int unmap_sectors =
-            s->qdev.conf.discard_granularity / s->qdev.blocksize;
-        unsigned int min_io_size =
-            s->qdev.conf.min_io_size / s->qdev.blocksize;
-        unsigned int opt_io_size =
-            s->qdev.conf.opt_io_size / s->qdev.blocksize;
-        unsigned int max_unmap_sectors =
-            s->max_unmap_size / s->qdev.blocksize;
-        unsigned int max_io_sectors =
-            s->max_io_size / s->qdev.blocksize;
+        SCSIBlockLimits bl = {};
 
         if (s->qdev.type == TYPE_ROM) {
             DPRINTF("Inquiry (EVPD[%02X] not supported for CDROM\n",
                     page_code);
             return -1;
         }
+        bl.wsnz = 1;
+        bl.unmap_sectors =
+            s->qdev.conf.discard_granularity / s->qdev.blocksize;
+        bl.min_io_size =
+            s->qdev.conf.min_io_size / s->qdev.blocksize;
+        bl.opt_io_size =
+            s->qdev.conf.opt_io_size / s->qdev.blocksize;
+        bl.max_unmap_sectors =
+            s->max_unmap_size / s->qdev.blocksize;
+        bl.max_io_sectors =
+            s->max_io_size / s->qdev.blocksize;
+        /* 255 descriptors fit in 4 KiB with an 8-byte header */
+        bl.max_unmap_descr = 255;
+
         if (s->qdev.type == TYPE_DISK) {
             int max_transfer_blk = blk_get_max_transfer(s->qdev.conf.blk);
             int max_io_sectors_blk =
                 max_transfer_blk / s->qdev.blocksize;
 
-            max_io_sectors =
-                MIN_NON_ZERO(max_io_sectors_blk, max_io_sectors);
-
-            /* min_io_size and opt_io_size can't be greater than
-             * max_io_sectors */
-            if (min_io_size) {
-                min_io_size = MIN(min_io_size, max_io_sectors);
-            }
-            if (opt_io_size) {
-                opt_io_size = MIN(opt_io_size, max_io_sectors);
-            }
+            bl.max_io_sectors =
+                MIN_NON_ZERO(max_io_sectors_blk, bl.max_io_sectors);
         }
-        /* required VPD size with unmap support */
-        buflen = 0x40;
-        memset(outbuf + 4, 0, buflen - 4);
-
-        outbuf[4] = 0x1; /* wsnz */
-
-        /* optimal transfer length granularity */
-        outbuf[6] = (min_io_size >> 8) & 0xff;
-        outbuf[7] = min_io_size & 0xff;
-
-        /* maximum transfer length */
-        outbuf[8] = (max_io_sectors >> 24) & 0xff;
-        outbuf[9] = (max_io_sectors >> 16) & 0xff;
-        outbuf[10] = (max_io_sectors >> 8) & 0xff;
-        outbuf[11] = max_io_sectors & 0xff;
-
-        /* optimal transfer length */
-        outbuf[12] = (opt_io_size >> 24) & 0xff;
-        outbuf[13] = (opt_io_size >> 16) & 0xff;
-        outbuf[14] = (opt_io_size >> 8) & 0xff;
-        outbuf[15] = opt_io_size & 0xff;
-
-        /* max unmap LBA count, default is 1GB */
-        outbuf[20] = (max_unmap_sectors >> 24) & 0xff;
-        outbuf[21] = (max_unmap_sectors >> 16) & 0xff;
-        outbuf[22] = (max_unmap_sectors >> 8) & 0xff;
-        outbuf[23] = max_unmap_sectors & 0xff;
-
-        /* max unmap descriptors, 255 fit in 4 kb with an 8-byte header */
-        outbuf[24] = 0;
-        outbuf[25] = 0;
-        outbuf[26] = 0;
-        outbuf[27] = 255;
-
-        /* optimal unmap granularity */
-        outbuf[28] = (unmap_sectors >> 24) & 0xff;
-        outbuf[29] = (unmap_sectors >> 16) & 0xff;
-        outbuf[30] = (unmap_sectors >> 8) & 0xff;
-        outbuf[31] = unmap_sectors & 0xff;
-
-        /* max write same size */
-        outbuf[36] = 0;
-        outbuf[37] = 0;
-        outbuf[38] = 0;
-        outbuf[39] = 0;
-
-        outbuf[40] = (max_io_sectors >> 24) & 0xff;
-        outbuf[41] = (max_io_sectors >> 16) & 0xff;
-        outbuf[42] = (max_io_sectors >> 8) & 0xff;
-        outbuf[43] = max_io_sectors & 0xff;
+        buflen += scsi_emulate_block_limits(outbuf + buflen, &bl);
         break;
     }
     case 0xb1: /* block device characteristics */
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index c5497bb..b50ce64 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -16,6 +16,7 @@
 #include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "hw/scsi/scsi.h"
+#include "hw/scsi/emulation.h"
 #include "sysemu/block-backend.h"
 
 #ifdef __linux__
@@ -181,7 +182,7 @@ static void scsi_handle_inquiry_reply(SCSIGenericReq *r, SCSIDevice *s)
             /* Also take care of the opt xfer len. */
             stl_be_p(&r->buf[12],
                     MIN_NON_ZERO(max_transfer, ldl_be_p(&r->buf[12])));
-        } else if (page == 0x00 && s->needs_vpd_bl_emulation) {
+        } else if (s->needs_vpd_bl_emulation && page == 0x00) {
             /*
              * Now we're capable of supplying the VPD Block Limits
              * response if the hardware can't. Add it in the INQUIRY
@@ -209,9 +210,24 @@ static void scsi_handle_inquiry_reply(SCSIGenericReq *r, SCSIDevice *s)
     }
 }
 
-static int scsi_emulate_block_limits(SCSIGenericReq *r)
+static int scsi_generic_emulate_block_limits(SCSIGenericReq *r, SCSIDevice *s)
 {
-    r->buflen = scsi_disk_emulate_vpd_page(&r->req, r->buf);
+    int len;
+    uint8_t buf[64];
+
+    SCSIBlockLimits bl = {
+        .max_io_sectors = blk_get_max_transfer(s->conf.blk) / s->blocksize
+    };
+
+    memset(r->buf, 0, r->buflen);
+    stb_p(buf, s->type);
+    stb_p(buf + 1, 0xb0);
+    len = scsi_emulate_block_limits(buf + 4, &bl);
+    assert(len <= sizeof(buf) - 4);
+    stw_be_p(buf + 2, len);
+
+    memcpy(r->buf, buf, MIN(r->buflen, len + 4));
+
     r->io_header.sb_len_wr = 0;
 
     /*
@@ -253,13 +269,12 @@ static void scsi_read_complete(void * opaque, int ret)
      * resulted in sense error but would need emulation.
      * In this case, emulate a valid VPD response.
      */
-    if (s->needs_vpd_bl_emulation) {
-        int is_vpd_bl = r->req.cmd.buf[0] == INQUIRY &&
-                         r->req.cmd.buf[1] & 0x01 &&
-                         r->req.cmd.buf[2] == 0xb0;
-
-        if (is_vpd_bl && sg_io_sense_from_errno(-ret, &r->io_header, &sense)) {
-            len = scsi_emulate_block_limits(r);
+    if (s->needs_vpd_bl_emulation &&
+        r->req.cmd.buf[0] == INQUIRY &&
+        (r->req.cmd.buf[1] & 0x01) &&
+        r->req.cmd.buf[2] == 0xb0) {
+        if (sg_io_sense_from_errno(-ret, &r->io_header, &sense)) {
+            len = scsi_generic_emulate_block_limits(r, s);
             /*
              * No need to let scsi_read_complete go on and handle an
              * INQUIRY VPD BL request we created manually.
diff --git a/include/hw/scsi/emulation.h b/include/hw/scsi/emulation.h
new file mode 100644
index 0000000..09fba1f
--- /dev/null
+++ b/include/hw/scsi/emulation.h
@@ -0,0 +1,16 @@
+#ifndef HW_SCSI_EMULATION_H
+#define HW_SCSI_EMULATION_H 1
+
+typedef struct SCSIBlockLimits {
+    bool wsnz;
+    uint16_t min_io_size;
+    uint32_t max_unmap_descr;
+    uint32_t opt_io_size;
+    uint32_t max_unmap_sectors;
+    uint32_t unmap_sectors;
+    uint32_t max_io_sectors;
+} SCSIBlockLimits;
+
+int scsi_emulate_block_limits(uint8_t *outbuf, const SCSIBlockLimits *bl);
+
+#endif
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index ee3a411..acef25f 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -189,7 +189,6 @@ void scsi_device_report_change(SCSIDevice *dev, SCSISense sense);
 void scsi_device_unit_attention_reported(SCSIDevice *dev);
 void scsi_generic_read_device_inquiry(SCSIDevice *dev);
 int scsi_device_get_sense(SCSIDevice *dev, uint8_t *buf, int len, bool fixed);
-int scsi_disk_emulate_vpd_page(SCSIRequest *req, uint8_t *outbuf);
 int scsi_SG_IO_FROM_DEV(BlockBackend *blk, uint8_t *cmd, uint8_t cmd_size,
                         uint8_t *buf, uint8_t buf_size);
 SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int target, int lun);
-- 
1.8.3.1
