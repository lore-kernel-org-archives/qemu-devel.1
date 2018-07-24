Received: from eggs.gnu.org ([2001:4830:134:3::10]:44193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fhvVJ-0004Z6-Cv
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fhvVE-0005RS-Pc
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:29:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48110 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fhvVE-0005Qj-JD
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:29:16 -0400
Date: Tue, 24 Jul 2018 12:29:12 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180724112911.GA2314@work-vm>
References: <1519726932-13833-1-git-send-email-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519726932-13833-1-git-send-email-liran.alon@oracle.com>
Subject: Re: [Qemu-devel] [PATCH] KVM: x86: Add support for save/load
 MSR_SMI_COUNT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liran Alon <liran.alon@oracle.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, ehabkost@redhat.com, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, quintela@redhat.com

* Liran Alon (liran.alon@oracle.com) wrote:
> This MSR returns the number of #SMIs that occurred on
> CPU since boot.
> 
> KVM commit 52797bf9a875 ("KVM: x86: Add emulation of MSR_SMI_COUNT")
> introduced support for emulating this MSR.
> 
> This commit adds support for QEMU to save/load this
> MSR for migration purposes.
> 
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Note this breaks 2.12->2.11 migration if SMM is enabled
with a:

qemu-system-x86_64: error while loading state for instance 0x0 of device 'cpu'

Dave

> ---
>  target/i386/cpu.c     |  1 +
>  target/i386/cpu.h     |  3 +++
>  target/i386/kvm.c     | 13 +++++++++++++
>  target/i386/machine.c | 20 ++++++++++++++++++++
>  4 files changed, 37 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b5e431e769da..ba9ec6a6116b 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3645,6 +3645,7 @@ static void x86_cpu_reset(CPUState *s)
>      cpu_x86_update_cr0(env, 0x60000010);
>      env->a20_mask = ~0x0;
>      env->smbase = 0x30000;
> +    env->msr_smi_count = 0;
>  
>      env->idt.limit = 0xffff;
>      env->gdt.limit = 0xffff;
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index faf39ec1ce77..254e557bb8fa 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1,3 +1,4 @@
> +
>  /*
>   * i386 virtual CPU header
>   *
> @@ -359,6 +360,7 @@ typedef enum X86Seg {
>  #define MSR_P6_PERFCTR0                 0xc1
>  
>  #define MSR_IA32_SMBASE                 0x9e
> +#define MSR_SMI_COUNT                   0x34
>  #define MSR_MTRRcap                     0xfe
>  #define MSR_MTRRcap_VCNT                8
>  #define MSR_MTRRcap_FIXRANGE_SUPPORT    (1 << 8)
> @@ -1123,6 +1125,7 @@ typedef struct CPUX86State {
>  
>      uint64_t pat;
>      uint32_t smbase;
> +    uint64_t msr_smi_count;
>  
>      uint32_t pkru;
>  
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index ad4b159b28af..a53735f266c5 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -92,6 +92,7 @@ static bool has_msr_hv_stimer;
>  static bool has_msr_hv_frequencies;
>  static bool has_msr_xss;
>  static bool has_msr_spec_ctrl;
> +static bool has_msr_smi_count;
>  
>  static uint32_t has_architectural_pmu_version;
>  static uint32_t num_architectural_pmu_gp_counters;
> @@ -1124,6 +1125,9 @@ static int kvm_get_supported_msrs(KVMState *s)
>                  case MSR_IA32_SMBASE:
>                      has_msr_smbase = true;
>                      break;
> +                case MSR_SMI_COUNT:
> +                    has_msr_smi_count = true;
> +                    break;
>                  case MSR_IA32_MISC_ENABLE:
>                      has_msr_misc_enable = true;
>                      break;
> @@ -1633,6 +1637,9 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>      if (has_msr_smbase) {
>          kvm_msr_entry_add(cpu, MSR_IA32_SMBASE, env->smbase);
>      }
> +    if (has_msr_smi_count) {
> +        kvm_msr_entry_add(cpu, MSR_SMI_COUNT, env->msr_smi_count);
> +    }
>      if (has_msr_bndcfgs) {
>          kvm_msr_entry_add(cpu, MSR_IA32_BNDCFGS, env->msr_bndcfgs);
>      }
> @@ -1979,6 +1986,9 @@ static int kvm_get_msrs(X86CPU *cpu)
>      if (has_msr_smbase) {
>          kvm_msr_entry_add(cpu, MSR_IA32_SMBASE, 0);
>      }
> +    if (has_msr_smi_count) {
> +        kvm_msr_entry_add(cpu, MSR_SMI_COUNT, 0);
> +    }
>      if (has_msr_feature_control) {
>          kvm_msr_entry_add(cpu, MSR_IA32_FEATURE_CONTROL, 0);
>      }
> @@ -2205,6 +2215,9 @@ static int kvm_get_msrs(X86CPU *cpu)
>          case MSR_IA32_SMBASE:
>              env->smbase = msrs[i].data;
>              break;
> +        case MSR_SMI_COUNT:
> +            env->msr_smi_count = msrs[i].data;
> +            break;
>          case MSR_IA32_FEATURE_CONTROL:
>              env->msr_ia32_feature_control = msrs[i].data;
>              break;
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index 361c05aedfdc..9432496cbda8 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -395,6 +395,25 @@ static const VMStateDescription vmstate_msr_tsc_adjust = {
>      }
>  };
>  
> +static bool msr_smi_count_needed(void *opaque)
> +{
> +    X86CPU *cpu = opaque;
> +    CPUX86State *env = &cpu->env;
> +
> +    return env->msr_smi_count != 0;
> +}
> +
> +static const VMStateDescription vmstate_msr_smi_count = {
> +    .name = "cpu/msr_smi_count",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = msr_smi_count_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT64(env.msr_smi_count, X86CPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static bool tscdeadline_needed(void *opaque)
>  {
>      X86CPU *cpu = opaque;
> @@ -952,6 +971,7 @@ VMStateDescription vmstate_x86_cpu = {
>          &vmstate_avx512,
>          &vmstate_xss,
>          &vmstate_tsc_khz,
> +        &vmstate_msr_smi_count,
>  #ifdef TARGET_X86_64
>          &vmstate_pkru,
>  #endif
> -- 
> 1.9.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
