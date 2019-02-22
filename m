Received: from eggs.gnu.org ([209.51.188.92]:58631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1gxJjH-0005iq-P5
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 17:55:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1gxJjG-0003DH-Sg
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 17:55:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1gxJjG-0003AP-Mc
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 17:55:38 -0500
From: Bandan Das <bsd@redhat.com>
Date: Fri, 22 Feb 2019 17:49:34 -0500
Message-Id: <20190222224934.5822-3-bsd@redhat.com>
In-Reply-To: <20190222224934.5822-1-bsd@redhat.com>
References: <20190222224934.5822-1-bsd@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] usb-mtp: fix some usb_mtp_write_data
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
index 79f2cb8743..4c1c53d330 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1658,7 +1658,7 @@ static int usb_mtp_update_object(MTPObject *parent,=
 char *name)
     return ret;
 }
=20
-static void usb_mtp_write_data(MTPState *s)
+static int usb_mtp_write_data(MTPState *s)
 {
     MTPData *d =3D s->data_out;
     MTPObject *parent =3D
@@ -1666,6 +1666,7 @@ static void usb_mtp_write_data(MTPState *s)
     char *path =3D NULL;
     uint64_t rc;
     mode_t mask =3D 0644;
+    int ret =3D 0;
=20
     assert(d !=3D NULL);
=20
@@ -1674,13 +1675,13 @@ static void usb_mtp_write_data(MTPState *s)
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
@@ -1710,7 +1711,8 @@ static void usb_mtp_write_data(MTPState *s)
             goto done;
         }
         if (d->write_status !=3D WRITE_END) {
-            return;
+            g_free(path);
+            return ret;
         } else {
             /*
              * Return an incomplete transfer if file size doesn't match
@@ -1739,12 +1741,14 @@ done:
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
@@ -1781,14 +1785,12 @@ static void usb_mtp_write_metadata(MTPState *s, u=
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
