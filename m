Received: from eggs.gnu.org ([2001:4830:134:3::10]:48111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gXH8h-0004c0-Lo
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 21:54:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gXH8d-0007Bn-IC
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 21:54:15 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1gXH8b-0006yh-1f
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 21:54:09 -0500
Received: by mail-pl1-x641.google.com with SMTP id y1so300157plp.9
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 18:54:02 -0800 (PST)
References: <20181211054926.56717-1-aik@ozlabs.ru>
	<20181211054926.56717-3-aik@ozlabs.ru>
	<20181211173520.785736ae@bahia.lab.toulouse-stg.fr.ibm.com>
	<a24cf2a7-2e96-318f-8ac1-1ab71f331303@ozlabs.ru>
	<20181212104622.5095be55@bahia.lab.toulouse-stg.fr.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <8492b43c-931c-19d5-38b6-2b8e0dee2e9a@ozlabs.ru>
Date: Thu, 13 Dec 2018 13:53:54 +1100
MIME-Version: 1.0
In-Reply-To: <20181212104622.5095be55@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH qemu 2/3] ppc/spapr: Receive and
 store device tree blob from SLOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>



On 12/12/2018 20:46, Greg Kurz wrote:
> On Wed, 12 Dec 2018 10:57:20 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> On 12/12/2018 03:35, Greg Kurz wrote:
>>> On Tue, 11 Dec 2018 16:49:25 +1100
>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>   
>>>> SLOF receives a device tree and updates it with various properties
>>>> before switching to the guest kernel and QEMU is not aware of any changes
>>>> made by SLOF. Since there is no real RTAS (QEMU implements it), it makes
>>>> sense to pass the SLOF final device tree to QEMU to let it implement
>>>> RTAS related tasks better, such as PCI host bus adapter hotplug.
>>>>
>>>> Specifially, now QEMU can find out the actual XICS phandle (for PHB
>>>> hotplug) and the RTAS linux,rtas-entry/base properties (for firmware
>>>> assisted NMI - FWNMI).
>>>>
>>>> This stores the initial DT blob in the sPAPR machine and replaces it
>>>> in the KVMPPC_H_UPDATE_DT (new private hypercall) handler.
>>>>
>>>> This adds an @update_dt_enabled machine property to allow backward
>>>> migration.
>>>>
>>>> SLOF already has a hypercall since
>>>> https://github.com/aik/SLOF/commit/e6fc84652c9c0073f9183
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>> ---
>>>>  include/hw/ppc/spapr.h |  7 ++++++-
>>>>  hw/ppc/spapr.c         | 31 ++++++++++++++++++++++++++++++-
>>>>  hw/ppc/spapr_hcall.c   | 42 ++++++++++++++++++++++++++++++++++++++++++
>>>>  hw/ppc/trace-events    |  3 +++
>>>>  4 files changed, 81 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>>>> index 1987640..86c90df 100644
>>>> --- a/include/hw/ppc/spapr.h
>>>> +++ b/include/hw/ppc/spapr.h
>>>> @@ -102,6 +102,7 @@ struct sPAPRMachineClass {
>>>>  
>>>>      /*< public >*/
>>>>      bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of LMBs */
>>>> +    bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
>>>>      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
>>>>      bool pre_2_10_has_unused_icps;
>>>>      bool legacy_irq_allocation;
>>>> @@ -138,6 +139,9 @@ struct sPAPRMachineState {
>>>>      int vrma_adjust;
>>>>      ssize_t rtas_size;
>>>>      void *rtas_blob;
>>>> +    uint32_t fdt_size;
>>>> +    uint32_t fdt_initial_size;
>>>> +    void *fdt_blob;
>>>>      long kernel_size;
>>>>      bool kernel_le;
>>>>      uint32_t initrd_base;
>>>> @@ -464,7 +468,8 @@ struct sPAPRMachineState {
>>>>  #define KVMPPC_H_LOGICAL_MEMOP  (KVMPPC_HCALL_BASE + 0x1)
>>>>  /* Client Architecture support */
>>>>  #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
>>>> -#define KVMPPC_HCALL_MAX        KVMPPC_H_CAS
>>>> +#define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
>>>> +#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
>>>>  
>>>>  typedef struct sPAPRDeviceTreeUpdateHeader {
>>>>      uint32_t version_id;
>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>> index 8a18250..984bf32 100644
>>>> --- a/hw/ppc/spapr.c
>>>> +++ b/hw/ppc/spapr.c
>>>> @@ -1654,7 +1654,10 @@ static void spapr_machine_reset(void)
>>>>      /* Load the fdt */
>>>>      qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
>>>>      cpu_physical_memory_write(fdt_addr, fdt, fdt_totalsize(fdt));
>>>> -    g_free(fdt);
>>>> +    g_free(spapr->fdt_blob);
>>>> +    spapr->fdt_size = fdt_totalsize(fdt);
>>>> +    spapr->fdt_initial_size = spapr->fdt_size;
>>>> +    spapr->fdt_blob = fdt;
>>>>  
>>>>      /* Set up the entry state */
>>>>      spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_addr);
>>>> @@ -1908,6 +1911,27 @@ static const VMStateDescription vmstate_spapr_irq_map = {
>>>>      },
>>>>  };
>>>>  
>>>> +static bool spapr_dtb_needed(void *opaque)
>>>> +{
>>>> +    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(opaque);
>>>> +
>>>> +    return smc->update_dt_enabled;
>>>> +}
>>>> +
>>>> +static const VMStateDescription vmstate_spapr_dtb = {
>>>> +    .name = "spapr_dtb",
>>>> +    .version_id = 1,
>>>> +    .minimum_version_id = 1,
>>>> +    .needed = spapr_dtb_needed,
>>>> +    .fields = (VMStateField[]) {
>>>> +        VMSTATE_UINT32(fdt_initial_size, sPAPRMachineState),
>>>> +        VMSTATE_UINT32(fdt_size, sPAPRMachineState),
>>>> +        VMSTATE_VBUFFER_ALLOC_UINT32(fdt_blob, sPAPRMachineState, 0, NULL,
>>>> +                                     fdt_size),  
>>>
>>> Unless I'm missing something, it looks like the initial spapr->fdt_blob in the
>>> destination might be leaked...  
>>
>> ah true.
>>
>>
>>>   
>>>> +        VMSTATE_END_OF_LIST()
>>>> +    },
>>>> +};
>>>> +
>>>>  static const VMStateDescription vmstate_spapr = {
>>>>      .name = "spapr",
>>>>      .version_id = 3,
>>>> @@ -1937,6 +1961,7 @@ static const VMStateDescription vmstate_spapr = {
>>>>          &vmstate_spapr_cap_ibs,
>>>>          &vmstate_spapr_irq_map,
>>>>          &vmstate_spapr_cap_nested_kvm_hv,
>>>> +        &vmstate_spapr_dtb,
>>>>          NULL
>>>>      }
>>>>  };
>>>> @@ -3871,6 +3896,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>>>>      hc->unplug = spapr_machine_device_unplug;
>>>>  
>>>>      smc->dr_lmb_enabled = true;
>>>> +    smc->update_dt_enabled = true;
>>>>      mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power8_v2.0");
>>>>      mc->has_hotpluggable_cpus = true;
>>>>      smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
>>>> @@ -3981,8 +4007,11 @@ static void spapr_machine_3_1_instance_options(MachineState *machine)
>>>>  
>>>>  static void spapr_machine_3_1_class_options(MachineClass *mc)
>>>>  {
>>>> +    sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
>>>> +
>>>>      spapr_machine_4_0_class_options(mc);
>>>>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_3_1);
>>>> +    smc->update_dt_enabled = false;
>>>>  }
>>>>  
>>>>  DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
>>>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>>>> index ae913d0..dfd3cf3 100644
>>>> --- a/hw/ppc/spapr_hcall.c
>>>> +++ b/hw/ppc/spapr_hcall.c
>>>> @@ -1717,6 +1717,46 @@ static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
>>>>  
>>>>      args[0] = characteristics;
>>>>      args[1] = behaviour;
>>>> +    return H_SUCCESS;
>>>> +}
>>>> +
>>>> +static target_ulong h_update_dt(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>>>> +                                target_ulong opcode, target_ulong *args)
>>>> +{
>>>> +    target_ulong dt = ppc64_phys_to_real(args[0]);
>>>> +    struct fdt_header hdr = { 0 };
>>>> +    unsigned cb;
>>>> +    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
>>>> +    void *fdt;
>>>> +
>>>> +    cpu_physical_memory_read(dt, &hdr, sizeof(hdr));
>>>> +    cb = fdt32_to_cpu(hdr.totalsize);
>>>> +
>>>> +    if (!smc->update_dt_enabled) {
>>>> +        return H_SUCCESS;
>>>> +    }
>>>> +
>>>> +    /* Check that the fdt did not grow out of proportion */
>>>> +    if (cb > spapr->fdt_initial_size * 2) {  
>>>
>>> Ok, so this caps the new fdt tree to 2 megs, which seems reasonable.  
>>
>> Why _megs_? It is 2 _times_. We do not expect big growth, it should be
> 
> The initial or cas fdt is capped to 1 meg (FDT_MAX_SIZE), isn't it ? So
> this check would allow the new fdt to be theoretically up to 2 meg.


Sure but I do not set the limit here, why would you bring it up here? Or
the idea was to do "if(cb > FDT_MAX_SIZE)return H_PARAMETER"? It is
probably a good idea, David? Thanks,





> 
>> phandles and some slof nodes (packages, options,...), pretty much. Right
>> now it is 10% bigger than the initial fdt.
>>
> 
> Expecting up to 100% may seem overkill then but even with a big initial/cas
> fdt, it would _only_ be 2 megs, which is a reasonable limit for a guest
> triggered allocation I guess.
> 
>>
>>> BTW, why 2 and not some other growth factor ?
>>>   
>>>> +        trace_spapr_update_dt_failed_size(spapr->fdt_initial_size, cb,
>>>> +            fdt32_to_cpu(hdr.magic));
>>>> +        return H_PARAMETER;
>>>> +    }
>>>> +
>>>> +    fdt = g_malloc0(cb);
>>>> +    cpu_physical_memory_read(dt, fdt, cb);
>>>> +
>>>> +    /* Check the fdt consostency */
>>>> +    if (fdt_check_full(fdt, cb)) {
>>>> +        trace_spapr_update_dt_failed_check(spapr->fdt_initial_size, cb,
>>>> +            fdt32_to_cpu(hdr.magic));
>>>> +        return H_PARAMETER;
>>>> +    }
>>>> +
>>>> +    g_free(spapr->fdt_blob);
>>>> +    spapr->fdt_size = cb;
>>>> +    spapr->fdt_blob = fdt;
>>>> +    trace_spapr_update_dt(cb);
>>>>  
>>>>      return H_SUCCESS;
>>>>  }
>>>> @@ -1822,6 +1862,8 @@ static void hypercall_register_types(void)
>>>>  
>>>>      /* ibm,client-architecture-support support */
>>>>      spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support);
>>>> +
>>>> +    spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
>>>>  }
>>>>  
>>>>  type_init(hypercall_register_types)
>>>> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
>>>> index dc5e65a..0af155e 100644
>>>> --- a/hw/ppc/trace-events
>>>> +++ b/hw/ppc/trace-events
>>>> @@ -22,6 +22,9 @@ spapr_cas_pvr_try(uint32_t pvr) "0x%x"
>>>>  spapr_cas_pvr(uint32_t cur_pvr, bool explicit_match, uint32_t new_pvr) "current=0x%x, explicit_match=%u, new=0x%x"
>>>>  spapr_h_resize_hpt_prepare(uint64_t flags, uint64_t shift) "flags=0x%"PRIx64", shift=%"PRIu64
>>>>  spapr_h_resize_hpt_commit(uint64_t flags, uint64_t shift) "flags=0x%"PRIx64", shift=%"PRIu64
>>>> +spapr_update_dt(unsigned cb) "New blob %u bytes"
>>>> +spapr_update_dt_failed_size(unsigned cbold, unsigned cbnew, unsigned magic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
>>>> +spapr_update_dt_failed_check(unsigned cbold, unsigned cbnew, unsigned magic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
>>>>  
>>>>  # hw/ppc/spapr_iommu.c
>>>>  spapr_iommu_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t ret) "liobn=0x%"PRIx64" ioba=0x%"PRIx64" tce=0x%"PRIx64" ret=%"PRId64  
>>>   
>>
> 

-- 
Alexey
