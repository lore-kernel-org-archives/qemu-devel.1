Received: from eggs.gnu.org ([2001:4830:134:3::10]:43106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cahTN-0002LB-BK
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cahTJ-0002vz-BU
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:28:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cahTJ-0002vB-5a
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:28:37 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  6 Feb 2017 12:28:16 +0100
Message-Id: <1486380501-13431-5-git-send-email-kraxel@redhat.com>
In-Reply-To: <1486380501-13431-1-git-send-email-kraxel@redhat.com>
References: <1486380501-13431-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 4/9] xhci: only free completed transfers
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
Message-id: 1485790607-31399-2-git-send-email-kraxel@redhat.com
---
 hw/usb/hcd-xhci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index f810678..6a1d3dc 100644
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
