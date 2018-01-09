Received: from eggs.gnu.org ([2001:4830:134:3::10]:54367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYxTv-0006cz-TN
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:14:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYxTu-0007j9-EV
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:14:35 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:36122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYxTu-0007ij-7x
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:14:34 -0500
Received: by mail-ot0-x243.google.com with SMTP id w4so11928681otg.3
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 09:14:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1514440458-10515-10-git-send-email-gengdongjiu@huawei.com>
References: <1514440458-10515-1-git-send-email-gengdongjiu@huawei.com>
	<1514440458-10515-10-git-send-email-gengdongjiu@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2018 17:14:12 +0000
Message-ID: <CAFEAcA84tR_9e24DqvR9vsNvFBbK86fUTBnQdBjWKDGj4wkTGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Marcelo Tosatti <mtosatti@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, James Morse <james.morse@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, kvm-devel <kvm@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Huangshaoyu <huangshaoyu@huawei.com>, "Zhengqiang (turing)" <zhengqiang10@huawei.com>, Xu Wei <xuwei5@hisilicon.com>

On 28 December 2017 at 05:54, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> Add SIGBUS signal handler. In this handler, it checks the SIGBUS type,
> translates the host VA which is delivered by host to guest PA, then fill
> this PA to CPER and fill the CPER to guest APEI GHES memory, finally
> notify guest according to the SIGBUS type. There are two kinds of SIGBUS
> that QEMU needs to handle, which are BUS_MCEERR_AO and BUS_MCEERR_AR.
>
> If guest accesses the poisoned memory, it generates Synchronous External
> Abort(SEA). Then host kernel gets an APEI notification and call memory_failure()
> to unmapped the affected page from the guest's stage2, and SIGBUS_MCEERR_AO
> is delivered to Qemu's main thread. If Qemu receives this SIGBUS, it will
> create a new CPER and add it to guest APEI GHES memory, then notify the
> guest with a GPIO-Signal notification.
>
> When guest hits a PG_hwpoison page, it will trap to KVM as stage2 fault, then a
> SIGBUS_MCEERR_AR synchronous signal is delivered to Qemu, Qemu record this error
> into guest APEI GHES memory and notify guest using Synchronous-External-Abort(SEA).
>
> Suggested-by: James Morse <james.morse@arm.com>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
> Address James's comments to record CPER and notify guest for SIGBUS signal handling.
> Shown some discussion in [1].
>
> [1]:
> https://lkml.org/lkml/2017/2/27/246
> https://lkml.org/lkml/2017/9/14/241
> https://lkml.org/lkml/2017/9/22/499
> ---
>  include/sysemu/kvm.h |  2 +-
>  target/arm/kvm.c     |  2 ++
>  target/arm/kvm64.c   | 34 ++++++++++++++++++++++++++++++++++
>  3 files changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 3a458f5..90c1605 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -361,7 +361,7 @@ bool kvm_vcpu_id_is_valid(int vcpu_id);
>  /* Returns VCPU ID to be used on KVM_CREATE_VCPU ioctl() */
>  unsigned long kvm_arch_vcpu_id(CPUState *cpu);
>
> -#ifdef TARGET_I386
> +#if defined(TARGET_I386) || defined(TARGET_AARCH64)

As a general rule we should not introduce new ifdefs with
lists of architectures in them. Instead the targets which support
something should define something suitable in a per-target
header file.

In this case I think you should:
 * move the define KVM_HAVE_MCE_INJECTION to target/i386/cpu.h,
   and have this ifdef be #ifdef KVM_HAVE_MCE_INJECTION
   (that should be in a different patch)
 * have the target-arm patch then just define KVM_HAVE_MCE_INJECTION
   in target/arm/cpu.h (if TARGET_AARCH64) and provide
   kvm_arch_on_sigbus_vcpu()

>  #define KVM_HAVE_MCE_INJECTION 1
>  void kvm_arch_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
>  #endif
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 7c17f0d..9d25f51 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -26,6 +26,7 @@
>  #include "exec/address-spaces.h"
>  #include "hw/boards.h"
>  #include "qemu/log.h"
> +#include "exec/ram_addr.h"

Why this #include ?

>  const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
>      KVM_CAP_LAST_INFO
> @@ -182,6 +183,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>
>      cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
>
> +    qemu_register_reset(kvm_unpoison_all, NULL);

Looking at this, I realised that we can do this generically in
kvm_init_vcpu() in kvm-all.c (guarded by #ifdef KVM_HAVE_MCE_INJECTION).
You can move the qemu_register_reset() call from target/i386 into
that common code in the patch where you move the unpoison functions.
Then you can make kvm_unpoison_all be static rather than global.

>      type_register_static(&host_arm_cpu_type_info);
>
>      return 0;
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index c00450d..6955d85 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -27,6 +27,9 @@
>  #include "kvm_arm.h"
>  #include "internals.h"
>  #include "hw/arm/arm.h"
> +#include "exec/ram_addr.h"
> +#include "hw/acpi/acpi-defs.h"
> +#include "hw/acpi/hest_ghes.h"
>
>  static bool have_guest_debug;
>
> @@ -944,6 +947,37 @@ int kvm_arch_get_registers(CPUState *cs)
>      return ret;
>  }
>
> +void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
> +{
> +    ram_addr_t ram_addr;
> +    hwaddr paddr;
> +
> +    assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
> +    if (addr) {

The x86 equivalent of this code has a check that amounts to
"is the guest CPU actually able to accept MCE notifications?".
It looks wrong that we don't have one here.

It's also suspicious that our "send an MCE notification" is
ACPI specific, when not all our aarch64 boards have ACPI,
and even on virt it's optional.

> +        ram_addr = qemu_ram_addr_from_host(addr);
> +        if (ram_addr != RAM_ADDR_INVALID &&
> +            kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
> +            kvm_hwpoison_page_add(ram_addr);
> +            if (code == BUS_MCEERR_AR) {
> +                kvm_cpu_synchronize_state(c);

This is missing a comment that explains why it's necessary.

> +                ghes_record_errors(ACPI_HEST_NOTIFY_SEA, paddr);
> +                kvm_inject_arm_sea(c);
> +            } else if (code == BUS_MCEERR_AO) {
> +                ghes_record_errors(ACPI_HEST_NOTIFY_GPIO, paddr);
> +                qemu_hardware_error_notify();
> +            }
> +            return;
> +        }
> +        fprintf(stderr, "Hardware memory error for memory used by "
> +                "QEMU itself instead of guest system!\n");
> +    }
> +
> +    if (code == BUS_MCEERR_AR) {
> +        fprintf(stderr, "Hardware memory error!\n");
> +        exit(1);
> +    }
> +}

I rather suspect we could have this function common, with
the per-architecture interface being "does this guest CPU support
reporting MCEs to it" and "report an MCE to the guest CPU". But
it's not that much code, so I can live with it not being shared for
now.

> +
>  /* C6.6.29 BRK instruction */
>  static const uint32_t brk_insn = 0xd4200000;
>
> --
> 1.8.3.1

thanks
-- PMM
