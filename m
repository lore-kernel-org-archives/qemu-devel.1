Received: from eggs.gnu.org ([2001:4830:134:3::10]:43323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqV9h-0002XU-MR
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 23:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqV9b-0001nd-D1
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 23:10:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fqV9b-0001lO-4q
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 23:10:23 -0400
Date: Fri, 17 Aug 2018 00:10:19 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180817031019.GZ15372@localhost.localdomain>
References: <1533909989-56115-1-git-send-email-robert.hu@linux.intel.com>
	<1533909989-56115-2-git-send-email-robert.hu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533909989-56115-2-git-send-email-robert.hu@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/3] x86: Data structure changes to
 support MSR based features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Robert Hoo <robert.hu@linux.intel.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, thomas.lendacky@amd.com, robert.hu@intel.com, qemu-devel@nongnu.org, jingqi.liu@intel.com

Hi,

Thanks for the patch and sorry for taking so long to review.
Comments below:

On Fri, Aug 10, 2018 at 10:06:27PM +0800, Robert Hoo wrote:
> Define FeatureWordType.
> Expand FeatureWordInfo to support both CPUID type feature word as well as
> MSR type's.
> Change feature_word_info[] accordingly.
> 
> Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> ---
>  target/i386/cpu.c | 133 ++++++++++++++++++++++++++++++++++++++----------------
>  target/i386/cpu.h |   5 ++
>  2 files changed, 99 insertions(+), 39 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index ba7abe5..f7c70d9 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -770,17 +770,36 @@ static void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
>            /* missing:
>            CPUID_XSAVE_XSAVEC, CPUID_XSAVE_XSAVES */
>  
> +typedef enum FeatureWordType {
> +   CPUID_FEATURE_WORD,
> +   MSR_FEATURE_WORD,
> +} FeatureWordType;
> +
>  typedef struct FeatureWordInfo {
> -    /* feature flags names are taken from "Intel Processor Identification and
> +    FeatureWordType type;
> +   /* feature flags names are taken from "Intel Processor Identification and
>       * the CPUID Instruction" and AMD's "CPUID Specification".
>       * In cases of disagreement between feature naming conventions,
>       * aliases may be added.
>       */
>      const char *feat_names[32];
> -    uint32_t cpuid_eax;   /* Input EAX for CPUID */
> -    bool cpuid_needs_ecx; /* CPUID instruction uses ECX as input */
> -    uint32_t cpuid_ecx;   /* Input ECX value for CPUID */
> -    int cpuid_reg;        /* output register (R_* constant) */
> +    union {
> +        /* If type==CPUID_FEATURE_WORD */
> +        struct {
> +            uint32_t eax;   /* Input EAX for CPUID */
> +            bool needs_ecx; /* CPUID instruction uses ECX as input */
> +            uint32_t ecx;   /* Input ECX value for CPUID */
> +            int reg;        /* output register (R_* constant) */
> +        } cpuid;
> +        /* If type==MSR_FEATURE_WORD */
> +        struct {
> +            uint32_t index;
> +            struct {   /*CPUID that enumerate this MSR*/
> +                FeatureWord cpuid_class;
> +                uint32_t    cpuid_flag;
> +            } cpuid_dep;
> +        } msr;
> +    };
>      uint32_t tcg_features; /* Feature flags supported by TCG */
>      uint32_t unmigratable_flags; /* Feature flags known to be unmigratable */
>      uint32_t migratable_flags; /* Feature flags known to be migratable */

The data structure change looks good, but you are breaking the
build if you touch them without updating the existing code.  If
you break the build in your series, you break git-bisect.


[...]
> +    /*Below are MSR exposed features*/
> +    [FEATURE_WORDS_ARCH_CAPABILITIES] = {
> +        .type = MSR_FEATURE_WORD,
> +        .feat_names = {
> +            "rdctl-no", "ibrs-all", "rsba", NULL,
> +            "ssb-no", NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +        },
> +        .msr = { .index = MSR_IA32_ARCH_CAPABILITIES,
> +                .cpuid_dep = { FEAT_7_0_EDX,
> +                    CPUID_7_0_EDX_ARCH_CAPABILITIES }
> +                },
> +    },

I suggest moving this hunk to a separate patch: first we refactor
the existing code without changing behavior or adding new
features, then we add the new features.

>  };
>  
>  typedef struct X86RegisterInfo32 {
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index cddf9d9..9e8879e 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -502,9 +502,14 @@ typedef enum FeatureWord {
>      FEAT_6_EAX,         /* CPUID[6].EAX */
>      FEAT_XSAVE_COMP_LO, /* CPUID[EAX=0xd,ECX=0].EAX */
>      FEAT_XSAVE_COMP_HI, /* CPUID[EAX=0xd,ECX=0].EDX */
> +    FEATURE_WORDS_NUM_CPUID,
> +    FEATURE_WORDS_FIRST_MSR = FEATURE_WORDS_NUM_CPUID,
> +    FEATURE_WORDS_ARCH_CAPABILITIES = FEATURE_WORDS_FIRST_MSR,
>      FEATURE_WORDS,
>  } FeatureWord;
>  
> +#define FEATURE_WORDS_NUM_MSRS (FEATURE_WORDS - FEATURE_WORDS_FIRST_MSR)
> +
>  typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>  
>  /* cpuid_features bits */
> -- 
> 1.8.3.1
> 
> 

-- 
Eduardo
