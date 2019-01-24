Received: from eggs.gnu.org ([209.51.188.92]:58795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gmjuc-0000BJ-TA
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 13:39:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gmjuR-0001s2-0e
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 13:39:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gmjuH-0001l3-V2
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 13:39:20 -0500
Date: Thu, 24 Jan 2019 16:39:09 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190124183909.GA4136@habkost.net>
References: <1548381283-16688-1-git-send-email-luwei.kang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548381283-16688-1-git-send-email-luwei.kang@intel.com>
Subject: Re: [Qemu-devel] [PATCH] i386: extended the cpuid level when Intel
 PT is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luwei Kang <luwei.kang@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

Hi,

Thanks for the patch.  Comment below:

On Thu, Jan 24, 2019 at 08:54:43PM -0500, Luwei Kang wrote:
> Intel Processor Trace required CPUID[0x14] but the cpuid level
> is 0xd when create a kvm guest with e.g. "-cpu qemu64,+intel-pt".
> 
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> ---
>  target/i386/cpu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 2f54125..da477b3 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5023,6 +5023,13 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>          x86_cpu_adjust_feat_level(cpu, FEAT_C000_0001_EDX);
>          x86_cpu_adjust_feat_level(cpu, FEAT_SVM);
>          x86_cpu_adjust_feat_level(cpu, FEAT_XSAVE);
> +
> +        /* Intel Processor Trace requires CPUID[0x14] */
> +        if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
> +             kvm_enabled()) {
> +            x86_cpu_adjust_level(cpu, &cpu->env.cpuid_min_level, 0x14);
> +        }

This will require a new machine-type compatibility flag to enable
the new behavior, so we don't change CPUID data under the guest
feet during live migration.

> +
>          /* SVM requires CPUID[0x8000000A] */
>          if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
>              x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000000A);
> -- 
> 1.8.3.1
> 

-- 
Eduardo
