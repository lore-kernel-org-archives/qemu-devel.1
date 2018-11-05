Received: from eggs.gnu.org ([2001:4830:134:3::10]:60494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjQg-0007tJ-4r
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjQd-00036Y-G5
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gJjQc-0002te-Sy
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:47 -0500
Date: Mon, 5 Nov 2018 13:16:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181105181353.39804-16-mst@redhat.com>
References: <20181105181353.39804-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105181353.39804-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 15/33] x86_iommu/amd: Prepare for interrupt
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
Cc: Peter Maydell <peter.maydell@linaro.org>, "Singh, Brijesh" <brijesh.singh@amd.com>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

From: "Singh, Brijesh" <brijesh.singh@amd.com>

Register the interrupt remapping callback and read/write ops for the
amd-iommu-ir memory region.

amd-iommu-ir is set to higher priority to ensure that this region won't
be masked out by other memory regions.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.h  |  14 +++++-
 hw/i386/amd_iommu.c  | 106 +++++++++++++++++++++++++++++++++++++++++++
 hw/i386/trace-events |   5 ++
 3 files changed, 123 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 874030582d..4e7cc271c4 100644
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
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 4bec1c6688..9118a75530 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -26,6 +26,7 @@
 #include "amd_iommu.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "hw/i386/apic_internal.h"
 #include "trace.h"
 
 /* used AMD-Vi MMIO registers */
@@ -1031,6 +1032,99 @@ static IOMMUTLBEntry amdvi_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
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
+    if (!iommu || !X86_IOMMU_DEVICE(iommu)->intr_supported) {
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
+        /* TODO: log the event using IOMMU log event interface */
+        error_report_once("failed to remap interrupt from devid 0x%x", sid);
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
     char name[128];
@@ -1066,6 +1160,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
          * |-----------------+-------------------+----------+
          * | amdvi_root      | 00000000-ffffffff |        0 |
          * |  amdvi_iommu    | 00000000-ffffffff |        1 |
+         * |  amdvi_iommu_ir | fee00000-feefffff |       64 |
          * |-----------------+-------------------+----------|
          */
         memory_region_init_iommu(&amdvi_dev_as->iommu,
@@ -1076,6 +1171,13 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
         memory_region_init(&amdvi_dev_as->root, OBJECT(s),
                            "amdvi_root", UINT64_MAX);
         address_space_init(&amdvi_dev_as->as, &amdvi_dev_as->root, name);
+        memory_region_init_io(&amdvi_dev_as->iommu_ir, OBJECT(s),
+                              &amdvi_ir_ops, s, "amd_iommu_ir",
+                              AMDVI_INT_ADDR_SIZE);
+        memory_region_add_subregion_overlap(&amdvi_dev_as->root,
+                                            AMDVI_INT_ADDR_FIRST,
+                                            &amdvi_dev_as->iommu_ir,
+                                            64);
         memory_region_add_subregion_overlap(&amdvi_dev_as->root, 0,
                                             MEMORY_REGION(&amdvi_dev_as->iommu),
                                             1);
@@ -1196,6 +1298,9 @@ static void amdvi_realize(DeviceState *dev, Error **err)
         return;
     }
 
+    /* Pseudo address space under root PCI bus. */
+    pcms->ioapic_as = amdvi_host_dma_iommu(bus, s, AMDVI_IOAPIC_SB_DEVID);
+
     /* set up MMIO */
     memory_region_init_io(&s->mmio, OBJECT(s), &mmio_mem_ops, s, "amdvi-mmio",
                           AMDVI_MMIO_SIZE);
@@ -1229,6 +1334,7 @@ static void amdvi_class_init(ObjectClass *klass, void* data)
     dc->vmsd = &vmstate_amdvi;
     dc->hotpluggable = false;
     dc_class->realize = amdvi_realize;
+    dc_class->int_remap = amdvi_int_remap;
     /* Supported by the pc-q35-* machine types */
     dc->user_creatable = true;
 }
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 9e6fc4dca9..41d533c250 100644
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
MST
