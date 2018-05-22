Received: from eggs.gnu.org ([2001:4830:134:3::10]:58018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLEXb-0006vX-7I
	for qemu-devel@nongnu.org; Tue, 22 May 2018 17:09:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLEXX-0000Jj-WE
	for qemu-devel@nongnu.org; Tue, 22 May 2018 17:09:55 -0400
Received: from mail-qt0-x22b.google.com ([2607:f8b0:400d:c0d::22b]:37167)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLEXX-0000JS-Pe
	for qemu-devel@nongnu.org; Tue, 22 May 2018 17:09:51 -0400
Received: by mail-qt0-x22b.google.com with SMTP id q13-v6so25388650qtp.4
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 14:09:51 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180522035629.30428-1-peterx@redhat.com>
	<20180522035629.30428-3-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <583d5b48-bb34-2c47-8e80-6c1142701506@amsat.org>
Date: Tue, 22 May 2018 18:09:46 -0300
MIME-Version: 1.0
In-Reply-To: <20180522035629.30428-3-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] intel-iommu: start to use
 error_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>

Hi Peter,

On 05/22/2018 12:56 AM, Peter Xu wrote:
> Replace existing trace_vtd_err() with error_report_once() then stderr
> will capture something if any of the error happens, meanwhile we don't
> suffer from any DDOS.  Then remove the trace point.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/i386/intel_iommu.c | 34 +++++++++++++++++-----------------
>  hw/i386/trace-events  |  1 -
>  2 files changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index fb31de9416..cf655fb9f6 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -285,14 +285,14 @@ static void vtd_generate_fault_event(IntelIOMMUState *s, uint32_t pre_fsts)
>  {
>      if (pre_fsts & VTD_FSTS_PPF || pre_fsts & VTD_FSTS_PFO ||
>          pre_fsts & VTD_FSTS_IQE) {
> -        trace_vtd_err("There are previous interrupt conditions "
> +        error_report_once("There are previous interrupt conditions "
>                        "to be serviced by software, fault event "
>                        "is not generated.");

Can you keep alignment consistent please?

>          return;
>      }
>      vtd_set_clear_mask_long(s, DMAR_FECTL_REG, 0, VTD_FECTL_IP);
>      if (vtd_get_long_raw(s, DMAR_FECTL_REG) & VTD_FECTL_IM) {
> -        trace_vtd_err("Interrupt Mask set, irq is not generated.");
> +        error_report_once("Interrupt Mask set, irq is not generated.");
>      } else {
>          vtd_generate_interrupt(s, DMAR_FEADDR_REG, DMAR_FEDATA_REG);
>          vtd_set_clear_mask_long(s, DMAR_FECTL_REG, VTD_FECTL_IP, 0);
> @@ -400,19 +400,19 @@ static void vtd_report_dmar_fault(IntelIOMMUState *s, uint16_t source_id,
>      trace_vtd_dmar_fault(source_id, fault, addr, is_write);
>  
>      if (fsts_reg & VTD_FSTS_PFO) {
> -        trace_vtd_err("New fault is not recorded due to "
> +        error_report_once("New fault is not recorded due to "
>                        "Primary Fault Overflow.");
>          return;
>      }
>  
>      if (vtd_try_collapse_fault(s, source_id)) {
> -        trace_vtd_err("New fault is not recorded due to "
> +        error_report_once("New fault is not recorded due to "
>                        "compression of faults.");
>          return;
>      }
>  
>      if (vtd_is_frcd_set(s, s->next_frcd_reg)) {
> -        trace_vtd_err("Next Fault Recording Reg is used, "
> +        error_report_once("Next Fault Recording Reg is used, "
>                        "new fault is not recorded, set PFO field.");
>          vtd_set_clear_mask_long(s, DMAR_FSTS_REG, 0, VTD_FSTS_PFO);
>          return;
> @@ -421,7 +421,7 @@ static void vtd_report_dmar_fault(IntelIOMMUState *s, uint16_t source_id,
>      vtd_record_frcd(s, s->next_frcd_reg, source_id, addr, fault, is_write);
>  
>      if (fsts_reg & VTD_FSTS_PPF) {
> -        trace_vtd_err("There are pending faults already, "
> +        error_report_once("There are pending faults already, "
>                        "fault event is not generated.");
>          vtd_set_frcd_and_update_ppf(s, s->next_frcd_reg);
>          s->next_frcd_reg++;
> @@ -1339,7 +1339,7 @@ static uint64_t vtd_context_cache_invalidate(IntelIOMMUState *s, uint64_t val)
>          break;
>  
>      default:
> -        trace_vtd_err("Context cache invalidate type error.");
> +        error_report_once("Context cache invalidate type error.");
>          caig = 0;
>      }
>      return caig;
> @@ -1445,7 +1445,7 @@ static uint64_t vtd_iotlb_flush(IntelIOMMUState *s, uint64_t val)
>          am = VTD_IVA_AM(addr);
>          addr = VTD_IVA_ADDR(addr);
>          if (am > VTD_MAMV) {
> -            trace_vtd_err("IOTLB PSI flush: address mask overflow.");
> +            error_report_once("IOTLB PSI flush: address mask overflow.");
>              iaig = 0;
>              break;
>          }
> @@ -1454,7 +1454,7 @@ static uint64_t vtd_iotlb_flush(IntelIOMMUState *s, uint64_t val)
>          break;
>  
>      default:
> -        trace_vtd_err("IOTLB flush: invalid granularity.");
> +        error_report_once("IOTLB flush: invalid granularity.");
>          iaig = 0;
>      }
>      return iaig;
> @@ -1604,7 +1604,7 @@ static void vtd_handle_ccmd_write(IntelIOMMUState *s)
>      /* Context-cache invalidation request */
>      if (val & VTD_CCMD_ICC) {
>          if (s->qi_enabled) {
> -            trace_vtd_err("Queued Invalidation enabled, "
> +            error_report_once("Queued Invalidation enabled, "
>                            "should not use register-based invalidation");
>              return;
>          }
> @@ -1625,7 +1625,7 @@ static void vtd_handle_iotlb_write(IntelIOMMUState *s)
>      /* IOTLB invalidation request */
>      if (val & VTD_TLB_IVT) {
>          if (s->qi_enabled) {
> -            trace_vtd_err("Queued Invalidation enabled, "
> +            error_report_once("Queued Invalidation enabled, "
>                            "should not use register-based invalidation.");
>              return;
>          }
> @@ -1644,7 +1644,7 @@ static bool vtd_get_inv_desc(dma_addr_t base_addr, uint32_t offset,
>      dma_addr_t addr = base_addr + offset * sizeof(*inv_desc);
>      if (dma_memory_read(&address_space_memory, addr, inv_desc,
>          sizeof(*inv_desc))) {
> -        trace_vtd_err("Read INV DESC failed.");
> +        error_report_once("Read INV DESC failed.");
>          inv_desc->lo = 0;
>          inv_desc->hi = 0;
>          return false;
> @@ -1999,7 +1999,7 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
>      trace_vtd_reg_read(addr, size);
>  
>      if (addr + size > DMAR_REG_SIZE) {
> -        trace_vtd_err("Read MMIO over range.");
> +        error_report_once("Read MMIO over range.");
>          return (uint64_t)-1;
>      }
>  
> @@ -2050,7 +2050,7 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
>      trace_vtd_reg_write(addr, size, val);
>  
>      if (addr + size > DMAR_REG_SIZE) {
> -        trace_vtd_err("Write MMIO over range.");
> +        error_report_once("Write MMIO over range.");
>          return;
>      }
>  
> @@ -2432,7 +2432,7 @@ static int vtd_irte_get(IntelIOMMUState *iommu, uint16_t index,
>      addr = iommu->intr_root + index * sizeof(*entry);
>      if (dma_memory_read(&address_space_memory, addr, entry,
>                          sizeof(*entry))) {
> -        trace_vtd_err("Memory read failed for IRTE.");
> +        error_report_once("Memory read failed for IRTE.");
>          return -VTD_FR_IR_ROOT_INVAL;
>      }
>  
> @@ -2564,14 +2564,14 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState *iommu,
>      }
>  
>      if (origin->address & VTD_MSI_ADDR_HI_MASK) {
> -        trace_vtd_err("MSI address high 32 bits non-zero when "
> +        error_report_once("MSI address high 32 bits non-zero when "
>                        "Interrupt Remapping enabled.");
>          return -VTD_FR_IR_REQ_RSVD;
>      }
>  
>      addr.data = origin->address & VTD_MSI_ADDR_LO_MASK;
>      if (addr.addr.__head != 0xfee) {
> -        trace_vtd_err("MSI addr low 32 bit invalid.");
> +        error_report_once("MSI addr low 32 bit invalid.");
>          return -VTD_FR_IR_REQ_RSVD;
>      }
>  
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index 22d44648af..e08cf2a9a7 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -68,7 +68,6 @@ vtd_ir_remap_msi_req(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" data 0x%"PR
>  vtd_fsts_ppf(bool set) "FSTS PPF bit set to %d"
>  vtd_fsts_clear_ip(void) ""
>  vtd_frr_new(int index, uint64_t hi, uint64_t lo) "index %d high 0x%"PRIx64" low 0x%"PRIx64
> -vtd_err(const char *str) "%s"
>  vtd_err_dmar_iova_overflow(uint64_t iova) "iova 0x%"PRIx64
>  vtd_err_dmar_slpte_read_error(uint64_t iova, int level) "iova 0x%"PRIx64" level %d"
>  vtd_err_dmar_slpte_perm_error(uint64_t iova, int level, uint64_t slpte, bool is_write) "iova 0x%"PRIx64" level %d slpte 0x%"PRIx64" write %d"
> 
