Received: from eggs.gnu.org ([2001:4830:134:3::10]:37532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRO7-0008Q9-CO
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRO1-0002wX-G5
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:51 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ebRO1-0002vq-95
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:45 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRO0-0002zs-8u
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:34:44 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 13:34:19 +0000
Message-Id: <1516109659-1557-25-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
References: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 24/24] sdhci: add a 'dma' property to the sysbus
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Add a 'dma' property allowing machine creation to provide the address-space
SDHCI DMA operates on.

[based on a patch from Alistair Francis <alistair.francis@xilinx.com>
 from qemu/xilinx tag xilinx-v2016.1]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180115182436.2066-15-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/sd/sdhci.h |  1 +
 hw/sd/sdhci.c         | 18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 4a102b8..cb37182 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -42,6 +42,7 @@ typedef struct SDHCIState {
     SDBus sdbus;
     MemoryRegion iomem;
     AddressSpace *dma_as;
+    MemoryRegion *dma_mr;
 
     QEMUTimer *insert_timer;       /* timer for 'changing' sd card. */
     QEMUTimer *transfer_timer;
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index dd40069..f9264d3 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1354,6 +1354,8 @@ static Property sdhci_sysbus_properties[] = {
     DEFINE_SDHCI_COMMON_PROPERTIES(SDHCIState),
     DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_quirk,
                      false),
+    DEFINE_PROP_LINK("dma", SDHCIState,
+                     dma_mr, TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -1367,6 +1369,11 @@ static void sdhci_sysbus_init(Object *obj)
 static void sdhci_sysbus_finalize(Object *obj)
 {
     SDHCIState *s = SYSBUS_SDHCI(obj);
+
+    if (s->dma_mr) {
+        object_unparent(OBJECT(s->dma_mr));
+    }
+
     sdhci_uninitfn(s);
 }
 
@@ -1380,7 +1387,12 @@ static void sdhci_sysbus_realize(DeviceState *dev, Error ** errp)
         return;
     }
 
-    s->dma_as = &address_space_memory;
+    if (s->dma_mr) {
+        address_space_init(s->dma_as, s->dma_mr, "sdhci-dma");
+    } else {
+        /* use system_memory() if property "dma" not set */
+        s->dma_as = &address_space_memory;
+    }
 
     sysbus_init_irq(sbd, &s->irq);
     sysbus_init_mmio(sbd, &s->iomem);
@@ -1391,6 +1403,10 @@ static void sdhci_sysbus_unrealize(DeviceState *dev, Error **errp)
     SDHCIState *s = SYSBUS_SDHCI(dev);
 
     sdhci_common_unrealize(s, &error_abort);
+
+     if (s->dma_mr) {
+        address_space_destroy(s->dma_as);
+    }
 }
 
 static void sdhci_sysbus_class_init(ObjectClass *klass, void *data)
-- 
2.7.4
