Received: from eggs.gnu.org ([208.118.235.92]:59691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gTkF3-0007IS-6E
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 04:10:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gTk4v-0002IO-L3
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:59:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gTk4v-0002Gc-Em
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:59:45 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  3 Dec 2018 09:59:37 +0100
Message-Id: <20181203085938.10247-2-kraxel@redhat.com>
In-Reply-To: <20181203085938.10247-1-kraxel@redhat.com>
References: <20181203085938.10247-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1 v2 1/2] usb-mtp: fix utf16_to_str
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: public@hansmi.ch, Gerd Hoffmann <kraxel@redhat.com>

Make utf16_to_str return an allocated string.  Remove the assumtion that
the number of string bytes equals the number of utf16 chars (which is
only true for ascii chars).  Instead call wcstombs twice, once to figure
the storage size and once for the actual conversion (as suggested by the
wcstombs manpage).

Reported-by: Michael Hanselmann <public@hansmi.ch>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-mtp.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 00a3691bae..0f6a9702ef 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1593,17 +1593,23 @@ static void usb_mtp_cancel_packet(USBDevice *dev, USBPacket *p)
     fprintf(stderr, "%s\n", __func__);
 }
 
-static void utf16_to_str(uint8_t len, uint16_t *arr, char *name)
+static char *utf16_to_str(uint8_t len, uint16_t *arr)
 {
-    int count;
-    wchar_t *wstr = g_new0(wchar_t, len);
+    wchar_t *wstr = g_new0(wchar_t, len + 1);
+    int count, dlen;
+    char *dest;
 
     for (count = 0; count < len; count++) {
+        /* FIXME: not working for surrogate pairs */
         wstr[count] = (wchar_t)arr[count];
     }
+    wstr[count] = 0;
 
-    wcstombs(name, wstr, len);
+    dlen = wcstombs(NULL, wstr, 0) + 1;
+    dest = g_malloc(dlen);
+    wcstombs(dest, wstr, dlen);
     g_free(wstr);
+    return dest;
 }
 
 /* Wrapper around write, returns 0 on failure */
@@ -1703,7 +1709,7 @@ static void usb_mtp_write_metadata(MTPState *s)
 {
     MTPData *d = s->data_out;
     ObjectInfo *dataset = (ObjectInfo *)d->data;
-    char *filename = g_new0(char, dataset->length);
+    char *filename;
     MTPObject *o;
     MTPObject *p = usb_mtp_object_lookup(s, s->dataset.parent_handle);
     uint32_t next_handle = s->next_handle;
@@ -1711,7 +1717,7 @@ static void usb_mtp_write_metadata(MTPState *s)
     assert(!s->write_pending);
     assert(p != NULL);
 
-    utf16_to_str(dataset->length, dataset->filename, filename);
+    filename = utf16_to_str(dataset->length, dataset->filename);
 
     o = usb_mtp_object_lookup_name(p, filename, dataset->length);
     if (o != NULL) {
-- 
2.9.3
