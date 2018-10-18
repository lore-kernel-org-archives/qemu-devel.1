Received: from eggs.gnu.org ([2001:4830:134:3::10]:58490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gD7Z6-0003xj-9t
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 08:38:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gD7Z2-0001RB-8l
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 08:38:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gD7Z2-0001QW-0k
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 08:38:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id n1-v6so33508491wrt.10
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 05:38:07 -0700 (PDT)
References: <20181009130853.6412-1-vkuznets@redhat.com>
	<20181009130853.6412-3-vkuznets@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bbb0a427-f41f-7415-ee10-618665864272@redhat.com>
Date: Thu, 18 Oct 2018 14:38:03 +0200
MIME-Version: 1.0
In-Reply-To: <20181009130853.6412-3-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] i386/kvm: add support for Hyper-V
 IPI send
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On 09/10/2018 15:08, Vitaly Kuznetsov wrote:
> Hyper-V PV IPI support is merged to KVM, enable the feature in Qemu. When
> enabled, this allows Windows guests to send IPIs to other vCPUs with a
> single hypercall even when there are >64 vCPUs in the request.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
> ---
>  target/i386/cpu.c          |  1 +
>  target/i386/cpu.h          |  1 +
>  target/i386/hyperv-proto.h |  1 +
>  target/i386/kvm.c          | 14 +++++++++++++-
>  4 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index c88876dfe3..32ea041c06 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5564,6 +5564,7 @@ static Property x86_cpu_properties[] = {
>      DEFINE_PROP_BOOL("hv-frequencies", X86CPU, hyperv_frequencies, false),
>      DEFINE_PROP_BOOL("hv-reenlightenment", X86CPU, hyperv_reenlightenment, false),
>      DEFINE_PROP_BOOL("hv-tlbflush", X86CPU, hyperv_tlbflush, false),
> +    DEFINE_PROP_BOOL("hv-ipi", X86CPU, hyperv_ipi, false),
>      DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
>      DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
>      DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 730c06f80a..caa1544b2e 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1382,6 +1382,7 @@ struct X86CPU {
>      bool hyperv_frequencies;
>      bool hyperv_reenlightenment;
>      bool hyperv_tlbflush;
> +    bool hyperv_ipi;
>      bool check_cpuid;
>      bool enforce_cpuid;
>      bool expose_kvm;
> diff --git a/target/i386/hyperv-proto.h b/target/i386/hyperv-proto.h
> index d6d5a79293..87f36d14e8 100644
> --- a/target/i386/hyperv-proto.h
> +++ b/target/i386/hyperv-proto.h
> @@ -58,6 +58,7 @@
>  #define HV_APIC_ACCESS_RECOMMENDED          (1u << 3)
>  #define HV_SYSTEM_RESET_RECOMMENDED         (1u << 4)
>  #define HV_RELAXED_TIMING_RECOMMENDED       (1u << 5)
> +#define HV_CLUSTER_IPI_RECOMMENDED          (1u << 10)
>  #define HV_EX_PROCESSOR_MASKS_RECOMMENDED   (1u << 11)
>  
>  /*
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index dc4047b02f..795aa52938 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -608,7 +608,8 @@ static bool hyperv_enabled(X86CPU *cpu)
>              cpu->hyperv_synic ||
>              cpu->hyperv_stimer ||
>              cpu->hyperv_reenlightenment ||
> -            cpu->hyperv_tlbflush);
> +            cpu->hyperv_tlbflush ||
> +            cpu->hyperv_ipi);
>  }
>  
>  static int kvm_arch_set_tsc_khz(CPUState *cs)
> @@ -888,6 +889,17 @@ int kvm_arch_init_vcpu(CPUState *cs)
>              c->eax |= HV_REMOTE_TLB_FLUSH_RECOMMENDED;
>              c->eax |= HV_EX_PROCESSOR_MASKS_RECOMMENDED;
>          }
> +        if (cpu->hyperv_ipi) {
> +            if (kvm_check_extension(cs->kvm_state,
> +                                    KVM_CAP_HYPERV_SEND_IPI) <= 0) {
> +                fprintf(stderr, "Hyper-V IPI send support "
> +                        "(requested by 'hv-ipi' cpu flag) "
> +                        " is not supported by kernel\n");
> +                return -ENOSYS;
> +            }
> +            c->eax |= HV_CLUSTER_IPI_RECOMMENDED;
> +            c->eax |= HV_EX_PROCESSOR_MASKS_RECOMMENDED;
> +        }
>  
>          c->ebx = cpu->hyperv_spinlock_attempts;
>  
> 

Queued patch 2, thanks.

Paolo
