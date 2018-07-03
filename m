Received: from eggs.gnu.org ([2001:4830:134:3::10]:47895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faGgF-0000a2-LA
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faGgC-0001Vk-ER
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:28:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1faGgC-0001VK-8D
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:28:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F0A730E684C
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 08:28:55 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  3 Jul 2018 10:28:51 +0200
Message-Id: <20180703082851.17959-3-kraxel@redhat.com>
In-Reply-To: <20180703082851.17959-1-kraxel@redhat.com>
References: <20180703082851.17959-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] xhci: fix guest-triggerable assert
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

Set xhci into error state instead of throwing a core dump.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180702162752.29233-1-kraxel@redhat.com
---
 hw/usb/hcd-xhci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 721beb5486..8f1a01a405 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1954,7 +1954,12 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
         for (i = 0; i < length; i++) {
             TRBType type;
             type = xhci_ring_fetch(xhci, ring, &xfer->trbs[i], NULL);
-            assert(type);
+            if (!type) {
+                xhci_die(xhci);
+                xhci_ep_free_xfer(xfer);
+                epctx->kick_active--;
+                return;
+            }
         }
         xfer->streamid = streamid;
 
-- 
2.9.3
