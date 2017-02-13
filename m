Received: from eggs.gnu.org ([2001:4830:134:3::10]:50414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cdBUc-00087g-C2
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 02:56:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cdBUZ-0000K3-85
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 02:56:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cdBUZ-0000Jm-2Q
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 02:56:11 -0500
From: P J P <ppandit@redhat.com>
Date: Mon, 13 Feb 2017 13:25:58 +0530
Message-Id: <20170213075558.786-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH] usb: xhci: break loop after ctrl transfer
 complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Li Qiang <liqiang6-s@360.cn>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

xHCI controller emulator loops through the transfer ring to
transfer control/data between host memory and device endpoints.
It continues to do so after processing 'Status Stage' TD which
is the last descriptor in control transfer. Add break to avoid
infinite loop.

Reported-by: Li Qiang <liqiang6-s@360.cn>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/usb/hcd-xhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 54b3901..7e2d345 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -2252,6 +2252,7 @@ static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid)
         if (xfer->complete) {
             xhci_ep_free_xfer(xfer);
             xfer = NULL;
+            break;
         }
 
         if (epctx->state == EP_HALTED) {
-- 
2.9.3
