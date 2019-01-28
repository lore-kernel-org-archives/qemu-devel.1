Received: from eggs.gnu.org ([209.51.188.92]:42424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1go7q8-0005ys-GZ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:24:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1go7q6-0003II-Qw
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:24:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1go7q6-00037z-HR
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:24:42 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39B055D608
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 14:24:27 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
Date: Mon, 28 Jan 2019 09:24:09 -0500
Message-Id: <20190128142410.11584-3-bsd@redhat.com>
In-Reply-To: <20190128142410.11584-1-bsd@redhat.com>
References: <20190128142410.11584-1-bsd@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 2/3] usb-mtp: breakup MTP write into smaller
 chunks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

For every MTP_WRITE_BUF_SZ copied, this patch writes it to file before
getting the next block of data. The file is kept opened for the
duration of the operation but the sanity checks on the write operation
are performed only once when the write operation starts. Additionally,
we also update the file size in the object metadata once the file has
completely been written.

Suggested-by: Gerd Hoffman <kraxel@redhat.com>
Signed-off-by: Bandan Das <bsd@redhat.com>
---
 hw/usb/dev-mtp.c | 134 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 91 insertions(+), 43 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 2f3536a26d..b607c7be05 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -35,6 +35,13 @@ enum mtp_container_type {
     TYPE_EVENT    =3D 4,
 };
=20
+/* MTP write stage, for internal use only */
+enum mtp_write_status {
+    WRITE_START    =3D 1,
+    WRITE_CONTINUE =3D 2,
+    WRITE_END      =3D 3,
+};
+
 enum mtp_code {
     /* command codes */
     CMD_GET_DEVICE_INFO            =3D 0x1001,
@@ -153,6 +160,9 @@ struct MTPData {
     /* Used for >4G file sizes */
     bool         pending;
     int          fd;
+    uint8_t      write_status;
+    /* Internal pointer per every MTP_WRITE_BUF_SZ */
+    uint64_t     data_offset;
 };
=20
 struct MTPObject {
@@ -1618,10 +1628,14 @@ static char *utf16_to_str(uint8_t len, uint16_t *=
arr)
 }
=20
 /* Wrapper around write, returns 0 on failure */
-static uint64_t write_retry(int fd, void *buf, uint64_t size)
+static uint64_t write_retry(int fd, void *buf, uint64_t size, off_t offs=
et)
 {
         uint64_t bytes_left =3D size, ret;
=20
+        if (lseek(fd, offset, SEEK_SET) < 0) {
+            goto done;
+        }
+
         while (bytes_left > 0) {
                 ret =3D write(fd, buf, bytes_left);
                 if ((ret =3D=3D -1) && (errno !=3D EINTR || errno !=3D E=
AGAIN ||
@@ -1632,9 +1646,20 @@ static uint64_t write_retry(int fd, void *buf, uin=
t64_t size)
                 buf +=3D ret;
         }
=20
+done:
         return size - bytes_left;
 }
=20
+static void usb_mtp_update_object(MTPObject *parent, char *name)
+{
+    MTPObject *o =3D
+        usb_mtp_object_lookup_name(parent, name, strlen(name));
+
+    if (o) {
+        lstat(o->path, &o->stat);
+    }
+}
+
 static void usb_mtp_write_data(MTPState *s)
 {
     MTPData *d =3D s->data_out;
@@ -1646,48 +1671,56 @@ static void usb_mtp_write_data(MTPState *s)
=20
     assert(d !=3D NULL);
=20
-    if (parent =3D=3D NULL || !s->write_pending) {
-        usb_mtp_queue_result(s, RES_INVALID_OBJECTINFO, d->trans,
-                             0, 0, 0, 0);
+    switch (d->write_status) {
+    case WRITE_START:
+        if (!parent || !s->write_pending) {
+            usb_mtp_queue_result(s, RES_INVALID_OBJECTINFO, d->trans,
+                0, 0, 0, 0);
         return;
-    }
-
-    if (s->dataset.filename) {
-        path =3D g_strdup_printf("%s/%s", parent->path, s->dataset.filen=
ame);
-        if (s->dataset.format =3D=3D FMT_ASSOCIATION) {
-            d->fd =3D mkdir(path, mask);
-            goto free;
-        }
-        if ((s->dataset.size !=3D 0xFFFFFFFF) && (s->dataset.size !=3D d=
->offset)) {
-            usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
-                                 0, 0, 0, 0);
-            goto done;
-        }
-        d->fd =3D open(path, O_CREAT | O_WRONLY | O_CLOEXEC | O_NOFOLLOW=
, mask);
-        if (d->fd =3D=3D -1) {
-            usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
-                                 0, 0, 0, 0);
-            goto done;
         }
=20
-        /*
-         * Return success if initiator sent 0 sized data
-         */
-        if (!s->dataset.size) {
-            goto success;
-        }
+        if (s->dataset.filename) {
+            path =3D g_strdup_printf("%s/%s", parent->path, s->dataset.f=
ilename);
+            if (s->dataset.format =3D=3D FMT_ASSOCIATION) {
+                d->fd =3D mkdir(path, mask);
+                goto free;
+            }
+            d->fd =3D open(path, O_CREAT | O_WRONLY |
+                         O_CLOEXEC | O_NOFOLLOW, mask);
+            if (d->fd =3D=3D -1) {
+                usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
+                                     0, 0, 0, 0);
+                goto done;
+            }
=20
-        rc =3D write_retry(d->fd, d->data, d->offset);
-        if (rc !=3D d->offset) {
+            /* Return success if initiator sent 0 sized data */
+            if (!s->dataset.size) {
+                goto success;
+            }
+            if (d->length !=3D MTP_WRITE_BUF_SZ && !d->pending) {
+                d->write_status =3D WRITE_END;
+            }
+        }
+        /* fall through */
+    case WRITE_CONTINUE:
+    case WRITE_END:
+        rc =3D write_retry(d->fd, d->data, d->data_offset,
+                         d->offset - d->data_offset);
+        if (rc !=3D d->data_offset) {
             usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
                                  0, 0, 0, 0);
             goto done;
+        }
+        if (d->write_status !=3D WRITE_END) {
+            return;
+        } else {
+            /* Only for < 4G file sizes */
+            if (s->dataset.size !=3D 0xFFFFFFFF && d->offset !=3D s->dat=
aset.size) {
+                usb_mtp_queue_result(s, RES_INCOMPLETE_TRANSFER, d->tran=
s,
+                                     0, 0, 0, 0);
+                goto done;
             }
-        /* Only for < 4G file sizes */
-        if (s->dataset.size !=3D 0xFFFFFFFF && rc !=3D s->dataset.size) =
{
-            usb_mtp_queue_result(s, RES_INCOMPLETE_TRANSFER, d->trans,
-                                 0, 0, 0, 0);
-            goto done;
+            usb_mtp_update_object(parent, s->dataset.filename);
         }
     }
=20
@@ -1786,25 +1819,33 @@ static void usb_mtp_get_data(MTPState *s, mtp_con=
tainer *container,
         d->offset =3D 0;
         d->first =3D false;
         d->pending =3D false;
+        d->data_offset =3D 0;
+        d->write_status =3D WRITE_START;
     }
=20
     if (d->pending) {
-        usb_mtp_realloc(d, MTP_WRITE_BUF_SZ);
-        d->length +=3D MTP_WRITE_BUF_SZ;
+        memset(d->data, 0, d->length);
+        if (d->length !=3D MTP_WRITE_BUF_SZ) {
+            usb_mtp_realloc(d, MTP_WRITE_BUF_SZ - d->length);
+            d->length +=3D (MTP_WRITE_BUF_SZ - d->length);
+        }
         d->pending =3D false;
+        d->write_status =3D WRITE_CONTINUE;
+        d->data_offset =3D 0;
     }
=20
-    if (d->length - d->offset > data_len) {
+    if (d->length - d->data_offset > data_len) {
         dlen =3D data_len;
     } else {
-        dlen =3D d->length - d->offset;
+        dlen =3D d->length - d->data_offset;
     }
=20
     switch (d->code) {
     case CMD_SEND_OBJECT_INFO:
-        usb_packet_copy(p, d->data + d->offset, dlen);
+        usb_packet_copy(p, d->data + d->data_offset, dlen);
         d->offset +=3D dlen;
-        if (d->offset =3D=3D d->length) {
+        d->data_offset +=3D dlen;
+        if (d->data_offset =3D=3D d->length) {
             /* The operation might have already failed */
             if (!s->result) {
                 usb_mtp_write_metadata(s, dlen);
@@ -1815,19 +1856,26 @@ static void usb_mtp_get_data(MTPState *s, mtp_con=
tainer *container,
         }
         break;
     case CMD_SEND_OBJECT:
-        usb_packet_copy(p, d->data + d->offset, dlen);
+        usb_packet_copy(p, d->data + d->data_offset, dlen);
         d->offset +=3D dlen;
+        d->data_offset +=3D dlen;
         if ((p->iov.size % 64) || !p->iov.size) {
             assert((s->dataset.size =3D=3D 0xFFFFFFFF) ||
                    (s->dataset.size =3D=3D d->offset));
=20
+            if (d->length =3D=3D MTP_WRITE_BUF_SZ) {
+                d->write_status =3D WRITE_END;
+            } else {
+                d->write_status =3D WRITE_START;
+            }
             usb_mtp_write_data(s);
             usb_mtp_data_free(s->data_out);
             s->data_out =3D NULL;
             return;
         }
-        if (d->offset =3D=3D d->length) {
+        if (d->data_offset =3D=3D d->length) {
             d->pending =3D true;
+            usb_mtp_write_data(s);
         }
         break;
     default:
--=20
2.19.2
