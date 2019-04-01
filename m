Received: from eggs.gnu.org ([209.51.188.92]:49547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1hB4RV-0008O8-F5
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:26:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1hB4RT-0001RX-QR
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:26:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1hB4RT-0001QY-5d
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:26:07 -0400
From: Bandan Das <bsd@redhat.com>
Date: Mon,  1 Apr 2019 17:17:12 -0400
Message-Id: <20190401211712.19012-4-bsd@redhat.com>
In-Reply-To: <20190401211712.19012-1-bsd@redhat.com>
References: <20190401211712.19012-1-bsd@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 3/3] usb-mtp: refactor the flow of
 usb_mtp_write_data
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

There's no functional change but the flow is (hopefully)
more consistent for both file and folder object types.

Signed-off-by: Bandan Das <bsd@redhat.com>
---
 hw/usb/dev-mtp.c | 57 +++++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 4dc1317e2e..0afb926719 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1599,7 +1599,7 @@ static int usb_mtp_update_object(MTPObject *parent,=
 char *name)
     return ret;
 }
=20
-static int usb_mtp_write_data(MTPState *s)
+static void usb_mtp_write_data(MTPState *s, uint32_t handle)
 {
     MTPData *d =3D s->data_out;
     MTPObject *parent =3D
@@ -1616,26 +1616,33 @@ static int usb_mtp_write_data(MTPState *s)
         if (!parent || !s->write_pending) {
             usb_mtp_queue_result(s, RES_INVALID_OBJECTINFO, d->trans,
                 0, 0, 0, 0);
-        return 1;
+            return;
         }
=20
         if (s->dataset.filename) {
             path =3D g_strdup_printf("%s/%s", parent->path, s->dataset.f=
ilename);
             if (s->dataset.format =3D=3D FMT_ASSOCIATION) {
                 ret =3D mkdir(path, mask);
-                goto free;
+                if (!ret) {
+                    usb_mtp_queue_result(s, RES_OK, d->trans, 3,
+                                         QEMU_STORAGE_ID,
+                                         s->dataset.parent_handle,
+                                         handle);
+                    goto close;
+                }
+                goto done;
             }
+
             d->fd =3D open(path, O_CREAT | O_WRONLY |
                          O_CLOEXEC | O_NOFOLLOW, mask);
             if (d->fd =3D=3D -1) {
-                usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
-                                     0, 0, 0, 0);
+                ret =3D 1;
                 goto done;
             }
=20
             /* Return success if initiator sent 0 sized data */
             if (!s->dataset.size) {
-                goto success;
+                goto done;
             }
             if (d->length !=3D MTP_WRITE_BUF_SZ && !d->pending) {
                 d->write_status =3D WRITE_END;
@@ -1647,13 +1654,12 @@ static int usb_mtp_write_data(MTPState *s)
         rc =3D write_retry(d->fd, d->data, d->data_offset,
                          d->offset - d->data_offset);
         if (rc !=3D d->data_offset) {
-            usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
-                                 0, 0, 0, 0);
+            ret =3D 1;
             goto done;
         }
         if (d->write_status !=3D WRITE_END) {
             g_free(path);
-            return ret;
+            return;
         } else {
             /*
              * Return an incomplete transfer if file size doesn't match
@@ -1665,16 +1671,20 @@ static int usb_mtp_write_data(MTPState *s)
                 usb_mtp_update_object(parent, s->dataset.filename)) {
                 usb_mtp_queue_result(s, RES_INCOMPLETE_TRANSFER, d->tran=
s,
                                      0, 0, 0, 0);
-                goto done;
+                goto close;
             }
         }
     }
=20
-success:
-    usb_mtp_queue_result(s, RES_OK, d->trans,
-                         0, 0, 0, 0);
-
 done:
+    if (ret) {
+        usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
+                             0, 0, 0, 0);
+    } else {
+        usb_mtp_queue_result(s, RES_OK, d->trans,
+                             0, 0, 0, 0);
+    }
+close:
     /*
      * The write dataset is kept around and freed only
      * on success or if another write request comes in
@@ -1683,12 +1693,10 @@ done:
         close(d->fd);
         d->fd =3D -1;
     }
-free:
     g_free(s->dataset.filename);
     s->dataset.size =3D 0;
     g_free(path);
     s->write_pending =3D false;
-    return ret;
 }
=20
 static void usb_mtp_write_metadata(MTPState *s, uint64_t dlen)
@@ -1725,16 +1733,11 @@ static void usb_mtp_write_metadata(MTPState *s, u=
int64_t dlen)
     s->write_pending =3D true;
=20
     if (s->dataset.format =3D=3D FMT_ASSOCIATION) {
-        if (usb_mtp_write_data(s)) {
-            /* next_handle will be allocated to the newly created dir */
-            usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
-                                 0, 0, 0, 0);
-            return;
-        }
+        usb_mtp_write_data(s, next_handle);
+    } else {
+        usb_mtp_queue_result(s, RES_OK, d->trans, 3, QEMU_STORAGE_ID,
+                             s->dataset.parent_handle, next_handle);
     }
-
-    usb_mtp_queue_result(s, RES_OK, d->trans, 3, QEMU_STORAGE_ID,
-                         s->dataset.parent_handle, next_handle);
 }
=20
 static void usb_mtp_get_data(MTPState *s, mtp_container *container,
@@ -1814,14 +1817,14 @@ static void usb_mtp_get_data(MTPState *s, mtp_con=
tainer *container,
             } else {
                 d->write_status =3D WRITE_START;
             }
-            usb_mtp_write_data(s);
+            usb_mtp_write_data(s, 0);
             usb_mtp_data_free(s->data_out);
             s->data_out =3D NULL;
             return;
         }
         if (d->data_offset =3D=3D d->length) {
             d->pending =3D true;
-            usb_mtp_write_data(s);
+            usb_mtp_write_data(s, 0);
         }
         break;
     default:
--=20
2.19.2
