Received: from eggs.gnu.org ([2001:4830:134:3::10]:42735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gK9D5-0005fz-KW
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:48:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gK93T-0001Dy-LF
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:38:38 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:37782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gK93S-0000bF-W7
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:38:35 -0500
Received: by mail-wm1-x333.google.com with SMTP id p2-v6so13717363wmc.2
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 13:38:24 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	l186-v6sm3223526wma.13.2018.11.06.13.38.22
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 06 Nov 2018 13:38:22 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Nov 2018 22:38:01 +0100
Message-Id: <1541540283-45699-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1541540283-45699-1-git-send-email-pbonzini@redhat.com>
References: <1541540283-45699-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 15/17] scsi-generic: do not do VPD emulation for
 sense other than ILLEGAL_REQUEST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Pass other sense, such as UNIT_ATTENTION or BUSY, directly to the
guest.

Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-generic.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index b50ce64..7237b41 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -246,7 +246,6 @@ static void scsi_read_complete(void * opaque, int ret)
 {
     SCSIGenericReq *r = (SCSIGenericReq *)opaque;
     SCSIDevice *s = r->req.dev;
-    SCSISense sense;
     int len;
 
     assert(r->req.aiocb != NULL);
@@ -269,11 +268,14 @@ static void scsi_read_complete(void * opaque, int ret)
      * resulted in sense error but would need emulation.
      * In this case, emulate a valid VPD response.
      */
-    if (s->needs_vpd_bl_emulation &&
+    if (s->needs_vpd_bl_emulation && ret == 0 &&
+        (r->io_header.driver_status & SG_ERR_DRIVER_SENSE) &&
         r->req.cmd.buf[0] == INQUIRY &&
         (r->req.cmd.buf[1] & 0x01) &&
         r->req.cmd.buf[2] == 0xb0) {
-        if (sg_io_sense_from_errno(-ret, &r->io_header, &sense)) {
+        SCSISense sense =
+            scsi_parse_sense_buf(r->req.sense, r->io_header.sb_len_wr);
+        if (sense.key == ILLEGAL_REQUEST) {
             len = scsi_generic_emulate_block_limits(r, s);
             /*
              * No need to let scsi_read_complete go on and handle an
-- 
1.8.3.1
