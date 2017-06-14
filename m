Received: from eggs.gnu.org ([2001:4830:134:3::10]:58948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1dKz9W-0007mO-9C
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 23:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1dKz9T-0002xE-7W
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 23:39:30 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:34419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1dKz9T-0002u6-0V
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 23:39:27 -0400
Received: by mail-pf0-x243.google.com with SMTP id d5so12419725pfe.1
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 20:39:25 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 13 Jun 2017 20:39:04 -0700
Message-Id: <1497411544-80213-1-git-send-email-liqiang6-s@360.cn>
Subject: [Qemu-devel] [PATCH] usb: xhci: fix info leak when writing event to
 the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kraxel@redhat.com
Cc: liqiang6-s@360.cn, ppandit@redhat.com, Li Qiang <liq3ea@gmail.com>

From: Li Qiang <liq3ea@gmail.com>

In 'xhci_write_event' function, the 'ev_trb' is not full initialized.
This will lead an info leak issue. This patch avoid this.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/usb/hcd-xhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index a0c7960..537997e 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -646,6 +646,7 @@ static void xhci_write_event(XHCIState *xhci, XHCIEvent *event, int v)
     XHCITRB ev_trb;
     dma_addr_t addr;
 
+    memset(&ev_trb, 0, sizeof(ev_trb));
     ev_trb.parameter = cpu_to_le64(event->ptr);
     ev_trb.status = cpu_to_le32(event->length | (event->ccode << 24));
     ev_trb.control = (event->slotid << 24) | (event->epid << 16) |
-- 
2.7.4
