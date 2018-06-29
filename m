Received: from eggs.gnu.org ([2001:4830:134:3::10]:44692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYtrl-0001zf-Nr
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYtri-0003AN-Lp
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:55:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33550 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fYtri-00038Z-FO
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:55:10 -0400
References: <20180610184927.19309-1-vkuznets@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <102161d8-5d70-ae5c-4056-6f8f389cdb6a@redhat.com>
Date: Fri, 29 Jun 2018 15:55:07 +0200
MIME-Version: 1.0
In-Reply-To: <20180610184927.19309-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i386/kvm: add support for Hyper-V TLB flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>

On 10/06/2018 20:49, Vitaly Kuznetsov wrote:
> Add support for Hyper-V TLB flush which recently got added to KVM.
> 
> Just like regular Hyper-V we announce HV_EX_PROCESSOR_MASKS_RECOMMENDED
> regardless of how many vCPUs we have. Windows is 'smart' and uses less
> expensive non-EX Hypercall whenever possible (when it wants to flush TLB
> for all vCPUs or the maximum vCPU index in the vCPU set requires flushing
> is less than 64).
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  linux-headers/linux/kvm.h  |  1 +
>  target/i386/cpu.c          |  1 +
>  target/i386/cpu.h          |  1 +
>  target/i386/hyperv-proto.h |  1 +
>  target/i386/kvm.c          | 15 ++++++++++++++-
>  5 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index cdb148e959..a52a685690 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -948,6 +948,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_S390_BPB 152
>  #define KVM_CAP_GET_MSR_FEATURES 153
>  #define KVM_CAP_HYPERV_EVENTFD 154
> +#define KVM_CAP_HYPERV_TLBFLUSH 155
>  
>  #ifdef KVM_CAP_IRQ_ROUTING
>  
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 94260412e2..756cc78808 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5151,6 +5151,7 @@ static Property x86_cpu_properties[] = {
>      DEFINE_PROP_BOOL("hv-stimer", X86CPU, hyperv_stimer, false),
>      DEFINE_PROP_BOOL("hv-frequencies", X86CPU, hyperv_frequencies, false),
>      DEFINE_PROP_BOOL("hv-reenlightenment", X86CPU, hyperv_reenlightenment, false),
> +    DEFINE_PROP_BOOL("hv-tlbflush", X86CPU, hyperv_tlbflush, false),
>      DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
>      DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
>      DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 664504610e..738d695331 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1363,6 +1363,7 @@ struct X86CPU {
>      bool hyperv_stimer;
>      bool hyperv_frequencies;
>      bool hyperv_reenlightenment;
> +    bool hyperv_tlbflush;
>      bool check_cpuid;
>      bool enforce_cpuid;
>      bool expose_kvm;
> diff --git a/target/i386/hyperv-proto.h b/target/i386/hyperv-proto.h
> index 93352ebd2a..d6d5a79293 100644
> --- a/target/i386/hyperv-proto.h
> +++ b/target/i386/hyperv-proto.h
> @@ -58,6 +58,7 @@
>  #define HV_APIC_ACCESS_RECOMMENDED          (1u << 3)
>  #define HV_SYSTEM_RESET_RECOMMENDED         (1u << 4)
>  #define HV_RELAXED_TIMING_RECOMMENDED       (1u << 5)
> +#define HV_EX_PROCESSOR_MASKS_RECOMMENDED   (1u << 11)
>  
>  /*
>   * Basic virtualized MSRs
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 44f70733e7..91c8e952c8 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -585,7 +585,8 @@ static bool hyperv_enabled(X86CPU *cpu)
>              cpu->hyperv_runtime ||
>              cpu->hyperv_synic ||
>              cpu->hyperv_stimer ||
> -            cpu->hyperv_reenlightenment);
> +            cpu->hyperv_reenlightenment ||
> +            cpu->hyperv_tlbflush);
>  }
>  
>  static int kvm_arch_set_tsc_khz(CPUState *cs)
> @@ -823,6 +824,18 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          if (cpu->hyperv_vapic) {
>              c->eax |= HV_APIC_ACCESS_RECOMMENDED;
>          }
> +        if (cpu->hyperv_tlbflush) {
> +            if (kvm_check_extension(cs->kvm_state,
> +                                    KVM_CAP_HYPERV_TLBFLUSH) <= 0) {
> +                fprintf(stderr, "Hyper-V TLB flush support "
> +                        "(requested by 'hv-tlbflush' cpu flag) "
> +                        " is not supported by kernel\n");
> +                return -ENOSYS;
> +            }
> +            c->eax |= HV_REMOTE_TLB_FLUSH_RECOMMENDED;
> +            c->eax |= HV_EX_PROCESSOR_MASKS_RECOMMENDED;
> +        }
> +
>          c->ebx = cpu->hyperv_spinlock_attempts;
>  
>          c = &cpuid_data.entries[cpuid_i++];
> 

Queued, thanks.

Paolo
