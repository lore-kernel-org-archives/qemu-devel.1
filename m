Received: from eggs.gnu.org ([2001:4830:134:3::10]:41924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1eox0K-0006R0-IR
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 14:58:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1eox0H-0000Dm-GS
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 14:58:08 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33602 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1eox0H-0000Cr-BK
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 14:58:05 -0500
From: Bandan Das <bsd@redhat.com>
Date: Thu, 22 Feb 2018 14:57:40 -0500
Message-Id: <20180222195740.12726-6-bsd@redhat.com>
In-Reply-To: <20180222195740.12726-1-bsd@redhat.com>
References: <20180222195740.12726-1-bsd@redhat.com>
Subject: [Qemu-devel] [PATCH v5 5/5] usb-mtp: Advertise SendObjectInfo for
 write support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, eblake@redhat.com, peter.maydell@linaro.org, berrange@redhat.com

This patch implements a dummy ObjectInfo structure so that
it's easy to typecast the incoming data. If the metadata is
valid, write_pending is set. Also, the incoming filename
is utf-16, so, instead of depending on external libraries, just
implement a simple function to get the filename

Signed-off-by: Bandan Das <bsd@redhat.com>
---
 hw/usb/dev-mtp.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 134 insertions(+), 2 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 6372c11e81..a6ba333357 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -47,6 +47,7 @@ enum mtp_code {
     CMD_GET_OBJECT_INFO            = 0x1008,
     CMD_GET_OBJECT                 = 0x1009,
     CMD_DELETE_OBJECT              = 0x100b,
+    CMD_SEND_OBJECT_INFO           = 0x100c,
     CMD_SEND_OBJECT                = 0x100d,
     CMD_GET_PARTIAL_OBJECT         = 0x101b,
     CMD_GET_OBJECT_PROPS_SUPPORTED = 0x9801,
@@ -67,8 +68,10 @@ enum mtp_code {
     RES_STORE_FULL                 = 0x200c,
     RES_STORE_READ_ONLY            = 0x200e,
     RES_PARTIAL_DELETE             = 0x2012,
+    RES_STORE_NOT_AVAILABLE        = 0x2013,
     RES_SPEC_BY_FORMAT_UNSUPPORTED = 0x2014,
     RES_INVALID_OBJECTINFO         = 0x2015,
+    RES_DESTINATION_UNSUPPORTED    = 0x2020,
     RES_INVALID_PARENT_OBJECT      = 0x201a,
     RES_INVALID_PARAMETER          = 0x201d,
     RES_SESSION_ALREADY_OPEN       = 0x201e,
@@ -196,6 +199,34 @@ struct MTPState {
     } dataset;
 };
 
+/*
+ * ObjectInfo dataset received from initiator
+ * Fields we don't care about are ignored
+ */
+typedef struct {
+    uint32_t storage_id; /*unused*/
+    uint16_t format;
+    uint16_t protection_status; /*unused*/
+    uint32_t size;
+    uint16_t thumb_format; /*unused*/
+    uint32_t thumb_comp_sz; /*unused*/
+    uint32_t thumb_pix_width; /*unused*/
+    uint32_t thumb_pix_height; /*unused*/
+    uint32_t image_pix_width; /*unused*/
+    uint32_t image_pix_height; /*unused*/
+    uint32_t image_bit_depth; /*unused*/
+    uint32_t parent; /*unused*/
+    uint16_t assoc_type;
+    uint32_t assoc_desc;
+    uint32_t seq_no; /*unused*/
+    uint8_t length; /*part of filename field*/
+    uint16_t filename[0];
+    char date_created[0]; /*unused*/
+    char date_modified[0]; /*unused*/
+    char keywords[0]; /*unused*/
+    /* string and other data follows */
+} QEMU_PACKED ObjectInfo;
+
 #define TYPE_USB_MTP "usb-mtp"
 #define USB_MTP(obj) OBJECT_CHECK(MTPState, (obj), TYPE_USB_MTP)
 
@@ -437,7 +468,6 @@ static MTPObject *usb_mtp_add_child(MTPState *s, MTPObject *o,
     return child;
 }
 
-#ifdef CONFIG_INOTIFY1
 static MTPObject *usb_mtp_object_lookup_name(MTPObject *parent,
                                              char *name, int len)
 {
@@ -452,6 +482,7 @@ static MTPObject *usb_mtp_object_lookup_name(MTPObject *parent,
     return NULL;
 }
 
+#ifdef CONFIG_INOTIFY1
 static MTPObject *usb_mtp_object_lookup_wd(MTPState *s, int wd)
 {
     MTPObject *iter;
@@ -815,6 +846,7 @@ static MTPData *usb_mtp_get_device_info(MTPState *s, MTPControl *c)
         CMD_GET_OBJECT_HANDLES,
         CMD_GET_OBJECT_INFO,
         CMD_DELETE_OBJECT,
+        CMD_SEND_OBJECT_INFO,
         CMD_SEND_OBJECT,
         CMD_GET_OBJECT,
         CMD_GET_PARTIAL_OBJECT,
@@ -1243,7 +1275,7 @@ static void usb_mtp_object_delete(MTPState *s, uint32_t handle,
 static void usb_mtp_command(MTPState *s, MTPControl *c)
 {
     MTPData *data_in = NULL;
-    MTPObject *o;
+    MTPObject *o = NULL;
     uint32_t nres = 0, res0 = 0;
 
     /* sanity checks */
@@ -1390,6 +1422,41 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
         nres = 1;
         res0 = data_in->length;
         break;
+    case CMD_SEND_OBJECT_INFO:
+        /* Return error if store is read-only */
+        if (!FLAG_SET(s, MTP_FLAG_WRITABLE)) {
+            usb_mtp_queue_result(s, RES_STORE_READ_ONLY,
+                                 c->trans, 0, 0, 0, 0);
+        } else if (c->argv[0] && (c->argv[0] != QEMU_STORAGE_ID)) {
+        /* First parameter points to storage id or is 0 */
+            usb_mtp_queue_result(s, RES_STORE_NOT_AVAILABLE, c->trans,
+                                 0, 0, 0, 0);
+        } else if (c->argv[1] && !c->argv[0]) {
+            /* If second parameter is specified, first must also be specified */
+            usb_mtp_queue_result(s, RES_DESTINATION_UNSUPPORTED, c->trans,
+                                 0, 0, 0, 0);
+        } else {
+            uint32_t handle = c->argv[1];
+            if (handle == 0xFFFFFFFF || handle == 0) {
+                /* root object */
+                o = QTAILQ_FIRST(&s->objects);
+            } else {
+                o = usb_mtp_object_lookup(s, handle);
+            }
+            if (o == NULL) {
+                usb_mtp_queue_result(s, RES_INVALID_OBJECT_HANDLE, c->trans,
+                                     0, 0, 0, 0);
+            }
+            if (o->format != FMT_ASSOCIATION) {
+                usb_mtp_queue_result(s, RES_INVALID_PARENT_OBJECT, c->trans,
+                                     0, 0, 0, 0);
+            }
+        }
+        if (o) {
+            s->dataset.parent_handle = o->handle;
+        }
+        s->data_out = usb_mtp_data_alloc(c);
+        return;
     case CMD_SEND_OBJECT:
         if (!FLAG_SET(s, MTP_FLAG_WRITABLE)) {
             usb_mtp_queue_result(s, RES_STORE_READ_ONLY,
@@ -1497,6 +1564,19 @@ static void usb_mtp_cancel_packet(USBDevice *dev, USBPacket *p)
     fprintf(stderr, "%s\n", __func__);
 }
 
+static void utf16_to_str(uint8_t len, uint16_t *arr, char *name)
+{
+    int count;
+    wchar_t *wstr = g_new0(wchar_t, len);
+
+    for (count = 0; count < len; count++) {
+        wstr[count] = (wchar_t)arr[count];
+    }
+
+    wcstombs(name, wstr, len);
+    g_free(wstr);
+}
+
 static void usb_mtp_write_data(MTPState *s)
 {
     MTPData *d = s->data_out;
@@ -1570,6 +1650,45 @@ free:
     s->write_pending = false;
 }
 
+static void usb_mtp_write_metadata(MTPState *s)
+{
+    MTPData *d = s->data_out;
+    ObjectInfo *dataset = (ObjectInfo *)d->data;
+    char *filename = g_new0(char, dataset->length);
+    MTPObject *o;
+    MTPObject *p = usb_mtp_object_lookup(s, s->dataset.parent_handle);
+    uint32_t next_handle = s->next_handle;
+
+    assert(!s->write_pending);
+
+    utf16_to_str(dataset->length, dataset->filename, filename);
+
+    o = usb_mtp_object_lookup_name(p, filename, dataset->length);
+    if (o != NULL) {
+        next_handle = o->handle;
+    }
+
+    s->dataset.filename = filename;
+    s->dataset.format = dataset->format;
+    s->dataset.size = dataset->size;
+    s->dataset.filename = filename;
+    s->write_pending = true;
+
+    if (s->dataset.format == FMT_ASSOCIATION) {
+        usb_mtp_write_data(s);
+        /* next_handle will be allocated to the newly created dir */
+        if (d->fd == -1) {
+            usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
+                                 0, 0, 0, 0);
+            return;
+        }
+        d->fd = -1;
+    }
+
+    usb_mtp_queue_result(s, RES_OK, d->trans, 3, QEMU_STORAGE_ID,
+                         s->dataset.parent_handle, next_handle);
+}
+
 static void usb_mtp_get_data(MTPState *s, mtp_container *container,
                              USBPacket *p)
 {
@@ -1594,6 +1713,19 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
     }
 
     switch (d->code) {
+    case CMD_SEND_OBJECT_INFO:
+        usb_packet_copy(p, d->data + d->offset, dlen);
+        d->offset += dlen;
+        if (d->offset == d->length) {
+            /* The operation might have already failed */
+            if (!s->result) {
+                usb_mtp_write_metadata(s);
+            }
+            usb_mtp_data_free(s->data_out);
+            s->data_out = NULL;
+            return;
+        }
+        break;
     case CMD_SEND_OBJECT:
         usb_packet_copy(p, d->data + d->offset, dlen);
         d->offset += dlen;
-- 
2.14.3
