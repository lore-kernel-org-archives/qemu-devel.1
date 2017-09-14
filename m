Received: from eggs.gnu.org ([2001:4830:134:3::10]:48006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1dsMl2-0002tS-Lm
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 01:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1dsMl0-0006RW-F0
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 01:32:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1dsMl0-0006PB-6G
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 01:32:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 52167C0587C5
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 05:32:09 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
Date: Thu, 14 Sep 2017 01:31:47 -0400
Message-Id: <20170914053148.2512-5-bsd@redhat.com>
In-Reply-To: <20170914053148.2512-1-bsd@redhat.com>
References: <20170914053148.2512-1-bsd@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] usb-mtp: Introduce write support for MTP
 objects
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

Allow write operations on behalf of the initiator. The
precursor to write is the sending of the write metadata
that consists of the ObjectInfo dataset. This patch introduces
a flag that is set when the responder is ready to receive
write data based on a previous SendObjectInfo operation by
the initiator (The SendObjectInfo implementation is in a
later patch)

Signed-off-by: Bandan Das <bsd@makefile.in>
---
 hw/usb/dev-mtp.c | 159 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 157 insertions(+), 2 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 76494f3..2ff9f0f 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -47,6 +47,7 @@ enum mtp_code {
     CMD_GET_OBJECT_INFO            = 0x1008,
     CMD_GET_OBJECT                 = 0x1009,
     CMD_DELETE_OBJECT              = 0x100b,
+    CMD_SEND_OBJECT                = 0x100d,
     CMD_GET_PARTIAL_OBJECT         = 0x101b,
     CMD_GET_OBJECT_PROPS_SUPPORTED = 0x9801,
     CMD_GET_OBJECT_PROP_DESC       = 0x9802,
@@ -66,7 +67,9 @@ enum mtp_code {
     RES_STORE_READ_ONLY            = 0x200e,
     RES_PARTIAL_DELETE             = 0x2012,
     RES_SPEC_BY_FORMAT_UNSUPPORTED = 0x2014,
+    RES_INVALID_OBJECTINFO         = 0x2015,
     RES_INVALID_PARENT_OBJECT      = 0x201a,
+    RES_STORE_FULL                 = 0x200c,
     RES_INVALID_PARAMETER          = 0x201d,
     RES_SESSION_ALREADY_OPEN       = 0x201e,
     RES_INVALID_OBJECT_PROP_CODE   = 0xA801,
@@ -182,6 +185,14 @@ struct MTPState {
     int          inotifyfd;
     QTAILQ_HEAD(events, MTPMonEntry) events;
 #endif
+    /* Responder is expecting a write operation */
+    bool write_pending;
+    struct {
+        uint32_t parent_handle;
+        uint16_t format;
+        uint32_t size;
+        char *filename;
+    } dataset;
 };
 
 #define TYPE_USB_MTP "usb-mtp"
@@ -803,6 +814,7 @@ static MTPData *usb_mtp_get_device_info(MTPState *s, MTPControl *c)
         CMD_GET_OBJECT_HANDLES,
         CMD_GET_OBJECT_INFO,
         CMD_DELETE_OBJECT,
+        CMD_SEND_OBJECT,
         CMD_GET_OBJECT,
         CMD_GET_PARTIAL_OBJECT,
         CMD_GET_OBJECT_PROPS_SUPPORTED,
@@ -1381,6 +1393,14 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
         nres = 1;
         res0 = data_in->length;
         break;
+    case CMD_SEND_OBJECT:
+        if (!s->write_pending) {
+            usb_mtp_queue_result(s, RES_INVALID_OBJECTINFO,
+                                 c->trans, 0, 0, 0, 0);
+            return;
+        }
+        s->data_out = usb_mtp_data_alloc(c);
+        return;
     case CMD_GET_OBJECT_PROPS_SUPPORTED:
         if (c->argv[0] != FMT_UNDEFINED_OBJECT &&
             c->argv[0] != FMT_ASSOCIATION) {
@@ -1475,12 +1495,133 @@ static void usb_mtp_cancel_packet(USBDevice *dev, USBPacket *p)
     fprintf(stderr, "%s\n", __func__);
 }
 
+mode_t getumask(void)
+{
+    mode_t mask = umask(0);
+    umask(mask);
+    return mask;
+}
+
+static void usb_mtp_write_data(MTPState *s)
+{
+    MTPData *d = s->data_out;
+    MTPObject *parent =
+        usb_mtp_object_lookup(s, s->dataset.parent_handle);
+    char *path;
+    int rc = -1;
+    mode_t mask = ~getumask() & 0777;
+
+    assert(d != NULL);
+
+    if (parent == NULL || !s->write_pending) {
+        usb_mtp_queue_result(s, RES_INVALID_OBJECTINFO, d->trans,
+                             0, 0, 0, 0);
+        return;
+    }
+
+    if (s->dataset.filename) {
+        path = g_strdup_printf("%s/%s", parent->path, s->dataset.filename);
+        if (s->dataset.format == FMT_ASSOCIATION) {
+            d->fd = mkdir(path, mask);
+            goto free;
+        }
+        if (s->dataset.size < d->length) {
+            usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
+                                 0, 0, 0, 0);
+            goto done;
+        }
+        d->fd = open(path, O_CREAT | O_WRONLY, mask);
+        if (d->fd == -1) {
+            usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
+                                 0, 0, 0, 0);
+            goto done;
+        }
+
+        /*
+         * Return success if initiator sent 0 sized data
+         */
+        if (!s->dataset.size) {
+            goto success;
+        }
+
+        rc = write(d->fd, d->data, s->dataset.size);
+        if (rc == -1) {
+            usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
+                                 0, 0, 0, 0);
+            goto done;
+            }
+        if (rc != s->dataset.size) {
+            usb_mtp_queue_result(s, RES_INCOMPLETE_TRANSFER, d->trans,
+                                 0, 0, 0, 0);
+            goto done;
+        }
+    }
+
+success:
+    usb_mtp_queue_result(s, RES_OK, d->trans,
+                         0, 0, 0, 0);
+
+done:
+    /*
+     * The write dataset is kept around and freed only
+     * on success or if another write request comes in
+     */
+    if (d->fd != -1) {
+        close(d->fd);
+    }
+free:
+    g_free(s->dataset.filename);
+    g_free(path);
+    s->write_pending = false;
+}
+
+static void usb_mtp_get_data(MTPState *s, mtp_container *container,
+                             USBPacket *p)
+{
+    MTPData *d = s->data_out;
+    uint64_t dlen;
+    uint32_t data_len = p->iov.size;
+
+    if (d->first) {
+        /* Total length of incoming data */
+        d->length = cpu_to_le32(container->length) - sizeof(mtp_container);
+        /* Length of data in this packet */
+        data_len -= sizeof(mtp_container);
+        usb_mtp_realloc(d, d->length);
+        d->offset = 0;
+        d->first = false;
+    }
+
+    if (d->length - d->offset > data_len) {
+        dlen = data_len;
+    } else {
+        dlen = d->length - d->offset;
+    }
+
+    switch (d->code) {
+    case CMD_SEND_OBJECT:
+        usb_packet_copy(p, d->data + d->offset, dlen);
+        d->offset += dlen;
+        if (d->offset == d->length) {
+            usb_mtp_write_data(s);
+            usb_mtp_data_free(s->data_out);
+            s->data_out = NULL;
+            return;
+        }
+        break;
+    default:
+        p->status = USB_RET_STALL;
+        return;
+    }
+}
+
 static void usb_mtp_handle_data(USBDevice *dev, USBPacket *p)
 {
     MTPState *s = USB_MTP(dev);
     MTPControl cmd;
     mtp_container container;
     uint32_t params[5];
+    uint16_t container_type;
     int i, rc;
 
     switch (p->ep->nr) {
@@ -1570,8 +1711,13 @@ static void usb_mtp_handle_data(USBDevice *dev, USBPacket *p)
             p->status = USB_RET_STALL;
             return;
         }
-        usb_packet_copy(p, &container, sizeof(container));
-        switch (le16_to_cpu(container.type)) {
+        if (s->data_out && !s->data_out->first) {
+            container_type = TYPE_DATA;
+        } else {
+            usb_packet_copy(p, &container, sizeof(container));
+            container_type = le16_to_cpu(container.type);
+        }
+        switch (container_type) {
         case TYPE_COMMAND:
             if (s->data_in || s->data_out || s->result) {
                 trace_usb_mtp_stall(s->dev.addr, "transaction inflight");
@@ -1602,6 +1748,15 @@ static void usb_mtp_handle_data(USBDevice *dev, USBPacket *p)
                                   (cmd.argc > 4) ? cmd.argv[4] : 0);
             usb_mtp_command(s, &cmd);
             break;
+        case TYPE_DATA:
+            /* One of the previous transfers has already errored but the
+             * responder is still sending data associated with it
+             */
+            if (s->result != NULL) {
+                return;
+            }
+            usb_mtp_get_data(s, &container, p);
+            break;
         default:
             /* not needed as long as the mtp device is read-only */
             p->status = USB_RET_STALL;
-- 
2.9.4
