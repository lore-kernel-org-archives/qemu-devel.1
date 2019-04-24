Received: from eggs.gnu.org ([209.51.188.92]:34656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hJ9xh-0006mX-4N
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:56:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hJ9rv-0003LV-5L
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:50:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49822
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1hJ9ru-0003JA-Vz
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:50:51 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3O4iYSg035283
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 00:50:48 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2s2h1kg72q-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 00:50:48 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Wed, 24 Apr 2019 05:50:48 +0100
References: <155591636364.20338.844048953355207313.stgit@aravinda>
	<155591659639.20338.6078212293519133016.stgit@aravinda>
	<20190423065359.GF31496@umbus.fritz.box>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Wed, 24 Apr 2019 10:20:42 +0530
MIME-Version: 1.0
In-Reply-To: <20190423065359.GF31496@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <3f8435a4-0435-fb3c-6f67-446e9a090ae0@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v8 3/6] target/ppc: Handle NMI
 guest exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: paulus@ozlabs.org, qemu-ppc@nongnu.org, aik@au1.ibm.com, qemu-devel@nongnu.org, mahesh@linux.vnet.ibm.com



On Tuesday 23 April 2019 12:23 PM, David Gibson wrote:
> On Mon, Apr 22, 2019 at 12:33:16PM +0530, Aravinda Prasad wrote:
>> Memory error such as bit flips that cannot be corrected
>> by hardware are passed on to the kernel for handling.
>> If the memory address in error belongs to guest then
>> the guest kernel is responsible for taking suitable action.
>> Patch [1] enhances KVM to exit guest with exit reason
>> set to KVM_EXIT_NMI in such cases. This patch handles
>> KVM_EXIT_NMI exit.
>>
>> [1] https://www.spinics.net/lists/kvm-ppc/msg12637.html
>>     (e20bbd3d and related commits)
>>
>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> 
> LGTM, apart from one detail noted below.
> 
>> ---
>>  hw/ppc/spapr.c          |    3 +++
>>  hw/ppc/spapr_events.c   |   22 ++++++++++++++++++++++
>>  hw/ppc/spapr_rtas.c     |    5 +++++
>>  include/hw/ppc/spapr.h  |    6 ++++++
>>  target/ppc/kvm.c        |   16 ++++++++++++++++
>>  target/ppc/kvm_ppc.h    |    2 ++
>>  target/ppc/trace-events |    2 ++
>>  7 files changed, 56 insertions(+)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 6642cb5..2779efe 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1806,6 +1806,7 @@ static void spapr_machine_reset(void)
>>  
>>      spapr->cas_reboot = false;
>>  
>> +    spapr->mc_status = -1;
>>      spapr->guest_machine_check_addr = -1;
>>  
>>      /* Signal all vCPUs waiting on this condition */
>> @@ -2106,6 +2107,7 @@ static const VMStateDescription vmstate_spapr_machine_check = {
>>      .minimum_version_id = 1,
>>      .fields = (VMStateField[]) {
>>          VMSTATE_UINT64(guest_machine_check_addr, SpaprMachineState),
>> +        VMSTATE_INT32(mc_status, SpaprMachineState),
> 
> So, technically this is a breaking change to the migration stream.  If
> this is applied immediately after the earlier patch introducing the
> subsection it would be ok in practice, but it would still be
> preferable to make all the migration stream changes together.

Do you mean that all .fields entries to vmstate_spapr_machine_check
should be in a single patch?

Because this patch introduced the variable mc_status, I added it to
vmstate_spapr_machine_check.

Regards,
Aravinda

> 
>>          VMSTATE_END_OF_LIST()
>>      },
>>  };
>> @@ -3085,6 +3087,7 @@ static void spapr_machine_init(MachineState *machine)
>>          kvmppc_spapr_enable_inkernel_multitce();
>>      }
>>  
>> +    spapr->mc_status = -1;
>>      qemu_cond_init(&spapr->mc_delivery_cond);
>>  }
>>  
>> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
>> index ae0f093..9922a23 100644
>> --- a/hw/ppc/spapr_events.c
>> +++ b/hw/ppc/spapr_events.c
>> @@ -620,6 +620,28 @@ void spapr_hotplug_req_remove_by_count_indexed(SpaprDrcType drc_type,
>>                              RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type, &drc_id);
>>  }
>>  
>> +void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>> +{
>> +    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>> +
>> +    while (spapr->mc_status != -1) {
>> +        /*
>> +         * Check whether the same CPU got machine check error
>> +         * while still handling the mc error (i.e., before
>> +         * that CPU called "ibm,nmi-interlock"
>> +         */
>> +        if (spapr->mc_status == cpu->vcpu_id) {
>> +            qemu_system_guest_panicked(NULL);
>> +        }
>> +        qemu_cond_wait_iothread(&spapr->mc_delivery_cond);
>> +        /* Meanwhile if the system is reset, then just return */
>> +        if (spapr->guest_machine_check_addr == -1) {
>> +            return;
>> +        }
>> +    }
>> +    spapr->mc_status = cpu->vcpu_id;
>> +}
>> +
>>  static void check_exception(PowerPCCPU *cpu, SpaprMachineState *spapr,
>>                              uint32_t token, uint32_t nargs,
>>                              target_ulong args,
>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>> index c2f3991..d3499f9 100644
>> --- a/hw/ppc/spapr_rtas.c
>> +++ b/hw/ppc/spapr_rtas.c
>> @@ -375,6 +375,11 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>>          /* NMI register not called */
>>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>>      } else {
>> +        /*
>> +         * vCPU issuing "ibm,nmi-interlock" is done with NMI handling,
>> +         * hence unset mc_status.
>> +         */
>> +        spapr->mc_status = -1;
>>          qemu_cond_signal(&spapr->mc_delivery_cond);
>>          rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>>      }
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index ec6f33e..f7204d0 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -189,6 +189,11 @@ struct SpaprMachineState {
>>  
>>      /* State related to "ibm,nmi-register" and "ibm,nmi-interlock" calls */
>>      target_ulong guest_machine_check_addr;
>> +    /*
>> +     * mc_status is set to -1 if mc is not in progress, else is set to the CPU
>> +     * handling the mc.
>> +     */
>> +    int mc_status;
>>      QemuCond mc_delivery_cond;
>>  
>>      /*< public >*/
>> @@ -792,6 +797,7 @@ void spapr_clear_pending_events(SpaprMachineState *spapr);
>>  int spapr_max_server_number(SpaprMachineState *spapr);
>>  void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
>>                        uint64_t pte0, uint64_t pte1);
>> +void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered);
>>  
>>  /* DRC callbacks. */
>>  void spapr_core_release(DeviceState *dev);
>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>> index 9e86db0..5eedce8 100644
>> --- a/target/ppc/kvm.c
>> +++ b/target/ppc/kvm.c
>> @@ -1759,6 +1759,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>>          ret = 0;
>>          break;
>>  
>> +    case KVM_EXIT_NMI:
>> +        trace_kvm_handle_nmi_exception();
>> +        ret = kvm_handle_nmi(cpu, run);
>> +        break;
>> +
>>      default:
>>          fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reason);
>>          ret = -1;
>> @@ -2837,6 +2842,17 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
>>      return data & 0xffff;
>>  }
>>  
>> +int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run)
>> +{
>> +    bool recovered = run->flags & KVM_RUN_PPC_NMI_DISP_FULLY_RECOV;
>> +
>> +    cpu_synchronize_state(CPU(cpu));
>> +
>> +    spapr_mce_req_event(cpu, recovered);
>> +
>> +    return 0;
>> +}
>> +
>>  int kvmppc_enable_hwrng(void)
>>  {
>>      if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_PPC_HWRNG)) {
>> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
>> index 2238513..6edc42f 100644
>> --- a/target/ppc/kvm_ppc.h
>> +++ b/target/ppc/kvm_ppc.h
>> @@ -80,6 +80,8 @@ bool kvmppc_hpt_needs_host_contiguous_pages(void);
>>  void kvm_check_mmu(PowerPCCPU *cpu, Error **errp);
>>  void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu, unsigned int online);
>>  
>> +int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run);
>> +
>>  #else
>>  
>>  static inline uint32_t kvmppc_get_tbfreq(void)
>> diff --git a/target/ppc/trace-events b/target/ppc/trace-events
>> index 7b3cfe1..d5691d2 100644
>> --- a/target/ppc/trace-events
>> +++ b/target/ppc/trace-events
>> @@ -28,3 +28,5 @@ kvm_handle_papr_hcall(void) "handle PAPR hypercall"
>>  kvm_handle_epr(void) "handle epr"
>>  kvm_handle_watchdog_expiry(void) "handle watchdog expiry"
>>  kvm_handle_debug_exception(void) "handle debug exception"
>> +kvm_handle_nmi_exception(void) "handle NMI exception"
>> +
>>
> 

-- 
Regards,
Aravinda
