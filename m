Received: from eggs.gnu.org ([209.51.188.92]:56330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwPpP-0008Mc-EL
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwPpO-0008Qu-Bv
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gwPpO-0007Yq-2A
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:14 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 20 Feb 2019 12:13:41 +0100
Message-Id: <20190220111346.13669-5-kraxel@redhat.com>
In-Reply-To: <20190220111346.13669-1-kraxel@redhat.com>
References: <20190220111346.13669-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 4/9] ehci: check device is not NULL before
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

In ehci_process_itd(), the call to ehci_find_device() can return NULL
if it doesn't find a device matching 'devaddr' so explicitly check
the return value before passing it to usb_ep_get().

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
Message-id: 1549460216-25808-5-git-send-email-liam.merwick@oracle.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-ehci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 9b132cb0d3..62dab0592f 100644
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
2.9.3
