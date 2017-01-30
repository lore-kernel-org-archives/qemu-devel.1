Received: from eggs.gnu.org ([2001:4830:134:3::10]:40018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYE0l-0006N4-Oz
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:36:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYE0i-0005az-SD
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:36:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cYE0i-0005aO-Mz
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:36:52 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 30 Jan 2017 16:36:46 +0100
Message-Id: <1485790607-31399-4-git-send-email-kraxel@redhat.com>
In-Reply-To: <1485790607-31399-1-git-send-email-kraxel@redhat.com>
References: <1485790607-31399-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] xhci: don't kick in xhci_submit and
 xhci_fire_ctl_transfer
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

xhci_submit and xhci_fire_ctl_transfer are is called from
xhci_kick_epctx processing loop only, so there is no need to call
xhci_kick_epctx make sure processing continues.  Also eecursive calls
into xhci_kick_epctx can cause trouble.

Drop the xhci_kick_epctx calls.

Cc: 1653384@bugs.launchpad.net
Fixes: 94b037f2a451b3dc855f9f2c346e5049a361bd55
Reported-by: Fabian Lesniak <fabian@lesniak-it.de>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-xhci.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 4e2807e..899a410 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -2001,11 +2001,7 @@ static int xhci_fire_ctl_transfer(XHCIState *xhci, XHCITransfer *xfer)
     xfer->packet.parameter = trb_setup->parameter;
 
     usb_handle_packet(xfer->packet.ep->dev, &xfer->packet);
-
     xhci_try_complete_packet(xfer);
-    if (!xfer->running_async && !xfer->running_retry) {
-        xhci_kick_epctx(xfer->epctx, 0);
-    }
     return 0;
 }
 
@@ -2105,11 +2101,7 @@ static int xhci_submit(XHCIState *xhci, XHCITransfer *xfer, XHCIEPContext *epctx
         return -1;
     }
     usb_handle_packet(xfer->packet.ep->dev, &xfer->packet);
-
     xhci_try_complete_packet(xfer);
-    if (!xfer->running_async && !xfer->running_retry) {
-        xhci_kick_epctx(xfer->epctx, xfer->streamid);
-    }
     return 0;
 }
 
-- 
1.8.3.1
