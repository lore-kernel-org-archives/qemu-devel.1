Received: from eggs.gnu.org ([2001:4830:134:3::10]:42975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eWjLo-0003hH-JZ
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 08:45:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eWjLn-0003UJ-1o
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 08:45:00 -0500
Date: Wed, 3 Jan 2018 14:44:42 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180103144442.21efd2c7@redhat.com>
In-Reply-To: <fed83a29-d96f-e696-8b94-dc2d1e81ee21@huawei.com>
References: <1514440458-10515-1-git-send-email-gengdongjiu@huawei.com>
	<1514440458-10515-10-git-send-email-gengdongjiu@huawei.com>
	<20171228160727.62d0857d@igors-macbook-pro.local>
	<fed83a29-d96f-e696-8b94-dc2d1e81ee21@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: pbonzini@redhat.com, mst@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, mtosatti@redhat.com, rth@twiddle.net, ehabkost@redhat.com, james.morse@arm.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, huangshaoyu@huawei.com, zhengqiang10@huawei.com, xuwei5@hisilicon.com

On Wed, 3 Jan 2018 17:13:45 +0800
gengdongjiu <gengdongjiu@huawei.com> wrote:

> On 2017/12/28 23:07, Igor Mammedov wrote:
> > On Thu, 28 Dec 2017 13:54:18 +0800
> > Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> >   
> >> Add SIGBUS signal handler. In this handler, it checks the SIGBUS type,
> >> translates the host VA which is delivered by host to guest PA, then fill
> >> this PA to CPER and fill the CPER to guest APEI GHES memory, finally
> >> notify guest according to the SIGBUS type. There are two kinds of SIGBUS
> >> that QEMU needs to handle, which are BUS_MCEERR_AO and BUS_MCEERR_AR.
> >>
> >> If guest accesses the poisoned memory, it generates Synchronous External
> >> Abort(SEA). Then host kernel gets an APEI notification and call memory_failure()
> >> to unmapped the affected page from the guest's stage2, and SIGBUS_MCEERR_AO  
> > s/unmapped/unmap/  
> Thanks.
> 
> >   
> >> is delivered to Qemu's main thread. If Qemu receives this SIGBUS, it will
> >> create a new CPER and add it to guest APEI GHES memory, then notify the
> >> guest with a GPIO-Signal notification.  
> > too long sentence, it's hard get what goes on here, pls split it in simple
> > sentences/rephrase so it would be easy to understand behavior.  
> I will split it in simple sentences/rephrase.
> Thanks for your detailed review.
> 
> >   
> >>
> >> When guest hits a PG_hwpoison page, it will trap to KVM as stage2 fault, then a
> >> SIGBUS_MCEERR_AR synchronous signal is delivered to Qemu, Qemu record this error
> >> into guest APEI GHES memory and notify guest using Synchronous-External-Abort(SEA).
> >>
> >> Suggested-by: James Morse <james.morse@arm.com>
> >> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> >> ---
> >> Address James's comments to record CPER and notify guest for SIGBUS signal handling.
> >> Shown some discussion in [1].
> >>
> >> [1]:
> >> https://lkml.org/lkml/2017/2/27/246
> >> https://lkml.org/lkml/2017/9/14/241
> >> https://lkml.org/lkml/2017/9/22/499
> >> ---
> >>  include/sysemu/kvm.h |  2 +-
> >>  target/arm/kvm.c     |  2 ++
> >>  target/arm/kvm64.c   | 34 ++++++++++++++++++++++++++++++++++
> >>  3 files changed, 37 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> >> index 3a458f5..90c1605 100644
> >> --- a/include/sysemu/kvm.h
> >> +++ b/include/sysemu/kvm.h
> >> @@ -361,7 +361,7 @@ bool kvm_vcpu_id_is_valid(int vcpu_id);
> >>  /* Returns VCPU ID to be used on KVM_CREATE_VCPU ioctl() */
> >>  unsigned long kvm_arch_vcpu_id(CPUState *cpu);
> >>  
> >> -#ifdef TARGET_I386
> >> +#if defined(TARGET_I386) || defined(TARGET_AARCH64)
> >>  #define KVM_HAVE_MCE_INJECTION 1
> >>  void kvm_arch_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
> >>  #endif
> >> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> >> index 7c17f0d..9d25f51 100644
> >> --- a/target/arm/kvm.c
> >> +++ b/target/arm/kvm.c
> >> @@ -26,6 +26,7 @@
> >>  #include "exec/address-spaces.h"
> >>  #include "hw/boards.h"
> >>  #include "qemu/log.h"
> >> +#include "exec/ram_addr.h"
> >>  
> >>  const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
> >>      KVM_CAP_LAST_INFO
> >> @@ -182,6 +183,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> >>  
> >>      cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
> >>  
> >> +    qemu_register_reset(kvm_unpoison_all, NULL);
> >>      type_register_static(&host_arm_cpu_type_info);
> >>  
> >>      return 0;
> >> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> >> index c00450d..6955d85 100644
> >> --- a/target/arm/kvm64.c
> >> +++ b/target/arm/kvm64.c
> >> @@ -27,6 +27,9 @@
> >>  #include "kvm_arm.h"
> >>  #include "internals.h"
> >>  #include "hw/arm/arm.h"
> >> +#include "exec/ram_addr.h"
> >> +#include "hw/acpi/acpi-defs.h"
> >> +#include "hw/acpi/hest_ghes.h"
> >>  
> >>  static bool have_guest_debug;
> >>  
> >> @@ -944,6 +947,37 @@ int kvm_arch_get_registers(CPUState *cs)
> >>      return ret;
> >>  }
> >>  
> >> +void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
> >> +{
> >> +    ram_addr_t ram_addr;
> >> +    hwaddr paddr;
> >> +
> >> +    assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
> >> +    if (addr) {
> >> +        ram_addr = qemu_ram_addr_from_host(addr);
> >> +        if (ram_addr != RAM_ADDR_INVALID &&
> >> +            kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
> >> +            kvm_hwpoison_page_add(ram_addr);
> >> +            if (code == BUS_MCEERR_AR) {
> >> +                kvm_cpu_synchronize_state(c);
> >> +                ghes_record_errors(ACPI_HEST_NOTIFY_SEA, paddr);
> >> +                kvm_inject_arm_sea(c);
> >> +            } else if (code == BUS_MCEERR_AO) {
> >> +                ghes_record_errors(ACPI_HEST_NOTIFY_GPIO, paddr);
> >> +                qemu_hardware_error_notify();
> >> +            }
> >> +            return;
> >> +        }
> >> +        fprintf(stderr, "Hardware memory error for memory used by "
> >> +                "QEMU itself instead of guest system!\n");  
> > not quite sure what above message means,  
> When the memory error address belong to QEMU itself, not belong to guest OS.
> it will print above message.
> 
> Above message means this memory error happens in QEMU application instead of guest OS.
I'm not really understand what's going here and how it could happen,
so I can't suggest something. Perhaps someone else could comment on it.
 
> > also fprintf() probably shouldn't be used by new code.  
> how about we use error_report()? thanks
I'm not sure what current trend is, but I'd use error_report() vs fprintf()

Also series could benefit from trace-points (I haven't noticed any).

> >   
> >> +    }
> >> +
> >> +    if (code == BUS_MCEERR_AR) {
> >> +        fprintf(stderr, "Hardware memory error!\n");
> >> +        exit(1);
> >> +    }
> >> +}
> >> +
> >>  /* C6.6.29 BRK instruction */
> >>  static const uint32_t brk_insn = 0xd4200000;
> >>    
> > 
> > 
> > .
> >   
> 
