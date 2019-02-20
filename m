Received: from eggs.gnu.org ([209.51.188.92]:56255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwPpN-0008KD-CX
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwPpM-0008Kr-6A
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gwPpK-0007Rh-PF
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:12 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 20 Feb 2019 12:13:39 +0100
Message-Id: <20190220111346.13669-3-kraxel@redhat.com>
In-Reply-To: <20190220111346.13669-1-kraxel@redhat.com>
References: <20190220111346.13669-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/9] xhci: add asserts to help with static code
 analysis
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

Most callers of xhci_port_update() and xhci_wakeup() pass in a pointer
to an array entry and can never be NULL but add two defensive asserts
to protect against future changes (e.g. adding a new port speed, etc.)
adding a path through xhci_lookup_port() that could result in the
return of a NULL XHCIPort.

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
Message-id: 1549460216-25808-3-git-send-email-liam.merwick@oracle.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-xhci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 19c64f7ff4..99b83aaa9e 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -2607,6 +2607,7 @@ static void xhci_port_update(XHCIPort *port, int is_detach)
 {
     uint32_t pls = PLS_RX_DETECT;
 
+    assert(port);
     port->portsc = PORTSC_PP;
     if (!is_detach && xhci_port_have_device(port)) {
         port->portsc |= PORTSC_CCS;
@@ -3215,6 +3216,7 @@ static void xhci_wakeup(USBPort *usbport)
     XHCIState *xhci = usbport->opaque;
     XHCIPort *port = xhci_lookup_port(xhci, usbport);
 
+    assert(port);
     if (get_field(port->portsc, PORTSC_PLS) != PLS_U3) {
         return;
     }
-- 
2.9.3
