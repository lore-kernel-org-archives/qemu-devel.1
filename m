Received: from eggs.gnu.org ([2001:4830:134:3::10]:48695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cUYwc-0001YW-2h
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:09:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cUYwX-0002Rj-1j
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:09:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cUYwW-0002RR-Oi
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:09:24 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri, 20 Jan 2017 21:08:43 +0800
Message-Id: <1484917736-32056-8-git-send-email-peterx@redhat.com>
In-Reply-To: <1484917736-32056-1-git-send-email-peterx@redhat.com>
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v4 07/20] intel_iommu: fix trace for inv
 desc handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, peterx@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com

VT-d codes are still using static DEBUG_INTEL_IOMMU macro. That's not
good, and we should end the day when we need to recompile the code
before getting useful debugging information for vt-d. Time to switch to
the trace system.

This is the first patch to do it.

Generally, the rule of mine is:

- for the old GENERAL typed message, I use trace_vtd_err*() in general.

- for the non-GENERAL typed messages, convert into specified trace_*().

- for useless DPRINTFs, I removed them.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 97 +++++++++++++++++++++------------------------------
 hw/i386/trace-events  | 15 ++++++++
 2 files changed, 54 insertions(+), 58 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index b934b56..343a2ad 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -35,6 +35,7 @@
 #include "sysemu/kvm.h"
 #include "hw/i386/apic_internal.h"
 #include "kvm_i386.h"
+#include "trace.h"
 
 /*#define DEBUG_INTEL_IOMMU*/
 #ifdef DEBUG_INTEL_IOMMU
@@ -474,22 +475,19 @@ static void vtd_handle_inv_queue_error(IntelIOMMUState *s)
 /* Set the IWC field and try to generate an invalidation completion interrupt */
 static void vtd_generate_completion_event(IntelIOMMUState *s)
 {
-    VTD_DPRINTF(INV, "completes an invalidation wait command with "
-                "Interrupt Flag");
     if (vtd_get_long_raw(s, DMAR_ICS_REG) & VTD_ICS_IWC) {
-        VTD_DPRINTF(INV, "there is a previous interrupt condition to be "
-                    "serviced by software, "
-                    "new invalidation event is not generated");
+        trace_vtd_inv_desc_wait_irq("One pending, skip current");
         return;
     }
     vtd_set_clear_mask_long(s, DMAR_ICS_REG, 0, VTD_ICS_IWC);
     vtd_set_clear_mask_long(s, DMAR_IECTL_REG, 0, VTD_IECTL_IP);
     if (vtd_get_long_raw(s, DMAR_IECTL_REG) & VTD_IECTL_IM) {
-        VTD_DPRINTF(INV, "IM filed in IECTL_REG is set, new invalidation "
-                    "event is not generated");
+        trace_vtd_inv_desc_wait_irq("IM in IECTL_REG is set, "
+                                    "new event not generated");
         return;
     } else {
         /* Generate the interrupt event */
+        trace_vtd_inv_desc_wait_irq("Generating complete event");
         vtd_generate_interrupt(s, DMAR_IEADDR_REG, DMAR_IEDATA_REG);
         vtd_set_clear_mask_long(s, DMAR_IECTL_REG, VTD_IECTL_IP, 0);
     }
@@ -923,6 +921,7 @@ static void vtd_interrupt_remap_table_setup(IntelIOMMUState *s)
 
 static void vtd_context_global_invalidate(IntelIOMMUState *s)
 {
+    trace_vtd_inv_desc_cc_global();
     s->context_cache_gen++;
     if (s->context_cache_gen == VTD_CONTEXT_CACHE_GEN_MAX) {
         vtd_reset_context_cache(s);
@@ -962,9 +961,11 @@ static void vtd_context_device_invalidate(IntelIOMMUState *s,
     uint16_t mask;
     VTDBus *vtd_bus;
     VTDAddressSpace *vtd_as;
-    uint16_t devfn;
+    uint8_t bus_n, devfn;
     uint16_t devfn_it;
 
+    trace_vtd_inv_desc_cc_devices(source_id, func_mask);
+
     switch (func_mask & 3) {
     case 0:
         mask = 0;   /* No bits in the SID field masked */
@@ -980,16 +981,16 @@ static void vtd_context_device_invalidate(IntelIOMMUState *s,
         break;
     }
     mask = ~mask;
-    VTD_DPRINTF(INV, "device-selective invalidation source 0x%"PRIx16
-                    " mask %"PRIu16, source_id, mask);
-    vtd_bus = vtd_find_as_from_bus_num(s, VTD_SID_TO_BUS(source_id));
+
+    bus_n = VTD_SID_TO_BUS(source_id);
+    vtd_bus = vtd_find_as_from_bus_num(s, bus_n);
     if (vtd_bus) {
         devfn = VTD_SID_TO_DEVFN(source_id);
         for (devfn_it = 0; devfn_it < X86_IOMMU_PCI_DEVFN_MAX; ++devfn_it) {
             vtd_as = vtd_bus->dev_as[devfn_it];
             if (vtd_as && ((devfn_it & mask) == (devfn & mask))) {
-                VTD_DPRINTF(INV, "invalidate context-cahce of devfn 0x%"PRIx16,
-                            devfn_it);
+                trace_vtd_inv_desc_cc_device(bus_n, VTD_PCI_SLOT(devfn_it),
+                                             VTD_PCI_FUNC(devfn_it));
                 vtd_as->context_cache_entry.context_cache_gen = 0;
             }
         }
@@ -1302,9 +1303,7 @@ static bool vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
 {
     if ((inv_desc->hi & VTD_INV_DESC_WAIT_RSVD_HI) ||
         (inv_desc->lo & VTD_INV_DESC_WAIT_RSVD_LO)) {
-        VTD_DPRINTF(GENERAL, "error: non-zero reserved field in Invalidation "
-                    "Wait Descriptor hi 0x%"PRIx64 " lo 0x%"PRIx64,
-                    inv_desc->hi, inv_desc->lo);
+        trace_vtd_err_nonzero_reserved("invalidation wait desc");
         return false;
     }
     if (inv_desc->lo & VTD_INV_DESC_WAIT_SW) {
@@ -1316,21 +1315,18 @@ static bool vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
 
         /* FIXME: need to be masked with HAW? */
         dma_addr_t status_addr = inv_desc->hi;
-        VTD_DPRINTF(INV, "status data 0x%x, status addr 0x%"PRIx64,
-                    status_data, status_addr);
+        trace_vtd_inv_desc_wait_sw(status_addr, status_data);
         status_data = cpu_to_le32(status_data);
         if (dma_memory_write(&address_space_memory, status_addr, &status_data,
                              sizeof(status_data))) {
-            VTD_DPRINTF(GENERAL, "error: fail to perform a coherent write");
+            trace_vtd_err("Invalidate Desc Wait status write failed");
             return false;
         }
     } else if (inv_desc->lo & VTD_INV_DESC_WAIT_IF) {
         /* Interrupt flag */
-        VTD_DPRINTF(INV, "Invalidation Wait Descriptor interrupt completion");
         vtd_generate_completion_event(s);
     } else {
-        VTD_DPRINTF(GENERAL, "error: invalid Invalidation Wait Descriptor: "
-                    "hi 0x%"PRIx64 " lo 0x%"PRIx64, inv_desc->hi, inv_desc->lo);
+        trace_vtd_err("invalid Invalidation Wait Descriptor");
         return false;
     }
     return true;
@@ -1339,30 +1335,30 @@ static bool vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
 static bool vtd_process_context_cache_desc(IntelIOMMUState *s,
                                            VTDInvDesc *inv_desc)
 {
+    uint16_t sid, fmask;
+
     if ((inv_desc->lo & VTD_INV_DESC_CC_RSVD) || inv_desc->hi) {
-        VTD_DPRINTF(GENERAL, "error: non-zero reserved field in Context-cache "
-                    "Invalidate Descriptor");
+        trace_vtd_err_nonzero_reserved("Context-cache invalidation desc");
         return false;
     }
     switch (inv_desc->lo & VTD_INV_DESC_CC_G) {
     case VTD_INV_DESC_CC_DOMAIN:
-        VTD_DPRINTF(INV, "domain-selective invalidation domain 0x%"PRIx16,
-                    (uint16_t)VTD_INV_DESC_CC_DID(inv_desc->lo));
+        trace_vtd_inv_desc_cc_domain(
+            (uint16_t)VTD_INV_DESC_CC_DID(inv_desc->lo));
         /* Fall through */
     case VTD_INV_DESC_CC_GLOBAL:
-        VTD_DPRINTF(INV, "global invalidation");
         vtd_context_global_invalidate(s);
         break;
 
     case VTD_INV_DESC_CC_DEVICE:
-        vtd_context_device_invalidate(s, VTD_INV_DESC_CC_SID(inv_desc->lo),
-                                      VTD_INV_DESC_CC_FM(inv_desc->lo));
+        sid = VTD_INV_DESC_CC_SID(inv_desc->lo);
+        fmask = VTD_INV_DESC_CC_FM(inv_desc->lo);
+        vtd_context_device_invalidate(s, sid, fmask);
         break;
 
     default:
-        VTD_DPRINTF(GENERAL, "error: invalid granularity in Context-cache "
-                    "Invalidate Descriptor hi 0x%"PRIx64  " lo 0x%"PRIx64,
-                    inv_desc->hi, inv_desc->lo);
+        trace_vtd_err("invalid granularity in Context-cache "
+                      "Invalidate Descriptor");
         return false;
     }
     return true;
@@ -1376,22 +1372,19 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
 
     if ((inv_desc->lo & VTD_INV_DESC_IOTLB_RSVD_LO) ||
         (inv_desc->hi & VTD_INV_DESC_IOTLB_RSVD_HI)) {
-        VTD_DPRINTF(GENERAL, "error: non-zero reserved field in IOTLB "
-                    "Invalidate Descriptor hi 0x%"PRIx64 " lo 0x%"PRIx64,
-                    inv_desc->hi, inv_desc->lo);
+        trace_vtd_err_nonzero_reserved("IOTLB invalidation desc");
         return false;
     }
 
     switch (inv_desc->lo & VTD_INV_DESC_IOTLB_G) {
     case VTD_INV_DESC_IOTLB_GLOBAL:
-        VTD_DPRINTF(INV, "global invalidation");
+        trace_vtd_inv_desc_iotlb_global();
         vtd_iotlb_global_invalidate(s);
         break;
 
     case VTD_INV_DESC_IOTLB_DOMAIN:
         domain_id = VTD_INV_DESC_IOTLB_DID(inv_desc->lo);
-        VTD_DPRINTF(INV, "domain-selective invalidation domain 0x%"PRIx16,
-                    domain_id);
+        trace_vtd_inv_desc_iotlb_domain(domain_id);
         vtd_iotlb_domain_invalidate(s, domain_id);
         break;
 
@@ -1399,20 +1392,16 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
         domain_id = VTD_INV_DESC_IOTLB_DID(inv_desc->lo);
         addr = VTD_INV_DESC_IOTLB_ADDR(inv_desc->hi);
         am = VTD_INV_DESC_IOTLB_AM(inv_desc->hi);
-        VTD_DPRINTF(INV, "page-selective invalidation domain 0x%"PRIx16
-                    " addr 0x%"PRIx64 " mask %"PRIu8, domain_id, addr, am);
+        trace_vtd_inv_desc_iotlb_pages(domain_id, addr, am);
         if (am > VTD_MAMV) {
-            VTD_DPRINTF(GENERAL, "error: supported max address mask value is "
-                        "%"PRIu8, (uint8_t)VTD_MAMV);
+            trace_vtd_err("IOTLB page inv desc addr mask overflow");
             return false;
         }
         vtd_iotlb_page_invalidate(s, domain_id, addr, am);
         break;
 
     default:
-        VTD_DPRINTF(GENERAL, "error: invalid granularity in IOTLB Invalidate "
-                    "Descriptor hi 0x%"PRIx64 " lo 0x%"PRIx64,
-                    inv_desc->hi, inv_desc->lo);
+        trace_vtd_err("invalid granularity in IOTLB inv desc");
         return false;
     }
     return true;
@@ -1492,7 +1481,6 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
     VTDInvDesc inv_desc;
     uint8_t desc_type;
 
-    VTD_DPRINTF(INV, "iq head %"PRIu16, s->iq_head);
     if (!vtd_get_inv_desc(s->iq, s->iq_head, &inv_desc)) {
         s->iq_last_desc_type = VTD_INV_DESC_NONE;
         return false;
@@ -1503,33 +1491,28 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
 
     switch (desc_type) {
     case VTD_INV_DESC_CC:
-        VTD_DPRINTF(INV, "Context-cache Invalidate Descriptor hi 0x%"PRIx64
-                    " lo 0x%"PRIx64, inv_desc.hi, inv_desc.lo);
+        trace_vtd_inv_desc("context-cache", inv_desc.hi, inv_desc.lo);
         if (!vtd_process_context_cache_desc(s, &inv_desc)) {
             return false;
         }
         break;
 
     case VTD_INV_DESC_IOTLB:
-        VTD_DPRINTF(INV, "IOTLB Invalidate Descriptor hi 0x%"PRIx64
-                    " lo 0x%"PRIx64, inv_desc.hi, inv_desc.lo);
+        trace_vtd_inv_desc("iotlb", inv_desc.hi, inv_desc.lo);
         if (!vtd_process_iotlb_desc(s, &inv_desc)) {
             return false;
         }
         break;
 
     case VTD_INV_DESC_WAIT:
-        VTD_DPRINTF(INV, "Invalidation Wait Descriptor hi 0x%"PRIx64
-                    " lo 0x%"PRIx64, inv_desc.hi, inv_desc.lo);
+        trace_vtd_inv_desc("wait", inv_desc.hi, inv_desc.lo);
         if (!vtd_process_wait_desc(s, &inv_desc)) {
             return false;
         }
         break;
 
     case VTD_INV_DESC_IEC:
-        VTD_DPRINTF(INV, "Invalidation Interrupt Entry Cache "
-                    "Descriptor hi 0x%"PRIx64 " lo 0x%"PRIx64,
-                    inv_desc.hi, inv_desc.lo);
+        trace_vtd_inv_desc("iec", inv_desc.hi, inv_desc.lo);
         if (!vtd_process_inv_iec_desc(s, &inv_desc)) {
             return false;
         }
@@ -1544,9 +1527,7 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
         break;
 
     default:
-        VTD_DPRINTF(GENERAL, "error: unkonw Invalidation Descriptor type "
-                    "hi 0x%"PRIx64 " lo 0x%"PRIx64 " type %"PRIu8,
-                    inv_desc.hi, inv_desc.lo, desc_type);
+        trace_vtd_err("Unkonw Invalidation Descriptor type");
         return false;
     }
     s->iq_head++;
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index d2b4973..eea3e84 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -10,6 +10,21 @@ xen_pv_mmio_write(uint64_t addr) "WARNING: write to Xen PV Device MMIO space (ad
 # hw/i386/x86-iommu.c
 x86_iommu_iec_notify(bool global, uint32_t index, uint32_t mask) "Notify IEC invalidation: global=%d index=%" PRIu32 " mask=%" PRIu32
 
+# hw/i386/intel_iommu.c
+vtd_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn, bool on) "Device %02x:%02x.%x switching address space (iommu enabled=%d)"
+vtd_inv_desc(const char *type, uint64_t hi, uint64_t lo) "invalidate desc type %s high 0x%"PRIx64" low 0x%"PRIx64
+vtd_inv_desc_cc_domain(uint16_t domain) "context invalidate domain 0x%"PRIx16
+vtd_inv_desc_cc_global(void) "context invalidate globally"
+vtd_inv_desc_cc_device(uint8_t bus, uint8_t dev, uint8_t fn) "context invalidate device %02"PRIx8":%02"PRIx8".%02"PRIx8
+vtd_inv_desc_cc_devices(uint16_t sid, uint16_t fmask) "context invalidate devices sid 0x%"PRIx16" fmask 0x%"PRIx16
+vtd_inv_desc_iotlb_global(void) "iotlb invalidate global"
+vtd_inv_desc_iotlb_domain(uint16_t domain) "iotlb invalidate whole domain 0x%"PRIx16
+vtd_inv_desc_iotlb_pages(uint16_t domain, uint64_t addr, uint8_t mask) "iotlb invalidate domain 0x%"PRIx16" addr 0x%"PRIx64" mask 0x%"PRIx8
+vtd_inv_desc_wait_sw(uint64_t addr, uint32_t data) "wait invalidate status write addr 0x%"PRIx64" data 0x%"PRIx32
+vtd_inv_desc_wait_irq(const char *msg) "%s"
+vtd_err_nonzero_reserved(const char *msg) "Non-zero reserved field in %s"
+vtd_err(const char *msg) "%s"
+
 # hw/i386/amd_iommu.c
 amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32
 amdvi_cache_update(uint16_t domid, uint8_t bus, uint8_t slot, uint8_t func, uint64_t gpa, uint64_t txaddr) " update iotlb domid 0x%"PRIx16" devid: %02x:%02x.%x gpa 0x%"PRIx64" hpa 0x%"PRIx64
-- 
2.7.4
