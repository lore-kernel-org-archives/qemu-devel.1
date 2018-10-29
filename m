Received: from eggs.gnu.org ([2001:4830:134:3::10]:33696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHBRJ-0002sk-0O
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHBRH-0001NK-3h
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:34:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gHBRE-0001Fp-Vs
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:34:53 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 29 Oct 2018 18:34:37 +0100
Message-Id: <20181029173437.32559-5-pbonzini@redhat.com>
In-Reply-To: <20181029173437.32559-1-pbonzini@redhat.com>
References: <20181029173437.32559-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] scsi-generic: do not do VPD emulation for
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
Cc: mreitz@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>

Pass other sense, such as UNIT_ATTENTION or BUSY, directly to the
guest.

Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-generic.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 8fc74ef0bd..b8fa0a0f7e 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -246,7 +246,6 @@ static void scsi_read_complete(void * opaque, int ret)
 {
     SCSIGenericReq *r = (SCSIGenericReq *)opaque;
     SCSIDevice *s = r->req.dev;
-    SCSISense sense;
     int len;
 
     assert(r->req.aiocb != NULL);
@@ -269,12 +268,15 @@ static void scsi_read_complete(void * opaque, int ret)
      * resulted in sense error but would need emulation.
      * In this case, emulate a valid VPD response.
      */
-    if (s->needs_vpd_bl_emulation) {
+    if (ret == 0 &&
+        (r->io_header.driver_status & SG_ERR_DRIVER_SENSE) &&
+        scsi_parse_sense_buf(r->req.sense, r->io_header.sb_len_wr).key == ILLEGAL_REQUEST &&
+        s->needs_vpd_bl_emulation) {
         int is_vpd_bl = r->req.cmd.buf[0] == INQUIRY &&
                          r->req.cmd.buf[1] & 0x01 &&
                          r->req.cmd.buf[2] == 0xb0;
 
-        if (is_vpd_bl && sg_io_sense_from_errno(-ret, &r->io_header, &sense)) {
+        if (is_vpd_bl) {
             len = scsi_generic_emulate_block_limits(r, s);
             /*
              * No need to let scsi_read_complete go on and handle an
-- 
2.17.1
