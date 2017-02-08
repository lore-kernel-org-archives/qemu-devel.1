Received: from eggs.gnu.org ([2001:4830:134:3::10]:53430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cbIIB-0007jB-6Y
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 21:47:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cbII8-0007Nz-3r
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 21:47:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cbII7-0007NM-RD
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 21:47:32 -0500
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
	<1486456099-7345-8-git-send-email-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8376ce3f-539d-8d45-dd90-17d3de3b1d4d@redhat.com>
Date: Wed, 8 Feb 2017 10:47:22 +0800
MIME-Version: 1.0
In-Reply-To: <1486456099-7345-8-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 07/17] intel_iommu: convert dbg macros
 to traces for inv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, alex.williamson@redhat.com, bd.aviv@gmail.com, David Gibson <david@gibson.dropbear.id.au>



On 2017=E5=B9=B402=E6=9C=8807=E6=97=A5 16:28, Peter Xu wrote:
> VT-d codes are still using static DEBUG_INTEL_IOMMU macro. That's not
> good, and we should end the day when we need to recompile the code
> before getting useful debugging information for vt-d. Time to switch to
> the trace system. This is the first patch to do it.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/i386/intel_iommu.c | 95 +++++++++++++++++++++---------------------=
---------
>   hw/i386/trace-events  | 18 ++++++++++
>   2 files changed, 56 insertions(+), 57 deletions(-)

Reviewed-by: Jason Wang <jasowang@redhat.com>

> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 0c94b79..08e43b6 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -35,6 +35,7 @@
>   #include "sysemu/kvm.h"
>   #include "hw/i386/apic_internal.h"
>   #include "kvm_i386.h"
> +#include "trace.h"
>  =20
>   /*#define DEBUG_INTEL_IOMMU*/
>   #ifdef DEBUG_INTEL_IOMMU
> @@ -474,22 +475,19 @@ static void vtd_handle_inv_queue_error(IntelIOMMU=
State *s)
>   /* Set the IWC field and try to generate an invalidation completion i=
nterrupt */
>   static void vtd_generate_completion_event(IntelIOMMUState *s)
>   {
> -    VTD_DPRINTF(INV, "completes an invalidation wait command with "
> -                "Interrupt Flag");
>       if (vtd_get_long_raw(s, DMAR_ICS_REG) & VTD_ICS_IWC) {
> -        VTD_DPRINTF(INV, "there is a previous interrupt condition to b=
e "
> -                    "serviced by software, "
> -                    "new invalidation event is not generated");
> +        trace_vtd_inv_desc_wait_irq("One pending, skip current");
>           return;
>       }
>       vtd_set_clear_mask_long(s, DMAR_ICS_REG, 0, VTD_ICS_IWC);
>       vtd_set_clear_mask_long(s, DMAR_IECTL_REG, 0, VTD_IECTL_IP);
>       if (vtd_get_long_raw(s, DMAR_IECTL_REG) & VTD_IECTL_IM) {
> -        VTD_DPRINTF(INV, "IM filed in IECTL_REG is set, new invalidati=
on "
> -                    "event is not generated");
> +        trace_vtd_inv_desc_wait_irq("IM in IECTL_REG is set, "
> +                                    "new event not generated");
>           return;
>       } else {
>           /* Generate the interrupt event */
> +        trace_vtd_inv_desc_wait_irq("Generating complete event");
>           vtd_generate_interrupt(s, DMAR_IEADDR_REG, DMAR_IEDATA_REG);
>           vtd_set_clear_mask_long(s, DMAR_IECTL_REG, VTD_IECTL_IP, 0);
>       }
> @@ -923,6 +921,7 @@ static void vtd_interrupt_remap_table_setup(IntelIO=
MMUState *s)
>  =20
>   static void vtd_context_global_invalidate(IntelIOMMUState *s)
>   {
> +    trace_vtd_inv_desc_cc_global();
>       s->context_cache_gen++;
>       if (s->context_cache_gen =3D=3D VTD_CONTEXT_CACHE_GEN_MAX) {
>           vtd_reset_context_cache(s);
> @@ -962,9 +961,11 @@ static void vtd_context_device_invalidate(IntelIOM=
MUState *s,
>       uint16_t mask;
>       VTDBus *vtd_bus;
>       VTDAddressSpace *vtd_as;
> -    uint16_t devfn;
> +    uint8_t bus_n, devfn;
>       uint16_t devfn_it;
>  =20
> +    trace_vtd_inv_desc_cc_devices(source_id, func_mask);
> +
>       switch (func_mask & 3) {
>       case 0:
>           mask =3D 0;   /* No bits in the SID field masked */
> @@ -980,16 +981,16 @@ static void vtd_context_device_invalidate(IntelIO=
MMUState *s,
>           break;
>       }
>       mask =3D ~mask;
> -    VTD_DPRINTF(INV, "device-selective invalidation source 0x%"PRIx16
> -                    " mask %"PRIu16, source_id, mask);
> -    vtd_bus =3D vtd_find_as_from_bus_num(s, VTD_SID_TO_BUS(source_id))=
;
> +
> +    bus_n =3D VTD_SID_TO_BUS(source_id);
> +    vtd_bus =3D vtd_find_as_from_bus_num(s, bus_n);
>       if (vtd_bus) {
>           devfn =3D VTD_SID_TO_DEVFN(source_id);
>           for (devfn_it =3D 0; devfn_it < X86_IOMMU_PCI_DEVFN_MAX; ++de=
vfn_it) {
>               vtd_as =3D vtd_bus->dev_as[devfn_it];
>               if (vtd_as && ((devfn_it & mask) =3D=3D (devfn & mask))) =
{
> -                VTD_DPRINTF(INV, "invalidate context-cahce of devfn 0x=
%"PRIx16,
> -                            devfn_it);
> +                trace_vtd_inv_desc_cc_device(bus_n, VTD_PCI_SLOT(devfn=
_it),
> +                                             VTD_PCI_FUNC(devfn_it));
>                   vtd_as->context_cache_entry.context_cache_gen =3D 0;
>               }
>           }
> @@ -1302,9 +1303,7 @@ static bool vtd_process_wait_desc(IntelIOMMUState=
 *s, VTDInvDesc *inv_desc)
>   {
>       if ((inv_desc->hi & VTD_INV_DESC_WAIT_RSVD_HI) ||
>           (inv_desc->lo & VTD_INV_DESC_WAIT_RSVD_LO)) {
> -        VTD_DPRINTF(GENERAL, "error: non-zero reserved field in Invali=
dation "
> -                    "Wait Descriptor hi 0x%"PRIx64 " lo 0x%"PRIx64,
> -                    inv_desc->hi, inv_desc->lo);
> +        trace_vtd_inv_desc_wait_invalid(inv_desc->hi, inv_desc->lo);
>           return false;
>       }
>       if (inv_desc->lo & VTD_INV_DESC_WAIT_SW) {
> @@ -1316,21 +1315,18 @@ static bool vtd_process_wait_desc(IntelIOMMUSta=
te *s, VTDInvDesc *inv_desc)
>  =20
>           /* FIXME: need to be masked with HAW? */
>           dma_addr_t status_addr =3D inv_desc->hi;
> -        VTD_DPRINTF(INV, "status data 0x%x, status addr 0x%"PRIx64,
> -                    status_data, status_addr);
> +        trace_vtd_inv_desc_wait_sw(status_addr, status_data);
>           status_data =3D cpu_to_le32(status_data);
>           if (dma_memory_write(&address_space_memory, status_addr, &sta=
tus_data,
>                                sizeof(status_data))) {
> -            VTD_DPRINTF(GENERAL, "error: fail to perform a coherent wr=
ite");
> +            trace_vtd_inv_desc_wait_write_fail(inv_desc->hi, inv_desc-=
>lo);
>               return false;
>           }
>       } else if (inv_desc->lo & VTD_INV_DESC_WAIT_IF) {
>           /* Interrupt flag */
> -        VTD_DPRINTF(INV, "Invalidation Wait Descriptor interrupt compl=
etion");
>           vtd_generate_completion_event(s);
>       } else {
> -        VTD_DPRINTF(GENERAL, "error: invalid Invalidation Wait Descrip=
tor: "
> -                    "hi 0x%"PRIx64 " lo 0x%"PRIx64, inv_desc->hi, inv_=
desc->lo);
> +        trace_vtd_inv_desc_wait_invalid(inv_desc->hi, inv_desc->lo);
>           return false;
>       }
>       return true;
> @@ -1339,30 +1335,29 @@ static bool vtd_process_wait_desc(IntelIOMMUSta=
te *s, VTDInvDesc *inv_desc)
>   static bool vtd_process_context_cache_desc(IntelIOMMUState *s,
>                                              VTDInvDesc *inv_desc)
>   {
> +    uint16_t sid, fmask;
> +
>       if ((inv_desc->lo & VTD_INV_DESC_CC_RSVD) || inv_desc->hi) {
> -        VTD_DPRINTF(GENERAL, "error: non-zero reserved field in Contex=
t-cache "
> -                    "Invalidate Descriptor");
> +        trace_vtd_inv_desc_cc_invalid(inv_desc->hi, inv_desc->lo);
>           return false;
>       }
>       switch (inv_desc->lo & VTD_INV_DESC_CC_G) {
>       case VTD_INV_DESC_CC_DOMAIN:
> -        VTD_DPRINTF(INV, "domain-selective invalidation domain 0x%"PRI=
x16,
> -                    (uint16_t)VTD_INV_DESC_CC_DID(inv_desc->lo));
> +        trace_vtd_inv_desc_cc_domain(
> +            (uint16_t)VTD_INV_DESC_CC_DID(inv_desc->lo));
>           /* Fall through */
>       case VTD_INV_DESC_CC_GLOBAL:
> -        VTD_DPRINTF(INV, "global invalidation");
>           vtd_context_global_invalidate(s);
>           break;
>  =20
>       case VTD_INV_DESC_CC_DEVICE:
> -        vtd_context_device_invalidate(s, VTD_INV_DESC_CC_SID(inv_desc-=
>lo),
> -                                      VTD_INV_DESC_CC_FM(inv_desc->lo)=
);
> +        sid =3D VTD_INV_DESC_CC_SID(inv_desc->lo);
> +        fmask =3D VTD_INV_DESC_CC_FM(inv_desc->lo);
> +        vtd_context_device_invalidate(s, sid, fmask);
>           break;
>  =20
>       default:
> -        VTD_DPRINTF(GENERAL, "error: invalid granularity in Context-ca=
che "
> -                    "Invalidate Descriptor hi 0x%"PRIx64  " lo 0x%"PRI=
x64,
> -                    inv_desc->hi, inv_desc->lo);
> +        trace_vtd_inv_desc_cc_invalid(inv_desc->hi, inv_desc->lo);
>           return false;
>       }
>       return true;
> @@ -1376,22 +1371,19 @@ static bool vtd_process_iotlb_desc(IntelIOMMUSt=
ate *s, VTDInvDesc *inv_desc)
>  =20
>       if ((inv_desc->lo & VTD_INV_DESC_IOTLB_RSVD_LO) ||
>           (inv_desc->hi & VTD_INV_DESC_IOTLB_RSVD_HI)) {
> -        VTD_DPRINTF(GENERAL, "error: non-zero reserved field in IOTLB =
"
> -                    "Invalidate Descriptor hi 0x%"PRIx64 " lo 0x%"PRIx=
64,
> -                    inv_desc->hi, inv_desc->lo);
> +        trace_vtd_inv_desc_iotlb_invalid(inv_desc->hi, inv_desc->lo);
>           return false;
>       }
>  =20
>       switch (inv_desc->lo & VTD_INV_DESC_IOTLB_G) {
>       case VTD_INV_DESC_IOTLB_GLOBAL:
> -        VTD_DPRINTF(INV, "global invalidation");
> +        trace_vtd_inv_desc_iotlb_global();
>           vtd_iotlb_global_invalidate(s);
>           break;
>  =20
>       case VTD_INV_DESC_IOTLB_DOMAIN:
>           domain_id =3D VTD_INV_DESC_IOTLB_DID(inv_desc->lo);
> -        VTD_DPRINTF(INV, "domain-selective invalidation domain 0x%"PRI=
x16,
> -                    domain_id);
> +        trace_vtd_inv_desc_iotlb_domain(domain_id);
>           vtd_iotlb_domain_invalidate(s, domain_id);
>           break;
>  =20
> @@ -1399,20 +1391,16 @@ static bool vtd_process_iotlb_desc(IntelIOMMUSt=
ate *s, VTDInvDesc *inv_desc)
>           domain_id =3D VTD_INV_DESC_IOTLB_DID(inv_desc->lo);
>           addr =3D VTD_INV_DESC_IOTLB_ADDR(inv_desc->hi);
>           am =3D VTD_INV_DESC_IOTLB_AM(inv_desc->hi);
> -        VTD_DPRINTF(INV, "page-selective invalidation domain 0x%"PRIx1=
6
> -                    " addr 0x%"PRIx64 " mask %"PRIu8, domain_id, addr,=
 am);
> +        trace_vtd_inv_desc_iotlb_pages(domain_id, addr, am);
>           if (am > VTD_MAMV) {
> -            VTD_DPRINTF(GENERAL, "error: supported max address mask va=
lue is "
> -                        "%"PRIu8, (uint8_t)VTD_MAMV);
> +            trace_vtd_inv_desc_iotlb_invalid(inv_desc->hi, inv_desc->l=
o);
>               return false;
>           }
>           vtd_iotlb_page_invalidate(s, domain_id, addr, am);
>           break;
>  =20
>       default:
> -        VTD_DPRINTF(GENERAL, "error: invalid granularity in IOTLB Inva=
lidate "
> -                    "Descriptor hi 0x%"PRIx64 " lo 0x%"PRIx64,
> -                    inv_desc->hi, inv_desc->lo);
> +        trace_vtd_inv_desc_iotlb_invalid(inv_desc->hi, inv_desc->lo);
>           return false;
>       }
>       return true;
> @@ -1511,33 +1499,28 @@ static bool vtd_process_inv_desc(IntelIOMMUStat=
e *s)
>  =20
>       switch (desc_type) {
>       case VTD_INV_DESC_CC:
> -        VTD_DPRINTF(INV, "Context-cache Invalidate Descriptor hi 0x%"P=
RIx64
> -                    " lo 0x%"PRIx64, inv_desc.hi, inv_desc.lo);
> +        trace_vtd_inv_desc("context-cache", inv_desc.hi, inv_desc.lo);
>           if (!vtd_process_context_cache_desc(s, &inv_desc)) {
>               return false;
>           }
>           break;
>  =20
>       case VTD_INV_DESC_IOTLB:
> -        VTD_DPRINTF(INV, "IOTLB Invalidate Descriptor hi 0x%"PRIx64
> -                    " lo 0x%"PRIx64, inv_desc.hi, inv_desc.lo);
> +        trace_vtd_inv_desc("iotlb", inv_desc.hi, inv_desc.lo);
>           if (!vtd_process_iotlb_desc(s, &inv_desc)) {
>               return false;
>           }
>           break;
>  =20
>       case VTD_INV_DESC_WAIT:
> -        VTD_DPRINTF(INV, "Invalidation Wait Descriptor hi 0x%"PRIx64
> -                    " lo 0x%"PRIx64, inv_desc.hi, inv_desc.lo);
> +        trace_vtd_inv_desc("wait", inv_desc.hi, inv_desc.lo);
>           if (!vtd_process_wait_desc(s, &inv_desc)) {
>               return false;
>           }
>           break;
>  =20
>       case VTD_INV_DESC_IEC:
> -        VTD_DPRINTF(INV, "Invalidation Interrupt Entry Cache "
> -                    "Descriptor hi 0x%"PRIx64 " lo 0x%"PRIx64,
> -                    inv_desc.hi, inv_desc.lo);
> +        trace_vtd_inv_desc("iec", inv_desc.hi, inv_desc.lo);
>           if (!vtd_process_inv_iec_desc(s, &inv_desc)) {
>               return false;
>           }
> @@ -1552,9 +1535,7 @@ static bool vtd_process_inv_desc(IntelIOMMUState =
*s)
>           break;
>  =20
>       default:
> -        VTD_DPRINTF(GENERAL, "error: unkonw Invalidation Descriptor ty=
pe "
> -                    "hi 0x%"PRIx64 " lo 0x%"PRIx64 " type %"PRIu8,
> -                    inv_desc.hi, inv_desc.lo, desc_type);
> +        trace_vtd_inv_desc_invalid(inv_desc.hi, inv_desc.lo);
>           return false;
>       }
>       s->iq_head++;
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index 1cc4a10..02aeaab 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -3,6 +3,24 @@
>   # hw/i386/x86-iommu.c
>   x86_iommu_iec_notify(bool global, uint32_t index, uint32_t mask) "Not=
ify IEC invalidation: global=3D%d index=3D%" PRIu32 " mask=3D%" PRIu32
>  =20
> +# hw/i386/intel_iommu.c
> +vtd_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn, bool o=
n) "Device %02x:%02x.%x switching address space (iommu enabled=3D%d)"
> +vtd_inv_desc(const char *type, uint64_t hi, uint64_t lo) "invalidate d=
esc type %s high 0x%"PRIx64" low 0x%"PRIx64
> +vtd_inv_desc_invalid(uint64_t hi, uint64_t lo) "invalid inv desc hi 0x=
%"PRIx64" lo 0x%"PRIx64
> +vtd_inv_desc_cc_domain(uint16_t domain) "context invalidate domain 0x%=
"PRIx16
> +vtd_inv_desc_cc_global(void) "context invalidate globally"
> +vtd_inv_desc_cc_device(uint8_t bus, uint8_t dev, uint8_t fn) "context =
invalidate device %02"PRIx8":%02"PRIx8".%02"PRIx8
> +vtd_inv_desc_cc_devices(uint16_t sid, uint16_t fmask) "context invalid=
ate devices sid 0x%"PRIx16" fmask 0x%"PRIx16
> +vtd_inv_desc_cc_invalid(uint64_t hi, uint64_t lo) "invalid context-cac=
he desc hi 0x%"PRIx64" lo 0x%"PRIx64
> +vtd_inv_desc_iotlb_global(void) "iotlb invalidate global"
> +vtd_inv_desc_iotlb_domain(uint16_t domain) "iotlb invalidate whole dom=
ain 0x%"PRIx16
> +vtd_inv_desc_iotlb_pages(uint16_t domain, uint64_t addr, uint8_t mask)=
 "iotlb invalidate domain 0x%"PRIx16" addr 0x%"PRIx64" mask 0x%"PRIx8
> +vtd_inv_desc_iotlb_invalid(uint64_t hi, uint64_t lo) "invalid iotlb de=
sc hi 0x%"PRIx64" lo 0x%"PRIx64
> +vtd_inv_desc_wait_sw(uint64_t addr, uint32_t data) "wait invalidate st=
atus write addr 0x%"PRIx64" data 0x%"PRIx32
> +vtd_inv_desc_wait_irq(const char *msg) "%s"
> +vtd_inv_desc_wait_invalid(uint64_t hi, uint64_t lo) "invalid wait desc=
 hi 0x%"PRIx64" lo 0x%"PRIx64
> +vtd_inv_desc_wait_write_fail(uint64_t hi, uint64_t lo) "write fail for=
 wait desc hi 0x%"PRIx64" lo 0x%"PRIx64
> +
>   # hw/i386/amd_iommu.c
>   amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to writ=
e at addr 0x%"PRIx64" +  offset 0x%"PRIx32
>   amdvi_cache_update(uint16_t domid, uint8_t bus, uint8_t slot, uint8_t=
 func, uint64_t gpa, uint64_t txaddr) " update iotlb domid 0x%"PRIx16" de=
vid: %02x:%02x.%x gpa 0x%"PRIx64" hpa 0x%"PRIx64
