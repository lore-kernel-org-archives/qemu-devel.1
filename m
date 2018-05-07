Received: from eggs.gnu.org ([2001:4830:134:3::10]:48075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFlzH-0001ey-Dz
	for qemu-devel@nongnu.org; Mon, 07 May 2018 15:39:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFlzE-0005Uc-8L
	for qemu-devel@nongnu.org; Mon, 07 May 2018 15:39:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fFlzE-0005US-24
	for qemu-devel@nongnu.org; Mon, 07 May 2018 15:39:52 -0400
Date: Mon, 7 May 2018 16:39:44 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180507193944.GF13350@localhost.localdomain>
References: <1524760009-24710-1-git-send-email-babu.moger@amd.com>
	<1524760009-24710-8-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524760009-24710-8-git-send-email-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v7 7/9] i386: Add support for
 CPUID_8000_001E for AMD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>
Cc: mst@redhat.com, marcel@redhat.com, pbonzini@redhat.com, rth@twiddle.net, mtosatti@redhat.com, geoff@hostfission.com, kash@tripleback.net, qemu-devel@nongnu.org, kvm@vger.kernel.org

On Thu, Apr 26, 2018 at 11:26:47AM -0500, Babu Moger wrote:
> Populate threads/core_id/apic_ids/socket_id when CPUID_EXT3_TOPOEXT
> feature is supported. This is required to support hyperthreading feature
> on AMD CPUs. This is supported via CPUID_8000_001E extended functions.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Tested-by: Geoffrey McRae <geoff@hostfission.com>
> ---
>  target/i386/cpu.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1024b09..1b15023 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -315,6 +315,12 @@ static uint32_t encode_cache_cpuid80000005(CPUCacheInfo *cache)
>                           (((CORES_IN_CMPLX - 1) * 2) + 1)  : \
>                           (CORES_IN_CMPLX - 1))
>  
> +/* Definitions used on CPUID Leaf 0x8000001E */
> +#define EXTENDED_APIC_ID(threads, socket_id, core_id, thread_id) \
> +                        ((threads) ? \
> +                         ((socket_id << 6) | (core_id << 1) | thread_id) : \
> +                         ((socket_id << 6) | core_id))

I suggest moving this to i386/topology.h.


> +
>  /*
>   * Encode cache info for CPUID[0x80000006].ECX and CPUID[0x80000006].EDX
>   * @l3 can be NULL.
> @@ -4105,6 +4111,14 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>              break;
>          }
>          break;
> +    case 0x8000001E:
> +        assert(cpu->core_id <= 255);

Where's the code that ensures this assert() line can't be
triggered by any command-line configuration?

> +        *eax = EXTENDED_APIC_ID((cs->nr_threads - 1),
> +               cpu->socket_id, cpu->core_id, cpu->thread_id);
> +        *ebx = (cs->nr_threads - 1) << 8 | cpu->core_id;
> +        *ecx = cpu->socket_id;
> +        *edx = 0;
> +        break;
>      case 0xC0000000:
>          *eax = env->cpuid_xlevel2;
>          *ebx = 0;
> -- 
> 2.7.4
> 
> 

-- 
Eduardo
