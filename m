Received: from eggs.gnu.org ([209.51.188.92]:58686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1grNOi-0005SO-Id
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:37:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1grNOd-0003rL-8f
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:37:49 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1grNOZ-0003nP-FV
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:37:44 -0500
From: Liam Merwick <liam.merwick@oracle.com>
Date: Wed,  6 Feb 2019 13:36:53 +0000
Message-Id: <1549460216-25808-7-git-send-email-liam.merwick@oracle.com>
In-Reply-To: <1549460216-25808-1-git-send-email-liam.merwick@oracle.com>
References: <1549460216-25808-1-git-send-email-liam.merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v2 6/9] uhci: check device is not NULL before
 calling usb_ep_get()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, qemu-devel@nongnu.org
Cc: liam.merwick@oracle.com, darren.kenny@oracle.com

In uhci_handle_td(), the call to ehci_find_device() can return NULL
if it doesn't find a device matching 'addr' so explicitly check
the return value before passing it to usb_ep_get().

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
---
 hw/usb/hcd-uhci.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index e694b62086d3..09df29ff9c16 100644
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
1.8.3.1
