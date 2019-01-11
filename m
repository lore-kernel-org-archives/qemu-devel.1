Received: from eggs.gnu.org ([209.51.188.92]:56642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghzvs-0006Ob-6E
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:45:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghzvo-0001KR-Lo
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:45:17 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 11 Jan 2019 17:45:06 +0100
Message-Id: <20190111164506.15971-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] scsi-generic: avoid possible out-of-bounds
 access to r->buf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

Whenever the allocation length of a SCSI request is shorter than the size=
 of the
VPD page list, page_idx is used blindly to index into r->buf.  Even thoug=
h
the stores in the insertion sort are protected against overflows, the sam=
e is not
true of the reads and the final store of 0xb0.

This basically does the same thing as commit 57dbb58d80 ("scsi-generic: a=
void
out-of-bounds access to VPD page list", 2018-11-06), except that here the
allocation length can be chosen by the guest.  Note that according to the=
 SCSI
standard, the contents of the PAGE LENGTH field are not altered based
on the allocation length.

The code was introduced by commit 6c219fc8a1 ("scsi-generic: keep VPD
page list sorted", 2018-11-06) but the overflow was already possible befo=
re.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Fixes: a71c775b24ebc664129eb1d9b4c360590353efd5
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-generic.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 7237b4162e..42700e8897 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -182,7 +182,7 @@ static void scsi_handle_inquiry_reply(SCSIGenericReq =
*r, SCSIDevice *s)
             /* Also take care of the opt xfer len. */
             stl_be_p(&r->buf[12],
                     MIN_NON_ZERO(max_transfer, ldl_be_p(&r->buf[12])));
-        } else if (s->needs_vpd_bl_emulation && page =3D=3D 0x00) {
+        } else if (s->needs_vpd_bl_emulation && page =3D=3D 0x00 && r->b=
uflen >=3D 4) {
             /*
              * Now we're capable of supplying the VPD Block Limits
              * response if the hardware can't. Add it in the INQUIRY
@@ -193,18 +193,20 @@ static void scsi_handle_inquiry_reply(SCSIGenericRe=
q *r, SCSIDevice *s)
              * and will use it to proper setup the SCSI device.
              *
              * VPD page numbers must be sorted, so insert 0xb0 at the
-             * right place with an in-place insert.  After the initializ=
ation
-             * part of the for loop is executed, the device response is
-             * at r[0] to r[page_idx - 1].
+             * right place with an in-place insert.  When the while loop
+             * begins the device response is at r[0] to r[page_idx - 1].
              */
-            for (page_idx =3D lduw_be_p(r->buf + 2) + 4;
-                 page_idx > 4 && r->buf[page_idx - 1] >=3D 0xb0;
-                 page_idx--) {
+            page_idx =3D lduw_be_p(r->buf + 2) + 4;
+            page_idx =3D MIN(page_idx, r->buflen);
+            while (page_idx > 4 && r->buf[page_idx - 1] >=3D 0xb0) {
                 if (page_idx < r->buflen) {
                     r->buf[page_idx] =3D r->buf[page_idx - 1];
                 }
+                page_idx--;
+            }
+            if (page_idx < r->buflen) {
+                r->buf[page_idx] =3D 0xb0;
             }
-            r->buf[page_idx] =3D 0xb0;
             stw_be_p(r->buf + 2, lduw_be_p(r->buf + 2) + 1);
         }
     }
--=20
2.20.1
