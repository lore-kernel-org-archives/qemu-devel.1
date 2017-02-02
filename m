Received: from eggs.gnu.org ([2001:4830:134:3::10]:56154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZFgi-000243-TC
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 06:36:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZFgf-0002iZ-Na
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 06:36:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cZFgf-0002gq-HD
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 06:36:25 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  2 Feb 2017 12:36:12 +0100
Message-Id: <1486035372-3621-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2] xhci: guard xhci_kick_epctx against
 recursive calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 1653384@bugs.launchpad.net

Track xhci_kick_epctx processing being active in a variable.  Check the
variable before calling xhci_kick_epctx from xhci_kick_ep.  Add an
assert to make sure we don't call recursively into xhci_kick_epctx.

Cc: 1653384@bugs.launchpad.net
Fixes: 94b037f2a451b3dc855f9f2c346e5049a361bd55
Reported-by: Fabian Lesniak <fabian@lesniak-it.de>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 1485790607-31399-5-git-send-email-kraxel@redhat.com
---
 hw/usb/hcd-xhci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 899a410..df75907 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -390,6 +390,7 @@ struct XHCIEPContext {
     dma_addr_t pctx;
     unsigned int max_psize;
     uint32_t state;
+    uint32_t kick_active;
 
     /* streams */
     unsigned int max_pstreams;
@@ -2131,6 +2132,9 @@ static void xhci_kick_ep(XHCIState *xhci, unsigned int slotid,
         return;
     }
 
+    if (epctx->kick_active) {
+        return;
+    }
     xhci_kick_epctx(epctx, streamid);
 }
 
@@ -2146,6 +2150,7 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
     int i;
 
     trace_usb_xhci_ep_kick(epctx->slotid, epctx->epid, streamid);
+    assert(!epctx->kick_active);
 
     /* If the device has been detached, but the guest has not noticed this
        yet the 2 above checks will succeed, but we must NOT continue */
@@ -2217,6 +2222,7 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
     }
     assert(ring->dequeue != 0);
 
+    epctx->kick_active++;
     while (1) {
         length = xhci_ring_chain_length(xhci, ring);
         if (length <= 0) {
@@ -2253,6 +2259,7 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
             break;
         }
     }
+    epctx->kick_active--;
 
     ep = xhci_epid_to_usbep(epctx);
     if (ep) {
-- 
1.8.3.1
