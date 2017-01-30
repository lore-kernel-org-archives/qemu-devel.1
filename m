Received: from eggs.gnu.org ([2001:4830:134:3::10]:40017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYE0l-0006N3-Ow
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:36:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYE0i-0005b9-UW
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:36:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cYE0i-0005aK-Nx
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:36:52 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 30 Jan 2017 16:36:47 +0100
Message-Id: <1485790607-31399-5-git-send-email-kraxel@redhat.com>
In-Reply-To: <1485790607-31399-1-git-send-email-kraxel@redhat.com>
References: <1485790607-31399-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] xhci: guard xhci_kick_epctx against
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
Cc: 1653384@bugs.launchpad.net, fabian@lesniak-it.de, Gerd Hoffmann <kraxel@redhat.com>

Track xhci_kick_epctx processing being active in a variable.  Check the
variable before calling xhci_kick_epctx from xhci_kick_ep.  Add an
assert to make sure we don't call recursively into xhci_kick_epctx.

Cc: 1653384@bugs.launchpad.net
Fixes: 94b037f2a451b3dc855f9f2c346e5049a361bd55
Reported-by: Fabian Lesniak <fabian@lesniak-it.de>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-xhci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 899a410..12cac89 100644
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
 
+    if (!epctx->kick_active) {
+        return;
+    }
     xhci_kick_epctx(epctx, streamid);
 }
 
@@ -2155,6 +2159,9 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
         return;
     }
 
+    assert(!epctx->kick_active);
+    epctx->kick_active++;
+
     if (epctx->retry) {
         XHCITransfer *xfer = epctx->retry;
 
@@ -2253,6 +2260,7 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
             break;
         }
     }
+    epctx->kick_active--;
 
     ep = xhci_epid_to_usbep(epctx);
     if (ep) {
-- 
1.8.3.1
