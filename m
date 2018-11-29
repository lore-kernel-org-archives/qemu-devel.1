Received: from eggs.gnu.org ([2001:4830:134:3::10]:48588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSJQp-00019C-4V
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:20:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSJQl-0006Tu-3y
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:20:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gSJQj-0006SD-7D
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:20:21 -0500
References: <20181126135958.20956-1-vkuznets@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c30c335e-ca21-1179-670b-d4506ce14571@redhat.com>
Date: Thu, 29 Nov 2018 11:20:14 +0100
MIME-Version: 1.0
In-Reply-To: <20181126135958.20956-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i386/kvm: expose
 HV_CPUID_ENLIGHTMENT_INFO.EAX and HV_CPUID_NESTED_FEATURES.EAX as feature
 words
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

On 26/11/18 14:59, Vitaly Kuznetsov wrote:
> It was found that QMP users of QEMU (e.g. libvirt) may need
> HV_CPUID_ENLIGHTMENT_INFO.EAX/HV_CPUID_NESTED_FEATURES.EAX information. In
> particular, 'hv_tlbflush' and 'hv_evmcs' enlightenments are only exposed in
> HV_CPUID_ENLIGHTMENT_INFO.EAX.
> 
> HV_CPUID_NESTED_FEATURES.EAX is exposed for two reasons: convenience
> (we don't need to export it from hyperv_handle_properties() and as
> future-proof for Enlightened MSR-Bitmap, PV EPT invalidation and
> direct virtual flush features.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Can you add a comment to feature_word_info, explaining why the
feat_names are not set?

Thanks,

Paolo

> ---
>  target/i386/cpu.c | 30 +++++++++++++++++
>  target/i386/cpu.h |  2 ++
>  target/i386/kvm.c | 85 +++++++++++++++++++++++++----------------------
>  3 files changed, 77 insertions(+), 40 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index f81d35e1f9..8306670e09 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -980,6 +980,36 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>          },
>          .cpuid = { .eax = 0x40000003, .reg = R_EDX, },
>      },
> +    [FEAT_HV_RECOMM_EAX] = {
> +        .type = CPUID_FEATURE_WORD,
> +        .feat_names = {
> +            NULL /* hv_recommend_pv_as_switch */,
> +            NULL /* hv_recommend_pv_tlbflush_local */,
> +            NULL /* hv_recommend_pv_tlbflush_remote */,
> +            NULL /* hv_recommend_msr_apic_access */,
> +            NULL /* hv_recommend_msr_reset */,
> +            NULL /* hv_recommend_relaxed_timing */,
> +            NULL /* hv_recommend_dma_remapping */,
> +            NULL /* hv_recommend_int_remapping */,
> +            NULL /* hv_recommend_x2apic_msrs */,
> +            NULL /* hv_recommend_autoeoi_deprecation */,
> +            NULL /* hv_recommend_pv_ipi */,
> +            NULL /* hv_recommend_ex_hypercalls */,
> +            NULL /* hv_hypervisor_is_nested */,
> +            NULL /* hv_recommend_int_mbec */,
> +            NULL /* hv_recommend_evmcs */,
> +            NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +        },
> +        .cpuid = { .eax = 0x40000004, .reg = R_EAX, },
> +    },
> +    [FEAT_HV_NESTED_EAX] = {
> +        .type = CPUID_FEATURE_WORD,
> +        .cpuid = { .eax = 0x4000000A, .reg = R_EAX, },
> +    },
>      [FEAT_SVM] = {
>          .type = CPUID_FEATURE_WORD,
>          .feat_names = {
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 9c52d0cbeb..dd881510ac 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -497,6 +497,8 @@ typedef enum FeatureWord {
>      FEAT_HYPERV_EAX,    /* CPUID[4000_0003].EAX */
>      FEAT_HYPERV_EBX,    /* CPUID[4000_0003].EBX */
>      FEAT_HYPERV_EDX,    /* CPUID[4000_0003].EDX */
> +    FEAT_HV_RECOMM_EAX, /* CPUID[4000_0004].EAX */
> +    FEAT_HV_NESTED_EAX, /* CPUID[4000_000A].EAX */
>      FEAT_SVM,           /* CPUID[8000_000A].EDX */
>      FEAT_XSAVE,         /* CPUID[EAX=0xd,ECX=1].EAX */
>      FEAT_6_EAX,         /* CPUID[6].EAX */
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index f524e7d929..b4d2b40a40 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -797,6 +797,48 @@ static int hyperv_handle_properties(CPUState *cs)
>          }
>          env->features[FEAT_HYPERV_EAX] |= HV_SYNTIMERS_AVAILABLE;
>      }
> +    if (cpu->hyperv_relaxed_timing) {
> +        env->features[FEAT_HV_RECOMM_EAX] |= HV_RELAXED_TIMING_RECOMMENDED;
> +    }
> +    if (cpu->hyperv_vapic) {
> +        env->features[FEAT_HV_RECOMM_EAX] |= HV_APIC_ACCESS_RECOMMENDED;
> +    }
> +    if (cpu->hyperv_tlbflush) {
> +        if (kvm_check_extension(cs->kvm_state,
> +                                KVM_CAP_HYPERV_TLBFLUSH) <= 0) {
> +            fprintf(stderr, "Hyper-V TLB flush support "
> +                    "(requested by 'hv-tlbflush' cpu flag) "
> +                    " is not supported by kernel\n");
> +            return -ENOSYS;
> +        }
> +        env->features[FEAT_HV_RECOMM_EAX] |= HV_REMOTE_TLB_FLUSH_RECOMMENDED;
> +        env->features[FEAT_HV_RECOMM_EAX] |= HV_EX_PROCESSOR_MASKS_RECOMMENDED;
> +    }
> +    if (cpu->hyperv_ipi) {
> +        if (kvm_check_extension(cs->kvm_state,
> +                                KVM_CAP_HYPERV_SEND_IPI) <= 0) {
> +            fprintf(stderr, "Hyper-V IPI send support "
> +                    "(requested by 'hv-ipi' cpu flag) "
> +                    " is not supported by kernel\n");
> +            return -ENOSYS;
> +        }
> +        env->features[FEAT_HV_RECOMM_EAX] |= HV_CLUSTER_IPI_RECOMMENDED;
> +        env->features[FEAT_HV_RECOMM_EAX] |= HV_EX_PROCESSOR_MASKS_RECOMMENDED;
> +    }
> +    if (cpu->hyperv_evmcs) {
> +        uint16_t evmcs_version;
> +
> +        if (kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_ENLIGHTENED_VMCS, 0,
> +                                (uintptr_t)&evmcs_version)) {
> +            fprintf(stderr, "Hyper-V Enlightened VMCS "
> +                    "(requested by 'hv-evmcs' cpu flag) "
> +                    "is not supported by kernel\n");
> +            return -ENOSYS;
> +        }
> +        env->features[FEAT_HV_RECOMM_EAX] |= HV_ENLIGHTENED_VMCS_RECOMMENDED;
> +        env->features[FEAT_HV_NESTED_EAX] = evmcs_version;
> +    }
> +
>      return 0;
>  }
>  
> @@ -869,7 +911,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      uint32_t unused;
>      struct kvm_cpuid_entry2 *c;
>      uint32_t signature[3];
> -    uint16_t evmcs_version;
>      int kvm_base = KVM_CPUID_SIGNATURE;
>      int r;
>      Error *local_err = NULL;
> @@ -944,44 +985,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
>  
>          c = &cpuid_data.entries[cpuid_i++];
>          c->function = HV_CPUID_ENLIGHTMENT_INFO;
> -        if (cpu->hyperv_relaxed_timing) {
> -            c->eax |= HV_RELAXED_TIMING_RECOMMENDED;
> -        }
> -        if (cpu->hyperv_vapic) {
> -            c->eax |= HV_APIC_ACCESS_RECOMMENDED;
> -        }
> -        if (cpu->hyperv_tlbflush) {
> -            if (kvm_check_extension(cs->kvm_state,
> -                                    KVM_CAP_HYPERV_TLBFLUSH) <= 0) {
> -                fprintf(stderr, "Hyper-V TLB flush support "
> -                        "(requested by 'hv-tlbflush' cpu flag) "
> -                        " is not supported by kernel\n");
> -                return -ENOSYS;
> -            }
> -            c->eax |= HV_REMOTE_TLB_FLUSH_RECOMMENDED;
> -            c->eax |= HV_EX_PROCESSOR_MASKS_RECOMMENDED;
> -        }
> -        if (cpu->hyperv_ipi) {
> -            if (kvm_check_extension(cs->kvm_state,
> -                                    KVM_CAP_HYPERV_SEND_IPI) <= 0) {
> -                fprintf(stderr, "Hyper-V IPI send support "
> -                        "(requested by 'hv-ipi' cpu flag) "
> -                        " is not supported by kernel\n");
> -                return -ENOSYS;
> -            }
> -            c->eax |= HV_CLUSTER_IPI_RECOMMENDED;
> -            c->eax |= HV_EX_PROCESSOR_MASKS_RECOMMENDED;
> -        }
> -        if (cpu->hyperv_evmcs) {
> -            if (kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_ENLIGHTENED_VMCS, 0,
> -                                    (uintptr_t)&evmcs_version)) {
> -                fprintf(stderr, "Hyper-V Enlightened VMCS "
> -                        "(requested by 'hv-evmcs' cpu flag) "
> -                        "is not supported by kernel\n");
> -                return -ENOSYS;
> -            }
> -            c->eax |= HV_ENLIGHTENED_VMCS_RECOMMENDED;
> -        }
> +
> +        c->eax = env->features[FEAT_HV_RECOMM_EAX];
>          c->ebx = cpu->hyperv_spinlock_attempts;
>  
>          c = &cpuid_data.entries[cpuid_i++];
> @@ -1005,7 +1010,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>  
>              c = &cpuid_data.entries[cpuid_i++];
>              c->function = HV_CPUID_NESTED_FEATURES;
> -            c->eax = evmcs_version;
> +            c->eax = env->features[FEAT_HV_NESTED_EAX];
>          }
>      }
>  
> 
