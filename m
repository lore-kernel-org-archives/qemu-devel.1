Received: from eggs.gnu.org ([209.51.188.92]:45537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gokOT-0004vA-Ef
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:34:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gokOR-000781-Mw
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:34:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49973)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gokOR-00075X-Bm
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:34:43 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 30 Jan 2019 08:34:25 +0100
Message-Id: <20190130073426.11525-8-kraxel@redhat.com>
In-Reply-To: <20190130073426.11525-1-kraxel@redhat.com>
References: <20190130073426.11525-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 7/8] usb-mtp: breakup MTP write into smaller
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
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Bandan Das <bsd@redhat.com>

From: Bandan Das <bsd@redhat.com>

For every MTP_WRITE_BUF_SZ copied, this patch writes it to file before
getting the next block of data. The file is kept opened for the
duration of the operation but the sanity checks on the write operation
are performed only once when the write operation starts. Additionally,
we also update the file size in the object metadata once the file has
completely been written.

Suggested-by: Gerd Hoffman <kraxel@redhat.com>
Signed-off-by: Bandan Das <bsd@redhat.com>
Message-id: 20190129131908.27924-3-bsd@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-mtp.c | 134 +++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 91 insertions(+), 43 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 2e342c7745..2ca25c9da5 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -36,6 +36,13 @@ enum mtp_container_type {
     TYPE_EVENT    = 4,
 };
 
+/* MTP write stage, for internal use only */
+enum mtp_write_status {
+    WRITE_START    = 1,
+    WRITE_CONTINUE = 2,
+    WRITE_END      = 3,
+};
+
 enum mtp_code {
     /* command codes */
     CMD_GET_DEVICE_INFO            = 0x1001,
@@ -154,6 +161,9 @@ struct MTPData {
     /* Used for >4G file sizes */
     bool         pending;
     int          fd;
+    uint8_t      write_status;
+    /* Internal pointer per every MTP_WRITE_BUF_SZ */
+    uint64_t     data_offset;
 };
 
 struct MTPObject {
@@ -1620,10 +1630,14 @@ static char *utf16_to_str(uint8_t len, uint16_t *arr)
 }
 
 /* Wrapper around write, returns 0 on failure */
-static uint64_t write_retry(int fd, void *buf, uint64_t size)
+static uint64_t write_retry(int fd, void *buf, uint64_t size, off_t offset)
 {
         uint64_t bytes_left = size, ret;
 
+        if (lseek(fd, offset, SEEK_SET) < 0) {
+            goto done;
+        }
+
         while (bytes_left > 0) {
                 ret = write(fd, buf, bytes_left);
                 if ((ret == -1) && (errno != EINTR || errno != EAGAIN ||
@@ -1634,9 +1648,20 @@ static uint64_t write_retry(int fd, void *buf, uint64_t size)
                 buf += ret;
         }
 
+done:
         return size - bytes_left;
 }
 
+static void usb_mtp_update_object(MTPObject *parent, char *name)
+{
+    MTPObject *o =
+        usb_mtp_object_lookup_name(parent, name, strlen(name));
+
+    if (o) {
+        lstat(o->path, &o->stat);
+    }
+}
+
 static void usb_mtp_write_data(MTPState *s)
 {
     MTPData *d = s->data_out;
@@ -1648,48 +1673,56 @@ static void usb_mtp_write_data(MTPState *s)
 
     assert(d != NULL);
 
-    if (parent == NULL || !s->write_pending) {
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
-        path = g_strdup_printf("%s/%s", parent->path, s->dataset.filename);
-        if (s->dataset.format == FMT_ASSOCIATION) {
-            d->fd = mkdir(path, mask);
-            goto free;
-        }
-        if ((s->dataset.size != 0xFFFFFFFF) && (s->dataset.size != d->offset)) {
-            usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
-                                 0, 0, 0, 0);
-            goto done;
-        }
-        d->fd = open(path, O_CREAT | O_WRONLY | O_CLOEXEC | O_NOFOLLOW, mask);
-        if (d->fd == -1) {
-            usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
-                                 0, 0, 0, 0);
-            goto done;
         }
 
-        /*
-         * Return success if initiator sent 0 sized data
-         */
-        if (!s->dataset.size) {
-            goto success;
-        }
+        if (s->dataset.filename) {
+            path = g_strdup_printf("%s/%s", parent->path, s->dataset.filename);
+            if (s->dataset.format == FMT_ASSOCIATION) {
+                d->fd = mkdir(path, mask);
+                goto free;
+            }
+            d->fd = open(path, O_CREAT | O_WRONLY |
+                         O_CLOEXEC | O_NOFOLLOW, mask);
+            if (d->fd == -1) {
+                usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
+                                     0, 0, 0, 0);
+                goto done;
+            }
 
-        rc = write_retry(d->fd, d->data, d->offset);
-        if (rc != d->offset) {
+            /* Return success if initiator sent 0 sized data */
+            if (!s->dataset.size) {
+                goto success;
+            }
+            if (d->length != MTP_WRITE_BUF_SZ && !d->pending) {
+                d->write_status = WRITE_END;
+            }
+        }
+        /* fall through */
+    case WRITE_CONTINUE:
+    case WRITE_END:
+        rc = write_retry(d->fd, d->data, d->data_offset,
+                         d->offset - d->data_offset);
+        if (rc != d->data_offset) {
             usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
                                  0, 0, 0, 0);
             goto done;
+        }
+        if (d->write_status != WRITE_END) {
+            return;
+        } else {
+            /* Only for < 4G file sizes */
+            if (s->dataset.size != 0xFFFFFFFF && d->offset != s->dataset.size) {
+                usb_mtp_queue_result(s, RES_INCOMPLETE_TRANSFER, d->trans,
+                                     0, 0, 0, 0);
+                goto done;
             }
-        /* Only for < 4G file sizes */
-        if (s->dataset.size != 0xFFFFFFFF && rc != s->dataset.size) {
-            usb_mtp_queue_result(s, RES_INCOMPLETE_TRANSFER, d->trans,
-                                 0, 0, 0, 0);
-            goto done;
+            usb_mtp_update_object(parent, s->dataset.filename);
         }
     }
 
@@ -1788,25 +1821,33 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
         d->offset = 0;
         d->first = false;
         d->pending = false;
+        d->data_offset = 0;
+        d->write_status = WRITE_START;
     }
 
     if (d->pending) {
-        usb_mtp_realloc(d, MTP_WRITE_BUF_SZ);
-        d->length += MTP_WRITE_BUF_SZ;
+        memset(d->data, 0, d->length);
+        if (d->length != MTP_WRITE_BUF_SZ) {
+            usb_mtp_realloc(d, MTP_WRITE_BUF_SZ - d->length);
+            d->length += (MTP_WRITE_BUF_SZ - d->length);
+        }
         d->pending = false;
+        d->write_status = WRITE_CONTINUE;
+        d->data_offset = 0;
     }
 
-    if (d->length - d->offset > data_len) {
+    if (d->length - d->data_offset > data_len) {
         dlen = data_len;
     } else {
-        dlen = d->length - d->offset;
+        dlen = d->length - d->data_offset;
     }
 
     switch (d->code) {
     case CMD_SEND_OBJECT_INFO:
-        usb_packet_copy(p, d->data + d->offset, dlen);
+        usb_packet_copy(p, d->data + d->data_offset, dlen);
         d->offset += dlen;
-        if (d->offset == d->length) {
+        d->data_offset += dlen;
+        if (d->data_offset == d->length) {
             /* The operation might have already failed */
             if (!s->result) {
                 usb_mtp_write_metadata(s, dlen);
@@ -1817,19 +1858,26 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
         }
         break;
     case CMD_SEND_OBJECT:
-        usb_packet_copy(p, d->data + d->offset, dlen);
+        usb_packet_copy(p, d->data + d->data_offset, dlen);
         d->offset += dlen;
+        d->data_offset += dlen;
         if ((p->iov.size % 64) || !p->iov.size) {
             assert((s->dataset.size == 0xFFFFFFFF) ||
                    (s->dataset.size == d->offset));
 
+            if (d->length == MTP_WRITE_BUF_SZ) {
+                d->write_status = WRITE_END;
+            } else {
+                d->write_status = WRITE_START;
+            }
             usb_mtp_write_data(s);
             usb_mtp_data_free(s->data_out);
             s->data_out = NULL;
             return;
         }
-        if (d->offset == d->length) {
+        if (d->data_offset == d->length) {
             d->pending = true;
+            usb_mtp_write_data(s);
         }
         break;
     default:
-- 
2.9.3
