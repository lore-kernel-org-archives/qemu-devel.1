Received: from eggs.gnu.org ([209.51.188.92]:56284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwPpO-0008L9-8r
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwPpN-0008OV-EQ
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gwPpM-0007bQ-6R
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:13 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 20 Feb 2019 12:13:43 +0100
Message-Id: <20190220111346.13669-7-kraxel@redhat.com>
In-Reply-To: <20190220111346.13669-1-kraxel@redhat.com>
References: <20190220111346.13669-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 6/9] uhci: check device is not NULL before
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

In uhci_handle_td(), the call to ehci_find_device() can return NULL
if it doesn't find a device matching 'addr' so explicitly check
the return value before passing it to usb_ep_get().

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
Message-id: 1549460216-25808-7-git-send-email-liam.merwick@oracle.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-uhci.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index e694b62086..09df29ff9c 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -858,13 +858,15 @@ static int uhci_handle_td(UHCIState *s, UHCIQueue *q, uint32_t qh_addr,
 
     /* Allocate new packet */
     if (q == NULL) {
-        USBDevice *dev = uhci_find_device(s, (td->token >> 8) & 0x7f);
-        USBEndpoint *ep = usb_ep_get(dev, pid, (td->token >> 15) & 0xf);
+        USBDevice *dev;
+        USBEndpoint *ep;
 
-        if (ep == NULL) {
+        dev = uhci_find_device(s, (td->token >> 8) & 0x7f);
+        if (dev == NULL) {
             return uhci_handle_td_error(s, td, td_addr, USB_RET_NODEV,
                                         int_mask);
         }
+        ep = usb_ep_get(dev, pid, (td->token >> 15) & 0xf);
         q = uhci_queue_new(s, qh_addr, td, ep);
     }
     async = uhci_async_alloc(q, td_addr);
-- 
2.9.3
