Received: from eggs.gnu.org ([209.51.188.92]:53111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1h1drI-0006nX-Me
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 16:13:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1h1drH-0007U0-Uj
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 16:13:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1h1drG-0007SJ-Tg
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 16:13:47 -0500
From: Bandan Das <bsd@redhat.com>
Date: Wed,  6 Mar 2019 16:04:08 -0500
Message-Id: <20190306210409.14842-3-bsd@redhat.com>
In-Reply-To: <20190306210409.14842-1-bsd@redhat.com>
References: <20190306210409.14842-1-bsd@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/3] usb-mtp: fix some usb_mtp_write_data
 return paths
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

During a write, free up the "path" before getting more data.
Also, while we at it, remove the confusing usage of d->fd for
storing mkdir status

Spotted by Coverity: CID 1398642

Signed-off-by: Bandan Das <bsd@redhat.com>
---
 hw/usb/dev-mtp.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 4dde14fc78..1f22284949 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1605,7 +1605,7 @@ static int usb_mtp_update_object(MTPObject *parent,=
 char *name)
     return ret;
 }
=20
-static void usb_mtp_write_data(MTPState *s)
+static int usb_mtp_write_data(MTPState *s)
 {
     MTPData *d =3D s->data_out;
     MTPObject *parent =3D
@@ -1613,6 +1613,7 @@ static void usb_mtp_write_data(MTPState *s)
     char *path =3D NULL;
     uint64_t rc;
     mode_t mask =3D 0644;
+    int ret =3D 0;
=20
     assert(d !=3D NULL);
=20
@@ -1621,13 +1622,13 @@ static void usb_mtp_write_data(MTPState *s)
         if (!parent || !s->write_pending) {
             usb_mtp_queue_result(s, RES_INVALID_OBJECTINFO, d->trans,
                 0, 0, 0, 0);
-        return;
+        return 1;
         }
=20
         if (s->dataset.filename) {
             path =3D g_strdup_printf("%s/%s", parent->path, s->dataset.f=
ilename);
             if (s->dataset.format =3D=3D FMT_ASSOCIATION) {
-                d->fd =3D mkdir(path, mask);
+                ret =3D mkdir(path, mask);
                 goto free;
             }
             d->fd =3D open(path, O_CREAT | O_WRONLY |
@@ -1657,7 +1658,8 @@ static void usb_mtp_write_data(MTPState *s)
             goto done;
         }
         if (d->write_status !=3D WRITE_END) {
-            return;
+            g_free(path);
+            return ret;
         } else {
             /*
              * Return an incomplete transfer if file size doesn't match
@@ -1685,12 +1687,14 @@ done:
      */
     if (d->fd !=3D -1) {
         close(d->fd);
+        d->fd =3D -1;
     }
 free:
     g_free(s->dataset.filename);
     s->dataset.size =3D 0;
     g_free(path);
     s->write_pending =3D false;
+    return ret;
 }
=20
 static void usb_mtp_write_metadata(MTPState *s, uint64_t dlen)
@@ -1727,14 +1731,12 @@ static void usb_mtp_write_metadata(MTPState *s, u=
int64_t dlen)
     s->write_pending =3D true;
=20
     if (s->dataset.format =3D=3D FMT_ASSOCIATION) {
-        usb_mtp_write_data(s);
-        /* next_handle will be allocated to the newly created dir */
-        if (d->fd =3D=3D -1) {
+        if (usb_mtp_write_data(s)) {
+            /* next_handle will be allocated to the newly created dir */
             usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
                                  0, 0, 0, 0);
             return;
         }
-        d->fd =3D -1;
     }
=20
     usb_mtp_queue_result(s, RES_OK, d->trans, 3, QEMU_STORAGE_ID,
--=20
2.19.2
