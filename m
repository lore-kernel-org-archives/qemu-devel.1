Received: from eggs.gnu.org ([2001:4830:134:3::10]:41202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dJKMJ-00075M-Bt
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dJKME-0006ee-Vc
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:53:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dJKME-0006dY-Ix
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:53:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 88EC0811A7
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 13:53:45 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri,  9 Jun 2017 21:53:27 +0800
Message-Id: <1497016409-22650-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1497016409-22650-1-git-send-email-peterx@redhat.com>
References: <1497016409-22650-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] intel_iommu: switching the rest DPRINTF
 to trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

We have converted many of the DPRINTF() into traces. This patch does the
last 100+ ones.

To debug VT-d when error happens, let's try enable:

  -trace enable="vtd_err*"

This should works just like the old GENERAL but of course better, since
we don't need to recompile.

Similar rules apply to the other modules. I was trying to make the
prefix good enough for sub-module debugging.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 355 ++++++++++++++++----------------------------------
 hw/i386/trace-events  |  43 ++++++
 2 files changed, 153 insertions(+), 245 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 15610b9..a650151 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -37,24 +37,6 @@
 #include "kvm_i386.h"
 #include "trace.h"
 
-/*#define DEBUG_INTEL_IOMMU*/
-#ifdef DEBUG_INTEL_IOMMU
-enum {
-    DEBUG_GENERAL, DEBUG_CSR, DEBUG_INV, DEBUG_MMU, DEBUG_FLOG,
-    DEBUG_CACHE, DEBUG_IR,
-};
-#define VTD_DBGBIT(x)   (1 << DEBUG_##x)
-static int vtd_dbgflags = VTD_DBGBIT(GENERAL) | VTD_DBGBIT(CSR);
-
-#define VTD_DPRINTF(what, fmt, ...) do { \
-    if (vtd_dbgflags & VTD_DBGBIT(what)) { \
-        fprintf(stderr, "(vtd)%s: " fmt "\n", __func__, \
-                ## __VA_ARGS__); } \
-    } while (0)
-#else
-#define VTD_DPRINTF(what, fmt, ...) do {} while (0)
-#endif
-
 static void vtd_define_quad(IntelIOMMUState *s, hwaddr addr, uint64_t val,
                             uint64_t wmask, uint64_t w1cmask)
 {
@@ -199,9 +181,10 @@ static void vtd_reset_context_cache(IntelIOMMUState *s)
     GHashTableIter bus_it;
     uint32_t devfn_it;
 
+    trace_vtd_context_cache_reset();
+
     g_hash_table_iter_init(&bus_it, s->vtd_as_by_busptr);
 
-    VTD_DPRINTF(CACHE, "global context_cache_gen=1");
     while (g_hash_table_iter_next (&bus_it, NULL, (void**)&vtd_bus)) {
         for (devfn_it = 0; devfn_it < X86_IOMMU_PCI_DEVFN_MAX; ++devfn_it) {
             vtd_as = vtd_bus->dev_as[devfn_it];
@@ -291,8 +274,8 @@ static void vtd_generate_interrupt(IntelIOMMUState *s, hwaddr mesg_addr_reg,
     msi.address = vtd_get_long_raw(s, mesg_addr_reg);
     msi.data = vtd_get_long_raw(s, mesg_data_reg);
 
-    VTD_DPRINTF(FLOG, "msi: addr 0x%"PRIx64 " data 0x%"PRIx32,
-                msi.address, msi.data);
+    trace_vtd_irq_generate(msi.address, msi.data);
+
     apic_get_class()->send_msi(&msi);
 }
 
@@ -304,14 +287,14 @@ static void vtd_generate_fault_event(IntelIOMMUState *s, uint32_t pre_fsts)
 {
     if (pre_fsts & VTD_FSTS_PPF || pre_fsts & VTD_FSTS_PFO ||
         pre_fsts & VTD_FSTS_IQE) {
-        VTD_DPRINTF(FLOG, "there are previous interrupt conditions "
-                    "to be serviced by software, fault event is not generated "
-                    "(FSTS_REG 0x%"PRIx32 ")", pre_fsts);
+        trace_vtd_err("There are previous interrupt conditions "
+                      "to be serviced by software, fault event "
+                      "is not generated.");
         return;
     }
     vtd_set_clear_mask_long(s, DMAR_FECTL_REG, 0, VTD_FECTL_IP);
     if (vtd_get_long_raw(s, DMAR_FECTL_REG) & VTD_FECTL_IM) {
-        VTD_DPRINTF(FLOG, "Interrupt Mask set, fault event is not generated");
+        trace_vtd_err("Interrupt Mask set, irq is not generated.");
     } else {
         vtd_generate_interrupt(s, DMAR_FEADDR_REG, DMAR_FEDATA_REG);
         vtd_set_clear_mask_long(s, DMAR_FECTL_REG, VTD_FECTL_IP, 0);
@@ -348,7 +331,7 @@ static void vtd_update_fsts_ppf(IntelIOMMUState *s)
         }
     }
     vtd_set_clear_mask_long(s, DMAR_FSTS_REG, VTD_FSTS_PPF, ppf_mask);
-    VTD_DPRINTF(FLOG, "set PPF of FSTS_REG to %d", ppf_mask ? 1 : 0);
+    trace_vtd_fsts_ppf(!!ppf_mask);
 }
 
 static void vtd_set_frcd_and_update_ppf(IntelIOMMUState *s, uint16_t index)
@@ -380,8 +363,8 @@ static void vtd_record_frcd(IntelIOMMUState *s, uint16_t index,
     }
     vtd_set_quad_raw(s, frcd_reg_addr, lo);
     vtd_set_quad_raw(s, frcd_reg_addr + 8, hi);
-    VTD_DPRINTF(FLOG, "record to FRCD_REG #%"PRIu16 ": hi 0x%"PRIx64
-                ", lo 0x%"PRIx64, index, hi, lo);
+
+    trace_vtd_frr_new(index, hi, lo);
 }
 
 /* Try to collapse multiple pending faults from the same requester */
@@ -393,7 +376,6 @@ static bool vtd_try_collapse_fault(IntelIOMMUState *s, uint16_t source_id)
 
     for (i = 0; i < DMAR_FRCD_REG_NR; i++) {
         frcd_reg = vtd_get_quad_raw(s, addr);
-        VTD_DPRINTF(FLOG, "frcd_reg #%d 0x%"PRIx64, i, frcd_reg);
         if ((frcd_reg & VTD_FRCD_F) &&
             ((frcd_reg & VTD_FRCD_SID_MASK) == source_id)) {
             return true;
@@ -416,21 +398,24 @@ static void vtd_report_dmar_fault(IntelIOMMUState *s, uint16_t source_id,
         /* This is not a normal fault reason case. Drop it. */
         return;
     }
-    VTD_DPRINTF(FLOG, "sid 0x%"PRIx16 ", fault %d, addr 0x%"PRIx64
-                ", is_write %d", source_id, fault, addr, is_write);
+
+    trace_vtd_dmar_fault(source_id, fault, addr, is_write);
+
     if (fsts_reg & VTD_FSTS_PFO) {
-        VTD_DPRINTF(FLOG, "new fault is not recorded due to "
-                    "Primary Fault Overflow");
+        trace_vtd_err("New fault is not recorded due to "
+                      "Primary Fault Overflow.");
         return;
     }
+
     if (vtd_try_collapse_fault(s, source_id)) {
-        VTD_DPRINTF(FLOG, "new fault is not recorded due to "
-                    "compression of faults");
+        trace_vtd_err("New fault is not recorded due to "
+                      "compression of faults.");
         return;
     }
+
     if (vtd_is_frcd_set(s, s->next_frcd_reg)) {
-        VTD_DPRINTF(FLOG, "Primary Fault Overflow and "
-                    "new fault is not recorded, set PFO field");
+        trace_vtd_err("Next Fault Recording Reg is used, "
+                      "new fault is not recorded, set PFO field.");
         vtd_set_clear_mask_long(s, DMAR_FSTS_REG, 0, VTD_FSTS_PFO);
         return;
     }
@@ -438,8 +423,8 @@ static void vtd_report_dmar_fault(IntelIOMMUState *s, uint16_t source_id,
     vtd_record_frcd(s, s->next_frcd_reg, source_id, addr, fault, is_write);
 
     if (fsts_reg & VTD_FSTS_PPF) {
-        VTD_DPRINTF(FLOG, "there are pending faults already, "
-                    "fault event is not generated");
+        trace_vtd_err("There are pending faults already, "
+                      "fault event is not generated.");
         vtd_set_frcd_and_update_ppf(s, s->next_frcd_reg);
         s->next_frcd_reg++;
         if (s->next_frcd_reg == DMAR_FRCD_REG_NR) {
@@ -702,7 +687,7 @@ static int vtd_iova_to_slpte(VTDContextEntry *ce, uint64_t iova, bool is_write,
     uint64_t access_right_check;
 
     if (!vtd_iova_range_check(iova, ce)) {
-        VTD_DPRINTF(GENERAL, "error: iova 0x%"PRIx64 " exceeds limits", iova);
+        trace_vtd_err_dmar_iova_overflow(iova);
         return -VTD_FR_ADDR_BEYOND_MGAW;
     }
 
@@ -714,9 +699,7 @@ static int vtd_iova_to_slpte(VTDContextEntry *ce, uint64_t iova, bool is_write,
         slpte = vtd_get_slpte(addr, offset);
 
         if (slpte == (uint64_t)-1) {
-            VTD_DPRINTF(GENERAL, "error: fail to access second-level paging "
-                        "entry at level %"PRIu32 " for iova 0x%"PRIx64,
-                        level, iova);
+            trace_vtd_err_dmar_slpte_read_error(iova, level);
             if (level == vtd_ce_get_level(ce)) {
                 /* Invalid programming of context-entry */
                 return -VTD_FR_CONTEXT_ENTRY_INV;
@@ -727,15 +710,11 @@ static int vtd_iova_to_slpte(VTDContextEntry *ce, uint64_t iova, bool is_write,
         *reads = (*reads) && (slpte & VTD_SL_R);
         *writes = (*writes) && (slpte & VTD_SL_W);
         if (!(slpte & access_right_check)) {
-            VTD_DPRINTF(GENERAL, "error: lack of %s permission for "
-                        "iova 0x%"PRIx64 " slpte 0x%"PRIx64,
-                        (is_write ? "write" : "read"), iova, slpte);
+            trace_vtd_err_dmar_slpte_perm_error(iova, level, slpte, is_write);
             return is_write ? -VTD_FR_WRITE : -VTD_FR_READ;
         }
         if (vtd_slpte_nonzero_rsvd(slpte, level)) {
-            VTD_DPRINTF(GENERAL, "error: non-zero reserved field in second "
-                        "level paging entry level %"PRIu32 " slpte 0x%"PRIx64,
-                        level, slpte);
+            trace_vtd_err_dmar_slpte_resv_error(iova, level, slpte);
             return -VTD_FR_PAGING_ENTRY_RSVD;
         }
 
@@ -1204,8 +1183,7 @@ static void vtd_root_table_setup(IntelIOMMUState *s)
     s->root_extended = s->root & VTD_RTADDR_RTT;
     s->root &= VTD_RTADDR_ADDR_MASK;
 
-    VTD_DPRINTF(CSR, "root_table addr 0x%"PRIx64 " %s", s->root,
-                (s->root_extended ? "(extended)" : ""));
+    trace_vtd_reg_dmar_root(s->root, s->root_extended);
 }
 
 static void vtd_iec_notify_all(IntelIOMMUState *s, bool global,
@@ -1225,8 +1203,7 @@ static void vtd_interrupt_remap_table_setup(IntelIOMMUState *s)
     /* Notify global invalidation */
     vtd_iec_notify_all(s, true, 0, 0);
 
-    VTD_DPRINTF(CSR, "int remap table addr 0x%"PRIx64 " size %"PRIu32,
-                s->intr_root, s->intr_size);
+    trace_vtd_reg_ir_root(s->intr_root, s->intr_size);
 }
 
 static void vtd_iommu_replay_all(IntelIOMMUState *s)
@@ -1328,11 +1305,8 @@ static uint64_t vtd_context_cache_invalidate(IntelIOMMUState *s, uint64_t val)
 
     switch (type) {
     case VTD_CCMD_DOMAIN_INVL:
-        VTD_DPRINTF(INV, "domain-selective invalidation domain 0x%"PRIx16,
-                    (uint16_t)VTD_CCMD_DID(val));
         /* Fall through */
     case VTD_CCMD_GLOBAL_INVL:
-        VTD_DPRINTF(INV, "global invalidation");
         caig = VTD_CCMD_GLOBAL_INVL_A;
         vtd_context_global_invalidate(s);
         break;
@@ -1343,7 +1317,7 @@ static uint64_t vtd_context_cache_invalidate(IntelIOMMUState *s, uint64_t val)
         break;
 
     default:
-        VTD_DPRINTF(GENERAL, "error: invalid granularity");
+        trace_vtd_err("Context cache invalidate type error.");
         caig = 0;
     }
     return caig;
@@ -1351,7 +1325,7 @@ static uint64_t vtd_context_cache_invalidate(IntelIOMMUState *s, uint64_t val)
 
 static void vtd_iotlb_global_invalidate(IntelIOMMUState *s)
 {
-    trace_vtd_iotlb_reset("global invalidation recved");
+    trace_vtd_inv_desc_iotlb_global();
     vtd_reset_iotlb(s);
     vtd_iommu_replay_all(s);
 }
@@ -1362,6 +1336,8 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
     VTDContextEntry ce;
     VTDAddressSpace *vtd_as;
 
+    trace_vtd_inv_desc_iotlb_domain(domain_id);
+
     g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_domain,
                                 &domain_id);
 
@@ -1407,6 +1383,8 @@ static void vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
 {
     VTDIOTLBPageInvInfo info;
 
+    trace_vtd_inv_desc_iotlb_pages(domain_id, addr, am);
+
     assert(am <= VTD_MAMV);
     info.domain_id = domain_id;
     info.addr = addr;
@@ -1429,15 +1407,12 @@ static uint64_t vtd_iotlb_flush(IntelIOMMUState *s, uint64_t val)
 
     switch (type) {
     case VTD_TLB_GLOBAL_FLUSH:
-        VTD_DPRINTF(INV, "global invalidation");
         iaig = VTD_TLB_GLOBAL_FLUSH_A;
         vtd_iotlb_global_invalidate(s);
         break;
 
     case VTD_TLB_DSI_FLUSH:
         domain_id = VTD_TLB_DID(val);
-        VTD_DPRINTF(INV, "domain-selective invalidation domain 0x%"PRIx16,
-                    domain_id);
         iaig = VTD_TLB_DSI_FLUSH_A;
         vtd_iotlb_domain_invalidate(s, domain_id);
         break;
@@ -1447,11 +1422,8 @@ static uint64_t vtd_iotlb_flush(IntelIOMMUState *s, uint64_t val)
         addr = vtd_get_quad_raw(s, DMAR_IVA_REG);
         am = VTD_IVA_AM(addr);
         addr = VTD_IVA_ADDR(addr);
-        VTD_DPRINTF(INV, "page-selective invalidation domain 0x%"PRIx16
-                    " addr 0x%"PRIx64 " mask %"PRIu8, domain_id, addr, am);
         if (am > VTD_MAMV) {
-            VTD_DPRINTF(GENERAL, "error: supported max address mask value is "
-                        "%"PRIu8, (uint8_t)VTD_MAMV);
+            trace_vtd_err("IOTLB PSI flush: address mask overflow.");
             iaig = 0;
             break;
         }
@@ -1460,7 +1432,7 @@ static uint64_t vtd_iotlb_flush(IntelIOMMUState *s, uint64_t val)
         break;
 
     default:
-        VTD_DPRINTF(GENERAL, "error: invalid granularity");
+        trace_vtd_err("IOTLB flush: invalid granularity.");
         iaig = 0;
     }
     return iaig;
@@ -1481,21 +1453,19 @@ static void vtd_handle_gcmd_qie(IntelIOMMUState *s, bool en)
 {
     uint64_t iqa_val = vtd_get_quad_raw(s, DMAR_IQA_REG);
 
-    VTD_DPRINTF(INV, "Queued Invalidation Enable %s", (en ? "on" : "off"));
+    trace_vtd_inv_qi_enable(en);
+
     if (en) {
         if (vtd_queued_inv_enable_check(s)) {
             s->iq = iqa_val & VTD_IQA_IQA_MASK;
             /* 2^(x+8) entries */
             s->iq_size = 1UL << ((iqa_val & VTD_IQA_QS) + 8);
             s->qi_enabled = true;
-            VTD_DPRINTF(INV, "DMAR_IQA_REG 0x%"PRIx64, iqa_val);
-            VTD_DPRINTF(INV, "Invalidation Queue addr 0x%"PRIx64 " size %d",
-                        s->iq, s->iq_size);
+            trace_vtd_inv_qi_setup(s->iq, s->iq_size);
             /* Ok - report back to driver */
             vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_QIES);
         } else {
-            VTD_DPRINTF(GENERAL, "error: can't enable Queued Invalidation: "
-                        "tail %"PRIu16, s->iq_tail);
+            trace_vtd_err_qi_enable(s->iq_tail);
         }
     } else {
         if (vtd_queued_inv_disable_check(s)) {
@@ -1506,10 +1476,7 @@ static void vtd_handle_gcmd_qie(IntelIOMMUState *s, bool en)
             /* Ok - report back to driver */
             vtd_set_clear_mask_long(s, DMAR_GSTS_REG, VTD_GSTS_QIES, 0);
         } else {
-            VTD_DPRINTF(GENERAL, "error: can't disable Queued Invalidation: "
-                        "head %"PRIu16 ", tail %"PRIu16
-                        ", last_descriptor %"PRIu8,
-                        s->iq_head, s->iq_tail, s->iq_last_desc_type);
+            trace_vtd_err_qi_disable(s->iq_head, s->iq_tail, s->iq_last_desc_type);
         }
     }
 }
@@ -1517,8 +1484,6 @@ static void vtd_handle_gcmd_qie(IntelIOMMUState *s, bool en)
 /* Set Root Table Pointer */
 static void vtd_handle_gcmd_srtp(IntelIOMMUState *s)
 {
-    VTD_DPRINTF(CSR, "set Root Table Pointer");
-
     vtd_root_table_setup(s);
     /* Ok - report back to driver */
     vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_RTPS);
@@ -1527,8 +1492,6 @@ static void vtd_handle_gcmd_srtp(IntelIOMMUState *s)
 /* Set Interrupt Remap Table Pointer */
 static void vtd_handle_gcmd_sirtp(IntelIOMMUState *s)
 {
-    VTD_DPRINTF(CSR, "set Interrupt Remap Table Pointer");
-
     vtd_interrupt_remap_table_setup(s);
     /* Ok - report back to driver */
     vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_IRTPS);
@@ -1541,7 +1504,7 @@ static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
         return;
     }
 
-    VTD_DPRINTF(CSR, "Translation Enable %s", (en ? "on" : "off"));
+    trace_vtd_dmar_enable(en);
 
     if (en) {
         s->dmar_enabled = true;
@@ -1562,7 +1525,7 @@ static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
 /* Handle Interrupt Remap Enable/Disable */
 static void vtd_handle_gcmd_ire(IntelIOMMUState *s, bool en)
 {
-    VTD_DPRINTF(CSR, "Interrupt Remap Enable %s", (en ? "on" : "off"));
+    trace_vtd_ir_enable(en);
 
     if (en) {
         s->intr_enabled = true;
@@ -1582,7 +1545,7 @@ static void vtd_handle_gcmd_write(IntelIOMMUState *s)
     uint32_t val = vtd_get_long_raw(s, DMAR_GCMD_REG);
     uint32_t changed = status ^ val;
 
-    VTD_DPRINTF(CSR, "value 0x%"PRIx32 " status 0x%"PRIx32, val, status);
+    trace_vtd_reg_write_gcmd(status, val);
     if (changed & VTD_GCMD_TE) {
         /* Translation enable/disable */
         vtd_handle_gcmd_te(s, val & VTD_GCMD_TE);
@@ -1614,8 +1577,8 @@ static void vtd_handle_ccmd_write(IntelIOMMUState *s)
     /* Context-cache invalidation request */
     if (val & VTD_CCMD_ICC) {
         if (s->qi_enabled) {
-            VTD_DPRINTF(GENERAL, "error: Queued Invalidation enabled, "
-                        "should not use register-based invalidation");
+            trace_vtd_err("Queued Invalidation enabled, "
+                          "should not use register-based invalidation");
             return;
         }
         ret = vtd_context_cache_invalidate(s, val);
@@ -1623,7 +1586,6 @@ static void vtd_handle_ccmd_write(IntelIOMMUState *s)
         vtd_set_clear_mask_quad(s, DMAR_CCMD_REG, VTD_CCMD_ICC, 0ULL);
         ret = vtd_set_clear_mask_quad(s, DMAR_CCMD_REG, VTD_CCMD_CAIG_MASK,
                                       ret);
-        VTD_DPRINTF(INV, "CCMD_REG write-back val: 0x%"PRIx64, ret);
     }
 }
 
@@ -1636,8 +1598,8 @@ static void vtd_handle_iotlb_write(IntelIOMMUState *s)
     /* IOTLB invalidation request */
     if (val & VTD_TLB_IVT) {
         if (s->qi_enabled) {
-            VTD_DPRINTF(GENERAL, "error: Queued Invalidation enabled, "
-                        "should not use register-based invalidation");
+            trace_vtd_err("Queued Invalidation enabled, "
+                          "should not use register-based invalidation.");
             return;
         }
         ret = vtd_iotlb_flush(s, val);
@@ -1645,7 +1607,6 @@ static void vtd_handle_iotlb_write(IntelIOMMUState *s)
         vtd_set_clear_mask_quad(s, DMAR_IOTLB_REG, VTD_TLB_IVT, 0ULL);
         ret = vtd_set_clear_mask_quad(s, DMAR_IOTLB_REG,
                                       VTD_TLB_FLUSH_GRANU_MASK_A, ret);
-        VTD_DPRINTF(INV, "IOTLB_REG write-back val: 0x%"PRIx64, ret);
     }
 }
 
@@ -1656,11 +1617,9 @@ static bool vtd_get_inv_desc(dma_addr_t base_addr, uint32_t offset,
     dma_addr_t addr = base_addr + offset * sizeof(*inv_desc);
     if (dma_memory_read(&address_space_memory, addr, inv_desc,
         sizeof(*inv_desc))) {
-        VTD_DPRINTF(GENERAL, "error: fail to fetch Invalidation Descriptor "
-                    "base_addr 0x%"PRIx64 " offset %"PRIu32, base_addr, offset);
+        trace_vtd_err("Read INV DESC failed.");
         inv_desc->lo = 0;
         inv_desc->hi = 0;
-
         return false;
     }
     inv_desc->lo = le64_to_cpu(inv_desc->lo);
@@ -1746,13 +1705,11 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
 
     switch (inv_desc->lo & VTD_INV_DESC_IOTLB_G) {
     case VTD_INV_DESC_IOTLB_GLOBAL:
-        trace_vtd_inv_desc_iotlb_global();
         vtd_iotlb_global_invalidate(s);
         break;
 
     case VTD_INV_DESC_IOTLB_DOMAIN:
         domain_id = VTD_INV_DESC_IOTLB_DID(inv_desc->lo);
-        trace_vtd_inv_desc_iotlb_domain(domain_id);
         vtd_iotlb_domain_invalidate(s, domain_id);
         break;
 
@@ -1760,7 +1717,6 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
         domain_id = VTD_INV_DESC_IOTLB_DID(inv_desc->lo);
         addr = VTD_INV_DESC_IOTLB_ADDR(inv_desc->hi);
         am = VTD_INV_DESC_IOTLB_AM(inv_desc->hi);
-        trace_vtd_inv_desc_iotlb_pages(domain_id, addr, am);
         if (am > VTD_MAMV) {
             trace_vtd_inv_desc_iotlb_invalid(inv_desc->hi, inv_desc->lo);
             return false;
@@ -1778,10 +1734,9 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
 static bool vtd_process_inv_iec_desc(IntelIOMMUState *s,
                                      VTDInvDesc *inv_desc)
 {
-    VTD_DPRINTF(INV, "inv ir glob %d index %d mask %d",
-                inv_desc->iec.granularity,
-                inv_desc->iec.index,
-                inv_desc->iec.index_mask);
+    trace_vtd_inv_desc_iec(inv_desc->iec.granularity,
+                           inv_desc->iec.index,
+                           inv_desc->iec.index_mask);
 
     vtd_iec_notify_all(s, !inv_desc->iec.granularity,
                        inv_desc->iec.index,
@@ -1810,9 +1765,7 @@ static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
 
     if ((inv_desc->lo & VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO) ||
         (inv_desc->hi & VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI)) {
-        VTD_DPRINTF(GENERAL, "error: non-zero reserved field in Device "
-                    "IOTLB Invalidate Descriptor hi 0x%"PRIx64 " lo 0x%"PRIx64,
-                    inv_desc->hi, inv_desc->lo);
+        trace_vtd_inv_desc_iotlb_invalid(inv_desc->hi, inv_desc->lo);
         return false;
     }
 
@@ -1857,7 +1810,7 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
     VTDInvDesc inv_desc;
     uint8_t desc_type;
 
-    VTD_DPRINTF(INV, "iq head %"PRIu16, s->iq_head);
+    trace_vtd_inv_qi_head(s->iq_head);
     if (!vtd_get_inv_desc(s->iq, s->iq_head, &inv_desc)) {
         s->iq_last_desc_type = VTD_INV_DESC_NONE;
         return false;
@@ -1896,8 +1849,7 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
         break;
 
     case VTD_INV_DESC_DEVICE:
-        VTD_DPRINTF(INV, "Device IOTLB Invalidation Descriptor hi 0x%"PRIx64
-                    " lo 0x%"PRIx64, inv_desc.hi, inv_desc.lo);
+        trace_vtd_inv_desc("device", inv_desc.hi, inv_desc.lo);
         if (!vtd_process_device_iotlb_desc(s, &inv_desc)) {
             return false;
         }
@@ -1917,11 +1869,11 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
 /* Try to fetch and process more Invalidation Descriptors */
 static void vtd_fetch_inv_desc(IntelIOMMUState *s)
 {
-    VTD_DPRINTF(INV, "fetch Invalidation Descriptors");
+    trace_vtd_inv_qi_fetch();
+
     if (s->iq_tail >= s->iq_size) {
         /* Detects an invalid Tail pointer */
-        VTD_DPRINTF(GENERAL, "error: iq_tail is %"PRIu16
-                    " while iq_size is %"PRIu16, s->iq_tail, s->iq_size);
+        trace_vtd_err_qi_tail(s->iq_tail, s->iq_size);
         vtd_handle_inv_queue_error(s);
         return;
     }
@@ -1944,7 +1896,8 @@ static void vtd_handle_iqt_write(IntelIOMMUState *s)
     uint64_t val = vtd_get_quad_raw(s, DMAR_IQT_REG);
 
     s->iq_tail = VTD_IQT_QT(val);
-    VTD_DPRINTF(INV, "set iq tail %"PRIu16, s->iq_tail);
+    trace_vtd_inv_qi_tail(s->iq_tail);
+
     if (s->qi_enabled && !(vtd_get_long_raw(s, DMAR_FSTS_REG) & VTD_FSTS_IQE)) {
         /* Process Invalidation Queue here */
         vtd_fetch_inv_desc(s);
@@ -1959,8 +1912,7 @@ static void vtd_handle_fsts_write(IntelIOMMUState *s)
 
     if ((fectl_reg & VTD_FECTL_IP) && !(fsts_reg & status_fields)) {
         vtd_set_clear_mask_long(s, DMAR_FECTL_REG, VTD_FECTL_IP, 0);
-        VTD_DPRINTF(FLOG, "all pending interrupt conditions serviced, clear "
-                    "IP field of FECTL_REG");
+        trace_vtd_fsts_clear_ip();
     }
     /* FIXME: when IQE is Clear, should we try to fetch some Invalidation
      * Descriptors if there are any when Queued Invalidation is enabled?
@@ -1975,11 +1927,12 @@ static void vtd_handle_fectl_write(IntelIOMMUState *s)
      * software clears the IM field? Or just check if the IM field is zero?
      */
     fectl_reg = vtd_get_long_raw(s, DMAR_FECTL_REG);
+
+    trace_vtd_reg_write_fectl(fectl_reg);
+
     if ((fectl_reg & VTD_FECTL_IP) && !(fectl_reg & VTD_FECTL_IM)) {
         vtd_generate_interrupt(s, DMAR_FEADDR_REG, DMAR_FEDATA_REG);
         vtd_set_clear_mask_long(s, DMAR_FECTL_REG, VTD_FECTL_IP, 0);
-        VTD_DPRINTF(FLOG, "IM field is cleared, generate "
-                    "fault event interrupt");
     }
 }
 
@@ -1989,9 +1942,8 @@ static void vtd_handle_ics_write(IntelIOMMUState *s)
     uint32_t iectl_reg = vtd_get_long_raw(s, DMAR_IECTL_REG);
 
     if ((iectl_reg & VTD_IECTL_IP) && !(ics_reg & VTD_ICS_IWC)) {
+        trace_vtd_reg_ics_clear_ip();
         vtd_set_clear_mask_long(s, DMAR_IECTL_REG, VTD_IECTL_IP, 0);
-        VTD_DPRINTF(INV, "pending completion interrupt condition serviced, "
-                    "clear IP field of IECTL_REG");
     }
 }
 
@@ -2003,11 +1955,12 @@ static void vtd_handle_iectl_write(IntelIOMMUState *s)
      * software clears the IM field? Or just check if the IM field is zero?
      */
     iectl_reg = vtd_get_long_raw(s, DMAR_IECTL_REG);
+
+    trace_vtd_reg_write_iectl(iectl_reg);
+
     if ((iectl_reg & VTD_IECTL_IP) && !(iectl_reg & VTD_IECTL_IM)) {
         vtd_generate_interrupt(s, DMAR_IEADDR_REG, DMAR_IEDATA_REG);
         vtd_set_clear_mask_long(s, DMAR_IECTL_REG, VTD_IECTL_IP, 0);
-        VTD_DPRINTF(INV, "IM field is cleared, generate "
-                    "invalidation event interrupt");
     }
 }
 
@@ -2016,10 +1969,10 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
     IntelIOMMUState *s = opaque;
     uint64_t val;
 
+    trace_vtd_reg_read(addr, size);
+
     if (addr + size > DMAR_REG_SIZE) {
-        VTD_DPRINTF(GENERAL, "error: addr outside region: max 0x%"PRIx64
-                    ", got 0x%"PRIx64 " %d",
-                    (uint64_t)DMAR_REG_SIZE, addr, size);
+        trace_vtd_err("Read MMIO over range.");
         return (uint64_t)-1;
     }
 
@@ -2058,8 +2011,7 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
             val = vtd_get_quad(s, addr);
         }
     }
-    VTD_DPRINTF(CSR, "addr 0x%"PRIx64 " size %d val 0x%"PRIx64,
-                addr, size, val);
+
     return val;
 }
 
@@ -2068,26 +2020,22 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
 {
     IntelIOMMUState *s = opaque;
 
+    trace_vtd_reg_write(addr, size, val);
+
     if (addr + size > DMAR_REG_SIZE) {
-        VTD_DPRINTF(GENERAL, "error: addr outside region: max 0x%"PRIx64
-                    ", got 0x%"PRIx64 " %d",
-                    (uint64_t)DMAR_REG_SIZE, addr, size);
+        trace_vtd_err("Write MMIO over range.");
         return;
     }
 
     switch (addr) {
     /* Global Command Register, 32-bit */
     case DMAR_GCMD_REG:
-        VTD_DPRINTF(CSR, "DMAR_GCMD_REG write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         vtd_set_long(s, addr, val);
         vtd_handle_gcmd_write(s);
         break;
 
     /* Context Command Register, 64-bit */
     case DMAR_CCMD_REG:
-        VTD_DPRINTF(CSR, "DMAR_CCMD_REG write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         if (size == 4) {
             vtd_set_long(s, addr, val);
         } else {
@@ -2097,8 +2045,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_CCMD_REG_HI:
-        VTD_DPRINTF(CSR, "DMAR_CCMD_REG_HI write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         assert(size == 4);
         vtd_set_long(s, addr, val);
         vtd_handle_ccmd_write(s);
@@ -2106,8 +2052,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
 
     /* IOTLB Invalidation Register, 64-bit */
     case DMAR_IOTLB_REG:
-        VTD_DPRINTF(INV, "DMAR_IOTLB_REG write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         if (size == 4) {
             vtd_set_long(s, addr, val);
         } else {
@@ -2117,8 +2061,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_IOTLB_REG_HI:
-        VTD_DPRINTF(INV, "DMAR_IOTLB_REG_HI write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         assert(size == 4);
         vtd_set_long(s, addr, val);
         vtd_handle_iotlb_write(s);
@@ -2126,8 +2068,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
 
     /* Invalidate Address Register, 64-bit */
     case DMAR_IVA_REG:
-        VTD_DPRINTF(INV, "DMAR_IVA_REG write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         if (size == 4) {
             vtd_set_long(s, addr, val);
         } else {
@@ -2136,16 +2076,12 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_IVA_REG_HI:
-        VTD_DPRINTF(INV, "DMAR_IVA_REG_HI write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
     /* Fault Status Register, 32-bit */
     case DMAR_FSTS_REG:
-        VTD_DPRINTF(FLOG, "DMAR_FSTS_REG write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         assert(size == 4);
         vtd_set_long(s, addr, val);
         vtd_handle_fsts_write(s);
@@ -2153,8 +2089,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
 
     /* Fault Event Control Register, 32-bit */
     case DMAR_FECTL_REG:
-        VTD_DPRINTF(FLOG, "DMAR_FECTL_REG write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         assert(size == 4);
         vtd_set_long(s, addr, val);
         vtd_handle_fectl_write(s);
@@ -2162,40 +2096,30 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
 
     /* Fault Event Data Register, 32-bit */
     case DMAR_FEDATA_REG:
-        VTD_DPRINTF(FLOG, "DMAR_FEDATA_REG write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
     /* Fault Event Address Register, 32-bit */
     case DMAR_FEADDR_REG:
-        VTD_DPRINTF(FLOG, "DMAR_FEADDR_REG write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
     /* Fault Event Upper Address Register, 32-bit */
     case DMAR_FEUADDR_REG:
-        VTD_DPRINTF(FLOG, "DMAR_FEUADDR_REG write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
     /* Protected Memory Enable Register, 32-bit */
     case DMAR_PMEN_REG:
-        VTD_DPRINTF(CSR, "DMAR_PMEN_REG write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
     /* Root Table Address Register, 64-bit */
     case DMAR_RTADDR_REG:
-        VTD_DPRINTF(CSR, "DMAR_RTADDR_REG write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         if (size == 4) {
             vtd_set_long(s, addr, val);
         } else {
@@ -2204,16 +2128,12 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_RTADDR_REG_HI:
-        VTD_DPRINTF(CSR, "DMAR_RTADDR_REG_HI write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
     /* Invalidation Queue Tail Register, 64-bit */
     case DMAR_IQT_REG:
-        VTD_DPRINTF(INV, "DMAR_IQT_REG write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         if (size == 4) {
             vtd_set_long(s, addr, val);
         } else {
@@ -2223,8 +2143,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_IQT_REG_HI:
-        VTD_DPRINTF(INV, "DMAR_IQT_REG_HI write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         assert(size == 4);
         vtd_set_long(s, addr, val);
         /* 19:63 of IQT_REG is RsvdZ, do nothing here */
@@ -2232,8 +2150,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
 
     /* Invalidation Queue Address Register, 64-bit */
     case DMAR_IQA_REG:
-        VTD_DPRINTF(INV, "DMAR_IQA_REG write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         if (size == 4) {
             vtd_set_long(s, addr, val);
         } else {
@@ -2242,16 +2158,12 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_IQA_REG_HI:
-        VTD_DPRINTF(INV, "DMAR_IQA_REG_HI write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
     /* Invalidation Completion Status Register, 32-bit */
     case DMAR_ICS_REG:
-        VTD_DPRINTF(INV, "DMAR_ICS_REG write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         assert(size == 4);
         vtd_set_long(s, addr, val);
         vtd_handle_ics_write(s);
@@ -2259,8 +2171,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
 
     /* Invalidation Event Control Register, 32-bit */
     case DMAR_IECTL_REG:
-        VTD_DPRINTF(INV, "DMAR_IECTL_REG write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         assert(size == 4);
         vtd_set_long(s, addr, val);
         vtd_handle_iectl_write(s);
@@ -2268,32 +2178,24 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
 
     /* Invalidation Event Data Register, 32-bit */
     case DMAR_IEDATA_REG:
-        VTD_DPRINTF(INV, "DMAR_IEDATA_REG write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
     /* Invalidation Event Address Register, 32-bit */
     case DMAR_IEADDR_REG:
-        VTD_DPRINTF(INV, "DMAR_IEADDR_REG write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
     /* Invalidation Event Upper Address Register, 32-bit */
     case DMAR_IEUADDR_REG:
-        VTD_DPRINTF(INV, "DMAR_IEUADDR_REG write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
     /* Fault Recording Registers, 128-bit */
     case DMAR_FRCD_REG_0_0:
-        VTD_DPRINTF(FLOG, "DMAR_FRCD_REG_0_0 write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         if (size == 4) {
             vtd_set_long(s, addr, val);
         } else {
@@ -2302,15 +2204,11 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_FRCD_REG_0_1:
-        VTD_DPRINTF(FLOG, "DMAR_FRCD_REG_0_1 write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
     case DMAR_FRCD_REG_0_2:
-        VTD_DPRINTF(FLOG, "DMAR_FRCD_REG_0_2 write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         if (size == 4) {
             vtd_set_long(s, addr, val);
         } else {
@@ -2321,8 +2219,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_FRCD_REG_0_3:
-        VTD_DPRINTF(FLOG, "DMAR_FRCD_REG_0_3 write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         assert(size == 4);
         vtd_set_long(s, addr, val);
         /* May clear bit 127 (Fault), update PPF */
@@ -2330,8 +2226,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_IRTA_REG:
-        VTD_DPRINTF(IR, "DMAR_IRTA_REG write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         if (size == 4) {
             vtd_set_long(s, addr, val);
         } else {
@@ -2340,15 +2234,11 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
         break;
 
     case DMAR_IRTA_REG_HI:
-        VTD_DPRINTF(IR, "DMAR_IRTA_REG_HI write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         assert(size == 4);
         vtd_set_long(s, addr, val);
         break;
 
     default:
-        VTD_DPRINTF(GENERAL, "error: unhandled reg write addr 0x%"PRIx64
-                    ", size %d, val 0x%"PRIx64, addr, size, val);
         if (size == 4) {
             vtd_set_long(s, addr, val);
         } else {
@@ -2381,11 +2271,12 @@ static IOMMUTLBEntry vtd_iommu_translate(MemoryRegion *iommu, hwaddr addr,
 
     vtd_do_iommu_translate(vtd_as, vtd_as->bus, vtd_as->devfn, addr,
                            flag & IOMMU_WO, &ret);
-    VTD_DPRINTF(MMU,
-                "bus %"PRIu8 " slot %"PRIu8 " func %"PRIu8 " devfn %"PRIu8
-                " iova 0x%"PRIx64 " hpa 0x%"PRIx64, pci_bus_num(vtd_as->bus),
-                VTD_PCI_SLOT(vtd_as->devfn), VTD_PCI_FUNC(vtd_as->devfn),
-                vtd_as->devfn, addr, ret.translated_addr);
+
+    trace_vtd_dmar_translate(pci_bus_num(vtd_as->bus),
+                             VTD_PCI_SLOT(vtd_as->devfn),
+                             VTD_PCI_FUNC(vtd_as->devfn),
+                             ret.iova, ret.translated_addr, ret.addr_mask);
+
     return ret;
 }
 
@@ -2484,25 +2375,23 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
     addr = iommu->intr_root + index * sizeof(*entry);
     if (dma_memory_read(&address_space_memory, addr, entry,
                         sizeof(*entry))) {
-        VTD_DPRINTF(GENERAL, "error: fail to access IR root at 0x%"PRIx64
-                    " + %"PRIu16, iommu->intr_root, index);
+        trace_vtd_err("Memory read failed for IRTE.");
         return -VTD_FR_IR_ROOT_INVAL;
     }
 
+    trace_vtd_ir_irte_get(index, le64_to_cpu(entry->data[1]),
+                          le64_to_cpu(entry->data[0]));
+
     if (!entry->irte.present) {
-        VTD_DPRINTF(GENERAL, "error: present flag not set in IRTE"
-                    " entry index %u value 0x%"PRIx64 " 0x%"PRIx64,
-                    index, le64_to_cpu(entry->data[1]),
-                    le64_to_cpu(entry->data[0]));
+        trace_vtd_err_irte(index, le64_to_cpu(entry->data[1]),
+                           le64_to_cpu(entry->data[0]));
         return -VTD_FR_IR_ENTRY_P;
     }
 
     if (entry->irte.__reserved_0 || entry->irte.__reserved_1 ||
         entry->irte.__reserved_2) {
-        VTD_DPRINTF(GENERAL, "error: IRTE entry index %"PRIu16
-                    " reserved fields non-zero: 0x%"PRIx64 " 0x%"PRIx64,
-                    index, le64_to_cpu(entry->data[1]),
-                    le64_to_cpu(entry->data[0]));
+        trace_vtd_err_irte(index, le64_to_cpu(entry->data[1]),
+                           le64_to_cpu(entry->data[0]));
         return -VTD_FR_IR_IRTE_RSVD;
     }
 
@@ -2511,15 +2400,12 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
         source_id = le32_to_cpu(entry->irte.source_id);
         switch (entry->irte.sid_vtype) {
         case VTD_SVT_NONE:
-            VTD_DPRINTF(IR, "No SID validation for IRTE index %d", index);
             break;
 
         case VTD_SVT_ALL:
             mask = vtd_svt_mask[entry->irte.sid_q];
             if ((source_id & mask) != (sid & mask)) {
-                VTD_DPRINTF(GENERAL, "SID validation for IRTE index "
-                            "%d failed (reqid 0x%04x sid 0x%04x)", index,
-                            sid, source_id);
+                trace_vtd_err_irte_sid(index, sid, source_id);
                 return -VTD_FR_IR_SID_ERR;
             }
             break;
@@ -2529,16 +2415,13 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
             bus_min = source_id & 0xff;
             bus = sid >> 8;
             if (bus > bus_max || bus < bus_min) {
-                VTD_DPRINTF(GENERAL, "SID validation for IRTE index %d "
-                            "failed (bus %d outside %d-%d)", index, bus,
-                            bus_min, bus_max);
+                trace_vtd_err_irte_sid_bus(index, bus, bus_min, bus_max);
                 return -VTD_FR_IR_SID_ERR;
             }
             break;
 
         default:
-            VTD_DPRINTF(GENERAL, "Invalid SVT bits (0x%x) in IRTE index "
-                        "%d", entry->irte.sid_vtype, index);
+            trace_vtd_err_irte_svt(index, entry->irte.sid_vtype);
             /* Take this as verification failure. */
             return -VTD_FR_IR_SID_ERR;
             break;
@@ -2573,10 +2456,8 @@ static int vtd_remap_irq_get(IntelIOMMUState *iommu, uint16_t index,
     irq->dest_mode = irte.irte.dest_mode;
     irq->redir_hint = irte.irte.redir_hint;
 
-    VTD_DPRINTF(IR, "remapping interrupt index %d: trig:%u,vec:%u,"
-                "deliver:%u,dest:%u,dest_mode:%u", index,
-                irq->trigger_mode, irq->vector, irq->delivery_mode,
-                irq->dest, irq->dest_mode);
+    trace_vtd_ir_remap(index, irq->trigger_mode, irq->vector,
+                       irq->delivery_mode, irq->dest, irq->dest_mode);
 
     return 0;
 }
@@ -2618,22 +2499,21 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState *iommu,
 
     assert(origin && translated);
 
+    trace_vtd_ir_remap_msi_req(origin->address, origin->data);
+
     if (!iommu || !iommu->intr_enabled) {
         goto do_not_translate;
     }
 
     if (origin->address & VTD_MSI_ADDR_HI_MASK) {
-        VTD_DPRINTF(GENERAL, "error: MSI addr high 32 bits nonzero"
-                    " during interrupt remapping: 0x%"PRIx32,
-                    (uint32_t)((origin->address & VTD_MSI_ADDR_HI_MASK) >> \
-                    VTD_MSI_ADDR_HI_SHIFT));
+        trace_vtd_err("MSI address high 32 bits non-zero when "
+                      "Interrupt Remapping enabled.");
         return -VTD_FR_IR_REQ_RSVD;
     }
 
     addr.data = origin->address & VTD_MSI_ADDR_LO_MASK;
     if (addr.addr.__head != 0xfee) {
-        VTD_DPRINTF(GENERAL, "error: MSI addr low 32 bits invalid: "
-                    "0x%"PRIx32, addr.data);
+        trace_vtd_err("MSI addr low 32 bit invalid.");
         return -VTD_FR_IR_REQ_RSVD;
     }
 
@@ -2658,34 +2538,28 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState *iommu,
     }
 
     if (addr.addr.sub_valid) {
-        VTD_DPRINTF(IR, "received MSI interrupt");
+        trace_vtd_ir_remap_type("MSI");
         if (origin->data & VTD_IR_MSI_DATA_RESERVED) {
-            VTD_DPRINTF(GENERAL, "error: MSI data bits non-zero for "
-                        "interrupt remappable entry: 0x%"PRIx32,
-                        origin->data);
+            trace_vtd_err_ir_msi_invalid(sid, origin->address, origin->data);
             return -VTD_FR_IR_REQ_RSVD;
         }
     } else {
         uint8_t vector = origin->data & 0xff;
         uint8_t trigger_mode = (origin->data >> MSI_DATA_TRIGGER_SHIFT) & 0x1;
 
-        VTD_DPRINTF(IR, "received IOAPIC interrupt");
+        trace_vtd_ir_remap_type("IOAPIC");
         /* IOAPIC entry vector should be aligned with IRTE vector
          * (see vt-d spec 5.1.5.1). */
         if (vector != irq.vector) {
-            VTD_DPRINTF(GENERAL, "IOAPIC vector inconsistent: "
-                        "entry: %d, IRTE: %d, index: %d",
-                        vector, irq.vector, index);
+            trace_vtd_warn_ir_vector(sid, index, vector, irq.vector);
         }
 
         /* The Trigger Mode field must match the Trigger Mode in the IRTE.
          * (see vt-d spec 5.1.5.1). */
         if (trigger_mode != irq.trigger_mode) {
-            VTD_DPRINTF(GENERAL, "IOAPIC trigger mode inconsistent: "
-                        "entry: %u, IRTE: %u, index: %d",
-                        trigger_mode, irq.trigger_mode, index);
+            trace_vtd_warn_ir_trigger(sid, index, trigger_mode,
+                                      irq.trigger_mode);
         }
-
     }
 
     /*
@@ -2697,9 +2571,9 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState *iommu,
     /* Translate VTDIrq to MSI message */
     vtd_generate_msi_message(&irq, translated);
 
-    VTD_DPRINTF(IR, "mapping MSI 0x%"PRIx64":0x%"PRIx32 " -> "
-                "0x%"PRIx64":0x%"PRIx32, origin->address, origin->data,
-                translated->address, translated->data);
+    trace_vtd_ir_remap_msi(origin->address, origin->data,
+                           translated->address, translated->data);
+
     return 0;
 
 do_not_translate:
@@ -2740,16 +2614,10 @@ static MemTxResult vtd_mem_ir_write(void *opaque, hwaddr addr,
     ret = vtd_interrupt_remap_msi(opaque, &from, &to, sid);
     if (ret) {
         /* TODO: report error */
-        VTD_DPRINTF(GENERAL, "int remap fail for addr 0x%"PRIx64
-                    " data 0x%"PRIx32, from.address, from.data);
         /* Drop this interrupt */
         return MEMTX_ERROR;
     }
 
-    VTD_DPRINTF(IR, "delivering MSI 0x%"PRIx64":0x%"PRIx32
-                " for device sid 0x%04x",
-                to.address, to.data, sid);
-
     apic_get_class()->send_msi(&to);
 
     return MEMTX_OK;
@@ -3052,7 +2920,6 @@ static void vtd_reset(DeviceState *dev)
 {
     IntelIOMMUState *s = INTEL_IOMMU_DEVICE(dev);
 
-    VTD_DPRINTF(GENERAL, "");
     vtd_init(s);
 
     /*
@@ -3125,7 +2992,6 @@ static void vtd_realize(DeviceState *dev, Error **errp)
     }
 
     bus = pcms->bus;
-    VTD_DPRINTF(GENERAL, "");
     x86_iommu->type = TYPE_INTEL;
 
     if (!vtd_decide_config(s, errp)) {
@@ -3173,7 +3039,6 @@ static const TypeInfo vtd_info = {
 
 static void vtd_register_types(void)
 {
-    VTD_DPRINTF(GENERAL, "");
     type_register_static(&vtd_info);
 }
 
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 72556da..8da20c3 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -19,6 +19,13 @@ vtd_inv_desc_wait_sw(uint64_t addr, uint32_t data) "wait invalidate status write
 vtd_inv_desc_wait_irq(const char *msg) "%s"
 vtd_inv_desc_wait_invalid(uint64_t hi, uint64_t lo) "invalid wait desc hi 0x%"PRIx64" lo 0x%"PRIx64
 vtd_inv_desc_wait_write_fail(uint64_t hi, uint64_t lo) "write fail for wait desc hi 0x%"PRIx64" lo 0x%"PRIx64
+vtd_inv_desc_iec(uint32_t granularity, uint32_t index, uint32_t mask) "granularity 0x%"PRIx32" index 0x%"PRIx32" mask 0x%"PRIx32
+vtd_inv_qi_enable(bool enable) "enabled %d"
+vtd_inv_qi_setup(uint64_t addr, int size) "addr 0x%"PRIx64" size %d"
+vtd_inv_qi_head(uint16_t head) "read head %d"
+vtd_inv_qi_tail(uint16_t head) "write tail %d"
+vtd_inv_qi_fetch(void) ""
+vtd_context_cache_reset(void) ""
 vtd_re_not_present(uint8_t bus) "Root entry bus %"PRIu8" not present"
 vtd_re_invalid(uint64_t hi, uint64_t lo) "invalid root entry hi 0x%"PRIx64" lo 0x%"PRIx64
 vtd_ce_not_present(uint8_t bus, uint8_t devfn) "Context entry bus %"PRIu8" devfn %"PRIu8" not present"
@@ -40,6 +47,42 @@ vtd_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn, bool on) "Device
 vtd_as_unmap_whole(uint8_t bus, uint8_t slot, uint8_t fn, uint64_t iova, uint64_t size) "Device %02x:%02x.%x start 0x%"PRIx64" size 0x%"PRIx64
 vtd_translate_pt(uint16_t sid, uint64_t addr) "source id 0x%"PRIu16", iova 0x%"PRIx64
 vtd_pt_enable_fast_path(uint16_t sid, bool success) "sid 0x%"PRIu16" %d"
+vtd_irq_generate(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" data 0x%"PRIx64
+vtd_reg_read(uint64_t addr, uint64_t size) "addr 0x%"PRIx64" size 0x%"PRIx64
+vtd_reg_write(uint64_t addr, uint64_t size, uint64_t val) "addr 0x%"PRIx64" size 0x%"PRIx64" value 0x%"PRIx64
+vtd_reg_dmar_root(uint64_t addr, bool extended) "addr 0x%"PRIx64" extended %d"
+vtd_reg_ir_root(uint64_t addr, uint32_t size) "addr 0x%"PRIx64" size 0x%"PRIx32
+vtd_reg_write_gcmd(uint32_t status, uint32_t val) "status 0x%"PRIx32" value 0x%"PRIx32
+vtd_reg_write_fectl(uint32_t value) "value 0x%"PRIx32
+vtd_reg_write_iectl(uint32_t value) "value 0x%"PRIx32
+vtd_reg_ics_clear_ip(void) ""
+vtd_dmar_translate(uint8_t bus, uint8_t slot, uint8_t func, uint64_t iova, uint64_t gpa, uint64_t mask) "dev %02x:%02x.%02x iova 0x%"PRIx64" -> gpa 0x%"PRIx64" mask 0x%"PRIx64
+vtd_dmar_enable(bool en) "enable %d"
+vtd_dmar_fault(uint16_t sid, int fault, uint64_t addr, bool is_write) "sid 0x%"PRIx16" fault %d addr 0x%"PRIx64" write %d"
+vtd_ir_enable(bool en) "enable %d"
+vtd_ir_irte_get(int index, uint64_t lo, uint64_t hi) "index %d low 0x%"PRIx64" high 0x%"PRIx64
+vtd_ir_remap(int index, int tri, int vec, int deliver, uint32_t dest, int dest_mode) "index %d trigger %d vector %d deliver %d dest 0x%"PRIx32" mode %d"
+vtd_ir_remap_type(const char *type) "%s"
+vtd_ir_remap_msi(uint64_t addr, uint64_t data, uint64_t addr2, uint64_t data2) "(addr 0x%"PRIx64", data 0x%"PRIx64") -> (addr 0x%"PRIx64", data 0x%"PRIx64")"
+vtd_ir_remap_msi_req(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" data 0x%"PRIx64
+vtd_fsts_ppf(bool set) "FSTS PPF bit set to %d"
+vtd_fsts_clear_ip(void) ""
+vtd_frr_new(int index, uint64_t hi, uint64_t lo) "index %d high 0x%"PRIx64" low 0x%"PRIx64
+vtd_err(const char *str) "%s"
+vtd_err_dmar_iova_overflow(uint64_t iova) "iova 0x%"PRIx64
+vtd_err_dmar_slpte_read_error(uint64_t iova, int level) "iova 0x%"PRIx64" level %d"
+vtd_err_dmar_slpte_perm_error(uint64_t iova, int level, uint64_t slpte, bool is_write) "iova 0x%"PRIx64" level %d slpte 0x%"PRIx64" write %d"
+vtd_err_dmar_slpte_resv_error(uint64_t iova, int level, uint64_t slpte) "iova 0x%"PRIx64" level %d slpte 0x%"PRIx64
+vtd_err_qi_enable(uint16_t tail) "tail 0x%"PRIx16
+vtd_err_qi_disable(uint16_t head, uint16_t tail, int type) "head 0x%"PRIx16" tail 0x%"PRIx16" last_desc_type %d"
+vtd_err_qi_tail(uint16_t tail, uint16_t size) "tail 0x%"PRIx16" size 0x%"PRIx16
+vtd_err_irte(int index, uint64_t lo, uint64_t hi) "index %d low 0x%"PRIx64" high 0x%"PRIx64
+vtd_err_irte_sid(int index, uint16_t req, uint16_t target) "index %d SVT_ALL sid 0x%"PRIx16" (should be: 0x%"PRIx16")"
+vtd_err_irte_sid_bus(int index, uint8_t bus, uint8_t min, uint8_t max) "index %d SVT_BUS bus 0x%"PRIx8" (should be: 0x%"PRIx8"-0x%"PRIx8")"
+vtd_err_irte_svt(int index, int type) "index %d SVT type %d"
+vtd_err_ir_msi_invalid(uint16_t sid, uint64_t addr, uint64_t data) "sid 0x%"PRIx16" addr 0x%"PRIx64" data 0x%"PRIx64
+vtd_warn_ir_vector(uint16_t sid, int index, int vec, int target) "sid 0x%"PRIx16" index %d vec %d (should be: %d)"
+vtd_warn_ir_trigger(uint16_t sid, int index, int trig, int target) "sid 0x%"PRIx16" index %d trigger %d (should be: %d)"
 
 # hw/i386/amd_iommu.c
 amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32
-- 
2.7.4
