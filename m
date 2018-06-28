Received: from eggs.gnu.org ([2001:4830:134:3::10]:38541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdBG-0007x3-IQ
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdBE-0001bu-Ml
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:14 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:50760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdBE-0001Yo-B3
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:12 -0400
Received: by mail-wm0-x242.google.com with SMTP id e16-v6so10988863wmd.0
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:06:12 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:05:08 +0200
Message-Id: <1530216310-52873-59-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 58/60] hw/scsi: centralize SG_IO calls into
 single function
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

For the VPD Block Limits emulation with SCSI passthrough,
we'll issue an Inquiry request with EVPD set to retrieve
the available VPD pages of the device. This would be done in
a way similar of what scsi_generic_read_device_identification
does: create a SCSI command and a reply buffer, fill in the
sg_io_hdr_t structure, call blk_ioctl, check if an error
occurred, process the response.

This same process is done in other 2 functions, get_device_type
and get_stream_blocksize. They differ in the command/reply
buffer and post-processing, everything else is almost a
copy/paste.

Instead of adding a forth copy/pasted-ish code when adding
the passthrough VPD BL emulation, this patch extirpates
this repetition of those 3 functions and put it into
a new one called scsi_SG_IO_FROM_DEV. Any future code that
wants to execute an SG_DXFER_FROM_DEV to the device can
use it, avoiding filling sg_io_hdr_t again and et cetera.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20180627172432.11120-3-danielhb413@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c    | 18 +++------------
 hw/scsi/scsi-generic.c | 61 +++++++++++++++++++++++++-------------------------
 include/hw/scsi/scsi.h |  2 ++
 3 files changed, 36 insertions(+), 45 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 664d634..b0b39f1 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2578,8 +2578,6 @@ static int get_device_type(SCSIDiskState *s)
 {
     uint8_t cmd[16];
     uint8_t buf[36];
-    uint8_t sensebuf[8];
-    sg_io_hdr_t io_header;
     int ret;
 
     memset(cmd, 0, sizeof(cmd));
@@ -2587,19 +2585,9 @@ static int get_device_type(SCSIDiskState *s)
     cmd[0] = INQUIRY;
     cmd[4] = sizeof(buf);
 
-    memset(&io_header, 0, sizeof(io_header));
-    io_header.interface_id = 'S';
-    io_header.dxfer_direction = SG_DXFER_FROM_DEV;
-    io_header.dxfer_len = sizeof(buf);
-    io_header.dxferp = buf;
-    io_header.cmdp = cmd;
-    io_header.cmd_len = sizeof(cmd);
-    io_header.mx_sb_len = sizeof(sensebuf);
-    io_header.sbp = sensebuf;
-    io_header.timeout = 6000; /* XXX */
-
-    ret = blk_ioctl(s->qdev.conf.blk, SG_IO, &io_header);
-    if (ret < 0 || io_header.driver_status || io_header.host_status) {
+    ret = scsi_SG_IO_FROM_DEV(s->qdev.conf.blk, cmd, sizeof(cmd),
+                              buf, sizeof(buf));
+    if (ret < 0) {
         return -1;
     }
     s->qdev.type = buf[0];
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index a04a704..61abc27 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -409,35 +409,48 @@ static int read_naa_id(const uint8_t *p, uint64_t *p_wwn)
     return -EINVAL;
 }
 
-void scsi_generic_read_device_identification(SCSIDevice *s)
+int scsi_SG_IO_FROM_DEV(BlockBackend *blk, uint8_t *cmd, uint8_t cmd_size,
+                        uint8_t *buf, uint8_t buf_size)
 {
-    uint8_t cmd[6];
-    uint8_t buf[250];
-    uint8_t sensebuf[8];
     sg_io_hdr_t io_header;
+    uint8_t sensebuf[8];
     int ret;
-    int i, len;
-
-    memset(cmd, 0, sizeof(cmd));
-    memset(buf, 0, sizeof(buf));
-    cmd[0] = INQUIRY;
-    cmd[1] = 1;
-    cmd[2] = 0x83;
-    cmd[4] = sizeof(buf);
 
     memset(&io_header, 0, sizeof(io_header));
     io_header.interface_id = 'S';
     io_header.dxfer_direction = SG_DXFER_FROM_DEV;
-    io_header.dxfer_len = sizeof(buf);
+    io_header.dxfer_len = buf_size;
     io_header.dxferp = buf;
     io_header.cmdp = cmd;
-    io_header.cmd_len = sizeof(cmd);
+    io_header.cmd_len = cmd_size;
     io_header.mx_sb_len = sizeof(sensebuf);
     io_header.sbp = sensebuf;
     io_header.timeout = 6000; /* XXX */
 
-    ret = blk_ioctl(s->conf.blk, SG_IO, &io_header);
+    ret = blk_ioctl(blk, SG_IO, &io_header);
     if (ret < 0 || io_header.driver_status || io_header.host_status) {
+        return -1;
+    }
+    return 0;
+}
+
+void scsi_generic_read_device_identification(SCSIDevice *s)
+{
+    uint8_t cmd[6];
+    uint8_t buf[250];
+    int ret;
+    int i, len;
+
+    memset(cmd, 0, sizeof(cmd));
+    memset(buf, 0, sizeof(buf));
+    cmd[0] = INQUIRY;
+    cmd[1] = 1;
+    cmd[2] = 0x83;
+    cmd[4] = sizeof(buf);
+
+    ret = scsi_SG_IO_FROM_DEV(s->conf.blk, cmd, sizeof(cmd),
+                              buf, sizeof(buf));
+    if (ret < 0) {
         return;
     }
 
@@ -470,8 +483,6 @@ static int get_stream_blocksize(BlockBackend *blk)
 {
     uint8_t cmd[6];
     uint8_t buf[12];
-    uint8_t sensebuf[8];
-    sg_io_hdr_t io_header;
     int ret;
 
     memset(cmd, 0, sizeof(cmd));
@@ -479,21 +490,11 @@ static int get_stream_blocksize(BlockBackend *blk)
     cmd[0] = MODE_SENSE;
     cmd[4] = sizeof(buf);
 
-    memset(&io_header, 0, sizeof(io_header));
-    io_header.interface_id = 'S';
-    io_header.dxfer_direction = SG_DXFER_FROM_DEV;
-    io_header.dxfer_len = sizeof(buf);
-    io_header.dxferp = buf;
-    io_header.cmdp = cmd;
-    io_header.cmd_len = sizeof(cmd);
-    io_header.mx_sb_len = sizeof(sensebuf);
-    io_header.sbp = sensebuf;
-    io_header.timeout = 6000; /* XXX */
-
-    ret = blk_ioctl(blk, SG_IO, &io_header);
-    if (ret < 0 || io_header.driver_status || io_header.host_status) {
+    ret = scsi_SG_IO_FROM_DEV(blk, cmd, sizeof(cmd), buf, sizeof(buf));
+    if (ret < 0) {
         return -1;
     }
+
     return (buf[9] << 16) | (buf[10] << 8) | buf[11];
 }
 
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 138eb79..75eced3 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -187,6 +187,8 @@ void scsi_device_unit_attention_reported(SCSIDevice *dev);
 void scsi_generic_read_device_identification(SCSIDevice *dev);
 int scsi_device_get_sense(SCSIDevice *dev, uint8_t *buf, int len, bool fixed);
 int scsi_disk_emulate_vpd_page(SCSIRequest *req, uint8_t *outbuf);
+int scsi_SG_IO_FROM_DEV(BlockBackend *blk, uint8_t *cmd, uint8_t cmd_size,
+                        uint8_t *buf, uint8_t buf_size);
 SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int target, int lun);
 
 /* scsi-generic.c. */
-- 
1.8.3.1
