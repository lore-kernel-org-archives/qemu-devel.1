Received: from eggs.gnu.org ([2001:4830:134:3::10]:46783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ewqeT-0007ks-Rm
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ewqeP-0002gU-Tt
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:48:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38930 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ewqeP-0002gD-MZ
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:48:09 -0400
References: <20180312151233.16565-1-vkuznets@redhat.com>
	<20180312151233.16565-2-vkuznets@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <435d80c2-ec07-9032-8d07-cac15fc437db@redhat.com>
Date: Fri, 16 Mar 2018 15:48:02 +0100
MIME-Version: 1.0
In-Reply-To: <20180312151233.16565-2-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] i386/kvm: add support for Hyper-V
 reenlightenment MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org

On 12/03/2018 16:12, Vitaly Kuznetsov wrote:
> KVM recently gained support for Hyper-V Reenlightenment MSRs which are
> required to make KVM-on-Hyper-V enable TSC page clocksource to its guests
> when INVTSC is not passed to it (and it is not passed by default in Qemu
> as it effectively blocks migration).
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  target/i386/cpu.h          |  3 +++
>  target/i386/hyperv-proto.h |  9 ++++++++-
>  target/i386/kvm.c          | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index faf39ec1ce..502b535be2 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1152,6 +1152,9 @@ typedef struct CPUX86State {
>      uint64_t msr_hv_synic_sint[HV_SINT_COUNT];
>      uint64_t msr_hv_stimer_config[HV_STIMER_COUNT];
>      uint64_t msr_hv_stimer_count[HV_STIMER_COUNT];
> +    uint64_t msr_hv_reenlightenment_control;
> +    uint64_t msr_hv_tsc_emulation_control;
> +    uint64_t msr_hv_tsc_emulation_status;
>  
>      /* exception/interrupt handling */
>      int error_code;
> diff --git a/target/i386/hyperv-proto.h b/target/i386/hyperv-proto.h
> index cb4d7f2b7a..93352ebd2a 100644
> --- a/target/i386/hyperv-proto.h
> +++ b/target/i386/hyperv-proto.h
> @@ -35,7 +35,7 @@
>  #define HV_RESET_AVAILABLE           (1u << 7)
>  #define HV_REFERENCE_TSC_AVAILABLE   (1u << 9)
>  #define HV_ACCESS_FREQUENCY_MSRS     (1u << 11)
> -
> +#define HV_ACCESS_REENLIGHTENMENTS_CONTROL  (1u << 13)
>  
>  /*
>   * HV_CPUID_FEATURES.EDX bits
> @@ -129,6 +129,13 @@
>  #define HV_X64_MSR_CRASH_CTL                    0x40000105
>  #define HV_CRASH_CTL_NOTIFY                     (1ull << 63)
>  
> +/*
> + * Reenlightenment notification MSRs
> + */
> +#define HV_X64_MSR_REENLIGHTENMENT_CONTROL      0x40000106
> +#define HV_X64_MSR_TSC_EMULATION_CONTROL        0x40000107
> +#define HV_X64_MSR_TSC_EMULATION_STATUS         0x40000108
> +
>  /*
>   * Hypercall status code
>   */
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index ad4b159b28..21e06deaf1 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -90,6 +90,7 @@ static bool has_msr_hv_runtime;
>  static bool has_msr_hv_synic;
>  static bool has_msr_hv_stimer;
>  static bool has_msr_hv_frequencies;
> +static bool has_msr_hv_reenlightenment;
>  static bool has_msr_xss;
>  static bool has_msr_spec_ctrl;
>  
> @@ -649,6 +650,11 @@ static int hyperv_handle_properties(CPUState *cs)
>              env->features[FEAT_HYPERV_EAX] |= HV_ACCESS_FREQUENCY_MSRS;
>              env->features[FEAT_HYPERV_EDX] |= HV_FREQUENCY_MSRS_AVAILABLE;
>          }
> +
> +        if (has_msr_hv_reenlightenment) {
> +            env->features[FEAT_HYPERV_EAX] |=
> +                HV_ACCESS_REENLIGHTENMENTS_CONTROL;
> +        }
>      }
>      if (cpu->hyperv_crash && has_msr_hv_crash) {
>          env->features[FEAT_HYPERV_EDX] |= HV_GUEST_CRASH_MSR_AVAILABLE;
> @@ -1154,6 +1160,9 @@ static int kvm_get_supported_msrs(KVMState *s)
>                  case HV_X64_MSR_TSC_FREQUENCY:
>                      has_msr_hv_frequencies = true;
>                      break;
> +                case HV_X64_MSR_REENLIGHTENMENT_CONTROL:
> +                    has_msr_hv_reenlightenment = true;
> +                    break;
>                  case MSR_IA32_SPEC_CTRL:
>                      has_msr_spec_ctrl = true;
>                      break;
> @@ -1713,6 +1722,15 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>              if (cpu->hyperv_time) {
>                  kvm_msr_entry_add(cpu, HV_X64_MSR_REFERENCE_TSC,
>                                    env->msr_hv_tsc);
> +
> +                if (has_msr_hv_reenlightenment) {
> +                    kvm_msr_entry_add(cpu, HV_X64_MSR_REENLIGHTENMENT_CONTROL,
> +                                      env->msr_hv_reenlightenment_control);
> +                    kvm_msr_entry_add(cpu, HV_X64_MSR_TSC_EMULATION_CONTROL,
> +                                      env->msr_hv_tsc_emulation_control);
> +                    kvm_msr_entry_add(cpu, HV_X64_MSR_TSC_EMULATION_STATUS,
> +                                      env->msr_hv_tsc_emulation_status);
> +                }
>              }
>          }
>          if (cpu->hyperv_vapic) {
> @@ -2053,6 +2071,12 @@ static int kvm_get_msrs(X86CPU *cpu)
>      }
>      if (cpu->hyperv_time) {
>          kvm_msr_entry_add(cpu, HV_X64_MSR_REFERENCE_TSC, 0);
> +
> +        if (has_msr_hv_reenlightenment) {
> +            kvm_msr_entry_add(cpu, HV_X64_MSR_REENLIGHTENMENT_CONTROL, 0);
> +            kvm_msr_entry_add(cpu, HV_X64_MSR_TSC_EMULATION_CONTROL, 0);
> +            kvm_msr_entry_add(cpu, HV_X64_MSR_TSC_EMULATION_STATUS, 0);
> +        }
>      }
>      if (has_msr_hv_crash) {
>          int j;
> @@ -2294,6 +2318,15 @@ static int kvm_get_msrs(X86CPU *cpu)
>              env->msr_hv_stimer_count[(index - HV_X64_MSR_STIMER0_COUNT)/2] =
>                                  msrs[i].data;
>              break;
> +        case HV_X64_MSR_REENLIGHTENMENT_CONTROL:
> +            env->msr_hv_reenlightenment_control = msrs[i].data;
> +            break;
> +        case HV_X64_MSR_TSC_EMULATION_CONTROL:
> +            env->msr_hv_tsc_emulation_control = msrs[i].data;
> +            break;
> +        case HV_X64_MSR_TSC_EMULATION_STATUS:
> +            env->msr_hv_tsc_emulation_status = msrs[i].data;
> +            break;
>          case MSR_MTRRdefType:
>              env->mtrr_deftype = msrs[i].data;
>              break;
> 

Doesn't this also need a new subsection in target/i386/machine.c?

Paolo
