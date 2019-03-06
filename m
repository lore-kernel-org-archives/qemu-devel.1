Received: from eggs.gnu.org ([209.51.188.92]:52619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1h1dor-0005bU-MP
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 16:11:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1h1dor-0006Pz-0C
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 16:11:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1h1doq-0006Pc-PY
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 16:11:16 -0500
From: Bandan Das <bsd@redhat.com>
Date: Wed,  6 Mar 2019 16:04:07 -0500
Message-Id: <20190306210409.14842-2-bsd@redhat.com>
In-Reply-To: <20190306210409.14842-1-bsd@redhat.com>
References: <20190306210409.14842-1-bsd@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/3] usb-mtp: return incomplete transfer on
 a lstat failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, peter.maydell@linaro.org

MTP writes objects in small chunks and at the end gets the
real file size to update the object metadata. If this fails for
any reason, return an INCOMPLETE_TRANSFER to the initiator

Spotted by Coverity: CID 1398651

Signed-off-by: Bandan Das <bsd@redhat.com>
---
 hw/usb/dev-mtp.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 4ee4fc5a89..4dde14fc78 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1591,14 +1591,18 @@ done:
         return ret;
 }
=20
-static void usb_mtp_update_object(MTPObject *parent, char *name)
+static int usb_mtp_update_object(MTPObject *parent, char *name)
 {
+    int ret =3D -1;
+
     MTPObject *o =3D
         usb_mtp_object_lookup_name(parent, name, strlen(name));
=20
     if (o) {
-        lstat(o->path, &o->stat);
+        ret =3D lstat(o->path, &o->stat);
     }
+
+    return ret;
 }
=20
 static void usb_mtp_write_data(MTPState *s)
@@ -1655,13 +1659,18 @@ static void usb_mtp_write_data(MTPState *s)
         if (d->write_status !=3D WRITE_END) {
             return;
         } else {
-            /* Only for < 4G file sizes */
-            if (s->dataset.size !=3D 0xFFFFFFFF && d->offset !=3D s->dat=
aset.size) {
+            /*
+             * Return an incomplete transfer if file size doesn't match
+             * for < 4G file or if lstat fails which will result in an i=
ncorrect
+             * file size
+             */
+            if ((s->dataset.size !=3D 0xFFFFFFFF &&
+                 d->offset !=3D s->dataset.size) ||
+                usb_mtp_update_object(parent, s->dataset.filename)) {
                 usb_mtp_queue_result(s, RES_INCOMPLETE_TRANSFER, d->tran=
s,
                                      0, 0, 0, 0);
                 goto done;
             }
-            usb_mtp_update_object(parent, s->dataset.filename);
         }
     }
=20
--=20
2.19.2
