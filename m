Received: from eggs.gnu.org ([2001:4830:134:3::10]:38573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdBI-00082E-6H
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdBF-0001eW-TT
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:16 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:35312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdBF-0001cc-Gn
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:13 -0400
Received: by mail-wr0-x243.google.com with SMTP id c13-v6so6681908wrq.2
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:06:13 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:05:09 +0200
Message-Id: <1530216310-52873-60-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 59/60] hw/scsi: add VPD Block Limits emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>

From: Daniel Henrique Barboza <danielhb413@gmail.com>

The VPD Block Limits Inquiry page is optional, allowing SCSI devices
to not implement it. This is the case for devices like the MegaRAID
SAS 9361-8i and Microsemi PM8069.

In case of SCSI passthrough, the response of this request is used by
the QEMU SCSI layer to set the max_io_sectors that the guest
device will support, based on the value of the max_sectors_kb that
the device has set in the host at that time. Without this response,
the guest kernel is free to assume any value of max_io_sectors
for the SCSI device. If this value is greater than the value from
the host, SCSI Sense errors will occur because the guest will send
read/write requests that are larger than the underlying host device
is configured to support. An example of this behavior can be seen
in [1].

A workaround is to set the max_sectors_kb host value back in the guest
kernel (a process that can be automated using rc.local startup scripts
and the like), but this has several drawbacks:

- it can be troublesome if the guest has many passthrough devices that
needs this tuning;

- if a change in max_sectors_kb is made in the host side, manual change
in the guests will also be required;

- during an OS install it is difficult, and sometimes not possible, to
go to a terminal and change the max_sectors_kb prior to the installation.
This means that the disk can't be used during the install process. The
easiest alternative here is to roll back to scsi-hd, install the guest
and then go back to SCSI passthrough when the installation is done and
max_sectors_kb can be set.

An easier way would be to QEMU handle the absence of the Block Limits
VPD device response, setting max_io_sectors accordingly and allowing
the guest to use the device without the hassle.

This patch adds emulation of the Block Limits VPD response for
SCSI passthrough devices of type TYPE_DISK that doesn't support
it. The following changes were made:

- scsi_handle_inquiry_reply will now check the available VPD
pages from the Inquiry EVPD reply. In case the device does not

- a new function called scsi_generic_set_vpd_bl_emulation,
that is called during device realize,  was created to set a
new flag 'needs_vpd_bl_emulation' of the device. This function
retrieves the Inquiry EVPD response of the device to check for
VPD BL support.

- scsi_handle_inquiry_reply will now check the available VPD
pages from the Inquiry EVPD reply in case the device needs
VPD BL emulation, adding the Block Limits page (0xb0) to
the list. This will make the guest kernel aware of the
support that we're now providing by emulation.

- a new function scsi_emulate_block_limits creates the
emulated Block Limits response. This function is called
inside scsi_read_complete in case the device requires
Block Limits VPD emulation and we detected a SCSI Sense
error in the VPD Block Limits reply that was issued
from the guest kernel to the device. This error is
expected: we're reporting support from our side, but
the device isn't aware of it.

With this patch, the guest now queries the Block Limits
page during the device configuration because it is being
advertised in the Supported Pages response. It will either
receive the Block Limits page from the hardware, if it supports
it, or will receive an emulated response from QEMU. At any rate,
the guest now has the information to set the max_sectors_kb
parameter accordingly, sparing the user of SCSI sense errors
that would happen without the emulated response and in the
absence of Block Limits support from the hardware.

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1566195

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1566195
Reported-by: Dac Nguyen <dacng@us.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20180627172432.11120-4-danielhb413@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c    |   2 +-
 hw/scsi/scsi-generic.c | 132 +++++++++++++++++++++++++++++++++++++++++++++----
 include/hw/scsi/scsi.h |   3 +-
 3 files changed, 125 insertions(+), 12 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index b0b39f1..55a34b3 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2645,7 +2645,7 @@ static void scsi_block_realize(SCSIDevice *dev, Error **errp)
     s->features |= (1 << SCSI_DISK_F_NO_REMOVABLE_DEVOPS);
 
     scsi_realize(&s->qdev, errp);
-    scsi_generic_read_device_identification(&s->qdev);
+    scsi_generic_read_device_inquiry(&s->qdev);
 }
 
 typedef struct SCSIBlockReq {
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 61abc27..d60c4d0 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -144,6 +144,8 @@ static int execute_command(BlockBackend *blk,
 
 static void scsi_handle_inquiry_reply(SCSIGenericReq *r, SCSIDevice *s)
 {
+    uint8_t page, page_len;
+
     /*
      *  EVPD set to zero returns the standard INQUIRY data.
      *
@@ -167,22 +169,57 @@ static void scsi_handle_inquiry_reply(SCSIGenericReq *r, SCSIDevice *s)
             s->scsi_version = r->buf[2];
         }
     }
-    if (s->type == TYPE_DISK && r->req.cmd.buf[2] == 0xb0) {
-        uint32_t max_transfer =
-            blk_get_max_transfer(s->conf.blk) / s->blocksize;
 
-        assert(max_transfer);
-        stl_be_p(&r->buf[8], max_transfer);
-        /* Also take care of the opt xfer len. */
-        stl_be_p(&r->buf[12],
-                 MIN_NON_ZERO(max_transfer, ldl_be_p(&r->buf[12])));
+    if (s->type == TYPE_DISK && (r->req.cmd.buf[1] & 0x01)) {
+        page = r->req.cmd.buf[2];
+        if (page == 0xb0) {
+            uint32_t max_transfer =
+                blk_get_max_transfer(s->conf.blk) / s->blocksize;
+
+            assert(max_transfer);
+            stl_be_p(&r->buf[8], max_transfer);
+            /* Also take care of the opt xfer len. */
+            stl_be_p(&r->buf[12],
+                    MIN_NON_ZERO(max_transfer, ldl_be_p(&r->buf[12])));
+        } else if (page == 0x00 && s->needs_vpd_bl_emulation) {
+            /*
+             * Now we're capable of supplying the VPD Block Limits
+             * response if the hardware can't. Add it in the INQUIRY
+             * Supported VPD pages response in case we are using the
+             * emulation for this device.
+             *
+             * This way, the guest kernel will be aware of the support
+             * and will use it to proper setup the SCSI device.
+             */
+            page_len = r->buf[3];
+            r->buf[page_len + 4] = 0xb0;
+            r->buf[3] = ++page_len;
+        }
     }
 }
 
+static int scsi_emulate_block_limits(SCSIGenericReq *r)
+{
+    r->buflen = scsi_disk_emulate_vpd_page(&r->req, r->buf);
+    r->io_header.sb_len_wr = 0;
+
+    /*
+    * We have valid contents in the reply buffer but the
+    * io_header can report a sense error coming from
+    * the hardware in scsi_command_complete_noio. Clean
+    * up the io_header to avoid reporting it.
+    */
+    r->io_header.driver_status = 0;
+    r->io_header.status = 0;
+
+    return r->buflen;
+}
+
 static void scsi_read_complete(void * opaque, int ret)
 {
     SCSIGenericReq *r = (SCSIGenericReq *)opaque;
     SCSIDevice *s = r->req.dev;
+    SCSISense sense;
     int len;
 
     assert(r->req.aiocb != NULL);
@@ -199,6 +236,27 @@ static void scsi_read_complete(void * opaque, int ret)
     DPRINTF("Data ready tag=0x%x len=%d\n", r->req.tag, len);
 
     r->len = -1;
+
+    /*
+     * Check if this is a VPD Block Limits request that
+     * resulted in sense error but would need emulation.
+     * In this case, emulate a valid VPD response.
+     */
+    if (s->needs_vpd_bl_emulation) {
+        int is_vpd_bl = r->req.cmd.buf[0] == INQUIRY &&
+                         r->req.cmd.buf[1] & 0x01 &&
+                         r->req.cmd.buf[2] == 0xb0;
+
+        if (is_vpd_bl && sg_io_sense_from_errno(-ret, &r->io_header, &sense)) {
+            len = scsi_emulate_block_limits(r);
+            /*
+             * No need to let scsi_read_complete go on and handle an
+             * INQUIRY VPD BL request we created manually.
+             */
+            goto req_complete;
+        }
+    }
+
     if (len == 0) {
         scsi_command_complete_noio(r, 0);
         goto done;
@@ -233,6 +291,8 @@ static void scsi_read_complete(void * opaque, int ret)
     if (r->req.cmd.buf[0] == INQUIRY) {
         scsi_handle_inquiry_reply(r, s);
     }
+
+req_complete:
     scsi_req_data(&r->req, len);
     scsi_req_unref(&r->req);
 
@@ -434,7 +494,49 @@ int scsi_SG_IO_FROM_DEV(BlockBackend *blk, uint8_t *cmd, uint8_t cmd_size,
     return 0;
 }
 
-void scsi_generic_read_device_identification(SCSIDevice *s)
+/*
+ * Executes an INQUIRY request with EVPD set to retrieve the
+ * available VPD pages of the device. If the device does
+ * not support the Block Limits page (page 0xb0), set
+ * the needs_vpd_bl_emulation flag for future use.
+ */
+static void scsi_generic_set_vpd_bl_emulation(SCSIDevice *s)
+{
+    uint8_t cmd[6];
+    uint8_t buf[250];
+    uint8_t page_len;
+    int ret, i;
+
+    memset(cmd, 0, sizeof(cmd));
+    memset(buf, 0, sizeof(buf));
+    cmd[0] = INQUIRY;
+    cmd[1] = 1;
+    cmd[2] = 0x00;
+    cmd[4] = sizeof(buf);
+
+    ret = scsi_SG_IO_FROM_DEV(s->conf.blk, cmd, sizeof(cmd),
+                              buf, sizeof(buf));
+    if (ret < 0) {
+        /*
+         * Do not assume anything if we can't retrieve the
+         * INQUIRY response to assert the VPD Block Limits
+         * support.
+         */
+        s->needs_vpd_bl_emulation = false;
+        return;
+    }
+
+    page_len = buf[3];
+    for (i = 4; i < page_len + 4; i++) {
+        if (buf[i] == 0xb0) {
+            s->needs_vpd_bl_emulation = false;
+            return;
+        }
+    }
+    s->needs_vpd_bl_emulation = true;
+}
+
+static void scsi_generic_read_device_identification(SCSIDevice *s)
 {
     uint8_t cmd[6];
     uint8_t buf[250];
@@ -479,6 +581,16 @@ void scsi_generic_read_device_identification(SCSIDevice *s)
     }
 }
 
+void scsi_generic_read_device_inquiry(SCSIDevice *s)
+{
+    scsi_generic_read_device_identification(s);
+    if (s->type == TYPE_DISK) {
+        scsi_generic_set_vpd_bl_emulation(s);
+    } else {
+        s->needs_vpd_bl_emulation = false;
+    }
+}
+
 static int get_stream_blocksize(BlockBackend *blk)
 {
     uint8_t cmd[6];
@@ -580,7 +692,7 @@ static void scsi_generic_realize(SCSIDevice *s, Error **errp)
 
     /* Only used by scsi-block, but initialize it nevertheless to be clean.  */
     s->default_scsi_version = -1;
-    scsi_generic_read_device_identification(s);
+    scsi_generic_read_device_inquiry(s);
 }
 
 const SCSIReqOps scsi_generic_req_ops = {
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 75eced3..21a3a6f 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -87,6 +87,7 @@ struct SCSIDevice
     uint64_t port_wwn;
     int scsi_version;
     int default_scsi_version;
+    bool needs_vpd_bl_emulation;
 };
 
 extern const VMStateDescription vmstate_scsi_device;
@@ -184,7 +185,7 @@ void scsi_device_purge_requests(SCSIDevice *sdev, SCSISense sense);
 void scsi_device_set_ua(SCSIDevice *sdev, SCSISense sense);
 void scsi_device_report_change(SCSIDevice *dev, SCSISense sense);
 void scsi_device_unit_attention_reported(SCSIDevice *dev);
-void scsi_generic_read_device_identification(SCSIDevice *dev);
+void scsi_generic_read_device_inquiry(SCSIDevice *dev);
 int scsi_device_get_sense(SCSIDevice *dev, uint8_t *buf, int len, bool fixed);
 int scsi_disk_emulate_vpd_page(SCSIRequest *req, uint8_t *outbuf);
 int scsi_SG_IO_FROM_DEV(BlockBackend *blk, uint8_t *cmd, uint8_t cmd_size,
-- 
1.8.3.1
