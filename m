Received: from eggs.gnu.org ([2001:4830:134:3::10]:53318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f16kr-0000uO-VB
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 04:48:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f16ko-0001Sc-NY
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 04:48:26 -0400
Received: from 6.mo173.mail-out.ovh.net ([46.105.43.93]:47124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f16ko-0001Rz-Ed
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 04:48:22 -0400
Received: from player726.ha.ovh.net (unknown [10.109.105.84])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id CFCD0B3E44
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 10:48:20 +0200 (CEST)
Date: Wed, 28 Mar 2018 10:48:10 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180328104810.6835d5f7@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20180327043741.7705-10-david@gibson.dropbear.id.au>
References: <20180327043741.7705-1-david@gibson.dropbear.id.au>
	<20180327043741.7705-10-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC for-2.13 09/12] target/ppc: Move 1T segment
 and AMR options to PPCHash64Options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org, benh@kernel.crashing.org, bharata@linux.vnet.ibm.com, clg@kaod.org

On Tue, 27 Mar 2018 15:37:38 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> Currently env->mmu_model is a bit of an unholy mess of an enum of distinct
> MMU types, with various flag bits as well.  This makes which bits of the
> field should be compared pretty confusing.
> 
> Make a start on cleaning that up by moving two of the flags bits -
> POWERPC_MMU_1TSEG and POWERPC_MMU_AMR - which are specific to the 64-bit
> hash MMU into a new flags field in PPCHash64Options structure.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/pnv.c            |  3 ++-
>  hw/ppc/spapr.c          |  2 +-
>  target/ppc/cpu-qom.h    | 11 +++--------
>  target/ppc/kvm.c        |  4 ++--
>  target/ppc/mmu-hash64.c |  6 ++++--
>  target/ppc/mmu-hash64.h |  3 +++
>  6 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 5a79b24828..0aa878b771 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -36,6 +36,7 @@
>  #include "monitor/monitor.h"
>  #include "hw/intc/intc.h"
>  #include "hw/ipmi/ipmi.h"
> +#include "target/ppc/mmu-hash64.h"
>  
>  #include "hw/ppc/xics.h"
>  #include "hw/ppc/pnv_xscom.h"
> @@ -187,7 +188,7 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
>          _FDT((fdt_setprop(fdt, offset, "ibm,purr", NULL, 0)));
>      }
>  
> -    if (env->mmu_model & POWERPC_MMU_1TSEG) {
> +    if (cpu->hash64_opts->flags & PPC_HASH64_1TSEG) {
>          _FDT((fdt_setprop(fdt, offset, "ibm,processor-segment-sizes",
>                             segs, sizeof(segs))));
>      }
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index a35bffd524..436ed39f7f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -557,7 +557,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
>          _FDT((fdt_setprop(fdt, offset, "ibm,purr", NULL, 0)));
>      }
>  
> -    if (env->mmu_model & POWERPC_MMU_1TSEG) {
> +    if (cpu->hash64_opts->flags & PPC_HASH64_1TSEG) {
>          _FDT((fdt_setprop(fdt, offset, "ibm,processor-segment-sizes",
>                            segs, sizeof(segs))));
>      }
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index 3e5ef7375f..2bd58b2a84 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -68,22 +68,17 @@ enum powerpc_mmu_t {
>      /* PowerPC 601 MMU model (specific BATs format)            */
>      POWERPC_MMU_601        = 0x0000000A,
>  #define POWERPC_MMU_64       0x00010000
> -#define POWERPC_MMU_1TSEG    0x00020000
> -#define POWERPC_MMU_AMR      0x00040000
>  #define POWERPC_MMU_V3       0x00100000 /* ISA V3.00 MMU Support */
>      /* 64 bits PowerPC MMU                                     */
>      POWERPC_MMU_64B        = POWERPC_MMU_64 | 0x00000001,
>      /* Architecture 2.03 and later (has LPCR) */
>      POWERPC_MMU_2_03       = POWERPC_MMU_64 | 0x00000002,
>      /* Architecture 2.06 variant                               */
> -    POWERPC_MMU_2_06       = POWERPC_MMU_64 | POWERPC_MMU_1TSEG
> -                             | POWERPC_MMU_AMR | 0x00000003,
> +    POWERPC_MMU_2_06       = POWERPC_MMU_64 | 0x00000003,
>      /* Architecture 2.07 variant                               */
> -    POWERPC_MMU_2_07       = POWERPC_MMU_64 | POWERPC_MMU_1TSEG
> -                             | POWERPC_MMU_AMR | 0x00000004,
> +    POWERPC_MMU_2_07       = POWERPC_MMU_64 | 0x00000004,
>      /* Architecture 3.00 variant                               */
> -    POWERPC_MMU_3_00       = POWERPC_MMU_64 | POWERPC_MMU_1TSEG
> -                             | POWERPC_MMU_AMR | POWERPC_MMU_V3
> +    POWERPC_MMU_3_00       = POWERPC_MMU_64 | POWERPC_MMU_V3
>                               | 0x00000005,
>  };
>  #define POWERPC_MMU_VER(x) ((x) & (POWERPC_MMU_64 | 0xFFFF))
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 01947169c9..3424917381 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -302,7 +302,7 @@ static void kvm_get_fallback_smmu_info(PowerPCCPU *cpu,
>          /* HV KVM has backing store size restrictions */
>          info->flags = KVM_PPC_PAGE_SIZES_REAL;
>  
> -        if (env->mmu_model & POWERPC_MMU_1TSEG) {
> +        if (cpu->hash64_opts->flags & PPC_HASH64_1TSEG) {
>              info->flags |= KVM_PPC_1T_SEGMENTS;
>          }
>  
> @@ -482,7 +482,7 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
>      }
>      env->slb_nr = smmu_info.slb_size;
>      if (!(smmu_info.flags & KVM_PPC_1T_SEGMENTS)) {
> -        env->mmu_model &= ~POWERPC_MMU_1TSEG;
> +        cpu->hash64_opts->flags &= ~PPC_HASH64_1TSEG;
>      }
>  }
>  
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index d369b1bf86..1d785f50d7 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -160,7 +160,7 @@ int ppc_store_slb(PowerPCCPU *cpu, target_ulong slot,
>      if (vsid & (SLB_VSID_B & ~SLB_VSID_B_1T)) {
>          return -1; /* Bad segment size */
>      }
> -    if ((vsid & SLB_VSID_B) && !(env->mmu_model & POWERPC_MMU_1TSEG)) {
> +    if ((vsid & SLB_VSID_B) && !(cpu->hash64_opts->flags & PPC_HASH64_1TSEG)) {
>          return -1; /* 1T segment on MMU that doesn't support it */
>      }
>  
> @@ -369,7 +369,7 @@ static int ppc_hash64_amr_prot(PowerPCCPU *cpu, ppc_hash_pte64_t pte)
>      int prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>  
>      /* Only recent MMUs implement Virtual Page Class Key Protection */
> -    if (!(env->mmu_model & POWERPC_MMU_AMR)) {
> +    if (!(cpu->hash64_opts->flags & PPC_HASH64_AMR)) {
>          return prot;
>      }
>  
> @@ -1114,6 +1114,7 @@ void ppc_hash64_finalize(PowerPCCPU *cpu)
>  }
>  
>  const PPCHash64Options ppc_hash64_opts_basic = {
> +    .flags = 0,
>      .sps = {
>          { .page_shift = 12, /* 4K */
>            .slb_enc = 0,
> @@ -1127,6 +1128,7 @@ const PPCHash64Options ppc_hash64_opts_basic = {
>  };
>  
>  const PPCHash64Options ppc_hash64_opts_POWER7 = {
> +    .flags = PPC_HASH64_1TSEG | PPC_HASH64_AMR,
>      .sps = {
>          {
>              .page_shift = 12, /* 4K */
> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> index ff0c48af55..6cfca97a60 100644
> --- a/target/ppc/mmu-hash64.h
> +++ b/target/ppc/mmu-hash64.h
> @@ -152,6 +152,9 @@ struct ppc_one_seg_page_size {
>  };
>  
>  struct PPCHash64Options {
> +#define PPC_HASH64_1TSEG        0x00001
> +#define PPC_HASH64_AMR          0x00002
> +    unsigned flags;
>      struct ppc_one_seg_page_size sps[PPC_PAGE_SIZES_MAX_SZ];
>  };
>  
