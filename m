Received: from eggs.gnu.org ([2001:4830:134:3::10]:45178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ewteJ-0003bl-0e
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ewteE-0004jd-LK
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:00:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ewteE-0004i1-CV
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:00:10 -0400
Date: Fri, 16 Mar 2018 15:00:06 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180316180006.GH28578@localhost.localdomain>
References: <1520888449-4352-1-git-send-email-babu.moger@amd.com>
	<1520888449-4352-3-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520888449-4352-3-git-send-email-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/5] target/i386: Populate AMD Processor
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
Cc: pbonzini@redhat.com, rth@twiddle.net, rkrcmar@redhat.com, Thomas.Lendacky@amd.com, brijesh.singh@amd.com, kvm@vger.kernel.org, kash@tripleback.net, mtosatti@redhat.com, Gary.Hook@amd.com, qemu-devel@nongnu.org

On Mon, Mar 12, 2018 at 05:00:46PM -0400, Babu Moger wrote:
> From: Stanislav Lanci <pixo@polepetko.eu>
> 
> Add information for cpuid 0x8000001D leaf. Populate cache topology information
> for different cache types(Data Cache, Instruction Cache, L2 and L3) supported
> by 0x8000001D leaf. Please refer Processor Programming Reference (PPR) for AMD
> Family 17h Model for more details.
> 
> Signed-off-by: Stanislav Lanci <pixo@polepetko.eu>
> Signed-off-by: Babu Moger <babu.moger@amd.com>

The new CPUID leaves don't seem to match the existing AMD cache information
leaves.  Is this intentional?  Why?

Details below:

> ---
>  target/i386/cpu.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  target/i386/kvm.c | 29 ++++++++++++++++++++++---
>  2 files changed, 91 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 42dd381..5fdbedd 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
[...]
> @@ -3590,6 +3594,67 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>              *edx = 0;
>          }
>          break;
> +    case 0x8000001D: /* AMD TOPOEXT cache info */
> +        switch (count) {

Copying macro definitions here, for reference:

> /* L1 data cache: */
> #define L1D_LINE_SIZE         64
> #define L1D_ASSOCIATIVITY      8
> #define L1D_SETS              64
> #define L1D_PARTITIONS         1
> /* Size = LINE_SIZE*ASSOCIATIVITY*SETS*PARTITIONS = 32KiB */
> #define L1D_DESCRIPTOR CPUID_2_L1D_32KB_8WAY_64B
> /*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
> #define L1D_LINES_PER_TAG      1
> #define L1D_SIZE_KB_AMD       64
> #define L1D_ASSOCIATIVITY_AMD  2

So, we already have:

CPUID[2]: 32KB 8-way cache, 64-byte lines
CPUID[4]: 8-way cache, 64-byte lines, 64 sets, 1 partition (32 KB)
CPUID[0x80000005]: 64 KB 2-way cache, 1 line per tag


> +        case 0: /* L1 dcache info */
> +            *eax |= TYPE_DCACHE | \
> +                    CACHE_LEVEL(1) | \
> +                    CACHE_SELF_INIT_LEVEL | \
> +                    ((cs->nr_threads - 1) << 14);
> +            *ebx = (L1D_LINE_SIZE - 1) | \
> +                   ((L1D_PARTITIONS - 1) << 12) | \
> +                   ((L1D_ASSOCIATIVITY - 1) << 22);
> +            *ecx = L1D_SETS - 1;
> +            *edx = 0;
> +            break;

This adds:
CPUID[0x8000001D]: 8-way cache, 64-byte lines, 64 sets, 1 partition (32 KiB)

This agrees with CPUID[2] and CPUID[4] (Intel leaves, reserved on AMD), but not
with CPUID[0x80000005].

>  
>  /* L1 instruction cache: */
>  #define L1I_LINE_SIZE         64
>  #define L1I_ASSOCIATIVITY      8
>  #define L1I_SETS              64
> +#define L1I_SETS_AMD         256
>  #define L1I_PARTITIONS         1
>  /* Size = LINE_SIZE*ASSOCIATIVITY*SETS*PARTITIONS = 32KiB */
>  #define L1I_DESCRIPTOR CPUID_2_L1I_32KB_8WAY_64B
>  /*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
>  #define L1I_LINES_PER_TAG      1
>  #define L1I_SIZE_KB_AMD       64
>  #define L1I_ASSOCIATIVITY_AMD  2

Currently we have:

CPUID[2]: 32KiB 8-way cache, 64-byte lines
CPUID[4]: 8-way cache, 64-byte lines, 64 sets, 1 partition (32 KiB)
CPUID[0x80000005]: 64 KiB 2-way cache, 1 line per tag


>  
> +        case 1: /* L1 icache info */
> +            *eax |= TYPE_ICACHE | \
> +                    CACHE_LEVEL(1) | \
> +                    CACHE_SELF_INIT_LEVEL | \
> +                    ((cs->nr_threads - 1) << 14);
> +            *ebx = (L1I_LINE_SIZE - 1) | \
> +                   ((L1I_PARTITIONS - 1) << 12) | \
> +                   ((L1I_ASSOCIATIVITY_AMD - 1) << 22);
> +            *ecx = L1I_SETS_AMD - 1;
> +            *edx = 0;
> +            break;

This adds:
CPUID[0x8000001D]: 2-way cache, 64-byte lines, 256 sets, 1 partition (32 KiB)

This doesn't match any of the existing leaves.


>  /* Level 2 unified cache: */
>  #define L2_LINE_SIZE          64
>  #define L2_ASSOCIATIVITY      16
> +#define L2_ASSOCIATIVITY_AMD   8
>  #define L2_SETS             4096
> +#define L2_SETS_AMD         1024
>  #define L2_PARTITIONS          1
>  /* Size = LINE_SIZE*ASSOCIATIVITY*SETS*PARTITIONS = 4MiB */
>  /*FIXME: CPUID leaf 2 descriptor is inconsistent with CPUID leaf 4 */
>  #define L2_DESCRIPTOR CPUID_2_L2_2MB_8WAY_64B
>  /*FIXME: CPUID leaf 0x80000006 is inconsistent with leaves 2 & 4 */
>  #define L2_LINES_PER_TAG       1
>  #define L2_SIZE_KB_AMD       512

Currently we have:
CPUID[2]: 4MiB 8-way cache, 64-byte lines
CPUID[4]: 64-byte lines, 16-way, 1 partition, 4096 sets (4 MiB)
CPUID[0x80000006]: 512 KiB, 16-way cache, 1 line per tag

>  
> +        case 2: /* L2 cache info */
> +            *eax |= TYPE_UNIFIED | \
> +                    CACHE_LEVEL(2) | \
> +                    CACHE_SELF_INIT_LEVEL | \
> +                    ((cs->nr_threads - 1) << 14);
> +            *ebx = (L2_LINE_SIZE - 1) | \
> +                   ((L2_PARTITIONS - 1) << 12) | \
> +                   ((L2_ASSOCIATIVITY_AMD - 1) << 22);
> +            *ecx = L2_SETS_AMD - 1;
> +            *edx = CACHE_INCLUSIVE;
> +            break;

This adds:
CPUID[0x8000001D]: 64-byte lines, 8-way, 1 partition, 1024 sets (512 KiB).

This doesn't match any of the existing leaves.


>  /* Level 3 unified cache: */
>  #define L3_N_LINE_SIZE         64
>  #define L3_N_ASSOCIATIVITY     16
>  #define L3_N_SETS           16384
> +#define L3_N_SETS_AMD        8192
>  #define L3_N_PARTITIONS         1
>  #define L3_N_DESCRIPTOR CPUID_2_L3_16MB_16WAY_64B
>  #define L3_N_LINES_PER_TAG      1
>  #define L3_N_SIZE_KB_AMD    16384
>  

Currently we have:
CPUID[2]: 16MiB 16-way cache, 64-byte lines
CPUID[4]: 64-byte lines, 16-way, 16384 sets, 1 partition (16 MiB)
CPUID[0x80000006]: 16 MiB cache, 16-way, 1 line per tag


> +        case 3: /* L3 cache info */
> +            if (cpu->enable_l3_cache) {
> +                *eax |= TYPE_UNIFIED | \
> +                        CACHE_LEVEL(3) | \
> +                        CACHE_SELF_INIT_LEVEL | \
> +                        ((cs->nr_cores * cs->nr_threads - 1) << 14);
> +                *ebx = (L3_N_LINE_SIZE - 1) | \
> +                       ((L3_N_PARTITIONS - 1) << 12) | \
> +                       ((L3_N_ASSOCIATIVITY - 1) << 22);
> +                *ecx = L3_N_SETS_AMD - 1;
> +                *edx = CACHE_NO_INVD_SHARING;

This adds:
CPUID[0x8000001D]: 64-byte lines, 16-way, 1 partition, 8192 sets (8 MiB)

This doesn't match any of the existing leaves.


> +            } else {
> +                *eax = 0;
> +                *ebx = 0;
> +                *ecx = 0;
> +                *edx = 0;
> +            }
> +            break;
> +        default: /* end of info */
> +            *eax = 0;
> +            *ebx = 0;
> +            *ecx = 0;
> +            *edx = 0;
> +            break;
> +        }
> +        break;
>      case 0xC0000000:
>          *eax = env->cpuid_xlevel2;
>          *ebx = 0;
[...]

-- 
Eduardo
