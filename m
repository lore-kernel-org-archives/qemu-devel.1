Received: from eggs.gnu.org ([2001:4830:134:3::10]:49157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cuzDa-0004sI-I7
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 06:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cuzDZ-00049x-NV
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 06:28:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cuzDZ-00048z-II
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 06:28:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 988F24E4EE
	for <qemu-devel@nongnu.org>; Mon,  3 Apr 2017 10:28:12 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  3 Apr 2017 12:28:01 +0200
Message-Id: <20170403102803.31820-2-kraxel@redhat.com>
In-Reply-To: <20170403102803.31820-1-kraxel@redhat.com>
References: <20170403102803.31820-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] xhci: flush dequeue pointer to endpoint
 context
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

When done processing a endpoint ring we must update the dequeue pointer
in the endpoint context in guest memory.  This is needed to make sure
the guest has a correct view of things and also to make live migration
work properly, because xhci post_load restores alot of the state from
xhci data structures in guest memory.

Add xhci_set_ep_state() call to do that.

The recursive calls stopped by commit
ddb603ab6c981c1d67cb42266fc700c33e5b2d8f had the (unintentional) side
effect to hiding this bug.  xhci_set_ep_state() was called before
processing, to set the state to running, which updated the dequeue
pointer too.

Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-id: 20170331102521.29253-1-kraxel@redhat.com
---
 hw/usb/hcd-xhci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index f0af852..a2d3143 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -2063,7 +2063,7 @@ static void xhci_kick_ep(XHCIState *xhci, unsigned int slotid,
 static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
 {
     XHCIState *xhci = epctx->xhci;
-    XHCIStreamContext *stctx;
+    XHCIStreamContext *stctx = NULL;
     XHCITransfer *xfer;
     XHCIRing *ring;
     USBEndpoint *ep = NULL;
@@ -2186,6 +2186,8 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
             break;
         }
     }
+    /* update ring dequeue ptr */
+    xhci_set_ep_state(xhci, epctx, stctx, epctx->state);
     epctx->kick_active--;
 
     ep = xhci_epid_to_usbep(epctx);
-- 
2.9.3
