Received: from eggs.gnu.org ([2001:4830:134:3::10]:47910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4lec-0006UP-5j
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:32:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4leZ-0002M6-0I
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:32:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e4leY-0002Ky-Nk
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:32:46 -0400
References: <1508232883-8790-1-git-send-email-yang.zhong@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <33bd9d2f-1b06-d73c-c4a9-5f0e69b8e1d5@redhat.com>
Date: Wed, 18 Oct 2017 12:32:42 +0200
MIME-Version: 1.0
In-Reply-To: <1508232883-8790-1-git-send-email-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] x86/cpufeatures: Enable new AVX512 cpu
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org

On 17/10/2017 11:34, Yang Zhong wrote:
> Intel IceLake cpu has added new cpu features,AVX512VBMI2/GFNI/
> VAES/AVX512VNNI/AVX512BITALG/VPCLMULQDQ. Those new cpu features
> need expose to guest VM.
> 
> The bit definition:
> CPUID.(EAX=7,ECX=0):ECX[bit 06] AVX512VBMI2
> CPUID.(EAX=7,ECX=0):ECX[bit 08] GFNI
> CPUID.(EAX=7,ECX=0):ECX[bit 09] VAES
> CPUID.(EAX=7,ECX=0):ECX[bit 10] VPCLMULQDQ
> CPUID.(EAX=7,ECX=0):ECX[bit 11] AVX512VNNI
> CPUID.(EAX=7,ECX=0):ECX[bit 12] AVX512_BITALG
> 
> The release document ref below link:
> https://software.intel.com/sites/default/files/managed/c5/15/
> architecture-instruction-set-extensions-programming-reference.pdf
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>

Have you sent the KVM part of this too?  I cannot find it.

Paolo

> ---
>  target/i386/cpu.c | 6 +++---
>  target/i386/cpu.h | 6 ++++++
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 98732cd..03fb8ad 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -435,9 +435,9 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>      [FEAT_7_0_ECX] = {
>          .feat_names = {
>              NULL, "avx512vbmi", "umip", "pku",
> -            "ospke", NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> -            NULL, NULL, "avx512-vpopcntdq", NULL,
> +            "ospke", NULL, "avx512vbmi2", NULL,
> +            "gfni", "vaes", "vpclmulqdq", "avx512vnni",
> +            "avx512bitalg", NULL, "avx512-vpopcntdq", NULL,
>              "la57", NULL, NULL, NULL,
>              NULL, NULL, "rdpid", NULL,
>              NULL, NULL, NULL, NULL,
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index b086b15..cdbf8b0 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -635,6 +635,12 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>  #define CPUID_7_0_ECX_UMIP     (1U << 2)
>  #define CPUID_7_0_ECX_PKU      (1U << 3)
>  #define CPUID_7_0_ECX_OSPKE    (1U << 4)
> +#define CPUID_7_0_ECX_VBMI2    (1U << 6) /* Additional VBMI Instrs */
> +#define CPUID_7_0_ECX_GFNI     (1U << 8)
> +#define CPUID_7_0_ECX_VAES     (1U << 9)
> +#define CPUID_7_0_ECX_VPCLMULQDQ (1U << 10)
> +#define CPUID_7_0_ECX_AVX512VNNI (1U << 11)
> +#define CPUID_7_0_ECX_AVX512BITALG (1U << 12)
>  #define CPUID_7_0_ECX_AVX512_VPOPCNTDQ (1U << 14) /* POPCNT for vectors of DW/QW */
>  #define CPUID_7_0_ECX_LA57     (1U << 16)
>  #define CPUID_7_0_ECX_RDPID    (1U << 22)
> 
