Received: from eggs.gnu.org ([2001:4830:134:3::10]:35649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qxs-0003Ie-3E
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qxq-0001y9-JM
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:04 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:56502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1e4qxq-0001wk-Cr
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:02 -0400
Received: by mail-wm0-x241.google.com with SMTP id l68so11139631wmd.5
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 09:13:02 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2017 18:11:54 +0200
Message-Id: <1508343141-31835-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
References: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/29] scsi-disk: support reporting of rotation
 rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Daniel P. Berrange" <berrange@redhat.com>

The Linux kernel will query the SCSI "Block device characteristics"
VPD to determine the rotations per minute of the disk. If this has
the value 1, it is taken to be an SSD and so Linux sets the
'rotational' flag to 0 for the I/O queue and will stop using that
disk as a source of random entropy. Other operating systems may
also take into account rotation rate when setting up default
behaviour.

Mgmt apps should be able to set the rotation rate for virtualized
block devices, based on characteristics of the host storage in use,
so that the guest OS gets sensible behaviour out of the box. This
patch thus adds a 'rotation-rate' parameter for 'scsi-hd' and
'scsi-block' device types. For the latter, this parameter will be
ignored unless the host device has TYPE_DISK.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-Id: <20171004114008.14849-2-berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 6e841fb..a518080 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -104,6 +104,14 @@ typedef struct SCSIDiskState
     char *product;
     bool tray_open;
     bool tray_locked;
+    /*
+     * 0x0000        - rotation rate not reported
+     * 0x0001        - non-rotating medium (SSD)
+     * 0x0002-0x0400 - reserved
+     * 0x0401-0xffe  - rotations per minute
+     * 0xffff        - reserved
+     */
+    uint16_t rotation_rate;
 } SCSIDiskState;
 
 static bool scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_failed);
@@ -605,6 +613,7 @@ static int scsi_disk_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf)
             outbuf[buflen++] = 0x83; // device identification
             if (s->qdev.type == TYPE_DISK) {
                 outbuf[buflen++] = 0xb0; // block limits
+                outbuf[buflen++] = 0xb1; /* block device characteristics */
                 outbuf[buflen++] = 0xb2; // thin provisioning
             }
             break;
@@ -747,6 +756,15 @@ static int scsi_disk_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf)
             outbuf[43] = max_io_sectors & 0xff;
             break;
         }
+        case 0xb1: /* block device characteristics */
+        {
+            buflen = 8;
+            outbuf[4] = (s->rotation_rate >> 8) & 0xff;
+            outbuf[5] = s->rotation_rate & 0xff;
+            outbuf[6] = 0;
+            outbuf[7] = 0;
+            break;
+        }
         case 0xb2: /* thin provisioning */
         {
             buflen = 8;
@@ -2911,6 +2929,7 @@ static Property scsi_hd_properties[] = {
                        DEFAULT_MAX_UNMAP_SIZE),
     DEFINE_PROP_UINT64("max_io_size", SCSIDiskState, max_io_size,
                        DEFAULT_MAX_IO_SIZE),
+    DEFINE_PROP_UINT16("rotation_rate", SCSIDiskState, rotation_rate, 0),
     DEFINE_BLOCK_CHS_PROPERTIES(SCSIDiskState, qdev.conf),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -2982,6 +3001,7 @@ static const TypeInfo scsi_cd_info = {
 static Property scsi_block_properties[] = {
     DEFINE_BLOCK_ERROR_PROPERTIES(SCSIDiskState, qdev.conf),         \
     DEFINE_PROP_DRIVE("drive", SCSIDiskState, qdev.conf.blk),
+    DEFINE_PROP_UINT16("rotation_rate", SCSIDiskState, rotation_rate, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
1.8.3.1
