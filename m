Received: from eggs.gnu.org ([2001:4830:134:3::10]:34708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1edBfq-0006Ei-1M
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 04:12:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1edBfn-000389-NY
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 04:12:22 -0500
Received: from chuckie.co.uk ([82.165.15.123]:47991
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1edBfn-00036d-DD
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 04:12:19 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 21 Jan 2018 09:11:50 +0000
Message-Id: <20180121091154.17426-7-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180121091154.17426-1-mark.cave-ayland@ilande.co.uk>
References: <20180121091154.17426-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCHv2 06/10] apb: rename QOM type from TYPE_APB to
 TYPE_SABRE
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

Similarly rename the corresponding APBState typedef to SabreState.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 hw/pci-host/apb.c         | 30 +++++++++++++++---------------
 hw/sparc64/sun4u.c        |  6 +++---
 include/hw/pci-host/apb.h | 10 +++++-----
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index 36c6251816..f6c5dbd469 100644
--- a/hw/pci-host/apb.c
+++ b/hw/pci-host/apb.c
@@ -70,7 +70,7 @@ do { printf("APB: " fmt , ## __VA_ARGS__); } while (0)
 
 #define NO_IRQ_REQUEST (MAX_IVEC + 1)
 
-static inline void sabre_set_request(APBState *s, unsigned int irq_num)
+static inline void sabre_set_request(SabreState *s, unsigned int irq_num)
 {
     APB_DPRINTF("%s: request irq %d\n", __func__, irq_num);
 
@@ -78,7 +78,7 @@ static inline void sabre_set_request(APBState *s, unsigned int irq_num)
     qemu_set_irq(s->ivec_irqs[irq_num], 1);
 }
 
-static inline void sabre_check_irqs(APBState *s)
+static inline void sabre_check_irqs(SabreState *s)
 {
     unsigned int i;
 
@@ -109,7 +109,7 @@ static inline void sabre_check_irqs(APBState *s)
     }
 }
 
-static inline void sabre_clear_request(APBState *s, unsigned int irq_num)
+static inline void sabre_clear_request(SabreState *s, unsigned int irq_num)
 {
     APB_DPRINTF("%s: clear request irq %d\n", __func__, irq_num);
     qemu_set_irq(s->ivec_irqs[irq_num], 0);
@@ -126,7 +126,7 @@ static AddressSpace *sabre_pci_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 static void sabre_config_write(void *opaque, hwaddr addr,
                                uint64_t val, unsigned size)
 {
-    APBState *s = opaque;
+    SabreState *s = opaque;
 
     APB_DPRINTF("%s: addr " TARGET_FMT_plx " val %" PRIx64 "\n", __func__, addr, val);
 
@@ -204,7 +204,7 @@ static void sabre_config_write(void *opaque, hwaddr addr,
 static uint64_t sabre_config_read(void *opaque,
                                   hwaddr addr, unsigned size)
 {
-    APBState *s = opaque;
+    SabreState *s = opaque;
     uint32_t val;
 
     switch (addr & 0xffff) {
@@ -266,7 +266,7 @@ static const MemoryRegionOps sabre_config_ops = {
 static void sabre_pci_config_write(void *opaque, hwaddr addr,
                                    uint64_t val, unsigned size)
 {
-    APBState *s = opaque;
+    SabreState *s = opaque;
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
 
     APB_DPRINTF("%s: addr " TARGET_FMT_plx " val %" PRIx64 "\n", __func__, addr, val);
@@ -277,7 +277,7 @@ static uint64_t sabre_pci_config_read(void *opaque, hwaddr addr,
                                       unsigned size)
 {
     uint32_t ret;
-    APBState *s = opaque;
+    SabreState *s = opaque;
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
 
     ret = pci_data_read(phb->bus, addr, size);
@@ -317,7 +317,7 @@ static int pci_simbaB_map_irq(PCIDevice *pci_dev, int irq_num)
 
 static void pci_sabre_set_irq(void *opaque, int irq_num, int level)
 {
-    APBState *s = opaque;
+    SabreState *s = opaque;
 
     APB_DPRINTF("%s: set irq_in %d level %d\n", __func__, irq_num, level);
     /* PCI IRQ map onto the first 32 INO.  */
@@ -347,7 +347,7 @@ static void pci_sabre_set_irq(void *opaque, int irq_num, int level)
 
 static void sabre_reset(DeviceState *d)
 {
-    APBState *s = APB_DEVICE(d);
+    SabreState *s = SABRE_DEVICE(d);
     PCIDevice *pci_dev;
     unsigned int i;
     uint16_t cmd;
@@ -385,7 +385,7 @@ static const MemoryRegionOps pci_config_ops = {
 
 static void sabre_realize(DeviceState *dev, Error **errp)
 {
-    APBState *s = APB_DEVICE(dev);
+    SabreState *s = SABRE_DEVICE(dev);
     PCIHostState *phb = PCI_HOST_BRIDGE(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(s);
     PCIDevice *pci_dev;
@@ -430,7 +430,7 @@ static void sabre_realize(DeviceState *dev, Error **errp)
 
 static void sabre_init(Object *obj)
 {
-    APBState *s = APB_DEVICE(obj);
+    SabreState *s = SABRE_DEVICE(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     unsigned int i;
 
@@ -509,8 +509,8 @@ static const TypeInfo sabre_pci_info = {
 };
 
 static Property sabre_properties[] = {
-    DEFINE_PROP_UINT64("special-base", APBState, special_base, 0),
-    DEFINE_PROP_UINT64("mem-base", APBState, mem_base, 0),
+    DEFINE_PROP_UINT64("special-base", SabreState, special_base, 0),
+    DEFINE_PROP_UINT64("mem-base", SabreState, mem_base, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -525,9 +525,9 @@ static void sabre_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo sabre_info = {
-    .name          = TYPE_APB,
+    .name          = TYPE_SABRE,
     .parent        = TYPE_PCI_HOST_BRIDGE,
-    .instance_size = sizeof(APBState),
+    .instance_size = sizeof(SabreState),
     .instance_init = sabre_init,
     .class_init    = sabre_class_init,
 };
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index ec45ec2801..b8f685847a 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -465,7 +465,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     Nvram *nvram;
     unsigned int i;
     uint64_t initrd_addr, initrd_size, kernel_addr, kernel_size, kernel_entry;
-    APBState *apb;
+    SabreState *apb;
     PCIBus *pci_bus, *pci_busA, *pci_busB;
     PCIDevice *ebus, *pci_dev;
     SysBusDevice *s;
@@ -488,8 +488,8 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
 
     prom_init(hwdef->prom_addr, bios_name);
 
-    /* Init APB (PCI host bridge) */
-    apb = APB_DEVICE(qdev_create(NULL, TYPE_APB));
+    /* Init sabre (PCI host bridge) */
+    apb = SABRE_DEVICE(qdev_create(NULL, TYPE_SABRE));
     qdev_prop_set_uint64(DEVICE(apb), "special-base", APB_SPECIAL_BASE);
     qdev_prop_set_uint64(DEVICE(apb), "mem-base", APB_MEM_BASE);
     object_property_set_link(OBJECT(apb), OBJECT(iommu), "iommu", &error_abort);
diff --git a/include/hw/pci-host/apb.h b/include/hw/pci-host/apb.h
index 470863639a..2552f3c984 100644
--- a/include/hw/pci-host/apb.h
+++ b/include/hw/pci-host/apb.h
@@ -22,7 +22,7 @@ typedef struct SabrePCIState {
 #define SABRE_PCI_DEVICE(obj) \
     OBJECT_CHECK(SabrePCIState, (obj), TYPE_SABRE_PCI_DEVICE)
 
-typedef struct APBState {
+typedef struct SabreState {
     PCIHostState parent_obj;
 
     hwaddr special_base;
@@ -43,10 +43,10 @@ typedef struct APBState {
     unsigned int irq_request;
     uint32_t reset_control;
     unsigned int nr_resets;
-} APBState;
+} SabreState;
 
-#define TYPE_APB "apb"
-#define APB_DEVICE(obj) \
-    OBJECT_CHECK(APBState, (obj), TYPE_APB)
+#define TYPE_SABRE "sabre"
+#define SABRE_DEVICE(obj) \
+    OBJECT_CHECK(SabreState, (obj), TYPE_SABRE)
 
 #endif
-- 
2.11.0
