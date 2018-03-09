Received: from eggs.gnu.org ([2001:4830:134:3::10]:32849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1euNPt-0007vf-1i
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:10:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1euNPo-0006Z4-68
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:10:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1euNPn-0006Yq-Tc
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:10:52 -0500
Date: Fri, 9 Mar 2018 16:10:48 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180309191048.GA28578@localhost.localdomain>
References: <1520182116-16485-1-git-send-email-luwei.kang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520182116-16485-1-git-send-email-luwei.kang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/2] i386: Add Intel Processor Trace
 feature support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luwei Kang <luwei.kang@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, mtosatti@redhat.com, Chao Peng <chao.p.peng@linux.intel.com>, pbonzini@redhat.com, rth@twiddle.net

On Mon, Mar 05, 2018 at 12:48:35AM +0800, Luwei Kang wrote:
> From: Chao Peng <chao.p.peng@linux.intel.com>
> 
> Expose Intel Processor Trace feature to guest.
> 
> To make Intel PT live migration safe and get same CPUID information
> with same CPU model on diffrent host. CPUID[14] is constant in this
> patch. Intel PT use EPT is first supported in IceLake, the CPUID[14]
> get on this machine as default value. Intel PT would be disabled
> if any machine don't support this minial feature list.
> 
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> ---
> From V3:
>  - fix some typo;
>  - add some comments and safty check.
> 
> ---
>  target/i386/cpu.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  target/i386/cpu.h |  1 +
>  target/i386/kvm.c | 23 ++++++++++++++++
>  3 files changed, 100 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b5e431e..24e1693 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -173,7 +173,32 @@
>  #define L2_ITLB_4K_ASSOC       4
>  #define L2_ITLB_4K_ENTRIES   512
>  
> -
> +/* CPUID Leaf 0x14 constants: */
> +#define INTEL_PT_MAX_SUBLEAF     0x1
> +/*
> + * bit[00]: IA32_RTIT_CTL.CR3 filter can be set to 1 and IA32_RTIT_CR3_MATCH
> + *          MSR can be accessed;
> + * bit[01]: Support Configurable PSB and Cycle-Accurate Mode;
> + * bit[02]: Support IP Filtering, TraceStop filtering, and preservation
> + *          of Intel PT MSRs across warm reset;
> + * bit[03]: Support MTC timing packet and suppression of COFI-based packets;
> + */
> +#define INTEL_PT_MINIMAL_EBX     0xf

Thanks!  I didn't expect a detailed description of each bit.  I
thought that just adding macros for each bit instead of
hardcoding 0xf would be enough.

But after reading the docs, I understand it could be difficult to
choose a macro name for something like "support of IP Filtering,
TraceStop filtering, and preservation of Intel PT MSRs across
warm reset", so this description looks like the best we can do.
:)


I only see a problem below:

> +/*
> + * bit[00]: Tracing can be enabled with IA32_RTIT_CTL.ToPA = 1 and
> + *          IA32_RTIT_OUTPUT_BASE and IA32_RTIT_OUTPUT_MASK_PTRS MSRs can be
> + *          accessed;
> + * bit[01]: ToPA tables can hold any number of output entries, up to the
> + *          maximum allowed by the MaskOrTableOffset field of
> + *          IA32_RTIT_OUTPUT_MASK_PTRS;
> + * bit[02]: Support Single-Range Output scheme;
> + */
> +#define INTEL_PT_MINIMAL_ECX     0x7
> +#define INTEL_PT_ADDR_RANGES_NUM 0x2 /* Number of configurable address ranges */
> +#define INTEL_PT_ADDR_RANGES_NUM_MASK 0x3
> +#define INTEL_PT_MTC_BITMAP      (0x0249 << 16) /* Support ART(0,3,6,9) */
> +#define INTEL_PT_CYCLE_BITMAP    0x1fff         /* Support 0,2^(0~11) */
> +#define INTEL_PT_PSB_BITMAP      (0x003f << 16) /* Support 2K,4K,8K,16K,32K,64K */
>  
>  static void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
>                                       uint32_t vendor2, uint32_t vendor3)
[...]
> @@ -4083,6 +4129,34 @@ static int x86_cpu_filter_features(X86CPU *cpu)
>          }
>      }
>  
> +    if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
> +        kvm_enabled()) {
> +        KVMState *s = CPU(cpu)->kvm_state;
> +        uint32_t eax_0 = kvm_arch_get_supported_cpuid(s, 0x14, 0, R_EAX);
> +        uint32_t ebx_0 = kvm_arch_get_supported_cpuid(s, 0x14, 0, R_EBX);
> +        uint32_t ecx_0 = kvm_arch_get_supported_cpuid(s, 0x14, 0, R_ECX);
> +        uint32_t eax_1 = kvm_arch_get_supported_cpuid(s, 0x14, 1, R_EAX);
> +        uint32_t ebx_1 = kvm_arch_get_supported_cpuid(s, 0x14, 1, R_EBX);
> +
> +        if (!eax_0 ||
> +           ((ebx_0 & INTEL_PT_MINIMAL_EBX) != INTEL_PT_MINIMAL_EBX) ||
> +           ((ecx_0 & INTEL_PT_MINIMAL_ECX) != INTEL_PT_MINIMAL_ECX) ||
> +           ((eax_1 & INTEL_PT_MTC_BITMAP) != INTEL_PT_MTC_BITMAP) ||
> +           ((eax_1 & INTEL_PT_ADDR_RANGES_NUM_MASK) <
> +                                           INTEL_PT_ADDR_RANGES_NUM) ||
> +           ((ebx_1 & (INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP)) !=
> +                (INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP))) {

I still don't see a check to ensure the host has bit 31 on ecx_0
set to 0, as I mentioned when reviewing v3.

The rest of the patch looks good.

> +            /*
> +             * Processor Trace capabilities aren't configurable, so if the
> +             * host can't emulate the capabilities we report on
> +             * cpu_x86_cpuid(), intel-pt can't be enabled on the current host.
> +             */
> +            env->features[FEAT_7_0_EBX] &= ~CPUID_7_0_EBX_INTEL_PT;
> +            cpu->filtered_features[FEAT_7_0_EBX] |= CPUID_7_0_EBX_INTEL_PT;
> +            rv = 1;
> +        }
> +    }
> +
>      return rv;
>  }
>  
[...]

-- 
Eduardo
