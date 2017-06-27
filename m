Received: from eggs.gnu.org ([2001:4830:134:3::10]:50718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dPq6Z-00040E-5V
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dPq6T-0008T2-JN
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:00:31 -0400
References: <1498512656-75289-1-git-send-email-agraf@suse.de>
	<20170627123718.mdfn3o7heu6v7x6n@kamzik.brq.redhat.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <b627df63-9ac1-49ff-931d-74c88d9d7ed5@suse.de>
Date: Tue, 27 Jun 2017 15:00:10 +0200
MIME-Version: 1.0
In-Reply-To: <20170627123718.mdfn3o7heu6v7x6n@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ARM: KVM: Enable in-kernel timers with
 user space gic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, cdall@linaro.org, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>



On 27.06.17 14:37, Andrew Jones wrote:
> On Mon, Jun 26, 2017 at 11:30:56PM +0200, Alexander Graf wrote:
>> When running with KVM enabled, you can choose between emulating the
>> gic in kernel or user space. If the kernel supports in-kernel virtualization
>> of the interrupt controller, it will default to that. If not, if will
>> default to user space emulation.
>>
>> Unfortunately when running in user mode gic emulation, we miss out on
>> interrupt events which are only available from kernel space, such as the timer.
>> This patch leverages the new kernel/user space pending line synchronization for
>> timer events. It does not handle PMU events yet.
>>
>> Signed-off-by: Alexander Graf <agraf@suse.de>
>> ---
>>   accel/kvm/kvm-all.c    |  5 +++++
>>   accel/stubs/kvm-stub.c |  5 +++++
>>   hw/intc/arm_gic.c      |  7 +++++++
>>   include/sysemu/kvm.h   | 11 +++++++++++
>>   target/arm/cpu.h       |  3 +++
>>   target/arm/kvm.c       | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   6 files changed, 80 insertions(+)
>>
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index 75feffa..ade32ea 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -2285,6 +2285,11 @@ int kvm_has_intx_set_mask(void)
>>       return kvm_state->intx_set_mask;
>>   }
>>   
>> +bool kvm_arm_supports_user_irq(void)
>> +{
>> +    return kvm_check_extension(kvm_state, KVM_CAP_ARM_USER_IRQ);
>> +}
>> +
>>   #ifdef KVM_CAP_SET_GUEST_DEBUG
>>   struct kvm_sw_breakpoint *kvm_find_sw_breakpoint(CPUState *cpu,
>>                                                    target_ulong pc)
>> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
>> index ef0c734..3965c52 100644
>> --- a/accel/stubs/kvm-stub.c
>> +++ b/accel/stubs/kvm-stub.c
>> @@ -155,4 +155,9 @@ void kvm_init_cpu_signals(CPUState *cpu)
>>   {
>>       abort();
>>   }
>> +
>> +bool kvm_arm_supports_user_irq(void)
>> +{
>> +    return false;
>> +}
>>   #endif
>> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
>> index b305d90..4ffd905 100644
>> --- a/hw/intc/arm_gic.c
>> +++ b/hw/intc/arm_gic.c
>> @@ -25,6 +25,7 @@
>>   #include "qom/cpu.h"
>>   #include "qemu/log.h"
>>   #include "trace.h"
>> +#include "sysemu/kvm.h"
>>   
>>   /* #define DEBUG_GIC */
>>   
>> @@ -1412,6 +1413,12 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
>>           return;
>>       }
>>   
>> +    if (kvm_enabled() && !kvm_arm_supports_user_irq()) {
>> +            error_setg(errp, "KVM with user space irqchip only works when the "
>> +                             "host kernel supports KVM_CAP_ARM_USER_IRQ");
>> +            return;
> 
> extra spaces here

Fixed

> 
>> +    }
>> +
>>       /* This creates distributor and main CPU interface (s->cpuiomem[0]) */
>>       gic_init_irqs_and_mmio(s, gic_set_irq, gic_ops);
>>   
>> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
>> index 1e91613..9f11fc0 100644
>> --- a/include/sysemu/kvm.h
>> +++ b/include/sysemu/kvm.h
>> @@ -227,6 +227,17 @@ int kvm_init_vcpu(CPUState *cpu);
>>   int kvm_cpu_exec(CPUState *cpu);
>>   int kvm_destroy_vcpu(CPUState *cpu);
>>   
>> +/**
>> + * kvm_arm_supports_user_irq
>> + *
>> + * Not all KVM implementations support notifications for kernel generated
>> + * interrupt events to user space. This function indicates whether the current
>> + * KVM implementation does support them.
>> + *
>> + * Returns: true if KVM supports using kernel generated IRQs from user space
>> + */
>> +bool kvm_arm_supports_user_irq(void);
>> +
>>   #ifdef NEED_CPU_H
>>   #include "cpu.h"
>>   
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 16a1e59..88ec3ee 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -706,6 +706,9 @@ struct ARMCPU {
>>       void *el_change_hook_opaque;
>>   
>>       int32_t node_id; /* NUMA node this CPU belongs to */
>> +
>> +    /* Used to synchronize KVM and QEMU timer levels */
> 
> Eventually it won't only be for timer levels

Ah, one place I forgot to fix up :). Fixed.

> 
>> +    uint8_t device_irq_level;
>>   };
>>   
>>   static inline ARMCPU *arm_env_get_cpu(CPUARMState *env)
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 4555468..29ee72d 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -174,6 +174,12 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>        */
>>       kvm_async_interrupts_allowed = true;
>>   
>> +    /*
>> +     * PSCI wakes up secondary cores, so we always need to
>> +     * have vCPUs waiting in kernel space
>> +     */
>> +    kvm_halt_in_kernel_allowed = true;
>> +
>>       cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
>>   
>>       type_register_static(&host_arm_cpu_type_info);
>> @@ -528,6 +534,49 @@ void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
>>   
>>   MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
>>   {
>> +    ARMCPU *cpu;
>> +    uint32_t switched_level;
>> +
>> +    if (kvm_irqchip_in_kernel()) {
>> +        /*
>> +         * We only need to sync timer states with user-space interrupt
>> +         * controllers, so return early and save cycles if we don't.
>> +         */
>> +        return MEMTXATTRS_UNSPECIFIED;
>> +    }
>> +
>> +    cpu = ARM_CPU(cs);
>> +
>> +    /* Synchronize our internal timer irq lines with the kvm ones */
>> +    if (run->s.regs.device_irq_level != cpu->device_irq_level) {
>> +        switched_level = cpu->device_irq_level ^ run->s.regs.device_irq_level;
>> +
>> +        qemu_mutex_lock_iothread();
>> +
>> +        if (switched_level & KVM_ARM_DEV_EL1_VTIMER) {
>> +            qemu_set_irq(cpu->gt_timer_outputs[GTIMER_VIRT],
>> +                         run->s.regs.device_irq_level & KVM_ARM_DEV_EL1_VTIMER);
> 
> Should be !!(run->s.regs.device_irq_level & KVM_ARM_DEV_EL1_VTIMER)

Yup.

> 
>> +            switched_level &= ~KVM_ARM_DEV_EL1_VTIMER;
>> +        }
>> +
>> +        if (switched_level & KVM_ARM_DEV_EL1_PTIMER) {
>> +            qemu_set_irq(cpu->gt_timer_outputs[GTIMER_PHYS],
>> +                         run->s.regs.device_irq_level & KVM_ARM_DEV_EL1_PTIMER);
> 
> Also need the !!

Yup.

> 
>> +            switched_level &= ~KVM_ARM_DEV_EL1_PTIMER;
>> +        }
>> +
>> +        /* XXX PMU IRQ is missing */
> 
> So I was wondering why you chose not to wire up the PMU in order to finish

Because the PMU IRQ is only available from the machine file, so it'll 
need some more plumbing to get the qemu_irq object available from kvm.c.

> this off, since I knew KVM has commit 3dbbdf78636e "KVM: arm/arm64: Report
> PMU overflow interrupts to userspace irqchip", which I presume should
> allow the PMU to work too. However, attempting to start a guest with
> -machine virt,accel=kvm,kernel-irqchip=off -cpu host,pmu=on doesn't provide
> it a PMU. AFAICT, that's only because KVM still has
> 
>          /*
>           * We currently require an in-kernel VGIC to use the PMU emulation,
>           * because we do not support forwarding PMU overflow interrupts to
>           * userspace yet.
>           */
>          if (!irqchip_in_kernel(vcpu->kvm) || !vgic_initialized(vcpu->kvm))
>                  return -ENODEV;
> 
> in kvm_arm_pmu_v3_init(). Anyone know why that wasn't removed with
> 3dbbdf78636e?

I guess it should get removed when the PMU sync works?

> 
>> +
>> +        if (switched_level) {
>> +            qemu_log_mask(LOG_UNIMP, "%s: unhandled device IRQ %x\n",
> 
> Misleading message here. It's not a device IRQ that switched_level
> contains.

Ok, changed to "in-kernel device" as that really is what it is about.


Alex
