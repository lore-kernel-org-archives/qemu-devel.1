Received: from eggs.gnu.org ([2001:4830:134:3::10]:42233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fIKlS-0001q2-2S
	for qemu-devel@nongnu.org; Mon, 14 May 2018 17:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fIKlN-0007X5-Te
	for qemu-devel@nongnu.org; Mon, 14 May 2018 17:12:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fIKlN-0007VS-KX
	for qemu-devel@nongnu.org; Mon, 14 May 2018 17:12:09 -0400
Date: Mon, 14 May 2018 18:12:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180514211201.GC25013@localhost.localdomain>
References: <1523402169-113351-1-git-send-email-babu.moger@amd.com>
	<1523402169-113351-8-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523402169-113351-8-git-send-email-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v6 7/9] i386: Add support for
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

On Tue, Apr 10, 2018 at 07:16:07PM -0400, Babu Moger wrote:
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
> index 63f2d31..24b39c6 100644
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

Using the AMD64 Architecture Programmer's Manual Volume 3 as
reference below.

The formula above assumes MNC = (2 ^ 6).

The current code in QEMU sets ApicIdCoreIdSize
(CPUID[0x80000008].ECX[bits 15:12]) to 0, which means MNC is
calculated using the legacy method:
  MNC = CPUID Fn8000_0008_ECX[NC] + 1.

The current code sets CPUID Fn8000_0008_ECX[NC] to:
  (cs->nr_cores * cs->nr_threads) - 1.

This means we cannot hardcode MNC, and must calculate it based on
nr_cores and nr_threads.

Probably it's a good idea to fill ApicIdCoreIdSize if TOPOEXT is
set, so we will know MNC will always be a power of 2 and the
formula here will be compatible with the existing APIC ID
calculation logic.

Note that we already have a comment at the top of topology.h:

 * This code should be compatible with AMD's "Extended Method" described at:
 *   AMD CPUID Specification (Publication #25481)
 *   Section 3: Multiple Core Calcuation
 * as long as:
 *  nr_threads is set to 1;
 *  OFFSET_IDX is assumed to be 0;
 *  CPUID Fn8000_0008_ECX[ApicIdCoreIdSize[3:0]] is set to apicid_core_width().

So you can already use cpu->apic_id here as long as
ApicIdCoreSize is set to apicid_core_width().  Probably
compatibility with AMD methods will be kept even if
nr_threads > 1, but I didn't confirm that.

Actually, I strongly advise you use cpu->apic_id here.  Otherwise
the Extended APIC ID seen by the guest here won't match the APIC
ID used everywhere else inside QEMU and KVM code.


> +
>  /*
>   * Encode cache info for CPUID[0x80000006].ECX and CPUID[0x80000006].EDX
>   * @l3 can be NULL.
> @@ -4098,6 +4104,14 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>              break;
>          }
>          break;
> +    case 0x8000001E:
> +        assert(cpu->core_id <= 255);
> +        *eax = EXTENDED_APIC_ID((cs->nr_threads - 1),
> +               cpu->socket_id, cpu->core_id, cpu->thread_id);
> +        *ebx = (cs->nr_threads - 1) << 8 | cpu->core_id;
> +        *ecx = cpu->socket_id;

Terminology is confusing here, so let's confirm this is really
what we want to do:
* ThreadsPerComputeUnit is set to nr_threads-1.  Looks correct.
* ComputeUnitId is being set to core_id.  Is this really what we
  want?
* NodesPerProcessor is being set to 0 (meaning 1 node per
  processor)
* NodeId is being set to socket_id.  Is this really right,
  considering that NodesPerProcessor is being set to 0?

If this is really what you intend to do, I'd like to see it
better documented, to avoid confusion in the future.

We could either add wrapper functions that make the logic more
explicit (e.g. x86_cpu_node_id(), x86_cpu_nodes_per_processor(),
etc.) or add comments explaining how the QEMU socket/core/thread
abstractions are being mapped to the AMD
socket/node/compute-unit/thread abstractions (also, how a
"Logical CCX L3 complex" is mapped into the QEMU abstractions,
here?)


> +        *edx = 0;
> +        break;
>      case 0xC0000000:
>          *eax = env->cpuid_xlevel2;
>          *ebx = 0;
> -- 
> 1.8.3.1
> 
> 

-- 
Eduardo
