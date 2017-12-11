Received: from eggs.gnu.org ([2001:4830:134:3::10]:45763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eOQcW-0002ll-9E
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:08:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eOQcS-00060b-5x
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:07:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eOQcR-000608-TM
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:07:52 -0500
References: <20171211083340.12791-1-haozhong.zhang@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <19ba9bf2-cd6b-6194-1d74-5e9c59d6de2c@redhat.com>
Date: Mon, 11 Dec 2017 17:07:41 +0100
MIME-Version: 1.0
In-Reply-To: <20171211083340.12791-1-haozhong.zhang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/i386: add CPU model
 "Skylake-Server-clflushopt"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On 11/12/2017 09:33, Haozhong Zhang wrote:
> The only difference from the existing CPU model "Skylake-Server" is
> the add of CPUID_7_0_EBX_CLFLUSHOPT, which is missed in "Skylake-Server".
> 
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>

If all Skylake-Server CPUs have it, maybe we can remove it on old
machine types via compatibility properties, and not add a new model?

Thanks,

Paolo

> ---
>  target/i386/cpu.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 045d66191f..a4370e6393 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1391,6 +1391,55 @@ static X86CPUDefinition builtin_x86_defs[] = {
>          .xlevel = 0x80000008,
>          .model_id = "Intel Xeon Processor (Skylake)",
>      },
> +    {
> +        /* Add CLFLUSHOPT which is missed in CPU model "Skylake-Server". */
> +        .name = "Skylake-Server-clflushopt",
> +        .level = 0xd,
> +        .vendor = CPUID_VENDOR_INTEL,
> +        .family = 6,
> +        .model = 85,
> +        .stepping = 4,
> +        .features[FEAT_1_EDX] =
> +            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
> +            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
> +            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
> +            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
> +            CPUID_DE | CPUID_FP87,
> +        .features[FEAT_1_ECX] =
> +            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
> +            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
> +            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
> +            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
> +            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOVBE |
> +            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
> +        .features[FEAT_8000_0001_EDX] =
> +            CPUID_EXT2_LM | CPUID_EXT2_PDPE1GB | CPUID_EXT2_RDTSCP |
> +            CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
> +        .features[FEAT_8000_0001_ECX] =
> +            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM | CPUID_EXT3_3DNOWPREFETCH,
> +        .features[FEAT_7_0_EBX] =
> +            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
> +            CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
> +            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
> +            CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
> +            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_CLWB |
> +            CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
> +            CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
> +            CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT,
> +        /* Missing: XSAVES (not supported by some Linux versions,
> +         * including v4.1 to v4.12).
> +         * KVM doesn't yet expose any XSAVES state save component,
> +         * and the only one defined in Skylake (processor tracing)
> +         * probably will block migration anyway.
> +         */
> +        .features[FEAT_XSAVE] =
> +            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
> +            CPUID_XSAVE_XGETBV1,
> +        .features[FEAT_6_EAX] =
> +            CPUID_6_EAX_ARAT,
> +        .xlevel = 0x80000008,
> +        .model_id = "Intel Xeon Processor (Skylake w/ clflushopt)",
> +    },
>      {
>          .name = "Opteron_G1",
>          .level = 5,
> 
