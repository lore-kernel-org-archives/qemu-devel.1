Received: from eggs.gnu.org ([2001:4830:134:3::10]:40281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ega38-0000GY-GQ
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:50:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ega33-0008HR-8g
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:50:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ega32-0008FJ-Hj
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:50:21 -0500
Date: Tue, 30 Jan 2018 17:49:58 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180130174957.GD2536@work-vm>
References: <20180129174132.108925-1-brijesh.singh@amd.com>
	<20180129174132.108925-6-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180129174132.108925-6-brijesh.singh@amd.com>
Subject: Re: [Qemu-devel] [PATCH v6 05/23] target/i386: add memory
 encryption feature cpuid support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Richard Henderson <rth@twiddle.net>

* Brijesh Singh (brijesh.singh@amd.com) wrote:
> AMD EPYC processors support memory encryption feature. The feature
> is reported through CPUID 8000_001F[EAX].
> 
> Fn8000_001F [EAX]:
>  Bit 0   Secure Memory Encryption (SME) supported
>  Bit 1   Secure Encrypted Virtualization (SEV) supported
>  Bit 2   Page flush MSR supported
>  Bit 3   Ecrypted State (SEV-ES) support
> 
> when memory encryption feature is reported, CPUID 8000_001F[EBX] should
> provide additional information regarding the feature (such as which page
> table bit is used to mark pages as encrypted etc). The information in EBX
> and ECX may vary from one family to another hence we use the host cpuid
> to populate the EBX information.

That's going to make it interesting for migration.  If the guest needs
to know that C-bit position then you presumably can't migrate between
those two host types, but we wouldn't have anything that currently
stops us.
We already have similar problems with variations in physical address
size but normally get away with that, especially on smaller VMs.

Dave


> The details for memory encryption CPUID is available in AMD APM
> (http://support.amd.com/TechDocs/24593.pdf) Section 15.34.1

> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  target/i386/cpu.c | 36 ++++++++++++++++++++++++++++++++++++
>  target/i386/cpu.h |  6 ++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index a49d2221adc9..4147eb6e18a9 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -234,6 +234,7 @@ static void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
>  #define TCG_EXT4_FEATURES 0
>  #define TCG_SVM_FEATURES 0
>  #define TCG_KVM_FEATURES 0
> +#define TCG_MEM_ENCRYPT_FEATURES 0
>  #define TCG_7_0_EBX_FEATURES (CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_SMAP | \
>            CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ADX | \
>            CPUID_7_0_EBX_PCOMMIT | CPUID_7_0_EBX_CLFLUSHOPT |            \
> @@ -545,6 +546,20 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>          .cpuid_reg = R_EDX,
>          .tcg_features = ~0U,
>      },
> +    [FEAT_MEM_ENCRYPT] = {
> +        .feat_names = {
> +            "sme", "sev", "page-flush-msr", "sev-es",
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +        },
> +        .cpuid_eax = 0x8000001F, .cpuid_reg = R_EAX,
> +        .tcg_features = TCG_MEM_ENCRYPT_FEATURES,
> +    }
>  };
>  
>  typedef struct X86RegisterInfo32 {
> @@ -1965,6 +1980,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              CPUID_XSAVE_XGETBV1,
>          .features[FEAT_6_EAX] =
>              CPUID_6_EAX_ARAT,
> +        /* Missing: SEV_ES */
> +        .features[FEAT_MEM_ENCRYPT] =
> +            CPUID_8000_001F_EAX_SME | CPUID_8000_001F_EAX_SEV,
>          .xlevel = 0x8000000A,
>          .model_id = "AMD EPYC Processor",
>      },
> @@ -3589,6 +3607,19 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>              *edx = 0;
>          }
>          break;
> +    case 0x8000001F:
> +        if (env->features[FEAT_MEM_ENCRYPT] & CPUID_8000_001F_EAX_SEV) {
> +            *eax = env->features[FEAT_MEM_ENCRYPT];
> +            host_cpuid(0x8000001F, 0, NULL, ebx, NULL, NULL);
> +            *ecx = 0;
> +            *edx = 0;
> +        } else {
> +            *eax = 0;
> +            *ebx = 0;
> +            *ecx = 0;
> +            *edx = 0;
> +        }
> +        break;
>      case 0xC0000000:
>          *eax = env->cpuid_xlevel2;
>          *ebx = 0;
> @@ -4036,10 +4067,15 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>          x86_cpu_adjust_feat_level(cpu, FEAT_C000_0001_EDX);
>          x86_cpu_adjust_feat_level(cpu, FEAT_SVM);
>          x86_cpu_adjust_feat_level(cpu, FEAT_XSAVE);
> +        x86_cpu_adjust_feat_level(cpu, FEAT_MEM_ENCRYPT);
>          /* SVM requires CPUID[0x8000000A] */
>          if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
>              x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000000A);
>          }
> +        /* SEV requires CPUID[0x8000001F] */
> +        if ((env->features[FEAT_MEM_ENCRYPT] & CPUID_8000_001F_EAX_SEV)) {
> +            x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000001F);
> +        }
>      }
>  
>      /* Set cpuid_*level* based on cpuid_min_*level, if not explicitly set */
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index f91e37d25dea..f7a0ab20fdd1 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -483,6 +483,7 @@ typedef enum FeatureWord {
>      FEAT_6_EAX,         /* CPUID[6].EAX */
>      FEAT_XSAVE_COMP_LO, /* CPUID[EAX=0xd,ECX=0].EAX */
>      FEAT_XSAVE_COMP_HI, /* CPUID[EAX=0xd,ECX=0].EDX */
> +    FEAT_MEM_ENCRYPT,   /* CPUID[8000_001F].EAX */
>      FEATURE_WORDS,
>  } FeatureWord;
>  
> @@ -679,6 +680,11 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>  
>  #define CPUID_6_EAX_ARAT       (1U << 2)
>  
> +#define CPUID_8000_001F_EAX_SME             (1U << 0) /* SME */
> +#define CPUID_8000_001F_EAX_SEV             (1U << 1) /* SEV */
> +#define CPUID_8000_001F_EAX_PAGE_FLUSH_MSR  (1U << 2) /* Page flush MSR */
> +#define CPUID_8000_001F_EAX_SEV_ES          (1U << 3) /* SEV-ES */
> +
>  /* CPUID[0x80000007].EDX flags: */
>  #define CPUID_APM_INVTSC       (1U << 8)
>  
> -- 
> 2.9.5
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
