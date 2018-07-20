Received: from eggs.gnu.org ([2001:4830:134:3::10]:42727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fgd8g-0005DJ-GX
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 17:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fgd8d-0005nD-Is
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 17:40:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34188 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1fgd8d-0005lx-8L
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 17:40:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 669BFFA45C
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 21:40:34 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
Date: Fri, 20 Jul 2018 17:40:19 -0400
Message-Id: <20180720214020.22897-5-bsd@redhat.com>
In-Reply-To: <20180720214020.22897-1-bsd@redhat.com>
References: <20180720214020.22897-1-bsd@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] dev-mtp: Add support for > 4GB file
 transfers
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

To support larger file transfers, rely on a short packet
to detect end of the data phase and rewrite d->length to
the size received

Signed-off-by: Bandan Das <bsd@redhat.com>
---
 hw/usb/dev-mtp.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index c8f6eb4e9e..2e3ea58da6 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -147,9 +147,12 @@ struct MTPData {
     uint32_t     trans;
     uint64_t     offset;
     uint64_t     length;
-    uint32_t     alloc;
+    uint64_t     alloc;
     uint8_t      *data;
     bool         first;
+    /* Used for >4G file sizes */
+    bool         pending;
+    uint64_t     cached_length;
     int          fd;
 };
 
@@ -1626,7 +1629,7 @@ static void usb_mtp_write_data(MTPState *s)
     MTPObject *parent =
         usb_mtp_object_lookup(s, s->dataset.parent_handle);
     char *path = NULL;
-    int rc = -1;
+    uint64_t rc;
     mode_t mask = 0644;
 
     assert(d != NULL);
@@ -1643,7 +1646,7 @@ static void usb_mtp_write_data(MTPState *s)
             d->fd = mkdir(path, mask);
             goto free;
         }
-        if (s->dataset.size < d->length) {
+        if ((s->dataset.size != 0xFFFFFFFF) && (s->dataset.size < d->length)) {
             usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
                                  0, 0, 0, 0);
             goto done;
@@ -1754,13 +1757,27 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
         usb_mtp_realloc(d, total_len);
         d->length += total_len;
         d->offset = 0;
+        d->cached_length = total_len;
         d->first = false;
+        d->pending = false;
+    }
+
+    if (d->pending) {
+        usb_mtp_realloc(d, d->cached_length);
+        d->length += d->cached_length;
+        d->pending = false;
     }
 
     if (d->length - d->offset > data_len) {
         dlen = data_len;
     } else {
         dlen = d->length - d->offset;
+        /* Check for cached data for large files */
+        if ((s->dataset.size == 0xFFFFFFFF) && (dlen < p->iov.size)) {
+            usb_mtp_realloc(d, p->iov.size - dlen);
+            d->length += p->iov.size - dlen;
+            dlen = p->iov.size;
+        }
     }
 
     switch (d->code) {
@@ -1780,12 +1797,18 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
     case CMD_SEND_OBJECT:
         usb_packet_copy(p, d->data + d->offset, dlen);
         d->offset += dlen;
-        if (d->offset == d->length) {
+        if ((p->iov.size % 64) || !p->iov.size) {
+            assert((s->dataset.size == 0xFFFFFFFF) ||
+                   (s->dataset.size == d->length));
+
             usb_mtp_write_data(s);
             usb_mtp_data_free(s->data_out);
             s->data_out = NULL;
             return;
         }
+        if (d->offset == d->length) {
+            d->pending = true;
+        }
         break;
     default:
         p->status = USB_RET_STALL;
-- 
2.14.4
