Received: from eggs.gnu.org ([2001:4830:134:3::10]:54284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1fzm6z-00082a-KL
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 13:06:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1fzlre-0002gx-CC
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 12:50:14 -0400
Received: from mail-eopbgr730079.outbound.protection.outlook.com
	([40.107.73.79]:55072
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1fzlre-0002dH-4Z
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 12:50:10 -0400
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Tue, 11 Sep 2018 11:49:45 -0500
Message-Id: <1536684589-11718-3-git-send-email-brijesh.singh@amd.com>
In-Reply-To: <1536684589-11718-1-git-send-email-brijesh.singh@amd.com>
References: <1536684589-11718-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/6] x86_iommu/amd: Prepare for interrupt remap
 support
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

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 hw/i386/amd_iommu.c  | 107 +++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/amd_iommu.h  |  17 +++++++-
 hw/i386/trace-events |   5 +++
 3 files changed, 127 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 1fd669f..572ba0a 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -26,6 +26,7 @@
 #include "amd_iommu.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "hw/i386/apic_internal.h"
 #include "trace.h"
 
 /* used AMD-Vi MMIO registers */
@@ -1026,6 +1027,101 @@ static IOMMUTLBEntry amdvi_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
     return ret;
 }
 
+/* Interrupt remapping for MSI/MSI-X entry */
+static int amdvi_int_remap_msi(AMDVIState *iommu,
+                               MSIMessage *origin,
+                               MSIMessage *translated,
+                               uint16_t sid)
+{
+    int ret;
+
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
+    uint16_t sid = AMDVI_SB_IOAPIC_ID;
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
     AMDVIState *s = opaque;
@@ -1055,6 +1151,12 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
         address_space_init(&iommu_as[devfn]->as,
                            MEMORY_REGION(&iommu_as[devfn]->iommu),
                            "amd-iommu");
+        memory_region_init_io(&iommu_as[devfn]->iommu_ir, OBJECT(s),
+                              &amdvi_ir_ops, s, "amd-iommu-ir",
+                              AMDVI_INT_ADDR_SIZE);
+        memory_region_add_subregion(MEMORY_REGION(&iommu_as[devfn]->iommu),
+                              AMDVI_INT_ADDR_FIRST,
+                              &iommu_as[devfn]->iommu_ir);
     }
     return &iommu_as[devfn]->as;
 }
@@ -1172,6 +1274,10 @@ static void amdvi_realize(DeviceState *dev, Error **err)
         return;
     }
 
+    /* Pseudo address space under root PCI bus. */
+    pcms->ioapic_as = amdvi_host_dma_iommu(bus, s, AMDVI_SB_IOAPIC_ID);
+    s->intr_enabled = x86_iommu->intr_supported;
+
     /* set up MMIO */
     memory_region_init_io(&s->mmio, OBJECT(s), &mmio_mem_ops, s, "amdvi-mmio",
                           AMDVI_MMIO_SIZE);
@@ -1205,6 +1311,7 @@ static void amdvi_class_init(ObjectClass *klass, void* data)
     dc->vmsd = &vmstate_amdvi;
     dc->hotpluggable = false;
     dc_class->realize = amdvi_realize;
+    dc_class->int_remap = amdvi_int_remap;
     /* Supported by the pc-q35-* machine types */
     dc->user_creatable = true;
 }
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 8740305..74e568b 100644
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
+/* Southbridge IOAPIC ID */
+#define AMDVI_SB_IOAPIC_ID      0xa0
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
