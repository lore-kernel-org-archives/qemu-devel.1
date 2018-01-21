Received: from eggs.gnu.org ([2001:4830:134:3::10]:34740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1edBfr-0006F8-2j
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 04:12:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1edBfp-00039Z-2b
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 04:12:23 -0500
Received: from chuckie.co.uk ([82.165.15.123]:47983
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1edBfo-00030p-PQ
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 04:12:21 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 21 Jan 2018 09:11:47 +0000
Message-Id: <20180121091154.17426-4-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180121091154.17426-1-mark.cave-ayland@ilande.co.uk>
References: <20180121091154.17426-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCHv2 03/10] apb: rename APB functions to use sabre
 prefix
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

As hinted in the comment at the top of the file, the naming convention for the
APB types/QOM functions isn't correct. As a starting point we can at least
rename the APB type and related functions to improve the readability of apb.c.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 hw/pci-host/apb.c         | 109 +++++++++++++++++++++++-----------------------
 include/hw/pci-host/apb.h |   1 -
 2 files changed, 54 insertions(+), 56 deletions(-)

diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index 43ee42d170..d5c459a2df 100644
--- a/hw/pci-host/apb.c
+++ b/hw/pci-host/apb.c
@@ -70,7 +70,7 @@ do { printf("APB: " fmt , ## __VA_ARGS__); } while (0)
 
 #define NO_IRQ_REQUEST (MAX_IVEC + 1)
 
-static inline void pbm_set_request(APBState *s, unsigned int irq_num)
+static inline void sabre_set_request(APBState *s, unsigned int irq_num)
 {
     APB_DPRINTF("%s: request irq %d\n", __func__, irq_num);
 
@@ -78,14 +78,13 @@ static inline void pbm_set_request(APBState *s, unsigned int irq_num)
     qemu_set_irq(s->ivec_irqs[irq_num], 1);
 }
 
-static inline void pbm_check_irqs(APBState *s)
+static inline void sabre_check_irqs(APBState *s)
 {
-
     unsigned int i;
 
     /* Previous request is not acknowledged, resubmit */
     if (s->irq_request != NO_IRQ_REQUEST) {
-        pbm_set_request(s, s->irq_request);
+        sabre_set_request(s, s->irq_request);
         return;
     }
     /* no request pending */
@@ -95,7 +94,7 @@ static inline void pbm_check_irqs(APBState *s)
     for (i = 0; i < 32; i++) {
         if (s->pci_irq_in & (1ULL << i)) {
             if (s->pci_irq_map[i >> 2] & PBM_PCI_IMR_ENABLED) {
-                pbm_set_request(s, i);
+                sabre_set_request(s, i);
                 return;
             }
         }
@@ -103,28 +102,28 @@ static inline void pbm_check_irqs(APBState *s)
     for (i = 32; i < 64; i++) {
         if (s->pci_irq_in & (1ULL << i)) {
             if (s->obio_irq_map[i - 32] & PBM_PCI_IMR_ENABLED) {
-                pbm_set_request(s, i);
+                sabre_set_request(s, i);
                 break;
             }
         }
     }
 }
 
-static inline void pbm_clear_request(APBState *s, unsigned int irq_num)
+static inline void sabre_clear_request(APBState *s, unsigned int irq_num)
 {
     APB_DPRINTF("%s: clear request irq %d\n", __func__, irq_num);
     qemu_set_irq(s->ivec_irqs[irq_num], 0);
     s->irq_request = NO_IRQ_REQUEST;
 }
 
-static AddressSpace *pbm_pci_dma_iommu(PCIBus *bus, void *opaque, int devfn)
+static AddressSpace *sabre_pci_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 {
     IOMMUState *is = opaque;
 
     return &is->iommu_as;
 }
 
-static void apb_config_writel (void *opaque, hwaddr addr,
+static void sabre_config_write(void *opaque, hwaddr addr,
                                uint64_t val, unsigned size)
 {
     APBState *s = opaque;
@@ -141,9 +140,9 @@ static void apb_config_writel (void *opaque, hwaddr addr,
             s->pci_irq_map[ino] &= PBM_PCI_IMR_MASK;
             s->pci_irq_map[ino] |= val & ~PBM_PCI_IMR_MASK;
             if ((s->irq_request == ino) && !(val & ~PBM_PCI_IMR_MASK)) {
-                pbm_clear_request(s, ino);
+                sabre_clear_request(s, ino);
             }
-            pbm_check_irqs(s);
+            sabre_check_irqs(s);
         }
         break;
     case 0x1000 ... 0x107f: /* OBIO interrupt control */
@@ -153,17 +152,17 @@ static void apb_config_writel (void *opaque, hwaddr addr,
             s->obio_irq_map[ino] |= val & ~PBM_PCI_IMR_MASK;
             if ((s->irq_request == (ino | 0x20))
                  && !(val & ~PBM_PCI_IMR_MASK)) {
-                pbm_clear_request(s, ino | 0x20);
+                sabre_clear_request(s, ino | 0x20);
             }
-            pbm_check_irqs(s);
+            sabre_check_irqs(s);
         }
         break;
     case 0x1400 ... 0x14ff: /* PCI interrupt clear */
         if (addr & 4) {
             unsigned int ino = (addr & 0xff) >> 5;
             if ((s->irq_request / 4)  == ino) {
-                pbm_clear_request(s, s->irq_request);
-                pbm_check_irqs(s);
+                sabre_clear_request(s, s->irq_request);
+                sabre_check_irqs(s);
             }
         }
         break;
@@ -171,8 +170,8 @@ static void apb_config_writel (void *opaque, hwaddr addr,
         if (addr & 4) {
             unsigned int ino = ((addr & 0xff) >> 3) | 0x20;
             if (s->irq_request == ino) {
-                pbm_clear_request(s, ino);
-                pbm_check_irqs(s);
+                sabre_clear_request(s, ino);
+                sabre_check_irqs(s);
             }
         }
         break;
@@ -202,7 +201,7 @@ static void apb_config_writel (void *opaque, hwaddr addr,
     }
 }
 
-static uint64_t apb_config_readl (void *opaque,
+static uint64_t sabre_config_read(void *opaque,
                                   hwaddr addr, unsigned size)
 {
     APBState *s = opaque;
@@ -258,14 +257,14 @@ static uint64_t apb_config_readl (void *opaque,
     return val;
 }
 
-static const MemoryRegionOps apb_config_ops = {
-    .read = apb_config_readl,
-    .write = apb_config_writel,
+static const MemoryRegionOps sabre_config_ops = {
+    .read = sabre_config_read,
+    .write = sabre_config_write,
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static void apb_pci_config_write(void *opaque, hwaddr addr,
-                                 uint64_t val, unsigned size)
+static void sabre_pci_config_write(void *opaque, hwaddr addr,
+                                   uint64_t val, unsigned size)
 {
     APBState *s = opaque;
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
@@ -274,8 +273,8 @@ static void apb_pci_config_write(void *opaque, hwaddr addr,
     pci_data_write(phb->bus, addr, val, size);
 }
 
-static uint64_t apb_pci_config_read(void *opaque, hwaddr addr,
-                                    unsigned size)
+static uint64_t sabre_pci_config_read(void *opaque, hwaddr addr,
+                                      unsigned size)
 {
     uint32_t ret;
     APBState *s = opaque;
@@ -286,8 +285,8 @@ static uint64_t apb_pci_config_read(void *opaque, hwaddr addr,
     return ret;
 }
 
-/* The APB host has an IRQ line for each IRQ line of each slot.  */
-static int pci_apb_map_irq(PCIDevice *pci_dev, int irq_num)
+/* The sabre host has an IRQ line for each IRQ line of each slot.  */
+static int pci_sabre_map_irq(PCIDevice *pci_dev, int irq_num)
 {
     /* Return the irq as swizzled by the PBM */
     return irq_num;
@@ -316,7 +315,7 @@ static int pci_simbaB_map_irq(PCIDevice *pci_dev, int irq_num)
     return (0x10 + (PCI_SLOT(pci_dev->devfn) << 2) + irq_num) & 0x1f;
 }
 
-static void pci_apb_set_irq(void *opaque, int irq_num, int level)
+static void pci_sabre_set_irq(void *opaque, int irq_num, int level)
 {
     APBState *s = opaque;
 
@@ -326,7 +325,7 @@ static void pci_apb_set_irq(void *opaque, int irq_num, int level)
         if (level) {
             s->pci_irq_in |= 1ULL << irq_num;
             if (s->pci_irq_map[irq_num >> 2] & PBM_PCI_IMR_ENABLED) {
-                pbm_set_request(s, irq_num);
+                sabre_set_request(s, irq_num);
             }
         } else {
             s->pci_irq_in &= ~(1ULL << irq_num);
@@ -338,7 +337,7 @@ static void pci_apb_set_irq(void *opaque, int irq_num, int level)
             s->pci_irq_in |= 1ULL << irq_num;
             if ((s->irq_request == NO_IRQ_REQUEST)
                 && (s->obio_irq_map[irq_num - 32] & PBM_PCI_IMR_ENABLED)) {
-                pbm_set_request(s, irq_num);
+                sabre_set_request(s, irq_num);
             }
         } else {
             s->pci_irq_in &= ~(1ULL << irq_num);
@@ -346,7 +345,7 @@ static void pci_apb_set_irq(void *opaque, int irq_num, int level)
     }
 }
 
-static void pci_pbm_reset(DeviceState *d)
+static void sabre_reset(DeviceState *d)
 {
     APBState *s = APB_DEVICE(d);
     PCIDevice *pci_dev;
@@ -379,12 +378,12 @@ static void pci_pbm_reset(DeviceState *d)
 }
 
 static const MemoryRegionOps pci_config_ops = {
-    .read = apb_pci_config_read,
-    .write = apb_pci_config_write,
+    .read = sabre_pci_config_read,
+    .write = sabre_pci_config_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static void pci_pbm_realize(DeviceState *dev, Error **errp)
+static void sabre_realize(DeviceState *dev, Error **errp)
 {
     APBState *s = APB_DEVICE(dev);
     PCIHostState *phb = PCI_HOST_BRIDGE(dev);
@@ -403,17 +402,17 @@ static void pci_pbm_realize(DeviceState *dev, Error **errp)
                                 &s->pci_mmio);
 
     phb->bus = pci_register_root_bus(dev, "pci",
-                                     pci_apb_set_irq, pci_apb_map_irq, s,
+                                     pci_sabre_set_irq, pci_sabre_map_irq, s,
                                      &s->pci_mmio,
                                      &s->pci_ioport,
                                      0, 32, TYPE_PCI_BUS);
 
     pci_create_simple(phb->bus, 0, "pbm-pci");
 
-    /* APB IOMMU */
+    /* IOMMU */
     memory_region_add_subregion_overlap(&s->apb_config, 0x200,
                     sysbus_mmio_get_region(SYS_BUS_DEVICE(s->iommu), 0), 1);
-    pci_setup_iommu(phb->bus, pbm_pci_dma_iommu, s->iommu);
+    pci_setup_iommu(phb->bus, sabre_pci_dma_iommu, s->iommu);
 
     /* APB secondary busses */
     pci_dev = pci_create_multifunction(phb->bus, PCI_DEVFN(1, 0), true,
@@ -429,7 +428,7 @@ static void pci_pbm_realize(DeviceState *dev, Error **errp)
     qdev_init_nofail(&pci_dev->qdev);
 }
 
-static void pci_pbm_init(Object *obj)
+static void sabre_init(Object *obj)
 {
     APBState *s = APB_DEVICE(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
@@ -444,7 +443,7 @@ static void pci_pbm_init(Object *obj)
     for (i = 0; i < 32; i++) {
         s->obio_irq_map[i] = ((0x1f << 6) | 0x20) + i;
     }
-    qdev_init_gpio_in_named(DEVICE(s), pci_apb_set_irq, "pbm-irq", MAX_IVEC);
+    qdev_init_gpio_in_named(DEVICE(s), pci_sabre_set_irq, "pbm-irq", MAX_IVEC);
     qdev_init_gpio_out_named(DEVICE(s), s->ivec_irqs, "ivec-irq", MAX_IVEC);
     s->irq_request = NO_IRQ_REQUEST;
     s->pci_irq_in = 0ULL;
@@ -456,7 +455,7 @@ static void pci_pbm_init(Object *obj)
                              0, NULL);
 
     /* apb_config */
-    memory_region_init_io(&s->apb_config, OBJECT(s), &apb_config_ops, s,
+    memory_region_init_io(&s->apb_config, OBJECT(s), &sabre_config_ops, s,
                           "apb-config", 0x10000);
     /* at region 0 */
     sysbus_init_mmio(sbd, &s->apb_config);
@@ -473,7 +472,7 @@ static void pci_pbm_init(Object *obj)
     sysbus_init_mmio(sbd, &s->pci_ioport);
 }
 
-static void pbm_pci_host_realize(PCIDevice *d, Error **errp)
+static void sabre_pci_host_realize(PCIDevice *d, Error **errp)
 {
     pci_set_word(d->config + PCI_COMMAND,
                  PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
@@ -482,12 +481,12 @@ static void pbm_pci_host_realize(PCIDevice *d, Error **errp)
                  PCI_STATUS_DEVSEL_MEDIUM);
 }
 
-static void pbm_pci_host_class_init(ObjectClass *klass, void *data)
+static void sabre_pci_host_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    k->realize = pbm_pci_host_realize;
+    k->realize = sabre_pci_host_realize;
     k->vendor_id = PCI_VENDOR_ID_SUN;
     k->device_id = PCI_DEVICE_ID_SUN_SABRE;
     k->class_id = PCI_CLASS_BRIDGE_HOST;
@@ -502,41 +501,41 @@ static const TypeInfo pbm_pci_host_info = {
     .name          = "pbm-pci",
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIDevice),
-    .class_init    = pbm_pci_host_class_init,
+    .class_init    = sabre_pci_host_class_init,
     .interfaces = (InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
 };
 
-static Property pbm_pci_host_properties[] = {
+static Property sabre_properties[] = {
     DEFINE_PROP_UINT64("special-base", APBState, special_base, 0),
     DEFINE_PROP_UINT64("mem-base", APBState, mem_base, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static void pbm_host_class_init(ObjectClass *klass, void *data)
+static void sabre_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->realize = pci_pbm_realize;
-    dc->reset = pci_pbm_reset;
-    dc->props = pbm_pci_host_properties;
+    dc->realize = sabre_realize;
+    dc->reset = sabre_reset;
+    dc->props = sabre_properties;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
-static const TypeInfo pbm_host_info = {
+static const TypeInfo sabre_info = {
     .name          = TYPE_APB,
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(APBState),
-    .instance_init = pci_pbm_init,
-    .class_init    = pbm_host_class_init,
+    .instance_init = sabre_init,
+    .class_init    = sabre_class_init,
 };
 
-static void pbm_register_types(void)
+static void sabre_register_types(void)
 {
-    type_register_static(&pbm_host_info);
+    type_register_static(&sabre_info);
     type_register_static(&pbm_pci_host_info);
 }
 
-type_init(pbm_register_types)
+type_init(sabre_register_types)
diff --git a/include/hw/pci-host/apb.h b/include/hw/pci-host/apb.h
index 5e28f3e1f3..41de012396 100644
--- a/include/hw/pci-host/apb.h
+++ b/include/hw/pci-host/apb.h
@@ -15,7 +15,6 @@
 #define OBIO_SER_IRQ         0x2b
 
 #define TYPE_APB "pbm"
-
 #define APB_DEVICE(obj) \
     OBJECT_CHECK(APBState, (obj), TYPE_APB)
 
-- 
2.11.0
