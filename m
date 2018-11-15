Received: from eggs.gnu.org ([2001:4830:134:3::10]:37078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1gNPi2-0002zL-NS
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:01:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1gNPhz-0000N7-Ia
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:01:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1gNPhy-0000IJ-SG
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:01:55 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 891CA1556B
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 22:01:51 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
Date: Thu, 15 Nov 2018 17:01:31 -0500
Message-Id: <20181115220132.6531-2-bsd@redhat.com>
In-Reply-To: <20181115220132.6531-1-bsd@redhat.com>
References: <20181115220132.6531-1-bsd@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] usb-mtp: Reallocate buffer in multiples of
 MTP_WRITE_BUF_SZ
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

This is a "pre-patch" to breaking up the write buffer for
MTP writes. Instead of allocating a mtp buffer equal to size
sent by the initiator, we start with a small size and reallocate
multiples (of that small size) as needed.

Signed-off-by: Bandan Das <bsd@redhat.com>
---
 hw/usb/dev-mtp.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 00a3691bae..de941d649c 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -152,7 +152,6 @@ struct MTPData {
     bool         first;
     /* Used for >4G file sizes */
     bool         pending;
-    uint64_t     cached_length;
     int          fd;
 };
 
@@ -244,6 +243,7 @@ typedef struct {
 
 #define MTP_MANUFACTURER  "QEMU"
 #define MTP_PRODUCT       "QEMU filesharing"
+#define MTP_WRITE_BUF_SZ  512000
 
 enum {
     STR_MANUFACTURER = 1,
@@ -1647,7 +1647,7 @@ static void usb_mtp_write_data(MTPState *s)
             d->fd = mkdir(path, mask);
             goto free;
         }
-        if ((s->dataset.size != 0xFFFFFFFF) && (s->dataset.size < d->length)) {
+        if ((s->dataset.size != 0xFFFFFFFF) && (s->dataset.size != d->offset)) {
             usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
                                  0, 0, 0, 0);
             goto done;
@@ -1757,17 +1757,21 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
         total_len = cpu_to_le32(container->length) - sizeof(mtp_container);
         /* Length of data in this packet */
         data_len -= sizeof(mtp_container);
-        usb_mtp_realloc(d, total_len);
-        d->length += total_len;
+        if (total_len < MTP_WRITE_BUF_SZ) {
+                usb_mtp_realloc(d, total_len);
+                d->length += total_len;
+        } else {
+                usb_mtp_realloc(d, MTP_WRITE_BUF_SZ - sizeof(mtp_container));
+                d->length += MTP_WRITE_BUF_SZ - sizeof(mtp_container);
+        }
         d->offset = 0;
-        d->cached_length = total_len;
         d->first = false;
         d->pending = false;
     }
 
     if (d->pending) {
-        usb_mtp_realloc(d, d->cached_length);
-        d->length += d->cached_length;
+        usb_mtp_realloc(d, MTP_WRITE_BUF_SZ);
+        d->length += MTP_WRITE_BUF_SZ;
         d->pending = false;
     }
 
@@ -1775,12 +1779,6 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
         dlen = data_len;
     } else {
         dlen = d->length - d->offset;
-        /* Check for cached data for large files */
-        if ((s->dataset.size == 0xFFFFFFFF) && (dlen < p->iov.size)) {
-            usb_mtp_realloc(d, p->iov.size - dlen);
-            d->length += p->iov.size - dlen;
-            dlen = p->iov.size;
-        }
     }
 
     switch (d->code) {
@@ -1802,7 +1800,7 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
         d->offset += dlen;
         if ((p->iov.size % 64) || !p->iov.size) {
             assert((s->dataset.size == 0xFFFFFFFF) ||
-                   (s->dataset.size == d->length));
+                   (s->dataset.size == d->offset));
 
             usb_mtp_write_data(s);
             usb_mtp_data_free(s->data_out);
-- 
2.14.4
