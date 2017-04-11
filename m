Received: from eggs.gnu.org ([2001:4830:134:3::10]:43191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1cxv6m-0005ex-UB
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1cxv6j-00018z-LL
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:41:20 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gsomlo@gmail.com>) id 1cxv6j-00017P-Gb
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:41:17 -0400
Received: by mail-qt0-x243.google.com with SMTP id r49so10037564qta.1
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 05:41:15 -0700 (PDT)
Date: Tue, 11 Apr 2017 08:41:11 -0400
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
Message-ID: <20170411124109.GB29540@HEDWIG.INI.CMU.EDU>
References: <1491911135-216950-1-git-send-email-agraf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491911135-216950-1-git-send-email-agraf@suse.de>
Subject: Re: [Qemu-devel] [PATCH v6] kvm: better MWAIT emulation for guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>
Cc: kvm list <kvm@vger.kernel.org>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jim Mattson <jmattson@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, qemu-devel@nongnu.org

On Tue, Apr 11, 2017 at 01:45:35PM +0200, Alexander Graf wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> 
> Guests that are heavy on futexes end up IPI'ing each other a lot. That
> can lead to significant slowdowns and latency increase for those guests
> when running within KVM.
> 
> If only a single guest is needed on a host, we have a lot of spare host
> CPU time we can throw at the problem. Modern CPUs implement a feature
> called "MWAIT" which allows guests to wake up sleeping remote CPUs without
> an IPI - thus without an exit - at the expense of never going out of guest
> context.
> 
> The decision whether this is something sensible to use should be up to the
> VM admin, so to user space. We can however allow MWAIT execution on systems
> that support it properly hardware wise.
> 
> This patch adds a CAP to user space and a KVM cpuid leaf to indicate
> availability of native MWAIT execution. With that enabled, the worst a
> guest can do is waste as many cycles as a "jmp ." would do, so it's not
> a privilege problem.

Did you mean "hlt" rather than "jmp" ?

> We consciously do *not* expose the feature in our CPUID bitmap, as most
> people will want to benefit from sleeping vCPUs to allow for over commit.
> 
> Reported-by: "Gabriel L. Somlo" <gsomlo@gmail.com>

That's maybe a bit inacurate, I didn't actually report anything *this*
patch is trying to address (that was rather commit 87c00572ba05aa8c9d).

Maybe

Acked-by: Gabriel Somlo <gsomlo@gmail.com>

would be a more accurate statement instead?

Thanks much,
--Gabriel

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> [agraf: fix amd, change commit message]
> Signed-off-by: Alexander Graf <agraf@suse.de>
> 
> ---
> 
> v5 -> v6:
> 
>   - Fix AMD check, so that we're consistent between svm and vmx
>   - Clarify commit message
> ---
>  Documentation/virtual/kvm/api.txt    |  9 +++++++++
>  Documentation/virtual/kvm/cpuid.txt  |  6 ++++++
>  arch/x86/include/uapi/asm/kvm_para.h |  1 +
>  arch/x86/kvm/cpuid.c                 |  3 +++
>  arch/x86/kvm/svm.c                   |  7 +++++--
>  arch/x86/kvm/vmx.c                   |  6 ++++--
>  arch/x86/kvm/x86.c                   |  3 +++
>  arch/x86/kvm/x86.h                   | 36 ++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/kvm.h             |  1 +
>  9 files changed, 68 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index 1a18484..dacc3d7 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -4094,3 +4094,12 @@ reserved.
>   2: MIPS64 or microMIPS64 with access to all address segments.
>      Both registers and addresses are 64-bits wide.
>      It will be possible to run 64-bit or 32-bit guest code.
> +
> +8.8 KVM_CAP_X86_GUEST_MWAIT
> +
> +Architectures: x86
> +
> +This capability indicates that guest using memory monotoring instructions
> +(MWAIT/MWAITX) to stop the virtual CPU will not cause a VM exit.  As such time
> +spent while virtual CPU is halted in this way will then be accounted for as
> +guest running time on the host (as opposed to e.g. HLT).
> diff --git a/Documentation/virtual/kvm/cpuid.txt b/Documentation/virtual/kvm/cpuid.txt
> index 3c65feb..04c201c 100644
> --- a/Documentation/virtual/kvm/cpuid.txt
> +++ b/Documentation/virtual/kvm/cpuid.txt
> @@ -54,6 +54,12 @@ KVM_FEATURE_PV_UNHALT              ||     7 || guest checks this feature bit
>                                     ||       || before enabling paravirtualized
>                                     ||       || spinlock support.
>  ------------------------------------------------------------------------------
> +KVM_FEATURE_MWAIT                  ||     8 || guest can use monitor/mwait
> +                                   ||       || to halt the VCPU without exits,
> +                                   ||       || time spent while halted in this
> +                                   ||       || way is accounted for on host as
> +                                   ||       || VCPU run time.
> +------------------------------------------------------------------------------
>  KVM_FEATURE_CLOCKSOURCE_STABLE_BIT ||    24 || host will warn if no guest-side
>                                     ||       || per-cpu warps are expected in
>                                     ||       || kvmclock.
> diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
> index cff0bb6..9cc77a7 100644
> --- a/arch/x86/include/uapi/asm/kvm_para.h
> +++ b/arch/x86/include/uapi/asm/kvm_para.h
> @@ -24,6 +24,7 @@
>  #define KVM_FEATURE_STEAL_TIME		5
>  #define KVM_FEATURE_PV_EOI		6
>  #define KVM_FEATURE_PV_UNHALT		7
> +#define KVM_FEATURE_MWAIT		8
>  
>  /* The last 8 bits are used to indicate how to interpret the flags field
>   * in pvclock structure. If no bits are set, all flags are ignored.
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index efde6cc..5638102 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -594,6 +594,9 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  		if (sched_info_on())
>  			entry->eax |= (1 << KVM_FEATURE_STEAL_TIME);
>  
> +		if (kvm_mwait_in_guest())
> +			entry->eax |= (1 << KVM_FEATURE_MWAIT);
> +
>  		entry->ebx = 0;
>  		entry->ecx = 0;
>  		entry->edx = 0;
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 1b203ab..c41f03e 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -1198,10 +1198,13 @@ static void init_vmcb(struct vcpu_svm *svm)
>  	set_intercept(svm, INTERCEPT_CLGI);
>  	set_intercept(svm, INTERCEPT_SKINIT);
>  	set_intercept(svm, INTERCEPT_WBINVD);
> -	set_intercept(svm, INTERCEPT_MONITOR);
> -	set_intercept(svm, INTERCEPT_MWAIT);
>  	set_intercept(svm, INTERCEPT_XSETBV);
>  
> +	if (!kvm_mwait_in_guest()) {
> +		set_intercept(svm, INTERCEPT_MONITOR);
> +		set_intercept(svm, INTERCEPT_MWAIT);
> +	}
> +
>  	control->iopm_base_pa = iopm_base;
>  	control->msrpm_base_pa = __pa(svm->msrpm);
>  	control->int_ctl = V_INTR_MASKING_MASK;
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index cfdb0d9..2e62f9d 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -3547,11 +3547,13 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf)
>  	      CPU_BASED_USE_IO_BITMAPS |
>  	      CPU_BASED_MOV_DR_EXITING |
>  	      CPU_BASED_USE_TSC_OFFSETING |
> -	      CPU_BASED_MWAIT_EXITING |
> -	      CPU_BASED_MONITOR_EXITING |
>  	      CPU_BASED_INVLPG_EXITING |
>  	      CPU_BASED_RDPMC_EXITING;
>  
> +	if (!kvm_mwait_in_guest())
> +		min |= CPU_BASED_MWAIT_EXITING |
> +			CPU_BASED_MONITOR_EXITING;
> +
>  	opt = CPU_BASED_TPR_SHADOW |
>  	      CPU_BASED_USE_MSR_BITMAPS |
>  	      CPU_BASED_ACTIVATE_SECONDARY_CONTROLS;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 6bc47e2..ffaa76d 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2679,6 +2679,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_ADJUST_CLOCK:
>  		r = KVM_CLOCK_TSC_STABLE;
>  		break;
> +	case KVM_CAP_X86_GUEST_MWAIT:
> +		r = kvm_mwait_in_guest();
> +		break;
>  	case KVM_CAP_X86_SMM:
>  		/* SMBASE is usually relocated above 1M on modern chipsets,
>  		 * and SMM handlers might indeed rely on 4G segment limits,
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index e8ff3e4..6120670 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -1,6 +1,8 @@
>  #ifndef ARCH_X86_KVM_X86_H
>  #define ARCH_X86_KVM_X86_H
>  
> +#include <asm/processor.h>
> +#include <asm/mwait.h>
>  #include <linux/kvm_host.h>
>  #include <asm/pvclock.h>
>  #include "kvm_cache_regs.h"
> @@ -212,4 +214,38 @@ static inline u64 nsec_to_cycles(struct kvm_vcpu *vcpu, u64 nsec)
>  	    __rem;						\
>  	 })
>  
> +static inline bool kvm_mwait_in_guest(void)
> +{
> +	unsigned int eax, ebx, ecx, edx;
> +
> +	if (!cpu_has(&boot_cpu_data, X86_FEATURE_MWAIT))
> +		return false;
> +
> +	switch (boot_cpu_data.x86_vendor) {
> +	case X86_VENDOR_AMD:
> +		/* All AMD CPUs have a working MWAIT implementation */
> +		return true;
> +	case X86_VENDOR_INTEL:
> +		/* Handle Intel below */
> +		break;
> +	default:
> +		return false;
> +	}
> +
> +	/*
> +	 * Intel CPUs without CPUID5_ECX_INTERRUPT_BREAK are problematic as
> +	 * they would allow guest to stop the CPU completely by disabling
> +	 * interrupts then invoking MWAIT.
> +	 */
> +	if (boot_cpu_data.cpuid_level < CPUID_MWAIT_LEAF)
> +		return false;
> +
> +	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
> +
> +	if (!(ecx & CPUID5_ECX_INTERRUPT_BREAK))
> +		return false;
> +
> +	return true;
> +}
> +
>  #endif
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 1e1a6c7..a3f03d3 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -890,6 +890,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_MIPS_VZ 137
>  #define KVM_CAP_MIPS_TE 138
>  #define KVM_CAP_MIPS_64BIT 139
> +#define KVM_CAP_X86_GUEST_MWAIT 140
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
> -- 
> 1.8.5.6
> 
