Received: from eggs.gnu.org ([2001:4830:134:3::10]:38074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ef9S7-0005UV-5x
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 14:14:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ef9S2-0005xC-9y
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 14:14:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ef9S1-0005wS-Vd
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 14:14:14 -0500
Date: Fri, 26 Jan 2018 17:14:10 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180126191410.GJ25150@localhost.localdomain>
References: <1516904751-10248-1-git-send-email-luwei.kang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516904751-10248-1-git-send-email-luwei.kang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] i386: Add Intel Processor Trace
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com, rth@twiddle.net, mtosatti@redhat.com, Chao Peng <chao.p.peng@linux.intel.com>

On Fri, Jan 26, 2018 at 02:25:50AM +0800, Luwei Kang wrote:
> From: Chao Peng <chao.p.peng@linux.intel.com>
> 
> Expose Intel Processor Trace feature to guest.
> 
> In order to make this feature migration-safe, new feature word
> information "FEAT_INTEL_PT_EBX" and "FEAT_INTEL_PT_ECX" be added.
> Some constant value initialized in CPUID[0x14].0x01 to guarantee
> get same result in diffrent hardware when this feature is enabled.
> 
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> ---
> v1->v2:
>  - In order to make this feature migration-safe, new feature word
>    information "FEAT_INTEL_PT_EBX" and "FEAT_INTEL_PT_ECX" be added.
>    Some constant value initialized in CPUID[0x14].0x01 to guarantee
>    get same result in diffrent hardware when this feature is enabled.
> 
> ---
>  target/i386/cpu.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  target/i386/cpu.h |  6 +++++
>  target/i386/kvm.c | 23 +++++++++++++++++++
>  3 files changed, 95 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index a49d222..ee8c6e6 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -172,7 +172,11 @@
>  #define L2_ITLB_4K_ASSOC       4
>  #define L2_ITLB_4K_ENTRIES   512
>  
> -
> +/* CPUID Leaf 0x14 constants: */
> +#define INTLE_PT_ADDR_RANGES_NUM 2
> +#define INTEL_PT_MTC_BITMAP      (0x0249 << 16) /* Support ART(0,3,6,9) */
> +#define INTEL_PT_CYCLE_BITMAP    0x3fff         /* Support 0,2^(0~12) */
> +#define INTEL_PT_PSB_BITMAP      (0x003f << 16) /* Support 2K,4K,8K,16K,32K,64K */
>  
>  static void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
>                                       uint32_t vendor2, uint32_t vendor3)
> @@ -427,7 +431,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>              NULL, NULL, "mpx", NULL,
>              "avx512f", "avx512dq", "rdseed", "adx",
>              "smap", "avx512ifma", "pcommit", "clflushopt",
> -            "clwb", NULL, "avx512pf", "avx512er",
> +            "clwb", "intel-pt", "avx512pf", "avx512er",
>              "avx512cd", "sha-ni", "avx512bw", "avx512vl",
>          },
>          .cpuid_eax = 7,
> @@ -545,6 +549,38 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>          .cpuid_reg = R_EDX,
>          .tcg_features = ~0U,
>      },
> +    [FEAT_INTEL_PT_EBX] = {
> +        .feat_names = {
> +            "cr3-filter", "psb-cycle", "filtering", "mtc-cofi",
> +            "ptwrite", "power-evt", NULL, NULL,

Note that this will make all those bits configurable on the
command-line.  You don't really need to do this in the first
version, if you don't really want to.

Also, if we want to make this configurable, we will need to
choose carefully the property names, because changing them later
would be more difficult.

Note that the feature names live in a single QOM property
namespace, so "filtering", "any-entries" and "transport" are
probably too generic.  Maybe we could prefix all names here with
"intel-pt-" or "pt-"?

If you don't want to make all bits configurable on the first
version, you can fill the CPUID[14h] bits with constant default
values just like you did with the INTEL_PT_* constants below.


> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +        },
> +        .cpuid_eax = 0x14,
> +        .cpuid_needs_ecx = true, .cpuid_ecx = 0,
> +        .cpuid_reg = R_EBX,
> +        .tcg_features = ~0U,

TCG doesn't implement this feature, so ~0U doesn't look right.


> +    },
> +    [FEAT_INTEL_PT_ECX] = {
> +        .feat_names = {
> +            "topa-output", "any-entries", "single-range", "transport",
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +        },
> +        .cpuid_eax = 0x14,
> +        .cpuid_needs_ecx = true, .cpuid_ecx = 0,
> +        .cpuid_reg = R_ECX,
> +        .tcg_features = ~0U,

Same as above.

> +    },
>  };
>  
>  typedef struct X86RegisterInfo32 {
> @@ -3452,6 +3488,34 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          }
>          break;
>      }
> +    case 0x14: {
> +	/* Intel Processor Trace Enumeration */
> +        *eax = 0;
> +        *ebx = 0;
> +        *ecx = 0;
> +        *edx = 0;
> +        if (!(env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) ||
> +             !kvm_enabled()) {
> +            break;
> +        }
> +
> +        if (count == 0) {
> +            *eax = 1;
> +            *ebx = env->features[FEAT_INTEL_PT_EBX];
> +            *ecx = env->features[FEAT_INTEL_PT_ECX];
> +        } else if (count == 1) {
> +            *eax = INTLE_PT_ADDR_RANGES_NUM;
> +            if (env->features[FEAT_INTEL_PT_EBX] &
> +                    CPUID_INTEL_PT_EBX_MTC_COFI) {
> +                *eax |= INTEL_PT_MTC_BITMAP;
> +            }
> +            if (env->features[FEAT_INTEL_PT_EBX] &
> +                    CPUID_INTEL_PT_EBX_PSB_CYCLE) {
> +                *ebx = INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP;
> +            }

We still need to validate the bitmaps and number of ranges
against the host capabilities (reported on GET_SUPPORTED_CPUID),
don't we?

If you are going to set CPUID bits that are not already present
on env->features[], you will want x86_cpu_filter_features() to
manually validate the constants against
x86_cpu_get_supported_feature_word(), to ensure we won't try to
enable unsupported bits.

(If doing that, we need to make sure CPUID_7_0_EBX_INTEL_PT will
be set on xc->filtered_features[FEAT_7_0_EBX] if something is
unsupported, to tell the calling code that intel-pt can't be
enabled on the current host)

In the future we could extend FeatureWordInfo to make it easier
to handle counter/bitmap fields like those, then we won't need
special cases inside x86_cpu_filter_features().


> +        }
> +        break;
> +    }
>      case 0x40000000:
>          /*
>           * CPUID code in kvm_arch_init_vcpu() ignores stuff
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 30cc562..53908ff 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -483,6 +483,8 @@ typedef enum FeatureWord {
>      FEAT_6_EAX,         /* CPUID[6].EAX */
>      FEAT_XSAVE_COMP_LO, /* CPUID[EAX=0xd,ECX=0].EAX */
>      FEAT_XSAVE_COMP_HI, /* CPUID[EAX=0xd,ECX=0].EDX */
> +    FEAT_INTEL_PT_EBX,  /* CPUID[EAX=0x14,ECX=0].EBX */
> +    FEAT_INTEL_PT_ECX,  /* CPUID[EAX=0x14,ECX=0].ECX */
>      FEATURE_WORDS,
>  } FeatureWord;
>  
> @@ -644,6 +646,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>  #define CPUID_7_0_EBX_PCOMMIT  (1U << 22) /* Persistent Commit */
>  #define CPUID_7_0_EBX_CLFLUSHOPT (1U << 23) /* Flush a Cache Line Optimized */
>  #define CPUID_7_0_EBX_CLWB     (1U << 24) /* Cache Line Write Back */
> +#define CPUID_7_0_EBX_INTEL_PT (1U << 25) /* Intel Processor Trace */
>  #define CPUID_7_0_EBX_AVX512PF (1U << 26) /* AVX-512 Prefetch */
>  #define CPUID_7_0_EBX_AVX512ER (1U << 27) /* AVX-512 Exponential and Reciprocal */
>  #define CPUID_7_0_EBX_AVX512CD (1U << 28) /* AVX-512 Conflict Detection */
> @@ -677,6 +680,9 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>  #define CPUID_XSAVE_XGETBV1    (1U << 2)
>  #define CPUID_XSAVE_XSAVES     (1U << 3)
>  
> +#define CPUID_INTEL_PT_EBX_PSB_CYCLE  (1U << 1) /* Support configurable PSB and  Cycle-Accurate Mode */
> +#define CPUID_INTEL_PT_EBX_MTC_COFI   (1U << 3) /* Support MTC timing and suppression of COFI-based packets */
> +
>  #define CPUID_6_EAX_ARAT       (1U << 2)
>  
>  /* CPUID[0x80000007].EDX flags: */
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index ad4b159..f9f4cd1 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -865,6 +865,29 @@ int kvm_arch_init_vcpu(CPUState *cs)
>                  c = &cpuid_data.entries[cpuid_i++];
>              }
>              break;
> +        case 0x14: {
> +            uint32_t times;
> +
> +            c->function = i;
> +            c->index = 0;
> +            c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> +            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
> +            times = c->eax;
> +
> +            for (j = 1; j <= times; ++j) {
> +                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
> +                    fprintf(stderr, "cpuid_data is full, no space for "
> +                                "cpuid(eax:0x14,ecx:0x%x)\n", j);
> +                    abort();
> +                }
> +                c = &cpuid_data.entries[cpuid_i++];
> +                c->function = i;
> +                c->index = j;
> +                c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
> +                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
> +            }
> +            break;
> +        }
>          default:
>              c->function = i;
>              c->flags = 0;
> -- 
> 1.8.3.1
> 

-- 
Eduardo
