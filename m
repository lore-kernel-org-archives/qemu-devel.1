Received: from eggs.gnu.org ([2001:4830:134:3::10]:38293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYYrA-00046O-Dk
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:52:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYYr9-0000go-8K
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:52:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cYYr9-0000gb-1v
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:52:23 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 148D219CB90
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 13:52:23 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 31 Jan 2017 14:52:07 +0100
Message-Id: <1485870727-21956-2-git-send-email-kraxel@redhat.com>
In-Reply-To: <1485870727-21956-1-git-send-email-kraxel@redhat.com>
References: <1485870727-21956-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] usb: accept usb3 control requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Windows 10 reportedly sends these, so accept them in case
the device in question is a superspeed (usb3) device.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/desc.c    | 7 +++++++
 include/hw/usb.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/hw/usb/desc.c b/hw/usb/desc.c
index 7828e52..c36bf30 100644
--- a/hw/usb/desc.c
+++ b/hw/usb/desc.c
@@ -774,6 +774,13 @@ int usb_desc_handle_control(USBDevice *dev, USBPacket *p,
         trace_usb_set_device_feature(dev->addr, value, ret);
         break;
 
+    case DeviceOutRequest | USB_REQ_SET_SEL:
+    case DeviceOutRequest | USB_REQ_SET_ISOCH_DELAY:
+        if (dev->speed == USB_SPEED_SUPER) {
+            ret = 0;
+        }
+        break;
+
     case InterfaceRequest | USB_REQ_GET_INTERFACE:
         if (index < 0 || index >= dev->ninterfaces) {
             break;
diff --git a/include/hw/usb.h b/include/hw/usb.h
index 847c9de..6fb62b2 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -135,6 +135,8 @@
 #define USB_REQ_GET_INTERFACE		0x0A
 #define USB_REQ_SET_INTERFACE		0x0B
 #define USB_REQ_SYNCH_FRAME		0x0C
+#define USB_REQ_SET_SEL                 0x30
+#define USB_REQ_SET_ISOCH_DELAY         0x31
 
 #define USB_DEVICE_SELF_POWERED		0
 #define USB_DEVICE_REMOTE_WAKEUP	1
-- 
1.8.3.1
