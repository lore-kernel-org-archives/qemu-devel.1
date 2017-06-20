Received: from eggs.gnu.org ([2001:4830:134:3::10]:38234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <JBeulich@suse.com>) id 1dNI0c-0002b0-OU
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:11:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <JBeulich@suse.com>) id 1dNI0Y-0000A2-Tr
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:11:50 -0400
Received: from prv-mh.provo.novell.com ([137.65.248.74]:60548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <JBeulich@suse.com>) id 1dNI0Y-00009l-Gr
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:11:46 -0400
Message-Id: <59492D1C0200007800164AA3@prv-mh.provo.novell.com>
Date: Tue, 20 Jun 2017 06:11:40 -0600
From: "Jan Beulich" <JBeulich@suse.com>
References: <59492D1C0200007800164AA3@prv-mh.provo.novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part84BC99EC.3__="
Subject: [Qemu-devel] [PATCH] xen/disk: don't leak stack data via response
 ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Julien Grall <julien.grall@arm.com>, xen-devel <xen-devel@lists.xenproject.org>, qemu-devel@nongnu.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part84BC99EC.3__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Rather than constructing a local structure instance on the stack, fill
the fields directly on the shared ring, just like other (Linux)
backends do. Build on the fact that all response structure flavors are
actually identical (the old code did make this assumption too).

This is XSA-216.

Reported by: Anthony Perard <anthony.perard@citrix.com>
Signed-off-by: Jan Beulich <jbeulich@suse.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
---
v2: Add QEMU_PACKED to fix handling 32-bit guests by 64-bit qemu.

--- a/hw/block/xen_blkif.h
+++ b/hw/block/xen_blkif.h
@@ -14,9 +14,6 @@
 struct blkif_common_request {
     char dummy;
 };
-struct blkif_common_response {
-    char dummy;
-};
=20
 /* i386 protocol version */
 #pragma pack(push, 4)
@@ -36,13 +33,7 @@ struct blkif_x86_32_request_discard {
     blkif_sector_t sector_number;    /* start sector idx on disk (r/w =
only)  */
     uint64_t       nr_sectors;       /* # of contiguous sectors to =
discard   */
 };
-struct blkif_x86_32_response {
-    uint64_t        id;              /* copied from request */
-    uint8_t         operation;       /* copied from request */
-    int16_t         status;          /* BLKIF_RSP_???       */
-};
 typedef struct blkif_x86_32_request blkif_x86_32_request_t;
-typedef struct blkif_x86_32_response blkif_x86_32_response_t;
 #pragma pack(pop)
=20
 /* x86_64 protocol version */
@@ -62,20 +53,14 @@ struct blkif_x86_64_request_discard {
     blkif_sector_t sector_number;    /* start sector idx on disk (r/w =
only)  */
     uint64_t       nr_sectors;       /* # of contiguous sectors to =
discard   */
 };
-struct blkif_x86_64_response {
-    uint64_t       __attribute__((__aligned__(8))) id;
-    uint8_t         operation;       /* copied from request */
-    int16_t         status;          /* BLKIF_RSP_???       */
-};
 typedef struct blkif_x86_64_request blkif_x86_64_request_t;
-typedef struct blkif_x86_64_response blkif_x86_64_response_t;
=20
 DEFINE_RING_TYPES(blkif_common, struct blkif_common_request,
-                  struct blkif_common_response);
+                  struct blkif_response);
 DEFINE_RING_TYPES(blkif_x86_32, struct blkif_x86_32_request,
-                  struct blkif_x86_32_response);
+                  struct blkif_response QEMU_PACKED);
 DEFINE_RING_TYPES(blkif_x86_64, struct blkif_x86_64_request,
-                  struct blkif_x86_64_response);
+                  struct blkif_response);
=20
 union blkif_back_rings {
     blkif_back_ring_t        native;
--- a/hw/block/xen_disk.c
+++ b/hw/block/xen_disk.c
@@ -769,31 +769,30 @@ static int blk_send_response_one(struct
     struct XenBlkDev  *blkdev =3D ioreq->blkdev;
     int               send_notify   =3D 0;
     int               have_requests =3D 0;
-    blkif_response_t  resp;
-    void              *dst;
-
-    resp.id        =3D ioreq->req.id;
-    resp.operation =3D ioreq->req.operation;
-    resp.status    =3D ioreq->status;
+    blkif_response_t  *resp;
=20
     /* Place on the response ring for the relevant domain. */
     switch (blkdev->protocol) {
     case BLKIF_PROTOCOL_NATIVE:
-        dst =3D RING_GET_RESPONSE(&blkdev->rings.native, blkdev->rings.nat=
ive.rsp_prod_pvt);
+        resp =3D RING_GET_RESPONSE(&blkdev->rings.native,
+                                 blkdev->rings.native.rsp_prod_pvt);
         break;
     case BLKIF_PROTOCOL_X86_32:
-        dst =3D RING_GET_RESPONSE(&blkdev->rings.x86_32_part,
-                                blkdev->rings.x86_32_part.rsp_prod_pvt);
+        resp =3D RING_GET_RESPONSE(&blkdev->rings.x86_32_part,
+                                 blkdev->rings.x86_32_part.rsp_prod_pvt);
         break;
     case BLKIF_PROTOCOL_X86_64:
-        dst =3D RING_GET_RESPONSE(&blkdev->rings.x86_64_part,
-                                blkdev->rings.x86_64_part.rsp_prod_pvt);
+        resp =3D RING_GET_RESPONSE(&blkdev->rings.x86_64_part,
+                                 blkdev->rings.x86_64_part.rsp_prod_pvt);
         break;
     default:
-        dst =3D NULL;
         return 0;
     }
-    memcpy(dst, &resp, sizeof(resp));
+
+    resp->id        =3D ioreq->req.id;
+    resp->operation =3D ioreq->req.operation;
+    resp->status    =3D ioreq->status;
+
     blkdev->rings.common.rsp_prod_pvt++;
=20
     RING_PUSH_RESPONSES_AND_CHECK_NOTIFY(&blkdev->rings.common, send_notif=
y);



--=__Part84BC99EC.3__=
Content-Type: text/plain; name="xsa216-qemuu.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="xsa216-qemuu.patch"

xen/disk: don't leak stack data via response ring=0A=0ARather than =
constructing a local structure instance on the stack, fill=0Athe fields =
directly on the shared ring, just like other (Linux)=0Abackends do. Build =
on the fact that all response structure flavors are=0Aactually identical =
(the old code did make this assumption too).=0A=0AThis is XSA-216.=0A=0ARep=
orted by: Anthony Perard <anthony.perard@citrix.com>=0ASigned-off-by: Jan =
Beulich <jbeulich@suse.com>=0AReviewed-by: Konrad Rzeszutek Wilk <konrad.wi=
lk@oracle.com>=0AAcked-by: Anthony PERARD <anthony.perard@citrix.com>=0A---=
=0Av2: Add QEMU_PACKED to fix handling 32-bit guests by 64-bit qemu.=0A=0A-=
-- a/hw/block/xen_blkif.h=0A+++ b/hw/block/xen_blkif.h=0A@@ -14,9 +14,6 =
@@=0A struct blkif_common_request {=0A     char dummy;=0A };=0A-struct =
blkif_common_response {=0A-    char dummy;=0A-};=0A =0A /* i386 protocol =
version */=0A #pragma pack(push, 4)=0A@@ -36,13 +33,7 @@ struct blkif_x86_3=
2_request_discard {=0A     blkif_sector_t sector_number;    /* start =
sector idx on disk (r/w only)  */=0A     uint64_t       nr_sectors;       =
/* # of contiguous sectors to discard   */=0A };=0A-struct blkif_x86_32_res=
ponse {=0A-    uint64_t        id;              /* copied from request =
*/=0A-    uint8_t         operation;       /* copied from request */=0A-   =
 int16_t         status;          /* BLKIF_RSP_???       */=0A-};=0A =
typedef struct blkif_x86_32_request blkif_x86_32_request_t;=0A-typedef =
struct blkif_x86_32_response blkif_x86_32_response_t;=0A #pragma =
pack(pop)=0A =0A /* x86_64 protocol version */=0A@@ -62,20 +53,14 @@ =
struct blkif_x86_64_request_discard {=0A     blkif_sector_t sector_number; =
   /* start sector idx on disk (r/w only)  */=0A     uint64_t       =
nr_sectors;       /* # of contiguous sectors to discard   */=0A };=0A-struc=
t blkif_x86_64_response {=0A-    uint64_t       __attribute__((__aligned__(=
8))) id;=0A-    uint8_t         operation;       /* copied from request =
*/=0A-    int16_t         status;          /* BLKIF_RSP_???       =
*/=0A-};=0A typedef struct blkif_x86_64_request blkif_x86_64_request_t;=0A-=
typedef struct blkif_x86_64_response blkif_x86_64_response_t;=0A =0A =
DEFINE_RING_TYPES(blkif_common, struct blkif_common_request,=0A-           =
       struct blkif_common_response);=0A+                  struct =
blkif_response);=0A DEFINE_RING_TYPES(blkif_x86_32, struct blkif_x86_32_req=
uest,=0A-                  struct blkif_x86_32_response);=0A+              =
    struct blkif_response QEMU_PACKED);=0A DEFINE_RING_TYPES(blkif_x86_64, =
struct blkif_x86_64_request,=0A-                  struct blkif_x86_64_respo=
nse);=0A+                  struct blkif_response);=0A =0A union blkif_back_=
rings {=0A     blkif_back_ring_t        native;=0A--- a/hw/block/xen_disk.c=
=0A+++ b/hw/block/xen_disk.c=0A@@ -769,31 +769,30 @@ static int blk_send_re=
sponse_one(struct=0A     struct XenBlkDev  *blkdev =3D ioreq->blkdev;=0A   =
  int               send_notify   =3D 0;=0A     int               =
have_requests =3D 0;=0A-    blkif_response_t  resp;=0A-    void            =
  *dst;=0A-=0A-    resp.id        =3D ioreq->req.id;=0A-    resp.operation =
=3D ioreq->req.operation;=0A-    resp.status    =3D ioreq->status;=0A+    =
blkif_response_t  *resp;=0A =0A     /* Place on the response ring for the =
relevant domain. */=0A     switch (blkdev->protocol) {=0A     case =
BLKIF_PROTOCOL_NATIVE:=0A-        dst =3D RING_GET_RESPONSE(&blkdev->rings.=
native, blkdev->rings.native.rsp_prod_pvt);=0A+        resp =3D RING_GET_RE=
SPONSE(&blkdev->rings.native,=0A+                                 =
blkdev->rings.native.rsp_prod_pvt);=0A         break;=0A     case =
BLKIF_PROTOCOL_X86_32:=0A-        dst =3D RING_GET_RESPONSE(&blkdev->rings.=
x86_32_part,=0A-                                blkdev->rings.x86_32_part.r=
sp_prod_pvt);=0A+        resp =3D RING_GET_RESPONSE(&blkdev->rings.x86_32_p=
art,=0A+                                 blkdev->rings.x86_32_part.rsp_prod=
_pvt);=0A         break;=0A     case BLKIF_PROTOCOL_X86_64:=0A-        dst =
=3D RING_GET_RESPONSE(&blkdev->rings.x86_64_part,=0A-                      =
          blkdev->rings.x86_64_part.rsp_prod_pvt);=0A+        resp =3D =
RING_GET_RESPONSE(&blkdev->rings.x86_64_part,=0A+                          =
       blkdev->rings.x86_64_part.rsp_prod_pvt);=0A         break;=0A     =
default:=0A-        dst =3D NULL;=0A         return 0;=0A     }=0A-    =
memcpy(dst, &resp, sizeof(resp));=0A+=0A+    resp->id        =3D ioreq->req=
.id;=0A+    resp->operation =3D ioreq->req.operation;=0A+    resp->status  =
  =3D ioreq->status;=0A+=0A     blkdev->rings.common.rsp_prod_pvt++;=0A =
=0A     RING_PUSH_RESPONSES_AND_CHECK_NOTIFY(&blkdev->rings.common, =
send_notify);=0A
--=__Part84BC99EC.3__=--
