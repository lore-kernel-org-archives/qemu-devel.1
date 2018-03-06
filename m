Received: from eggs.gnu.org ([2001:4830:134:3::10]:38823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1etBsL-0001iu-Or
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:39:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1etBsI-0002J9-NY
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:39:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1etBsI-0002IS-De
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:39:22 -0500
Date: Tue, 6 Mar 2018 09:39:12 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180306123912.GJ5120@localhost.localdomain>
References: <20180228211028.83970-1-brijesh.singh@amd.com>
	<20180228211028.83970-26-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228211028.83970-26-brijesh.singh@amd.com>
Subject: Re: [Qemu-devel] [PATCH v10 25/28] cpu/i386: populate CPUID
 0x8000_001F when SEV is active
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Alexander Graf <agraf@suse.de>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Markus Armbruster <armbru@redhat.com>, Bruce Rogers <brogers@suse.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Marcel Apfelbaum <marcel@redhat.com>, Borislav Petkov <bp@suse.de>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Richard Henderson <richard.henderson@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Feb 28, 2018 at 03:10:25PM -0600, Brijesh Singh wrote:
> When SEV is enabled, CPUID 0x8000_001F should provide additional
> information regarding the feature (such as which page table bit is used
> to mark the pages as encrypted etc).
> 
> The details for memory encryption CPUID is available in AMD APM
> (https://support.amd.com/TechDocs/24594.pdf) Section E.4.17
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  target/i386/cpu.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b5e431e769da..7a3cec59402b 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -26,6 +26,7 @@
>  #include "sysemu/hvf.h"
>  #include "sysemu/cpus.h"
>  #include "kvm_i386.h"
> +#include "sev_i386.h"
>  
>  #include "qemu/error-report.h"
>  #include "qemu/option.h"
> @@ -3612,6 +3613,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          *ecx = 0;
>          *edx = 0;
>          break;
> +    case 0x8000001F:

What I'm worried about here is ABI stability and migration safety
guarantees.  Let's see:

> +        *eax = sev_enabled() ? 0x2 : 0;

sev_enabled() just checks if sev_state is set.
sev_state is only set by sev_guest_init().
sev_guest_init() is only called if MachineState::memory_encryption is set.

The value is a function of command-line options only.  Good.

> +        *ebx = sev_get_cbit_position();

This is 0 if sev_state is NULL (see above).  Good.

If sev_state is set, it returns sev_state->cbitpos.

s->cbitpos is set based on the "cbitpos" property of
QSevGuestInfo only (it's only validated against host CPUID).  The
property has no host-dependent default and needs to be set
explicitly.

This means sev_get_cbit_position() is a function of command-line
options only, too.  Good.

> +        *ebx |= sev_get_reduced_phys_bits() << 6;

Logic is very similar to sev_get_cbit_position(), and depends on
the "reduced-phys-bits" property of QSevGuestInfo only.  Good.


> +        *ecx = 0;
> +        *edx = 0;
> +        break;
>      default:
>          /* reserved values: zero */
>          *eax = 0;
> @@ -4041,6 +4049,11 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>          if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
>              x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000000A);
>          }
> +
> +        /* SEV requires CPUID[0x8000001F] */
> +        if (sev_enabled()) {
> +            x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000001F);
> +        }

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

>      }
>  
>      /* Set cpuid_*level* based on cpuid_min_*level, if not explicitly set */
> -- 
> 2.14.3
> 
> 

-- 
Eduardo
