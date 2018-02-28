Received: from eggs.gnu.org ([2001:4830:134:3::10]:43022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1er6Ae-0007sh-W0
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:09:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1er6Aa-0000dZ-Vz
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:09:40 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47512 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkrcmar@redhat.com>) id 1er6Aa-0000cP-PF
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:09:36 -0500
Date: Wed, 28 Feb 2018 19:08:59 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Message-ID: <20180228180858.GB8418@flask>
References: <1519439425-27883-1-git-send-email-babu.moger@amd.com>
	<1519439425-27883-3-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519439425-27883-3-git-send-email-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] target/i386: Populate AMD Processor
 Cache Information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, pixo@polepetko.eu, Gary.Hook@amd.com

2018-02-23 21:30-0500, Babu Moger:
> From: Stanislav Lanci <pixo@polepetko.eu>
> 
> Adds information about cache size and topology from cpuid 0x8000001D leaf
> for different cache types on AMD processors.
> 
> Signed-off-by: Stanislav Lanci <pixo@polepetko.eu>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> @@ -3590,6 +3594,78 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>              *edx = 0;
>          }
>          break;
> +    case 0x8000001D: /* AMD TOPOEXT cache info */
> +        if (cpu->cache_info_passthrough) {
> +            host_cpuid(index, count, eax, ebx, ecx, edx);
> +            break;
> +        } else if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) {
> +            *eax = 0;
> +            switch (count) {
> +            case 0: /* L1 dcache info */
> +                *eax |= CPUID_4_TYPE_DCACHE | \
> +                        CPUID_4_LEVEL(1) | \
> +                        CPUID_4_SELF_INIT_LEVEL | \
> +                        ((cs->nr_threads - 1) << 14);

CPUID_4 uses the same format even for bits 25-14, so this would look
better with a macro.

> +                *ebx = (L1D_LINE_SIZE - 1) | \
> +                       ((L1D_PARTITIONS - 1) << 12) | \
> +                       ((L1D_ASSOCIATIVITY - 1) << 22);
> +                *ecx = L1D_SETS - 1;

These numbers seem to have the same meaning as CPUID 4, but have
conflicting values.

I think we should not expose CPUID 4 with AMD CPUs or at least when they
have CPUID_EXT3_TOPOEXT (the latter is easier wrt. compatibility).

> +                *edx = 0;
> +                break;
> +            case 1: /* L1 icache info */
> +                *eax |= CPUID_4_TYPE_ICACHE | \
> +                        CPUID_4_LEVEL(1) | \
> +                        CPUID_4_SELF_INIT_LEVEL | \
> +                        ((cs->nr_threads - 1) << 14);
> +                *ebx = (L1I_LINE_SIZE - 1) | \
> +                       ((L1I_PARTITIONS - 1) << 12) | \
> +                       ((L1I_ASSOCIATIVITY_AMD - 1) << 22);
> +                *ecx = L1I_SETS_AMD - 1;
> +                *edx = 0;
> +                break;
> +            case 2: /* L2 cache info */
> +                *eax |= CPUID_4_TYPE_UNIFIED | \
> +                        CPUID_4_LEVEL(2) | \
> +                        CPUID_4_SELF_INIT_LEVEL | \
> +                        ((cs->nr_threads - 1) << 14);
> +                *ebx = (L2_LINE_SIZE - 1) | \
> +                       ((L2_PARTITIONS - 1) << 12) | \
> +                       ((L2_ASSOCIATIVITY_AMD - 1) << 22);
> +                *ecx = L2_SETS_AMD - 1;
> +                *edx = CPUID_4_INCLUSIVE;
> +                break;
> +            case 3: /* L3 cache info */
> +                if (!cpu->enable_l3_cache) {
> +                    *eax = 0;
> +                    *ebx = 0;
> +                    *ecx = 0;
> +                    *edx = 0;
> +                    break;
> +                }
> +                *eax |= CPUID_4_TYPE_UNIFIED | \
> +                        CPUID_4_LEVEL(3) | \
> +                        CPUID_4_SELF_INIT_LEVEL | \
> +                        ((cs->nr_cores * cs->nr_threads - 1) << 14);

This number seems to be the only difference that isn't just a difference
constant.  It tempts me to merge the cases for 4 and 0x8000001D as it
seems that vendors try to be compatible.

> +                *ebx = (L3_N_LINE_SIZE - 1) | \
> +                       ((L3_N_PARTITIONS - 1) << 12) | \
> +                       ((L3_N_ASSOCIATIVITY - 1) << 22);
> +                *ecx = L3_N_SETS_AMD - 1;
> +                *edx = CPUID_4_NO_INVD_SHARING;
> +                break;
> +            default: /* end of info */
> +                *eax = 0;
> +                *ebx = 0;
> +                *ecx = 0;
> +                *edx = 0;
> +                break;
> +            }
> +        } else {
> +            *eax = 0;
> +            *ebx = 0;
> +            *ecx = 0;
> +            *edx = 0;
> +        }
> +        break;
>      case 0xC0000000:
>          *eax = env->cpuid_xlevel2;
>          *ebx = 0;

The numbers looks like real hardware,

thanks.
