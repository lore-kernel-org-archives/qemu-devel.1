Received: from eggs.gnu.org ([2001:4830:134:3::10]:45080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eZF0G-00076Y-ED
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 06:57:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eZF0E-0005ik-Ie
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 06:57:08 -0500
References: <1514440458-10515-1-git-send-email-gengdongjiu@huawei.com>
	<1514440458-10515-10-git-send-email-gengdongjiu@huawei.com>
	<CAFEAcA84tR_9e24DqvR9vsNvFBbK86fUTBnQdBjWKDGj4wkTGg@mail.gmail.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <569aa6ff-18e4-2ed2-bf1a-d5d5b607d738@huawei.com>
Date: Wed, 10 Jan 2018 19:56:34 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA84tR_9e24DqvR9vsNvFBbK86fUTBnQdBjWKDGj4wkTGg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v14 9/9] target-arm: kvm64: handle SIGBUS
 signal from kernel or KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Marcelo Tosatti <mtosatti@redhat.com>, Richard
	Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, James
	Morse <james.morse@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, kvm-devel <kvm@vger.kernel.org>, QEMU
	Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Huangshaoyu <huangshaoyu@huawei.com>, "Zhengqiang (turing)" <zhengqiang10@huawei.com>, Xu Wei <xuwei5@hisilicon.com>

Hi Peter,
  Thanks for the mail and comments.

On 2018/1/10 1:14, Peter Maydell wrote:
> On 28 December 2017 at 05:54, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>> Add SIGBUS signal handler. In this handler, it checks the SIGBUS type,
>> translates the host VA which is delivered by host to guest PA, then fill
>> this PA to CPER and fill the CPER to guest APEI GHES memory, finally
>> notify guest according to the SIGBUS type. There are two kinds of SIGBUS
>> that QEMU needs to handle, which are BUS_MCEERR_AO and BUS_MCEERR_AR.
>>
>> If guest accesses the poisoned memory, it generates Synchronous External
>> Abort(SEA). Then host kernel gets an APEI notification and call memory_failure()
>> to unmapped the affected page from the guest's stage2, and SIGBUS_MCEERR_AO
>> is delivered to Qemu's main thread. If Qemu receives this SIGBUS, it will
>> create a new CPER and add it to guest APEI GHES memory, then notify the
>> guest with a GPIO-Signal notification.
>>
>> When guest hits a PG_hwpoison page, it will trap to KVM as stage2 fault, then a
>> SIGBUS_MCEERR_AR synchronous signal is delivered to Qemu, Qemu record this error
>> into guest APEI GHES memory and notify guest using Synchronous-External-Abort(SEA).
>>
>> Suggested-by: James Morse <james.morse@arm.com>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> ---
>> Address James's comments to record CPER and notify guest for SIGBUS signal handling.
>> Shown some discussion in [1].
>>
>> [1]:
>> https://lkml.org/lkml/2017/2/27/246
>> https://lkml.org/lkml/2017/9/14/241
>> https://lkml.org/lkml/2017/9/22/499
>> ---
>>  include/sysemu/kvm.h |  2 +-
>>  target/arm/kvm.c     |  2 ++
>>  target/arm/kvm64.c   | 34 ++++++++++++++++++++++++++++++++++
>>  3 files changed, 37 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
>> index 3a458f5..90c1605 100644
>> --- a/include/sysemu/kvm.h
>> +++ b/include/sysemu/kvm.h
>> @@ -361,7 +361,7 @@ bool kvm_vcpu_id_is_valid(int vcpu_id);
>>  /* Returns VCPU ID to be used on KVM_CREATE_VCPU ioctl() */
>>  unsigned long kvm_arch_vcpu_id(CPUState *cpu);
>>
>> -#ifdef TARGET_I386
>> +#if defined(TARGET_I386) || defined(TARGET_AARCH64)
> 
> As a general rule we should not introduce new ifdefs with
> lists of architectures in them. Instead the targets which support
> something should define something suitable in a per-target
> header file.
> 
> In this case I think you should:
>  * move the define KVM_HAVE_MCE_INJECTION to target/i386/cpu.h,
>    and have this ifdef be #ifdef KVM_HAVE_MCE_INJECTION
>    (that should be in a different patch)
>  * have the target-arm patch then just define KVM_HAVE_MCE_INJECTION
>    in target/arm/cpu.h (if TARGET_AARCH64) and provide
>    kvm_arch_on_sigbus_vcpu()
Yes, this way is clean. thanks for the suggestion and detailed description.

>>  #define KVM_HAVE_MCE_INJECTION 1
>>  void kvm_arch_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
>>  #endif
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 7c17f0d..9d25f51 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -26,6 +26,7 @@
>>  #include "exec/address-spaces.h"
>>  #include "hw/boards.h"
>>  #include "qemu/log.h"
>> +#include "exec/ram_addr.h"
> 
> Why this #include ?
it needs to call the qemu_register_reset()

> 
>>  const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
>>      KVM_CAP_LAST_INFO
>> @@ -182,6 +183,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>
>>      cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
>>
>> +    qemu_register_reset(kvm_unpoison_all, NULL);
> 
> Looking at this, I realised that we can do this generically in
> kvm_init_vcpu() in kvm-all.c (guarded by #ifdef KVM_HAVE_MCE_INJECTION).
> You can move the qemu_register_reset() call from target/i386 into
> that common code in the patch where you move the unpoison functions.
> Then you can make kvm_unpoison_all be static rather than global.
Ok, thanks for the good suggestion and pointing out.

> 
>>      type_register_static(&host_arm_cpu_type_info);
>>
>>      return 0;
>> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
>> index c00450d..6955d85 100644
>> --- a/target/arm/kvm64.c
>> +++ b/target/arm/kvm64.c
>> @@ -27,6 +27,9 @@
>>  #include "kvm_arm.h"
>>  #include "internals.h"
>>  #include "hw/arm/arm.h"
>> +#include "exec/ram_addr.h"
>> +#include "hw/acpi/acpi-defs.h"
>> +#include "hw/acpi/hest_ghes.h"
>>
>>  static bool have_guest_debug;
>>
>> @@ -944,6 +947,37 @@ int kvm_arch_get_registers(CPUState *cs)
>>      return ret;
>>  }
>>
>> +void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>> +{
>> +    ram_addr_t ram_addr;
>> +    hwaddr paddr;
>> +
>> +    assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
>> +    if (addr) {
> 
> The x86 equivalent of this code has a check that amounts to
> "is the guest CPU actually able to accept MCE notifications?".
> It looks wrong that we don't have one here.

In the x86 code[1], it checks the MCG_SER_P(software error recovery support present) flag,
this flag indicates that whether the processor supports software error recovery[2]. In arm64(now we
do not support arm32), we do not have such bit. If check, it may need to check that whether processor
supports RAS feature, Otherwise what we should check? James Morse <james.morse@arm.com> has some concern that Qemu checks whether
processor supports RAS feature. He thinks QEMU should record guest CPER and notify guest when receiving
SIGBUS signal even though processor does not support RAS. so I do not know what we should check, host(include QEMU and KVM)
should not know that whether guest can able to accept MCE notifications.

[1]: void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr) {
     	if ((env->mcg_cap & MCG_SER_P) && addr) {
		.........
   	}
   }
[2]: https://xem.github.io/minix86/manual/intel-x86-and-64-manual-vol3/o_fe12b1e2a880e0ce-509.html


Hello James,
  As Peter mentioned, the x86 checks that whether the processor supports software error recovery before injecting MCE error in the user space.
For the ARM64, whether we should check something before recording guest CPER and inject SEA/IRQ? or nothing? I remember you are opposed to checking
processor RAS feature.

Below is user space code logic:
1. If kernel/KVM delivered host VA is not NULL and belonged to guest, then translate this host VA to guest PA.
2. if the SIBUS is BUS_MCEERR_AR, record the CPER for guest and inject SEA to notify guest
3. if the SIBUS is BUS_MCEERR_AO, record the CPER for guest and inject a GPIO IRQ to notify guest

In above logic, I do not check that processor support RAS feature.

> 
>> +        ram_addr = qemu_ram_addr_from_host(addr);
>> +        if (ram_addr != RAM_ADDR_INVALID &&
>> +            kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
>> +            kvm_hwpoison_page_add(ram_addr);
>> +            if (code == BUS_MCEERR_AR) {
>> +                kvm_cpu_synchronize_state(c);
> 
> This is missing a comment that explains why it's necessary.
Ok, thanks very much for the careful review. sure, I will add it.

> 
>> +                ghes_record_errors(ACPI_HEST_NOTIFY_SEA, paddr);
>> +                kvm_inject_arm_sea(c);
>> +            } else if (code == BUS_MCEERR_AO) {
>> +                ghes_record_errors(ACPI_HEST_NOTIFY_GPIO, paddr);
>> +                qemu_hardware_error_notify();
>> +            }
>> +            return;
>> +        }
>> +        fprintf(stderr, "Hardware memory error for memory used by "
>> +                "QEMU itself instead of guest system!\n");
>> +    }
>> +
>> +    if (code == BUS_MCEERR_AR) {
>> +        fprintf(stderr, "Hardware memory error!\n");
>> +        exit(1);
>> +    }
>> +}
> 
> I rather suspect we could have this function common, with
> the per-architecture interface being "does this guest CPU support
> reporting MCEs to it" and "report an MCE to the guest CPU". But
> it's not that much code, so I can live with it not being shared for
> now.
Thanks!
The x86 MCE mechanism and ARM64 RAS extension mechanism have some difference
include hardware and software. so the QEMU handling has some difference.

> 
>> +
>>  /* C6.6.29 BRK instruction */
>>  static const uint32_t brk_insn = 0xd4200000;
>>
>> --
>> 1.8.3.1
> 
> thanks
> -- PMM
> 
> .
> 
