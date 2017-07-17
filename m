Received: from eggs.gnu.org ([2001:4830:134:3::10]:51098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX2Vn-0000i0-Dl
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:40:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX2Vl-0001ir-7v
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:40:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dX2Vl-0001id-14
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:40:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F33F815561
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 09:40:15 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 17 Jul 2017 11:40:11 +0200
Message-Id: <20170717094011.15905-2-kraxel@redhat.com>
In-Reply-To: <20170717094011.15905-1-kraxel@redhat.com>
References: <20170717094011.15905-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] ehci: add sanity check for maxframes
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

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20170703111549.10924-1-kraxel@redhat.com
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
