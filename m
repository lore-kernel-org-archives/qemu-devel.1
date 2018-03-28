Received: from eggs.gnu.org ([2001:4830:134:3::10]:53669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f16n5-0002ov-OH
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 04:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f16n2-0002Bw-DT
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 04:50:43 -0400
Received: from 11.mo4.mail-out.ovh.net ([46.105.34.195]:47238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f16n2-0002AJ-3h
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 04:50:40 -0400
Received: from player794.ha.ovh.net (unknown [10.109.122.15])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 3522A15774C
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 10:50:37 +0200 (CEST)
Date: Wed, 28 Mar 2018 10:50:29 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180328105029.0c5ba9fe@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20180327043741.7705-11-david@gibson.dropbear.id.au>
References: <20180327043741.7705-1-david@gibson.dropbear.id.au>
	<20180327043741.7705-11-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC for-2.13 10/12] target/ppc: Fold
 ci_large_pages flag into PPCHash64Options
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

On Tue, 27 Mar 2018 15:37:39 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> The ci_large_pages boolean in CPUPPCState is only relevant to 64-bit hash
> MMU machines, indicating whether it's possible to map large (> 4kiB) pages
> as cache-inhibitied (i.e. for IO, rather than memory).  Fold it as another
> flag into the PPCHash64Options structure.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c              | 3 +--
>  target/ppc/cpu.h            | 1 -
>  target/ppc/kvm.c            | 6 +++++-
>  target/ppc/mmu-hash64.c     | 2 +-
>  target/ppc/mmu-hash64.h     | 1 +
>  target/ppc/translate_init.c | 3 ---
>  6 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 436ed39f7f..95063df54d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -263,7 +263,6 @@ static void spapr_populate_pa_features(sPAPRMachineState *spapr,
>                                         void *fdt, int offset,
>                                         bool legacy_guest)
>  {
> -    CPUPPCState *env = &cpu->env;
>      uint8_t pa_features_206[] = { 6, 0,
>          0xf6, 0x1f, 0xc7, 0x00, 0x80, 0xc0 };
>      uint8_t pa_features_207[] = { 24, 0,
> @@ -315,7 +314,7 @@ static void spapr_populate_pa_features(sPAPRMachineState *spapr,
>          return;
>      }
>  
> -    if (env->ci_large_pages) {
> +    if (cpu->hash64_opts->flags & PPC_HASH64_CI_LARGEPAGE) {
>          /*
>           * Note: we keep CI large pages off by default because a 64K capable
>           * guest provisioned with large pages might otherwise try to map a qemu
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index fb6c578eb5..76ce67e9de 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1088,7 +1088,6 @@ struct CPUPPCState {
>  #if defined(TARGET_PPC64)
>      ppc_slb_t vrma_slb;
>      target_ulong rmls;
> -    bool ci_large_pages;
>  #endif
>  
>  #if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 3424917381..6c45815ee6 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -448,7 +448,11 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
>       * host page size is smaller than 64K.
>       */
>      if (smmu_info.flags & KVM_PPC_PAGE_SIZES_REAL) {
> -        env->ci_large_pages = getpagesize() >= 0x10000;
> +        if (getpagesize() >= 0x10000) {
> +            cpu->hash64_opts->flags |= PPC_HASH64_CI_LARGEPAGE;
> +        } else {
> +            cpu->hash64_opts->flags &= ~PPC_HASH64_CI_LARGEPAGE;
> +        }
>      }
>  
>      /*
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 1d785f50d7..3b00bdee91 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -1128,7 +1128,7 @@ const PPCHash64Options ppc_hash64_opts_basic = {
>  };
>  
>  const PPCHash64Options ppc_hash64_opts_POWER7 = {
> -    .flags = PPC_HASH64_1TSEG | PPC_HASH64_AMR,
> +    .flags = PPC_HASH64_1TSEG | PPC_HASH64_AMR | PPC_HASH64_CI_LARGEPAGE,
>      .sps = {
>          {
>              .page_shift = 12, /* 4K */
> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> index 6cfca97a60..cddfe06a8b 100644
> --- a/target/ppc/mmu-hash64.h
> +++ b/target/ppc/mmu-hash64.h
> @@ -154,6 +154,7 @@ struct ppc_one_seg_page_size {
>  struct PPCHash64Options {
>  #define PPC_HASH64_1TSEG        0x00001
>  #define PPC_HASH64_AMR          0x00002
> +#define PPC_HASH64_CI_LARGEPAGE 0x00004
>      unsigned flags;
>      struct ppc_one_seg_page_size sps[PPC_PAGE_SIZES_MAX_SZ];
>  };
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index ae005b2a54..a925cf5cd3 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8392,7 +8392,6 @@ static void init_proc_POWER7(CPUPPCState *env)
>  #if !defined(CONFIG_USER_ONLY)
>      env->slb_nr = 32;
>  #endif
> -    env->ci_large_pages = true;
>      env->dcache_line_size = 128;
>      env->icache_line_size = 128;
>  
> @@ -8547,7 +8546,6 @@ static void init_proc_POWER8(CPUPPCState *env)
>  #if !defined(CONFIG_USER_ONLY)
>      env->slb_nr = 32;
>  #endif
> -    env->ci_large_pages = true;
>      env->dcache_line_size = 128;
>      env->icache_line_size = 128;
>  
> @@ -8748,7 +8746,6 @@ static void init_proc_POWER9(CPUPPCState *env)
>  #if !defined(CONFIG_USER_ONLY)
>      env->slb_nr = 32;
>  #endif
> -    env->ci_large_pages = true;
>      env->dcache_line_size = 128;
>      env->icache_line_size = 128;
>  
