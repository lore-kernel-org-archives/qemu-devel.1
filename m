Received: from eggs.gnu.org ([2001:4830:134:3::10]:50703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuAnC-0007bE-1Y
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 02:14:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuAgm-0002x3-3I
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 02:07:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38976 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fuAgl-0002wa-S4
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 02:07:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 81F3F40216EF
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 06:07:47 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Aug 2018 08:07:43 +0200
Message-Id: <20180827060744.13770-3-armbru@redhat.com>
In-Reply-To: <20180827060744.13770-1-armbru@redhat.com>
References: <20180827060744.13770-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/3] intel-iommu: start to use error_report_once
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

Replace existing trace_vtd_err() with error_report_once() then stderr
will capture something if any of the error happens, meanwhile we don't
suffer from any DDOS.  Then remove the trace point.  Since at it,
provide more information where proper (now we can pass parameters into
the report function).

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180815095328.32414-3-peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/i386/intel_iommu.c | 64 ++++++++++++++++++++++++-------------------
 hw/i386/trace-events  |  1 -
 2 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 0a8cd4e9cc..ed66ca78f5 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -311,14 +311,14 @@ static void vtd_generate_fault_event(IntelIOMMUStat=
e *s, uint32_t pre_fsts)
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
@@ -426,20 +426,20 @@ static void vtd_report_dmar_fault(IntelIOMMUState *=
s, uint16_t source_id,
     trace_vtd_dmar_fault(source_id, fault, addr, is_write);
=20
     if (fsts_reg & VTD_FSTS_PFO) {
-        trace_vtd_err("New fault is not recorded due to "
-                      "Primary Fault Overflow.");
+        error_report_once("New fault is not recorded due to "
+                          "Primary Fault Overflow");
         return;
     }
=20
     if (vtd_try_collapse_fault(s, source_id)) {
-        trace_vtd_err("New fault is not recorded due to "
-                      "compression of faults.");
+        error_report_once("New fault is not recorded due to "
+                          "compression of faults");
         return;
     }
=20
     if (vtd_is_frcd_set(s, s->next_frcd_reg)) {
-        trace_vtd_err("Next Fault Recording Reg is used, "
-                      "new fault is not recorded, set PFO field.");
+        error_report_once("Next Fault Recording Reg is used, "
+                          "new fault is not recorded, set PFO field");
         vtd_set_clear_mask_long(s, DMAR_FSTS_REG, 0, VTD_FSTS_PFO);
         return;
     }
@@ -447,8 +447,8 @@ static void vtd_report_dmar_fault(IntelIOMMUState *s,=
 uint16_t source_id,
     vtd_record_frcd(s, s->next_frcd_reg, source_id, addr, fault, is_writ=
e);
=20
     if (fsts_reg & VTD_FSTS_PPF) {
-        trace_vtd_err("There are pending faults already, "
-                      "fault event is not generated.");
+        error_report_once("There are pending faults already, "
+                          "fault event is not generated");
         vtd_set_frcd_and_update_ppf(s, s->next_frcd_reg);
         s->next_frcd_reg++;
         if (s->next_frcd_reg =3D=3D DMAR_FRCD_REG_NR) {
@@ -1056,8 +1056,9 @@ static int vtd_sync_shadow_page_table_range(VTDAddr=
essSpace *vtd_as,
              * we just skip the sync for this time.  After all we even
              * don't have the root table pointer!
              */
-            trace_vtd_err("Detected invalid context entry when "
-                          "trying to sync shadow page table");
+            error_report_once("%s: invalid context entry for bus 0x%" PR=
Ix16
+                              "devfn 0x%" PRIx16, __func__,
+                              pci_bus_num(vtd_as->bus), vtd_as->devfn);
             return 0;
         }
     }
@@ -1514,7 +1515,8 @@ static uint64_t vtd_context_cache_invalidate(IntelI=
OMMUState *s, uint64_t val)
         break;
=20
     default:
-        trace_vtd_err("Context cache invalidate type error.");
+        error_report_once("%s: invalid context: 0x%"PRIx64,
+                          __func__, val);
         caig =3D 0;
     }
     return caig;
@@ -1634,7 +1636,8 @@ static uint64_t vtd_iotlb_flush(IntelIOMMUState *s,=
 uint64_t val)
         am =3D VTD_IVA_AM(addr);
         addr =3D VTD_IVA_ADDR(addr);
         if (am > VTD_MAMV) {
-            trace_vtd_err("IOTLB PSI flush: address mask overflow.");
+            error_report_once("%s: address mask overflow: 0x%"PRIx64,
+                              __func__, vtd_get_quad_raw(s, DMAR_IVA_REG=
));
             iaig =3D 0;
             break;
         }
@@ -1643,7 +1646,8 @@ static uint64_t vtd_iotlb_flush(IntelIOMMUState *s,=
 uint64_t val)
         break;
=20
     default:
-        trace_vtd_err("IOTLB flush: invalid granularity.");
+        error_report_once("%s: invalid granularity: 0x%"PRIx64,
+                          __func__, val);
         iaig =3D 0;
     }
     return iaig;
@@ -1793,8 +1797,8 @@ static void vtd_handle_ccmd_write(IntelIOMMUState *=
s)
     /* Context-cache invalidation request */
     if (val & VTD_CCMD_ICC) {
         if (s->qi_enabled) {
-            trace_vtd_err("Queued Invalidation enabled, "
-                          "should not use register-based invalidation");
+            error_report_once("Queued Invalidation enabled, "
+                              "should not use register-based invalidatio=
n");
             return;
         }
         ret =3D vtd_context_cache_invalidate(s, val);
@@ -1814,8 +1818,8 @@ static void vtd_handle_iotlb_write(IntelIOMMUState =
*s)
     /* IOTLB invalidation request */
     if (val & VTD_TLB_IVT) {
         if (s->qi_enabled) {
-            trace_vtd_err("Queued Invalidation enabled, "
-                          "should not use register-based invalidation.")=
;
+            error_report_once("Queued Invalidation enabled, "
+                              "should not use register-based invalidatio=
n");
             return;
         }
         ret =3D vtd_iotlb_flush(s, val);
@@ -1833,7 +1837,7 @@ static bool vtd_get_inv_desc(dma_addr_t base_addr, =
uint32_t offset,
     dma_addr_t addr =3D base_addr + offset * sizeof(*inv_desc);
     if (dma_memory_read(&address_space_memory, addr, inv_desc,
         sizeof(*inv_desc))) {
-        trace_vtd_err("Read INV DESC failed.");
+        error_report_once("Read INV DESC failed");
         inv_desc->lo =3D 0;
         inv_desc->hi =3D 0;
         return false;
@@ -2188,7 +2192,8 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr a=
ddr, unsigned size)
     trace_vtd_reg_read(addr, size);
=20
     if (addr + size > DMAR_REG_SIZE) {
-        trace_vtd_err("Read MMIO over range.");
+        error_report_once("%s: MMIO over range: addr=3D0x%"PRIx64
+                          " size=3D0x%u", __func__, addr, size);
         return (uint64_t)-1;
     }
=20
@@ -2239,7 +2244,8 @@ static void vtd_mem_write(void *opaque, hwaddr addr=
,
     trace_vtd_reg_write(addr, size, val);
=20
     if (addr + size > DMAR_REG_SIZE) {
-        trace_vtd_err("Write MMIO over range.");
+        error_report_once("%s: MMIO over range: addr=3D0x%"PRIx64
+                          " size=3D0x%u", __func__, addr, size);
         return;
     }
=20
@@ -2610,7 +2616,8 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uin=
t16_t index,
     addr =3D iommu->intr_root + index * sizeof(*entry);
     if (dma_memory_read(&address_space_memory, addr, entry,
                         sizeof(*entry))) {
-        trace_vtd_err("Memory read failed for IRTE.");
+        error_report_once("%s: read failed: ind=3D0x%"PRIu16
+                          " addr=3D0x%"PRIx64, __func__, index, addr);
         return -VTD_FR_IR_ROOT_INVAL;
     }
=20
@@ -2742,14 +2749,15 @@ static int vtd_interrupt_remap_msi(IntelIOMMUStat=
e *iommu,
     }
=20
     if (origin->address & VTD_MSI_ADDR_HI_MASK) {
-        trace_vtd_err("MSI address high 32 bits non-zero when "
-                      "Interrupt Remapping enabled.");
+        error_report_once("%s: MSI address high 32 bits non-zero detecte=
d: "
+                          "address=3D0x%"PRIx64, __func__, origin->addre=
ss);
         return -VTD_FR_IR_REQ_RSVD;
     }
=20
     addr.data =3D origin->address & VTD_MSI_ADDR_LO_MASK;
     if (addr.addr.__head !=3D 0xfee) {
-        trace_vtd_err("MSI addr low 32 bit invalid.");
+        error_report_once("%s: MSI address low 32 bit invalid: 0x%"PRIx3=
2,
+                          __func__, addr.data);
         return -VTD_FR_IR_REQ_RSVD;
     }
=20
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index e14d06ec83..922431b1bb 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -69,7 +69,6 @@ vtd_ir_remap_msi_req(uint64_t addr, uint64_t data) "add=
r 0x%"PRIx64" data 0x%"PR
 vtd_fsts_ppf(bool set) "FSTS PPF bit set to %d"
 vtd_fsts_clear_ip(void) ""
 vtd_frr_new(int index, uint64_t hi, uint64_t lo) "index %d high 0x%"PRIx=
64" low 0x%"PRIx64
-vtd_err(const char *str) "%s"
 vtd_err_dmar_iova_overflow(uint64_t iova) "iova 0x%"PRIx64
 vtd_err_dmar_slpte_read_error(uint64_t iova, int level) "iova 0x%"PRIx64=
" level %d"
 vtd_err_dmar_slpte_perm_error(uint64_t iova, int level, uint64_t slpte, =
bool is_write) "iova 0x%"PRIx64" level %d slpte 0x%"PRIx64" write %d"
--=20
2.17.1
