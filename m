Received: from eggs.gnu.org ([2001:4830:134:3::10]:44778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuHHi-0007G4-BJ
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 09:10:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuHHf-000159-5t
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 09:10:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fuHHe-000146-Sb
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 09:10:19 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180815095328.32414-1-peterx@redhat.com>
	<20180815095328.32414-3-peterx@redhat.com>
Date: Mon, 27 Aug 2018 15:10:16 +0200
In-Reply-To: <20180815095328.32414-3-peterx@redhat.com> (Peter Xu's message of
	"Wed, 15 Aug 2018 17:53:27 +0800")
Message-ID: <87a7p8t0p3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 2/3] intel-iommu: start to use
 error_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> Replace existing trace_vtd_err() with error_report_once() then stderr
> will capture something if any of the error happens, meanwhile we don't
> suffer from any DDOS.  Then remove the trace point.  Since at it,
> provide more information where proper (now we can pass parameters into
> the report function).
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/i386/intel_iommu.c | 64 ++++++++++++++++++++++++-------------------
>  hw/i386/trace-events  |  1 -
>  2 files changed, 36 insertions(+), 29 deletions(-)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 0a8cd4e9cc..ed66ca78f5 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -311,14 +311,14 @@ static void vtd_generate_fault_event(IntelIOMMUState *s, uint32_t pre_fsts)
>  {
>      if (pre_fsts & VTD_FSTS_PPF || pre_fsts & VTD_FSTS_PFO ||
>          pre_fsts & VTD_FSTS_IQE) {
> -        trace_vtd_err("There are previous interrupt conditions "
> -                      "to be serviced by software, fault event "
> -                      "is not generated.");
> +        error_report_once("There are previous interrupt conditions "
> +                          "to be serviced by software, fault event "
> +                          "is not generated");
>          return;
>      }
>      vtd_set_clear_mask_long(s, DMAR_FECTL_REG, 0, VTD_FECTL_IP);
>      if (vtd_get_long_raw(s, DMAR_FECTL_REG) & VTD_FECTL_IM) {
> -        trace_vtd_err("Interrupt Mask set, irq is not generated.");
> +        error_report_once("Interrupt Mask set, irq is not generated");
>      } else {
>          vtd_generate_interrupt(s, DMAR_FEADDR_REG, DMAR_FEDATA_REG);
>          vtd_set_clear_mask_long(s, DMAR_FECTL_REG, VTD_FECTL_IP, 0);
> @@ -426,20 +426,20 @@ static void vtd_report_dmar_fault(IntelIOMMUState *s, uint16_t source_id,
>      trace_vtd_dmar_fault(source_id, fault, addr, is_write);
>  
>      if (fsts_reg & VTD_FSTS_PFO) {
> -        trace_vtd_err("New fault is not recorded due to "
> -                      "Primary Fault Overflow.");
> +        error_report_once("New fault is not recorded due to "
> +                          "Primary Fault Overflow");
>          return;
>      }
>  
>      if (vtd_try_collapse_fault(s, source_id)) {
> -        trace_vtd_err("New fault is not recorded due to "
> -                      "compression of faults.");
> +        error_report_once("New fault is not recorded due to "
> +                          "compression of faults");
>          return;
>      }
>  
>      if (vtd_is_frcd_set(s, s->next_frcd_reg)) {
> -        trace_vtd_err("Next Fault Recording Reg is used, "
> -                      "new fault is not recorded, set PFO field.");
> +        error_report_once("Next Fault Recording Reg is used, "
> +                          "new fault is not recorded, set PFO field");
>          vtd_set_clear_mask_long(s, DMAR_FSTS_REG, 0, VTD_FSTS_PFO);
>          return;
>      }
> @@ -447,8 +447,8 @@ static void vtd_report_dmar_fault(IntelIOMMUState *s, uint16_t source_id,
>      vtd_record_frcd(s, s->next_frcd_reg, source_id, addr, fault, is_write);
>  
>      if (fsts_reg & VTD_FSTS_PPF) {
> -        trace_vtd_err("There are pending faults already, "
> -                      "fault event is not generated.");
> +        error_report_once("There are pending faults already, "
> +                          "fault event is not generated");
>          vtd_set_frcd_and_update_ppf(s, s->next_frcd_reg);
>          s->next_frcd_reg++;
>          if (s->next_frcd_reg == DMAR_FRCD_REG_NR) {
> @@ -1056,8 +1056,9 @@ static int vtd_sync_shadow_page_table_range(VTDAddressSpace *vtd_as,
>               * we just skip the sync for this time.  After all we even
>               * don't have the root table pointer!
>               */
> -            trace_vtd_err("Detected invalid context entry when "
> -                          "trying to sync shadow page table");
> +            error_report_once("%s: invalid context entry for bus 0x%" PRIx16
> +                              "devfn 0x%" PRIx16, __func__,
> +                              pci_bus_num(vtd_as->bus), vtd_as->devfn);

"%" PRIx16 is wrong both times: pci_bus_num() returns int, and devfn is
uint8_t.  Plain "%x" works for anything narrower than int, so let's use
that.

>              return 0;
>          }
>      }
> @@ -1514,7 +1515,8 @@ static uint64_t vtd_context_cache_invalidate(IntelIOMMUState *s, uint64_t val)
>          break;
>  
>      default:
> -        trace_vtd_err("Context cache invalidate type error.");
> +        error_report_once("%s: invalid context: 0x%"PRIx64,

While there, let's add spaces around PRIx64 & friends.

> +                          __func__, val);
>          caig = 0;
>      }
>      return caig;
[...]

Squashing in:

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index ed66ca78f5..9c0f525408 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1056,9 +1056,10 @@ static int vtd_sync_shadow_page_table_range(VTDAddressSpace *vtd_as,
              * we just skip the sync for this time.  After all we even
              * don't have the root table pointer!
              */
-            error_report_once("%s: invalid context entry for bus 0x%" PRIx16
-                              "devfn 0x%" PRIx16, __func__,
-                              pci_bus_num(vtd_as->bus), vtd_as->devfn);
+            error_report_once("%s: invalid context entry for bus 0x%x"
+                              " devfn 0x%x",
+                              __func__, pci_bus_num(vtd_as->bus),
+                              vtd_as->devfn);
             return 0;
         }
     }
@@ -1515,7 +1516,7 @@ static uint64_t vtd_context_cache_invalidate(IntelIOMMUState *s, uint64_t val)
         break;
 
     default:
-        error_report_once("%s: invalid context: 0x%"PRIx64,
+        error_report_once("%s: invalid context: 0x%" PRIx64,
                           __func__, val);
         caig = 0;
     }
@@ -1636,7 +1637,7 @@ static uint64_t vtd_iotlb_flush(IntelIOMMUState *s, uint64_t val)
         am = VTD_IVA_AM(addr);
         addr = VTD_IVA_ADDR(addr);
         if (am > VTD_MAMV) {
-            error_report_once("%s: address mask overflow: 0x%"PRIx64,
+            error_report_once("%s: address mask overflow: 0x%" PRIx64,
                               __func__, vtd_get_quad_raw(s, DMAR_IVA_REG));
             iaig = 0;
             break;
@@ -1646,7 +1647,7 @@ static uint64_t vtd_iotlb_flush(IntelIOMMUState *s, uint64_t val)
         break;
 
     default:
-        error_report_once("%s: invalid granularity: 0x%"PRIx64,
+        error_report_once("%s: invalid granularity: 0x%" PRIx64,
                           __func__, val);
         iaig = 0;
     }
@@ -2192,7 +2193,7 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
     trace_vtd_reg_read(addr, size);
 
     if (addr + size > DMAR_REG_SIZE) {
-        error_report_once("%s: MMIO over range: addr=0x%"PRIx64
+        error_report_once("%s: MMIO over range: addr=0x%" PRIx64
                           " size=0x%u", __func__, addr, size);
         return (uint64_t)-1;
     }
@@ -2244,7 +2245,7 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
     trace_vtd_reg_write(addr, size, val);
 
     if (addr + size > DMAR_REG_SIZE) {
-        error_report_once("%s: MMIO over range: addr=0x%"PRIx64
+        error_report_once("%s: MMIO over range: addr=0x%" PRIx64
                           " size=0x%u", __func__, addr, size);
         return;
     }
@@ -2616,8 +2617,8 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
     addr = iommu->intr_root + index * sizeof(*entry);
     if (dma_memory_read(&address_space_memory, addr, entry,
                         sizeof(*entry))) {
-        error_report_once("%s: read failed: ind=0x%"PRIu16
-                          " addr=0x%"PRIx64, __func__, index, addr);
+        error_report_once("%s: read failed: ind=0x%x addr=0x%" PRIx64,
+                          __func__, index, addr);
         return -VTD_FR_IR_ROOT_INVAL;
     }
 
@@ -2750,13 +2751,13 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState *iommu,
 
     if (origin->address & VTD_MSI_ADDR_HI_MASK) {
         error_report_once("%s: MSI address high 32 bits non-zero detected: "
-                          "address=0x%"PRIx64, __func__, origin->address);
+                          "address=0x%" PRIx64, __func__, origin->address);
         return -VTD_FR_IR_REQ_RSVD;
     }
 
     addr.data = origin->address & VTD_MSI_ADDR_LO_MASK;
     if (addr.addr.__head != 0xfee) {
-        error_report_once("%s: MSI address low 32 bit invalid: 0x%"PRIx32,
+        error_report_once("%s: MSI address low 32 bit invalid: 0x%" PRIx32,
                           __func__, addr.data);
         return -VTD_FR_IR_REQ_RSVD;
     }
