Received: from eggs.gnu.org ([2001:4830:134:3::10]:34106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eIx6B-0000Qi-QB
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 08:35:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eIx6A-0006dX-BC
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 08:35:55 -0500
Received: from chuckie.co.uk ([82.165.15.123]:48802
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eIx6A-0006d2-2Q
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 08:35:54 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 26 Nov 2017 13:35:22 +0000
Message-Id: <1511703326-25325-5-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1511703326-25325-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1511703326-25325-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 4/8] apb: QOMify IOMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

This is in preparation to split the IOMMU device out of the APB. As part of
this commit we also enforce separation of the IOMMU and APB devices by using
a QOM object link to pass the IOMMU reference and accessing the IOMMU registers
via a separate memory region mapped into the APB config space rather than
directly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci-host/apb.c         |   77 +++++++++++++++++++++++++++++++++------------
 hw/sparc64/sun4u.c        |    7 ++++-
 include/hw/pci-host/apb.h |    8 ++++-
 3 files changed, 70 insertions(+), 22 deletions(-)

diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index 54ab899..7eb5ce0 100644
--- a/hw/pci-host/apb.c
+++ b/hw/pci-host/apb.c
@@ -36,6 +36,7 @@
 #include "hw/pci-host/apb.h"
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
+#include "qapi/error.h"
 #include "qemu/log.h"
 
 /* debug APB */
@@ -250,8 +251,8 @@ static IOMMUTLBEntry pbm_translate_iommu(IOMMUMemoryRegion *iommu, hwaddr addr,
     return ret;
 }
 
-static void iommu_config_write(void *opaque, hwaddr addr,
-                               uint64_t val, unsigned size)
+static void iommu_mem_write(void *opaque, hwaddr addr,
+                            uint64_t val, unsigned size)
 {
     IOMMUState *is = opaque;
 
@@ -295,7 +296,7 @@ static void iommu_config_write(void *opaque, hwaddr addr,
     }
 }
 
-static uint64_t iommu_config_read(void *opaque, hwaddr addr, unsigned size)
+static uint64_t iommu_mem_read(void *opaque, hwaddr addr, unsigned size)
 {
     IOMMUState *is = opaque;
     uint64_t val;
@@ -344,7 +345,6 @@ static void apb_config_writel (void *opaque, hwaddr addr,
                                uint64_t val, unsigned size)
 {
     APBState *s = opaque;
-    IOMMUState *is = &s->iommu;
 
     APB_DPRINTF("%s: addr " TARGET_FMT_plx " val %" PRIx64 "\n", __func__, addr, val);
 
@@ -352,9 +352,6 @@ static void apb_config_writel (void *opaque, hwaddr addr,
     case 0x30 ... 0x4f: /* DMA error registers */
         /* XXX: not implemented yet */
         break;
-    case 0x200 ... 0x217: /* IOMMU */
-        iommu_config_write(is, (addr & 0x1f), val, size);
-        break;
     case 0xc00 ... 0xc3f: /* PCI interrupt control */
         if (addr & 4) {
             unsigned int ino = (addr & 0x3f) >> 3;
@@ -426,7 +423,6 @@ static uint64_t apb_config_readl (void *opaque,
                                   hwaddr addr, unsigned size)
 {
     APBState *s = opaque;
-    IOMMUState *is = &s->iommu;
     uint32_t val;
 
     switch (addr & 0xffff) {
@@ -434,9 +430,6 @@ static uint64_t apb_config_readl (void *opaque,
         val = 0;
         /* XXX: not implemented yet */
         break;
-    case 0x200 ... 0x217: /* IOMMU */
-        val = iommu_config_read(is, (addr & 0x1f), size);
-        break;
     case 0xc00 ... 0xc3f: /* PCI interrupt control */
         if (addr & 4) {
             val = s->pci_irq_map[(addr & 0x3f) >> 3];
@@ -641,7 +634,6 @@ static void pci_pbm_realize(DeviceState *dev, Error **errp)
     PCIHostState *phb = PCI_HOST_BRIDGE(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(s);
     PCIDevice *pci_dev;
-    IOMMUState *is;
 
     /* apb_config */
     sysbus_mmio_map(sbd, 0, s->special_base);
@@ -657,14 +649,9 @@ static void pci_pbm_realize(DeviceState *dev, Error **errp)
     pci_create_simple(phb->bus, 0, "pbm-pci");
 
     /* APB IOMMU */
-    is = &s->iommu;
-    memset(is, 0, sizeof(IOMMUState));
-
-    memory_region_init_iommu(&is->iommu, sizeof(is->iommu),
-                             TYPE_APB_IOMMU_MEMORY_REGION, OBJECT(dev),
-                             "iommu-apb", UINT64_MAX);
-    address_space_init(&is->iommu_as, MEMORY_REGION(&is->iommu), "pbm-as");
-    pci_setup_iommu(phb->bus, pbm_pci_dma_iommu, is);
+    memory_region_add_subregion_overlap(&s->apb_config, 0x200,
+                    sysbus_mmio_get_region(SYS_BUS_DEVICE(s->iommu), 0), 1);
+    pci_setup_iommu(phb->bus, pbm_pci_dma_iommu, s->iommu);
 
     /* APB secondary busses */
     pci_dev = pci_create_multifunction(phb->bus, PCI_DEVFN(1, 0), true,
@@ -707,6 +694,12 @@ static void pci_pbm_init(Object *obj)
     s->irq_request = NO_IRQ_REQUEST;
     s->pci_irq_in = 0ULL;
 
+    /* IOMMU */
+    object_property_add_link(obj, "iommu", TYPE_SUN4U_IOMMU,
+                             (Object **) &s->iommu,
+                             qdev_prop_allow_set_link_before_realize,
+                             0, NULL);
+
     /* apb_config */
     memory_region_init_io(&s->apb_config, OBJECT(s), &apb_config_ops, s,
                           "apb-config", 0x10000);
@@ -813,6 +806,49 @@ static const TypeInfo pbm_pci_bridge_info = {
     },
 };
 
+static const MemoryRegionOps iommu_mem_ops = {
+    .read = iommu_mem_read,
+    .write = iommu_mem_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void iommu_reset(DeviceState *d)
+{
+    IOMMUState *s = SUN4U_IOMMU(d);
+
+    memset(s->regs, 0, IOMMU_NREGS * sizeof(uint64_t));
+}
+
+static void iommu_init(Object *obj)
+{
+    IOMMUState *s = SUN4U_IOMMU(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_iommu(&s->iommu, sizeof(s->iommu),
+                             TYPE_APB_IOMMU_MEMORY_REGION, OBJECT(s),
+                             "iommu-apb", UINT64_MAX);
+    address_space_init(&s->iommu_as, MEMORY_REGION(&s->iommu), "pbm-as");
+
+    memory_region_init_io(&s->iomem, obj, &iommu_mem_ops, s, "iommu",
+                          IOMMU_NREGS * sizeof(uint64_t));
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void iommu_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = iommu_reset;
+}
+
+static const TypeInfo pbm_iommu_info = {
+    .name          = TYPE_SUN4U_IOMMU,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(IOMMUState),
+    .instance_init = iommu_init,
+    .class_init    = iommu_class_init,
+};
+
 static void pbm_iommu_memory_region_class_init(ObjectClass *klass, void *data)
 {
     IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
@@ -831,6 +867,7 @@ static void pbm_register_types(void)
     type_register_static(&pbm_host_info);
     type_register_static(&pbm_pci_host_info);
     type_register_static(&pbm_pci_bridge_info);
+    type_register_static(&pbm_iommu_info);
     type_register_static(&pbm_iommu_memory_region_info);
 }
 
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 5d802bd..aaee3de 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -469,7 +469,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     PCIDevice *ebus, *pci_dev;
     SysBusDevice *s;
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-    DeviceState *dev;
+    DeviceState *iommu, *dev;
     FWCfgState *fw_cfg;
     NICInfo *nd;
     MACAddr macaddr;
@@ -478,6 +478,10 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     /* init CPUs */
     cpu = sparc64_cpu_devinit(machine->cpu_type, hwdef->prom_addr);
 
+    /* IOMMU */
+    iommu = qdev_create(NULL, TYPE_SUN4U_IOMMU);
+    qdev_init_nofail(iommu);
+
     /* set up devices */
     ram_init(0, machine->ram_size);
 
@@ -487,6 +491,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     apb = APB_DEVICE(qdev_create(NULL, TYPE_APB));
     qdev_prop_set_uint64(DEVICE(apb), "special-base", APB_SPECIAL_BASE);
     qdev_prop_set_uint64(DEVICE(apb), "mem-base", APB_MEM_BASE);
+    object_property_set_link(OBJECT(apb), OBJECT(iommu), "iommu", &error_abort);
     qdev_init_nofail(DEVICE(apb));
 
     /* Wire up PCI interrupts to CPU */
diff --git a/include/hw/pci-host/apb.h b/include/hw/pci-host/apb.h
index 6194c8c..33dbc7a 100644
--- a/include/hw/pci-host/apb.h
+++ b/include/hw/pci-host/apb.h
@@ -44,12 +44,18 @@
 #define IOMMU_TSB_64K_OFFSET_MASK_2G   0x000000007fff0000ULL
 
 typedef struct IOMMUState {
+    SysBusDevice parent_obj;
+
     AddressSpace iommu_as;
     IOMMUMemoryRegion iommu;
 
+    MemoryRegion iomem;
     uint64_t regs[IOMMU_NREGS];
 } IOMMUState;
 
+#define TYPE_SUN4U_IOMMU "sun4u-iommu"
+#define SUN4U_IOMMU(obj) OBJECT_CHECK(IOMMUState, (obj), TYPE_SUN4U_IOMMU)
+
 #define MAX_IVEC 0x40
 
 /* OBIO IVEC IRQs */
@@ -78,7 +84,7 @@ typedef struct APBState {
     MemoryRegion pci_mmio;
     MemoryRegion pci_ioport;
     uint64_t pci_irq_in;
-    IOMMUState iommu;
+    IOMMUState *iommu;
     PCIBridge *bridgeA;
     PCIBridge *bridgeB;
     uint32_t pci_control[16];
-- 
1.7.10.4
