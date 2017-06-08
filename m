Received: from eggs.gnu.org ([2001:4830:134:3::10]:38093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dIs4Z-0003yN-J6
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dIs4V-0003j6-N8
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:41:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dIs4V-0003ig-H1
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:41:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 84F408124D
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 07:41:34 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  8 Jun 2017 09:41:22 +0200
Message-Id: <20170608074122.32099-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] xhci: only update dequeue ptr on completed
 transfers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lvivier@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

The dequeue pointer should only be updated in case the transfer
is actually completed.  If we update it for inflight transfers
we will not pick them up again after migration, which easily
triggers with HID devices as they typically have a pending
transfer, waiting for user input to happen.

Fixes: 243afe858b95765b98d16a1f0dd50dca262858ad
Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1451631
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-xhci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index a0c7960a7b..760135c0d2 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1912,6 +1912,8 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
         }
         assert(!xfer->running_retry);
         if (xfer->complete) {
+            /* update ring dequeue ptr */
+            xhci_set_ep_state(xhci, epctx, stctx, epctx->state);
             xhci_ep_free_xfer(epctx->retry);
         }
         epctx->retry = NULL;
@@ -1962,6 +1964,8 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
             xhci_fire_transfer(xhci, xfer, epctx);
         }
         if (xfer->complete) {
+            /* update ring dequeue ptr */
+            xhci_set_ep_state(xhci, epctx, stctx, epctx->state);
             xhci_ep_free_xfer(xfer);
             xfer = NULL;
         }
@@ -1979,8 +1983,6 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
             break;
         }
     }
-    /* update ring dequeue ptr */
-    xhci_set_ep_state(xhci, epctx, stctx, epctx->state);
     epctx->kick_active--;
 
     ep = xhci_epid_to_usbep(epctx);
-- 
2.9.3
