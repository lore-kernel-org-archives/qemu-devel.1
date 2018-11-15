Received: from eggs.gnu.org ([2001:4830:134:3::10]:37133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1gNPi7-00032g-At
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:02:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1gNPi4-0000RE-QO
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:02:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1gNPi2-0000OS-RT
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:02:00 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C2159307D856
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 22:01:56 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
Date: Thu, 15 Nov 2018 17:01:32 -0500
Message-Id: <20181115220132.6531-3-bsd@redhat.com>
In-Reply-To: <20181115220132.6531-1-bsd@redhat.com>
References: <20181115220132.6531-1-bsd@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] usb-mtp: breakup MTP write into smaller
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
 hw/usb/dev-mtp.c | 133 +++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 90 insertions(+), 43 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index de941d649c..fce6029df0 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -35,6 +35,13 @@ enum mtp_container_type {
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
@@ -153,6 +160,9 @@ struct MTPData {
     /* Used for >4G file sizes */
     bool         pending;
     int          fd;
+    uint8_t      write_status;
+    /* Internal pointer per every MTP_WRITE_BUF_SZ */
+    uint64_t     data_offset;
 };
 
 struct MTPObject {
@@ -1607,10 +1617,14 @@ static void utf16_to_str(uint8_t len, uint16_t *arr, char *name)
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
@@ -1621,9 +1635,20 @@ static uint64_t write_retry(int fd, void *buf, uint64_t size)
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
@@ -1635,48 +1660,55 @@ static void usb_mtp_write_data(MTPState *s)
 
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
-        d->fd = open(path, O_CREAT | O_WRONLY, mask);
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
+            d->fd = open(path, O_CREAT | O_WRONLY, mask);
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
 
@@ -1767,25 +1799,33 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
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
                 usb_mtp_write_metadata(s);
@@ -1796,19 +1836,26 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
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
2.14.4
