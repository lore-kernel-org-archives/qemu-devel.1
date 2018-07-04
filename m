Received: from eggs.gnu.org ([2001:4830:134:3::10]:56005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1faeIr-000734-3d
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:42:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1faeIn-0000j1-SL
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:42:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35736 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1faeIn-0000io-MR
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:42:21 -0400
References: <1530695199-27601-1-git-send-email-robert.hu@linux.intel.com>
	<1530695199-27601-3-git-send-email-robert.hu@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <791eed17-aa1e-e6d6-5dcf-43caa8b48af2@redhat.com>
Date: Wed, 4 Jul 2018 11:42:17 +0200
MIME-Version: 1.0
In-Reply-To: <1530695199-27601-3-git-send-email-robert.hu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/5] i386: Add CPUID bit and feature
 words for IA32_ARCH_CAPABILITIES MSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Robert Hoo <robert.hu@linux.intel.com>, qemu-devel@nongnu.org, rth@twiddle.net, ehabkost@redhat.com
Cc: robert.hu@intel.com

On 04/07/2018 11:06, Robert Hoo wrote:
> Support of IA32_PRED_CMD MSR already be enumerated by same CPUID bit as
> SPEC_CTRL.
> 
> Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> ---
>  target/i386/cpu.c | 2 +-
>  target/i386/cpu.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b0b87c3..7f787ef 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1000,7 +1000,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, "spec-ctrl", NULL,
> -            NULL, NULL, NULL, "ssbd",
> +            NULL, "arch-capabilities", NULL, "ssbd",
>          },
>          .cpuid_eax = 7,
>          .cpuid_needs_ecx = true, .cpuid_ecx = 0,
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index ae97005..c2b297b 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -690,6 +690,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>  #define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural Network Instructions */
>  #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
>  #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
> +#define CPUID_7_0_EDX_ARCH_CAPABILITIES (1U << 29)  /*Arch Capabilities*/
>  #define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store Bypass Disable */
>  
>  #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Prediction Barrier */
> 

Doing this without the MSR is wrong.  We need to leave it out of
Icelake-Client/Icelake-Server.  Eduardo, should the models be marked as
non-migratable until it is in place?

Paolo
