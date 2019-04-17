Received: from eggs.gnu.org ([209.51.188.92]:39192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hGj8S-00066V-UT
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 07:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hGj8R-0003Rx-SZ
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 07:53:52 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 17 Apr 2019 13:53:43 +0200
Message-Id: <20190417115343.30527-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] scsi-generic: prevent guest from exceeding
 SG_IO limits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

Linux places a limit of UIO_MAXIOV pages on SG_IO ioctls (and if the limi=
t
is exceeded, a confusing ENOMEM error is returned[1]).  Prevent the guest
from exceeding these limits, by capping the maximum transfer length to
that value in the block limits VPD page.

[1] Oh well, at least it was easier to follow the kernel source knowing
    it had to end as ENOMEM...

Cc: qemu-stable@nongnu.org
Cc: qemu-block@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-generic.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index d82b462be4..4134d8389b 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -131,6 +131,17 @@ static int execute_command(BlockBackend *blk,
     return 0;
 }
=20
+/*
+ * Linux places a hard limit on SG_IO transfers equal to UIO_MAXIOV
+ * pages, which we need to factor in the block limits we return.
+ */
+static uint32_t sg_max_transfer(SCSIDevice *s)
+{
+    uint32_t max_transfer =3D blk_get_max_transfer(s->conf.blk);
+    max_transfer =3D MIN_NON_ZERO(max_transfer, UIO_MAXIOV * qemu_real_h=
ost_page_size);
+    return max_transfer / s->blocksize;
+}
+
 static void scsi_handle_inquiry_reply(SCSIGenericReq *r, SCSIDevice *s)
 {
     uint8_t page, page_idx;
@@ -162,10 +173,8 @@ static void scsi_handle_inquiry_reply(SCSIGenericReq=
 *r, SCSIDevice *s)
     if (s->type =3D=3D TYPE_DISK && (r->req.cmd.buf[1] & 0x01)) {
         page =3D r->req.cmd.buf[2];
         if (page =3D=3D 0xb0) {
-            uint32_t max_transfer =3D
-                blk_get_max_transfer(s->conf.blk) / s->blocksize;
+            uint32_t max_transfer =3D sg_max_transfer(s);
=20
-            assert(max_transfer);
             stl_be_p(&r->buf[8], max_transfer);
             /* Also take care of the opt xfer len. */
             stl_be_p(&r->buf[12],
@@ -206,7 +215,7 @@ static int scsi_generic_emulate_block_limits(SCSIGene=
ricReq *r, SCSIDevice *s)
     uint8_t buf[64];
=20
     SCSIBlockLimits bl =3D {
-        .max_io_sectors =3D blk_get_max_transfer(s->conf.blk) / s->block=
size
+        .max_io_sectors =3D sg_max_transfer(s)
     };
=20
     memset(r->buf, 0, r->buflen);
--=20
2.21.0
