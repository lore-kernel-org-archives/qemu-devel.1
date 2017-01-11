Received: from eggs.gnu.org ([2001:4830:134:3::10]:48866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cROvV-0002Pj-4p
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:51:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cROvS-0001am-32
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:51:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cROvR-0001aB-Sx
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:51:13 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 11 Jan 2017 20:51:09 +0100
Message-Id: <1484164269-27941-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] xhci: only free completed transfers
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

Most callsites check already, one was missed.

Cc: 1653384@bugs.launchpad.net
Fixes: 94b037f2a451b3dc855f9f2c346e5049a361bd55
Reported-by: Fabian Lesniak <fabian@lesniak-it.de>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-xhci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 4acf0c6..e961564 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -2198,7 +2198,9 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
             xhci_complete_packet(xfer);
         }
         assert(!xfer->running_retry);
-        xhci_ep_free_xfer(epctx->retry);
+        if (xfer->complete) {
+            xhci_ep_free_xfer(epctx->retry);
+        }
         epctx->retry = NULL;
     }
 
-- 
1.8.3.1
