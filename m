Received: from eggs.gnu.org ([2001:4830:134:3::10]:36370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Utr-0007wT-8P
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Uto-0007h1-6g
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:43 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:36699)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f4Utn-0007fy-T3
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:40 -0400
Received: by mail-wm0-x235.google.com with SMTP id x82so4588113wmg.1
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 10:11:39 -0700 (PDT)
Received: from 640k.lan (94-36-194-48.adsl-ull.clienti.tiscali.it.
	[94.36.194.48]) by smtp.gmail.com with ESMTPSA id
	24sm16286180wrt.60.2018.04.06.10.11.37 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 06 Apr 2018 10:11:37 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  6 Apr 2018 19:11:11 +0200
Message-Id: <1523034681-33787-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
References: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 10/20] scsi-disk: allow customizing the SCSI
 version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We would like to have different behavior for passthrough devices
depending on the SCSI version they expose.  To prepare for that,
allow the user of emulated devices to specify the desired SCSI
level, and adjust the emulation according to the property value.
The next patch will set the level for scsi-block and scsi-generic
devices.

Based on a patch by Daniel Henrique Barboza
<danielhb@linux.vnet.ibm.com>.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c    | 29 ++++++++++++++++++++++++-----
 hw/scsi/scsi-generic.c |  1 +
 include/hw/scsi/scsi.h |  2 ++
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index f8ed8cf..9400b97 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -825,7 +825,7 @@ static int scsi_disk_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf)
      * block characteristics VPD page by default.  Not all of SPC-3
      * is actually implemented, but we're good enough.
      */
-    outbuf[2] = 5;
+    outbuf[2] = s->qdev.default_scsi_version;
     outbuf[3] = 2 | 0x10; /* Format 2, HiSup */
 
     if (buflen > 36) {
@@ -2193,7 +2193,11 @@ static int32_t scsi_disk_dma_command(SCSIRequest *req, uint8_t *buf)
     case READ_12:
     case READ_16:
         DPRINTF("Read (sector %" PRId64 ", count %u)\n", r->req.cmd.lba, len);
-        if (r->req.cmd.buf[1] & 0xe0) {
+        /* Protection information is not supported.  For SCSI versions 2 and
+         * older (as determined by snooping the guest's INQUIRY commands),
+         * there is no RD/WR/VRPROTECT, so skip this check in these versions.
+         */
+        if (s->qdev.scsi_version > 2 && (r->req.cmd.buf[1] & 0xe0)) {
             goto illegal_request;
         }
         if (!check_lba_range(s, r->req.cmd.lba, len)) {
@@ -2224,7 +2228,7 @@ static int32_t scsi_disk_dma_command(SCSIRequest *req, uint8_t *buf)
          * As far as DMA is concerned, we can treat it the same as a write;
          * scsi_block_do_sgio will send VERIFY commands.
          */
-        if (r->req.cmd.buf[1] & 0xe0) {
+        if (s->qdev.scsi_version > 2 && (r->req.cmd.buf[1] & 0xe0)) {
             goto illegal_request;
         }
         if (!check_lba_range(s, r->req.cmd.lba, len)) {
@@ -2270,6 +2274,8 @@ static void scsi_disk_reset(DeviceState *dev)
     /* reset tray statuses */
     s->tray_locked = 0;
     s->tray_open = 0;
+
+    s->qdev.scsi_version = s->qdev.default_scsi_version;
 }
 
 static void scsi_disk_resize_cb(void *opaque)
@@ -2814,6 +2820,8 @@ static bool scsi_block_is_passthrough(SCSIDiskState *s, uint8_t *buf)
 static int32_t scsi_block_dma_command(SCSIRequest *req, uint8_t *buf)
 {
     SCSIBlockReq *r = (SCSIBlockReq *)req;
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
+
     r->cmd = req->cmd.buf[0];
     switch (r->cmd >> 5) {
     case 0:
@@ -2839,8 +2847,11 @@ static int32_t scsi_block_dma_command(SCSIRequest *req, uint8_t *buf)
         abort();
     }
 
-    if (r->cdb1 & 0xe0) {
-        /* Protection information is not supported.  */
+    /* Protection information is not supported.  For SCSI versions 2 and
+     * older (as determined by snooping the guest's INQUIRY commands),
+     * there is no RD/WR/VRPROTECT, so skip this check in these versions.
+     */
+    if (s->qdev.scsi_version > 2 && (req->cmd.buf[1] & 0xe0)) {
         scsi_check_condition(&r->req, SENSE_CODE(INVALID_FIELD));
         return 0;
     }
@@ -2952,6 +2963,8 @@ static Property scsi_hd_properties[] = {
     DEFINE_PROP_UINT64("max_io_size", SCSIDiskState, max_io_size,
                        DEFAULT_MAX_IO_SIZE),
     DEFINE_PROP_UINT16("rotation_rate", SCSIDiskState, rotation_rate, 0),
+    DEFINE_PROP_INT32("scsi_version", SCSIDiskState, qdev.default_scsi_version,
+                      5),
     DEFINE_BLOCK_CHS_PROPERTIES(SCSIDiskState, qdev.conf),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -2997,6 +3010,8 @@ static Property scsi_cd_properties[] = {
     DEFINE_PROP_UINT16("port_index", SCSIDiskState, port_index, 0),
     DEFINE_PROP_UINT64("max_io_size", SCSIDiskState, max_io_size,
                        DEFAULT_MAX_IO_SIZE),
+    DEFINE_PROP_INT32("scsi_version", SCSIDiskState, qdev.default_scsi_version,
+                      5),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -3025,6 +3040,8 @@ static Property scsi_block_properties[] = {
     DEFINE_PROP_DRIVE("drive", SCSIDiskState, qdev.conf.blk),
     DEFINE_PROP_BOOL("share-rw", SCSIDiskState, qdev.conf.share_rw, false),
     DEFINE_PROP_UINT16("rotation_rate", SCSIDiskState, rotation_rate, 0),
+    DEFINE_PROP_INT32("scsi_version", SCSIDiskState, qdev.default_scsi_version,
+                      5),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -3065,6 +3082,8 @@ static Property scsi_disk_properties[] = {
                        DEFAULT_MAX_UNMAP_SIZE),
     DEFINE_PROP_UINT64("max_io_size", SCSIDiskState, max_io_size,
                        DEFAULT_MAX_IO_SIZE),
+    DEFINE_PROP_INT32("scsi_version", SCSIDiskState, qdev.default_scsi_version,
+                      5),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 4753f87..1870085 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -474,6 +474,7 @@ static void scsi_generic_reset(DeviceState *dev)
 {
     SCSIDevice *s = SCSI_DEVICE(dev);
 
+    s->scsi_version = s->default_scsi_version;
     scsi_device_purge_requests(s, SENSE_CODE(RESET));
 }
 
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 7ecadda..e35137e 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -85,6 +85,8 @@ struct SCSIDevice
     uint64_t max_lba;
     uint64_t wwn;
     uint64_t port_wwn;
+    int scsi_version;
+    int default_scsi_version;
 };
 
 extern const VMStateDescription vmstate_scsi_device;
-- 
1.8.3.1
