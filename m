Received: from eggs.gnu.org ([2001:4830:134:3::10]:49101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eWz4s-0002Tx-Er
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:32:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eWz4r-00084t-0y
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:32:34 -0500
References: <1514440458-10515-1-git-send-email-gengdongjiu@huawei.com>
	<1514440458-10515-10-git-send-email-gengdongjiu@huawei.com>
	<20171228160727.62d0857d@igors-macbook-pro.local>
	<fed83a29-d96f-e696-8b94-dc2d1e81ee21@huawei.com>
	<20180103144442.21efd2c7@redhat.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <62b802f3-25b3-ba4b-211d-efc33ac9bf63@huawei.com>
Date: Thu, 4 Jan 2018 14:31:58 +0800
MIME-Version: 1.0
In-Reply-To: <20180103144442.21efd2c7@redhat.com>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, mtosatti@redhat.com, rth@twiddle.net, ehabkost@redhat.com, james.morse@arm.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, huangshaoyu@huawei.com, zhengqiang10@huawei.com, xuwei5@hisilicon.com

On 2018/1/3 21:44, Igor Mammedov wrote:
> On Wed, 3 Jan 2018 17:13:45 +0800
> gengdongjiu <gengdongjiu@huawei.com> wrote:
> 
>> On 2017/12/28 23:07, Igor Mammedov wrote:
>>> On Thu, 28 Dec 2017 13:54:18 +0800
>>> Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>>>   
>>>> Add SIGBUS signal handler. In this handler, it checks the SIGBUS type,
>>>> translates the host VA which is delivered by host to guest PA, then fill
>>>> this PA to CPER and fill the CPER to guest APEI GHES memory, finally
>>>> notify guest according to the SIGBUS type. There are two kinds of SIGBUS
>>>> that QEMU needs to handle, which are BUS_MCEERR_AO and BUS_MCEERR_AR.
>>>>
>>>> If guest accesses the poisoned memory, it generates Synchronous External
>>>> Abort(SEA). Then host kernel gets an APEI notification and call memory_failure()
>>>> to unmapped the affected page from the guest's stage2, and SIGBUS_MCEERR_AO  
>>> s/unmapped/unmap/  
>> Thanks.
>>
>>>   
>>>> is delivered to Qemu's main thread. If Qemu receives this SIGBUS, it will
>>>> create a new CPER and add it to guest APEI GHES memory, then notify the
>>>> guest with a GPIO-Signal notification.  
>>> too long sentence, it's hard get what goes on here, pls split it in simple
>>> sentences/rephrase so it would be easy to understand behavior.  
>> I will split it in simple sentences/rephrase.
>> Thanks for your detailed review.
>>
>>>   
>>>>
>>>> When guest hits a PG_hwpoison page, it will trap to KVM as stage2 fault, then a
>>>> SIGBUS_MCEERR_AR synchronous signal is delivered to Qemu, Qemu record this error
>>>> into guest APEI GHES memory and notify guest using Synchronous-External-Abort(SEA).
>>>>
>>>> Suggested-by: James Morse <james.morse@arm.com>
>>>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>>>> ---
>>>> Address James's comments to record CPER and notify guest for SIGBUS signal handling.
>>>> Shown some discussion in [1].
>>>>
>>>> [1]:
>>>> https://lkml.org/lkml/2017/2/27/246
>>>> https://lkml.org/lkml/2017/9/14/241
>>>> https://lkml.org/lkml/2017/9/22/499
>>>> ---
>>>>  include/sysemu/kvm.h |  2 +-
>>>>  target/arm/kvm.c     |  2 ++
>>>>  target/arm/kvm64.c   | 34 ++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 37 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
>>>> index 3a458f5..90c1605 100644
>>>> --- a/include/sysemu/kvm.h
>>>> +++ b/include/sysemu/kvm.h
>>>> @@ -361,7 +361,7 @@ bool kvm_vcpu_id_is_valid(int vcpu_id);
>>>>  /* Returns VCPU ID to be used on KVM_CREATE_VCPU ioctl() */
>>>>  unsigned long kvm_arch_vcpu_id(CPUState *cpu);
>>>>  
>>>> -#ifdef TARGET_I386
>>>> +#if defined(TARGET_I386) || defined(TARGET_AARCH64)
>>>>  #define KVM_HAVE_MCE_INJECTION 1
>>>>  void kvm_arch_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
>>>>  #endif
>>>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>>>> index 7c17f0d..9d25f51 100644
>>>> --- a/target/arm/kvm.c
>>>> +++ b/target/arm/kvm.c
>>>> @@ -26,6 +26,7 @@
>>>>  #include "exec/address-spaces.h"
>>>>  #include "hw/boards.h"
>>>>  #include "qemu/log.h"
>>>> +#include "exec/ram_addr.h"
>>>>  
>>>>  const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
>>>>      KVM_CAP_LAST_INFO
>>>> @@ -182,6 +183,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>>>>  
>>>>      cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
>>>>  
>>>> +    qemu_register_reset(kvm_unpoison_all, NULL);
>>>>      type_register_static(&host_arm_cpu_type_info);
>>>>  
>>>>      return 0;
>>>> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
>>>> index c00450d..6955d85 100644
>>>> --- a/target/arm/kvm64.c
>>>> +++ b/target/arm/kvm64.c
>>>> @@ -27,6 +27,9 @@
>>>>  #include "kvm_arm.h"
>>>>  #include "internals.h"
>>>>  #include "hw/arm/arm.h"
>>>> +#include "exec/ram_addr.h"
>>>> +#include "hw/acpi/acpi-defs.h"
>>>> +#include "hw/acpi/hest_ghes.h"
>>>>  
>>>>  static bool have_guest_debug;
>>>>  
>>>> @@ -944,6 +947,37 @@ int kvm_arch_get_registers(CPUState *cs)
>>>>      return ret;
>>>>  }
>>>>  
>>>> +void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>>>> +{
>>>> +    ram_addr_t ram_addr;
>>>> +    hwaddr paddr;
>>>> +
>>>> +    assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
>>>> +    if (addr) {
>>>> +        ram_addr = qemu_ram_addr_from_host(addr);
>>>> +        if (ram_addr != RAM_ADDR_INVALID &&
>>>> +            kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
>>>> +            kvm_hwpoison_page_add(ram_addr);
>>>> +            if (code == BUS_MCEERR_AR) {
>>>> +                kvm_cpu_synchronize_state(c);
>>>> +                ghes_record_errors(ACPI_HEST_NOTIFY_SEA, paddr);
>>>> +                kvm_inject_arm_sea(c);
>>>> +            } else if (code == BUS_MCEERR_AO) {
>>>> +                ghes_record_errors(ACPI_HEST_NOTIFY_GPIO, paddr);
>>>> +                qemu_hardware_error_notify();
>>>> +            }
>>>> +            return;
>>>> +        }
>>>> +        fprintf(stderr, "Hardware memory error for memory used by "
>>>> +                "QEMU itself instead of guest system!\n");  
>>> not quite sure what above message means,  
>> When the memory error address belong to QEMU itself, not belong to guest OS.
>> it will print above message.
>>
>> Above message means this memory error happens in QEMU application instead of guest OS.
> I'm not really understand what's going here and how it could happen,

Thanks, sorry for your confusion. I make a example:

As a general application, when QEMU does not run guest, if Qemu's thread touch a poison user space
memory, it will trap to host kernel, host kernel will call memory error handler(memory_failure())
to handle this error access, kernel memory error handler will deliver SIGBUS to QEMU, in this
process, KVM and guest are not involved. Because this address is not belong to guest(not match 'if'
condition in[1]), so it go to here and print above message.

[1]:
        if (ram_addr != RAM_ADDR_INVALID &&
             kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
	          .......
	     return;
         }
         fprintf(stderr, "Hardware memory error for memory used by "
                 "QEMU itself instead of guest system!\n");

> so I can't suggest something. Perhaps someone else could comment on it.
>  
>>> also fprintf() probably shouldn't be used by new code.  
>> how about we use error_report()? thanks
> I'm not sure what current trend is, but I'd use error_report() vs fprintf()
> 
> Also series could benefit from trace-points (I haven't noticed any).
I will add some trace-points, thanks.

> 
>>>   
>>>> +    }
>>>> +
>>>> +    if (code == BUS_MCEERR_AR) {
>>>> +        fprintf(stderr, "Hardware memory error!\n");
>>>> +        exit(1);
>>>> +    }
>>>> +}
>>>> +
>>>>  /* C6.6.29 BRK instruction */
>>>>  static const uint32_t brk_insn = 0xd4200000;
>>>>    
>>>
>>>
>>> .
>>>   
>>
> 
> 
> .
> 
