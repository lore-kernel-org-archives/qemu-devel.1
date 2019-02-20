Received: from eggs.gnu.org ([209.51.188.92]:56177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwPpJ-0008HD-PB
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwPpG-00085g-El
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gwPp6-0007Xp-Vl
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:13:58 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 20 Feb 2019 12:13:40 +0100
Message-Id: <20190220111346.13669-4-kraxel@redhat.com>
In-Reply-To: <20190220111346.13669-1-kraxel@redhat.com>
References: <20190220111346.13669-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/9] xhci: check device is not NULL before
 calling usb_ep_get()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Liam Merwick <liam.merwick@oracle.com>

From: Liam Merwick <liam.merwick@oracle.com>

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
Message-id: 1549460216-25808-4-git-send-email-liam.merwick@oracle.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-xhci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 99b83aaa9e..ec28bee319 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3276,10 +3276,10 @@ static USBEndpoint *xhci_epid_to_usbep(XHCIEPContext *epctx)
         return NULL;
     }
     uport = epctx->xhci->slots[epctx->slotid - 1].uport;
+    if (!uport || !uport->dev) {
+        return NULL;
+    }
     token = (epctx->epid & 1) ? USB_TOKEN_IN : USB_TOKEN_OUT;
-    if (!uport) {
-        return NULL;
-    }
     return usb_ep_get(uport->dev, token, epctx->epid >> 1);
 }
 
-- 
2.9.3
