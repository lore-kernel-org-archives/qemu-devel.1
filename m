Received: from eggs.gnu.org ([2001:4830:134:3::10]:41583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <public@hansmi.ch>) id 1gXZbu-0004mm-BU
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 17:37:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <public@hansmi.ch>) id 1gXZbp-0002EE-95
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 17:37:38 -0500
Received: from mail-gateway-shared14.cyon.net ([194.126.200.67]:42576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <public@hansmi.ch>) id 1gXZbo-00025h-Tm
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 17:37:33 -0500
Received: from s013.cyon.net ([149.126.4.22])
	by mail-gateway-shared14.cyon.net with esmtpsa
	(TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim)
	(envelope-from <public@hansmi.ch>) id 1gXZbc-0007Is-0G
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 23:37:30 +0100
From: Michael Hanselmann <public@hansmi.ch>
Date: Thu, 13 Dec 2018 22:37:06 +0000
Message-Id: <ab70659d8d5c580bdf150a5f7d5cc60c8e374ffc.1544740018.git.public@hansmi.ch>
Subject: [Qemu-devel] [PATCH] usb-mtp: Limit filename to object information
 size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, Michael Hanselmann <public@hansmi.ch>

The filename length in MTP metadata is specified by the guest. By
trusting it directly it'd theoretically be possible to get the host to
write memory parts outside the filename buffer into a filename. In
practice though there are usually NUL bytes stopping the string
operations.

Also use the opportunity to not assign the filename member twice.

Signed-off-by: Michael Hanselmann <public@hansmi.ch>
---
 hw/usb/dev-mtp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 100b7171f4..360ca65ee4 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1705,7 +1705,7 @@ free:
     s->write_pending = false;
 }
 
-static void usb_mtp_write_metadata(MTPState *s)
+static void usb_mtp_write_metadata(MTPState *s, uint64_t dlen)
 {
     MTPData *d = s->data_out;
     ObjectInfo *dataset = (ObjectInfo *)d->data;
@@ -1717,7 +1717,8 @@ static void usb_mtp_write_metadata(MTPState *s)
     assert(!s->write_pending);
     assert(p != NULL);
 
-    filename = utf16_to_str(dataset->length, dataset->filename);
+    filename = utf16_to_str(MIN(dataset->length, dlen - offsetof(ObjectInfo, filename)),
+                            dataset->filename);
 
     if (strchr(filename, '/')) {
         usb_mtp_queue_result(s, RES_PARAMETER_NOT_SUPPORTED, d->trans,
@@ -1733,7 +1734,6 @@ static void usb_mtp_write_metadata(MTPState *s)
     s->dataset.filename = filename;
     s->dataset.format = dataset->format;
     s->dataset.size = dataset->size;
-    s->dataset.filename = filename;
     s->write_pending = true;
 
     if (s->dataset.format == FMT_ASSOCIATION) {
@@ -1802,7 +1802,7 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
         if (d->offset == d->length) {
             /* The operation might have already failed */
             if (!s->result) {
-                usb_mtp_write_metadata(s);
+                usb_mtp_write_metadata(s, dlen);
             }
             usb_mtp_data_free(s->data_out);
             s->data_out = NULL;
-- 
2.11.0
