Received: from eggs.gnu.org ([2001:4830:134:3::10]:43114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cahTN-0002LG-Cc
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cahTJ-0002wU-OA
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:28:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cahTJ-0002vb-JD
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:28:37 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C47B26572D
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 11:28:37 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  6 Feb 2017 12:28:17 +0100
Message-Id: <1486380501-13431-6-git-send-email-kraxel@redhat.com>
In-Reply-To: <1486380501-13431-1-git-send-email-kraxel@redhat.com>
References: <1486380501-13431-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 5/9] xhci: rename xhci_complete_packet to
 xhci_try_complete_packet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Make clear that this isn't guaranteed to actually complete the transfer,
the usb packet can still be in flight after calling that function.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 1485790607-31399-3-git-send-email-kraxel@redhat.com
---
 hw/usb/hcd-xhci.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 6a1d3dc..7e863d3 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1897,7 +1897,7 @@ static int xhci_setup_packet(XHCITransfer *xfer)
     return 0;
 }
 
-static int xhci_complete_packet(XHCITransfer *xfer)
+static int xhci_try_complete_packet(XHCITransfer *xfer)
 {
     if (xfer->packet.status == USB_RET_ASYNC) {
         trace_usb_xhci_xfer_async(xfer);
@@ -2002,7 +2002,7 @@ static int xhci_fire_ctl_transfer(XHCIState *xhci, XHCITransfer *xfer)
 
     usb_handle_packet(xfer->packet.ep->dev, &xfer->packet);
 
-    xhci_complete_packet(xfer);
+    xhci_try_complete_packet(xfer);
     if (!xfer->running_async && !xfer->running_retry) {
         xhci_kick_epctx(xfer->epctx, 0);
     }
@@ -2106,7 +2106,7 @@ static int xhci_submit(XHCIState *xhci, XHCITransfer *xfer, XHCIEPContext *epctx
     }
     usb_handle_packet(xfer->packet.ep->dev, &xfer->packet);
 
-    xhci_complete_packet(xfer);
+    xhci_try_complete_packet(xfer);
     if (!xfer->running_async && !xfer->running_retry) {
         xhci_kick_epctx(xfer->epctx, xfer->streamid);
     }
@@ -2185,7 +2185,7 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
             }
             usb_handle_packet(xfer->packet.ep->dev, &xfer->packet);
             assert(xfer->packet.status != USB_RET_NAK);
-            xhci_complete_packet(xfer);
+            xhci_try_complete_packet(xfer);
         } else {
             /* retry nak'ed transfer */
             if (xhci_setup_packet(xfer) < 0) {
@@ -2195,7 +2195,7 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
             if (xfer->packet.status == USB_RET_NAK) {
                 return;
             }
-            xhci_complete_packet(xfer);
+            xhci_try_complete_packet(xfer);
         }
         assert(!xfer->running_retry);
         if (xfer->complete) {
@@ -3492,7 +3492,7 @@ static void xhci_complete(USBPort *port, USBPacket *packet)
         xhci_ep_nuke_one_xfer(xfer, 0);
         return;
     }
-    xhci_complete_packet(xfer);
+    xhci_try_complete_packet(xfer);
     xhci_kick_epctx(xfer->epctx, xfer->streamid);
     if (xfer->complete) {
         xhci_ep_free_xfer(xfer);
-- 
1.8.3.1
