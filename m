Received: from eggs.gnu.org ([2001:4830:134:3::10]:45769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dRzKh-0003Zt-56
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dRzKe-00063V-0L
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:15:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dRzKd-00062z-Qk
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:15:55 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  3 Jul 2017 13:15:49 +0200
Message-Id: <20170703111549.10924-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] ehci: add sanity check for maxframes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-ehci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 73090e01ad..604912cb3e 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -2483,6 +2483,11 @@ void usb_ehci_realize(EHCIState *s, DeviceState *dev, Error **errp)
                    NB_PORTS);
         return;
     }
+    if (s->maxframes < 8 || s->maxframes > 512)  {
+        error_setg(errp, "maxframes %d out if range (8 .. 512)",
+                   s->maxframes);
+        return;
+    }
 
     usb_bus_new(&s->bus, sizeof(s->bus), s->companion_enable ?
                 &ehci_bus_ops_companion : &ehci_bus_ops_standalone, dev);
-- 
2.9.3
