Received: from eggs.gnu.org ([2001:4830:134:3::10]:34775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1edBft-0006Ge-6k
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 04:12:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1edBfr-0003DB-MI
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 04:12:25 -0500
Received: from chuckie.co.uk ([82.165.15.123]:47998
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1edBfr-0003C0-Cz
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 04:12:23 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 21 Jan 2018 09:11:52 +0000
Message-Id: <20180121091154.17426-9-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180121091154.17426-1-mark.cave-ayland@ilande.co.uk>
References: <20180121091154.17426-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCHv2 08/10] apb: rename apb.c to sabre.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This is the final stage in correcting the naming convention with respect to
sabre, APB and PBM. It is effectively a file rename from apb.c to sabre.c
along with touching up a few constants to remove the remaining references
to APB.

Note that as part of the rename process the configuration variable
CONFIG_PCI_APB is changed to CONFIG_PCI_SABRE.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 default-configs/sparc64-softmmu.mak    |  2 +-
 hw/pci-host/Makefile.objs              |  2 +-
 hw/pci-host/{apb.c => sabre.c}         | 57 +++++++++++++++++-----------------
 hw/sparc64/sun4u.c                     |  2 +-
 include/hw/pci-host/{apb.h => sabre.h} |  2 +-
 5 files changed, 33 insertions(+), 32 deletions(-)
 rename hw/pci-host/{apb.c => sabre.c} (91%)
 rename include/hw/pci-host/{apb.h => sabre.h} (97%)

diff --git a/default-configs/sparc64-softmmu.mak b/default-configs/sparc64-softmmu.mak
index 9b742a7b41..52edafe547 100644
--- a/default-configs/sparc64-softmmu.mak
+++ b/default-configs/sparc64-softmmu.mak
@@ -11,7 +11,7 @@ CONFIG_PCKBD=y
 CONFIG_FDC=y
 CONFIG_IDE_ISA=y
 CONFIG_IDE_CMD646=y
-CONFIG_PCI_APB=y
+CONFIG_PCI_SABRE=y
 CONFIG_SIMBA=y
 CONFIG_SUNHME=y
 CONFIG_MC146818RTC=y
diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
index 9c7909cf44..4b69f737b5 100644
--- a/hw/pci-host/Makefile.objs
+++ b/hw/pci-host/Makefile.objs
@@ -11,7 +11,7 @@ common-obj-$(CONFIG_PPCE500_PCI) += ppce500.o
 # ARM devices
 common-obj-$(CONFIG_VERSATILE_PCI) += versatile.o
 
-common-obj-$(CONFIG_PCI_APB) += apb.o
+common-obj-$(CONFIG_PCI_SABRE) += sabre.o
 common-obj-$(CONFIG_FULONG) += bonito.o
 common-obj-$(CONFIG_PCI_PIIX) += piix.o
 common-obj-$(CONFIG_PCI_Q35) += q35.o
diff --git a/hw/pci-host/apb.c b/hw/pci-host/sabre.c
similarity index 91%
rename from hw/pci-host/apb.c
rename to hw/pci-host/sabre.c
index f6c5dbd469..4054c17598 100644
--- a/hw/pci-host/apb.c
+++ b/hw/pci-host/sabre.c
@@ -1,8 +1,9 @@
 /*
- * QEMU Ultrasparc APB PCI host
+ * QEMU Ultrasparc Sabre PCI host (PBM)
  *
  * Copyright (c) 2006 Fabrice Bellard
  * Copyright (c) 2012,2013 Artyom Tarasenko
+ * Copyright (c) 2018 Mark Cave-Ayland
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -23,10 +24,6 @@
  * THE SOFTWARE.
  */
 
-/* XXX This file and most of its contents are somewhat misnamed.  The
-   Ultrasparc PCI host is called the PCI Bus Module (PBM).  The APB is
-   the secondary PCI bridge.  */
-
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/pci/pci.h"
@@ -34,20 +31,20 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci-bridge/simba.h"
-#include "hw/pci-host/apb.h"
+#include "hw/pci-host/sabre.h"
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 
-/* debug APB */
-//#define DEBUG_APB
+/* debug sabre */
+//#define DEBUG_SABRE
 
-#ifdef DEBUG_APB
-#define APB_DPRINTF(fmt, ...) \
-do { printf("APB: " fmt , ## __VA_ARGS__); } while (0)
+#ifdef DEBUG_SABRE
+#define SABRE_DPRINTF(fmt, ...) \
+do { printf("sabre: " fmt , ## __VA_ARGS__); } while (0)
 #else
-#define APB_DPRINTF(fmt, ...)
+#define SABRE_DPRINTF(fmt, ...)
 #endif
 
 /*
@@ -72,7 +69,7 @@ do { printf("APB: " fmt , ## __VA_ARGS__); } while (0)
 
 static inline void sabre_set_request(SabreState *s, unsigned int irq_num)
 {
-    APB_DPRINTF("%s: request irq %d\n", __func__, irq_num);
+    SABRE_DPRINTF("%s: request irq %d\n", __func__, irq_num);
 
     s->irq_request = irq_num;
     qemu_set_irq(s->ivec_irqs[irq_num], 1);
@@ -111,7 +108,7 @@ static inline void sabre_check_irqs(SabreState *s)
 
 static inline void sabre_clear_request(SabreState *s, unsigned int irq_num)
 {
-    APB_DPRINTF("%s: clear request irq %d\n", __func__, irq_num);
+    SABRE_DPRINTF("%s: clear request irq %d\n", __func__, irq_num);
     qemu_set_irq(s->ivec_irqs[irq_num], 0);
     s->irq_request = NO_IRQ_REQUEST;
 }
@@ -128,7 +125,8 @@ static void sabre_config_write(void *opaque, hwaddr addr,
 {
     SabreState *s = opaque;
 
-    APB_DPRINTF("%s: addr " TARGET_FMT_plx " val %" PRIx64 "\n", __func__, addr, val);
+    SABRE_DPRINTF("%s: addr " TARGET_FMT_plx " val %" PRIx64 "\n", __func__,
+                  addr, val);
 
     switch (addr & 0xffff) {
     case 0x30 ... 0x4f: /* DMA error registers */
@@ -252,7 +250,7 @@ static uint64_t sabre_config_read(void *opaque,
         val = 0;
         break;
     }
-    APB_DPRINTF("%s: addr " TARGET_FMT_plx " -> %x\n", __func__, addr, val);
+    SABRE_DPRINTF("%s: addr " TARGET_FMT_plx " -> %x\n", __func__, addr, val);
 
     return val;
 }
@@ -269,7 +267,8 @@ static void sabre_pci_config_write(void *opaque, hwaddr addr,
     SabreState *s = opaque;
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
 
-    APB_DPRINTF("%s: addr " TARGET_FMT_plx " val %" PRIx64 "\n", __func__, addr, val);
+    SABRE_DPRINTF("%s: addr " TARGET_FMT_plx " val %" PRIx64 "\n", __func__,
+                  addr, val);
     pci_data_write(phb->bus, addr, val, size);
 }
 
@@ -281,7 +280,7 @@ static uint64_t sabre_pci_config_read(void *opaque, hwaddr addr,
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
 
     ret = pci_data_read(phb->bus, addr, size);
-    APB_DPRINTF("%s: addr " TARGET_FMT_plx " -> %x\n", __func__, addr, ret);
+    SABRE_DPRINTF("%s: addr " TARGET_FMT_plx " -> %x\n", __func__, addr, ret);
     return ret;
 }
 
@@ -319,7 +318,7 @@ static void pci_sabre_set_irq(void *opaque, int irq_num, int level)
 {
     SabreState *s = opaque;
 
-    APB_DPRINTF("%s: set irq_in %d level %d\n", __func__, irq_num, level);
+    SABRE_DPRINTF("%s: set irq_in %d level %d\n", __func__, irq_num, level);
     /* PCI IRQ map onto the first 32 INO.  */
     if (irq_num < 32) {
         if (level) {
@@ -333,7 +332,8 @@ static void pci_sabre_set_irq(void *opaque, int irq_num, int level)
     } else {
         /* OBIO IRQ map onto the next 32 INO.  */
         if (level) {
-            APB_DPRINTF("%s: set irq %d level %d\n", __func__, irq_num, level);
+            SABRE_DPRINTF("%s: set irq %d level %d\n", __func__, irq_num,
+                          level);
             s->pci_irq_in |= 1ULL << irq_num;
             if ((s->irq_request == NO_IRQ_REQUEST)
                 && (s->obio_irq_map[irq_num - 32] & PBM_PCI_IMR_ENABLED)) {
@@ -390,7 +390,7 @@ static void sabre_realize(DeviceState *dev, Error **errp)
     SysBusDevice *sbd = SYS_BUS_DEVICE(s);
     PCIDevice *pci_dev;
 
-    /* apb_config */
+    /* sabre_config */
     sysbus_mmio_map(sbd, 0, s->special_base);
     /* PCI configuration space */
     sysbus_mmio_map(sbd, 1, s->special_base + 0x1000000ULL);
@@ -410,7 +410,7 @@ static void sabre_realize(DeviceState *dev, Error **errp)
     pci_create_simple(phb->bus, 0, TYPE_SABRE_PCI_DEVICE);
 
     /* IOMMU */
-    memory_region_add_subregion_overlap(&s->apb_config, 0x200,
+    memory_region_add_subregion_overlap(&s->sabre_config, 0x200,
                     sysbus_mmio_get_region(SYS_BUS_DEVICE(s->iommu), 0), 1);
     pci_setup_iommu(phb->bus, sabre_pci_dma_iommu, s->iommu);
 
@@ -454,19 +454,20 @@ static void sabre_init(Object *obj)
                              qdev_prop_allow_set_link_before_realize,
                              0, NULL);
 
-    /* apb_config */
-    memory_region_init_io(&s->apb_config, OBJECT(s), &sabre_config_ops, s,
-                          "apb-config", 0x10000);
+    /* sabre_config */
+    memory_region_init_io(&s->sabre_config, OBJECT(s), &sabre_config_ops, s,
+                          "sabre-config", 0x10000);
     /* at region 0 */
-    sysbus_init_mmio(sbd, &s->apb_config);
+    sysbus_init_mmio(sbd, &s->sabre_config);
 
     memory_region_init_io(&s->pci_config, OBJECT(s), &pci_config_ops, s,
-                          "apb-pci-config", 0x1000000);
+                          "sabre-pci-config", 0x1000000);
     /* at region 1 */
     sysbus_init_mmio(sbd, &s->pci_config);
 
     /* pci_ioport */
-    memory_region_init(&s->pci_ioport, OBJECT(s), "apb-pci-ioport", 0x1000000);
+    memory_region_init(&s->pci_ioport, OBJECT(s), "sabre-pci-ioport",
+                       0x1000000);
 
     /* at region 2 */
     sysbus_init_mmio(sbd, &s->pci_ioport);
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index fb18afaaa6..c4eff6bea2 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -30,7 +30,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
-#include "hw/pci-host/apb.h"
+#include "hw/pci-host/sabre.h"
 #include "hw/i386/pc.h"
 #include "hw/char/serial.h"
 #include "hw/timer/m48t59.h"
diff --git a/include/hw/pci-host/apb.h b/include/hw/pci-host/sabre.h
similarity index 97%
rename from include/hw/pci-host/apb.h
rename to include/hw/pci-host/sabre.h
index 2552f3c984..0f2ccc01c6 100644
--- a/include/hw/pci-host/apb.h
+++ b/include/hw/pci-host/sabre.h
@@ -27,7 +27,7 @@ typedef struct SabreState {
 
     hwaddr special_base;
     hwaddr mem_base;
-    MemoryRegion apb_config;
+    MemoryRegion sabre_config;
     MemoryRegion pci_config;
     MemoryRegion pci_mmio;
     MemoryRegion pci_ioport;
-- 
2.11.0
