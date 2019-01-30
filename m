Received: from eggs.gnu.org ([209.51.188.92]:45501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gokOS-0004v5-Op
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gokOR-00077e-9W
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:34:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gokOL-00074p-F4
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:34:40 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 30 Jan 2019 08:34:24 +0100
Message-Id: <20190130073426.11525-7-kraxel@redhat.com>
In-Reply-To: <20190130073426.11525-1-kraxel@redhat.com>
References: <20190130073426.11525-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 6/8] usb-mtp: Reallocate buffer in multiples of
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
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Bandan Das <bsd@redhat.com>

From: Bandan Das <bsd@redhat.com>

This is a "pre-patch" to breaking up the write buffer for
MTP writes. Instead of allocating a mtp buffer equal to size
sent by the initiator, we start with a small size and reallocate
multiples (of that small size) as needed.

Signed-off-by: Bandan Das <bsd@redhat.com>
Message-id: 20190129131908.27924-2-bsd@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-mtp.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 837c9d9449..2e342c7745 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -25,6 +25,7 @@
 #include "trace.h"
 #include "hw/usb.h"
 #include "desc.h"
+#include "qemu/units.h"
 
 /* ----------------------------------------------------------------------- */
 
@@ -152,7 +153,6 @@ struct MTPData {
     bool         first;
     /* Used for >4G file sizes */
     bool         pending;
-    uint64_t     cached_length;
     int          fd;
 };
 
@@ -244,6 +244,7 @@ typedef struct {
 
 #define MTP_MANUFACTURER  "QEMU"
 #define MTP_PRODUCT       "QEMU filesharing"
+#define MTP_WRITE_BUF_SZ  (512 * KiB)
 
 enum {
     STR_MANUFACTURER = 1,
@@ -1659,7 +1660,7 @@ static void usb_mtp_write_data(MTPState *s)
             d->fd = mkdir(path, mask);
             goto free;
         }
-        if ((s->dataset.size != 0xFFFFFFFF) && (s->dataset.size < d->length)) {
+        if ((s->dataset.size != 0xFFFFFFFF) && (s->dataset.size != d->offset)) {
             usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
                                  0, 0, 0, 0);
             goto done;
@@ -1777,17 +1778,21 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
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
 
@@ -1795,12 +1800,6 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
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
@@ -1822,7 +1821,7 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
         d->offset += dlen;
         if ((p->iov.size % 64) || !p->iov.size) {
             assert((s->dataset.size == 0xFFFFFFFF) ||
-                   (s->dataset.size == d->length));
+                   (s->dataset.size == d->offset));
 
             usb_mtp_write_data(s);
             usb_mtp_data_free(s->data_out);
-- 
2.9.3
