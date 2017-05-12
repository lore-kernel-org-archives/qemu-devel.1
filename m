Received: from eggs.gnu.org ([2001:4830:134:3::10]:41292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d99aE-0000Mb-Te
	for qemu-devel@nongnu.org; Fri, 12 May 2017 08:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d99aE-00058t-4V
	for qemu-devel@nongnu.org; Fri, 12 May 2017 08:22:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d99aD-00058Z-US
	for qemu-devel@nongnu.org; Fri, 12 May 2017 08:22:10 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F218F68115
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 12:22:08 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 May 2017 14:21:55 +0200
Message-Id: <20170512122158.32032-4-kraxel@redhat.com>
In-Reply-To: <20170512122158.32032-1-kraxel@redhat.com>
References: <20170512122158.32032-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/6] xhci: fix logging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ladi Prosek <lprosek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Ladi Prosek <lprosek@redhat.com>

slotid and epid were deleted from XHCITransfer in commit d6fcb29.
Also deleting one unused forward declaration.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Message-id: 20170511125314.24549-2-lprosek@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-xhci.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index a2d3143bf4..d3d47bf925 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1790,9 +1790,6 @@ static void xhci_stall_ep(XHCITransfer *xfer)
     }
 }
 
-static int xhci_submit(XHCIState *xhci, XHCITransfer *xfer,
-                       XHCIEPContext *epctx);
-
 static int xhci_setup_packet(XHCITransfer *xfer)
 {
     USBEndpoint *ep;
@@ -1806,7 +1803,7 @@ static int xhci_setup_packet(XHCITransfer *xfer)
         ep = xhci_epid_to_usbep(xfer->epctx);
         if (!ep) {
             DPRINTF("xhci: slot %d has no device\n",
-                    xfer->slotid);
+                    xfer->epctx->slotid);
             return -1;
         }
     }
@@ -1980,7 +1977,7 @@ static int xhci_submit(XHCIState *xhci, XHCITransfer *xfer, XHCIEPContext *epctx
 {
     uint64_t mfindex;
 
-    DPRINTF("xhci_submit(slotid=%d,epid=%d)\n", xfer->slotid, xfer->epid);
+    DPRINTF("xhci_submit(slotid=%d,epid=%d)\n", epctx->slotid, epctx->epid);
 
     xfer->in_xfer = epctx->type>>2;
 
-- 
2.9.3
