Received: from eggs.gnu.org ([209.51.188.92]:58631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1grNOR-0005D9-Bv
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:37:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1grNOJ-0003oH-Mr
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:37:30 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1grNOH-0003n3-AE
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:37:26 -0500
From: Liam Merwick <liam.merwick@oracle.com>
Date: Wed,  6 Feb 2019 13:36:51 +0000
Message-Id: <1549460216-25808-5-git-send-email-liam.merwick@oracle.com>
In-Reply-To: <1549460216-25808-1-git-send-email-liam.merwick@oracle.com>
References: <1549460216-25808-1-git-send-email-liam.merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v2 4/9] ehci: check device is not NULL before
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

In ehci_process_itd(), the call to ehci_find_device() can return NULL
if it doesn't find a device matching 'devaddr' so explicitly check
the return value before passing it to usb_ep_get().

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
---
 hw/usb/hcd-ehci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 9b132cb0d392..62dab0592fa2 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -1439,9 +1439,12 @@ static int ehci_process_itd(EHCIState *ehci,
                 qemu_sglist_add(&ehci->isgl, ptr1 + off, len);
             }
 
-            pid = dir ? USB_TOKEN_IN : USB_TOKEN_OUT;
-
             dev = ehci_find_device(ehci, devaddr);
+            if (dev == NULL) {
+                ehci_trace_guest_bug(ehci, "no device found");
+                return -1;
+            }
+            pid = dir ? USB_TOKEN_IN : USB_TOKEN_OUT;
             ep = usb_ep_get(dev, pid, endp);
             if (ep && ep->type == USB_ENDPOINT_XFER_ISOC) {
                 usb_packet_setup(&ehci->ipacket, pid, ep, 0, addr, false,
-- 
1.8.3.1
