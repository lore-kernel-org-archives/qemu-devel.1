Received: from eggs.gnu.org ([2001:4830:134:3::10]:42722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fgd8g-0005DG-G4
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 17:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fgd8d-0005mp-9P
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 17:40:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50032 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1fgd8d-0005lI-47
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 17:40:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E7450DEF0E
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 21:40:33 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
Date: Fri, 20 Jul 2018 17:40:16 -0400
Message-Id: <20180720214020.22897-2-bsd@redhat.com>
In-Reply-To: <20180720214020.22897-1-bsd@redhat.com>
References: <20180720214020.22897-1-bsd@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] dev-mtp: add support for canceling
 transaction
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

The initiator can choose to cancel an ongoing request which
is specified by bRequest=0x64. If such a request arrives,
free up any pending state

Signed-off-by: Bandan Das <bsd@redhat.com>
---
 hw/usb/dev-mtp.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 1ded7ac9a3..c40b0de0bb 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -82,6 +82,7 @@ enum mtp_code {
     FMT_ASSOCIATION                = 0x3001,
 
     /* event codes */
+    EVT_CANCEL_TRANSACTION         = 0x4001,
     EVT_OBJ_ADDED                  = 0x4002,
     EVT_OBJ_REMOVED                = 0x4003,
     EVT_OBJ_INFO_CHANGED           = 0x4007,
@@ -1551,14 +1552,35 @@ static void usb_mtp_handle_control(USBDevice *dev, USBPacket *p,
                                    int length, uint8_t *data)
 {
     int ret;
+    MTPState *s = USB_MTP(dev);
+    uint16_t *event = (uint16_t *)data;
 
-    ret = usb_desc_handle_control(dev, p, request, value, index, length, data);
-    if (ret >= 0) {
-        return;
+    switch (request) {
+    case ClassInterfaceOutRequest | 0x64:
+        if (*event == EVT_CANCEL_TRANSACTION) {
+            g_free(s->result);
+            s->result = NULL;
+            usb_mtp_data_free(s->data_in);
+            s->data_in = NULL;
+            if (s->write_pending) {
+                g_free(s->dataset.filename);
+                s->write_pending = false;
+            }
+            usb_mtp_data_free(s->data_out);
+            s->data_out = NULL;
+        } else {
+            p->status = USB_RET_STALL;
+        }
+        break;
+    default:
+        ret = usb_desc_handle_control(dev, p, request,
+                                      value, index, length, data);
+        if (ret >= 0) {
+            return;
+        }
     }
 
     trace_usb_mtp_stall(dev->addr, "unknown control request");
-    p->status = USB_RET_STALL;
 }
 
 static void usb_mtp_cancel_packet(USBDevice *dev, USBPacket *p)
-- 
2.14.4
