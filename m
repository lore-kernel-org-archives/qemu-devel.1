Received: from eggs.gnu.org ([2001:4830:134:3::10]:34515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gXks3-0008TV-9X
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:39:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gXks0-00056H-DJ
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:39:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gXks0-00055d-3x
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:39:00 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 14 Dec 2018 11:38:54 +0100
Message-Id: <20181214103854.13820-6-kraxel@redhat.com>
In-Reply-To: <20181214103854.13820-1-kraxel@redhat.com>
References: <20181214103854.13820-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 5/5] usb-mtp: Limit filename to object
 information size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Michael Hanselmann <public@hansmi.ch>

From: Michael Hanselmann <public@hansmi.ch>

The filename length in MTP metadata is specified by the guest. By
trusting it directly it'd theoretically be possible to get the host to
write memory parts outside the filename buffer into a filename. In
practice though there are usually NUL bytes stopping the string
operations.

Also use the opportunity to not assign the filename member twice.

Signed-off-by: Michael Hanselmann <public@hansmi.ch>
Message-id: ab70659d8d5c580bdf150a5f7d5cc60c8e374ffc.1544740018.git.public@hansmi.ch

[ kraxel: codestyle fix: break a long line ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-mtp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 36c43b8c20..6098005cd4 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1710,7 +1710,7 @@ free:
     s->write_pending = false;
 }
 
-static void usb_mtp_write_metadata(MTPState *s)
+static void usb_mtp_write_metadata(MTPState *s, uint64_t dlen)
 {
     MTPData *d = s->data_out;
     ObjectInfo *dataset = (ObjectInfo *)d->data;
@@ -1722,7 +1722,9 @@ static void usb_mtp_write_metadata(MTPState *s)
     assert(!s->write_pending);
     assert(p != NULL);
 
-    filename = utf16_to_str(dataset->length, dataset->filename);
+    filename = utf16_to_str(MIN(dataset->length,
+                                dlen - offsetof(ObjectInfo, filename)),
+                            dataset->filename);
 
     if (strchr(filename, '/')) {
         usb_mtp_queue_result(s, RES_PARAMETER_NOT_SUPPORTED, d->trans,
@@ -1738,7 +1740,6 @@ static void usb_mtp_write_metadata(MTPState *s)
     s->dataset.filename = filename;
     s->dataset.format = dataset->format;
     s->dataset.size = dataset->size;
-    s->dataset.filename = filename;
     s->write_pending = true;
 
     if (s->dataset.format == FMT_ASSOCIATION) {
@@ -1807,7 +1808,7 @@ static void usb_mtp_get_data(MTPState *s, mtp_container *container,
         if (d->offset == d->length) {
             /* The operation might have already failed */
             if (!s->result) {
-                usb_mtp_write_metadata(s);
+                usb_mtp_write_metadata(s, dlen);
             }
             usb_mtp_data_free(s->data_out);
             s->data_out = NULL;
-- 
2.9.3
