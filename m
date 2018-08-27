Received: from eggs.gnu.org ([2001:4830:134:3::10]:50703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuAnA-0007bE-P6
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 02:14:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuAgm-0002wt-2e
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 02:07:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51758 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fuAgl-0002wW-QC
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 02:07:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7CD0240201BE
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 06:07:47 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Aug 2018 08:07:44 +0200
Message-Id: <20180827060744.13770-4-armbru@redhat.com>
In-Reply-To: <20180827060744.13770-1-armbru@redhat.com>
References: <20180827060744.13770-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 3/3] intel-iommu: replace more vtd_err_* traces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

Replace all the trace_vtd_err_*() hooks with the new error_report_once()
since they are similar to trace_vtd_err() - dumping the first error
would be mostly enough, then we have them on by default too.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180815095328.32414-4-peterx@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/i386/intel_iommu.c | 63 ++++++++++++++++++++++++++++++-------------
 hw/i386/trace-events  | 12 ---------
 2 files changed, 45 insertions(+), 30 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index ed66ca78f5..9e4e7ed3bb 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -705,7 +705,8 @@ static int vtd_iova_to_slpte(VTDContextEntry *ce, uint64_t iova, bool is_write,
     uint64_t access_right_check;
 
     if (!vtd_iova_range_check(iova, ce, aw_bits)) {
-        trace_vtd_err_dmar_iova_overflow(iova);
+        error_report_once("%s: detected IOVA overflow (iova=0x%"PRIx64")",
+                          __func__, iova);
         return -VTD_FR_ADDR_BEYOND_MGAW;
     }
 
@@ -717,7 +718,8 @@ static int vtd_iova_to_slpte(VTDContextEntry *ce, uint64_t iova, bool is_write,
         slpte = vtd_get_slpte(addr, offset);
 
         if (slpte == (uint64_t)-1) {
-            trace_vtd_err_dmar_slpte_read_error(iova, level);
+            error_report_once("%s: detected read error on DMAR slpte "
+                              "(iova=0x%"PRIx64")", __func__, iova);
             if (level == vtd_ce_get_level(ce)) {
                 /* Invalid programming of context-entry */
                 return -VTD_FR_CONTEXT_ENTRY_INV;
@@ -728,11 +730,17 @@ static int vtd_iova_to_slpte(VTDContextEntry *ce, uint64_t iova, bool is_write,
         *reads = (*reads) && (slpte & VTD_SL_R);
         *writes = (*writes) && (slpte & VTD_SL_W);
         if (!(slpte & access_right_check)) {
-            trace_vtd_err_dmar_slpte_perm_error(iova, level, slpte, is_write);
+            error_report_once("%s: detected slpte permission error "
+                              "(iova=0x%"PRIx64", level=0x%"PRIx32", "
+                              "slpte=0x%"PRIx64", write=%d)", __func__,
+                              iova, level, slpte, is_write);
             return is_write ? -VTD_FR_WRITE : -VTD_FR_READ;
         }
         if (vtd_slpte_nonzero_rsvd(slpte, level)) {
-            trace_vtd_err_dmar_slpte_resv_error(iova, level, slpte);
+            error_report_once("%s: detected splte reserve non-zero "
+                              "iova=0x%"PRIx64", level=0x%"PRIx32
+                              "slpte=0x%"PRIx64")", __func__, iova,
+                              level, slpte);
             return -VTD_FR_PAGING_ENTRY_RSVD;
         }
 
@@ -1696,7 +1704,10 @@ static void vtd_handle_gcmd_qie(IntelIOMMUState *s, bool en)
             /* Ok - report back to driver */
             vtd_set_clear_mask_long(s, DMAR_GSTS_REG, VTD_GSTS_QIES, 0);
         } else {
-            trace_vtd_err_qi_disable(s->iq_head, s->iq_tail, s->iq_last_desc_type);
+            error_report_once("%s: detected improper state when disable QI "
+                              "(head=0x%"PRIx16", tail=0x%"PRIx16", "
+                              "last_type=%d)", __func__, s->iq_head,
+                              s->iq_tail, s->iq_last_desc_type);
         }
     }
 }
@@ -2093,7 +2104,9 @@ static void vtd_fetch_inv_desc(IntelIOMMUState *s)
 
     if (s->iq_tail >= s->iq_size) {
         /* Detects an invalid Tail pointer */
-        trace_vtd_err_qi_tail(s->iq_tail, s->iq_size);
+        error_report_once("%s: detected invalid QI tail "
+                          "(tail=0x%"PRIx16", size=0x%"PRIx16")",
+                          __func__, s->iq_tail, s->iq_size);
         vtd_handle_inv_queue_error(s);
         return;
     }
@@ -2506,10 +2519,12 @@ static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
                                  iotlb.iova, iotlb.translated_addr,
                                  iotlb.addr_mask);
     } else {
-        trace_vtd_err_dmar_translate(pci_bus_num(vtd_as->bus),
-                                     VTD_PCI_SLOT(vtd_as->devfn),
-                                     VTD_PCI_FUNC(vtd_as->devfn),
-                                     iotlb.iova);
+        error_report_once("%s: detected translation failure "
+                          "(dev=%02x:%02x:%02x, iova=0x%"PRIx64")",
+                          __func__, pci_bus_num(vtd_as->bus),
+                          VTD_PCI_SLOT(vtd_as->devfn),
+                          VTD_PCI_FUNC(vtd_as->devfn),
+                          iotlb.iova);
     }
 
     return iotlb;
@@ -2625,15 +2640,19 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
                           le64_to_cpu(entry->data[0]));
 
     if (!entry->irte.present) {
-        trace_vtd_err_irte(index, le64_to_cpu(entry->data[1]),
-                           le64_to_cpu(entry->data[0]));
+        error_report_once("%s: detected non-present IRTE "
+                          "(index=%u, high=0x%"PRIx64", low=0x%"PRIx64")",
+                          __func__, index, le64_to_cpu(entry->data[1]),
+                          le64_to_cpu(entry->data[0]));
         return -VTD_FR_IR_ENTRY_P;
     }
 
     if (entry->irte.__reserved_0 || entry->irte.__reserved_1 ||
         entry->irte.__reserved_2) {
-        trace_vtd_err_irte(index, le64_to_cpu(entry->data[1]),
-                           le64_to_cpu(entry->data[0]));
+        error_report_once("%s: detected non-zero reserved IRTE "
+                          "(index=%u, high=0x%"PRIx64", low=0x%"PRIx64")",
+                          __func__, index, le64_to_cpu(entry->data[1]),
+                          le64_to_cpu(entry->data[0]));
         return -VTD_FR_IR_IRTE_RSVD;
     }
 
@@ -2647,7 +2666,9 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
         case VTD_SVT_ALL:
             mask = vtd_svt_mask[entry->irte.sid_q];
             if ((source_id & mask) != (sid & mask)) {
-                trace_vtd_err_irte_sid(index, sid, source_id);
+                error_report_once("%s: invalid IRTE SID "
+                                  "(index=%u, sid=%u, source_id=%u)",
+                                  __func__, index, sid, source_id);
                 return -VTD_FR_IR_SID_ERR;
             }
             break;
@@ -2657,13 +2678,17 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
             bus_min = source_id & 0xff;
             bus = sid >> 8;
             if (bus > bus_max || bus < bus_min) {
-                trace_vtd_err_irte_sid_bus(index, bus, bus_min, bus_max);
+                error_report_once("%s: invalid SVT_BUS "
+                                  "(index=%u, bus=%u, min=%u, max=%u)",
+                                  __func__, index, bus, bus_min, bus_max);
                 return -VTD_FR_IR_SID_ERR;
             }
             break;
 
         default:
-            trace_vtd_err_irte_svt(index, entry->irte.sid_vtype);
+            error_report_once("%s: detected invalid IRTE SVT "
+                              "(index=%u, type=%d)", __func__,
+                              index, entry->irte.sid_vtype);
             /* Take this as verification failure. */
             return -VTD_FR_IR_SID_ERR;
             break;
@@ -2785,7 +2810,9 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState *iommu,
     if (addr.addr.sub_valid) {
         trace_vtd_ir_remap_type("MSI");
         if (origin->data & VTD_IR_MSI_DATA_RESERVED) {
-            trace_vtd_err_ir_msi_invalid(sid, origin->address, origin->data);
+            error_report_once("%s: invalid IR MSI "
+                              "(sid=%u, address=0x%"PRIx64", data=0x%"PRIx32")",
+                              __func__, sid, origin->address, origin->data);
             return -VTD_FR_IR_REQ_RSVD;
         }
     } else {
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 922431b1bb..9e6fc4dca9 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -69,19 +69,7 @@ vtd_ir_remap_msi_req(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" data 0x%"PR
 vtd_fsts_ppf(bool set) "FSTS PPF bit set to %d"
 vtd_fsts_clear_ip(void) ""
 vtd_frr_new(int index, uint64_t hi, uint64_t lo) "index %d high 0x%"PRIx64" low 0x%"PRIx64
-vtd_err_dmar_iova_overflow(uint64_t iova) "iova 0x%"PRIx64
-vtd_err_dmar_slpte_read_error(uint64_t iova, int level) "iova 0x%"PRIx64" level %d"
-vtd_err_dmar_slpte_perm_error(uint64_t iova, int level, uint64_t slpte, bool is_write) "iova 0x%"PRIx64" level %d slpte 0x%"PRIx64" write %d"
-vtd_err_dmar_slpte_resv_error(uint64_t iova, int level, uint64_t slpte) "iova 0x%"PRIx64" level %d slpte 0x%"PRIx64
-vtd_err_dmar_translate(uint8_t bus, uint8_t slot, uint8_t func, uint64_t iova) "dev %02x:%02x.%02x iova 0x%"PRIx64
 vtd_warn_invalid_qi_tail(uint16_t tail) "tail 0x%"PRIx16
-vtd_err_qi_disable(uint16_t head, uint16_t tail, int type) "head 0x%"PRIx16" tail 0x%"PRIx16" last_desc_type %d"
-vtd_err_qi_tail(uint16_t tail, uint16_t size) "tail 0x%"PRIx16" size 0x%"PRIx16
-vtd_err_irte(int index, uint64_t lo, uint64_t hi) "index %d low 0x%"PRIx64" high 0x%"PRIx64
-vtd_err_irte_sid(int index, uint16_t req, uint16_t target) "index %d SVT_ALL sid 0x%"PRIx16" (should be: 0x%"PRIx16")"
-vtd_err_irte_sid_bus(int index, uint8_t bus, uint8_t min, uint8_t max) "index %d SVT_BUS bus 0x%"PRIx8" (should be: 0x%"PRIx8"-0x%"PRIx8")"
-vtd_err_irte_svt(int index, int type) "index %d SVT type %d"
-vtd_err_ir_msi_invalid(uint16_t sid, uint64_t addr, uint64_t data) "sid 0x%"PRIx16" addr 0x%"PRIx64" data 0x%"PRIx64
 vtd_warn_ir_vector(uint16_t sid, int index, int vec, int target) "sid 0x%"PRIx16" index %d vec %d (should be: %d)"
 vtd_warn_ir_trigger(uint16_t sid, int index, int trig, int target) "sid 0x%"PRIx16" index %d trigger %d (should be: %d)"
 
-- 
2.17.1
