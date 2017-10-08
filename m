Received: from eggs.gnu.org ([2001:4830:134:3::10]:42341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1e17R7-00062Z-6e
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 04:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1e17Qz-0003Wz-17
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 04:59:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34988
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1e17Qy-0003Wa-Qg
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 04:59:40 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v988xJiR119253
	for <qemu-devel@nongnu.org>; Sun, 8 Oct 2017 04:59:37 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2deuguunma-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 08 Oct 2017 04:59:36 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Sun, 8 Oct 2017 02:59:36 -0600
References: <150659494872.25889.2069124544245723984.stgit@aravinda>
	<150659509034.25889.15033474935802042526.stgit@aravinda>
	<20171004012921.GQ3260@umbus.fritz.box>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Sun, 8 Oct 2017 14:29:26 +0530
MIME-Version: 1.0
In-Reply-To: <20171004012921.GQ3260@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <14aeb1ff-867f-722a-28ce-7d66193051fc@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 4/6] target/ppc: Handle NMI guest exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, mahesh@linux.vnet.ibm.com, benh@au1.ibm.com, paulus@samba.org, sam.bobroff@au1.ibm.com



On Wednesday 04 October 2017 06:59 AM, David Gibson wrote:
> On Thu, Sep 28, 2017 at 04:08:10PM +0530, Aravinda Prasad wrote:
>> Memory error such as bit flips that cannot be corrected
>> by hardware are passed on to the kernel for handling.
>> If the memory address in error belongs to guest then
>> the guest kernel is responsible for taking suitable action.
>> Patch [1] enhances KVM to exit guest with exit reason
>> set to KVM_EXIT_NMI in such cases.
>>
>> This patch handles KVM_EXIT_NMI exit. If the guest OS
>> has registered the machine check handling routine by
>> calling "ibm,nmi-register", then the handler builds
>> the error log and invokes the registered handler else
>> invokes the handler at 0x200.
>>
>> Note that FWNMI handles synchronous machine check exceptions
>> triggered by the hardware and hence we do not extend
>> such support to the "nmi" command available in the QEMU
>> monitor. Hence, "nmi" command from the monitor will
>> always go through 0x200 vector.
>>
>> [1] https://www.spinics.net/lists/kvm-ppc/msg12637.html
>> 	(e20bbd3d and related commits)
> 
> What does happen on KVM if an asynchronous machine check exception
> occurs while in the guest?  Or under PowerVM for that matter.

AFAIK asynchronous errors take a different path in KVM as it can happen
in a different process context.

> 
>>
>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> ---
>>  hw/ppc/spapr.c         |    4 +++
>>  hw/ppc/spapr_events.c  |   62 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/hw/ppc/spapr.h |    6 +++++
>>  target/ppc/kvm.c       |   62 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  target/ppc/kvm_ppc.h   |   14 +++++++++++
>>  5 files changed, 148 insertions(+)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index d568ea6..7780434 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -2453,6 +2453,10 @@ static void ppc_spapr_init(MachineState *machine)
>>          error_report("Could not get size of LPAR rtas '%s'", filename);
>>          exit(1);
>>      }
>> +
>> +    /* Resize blob to accommodate error log. */
>> +    spapr->rtas_size = spapr_get_rtas_size();
>> +
>>      spapr->rtas_blob = g_malloc(spapr->rtas_size);
>>      if (load_image_size(filename, spapr->rtas_blob, spapr->rtas_size) < 0) {
>>          error_report("Could not load LPAR rtas '%s'", filename);
>> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
>> index e377fc7..ac93a7b 100644
>> --- a/hw/ppc/spapr_events.c
>> +++ b/hw/ppc/spapr_events.c
>> @@ -41,6 +41,7 @@
>>  #include "qemu/bcd.h"
>>  #include "hw/ppc/spapr_ovec.h"
>>  #include <libfdt.h>
>> +#include <linux/kvm.h>
>>  
>>  #define RTAS_LOG_VERSION_MASK                   0xff000000
>>  #define   RTAS_LOG_VERSION_6                    0x06000000
>> @@ -174,6 +175,22 @@ struct epow_extended_log {
>>      struct rtas_event_log_v6_epow epow;
>>  } QEMU_PACKED;
>>  
>> +/*
>> + * Data format in RTAS Blob
>> + *
>> + * This structure contains error information related to Machine
>> + * Check exception. This is filled up and copied to rtas blob
>> + * upon machine check exception. The address of rtas blob is
>> + * passed on to OS registered machine check notification
>> + * routines upon machine check exception.
>> + */
>> +struct rtas_event_log_mce {
>> +    target_ulong r3;
>> +    struct rtas_error_log rtas_error_log;
>> +    unsigned char   buffer[1];      /* Start of extended log */
> 
> I believe we allow C99 extensions in qemu, so you can use buffer[], a
> C99 flexible array member, rather than the length 1 hack.

ok.

> 
>> +} QEMU_PACKED;
>> +
>> +
>>  union drc_identifier {
>>      uint32_t index;
>>      uint32_t count;
>> @@ -623,6 +640,51 @@ void spapr_hotplug_req_remove_by_count_indexed(sPAPRDRConnectorType drc_type,
>>                              RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type, &drc_id);
>>  }
>>  
>> +ssize_t spapr_get_rtas_size(void)
>> +{
>> +    return RTAS_ERRLOG_OFFSET + sizeof(struct rtas_event_log_mce);
> 
> Erm.. because of the definition of rtas_event_log_mce, this only
> allows for 1 byte of extended log buffer.  That doesn't seem right.

This is directly taken from the kernel's RTAS log (struct rtas_error_log
in arch/powerpc/include/asm/rtas.h). I am not sure why they use 1 byte
extended log buffer.

> 
>> +}
>> +
>> +target_ulong spapr_mce_req_event(target_ulong r3, hwaddr rtas_addr,
>> +                                 uint16_t flags, bool err_type, bool le)
> 
> err_tpe isn't a very informative name for a boolean.  'uncorrectable'
> would be better.  Although, didn't you say only uncorrectable errors
> are directed to the guest, so does this have any purpose anyway?

Right now only uncorrectable errors, but can be enhanced later to pass
on correctable errors to inform the guest.

> 
>> +{
>> +    struct rtas_event_log_mce mc_log;
>> +    uint32_t summary;
>> +
>> +    /* Set error log fields */
>> +    mc_log.r3 = r3;
>> +
>> +    summary = RTAS_LOG_SEVERITY_ERROR_SYNC;
>> +
>> +    if (flags & KVM_RUN_PPC_NMI_DISP_FULLY_RECOV) {
> 
> KVM specific flags shouldn't be here, this translation should happen
> in the caller.

ok.

> 
>> +        summary |= RTAS_LOG_DISPOSITION_FULLY_RECOVERED;
>> +    } else {
>> +        summary |= RTAS_LOG_DISPOSITION_NOT_RECOVERED;
>> +    }
>> +
>> +    summary |= (RTAS_LOG_INITIATOR_MEMORY | RTAS_LOG_TARGET_MEMORY);
>> +
>> +    if (err_type) {
>> +        summary |= RTAS_LOG_TYPE_ECC_UNCORR;
>> +    } else {
>> +        summary |= RTAS_LOG_TYPE_ECC_CORR;
>> +    }
>> +
>> +    mc_log.rtas_error_log.summary = cpu_to_be32(summary);
>> +
>> +    /* Handle all Host/Guest LE/BE combinations */
> 
> I'd prefer you do this logic immediate as you store mc_log.r3.  I
> really dislike storing values into a structure in the wrong
> endianness, even temporarily - it makes it harder for someone reading
> the code to discern what endianness the field is supposed to be in.

ok.

> 
>> +    if (le) {
>> +        mc_log.r3 = cpu_to_le64(mc_log.r3);
>> +    } else {
>> +        mc_log.r3 = cpu_to_be64(mc_log.r3);
>> +    }
>> +
>> +    cpu_physical_memory_write(rtas_addr + RTAS_ERRLOG_OFFSET,
>> +                              &mc_log, sizeof(mc_log));
>> +
>> +    return rtas_addr + RTAS_ERRLOG_OFFSET;
>> +}
>> +
>>  static void check_exception(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>>                              uint32_t token, uint32_t nargs,
>>                              target_ulong args,
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 28b6e2e..a75e9cf 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -556,6 +556,9 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
>>  #define DIAGNOSTICS_RUN_MODE_IMMEDIATE 2
>>  #define DIAGNOSTICS_RUN_MODE_PERIODIC  3
>>  
>> +/* Offset from rtas-base where error log is placed */
>> +#define RTAS_ERRLOG_OFFSET       0x200
> 
> Is there any particular rationale for this offset?  Our actual RTAS
> code is 20 bytes, much smaller than this.

Just to ensure some space if in case RTAS code needs to be extended in
future.

> 
>> +
>>  static inline uint64_t ppc64_phys_to_real(uint64_t addr)
>>  {
>>      return addr & ~0xF000000000000000ULL;
>> @@ -675,6 +678,9 @@ int spapr_hpt_shift_for_ramsize(uint64_t ramsize);
>>  void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
>>                            Error **errp);
>>  void spapr_clear_pending_events(sPAPRMachineState *spapr);
>> +ssize_t spapr_get_rtas_size(void);
>> +target_ulong spapr_mce_req_event(target_ulong r3, hwaddr rtas_addr,
>> +                                 uint16_t flags, bool err_type, bool le);
>>  
>>  /* CPU and LMB DRC release callbacks. */
>>  void spapr_core_release(DeviceState *dev);
>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>> index 171d3d8..7e4ce02 100644
>> --- a/target/ppc/kvm.c
>> +++ b/target/ppc/kvm.c
>> @@ -1798,6 +1798,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>>          ret = 0;
>>          break;
>>  
>> +    case KVM_EXIT_NMI:
>> +        DPRINTF("handle NMI exception\n");
>> +        ret = kvm_handle_nmi(cpu, run);
>> +        break;
>> +
>>      default:
>>          fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reason);
>>          ret = -1;
>> @@ -2746,6 +2751,63 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
>>      return data & 0xffff;
>>  }
>>  
>> +int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run)
> 
> Most of the logic here - everything except actually parsing the
> relevant fields from kvm_run - should move to spapr_events.  We may
> not have any way of generating synchronous MCEs in TCG at the moment,
> but we shouldn't exclude the possibility (being able to inject
> uncorrectable memory errors in TCG sounds like it could be quite a
> useful debugging tool).

ok.

> 
>> +{
>> +    CPUPPCState *env = &cpu->env;
>> +    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>> +    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
>> +    target_ulong msr = 0;
>> +    bool type, le;
>> +
>> +    cpu_synchronize_state(CPU(cpu));
>> +
>> +    /*
>> +     * Properly set bits in MSR before we invoke the handler.
>> +     * SRR0/1, DAR and DSISR are properly set by KVM
>> +     */
>> +    if (!(*pcc->interrupts_big_endian)(cpu)) {
>> +        msr |= (1ULL << MSR_LE);
>> +    }
>> +
>> +    if (env->msr && (1ULL << MSR_SF)) {
>> +        msr |= (1ULL << MSR_SF);
>> +    }
>> +
>> +    msr |= (1ULL << MSR_ME);
>> +    env->msr = msr;
>> +
>> +    if (!spapr->guest_machine_check_addr) {
>> +        /*
>> +         * If OS has not registered with "ibm,nmi-register"
>> +         * jump to 0x200
>> +         */
>> +        env->nip = 0x200;
> 
> Sure you don't need to set some diagnostic registers in this case?

Not sure. Let me check.

> 
>> +        return 0;
>> +    }
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
> 
> I think you need a check to break out of here if the system has been
> reset.  Otherwise if you get:
> 
>    1. MC generated on CPUs 0 & 1
>    2. MC delivered CPU0, CPU1 blocked here
>    3. system reset
> 
> I think the CPU1 thread will still be stuck here, waiting to get back
> to the main loop that would check for the reset.

sure.

Regards,
Aravinda
> 
>> +        qemu_cond_wait_iothread(&spapr->mc_delivery_cond);
>> +    }
>> +
>> +    spapr->mc_status = cpu->vcpu_id;
>> +
>> +    type = !!(env->spr[SPR_DSISR] & P7_DSISR_MC_UE);
>> +    le = !!(env->msr & (1ULL << MSR_LE));
>> +    env->gpr[3] = spapr_mce_req_event(env->gpr[3], spapr->rtas_addr,
>> +                                      run->flags, type, le);
>> +    env->nip = spapr->guest_machine_check_addr;
>> +
>> +    return 0;
>> +}
>> +
>>  int kvmppc_enable_hwrng(void)
>>  {
>>      if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_PPC_HWRNG)) {
>> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
>> index d6be38e..0139dae 100644
>> --- a/target/ppc/kvm_ppc.h
>> +++ b/target/ppc/kvm_ppc.h
>> @@ -71,6 +71,20 @@ bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu);
>>  
>>  bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path);
>>  
>> +int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run);
>> +
>> +/*
>> + * Currently KVM only passes on the uncorrected machine
>> + * check memory error to guest. Other machine check errors
>> + * such as SLB multi-hit and TLB multi-hit are recovered
>> + * in KVM and are not passed on to guest.
>> + *
>> + * DSISR Bit for uncorrected machine check error. Based
>> + * on arch/powerpc/include/asm/mce.h
>> + */
>> +#define PPC_BIT(bit)                (0x8000000000000000ULL >> bit)
>> +#define P7_DSISR_MC_UE              (PPC_BIT(48))  /* P8 too */
>> +
>>  #else
>>  
>>  static inline uint32_t kvmppc_get_tbfreq(void)
>>
> 

-- 
Regards,
Aravinda
