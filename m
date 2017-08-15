Received: from eggs.gnu.org ([2001:4830:134:3::10]:47867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dha8J-0007nl-Qp
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:35:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dha8F-0008SV-9x
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:35:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dha8F-0008Ru-3o
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:35:35 -0400
Date: Tue, 15 Aug 2017 08:35:31 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170815113531.GR3108@localhost.localdomain>
References: <20170814155217.4898-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170814155217.4898-1-brijesh.singh@amd.com>
Subject: Re: [Qemu-devel] [PATCH] target-i386/cpu: Add new EYPC CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Tom Lendacky <Thomas.Lendacky@amd.com>

Hi,

Thanks for the patch.

On Mon, Aug 14, 2017 at 10:52:17AM -0500, Brijesh Singh wrote:
> Add a new base CPU model called 'EPYC' to model processors from AMD EPYC
> family (which includes EPYC 76xx,75xx,74xx,73xx and 72xx).

I suggest enumerating in the commit message which features were
added to the CPU model in comparison to Opteron_G5.

> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  target/i386/cpu.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index ddc45ab..ed1708b 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1522,6 +1522,50 @@ static X86CPUDefinition builtin_x86_defs[] = {
>          .xlevel = 0x8000001A,
>          .model_id = "AMD Opteron 63xx class CPU",
>      },
> +    {
> +        .name = "EPYC",
> +        .level = 0xd,
> +        .vendor = CPUID_VENDOR_AMD,
> +        .family = 23,
> +        .model = 1,
> +        .stepping = 2,
[...]
> +        /* Missing: XSAVES (not supported by some Linux versions,
> +         * including v4.1 to v4.12).
> +         * KVM doesn't yet expose any XSAVES state save component.
> +         */

Do you know which supervisor state components are available in
EPYC CPUs?  Do you have a pointer to public AMD documentation
about XSAVES?


> +        .features[FEAT_XSAVE] =
> +            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
> +            CPUID_XSAVE_XGETBV1,
> +        .features[FEAT_6_EAX] =
> +            CPUID_6_EAX_ARAT,
> +        .xlevel = 0x8000001F,

All CPUID leaves from 0x8000000B to 0x8000001F return all-zeroes
today.  If we set xlevel to 0x8000001F before we actually
implement those CPUID leaves, we will be forced to add extra
machine-type compat code when we finally implement them.

I suggest setting it to 0x8000000A, and increasing it only after
we actually implement the new CPUID leaves.


> +        .model_id = "AMD EYPC Processor",
> +    },
>  };
>  
>  typedef struct PropValue {
> -- 
> 2.9.4
> 

-- 
Eduardo
