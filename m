Received: from eggs.gnu.org ([209.51.188.92]:58611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1grNOJ-00057I-FW
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:37:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1grNOD-0003nJ-QV
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:37:25 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1grNOB-0003mb-Px
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:37:20 -0500
From: Liam Merwick <liam.merwick@oracle.com>
Date: Wed,  6 Feb 2019 13:36:49 +0000
Message-Id: <1549460216-25808-3-git-send-email-liam.merwick@oracle.com>
In-Reply-To: <1549460216-25808-1-git-send-email-liam.merwick@oracle.com>
References: <1549460216-25808-1-git-send-email-liam.merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v2 2/9] xhci: add asserts to help with static
 code analysis
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

Most callers of xhci_port_update() and xhci_wakeup() pass in a pointer
to an array entry and can never be NULL but add two defensive asserts
to protect against future changes (e.g. adding a new port speed, etc.)
adding a path through xhci_lookup_port() that could result in the
return of a NULL XHCIPort.

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
---
 hw/usb/hcd-xhci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 19c64f7ff421..99b83aaa9ed5 100644
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
1.8.3.1
