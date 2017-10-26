Received: from eggs.gnu.org ([2001:4830:134:3::10]:34931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7bwg-0006IP-M0
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 02:47:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7bwc-0004kC-DB
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 02:47:14 -0400
Received: from ozlabs.ru ([107.173.13.209]:55926)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7bwc-0004jc-78
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 02:47:10 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 26 Oct 2017 17:46:35 +1100
Message-Id: <20171026064635.7179-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] fdc: Exit if ISA controller does not
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>

A "powernv" machine type defines an ISA bus but it does not add any DMA
controller to it so it is possible to hit assert(fdctrl->dma) by
adding "-machine powernv -device isa-fdc".

This replaces assert() with an error message.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

Is it a must for ISA to have DMA controllers?


---
 hw/block/fdc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 67f78ac702..ed8b367572 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2700,7 +2700,10 @@ static void isabus_fdc_realize(DeviceState *dev, Error **errp)
     fdctrl->dma_chann = isa->dma;
     if (fdctrl->dma_chann != -1) {
         fdctrl->dma = isa_get_dma(isa_bus_from_device(isadev), isa->dma);
-        assert(fdctrl->dma);
+        if (!fdctrl->dma) {
+            error_setg(errp, "ISA controller does not support DMA, exiting");
+            return;
+        }
     }
 
     qdev_set_legacy_instance_id(dev, isa->iobase, 2);
-- 
2.11.0
