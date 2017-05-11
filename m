Received: from eggs.gnu.org ([2001:4830:134:3::10]:60010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1d8naw-0002rD-7x
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:53:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1d8nat-000096-HU
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:53:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1d8nat-00008Z-B4
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:53:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31216C059742
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 12:53:22 +0000 (UTC)
From: Ladi Prosek <lprosek@redhat.com>
Date: Thu, 11 May 2017 14:53:13 +0200
Message-Id: <20170511125314.24549-2-lprosek@redhat.com>
In-Reply-To: <20170511125314.24549-1-lprosek@redhat.com>
References: <20170511125314.24549-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] xhci: fix logging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

slotid and epid were deleted from XHCITransfer in commit d6fcb29.
Also deleting one unused forward declaration.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---
 hw/usb/hcd-xhci.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index a2d3143..d3d47bf 100644
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
