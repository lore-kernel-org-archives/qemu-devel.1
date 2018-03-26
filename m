Received: from eggs.gnu.org ([2001:4830:134:3::10]:57134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SIy-0006WC-FQ
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f0SIx-0006wJ-Eb
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:36:56 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:37959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f0SIx-0006vx-8A
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:36:55 -0400
Received: by mail-wr0-x230.google.com with SMTP id m13so5631663wrj.5
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 06:36:55 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Mar 2018 15:36:33 +0200
Message-Id: <1522071403-52486-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
References: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 06/16] fdc: Exit if ISA controller does not
 support DMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

A "powernv" machine type defines an ISA bus but it does not add any DMA
controller to it so it is possible to hit assert(fdctrl->dma) by
adding "-machine powernv -device isa-fdc".

This replaces assert() with an error message.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
[thuth: Slightly adjusted error message and updated scripts/device-crash-test]
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1521193892-15552-3-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/block/fdc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 7b7dd41..cd29e27 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2695,7 +2695,10 @@ static void isabus_fdc_realize(DeviceState *dev, Error **errp)
     fdctrl->dma_chann = isa->dma;
     if (fdctrl->dma_chann != -1) {
         fdctrl->dma = isa_get_dma(isa_bus_from_device(isadev), isa->dma);
-        assert(fdctrl->dma);
+        if (!fdctrl->dma) {
+            error_setg(errp, "ISA controller does not support DMA");
+            return;
+        }
     }
 
     qdev_set_legacy_instance_id(dev, isa->iobase, 2);
-- 
1.8.3.1
