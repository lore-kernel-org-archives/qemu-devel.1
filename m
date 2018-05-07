Received: from eggs.gnu.org ([2001:4830:134:3::10]:56639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFmf9-0005MQ-3c
	for qemu-devel@nongnu.org; Mon, 07 May 2018 16:23:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFmf5-00078U-QF
	for qemu-devel@nongnu.org; Mon, 07 May 2018 16:23:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fFmf5-00078E-Hb
	for qemu-devel@nongnu.org; Mon, 07 May 2018 16:23:07 -0400
Date: Mon, 7 May 2018 17:22:56 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180507202256.GG13350@localhost.localdomain>
References: <1524760009-24710-1-git-send-email-babu.moger@amd.com>
	<1524760009-24710-4-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524760009-24710-4-git-send-email-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v7 3/9] i386: Initialize cache information
 for EPYC family processors
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

On Thu, Apr 26, 2018 at 11:26:43AM -0500, Babu Moger wrote:
> Initialize pre-determined cache information for EPYC processors.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Tested-by: Geoffrey McRae <geoff@hostfission.com>

Assuming that the cache information below was validated by people
from AMD, patch looks good to me.

> ---
>  target/i386/cpu.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index a518a0f..5d88363 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2302,6 +2302,54 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              CPUID_6_EAX_ARAT,
>          .xlevel = 0x8000000A,
>          .model_id = "AMD EPYC Processor",
> +        .cache_info.valid = 1,
> +        .cache_info.l1d_cache = {
> +            .type = DCACHE,
> +            .level = 1,
> +            .size = 32 * KiB,
> +            .line_size = 64,
> +            .associativity = 8,
> +            .partitions = 1,
> +            .sets = 64,
> +            .lines_per_tag = 1,
> +            .self_init = 1,
> +            .no_invd_sharing = true,
> +        },
> +        .cache_info.l1i_cache = {
> +            .type = ICACHE,
> +            .level = 1,
> +            .size = 64 * KiB,
> +            .line_size = 64,
> +            .associativity = 4,
> +            .partitions = 1,
> +            .sets = 256,
> +            .lines_per_tag = 1,
> +            .self_init = 1,
> +            .no_invd_sharing = true,
> +        },
> +        .cache_info.l2_cache = {
> +            .type = UNIFIED_CACHE,
> +            .level = 2,
> +            .size = 512 * KiB,
> +            .line_size = 64,
> +            .associativity = 8,
> +            .partitions = 1,
> +            .sets = 1024,
> +            .lines_per_tag = 1,
> +        },
> +        .cache_info.l3_cache = {
> +            .type = UNIFIED_CACHE,
> +            .level = 3,
> +            .size = 8 * MiB,
> +            .line_size = 64,
> +            .associativity = 16,
> +            .partitions = 1,
> +            .sets = 8192,
> +            .lines_per_tag = 1,
> +            .self_init = true,
> +            .inclusive = true,
> +            .complex_indexing = true,
> +        },
>      },
>      {
>          .name = "EPYC-IBPB",
> @@ -2348,6 +2396,54 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              CPUID_6_EAX_ARAT,
>          .xlevel = 0x8000000A,
>          .model_id = "AMD EPYC Processor (with IBPB)",
> +        .cache_info.valid = 1,
> +        .cache_info.l1d_cache = {
> +            .type = DCACHE,
> +            .level = 1,
> +            .size = 32 * KiB,
> +            .line_size = 64,
> +            .associativity = 8,
> +            .partitions = 1,
> +            .sets = 64,
> +            .lines_per_tag = 1,
> +            .self_init = 1,
> +            .no_invd_sharing = true,
> +        },
> +        .cache_info.l1i_cache = {
> +            .type = ICACHE,
> +            .level = 1,
> +            .size = 64 * KiB,
> +            .line_size = 64,
> +            .associativity = 4,
> +            .partitions = 1,
> +            .sets = 256,
> +            .lines_per_tag = 1,
> +            .self_init = 1,
> +            .no_invd_sharing = true,
> +        },
> +        .cache_info.l2_cache = {
> +            .type = UNIFIED_CACHE,
> +            .level = 2,
> +            .size = 512 * KiB,
> +            .line_size = 64,
> +            .associativity = 8,
> +            .partitions = 1,
> +            .sets = 1024,
> +            .lines_per_tag = 1,
> +        },
> +        .cache_info.l3_cache = {
> +            .type = UNIFIED_CACHE,
> +            .level = 3,
> +            .size = 8 * MiB,
> +            .line_size = 64,
> +            .associativity = 16,
> +            .partitions = 1,
> +            .sets = 8192,
> +            .lines_per_tag = 1,
> +            .self_init = true,
> +            .inclusive = true,
> +            .complex_indexing = true,
> +        },
>      },
>  };
>  
> -- 
> 2.7.4
> 
> 

-- 
Eduardo
