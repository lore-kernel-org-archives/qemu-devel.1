Received: from eggs.gnu.org ([2001:4830:134:3::10]:47794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFlx9-0000ow-HF
	for qemu-devel@nongnu.org; Mon, 07 May 2018 15:37:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFlx6-0004YK-Bc
	for qemu-devel@nongnu.org; Mon, 07 May 2018 15:37:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fFlx6-0004Xn-3g
	for qemu-devel@nongnu.org; Mon, 07 May 2018 15:37:40 -0400
Date: Mon, 7 May 2018 16:37:32 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180507193732.GE13350@localhost.localdomain>
References: <1524760009-24710-1-git-send-email-babu.moger@amd.com>
	<1524760009-24710-6-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524760009-24710-6-git-send-email-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v7 5/9] i386: Use the statically loaded
 cache definitions
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

On Thu, Apr 26, 2018 at 11:26:45AM -0500, Babu Moger wrote:
> Use the statically loaded cache definitions if available
> and legacy-cache parameter is not set.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Tested-by: Geoffrey McRae <geoff@hostfission.com>

Now that I'm looking at the rest of the code, this seems
incomplete:

What about CPUID[2], CPUID[4]?  They are still referring to the
old legacy cache structs.

If their corresponding code isn't updated to use env->cache_info,
those leaves will be inconsistent with CPUID[0x8000005] and
CPUID[0x80000006].

> ---
>  target/i386/cpu.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index a27b658..56d2f0b 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3941,8 +3941,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>                 (L1_ITLB_2M_ASSOC <<  8) | (L1_ITLB_2M_ENTRIES);
>          *ebx = (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) | \
>                 (L1_ITLB_4K_ASSOC <<  8) | (L1_ITLB_4K_ENTRIES);
> -        *ecx = encode_cache_cpuid80000005(&l1d_cache_amd);
> -        *edx = encode_cache_cpuid80000005(&l1i_cache_amd);
> +        if (env->cache_info.valid && !cpu->legacy_cache) {
> +            *ecx = encode_cache_cpuid80000005(&env->cache_info.l1d_cache);
> +            *edx = encode_cache_cpuid80000005(&env->cache_info.l1i_cache);
> +        } else {
> +            *ecx = encode_cache_cpuid80000005(&l1d_cache_amd);
> +            *edx = encode_cache_cpuid80000005(&l1i_cache_amd);
> +        }
>          break;
>      case 0x80000006:
>          /* cache info (L2 cache) */
> @@ -3958,9 +3963,16 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>                 (L2_DTLB_4K_ENTRIES << 16) | \
>                 (AMD_ENC_ASSOC(L2_ITLB_4K_ASSOC) << 12) | \
>                 (L2_ITLB_4K_ENTRIES);
> -        encode_cache_cpuid80000006(&l2_cache_amd,
> -                                   cpu->enable_l3_cache ? &l3_cache : NULL,
> -                                   ecx, edx);
> +        if (env->cache_info.valid && !cpu->legacy_cache) {
> +            encode_cache_cpuid80000006(&env->cache_info.l2_cache,
> +                                       cpu->enable_l3_cache ?
> +                                       &env->cache_info.l3_cache : NULL,
> +                                       ecx, edx);
> +        } else {
> +            encode_cache_cpuid80000006(&l2_cache_amd,
> +                                       cpu->enable_l3_cache ? &l3_cache : NULL,
> +                                       ecx, edx);
> +        }
>          break;
>      case 0x80000007:
>          *eax = 0;
> -- 
> 2.7.4
> 
> 

-- 
Eduardo
