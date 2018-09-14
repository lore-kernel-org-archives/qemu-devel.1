Received: from eggs.gnu.org ([2001:4830:134:3::10]:35638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g0soY-0008P0-QQ
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 14:27:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1g0soW-0003iS-06
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 14:27:34 -0400
Received: from mail-eopbgr690086.outbound.protection.outlook.com
	([40.107.69.86]:22784
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1g0soV-0003fI-OT
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 14:27:31 -0400
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Fri, 14 Sep 2018 13:27:00 -0500
Message-Id: <1536949623-23564-6-git-send-email-brijesh.singh@amd.com>
In-Reply-To: <1536949623-23564-1-git-send-email-brijesh.singh@amd.com>
References: <1536949623-23564-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 5/8] x86_iommu/amd: Add interrupt remap
 support when VAPIC is not enabled
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

Emulate the interrupt remapping support when guest virtual APIC is
not enabled.

For more info Refer: AMD IOMMU spec Rev 3.0 - section 2.2.5.1

When VAPIC is not enabled, it uses interrupt remapping as defined in
Table 20 and Figure 15 from IOMMU spec.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 hw/i386/amd_iommu.c  | 189 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/i386/amd_iommu.h  |  46 ++++++++++++-
 hw/i386/trace-events |   7 ++
 3 files changed, 240 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index b15962b..9c8e4de 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -28,6 +28,8 @@
 #include "qemu/error-report.h"
 #include "hw/i386/apic_internal.h"
 #include "trace.h"
+#include "cpu.h"
+#include "hw/i386/apic-msidef.h"
 
 /* used AMD-Vi MMIO registers */
 const char *amdvi_mmio_low[] = {
@@ -1029,17 +1031,144 @@ static IOMMUTLBEntry amdvi_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
     return ret;
 }
 
+static int amdvi_get_irte(AMDVIState *s, MSIMessage *origin, uint64_t *dte,
+                          union irte *irte, uint16_t devid)
+{
+    uint64_t irte_root, offset;
+
+    irte_root = dte[2] & AMDVI_IR_PHYS_ADDR_MASK;
+    offset = (origin->data & AMDVI_IRTE_OFFSET) << 2;
+
+    trace_amdvi_ir_irte(irte_root, offset);
+
+    if (dma_memory_read(&address_space_memory, irte_root + offset,
+                        irte, sizeof(*irte))) {
+        trace_amdvi_ir_err("failed to get irte");
+        return -AMDVI_IR_GET_IRTE;
+    }
+
+    trace_amdvi_ir_irte_val(irte->val);
+
+    return 0;
+}
+
+static int amdvi_int_remap_legacy(AMDVIState *iommu,
+                                  MSIMessage *origin,
+                                  MSIMessage *translated,
+                                  uint64_t *dte,
+                                  X86IOMMUIrq *irq,
+                                  uint16_t sid)
+{
+    int ret;
+    union irte irte;
+
+    /* get interrupt remapping table */
+    ret = amdvi_get_irte(iommu, origin, dte, &irte, sid);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (!irte.fields.valid) {
+        trace_amdvi_ir_target_abort("RemapEn is disabled");
+        return -AMDVI_IR_TARGET_ABORT;
+    }
+
+    if (irte.fields.guest_mode) {
+        trace_amdvi_ir_target_abort("guest mode is not zero");
+        return -AMDVI_IR_TARGET_ABORT;
+    }
+
+    if (irte.fields.int_type > AMDVI_IOAPIC_INT_TYPE_ARBITRATED) {
+        trace_amdvi_ir_target_abort("reserved int_type");
+        return -AMDVI_IR_TARGET_ABORT;
+    }
+
+    irq->delivery_mode = irte.fields.int_type;
+    irq->vector = irte.fields.vector;
+    irq->dest_mode = irte.fields.dm;
+    irq->redir_hint = irte.fields.rq_eoi;
+    irq->dest = irte.fields.destination;
+
+    return 0;
+}
+
+static int __amdvi_int_remap_msi(AMDVIState *iommu,
+                                 MSIMessage *origin,
+                                 MSIMessage *translated,
+                                 uint64_t *dte,
+                                 X86IOMMUIrq *irq,
+                                 uint16_t sid)
+{
+    uint8_t int_ctl;
+
+    int_ctl = (dte[2] >> AMDVI_IR_INTCTL_SHIFT) & 3;
+    trace_amdvi_ir_intctl(int_ctl);
+
+    switch (int_ctl) {
+    case AMDVI_IR_INTCTL_PASS:
+        memcpy(translated, origin, sizeof(*origin));
+        return 0;
+    case AMDVI_IR_INTCTL_REMAP:
+        break;
+    case AMDVI_IR_INTCTL_ABORT:
+        trace_amdvi_ir_target_abort("int_ctl abort");
+        return -AMDVI_IR_TARGET_ABORT;
+    default:
+        trace_amdvi_ir_target_abort("int_ctl reserved");
+        return -AMDVI_IR_TARGET_ABORT;
+    }
+
+    return amdvi_int_remap_legacy(iommu, origin, translated, dte, irq, sid);
+}
+
+static bool amdvi_validate_int_reamp(AMDVIState *s, uint64_t *dte)
+{
+    /* Check if IR is enabled in DTE */
+    if (!(dte[2] & AMDVI_IR_REMAP_ENABLE)) {
+        return false;
+    }
+
+    /* validate that we are configure with intremap=on */
+    if (!s->intr_enabled) {
+        error_report("Interrupt remapping is enabled in the guest but "
+                     "not in the host. Use intremap=on to enable interrupt "
+                     "remapping in amd-iommu.");
+        exit(1);
+    }
+
+    return true;
+}
+
 /* Interrupt remapping for MSI/MSI-X entry */
 static int amdvi_int_remap_msi(AMDVIState *iommu,
                                MSIMessage *origin,
                                MSIMessage *translated,
                                uint16_t sid)
 {
+    int ret = 0;
+    uint64_t pass = 0;
+    uint64_t dte[4] = { 0 };
+    X86IOMMUIrq irq = { 0 };
+    uint8_t dest_mode, delivery_mode;
+
     assert(origin && translated);
 
+    /*
+     * When IOMMU is enabled, interrupt remap request will come either from
+     * IO-APIC or PCI device. If interrupt is from PCI device then it will
+     * have a valid requester id but if the interrupt is from IO-APIC
+     * then requester id will be invalid.
+     */
+    if (sid == X86_IOMMU_SID_INVALID) {
+        sid = AMDVI_IOAPIC_SB_DEVID;
+    }
+
     trace_amdvi_ir_remap_msi_req(origin->address, origin->data, sid);
 
-    if (!iommu || !iommu->intr_enabled) {
+    /* verify that interrupt remapping is enabled before going further. */
+    if (!iommu ||
+        !amdvi_get_dte(iommu, sid, dte)  ||
+        !amdvi_validate_int_reamp(iommu, dte)) {
         memcpy(translated, origin, sizeof(*origin));
         goto out;
     }
@@ -1055,10 +1184,68 @@ static int amdvi_int_remap_msi(AMDVIState *iommu,
         return -AMDVI_IR_ERR;
     }
 
+    delivery_mode = (origin->data >> MSI_DATA_DELIVERY_MODE_SHIFT) & 7;
+
+    switch (delivery_mode) {
+    case AMDVI_IOAPIC_INT_TYPE_FIXED:
+    case AMDVI_IOAPIC_INT_TYPE_ARBITRATED:
+        trace_amdvi_ir_delivery_mode("fixed/arbitrated");
+        ret = __amdvi_int_remap_msi(iommu, origin, translated, dte, &irq, sid);
+        if (ret < 0) {
+            goto remap_fail;
+        } else {
+            /* Translate IRQ to MSI messages */
+            x86_iommu_irq_to_msi_message(&irq, translated);
+            goto out;
+        }
+        break;
+    case AMDVI_IOAPIC_INT_TYPE_SMI:
+        error_report("SMI is not supported!");
+        ret = -AMDVI_IR_ERR;
+    case AMDVI_IOAPIC_INT_TYPE_NMI:
+        pass = dte[3] & AMDVI_DEV_NMI_PASS_MASK;
+        trace_amdvi_ir_delivery_mode("nmi");
+        break;
+    case AMDVI_IOAPIC_INT_TYPE_INIT:
+        pass = dte[3] & AMDVI_DEV_INT_PASS_MASK;
+        trace_amdvi_ir_delivery_mode("init");
+        break;
+    case AMDVI_IOAPIC_INT_TYPE_EINT:
+        pass = dte[3] & AMDVI_DEV_EINT_PASS_MASK;
+        trace_amdvi_ir_delivery_mode("eint");
+        break;
+    default:
+        trace_amdvi_ir_delivery_mode("unsupported delivery_mode");
+        ret = -AMDVI_IR_ERR;
+        break;
+    }
+
+    if (ret < 0) {
+        goto remap_fail;
+    }
+
+    /* dest_mode 1 is valid for fixed and arbitrated interrupts only */
+    dest_mode = (origin->address >> MSI_ADDR_DEST_MODE_SHIFT) & 1;
+    if (dest_mode) {
+        trace_amdvi_ir_err("invalid dest_mode");
+        goto remap_fail;
+    }
+
+    if (pass) {
+        memcpy(translated, origin, sizeof(*origin));
+    } else {
+        /* pass through is not enabled */
+        trace_amdvi_ir_err("passthrough is not enabled");
+        goto remap_fail;
+    }
+
 out:
     trace_amdvi_ir_remap_msi(origin->address, origin->data,
                              translated->address, translated->data);
     return 0;
+
+remap_fail:
+    return -AMDVI_IR_TARGET_ABORT;
 }
 
 static int amdvi_int_remap(X86IOMMUState *iommu,
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 71ff3c1..bd27cd2 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -217,7 +217,51 @@
 
 /* Interrupt remapping errors */
 #define AMDVI_IR_ERR            0x1
-
+#define AMDVI_IR_GET_IRTE       0x2
+#define AMDVI_IR_TARGET_ABORT   0x3
+
+/* Interrupt remapping */
+#define AMDVI_IR_REMAP_ENABLE           1ULL
+#define AMDVI_IR_INTCTL_SHIFT           60
+#define AMDVI_IR_INTCTL_ABORT           0
+#define AMDVI_IR_INTCTL_PASS            1
+#define AMDVI_IR_INTCTL_REMAP           2
+
+#define AMDVI_IR_PHYS_ADDR_MASK         (((1ULL << 45) - 1) << 6)
+
+/* MSI data 10:0 bits (section 2.2.5.1 Fig 14) */
+#define AMDVI_IRTE_OFFSET               0x7ff
+
+/* Delivery mode of MSI data (same as IOAPIC deilver mode encoding) */
+#define AMDVI_IOAPIC_INT_TYPE_FIXED          0x0
+#define AMDVI_IOAPIC_INT_TYPE_ARBITRATED     0x1
+#define AMDVI_IOAPIC_INT_TYPE_SMI            0x2
+#define AMDVI_IOAPIC_INT_TYPE_NMI            0x4
+#define AMDVI_IOAPIC_INT_TYPE_INIT           0x5
+#define AMDVI_IOAPIC_INT_TYPE_EINT           0x7
+
+/* Pass through interrupt */
+#define AMDVI_DEV_INT_PASS_MASK         (1UL << 56)
+#define AMDVI_DEV_EINT_PASS_MASK        (1UL << 57)
+#define AMDVI_DEV_NMI_PASS_MASK         (1UL << 58)
+#define AMDVI_DEV_LINT0_PASS_MASK       (1UL << 62)
+#define AMDVI_DEV_LINT1_PASS_MASK       (1UL << 63)
+
+/* Interrupt remapping table fields (Guest VAPIC not enabled) */
+union irte {
+    uint32_t val;
+    struct {
+        uint32_t valid:1,
+                 no_fault:1,
+                 int_type:3,
+                 rq_eoi:1,
+                 dm:1,
+                 guest_mode:1,
+                 destination:8,
+                 vector:8,
+                 rsvd:8;
+    } fields;
+};
 
 #define TYPE_AMD_IOMMU_DEVICE "amd-iommu"
 #define AMD_IOMMU_DEVICE(obj)\
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 41d533c..98150c9 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -106,6 +106,13 @@ amdvi_mem_ir_write(uint64_t addr, uint64_t val) "addr 0x%"PRIx64" data 0x%"PRIx6
 amdvi_ir_remap_msi_req(uint64_t addr, uint64_t data, uint8_t devid) "addr 0x%"PRIx64" data 0x%"PRIx64" devid 0x%"PRIx8
 amdvi_ir_remap_msi(uint64_t addr, uint64_t data, uint64_t addr2, uint64_t data2) "(addr 0x%"PRIx64", data 0x%"PRIx64") -> (addr 0x%"PRIx64", data 0x%"PRIx64")"
 amdvi_err(const char *str) "%s"
+amdvi_ir_irte(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" offset 0x%"PRIx64
+amdvi_ir_irte_val(uint32_t data) "data 0x%"PRIx32
+amdvi_ir_err(const char *str) "%s"
+amdvi_ir_intctl(uint8_t val) "int_ctl 0x%"PRIx8
+amdvi_ir_target_abort(const char *str) "%s"
+amdvi_ir_delivery_mode(const char *str) "%s"
+amdvi_ir_generate_msi_message(uint8_t vector, uint8_t delivery_mode, uint8_t dest_mode, uint8_t dest, uint8_t rh) "vector %d delivery-mode %d dest-mode %d dest-id %d rh %d"
 
 # hw/i386/vmport.c
 vmport_register(unsigned char command, void *func, void *opaque) "command: 0x%02x func: %p opaque: %p"
-- 
2.7.4
