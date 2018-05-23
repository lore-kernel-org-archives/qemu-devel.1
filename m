Received: from eggs.gnu.org ([2001:4830:134:3::10]:44374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fLKI4-0000hE-Uu
	for qemu-devel@nongnu.org; Tue, 22 May 2018 23:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fLKI3-00089Q-DM
	for qemu-devel@nongnu.org; Tue, 22 May 2018 23:18:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60384 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fLKI3-00089I-85
	for qemu-devel@nongnu.org; Tue, 22 May 2018 23:18:15 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 23 May 2018 11:18:05 +0800
Message-Id: <20180523031805.27101-3-peterx@redhat.com>
In-Reply-To: <20180523031805.27101-1-peterx@redhat.com>
References: <20180523031805.27101-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/2] intel-iommu: start to use
 error_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

Replace existing trace_vtd_err() with error_report_once() then stderr
will capture something if any of the error happens, meanwhile we don't
suffer from any DDOS.  Then remove the trace point.  Since at it,
provide more information where proper (now we can pass parameters into
the report function).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 59 ++++++++++++++++++++++++-------------------
 hw/i386/trace-events  |  1 -
 2 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index fb31de9416..fa6df921ee 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -285,14 +285,14 @@ static void vtd_generate_fault_event(IntelIOMMUState *s, uint32_t pre_fsts)
 {
     if (pre_fsts & VTD_FSTS_PPF || pre_fsts & VTD_FSTS_PFO ||
         pre_fsts & VTD_FSTS_IQE) {
-        trace_vtd_err("There are previous interrupt conditions "
-                      "to be serviced by software, fault event "
-                      "is not generated.");
+        error_report_once("There are previous interrupt conditions "
+                          "to be serviced by software, fault event "
+                          "is not generated");
         return;
     }
     vtd_set_clear_mask_long(s, DMAR_FECTL_REG, 0, VTD_FECTL_IP);
     if (vtd_get_long_raw(s, DMAR_FECTL_REG) & VTD_FECTL_IM) {
-        trace_vtd_err("Interrupt Mask set, irq is not generated.");
+        error_report_once("Interrupt Mask set, irq is not generated");
     } else {
         vtd_generate_interrupt(s, DMAR_FEADDR_REG, DMAR_FEDATA_REG);
         vtd_set_clear_mask_long(s, DMAR_FECTL_REG, VTD_FECTL_IP, 0);
@@ -400,20 +400,20 @@ static void vtd_report_dmar_fault(IntelIOMMUState *s, uint16_t source_id,
     trace_vtd_dmar_fault(source_id, fault, addr, is_write);
 
     if (fsts_reg & VTD_FSTS_PFO) {
-        trace_vtd_err("New fault is not recorded due to "
-                      "Primary Fault Overflow.");
+        error_report_once("New fault is not recorded due to "
+                          "Primary Fault Overflow");
         return;
     }
 
     if (vtd_try_collapse_fault(s, source_id)) {
-        trace_vtd_err("New fault is not recorded due to "
-                      "compression of faults.");
+        error_report_once("New fault is not recorded due to "
+                          "compression of faults");
         return;
     }
 
     if (vtd_is_frcd_set(s, s->next_frcd_reg)) {
-        trace_vtd_err("Next Fault Recording Reg is used, "
-                      "new fault is not recorded, set PFO field.");
+        error_report_once("Next Fault Recording Reg is used, "
+                          "new fault is not recorded, set PFO field");
         vtd_set_clear_mask_long(s, DMAR_FSTS_REG, 0, VTD_FSTS_PFO);
         return;
     }
@@ -421,8 +421,8 @@ static void vtd_report_dmar_fault(IntelIOMMUState *s, uint16_t source_id,
     vtd_record_frcd(s, s->next_frcd_reg, source_id, addr, fault, is_write);
 
     if (fsts_reg & VTD_FSTS_PPF) {
-        trace_vtd_err("There are pending faults already, "
-                      "fault event is not generated.");
+        error_report_once("There are pending faults already, "
+                          "fault event is not generated");
         vtd_set_frcd_and_update_ppf(s, s->next_frcd_reg);
         s->next_frcd_reg++;
         if (s->next_frcd_reg == DMAR_FRCD_REG_NR) {
@@ -1339,7 +1339,8 @@ static uint64_t vtd_context_cache_invalidate(IntelIOMMUState *s, uint64_t val)
         break;
 
     default:
-        trace_vtd_err("Context cache invalidate type error.");
+        error_report_once("%s: invalid context: 0x%"PRIx64,
+                          __func__, val);
         caig = 0;
     }
     return caig;
@@ -1445,7 +1446,8 @@ static uint64_t vtd_iotlb_flush(IntelIOMMUState *s, uint64_t val)
         am = VTD_IVA_AM(addr);
         addr = VTD_IVA_ADDR(addr);
         if (am > VTD_MAMV) {
-            trace_vtd_err("IOTLB PSI flush: address mask overflow.");
+            error_report_once("%s: address mask overflow: 0x%"PRIx64,
+                              __func__, vtd_get_quad_raw(s, DMAR_IVA_REG));
             iaig = 0;
             break;
         }
@@ -1454,7 +1456,8 @@ static uint64_t vtd_iotlb_flush(IntelIOMMUState *s, uint64_t val)
         break;
 
     default:
-        trace_vtd_err("IOTLB flush: invalid granularity.");
+        error_report_once("%s: invalid granularity: 0x%"PRIx64,
+                          __func__, val);
         iaig = 0;
     }
     return iaig;
@@ -1604,8 +1607,8 @@ static void vtd_handle_ccmd_write(IntelIOMMUState *s)
     /* Context-cache invalidation request */
     if (val & VTD_CCMD_ICC) {
         if (s->qi_enabled) {
-            trace_vtd_err("Queued Invalidation enabled, "
-                          "should not use register-based invalidation");
+            error_report_once("Queued Invalidation enabled, "
+                              "should not use register-based invalidation");
             return;
         }
         ret = vtd_context_cache_invalidate(s, val);
@@ -1625,8 +1628,8 @@ static void vtd_handle_iotlb_write(IntelIOMMUState *s)
     /* IOTLB invalidation request */
     if (val & VTD_TLB_IVT) {
         if (s->qi_enabled) {
-            trace_vtd_err("Queued Invalidation enabled, "
-                          "should not use register-based invalidation.");
+            error_report_once("Queued Invalidation enabled, "
+                              "should not use register-based invalidation");
             return;
         }
         ret = vtd_iotlb_flush(s, val);
@@ -1644,7 +1647,7 @@ static bool vtd_get_inv_desc(dma_addr_t base_addr, uint32_t offset,
     dma_addr_t addr = base_addr + offset * sizeof(*inv_desc);
     if (dma_memory_read(&address_space_memory, addr, inv_desc,
         sizeof(*inv_desc))) {
-        trace_vtd_err("Read INV DESC failed.");
+        error_report_once("Read INV DESC failed");
         inv_desc->lo = 0;
         inv_desc->hi = 0;
         return false;
@@ -1999,7 +2002,8 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
     trace_vtd_reg_read(addr, size);
 
     if (addr + size > DMAR_REG_SIZE) {
-        trace_vtd_err("Read MMIO over range.");
+        error_report_once("%s: MMIO over range: addr=0x%"PRIx64
+                          " size=0x%u", __func__, addr, size);
         return (uint64_t)-1;
     }
 
@@ -2050,7 +2054,8 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
     trace_vtd_reg_write(addr, size, val);
 
     if (addr + size > DMAR_REG_SIZE) {
-        trace_vtd_err("Write MMIO over range.");
+        error_report_once("%s: MMIO over range: addr=0x%"PRIx64
+                          " size=0x%u", __func__, addr, size);
         return;
     }
 
@@ -2432,7 +2437,8 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
     addr = iommu->intr_root + index * sizeof(*entry);
     if (dma_memory_read(&address_space_memory, addr, entry,
                         sizeof(*entry))) {
-        trace_vtd_err("Memory read failed for IRTE.");
+        error_report_once("%s: read failed: ind=0x%"PRIu16
+                          " addr=0x%"PRIx64, __func__, index, addr);
         return -VTD_FR_IR_ROOT_INVAL;
     }
 
@@ -2564,14 +2570,15 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState *iommu,
     }
 
     if (origin->address & VTD_MSI_ADDR_HI_MASK) {
-        trace_vtd_err("MSI address high 32 bits non-zero when "
-                      "Interrupt Remapping enabled.");
+        error_report_once("%s: MSI address high 32 bits non-zero detected: "
+                          "address=0x%"PRIx64, __func__, origin->address);
         return -VTD_FR_IR_REQ_RSVD;
     }
 
     addr.data = origin->address & VTD_MSI_ADDR_LO_MASK;
     if (addr.addr.__head != 0xfee) {
-        trace_vtd_err("MSI addr low 32 bit invalid.");
+        error_report_once("%s: MSI address low 32 bit invalid: 0x%"PRIx32,
+                          __func__, addr.data);
         return -VTD_FR_IR_REQ_RSVD;
     }
 
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 22d44648af..e08cf2a9a7 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -68,7 +68,6 @@ vtd_ir_remap_msi_req(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" data 0x%"PR
 vtd_fsts_ppf(bool set) "FSTS PPF bit set to %d"
 vtd_fsts_clear_ip(void) ""
 vtd_frr_new(int index, uint64_t hi, uint64_t lo) "index %d high 0x%"PRIx64" low 0x%"PRIx64
-vtd_err(const char *str) "%s"
 vtd_err_dmar_iova_overflow(uint64_t iova) "iova 0x%"PRIx64
 vtd_err_dmar_slpte_read_error(uint64_t iova, int level) "iova 0x%"PRIx64" level %d"
 vtd_err_dmar_slpte_perm_error(uint64_t iova, int level, uint64_t slpte, bool is_write) "iova 0x%"PRIx64" level %d slpte 0x%"PRIx64" write %d"
-- 
2.17.0
