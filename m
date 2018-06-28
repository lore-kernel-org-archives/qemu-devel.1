Received: from eggs.gnu.org ([2001:4830:134:3::10]:44061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYbed-0006cN-60
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 14:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYbeZ-0004SY-U8
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 14:28:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fYbeZ-0004QW-Mw
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 14:28:23 -0400
Date: Thu, 28 Jun 2018 15:28:20 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180628182820.GE914@localhost.localdomain>
References: <1530098844-236851-1-git-send-email-robert.hu@linux.intel.com>
	<1530098844-236851-3-git-send-email-robert.hu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530098844-236851-3-git-send-email-robert.hu@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] i386: Add CPUID bit and feature
 words for IA32_ARCH_CAPABILITIES MSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Robert Hoo <robert.hu@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, robert.hu@intel.com

On Wed, Jun 27, 2018 at 07:27:21PM +0800, Robert Hoo wrote:
> Support of IA32_PRED_CMD MSR already be enumerated by same CPUID bit as
> SPEC_CTRL.
> 
> Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>

Based on kernel commit 1eaafe91, it looks like we must always set
IA32_ARCH_CAPABILITIES.RSBA[bit 2] unless we're really sure the
VM will not be migrated to a vulnerable processor.

Considering this, I'd like to make "+arch-capabilities" set
IA32_ARCH_CAPABILITIES.RSBA by default, unless RSBA is explicitly
disabled by management software.

> ---
>  target/i386/cpu.c | 2 +-
>  target/i386/cpu.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index e6c2f8a..953098c 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1002,7 +1002,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, "spec-ctrl", NULL,
> -            NULL, NULL, NULL, "ssbd",
> +            NULL, "arch-capabilities", NULL, "ssbd",
>          },
>          .cpuid_eax = 7,
>          .cpuid_needs_ecx = true, .cpuid_ecx = 0,
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 734a73e..1ef2040 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -688,6 +688,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>  #define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural Network Instructions */
>  #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
>  #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
> +#define CPUID_7_0_EDX_ARCH_CAPABILITIES (1U << 29)  /*Arch Capabilities of RDCL_NO and IBRS_ALL*/
>  #define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store Bypass Disable */
>  
>  #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Prediction Barrier */
> -- 
> 1.8.3.1
> 
> 

-- 
Eduardo
