Received: from eggs.gnu.org ([2001:4830:134:3::10]:35636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g0soY-0008Oy-Pm
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 14:27:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g0soV-0003hb-Gr
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 14:27:34 -0400
Received: from mail-eopbgr690086.outbound.protection.outlook.com
	([40.107.69.86]:22784
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1g0soV-0003fI-3c
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 14:27:31 -0400
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Fri, 14 Sep 2018 13:26:59 -0500
Message-Id: <1536949623-23564-5-git-send-email-brijesh.singh@amd.com>
In-Reply-To: <1536949623-23564-1-git-send-email-brijesh.singh@amd.com>
References: <1536949623-23564-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 4/8] x86_iommu/amd: Prepare for interrupt
 remap support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Register the interrupt remapping callback and read/write ops for the
amd-iommu-ir memory region.

amd-iommu-ir is set to higher priority to ensure that this region won't
be masked out by other memory regions.

While at it, add a overlapping amd-iommu region with higher priority
and update address space name to include the devfn.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 hw/i386/amd_iommu.c  | 140 ++++++++++++++++++++++++++++++++++++++++++++++++---
 hw/i386/amd_iommu.h  |  17 ++++++-
 hw/i386/trace-events |   5 ++
 3 files changed, 154 insertions(+), 8 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 225825e..b15962b 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -26,6 +26,7 @@
 #include "amd_iommu.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "hw/i386/apic_internal.h"
 #include "trace.h"
 
 /* used AMD-Vi MMIO registers */
@@ -56,6 +57,7 @@ struct AMDVIAddressSpace {
     uint8_t devfn;              /* device function                      */
     AMDVIState *iommu_state;    /* AMDVI - one per machine              */
     IOMMUMemoryRegion iommu;    /* Device's address translation region  */
+    MemoryRegion root;          /* AMDVI Root memory map region */
     MemoryRegion iommu_ir;      /* Device's interrupt remapping region  */
     AddressSpace as;            /* device's corresponding address space */
 };
@@ -1027,10 +1029,104 @@ static IOMMUTLBEntry amdvi_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
     return ret;
 }
 
+/* Interrupt remapping for MSI/MSI-X entry */
+static int amdvi_int_remap_msi(AMDVIState *iommu,
+                               MSIMessage *origin,
+                               MSIMessage *translated,
+                               uint16_t sid)
+{
+    assert(origin && translated);
+
+    trace_amdvi_ir_remap_msi_req(origin->address, origin->data, sid);
+
+    if (!iommu || !iommu->intr_enabled) {
+        memcpy(translated, origin, sizeof(*origin));
+        goto out;
+    }
+
+    if (origin->address & AMDVI_MSI_ADDR_HI_MASK) {
+        trace_amdvi_err("MSI address high 32 bits non-zero when "
+                        "Interrupt Remapping enabled.");
+        return -AMDVI_IR_ERR;
+    }
+
+    if ((origin->address & AMDVI_MSI_ADDR_LO_MASK) != APIC_DEFAULT_ADDRESS) {
+        trace_amdvi_err("MSI is not from IOAPIC.");
+        return -AMDVI_IR_ERR;
+    }
+
+out:
+    trace_amdvi_ir_remap_msi(origin->address, origin->data,
+                             translated->address, translated->data);
+    return 0;
+}
+
+static int amdvi_int_remap(X86IOMMUState *iommu,
+                           MSIMessage *origin,
+                           MSIMessage *translated,
+                           uint16_t sid)
+{
+    return amdvi_int_remap_msi(AMD_IOMMU_DEVICE(iommu), origin,
+                               translated, sid);
+}
+
+static MemTxResult amdvi_mem_ir_write(void *opaque, hwaddr addr,
+                                      uint64_t value, unsigned size,
+                                      MemTxAttrs attrs)
+{
+    int ret;
+    MSIMessage from = { 0, 0 }, to = { 0, 0 };
+    uint16_t sid = AMDVI_IOAPIC_SB_DEVID;
+
+    from.address = (uint64_t) addr + AMDVI_INT_ADDR_FIRST;
+    from.data = (uint32_t) value;
+
+    trace_amdvi_mem_ir_write_req(addr, value, size);
+
+    if (!attrs.unspecified) {
+        /* We have explicit Source ID */
+        sid = attrs.requester_id;
+    }
+
+    ret = amdvi_int_remap_msi(opaque, &from, &to, sid);
+    if (ret < 0) {
+        /* TODO: report error */
+        /* Drop the interrupt */
+        return MEMTX_ERROR;
+    }
+
+    apic_get_class()->send_msi(&to);
+
+    trace_amdvi_mem_ir_write(to.address, to.data);
+    return MEMTX_OK;
+}
+
+static MemTxResult amdvi_mem_ir_read(void *opaque, hwaddr addr,
+                                     uint64_t *data, unsigned size,
+                                     MemTxAttrs attrs)
+{
+    return MEMTX_OK;
+}
+
+static const MemoryRegionOps amdvi_ir_ops = {
+    .read_with_attrs = amdvi_mem_ir_read,
+    .write_with_attrs = amdvi_mem_ir_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    }
+};
+
 static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 {
+    char name[128];
     AMDVIState *s = opaque;
-    AMDVIAddressSpace **iommu_as;
+    AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
     int bus_num = pci_bus_num(bus);
 
     iommu_as = s->address_spaces[bus_num];
@@ -1043,19 +1139,46 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 
     /* set up AMD-Vi region */
     if (!iommu_as[devfn]) {
+        snprintf(name, sizeof(name), "amd_iommu_devfn_%d", devfn);
+
         iommu_as[devfn] = g_malloc0(sizeof(AMDVIAddressSpace));
         iommu_as[devfn]->bus_num = (uint8_t)bus_num;
         iommu_as[devfn]->devfn = (uint8_t)devfn;
         iommu_as[devfn]->iommu_state = s;
 
-        memory_region_init_iommu(&iommu_as[devfn]->iommu,
-                                 sizeof(iommu_as[devfn]->iommu),
+        amdvi_dev_as = iommu_as[devfn];
+
+        /*
+         * Memory region relationships looks like (Address range shows
+         * only lower 32 bits to make it short in length...):
+         *
+         * |-----------------+-------------------+----------|
+         * | Name            | Address range     | Priority |
+         * |-----------------+-------------------+----------+
+         * | amdvi_root      | 00000000-ffffffff |        0 |
+         * |  amdvi_iommu    | 00000000-ffffffff |        1 |
+         * |  amdvi_iommu_ir | fee00000-feefffff |       64 |
+         * |-----------------+-------------------+----------|
+         */
+        memory_region_init_iommu(&amdvi_dev_as->iommu,
+                                 sizeof(amdvi_dev_as->iommu),
                                  TYPE_AMD_IOMMU_MEMORY_REGION,
                                  OBJECT(s),
                                  "amd-iommu", UINT64_MAX);
-        address_space_init(&iommu_as[devfn]->as,
-                           MEMORY_REGION(&iommu_as[devfn]->iommu),
-                           "amd-iommu");
+        memory_region_init(&amdvi_dev_as->root, OBJECT(s),
+                           "amdvi_root", UINT64_MAX);
+        address_space_init(&amdvi_dev_as->as, &amdvi_dev_as->root, name);
+        memory_region_init_io(&amdvi_dev_as->iommu_ir, OBJECT(s),
+                              &amdvi_ir_ops, s, "amd-iommu-ir",
+                              AMDVI_INT_ADDR_SIZE);
+        memory_region_add_subregion_overlap(&amdvi_dev_as->root,
+                                            AMDVI_INT_ADDR_FIRST,
+                                            &amdvi_dev_as->iommu_ir,
+                                            64);
+        memory_region_add_subregion_overlap(&amdvi_dev_as->root, 0,
+                                            MEMORY_REGION(&amdvi_dev_as->iommu),
+                                            1);
+
     }
     return &iommu_as[devfn]->as;
 }
@@ -1173,6 +1296,10 @@ static void amdvi_realize(DeviceState *dev, Error **err)
         return;
     }
 
+    /* Pseudo address space under root PCI bus. */
+    pcms->ioapic_as = amdvi_host_dma_iommu(bus, s, AMDVI_IOAPIC_SB_DEVID);
+    s->intr_enabled = x86_iommu->intr_supported;
+
     /* set up MMIO */
     memory_region_init_io(&s->mmio, OBJECT(s), &mmio_mem_ops, s, "amdvi-mmio",
                           AMDVI_MMIO_SIZE);
@@ -1206,6 +1333,7 @@ static void amdvi_class_init(ObjectClass *klass, void* data)
     dc->vmsd = &vmstate_amdvi;
     dc->hotpluggable = false;
     dc_class->realize = amdvi_realize;
+    dc_class->int_remap = amdvi_int_remap;
     /* Supported by the pc-q35-* machine types */
     dc->user_creatable = true;
 }
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 8740305..71ff3c1 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -206,8 +206,18 @@
 
 #define AMDVI_COMMAND_SIZE   16
 
-#define AMDVI_INT_ADDR_FIRST 0xfee00000
-#define AMDVI_INT_ADDR_LAST  0xfeefffff
+#define AMDVI_INT_ADDR_FIRST    0xfee00000
+#define AMDVI_INT_ADDR_LAST     0xfeefffff
+#define AMDVI_INT_ADDR_SIZE     (AMDVI_INT_ADDR_LAST - AMDVI_INT_ADDR_FIRST + 1)
+#define AMDVI_MSI_ADDR_HI_MASK  (0xffffffff00000000ULL)
+#define AMDVI_MSI_ADDR_LO_MASK  (0x00000000ffffffffULL)
+
+/* SB IOAPIC is always on this device in AMD systems */
+#define AMDVI_IOAPIC_SB_DEVID   PCI_BUILD_BDF(0, PCI_DEVFN(0x14, 0))
+
+/* Interrupt remapping errors */
+#define AMDVI_IR_ERR            0x1
+
 
 #define TYPE_AMD_IOMMU_DEVICE "amd-iommu"
 #define AMD_IOMMU_DEVICE(obj)\
@@ -278,6 +288,9 @@ typedef struct AMDVIState {
 
     /* IOTLB */
     GHashTable *iotlb;
+
+    /* Interrupt remapping */
+    bool intr_enabled;
 } AMDVIState;
 
 #endif
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 9e6fc4d..41d533c 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -101,6 +101,11 @@ amdvi_mode_invalid(uint8_t level, uint64_t addr)"error: translation level 0x%"PR
 amdvi_page_fault(uint64_t addr) "error: page fault accessing guest physical address 0x%"PRIx64
 amdvi_iotlb_hit(uint8_t bus, uint8_t slot, uint8_t func, uint64_t addr, uint64_t txaddr) "hit iotlb devid %02x:%02x.%x gpa 0x%"PRIx64" hpa 0x%"PRIx64
 amdvi_translation_result(uint8_t bus, uint8_t slot, uint8_t func, uint64_t addr, uint64_t txaddr) "devid: %02x:%02x.%x gpa 0x%"PRIx64" hpa 0x%"PRIx64
+amdvi_mem_ir_write_req(uint64_t addr, uint64_t val, uint32_t size) "addr 0x%"PRIx64" data 0x%"PRIx64" size 0x%"PRIx32
+amdvi_mem_ir_write(uint64_t addr, uint64_t val) "addr 0x%"PRIx64" data 0x%"PRIx64
+amdvi_ir_remap_msi_req(uint64_t addr, uint64_t data, uint8_t devid) "addr 0x%"PRIx64" data 0x%"PRIx64" devid 0x%"PRIx8
+amdvi_ir_remap_msi(uint64_t addr, uint64_t data, uint64_t addr2, uint64_t data2) "(addr 0x%"PRIx64", data 0x%"PRIx64") -> (addr 0x%"PRIx64", data 0x%"PRIx64")"
+amdvi_err(const char *str) "%s"
 
 # hw/i386/vmport.c
 vmport_register(unsigned char command, void *func, void *opaque) "command: 0x%02x func: %p opaque: %p"
-- 
2.7.4
