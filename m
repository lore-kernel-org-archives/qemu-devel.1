Received: from eggs.gnu.org ([209.51.188.92]:58020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1goTIp-0003nX-BN
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:19:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1goTIn-0003oH-1J
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:19:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1goTIl-0003mU-Bf
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:19:44 -0500
From: Bandan Das <bsd@redhat.com>
Date: Tue, 29 Jan 2019 08:19:06 -0500
Message-Id: <20190129131908.27924-2-bsd@redhat.com>
In-Reply-To: <20190129131908.27924-1-bsd@redhat.com>
References: <20190129131908.27924-1-bsd@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 1/3] usb-mtp: Reallocate buffer in multiples
 of MTP_WRITE_BUF_SZ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, eblake@redhat.com, peter.maydell@linaro.org

This is a "pre-patch" to breaking up the write buffer for
MTP writes. Instead of allocating a mtp buffer equal to size
sent by the initiator, we start with a small size and reallocate
multiples (of that small size) as needed.

Signed-off-by: Bandan Das <bsd@redhat.com>
---
 hw/usb/dev-mtp.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 68c5eb8eaa..ad681145ce 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -25,6 +25,7 @@
 #include "trace.h"
 #include "hw/usb.h"
 #include "desc.h"
+#include "qemu/units.h"
=20
 /* ---------------------------------------------------------------------=
-- */
=20
@@ -152,7 +153,6 @@ struct MTPData {
     bool         first;
     /* Used for >4G file sizes */
     bool         pending;
-    uint64_t     cached_length;
     int          fd;
 };
=20
@@ -244,6 +244,7 @@ typedef struct {
=20
 #define MTP_MANUFACTURER  "QEMU"
 #define MTP_PRODUCT       "QEMU filesharing"
+#define MTP_WRITE_BUF_SZ  (512 * KiB)
=20
 enum {
     STR_MANUFACTURER =3D 1,
@@ -1658,7 +1659,7 @@ static void usb_mtp_write_data(MTPState *s)
             d->fd =3D mkdir(path, mask);
             goto free;
         }
-        if ((s->dataset.size !=3D 0xFFFFFFFF) && (s->dataset.size < d->l=
ength)) {
+        if ((s->dataset.size !=3D 0xFFFFFFFF) && (s->dataset.size !=3D d=
->offset)) {
             usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
                                  0, 0, 0, 0);
             goto done;
@@ -1776,17 +1777,21 @@ static void usb_mtp_get_data(MTPState *s, mtp_con=
tainer *container,
         total_len =3D cpu_to_le32(container->length) - sizeof(mtp_contai=
ner);
         /* Length of data in this packet */
         data_len -=3D sizeof(mtp_container);
-        usb_mtp_realloc(d, total_len);
-        d->length +=3D total_len;
+        if (total_len < MTP_WRITE_BUF_SZ) {
+                usb_mtp_realloc(d, total_len);
+                d->length +=3D total_len;
+        } else {
+                usb_mtp_realloc(d, MTP_WRITE_BUF_SZ - sizeof(mtp_contain=
er));
+                d->length +=3D MTP_WRITE_BUF_SZ - sizeof(mtp_container);
+        }
         d->offset =3D 0;
-        d->cached_length =3D total_len;
         d->first =3D false;
         d->pending =3D false;
     }
=20
     if (d->pending) {
-        usb_mtp_realloc(d, d->cached_length);
-        d->length +=3D d->cached_length;
+        usb_mtp_realloc(d, MTP_WRITE_BUF_SZ);
+        d->length +=3D MTP_WRITE_BUF_SZ;
         d->pending =3D false;
     }
=20
@@ -1794,12 +1799,6 @@ static void usb_mtp_get_data(MTPState *s, mtp_cont=
ainer *container,
         dlen =3D data_len;
     } else {
         dlen =3D d->length - d->offset;
-        /* Check for cached data for large files */
-        if ((s->dataset.size =3D=3D 0xFFFFFFFF) && (dlen < p->iov.size))=
 {
-            usb_mtp_realloc(d, p->iov.size - dlen);
-            d->length +=3D p->iov.size - dlen;
-            dlen =3D p->iov.size;
-        }
     }
=20
     switch (d->code) {
@@ -1821,7 +1820,7 @@ static void usb_mtp_get_data(MTPState *s, mtp_conta=
iner *container,
         d->offset +=3D dlen;
         if ((p->iov.size % 64) || !p->iov.size) {
             assert((s->dataset.size =3D=3D 0xFFFFFFFF) ||
-                   (s->dataset.size =3D=3D d->length));
+                   (s->dataset.size =3D=3D d->offset));
=20
             usb_mtp_write_data(s);
             usb_mtp_data_free(s->data_out);
--=20
2.19.2
