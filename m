Received: from eggs.gnu.org ([2001:4830:134:3::10]:50220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFGDZ-0002Ya-Gh
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 06:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFGDW-0006hK-CS
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 06:16:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gFGDW-0006gl-3s
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 06:16:46 -0400
Date: Wed, 24 Oct 2018 07:16:43 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181024101643.GE4096@habkost.net>
References: <1539578845-37944-1-git-send-email-robert.hu@linux.intel.com>
	<1539578845-37944-3-git-send-email-robert.hu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539578845-37944-3-git-send-email-robert.hu@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/3] x86: Data structure changes to
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
Cc: pbonzini@redhat.com, rth@twiddle.net, thomas.lendacky@amd.com, robert.hu@intel.com, qemu-devel@nongnu.org

On Mon, Oct 15, 2018 at 12:47:24PM +0800, Robert Hoo wrote:
> Add FeatureWordType indicator in struct FeatureWordInfo.
> Change feature_word_info[] accordingly.
> Change existing functions that refer to feature_word_info[] accordingly.
> 
> Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> ---
>  target/i386/cpu.c | 188 +++++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 136 insertions(+), 52 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index c88876d..d191b9c 100644
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
> +    FeatureWordType type;
>      /* feature flags names are taken from "Intel Processor Identification and
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

Aren't you going to use this field anywhere?  Probably we want to
prevent the VM from starting if a bit is set in the feature world
but the cpuid_dep bit is not set.

e.g.:
  qemu-system-x86_64 -cpu Skylake-Client,-arch-capabilities,+rsba
probably should fail to start.

> +        } msr;
> +    };
[...]

-- 
Eduardo
