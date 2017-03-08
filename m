Received: from eggs.gnu.org ([2001:4830:134:3::10]:53272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1clj9Y-0000l1-W4
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:29:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1clj9V-0006d7-PD
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:29:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1clj9V-0006d0-Jd
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:29:45 -0500
Date: Wed, 8 Mar 2017 18:29:38 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170308212938.GR4694@thinpad.lan.raisama.net>
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
	<148900646027.27090.10825101032119361281.stgit@brijesh-build-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148900646027.27090.10825101032119361281.stgit@brijesh-build-machine>
Subject: Re: [Qemu-devel] [RFC PATCH v4 18/20] target/i386: add cpuid
 Fn8000_001f
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: crosthwaite.peter@gmail.com, armbru@redhat.com, mst@redhat.com, p.fedin@samsung.com, qemu-devel@nongnu.org, lcapitulino@redhat.com, pbonzini@redhat.com, rth@twiddle.net, Thomas.Lendacky@amd.com

On Wed, Mar 08, 2017 at 03:54:20PM -0500, Brijesh Singh wrote:
> Fn8000_001f cpuid provides the memory encryption (aka C-bit) location
> in a page table for the SEV-enabled guest.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  target/i386/cpu.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index fba9212..44662eb 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -40,6 +40,7 @@
>  #include "qapi/visitor.h"
>  #include "qom/qom-qobject.h"
>  #include "sysemu/arch_init.h"
> +#include "sysemu/sev.h"
>  
>  #if defined(CONFIG_KVM)
>  #include <linux/kvm_para.h>
> @@ -2966,6 +2967,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>              *edx = 0;
>          }
>          break;
> +    case 0x8000001F:
> +        if (sev_enabled()) {
> +            host_cpuid(index, 0, eax, ebx, ecx, edx);

This doesn't look future-proof. The architecture may be extended
to include CPUID bits that we can't expose to the guest unless we
implement host-side support for it.

I suggest including only the specific bits we know we can really
expose to the guest, instead of exposing raw host CPUID directly.

Also, exposing only explicitly configured CPUID bits will make it
easier to implement migration support in the future.

> +        }
> +        break;
>      case 0xC0000000:
>          *eax = env->cpuid_xlevel2;
>          *ebx = 0;
> 

-- 
Eduardo
