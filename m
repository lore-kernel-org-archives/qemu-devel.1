Received: from eggs.gnu.org ([2001:4830:134:3::10]:51602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JK-0003GH-HC
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JE-0008Bs-6X
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:06 -0400
Received: from [185.30.24.106] (port=13464
	helo=hotspot.internet-for-guests.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JD-00088p-3L
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:00 -0400
Date: Tue, 23 Oct 2018 19:41:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181023234112.188140-15-mst@redhat.com>
References: <20181023234112.188140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023234112.188140-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 14/28] x86_iommu/amd: Add interrupt remap
 support when VAPIC is enabled
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

Emulate the interrupt remapping support when guest virtual APIC is
enabled.

For more information refer: IOMMU spec rev 3.0 (section 2.2.5.2)

When VAPIC is enabled, it uses interrupt remapping as defined in
Table 22 and Figure 17 from IOMMU spec.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.h  | 36 +++++++++++++++++++++++
 hw/i386/amd_iommu.c  | 69 +++++++++++++++++++++++++++++++++++++++++++-
 hw/i386/trace-events |  2 ++
 3 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index f73be48fca..8061e9c49c 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -103,6 +103,7 @@
 #define AMDVI_MMIO_CONTROL_EVENTINTEN     (1ULL << 3)
 #define AMDVI_MMIO_CONTROL_COMWAITINTEN   (1ULL << 4)
 #define AMDVI_MMIO_CONTROL_CMDBUFLEN      (1ULL << 12)
+#define AMDVI_MMIO_CONTROL_GAEN           (1ULL << 17)
 
 /* MMIO status register bits */
 #define AMDVI_MMIO_STATUS_CMDBUF_RUN  (1 << 4)
@@ -263,6 +264,38 @@ union irte {
     } fields;
 };
 
+/* Interrupt remapping table fields (Guest VAPIC is enabled) */
+union irte_ga_lo {
+  uint64_t val;
+
+  /* For int remapping */
+  struct {
+      uint64_t  valid:1,
+                no_fault:1,
+                /* ------ */
+                int_type:3,
+                rq_eoi:1,
+                dm:1,
+                /* ------ */
+                guest_mode:1,
+                destination:8,
+                rsvd_1:48;
+  } fields_remap;
+};
+
+union irte_ga_hi {
+  uint64_t val;
+  struct {
+      uint64_t  vector:8,
+                rsvd_2:56;
+  } fields;
+};
+
+struct irte_ga {
+  union irte_ga_lo lo;
+  union irte_ga_hi hi;
+};
+
 #define TYPE_AMD_IOMMU_DEVICE "amd-iommu"
 #define AMD_IOMMU_DEVICE(obj)\
     OBJECT_CHECK(AMDVIState, (obj), TYPE_AMD_IOMMU_DEVICE)
@@ -332,6 +365,9 @@ typedef struct AMDVIState {
 
     /* IOTLB */
     GHashTable *iotlb;
+
+    /* Interrupt remapping */
+    bool ga_enabled;
 } AMDVIState;
 
 #endif
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 8e2f13c029..353a810e6b 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -608,6 +608,7 @@ static void amdvi_handle_control_write(AMDVIState *s)
     s->completion_wait_intr = !!(control & AMDVI_MMIO_CONTROL_COMWAITINTEN);
     s->cmdbuf_enabled = s->enabled && !!(control &
                         AMDVI_MMIO_CONTROL_CMDBUFLEN);
+    s->ga_enabled = !!(control & AMDVI_MMIO_CONTROL_GAEN);
 
     /* update the flags depending on the control register */
     if (s->cmdbuf_enabled) {
@@ -1094,6 +1095,65 @@ static int amdvi_int_remap_legacy(AMDVIState *iommu,
     return 0;
 }
 
+static int amdvi_get_irte_ga(AMDVIState *s, MSIMessage *origin, uint64_t *dte,
+                             struct irte_ga *irte, uint16_t devid)
+{
+    uint64_t irte_root, offset;
+
+    irte_root = dte[2] & AMDVI_IR_PHYS_ADDR_MASK;
+    offset = (origin->data & AMDVI_IRTE_OFFSET) << 4;
+    trace_amdvi_ir_irte(irte_root, offset);
+
+    if (dma_memory_read(&address_space_memory, irte_root + offset,
+                        irte, sizeof(*irte))) {
+        trace_amdvi_ir_err("failed to get irte_ga");
+        return -AMDVI_IR_GET_IRTE;
+    }
+
+    trace_amdvi_ir_irte_ga_val(irte->hi.val, irte->lo.val);
+    return 0;
+}
+
+static int amdvi_int_remap_ga(AMDVIState *iommu,
+                              MSIMessage *origin,
+                              MSIMessage *translated,
+                              uint64_t *dte,
+                              X86IOMMUIrq *irq,
+                              uint16_t sid)
+{
+    int ret;
+    struct irte_ga irte;
+
+    /* get interrupt remapping table */
+    ret = amdvi_get_irte_ga(iommu, origin, dte, &irte, sid);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (!irte.lo.fields_remap.valid) {
+        trace_amdvi_ir_target_abort("RemapEn is disabled");
+        return -AMDVI_IR_TARGET_ABORT;
+    }
+
+    if (irte.lo.fields_remap.guest_mode) {
+        error_report_once("guest mode is not zero");
+        return -AMDVI_IR_ERR;
+    }
+
+    if (irte.lo.fields_remap.int_type > AMDVI_IOAPIC_INT_TYPE_ARBITRATED) {
+        error_report_once("reserved int_type is set");
+        return -AMDVI_IR_ERR;
+    }
+
+    irq->delivery_mode = irte.lo.fields_remap.int_type;
+    irq->vector = irte.hi.fields.vector;
+    irq->dest_mode = irte.lo.fields_remap.dm;
+    irq->redir_hint = irte.lo.fields_remap.rq_eoi;
+    irq->dest = irte.lo.fields_remap.destination;
+
+    return 0;
+}
+
 static int __amdvi_int_remap_msi(AMDVIState *iommu,
                                  MSIMessage *origin,
                                  MSIMessage *translated,
@@ -1101,6 +1161,7 @@ static int __amdvi_int_remap_msi(AMDVIState *iommu,
                                  X86IOMMUIrq *irq,
                                  uint16_t sid)
 {
+    int ret;
     uint8_t int_ctl;
 
     int_ctl = (dte[2] >> AMDVI_IR_INTCTL_SHIFT) & 3;
@@ -1120,7 +1181,13 @@ static int __amdvi_int_remap_msi(AMDVIState *iommu,
         return -AMDVI_IR_ERR;
     }
 
-    return amdvi_int_remap_legacy(iommu, origin, translated, dte, irq, sid);
+    if (iommu->ga_enabled) {
+        ret = amdvi_int_remap_ga(iommu, origin, translated, dte, irq, sid);
+    } else {
+        ret = amdvi_int_remap_legacy(iommu, origin, translated, dte, irq, sid);
+    }
+
+    return ret;
 }
 
 /* Interrupt remapping for MSI/MSI-X entry */
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 98150c93db..6ac347d18c 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -113,6 +113,8 @@ amdvi_ir_intctl(uint8_t val) "int_ctl 0x%"PRIx8
 amdvi_ir_target_abort(const char *str) "%s"
 amdvi_ir_delivery_mode(const char *str) "%s"
 amdvi_ir_generate_msi_message(uint8_t vector, uint8_t delivery_mode, uint8_t dest_mode, uint8_t dest, uint8_t rh) "vector %d delivery-mode %d dest-mode %d dest-id %d rh %d"
+amdvi_ir_irte_ga(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" offset 0x%"PRIx64
+amdvi_ir_irte_ga_val(uint64_t hi, uint64_t lo) "hi 0x%"PRIx64" lo 0x%"PRIx64
 
 # hw/i386/vmport.c
 vmport_register(unsigned char command, void *func, void *opaque) "command: 0x%02x func: %p opaque: %p"
-- 
MST
