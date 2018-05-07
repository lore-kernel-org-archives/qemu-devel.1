Received: from eggs.gnu.org ([2001:4830:134:3::10]:42769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFchZ-0002jG-Qd
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:45:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFchY-00059R-A9
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:45:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51484 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fFchY-00057Z-5U
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:45:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B423A818F6E6
	for <qemu-devel@nongnu.org>; Mon,  7 May 2018 09:44:53 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  7 May 2018 11:44:46 +0200
Message-Id: <20180507094448.32386-2-kraxel@redhat.com>
In-Reply-To: <20180507094448.32386-1-kraxel@redhat.com>
References: <20180507094448.32386-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] usb-mtp: Add some NULL checks for issues
 pointed out by coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Bandan Das <bsd@redhat.com>

From: Bandan Das <bsd@redhat.com>

CID 1390578: In usb_mtp_write_metadata, parent can never be NULL but
just in case, add an assert
CID 1390592: Check for o->format only if o !=NULL
CID 1390604: Check s->data_out != NULL in usb_mtp_handle_data

Signed-off-by: Bandan Das <bsd@redhat.com>
Message-id: 20180503192028.14353-2-bsd@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-mtp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 6ecf70a79b..24cff640c0 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1446,8 +1446,7 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
             if (o == NULL) {
                 usb_mtp_queue_result(s, RES_INVALID_OBJECT_HANDLE, c->trans,
                                      0, 0, 0, 0);
-            }
-            if (o->format != FMT_ASSOCIATION) {
+            } else if (o->format != FMT_ASSOCIATION) {
                 usb_mtp_queue_result(s, RES_INVALID_PARENT_OBJECT, c->trans,
                                      0, 0, 0, 0);
             }
@@ -1660,6 +1659,7 @@ static void usb_mtp_write_metadata(MTPState *s)
     uint32_t next_handle = s->next_handle;
 
     assert(!s->write_pending);
+    assert(p != NULL);
 
     utf16_to_str(dataset->length, dataset->filename, filename);
 
@@ -1838,7 +1838,7 @@ static void usb_mtp_handle_data(USBDevice *dev, USBPacket *p)
             p->status = USB_RET_STALL;
             return;
         }
-        if (s->data_out && !s->data_out->first) {
+        if ((s->data_out != NULL) && !s->data_out->first) {
             container_type = TYPE_DATA;
         } else {
             usb_packet_copy(p, &container, sizeof(container));
-- 
2.9.3
