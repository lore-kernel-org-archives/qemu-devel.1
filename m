Received: from eggs.gnu.org ([2001:4830:134:3::10]:48005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1dsMl2-0002tI-LW
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 01:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1dsMl1-0006SR-0Z
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 01:32:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1dsMl0-0006Qo-Ny
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 01:32:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C9F147EBD3
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 05:32:09 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
Date: Thu, 14 Sep 2017 01:31:48 -0400
Message-Id: <20170914053148.2512-6-bsd@redhat.com>
In-Reply-To: <20170914053148.2512-1-bsd@redhat.com>
References: <20170914053148.2512-1-bsd@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] usb-mtp: Advertise SendObjectInfo for
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
Cc: kraxel@redhat.com

From: Bandan Das <bsd@makefile.in>

This patch implements a dummy ObjectInfo structure so that
it's easy to typecast the incoming data. If the metadata is
valid, write_pending is set. Also, the incoming filename
is utf-16, so, instead of depending on external libraries, just
implement a simple function to get the filename

Signed-off-by: Bandan Das <bsd@makefile.in>
---
 hw/usb/dev-mtp.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 2ff9f0f..e5152db 100644
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
@@ -66,8 +67,10 @@ enum mtp_code {
     RES_INVALID_OBJECT_FORMAT_CODE = 0x200b,
     RES_STORE_READ_ONLY            = 0x200e,
     RES_PARTIAL_DELETE             = 0x2012,
+    RES_STORE_NOT_AVAILABLE        = 0x2013,
     RES_SPEC_BY_FORMAT_UNSUPPORTED = 0x2014,
     RES_INVALID_OBJECTINFO         = 0x2015,
+    RES_DESTINATION_UNSUPPORTED    = 0x2020,
     RES_INVALID_PARENT_OBJECT      = 0x201a,
     RES_STORE_FULL                 = 0x200c,
     RES_INVALID_PARAMETER          = 0x201d,
@@ -195,6 +198,24 @@ struct MTPState {
     } dataset;
 };
 
+/*
+ * ObjectInfo dataset received from initiator
+ * Fields we don't care about are ignored
+ */
+typedef struct {
+    char __pad1[4];
+    uint16_t format;
+    char __pad2[2];
+    uint32_t size;
+    char __pad3[30];
+    uint16_t assoc_type;
+    uint32_t assoc_desc;
+    char __pad4[4];
+    uint8_t length;
+    uint16_t filename[0];
+    /* string and other data follows */
+} QEMU_PACKED ObjectInfo;
+
 #define TYPE_USB_MTP "usb-mtp"
 #define USB_MTP(obj) OBJECT_CHECK(MTPState, (obj), TYPE_USB_MTP)
 
@@ -814,6 +835,7 @@ static MTPData *usb_mtp_get_device_info(MTPState *s, MTPControl *c)
         CMD_GET_OBJECT_HANDLES,
         CMD_GET_OBJECT_INFO,
         CMD_DELETE_OBJECT,
+        CMD_SEND_OBJECT_INFO,
         CMD_SEND_OBJECT,
         CMD_GET_OBJECT,
         CMD_GET_PARTIAL_OBJECT,
@@ -1393,6 +1415,35 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
         nres = 1;
         res0 = data_in->length;
         break;
+    case CMD_SEND_OBJECT_INFO:
+        /* First parameter points to storage id or is 0 */
+        if (c->argv[0] && (c->argv[0] != QEMU_STORAGE_ID)) {
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
+        s->dataset.parent_handle = o->handle;
+        s->data_out = usb_mtp_data_alloc(c);
+        return;
     case CMD_SEND_OBJECT:
         if (!s->write_pending) {
             usb_mtp_queue_result(s, RES_INVALID_OBJECTINFO,
@@ -1502,6 +1553,17 @@ mode_t getumask(void)
     return mask;
 }
 
+static void utf16_to_str(uint8_t len, uint16_t *arr, char *name)
+{
+    int count;
+
+    for (count = 0; count < len; count++) {
+        /* Check for valid ascii */
+        assert(!(arr[count] & 0xFF80));
+        name[count] = arr[count];
+    }
+}
+
 static void usb_mtp_write_data(MTPState *s)
 {
     MTPData *d = s->data_out;
@@ -1575,6 +1637,45 @@ free:
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
@@ -1599,6 +1700,19 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
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
2.9.4
