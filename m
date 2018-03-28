Received: from eggs.gnu.org ([2001:4830:134:3::10]:60083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f17Mx-0004Ub-IK
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f17Mt-000551-E7
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:27:47 -0400
Received: from 7.mo177.mail-out.ovh.net ([46.105.61.149]:41034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f17Mt-000548-3h
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:27:43 -0400
Received: from player794.ha.ovh.net (unknown [10.109.120.50])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 94C48A5D46
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 11:27:41 +0200 (CEST)
Date: Wed, 28 Mar 2018 11:26:41 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180328112641.25162c66@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20180327043741.7705-13-david@gibson.dropbear.id.au>
References: <20180327043741.7705-1-david@gibson.dropbear.id.au>
	<20180327043741.7705-13-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC for-2.13 12/12] target/ppc: Get rid of
 POWERPC_MMU_VER() macros
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

On Tue, 27 Mar 2018 15:37:41 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> These macros were introduced to deal with the fact that the mmu_model
> field has bit flags mixed in with what's otherwise an enum of various mmu
> types.
> 
> We've now eliminated all those flags except for one, and that one -
> POWERPC_MMU_64 - is already included/compared in the MMU_VER macros.  So,
> we can get rid of those macros and just directly compare mmu_model values
> in the places it was used.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  target/ppc/cpu-qom.h    |  6 ------
>  target/ppc/kvm.c        |  8 ++++----
>  target/ppc/mmu-hash64.c | 12 ++++++------
>  target/ppc/mmu_helper.c | 24 ++++++++++++------------
>  target/ppc/translate.c  | 12 ++++++------
>  5 files changed, 28 insertions(+), 34 deletions(-)
> 
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index ef96d42cf2..433a71e484 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -79,12 +79,6 @@ enum powerpc_mmu_t {
>      /* Architecture 3.00 variant                               */
>      POWERPC_MMU_3_00       = POWERPC_MMU_64 | 0x00000005,
>  };
> -#define POWERPC_MMU_VER(x) ((x) & (POWERPC_MMU_64 | 0xFFFF))
> -#define POWERPC_MMU_VER_64B POWERPC_MMU_VER(POWERPC_MMU_64B)
> -#define POWERPC_MMU_VER_2_03 POWERPC_MMU_VER(POWERPC_MMU_2_03)
> -#define POWERPC_MMU_VER_2_06 POWERPC_MMU_VER(POWERPC_MMU_2_06)
> -#define POWERPC_MMU_VER_2_07 POWERPC_MMU_VER(POWERPC_MMU_2_07)
> -#define POWERPC_MMU_VER_3_00 POWERPC_MMU_VER(POWERPC_MMU_3_00)
>  
>  /*****************************************************************************/
>  /* Exception model                                                           */
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 6c45815ee6..9f3f567dda 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -306,8 +306,8 @@ static void kvm_get_fallback_smmu_info(PowerPCCPU *cpu,
>              info->flags |= KVM_PPC_1T_SEGMENTS;
>          }
>  
> -        if (POWERPC_MMU_VER(env->mmu_model) == POWERPC_MMU_VER_2_06 ||
> -           POWERPC_MMU_VER(env->mmu_model) == POWERPC_MMU_VER_2_07) {
> +        if (env->mmu_model == POWERPC_MMU_2_06 ||
> +            env->mmu_model == POWERPC_MMU_2_07) {
>              info->slb_size = 32;
>          } else {
>              info->slb_size = 64;
> @@ -321,8 +321,8 @@ static void kvm_get_fallback_smmu_info(PowerPCCPU *cpu,
>          i++;
>  
>          /* 64K on MMU 2.06 and later */
> -        if (POWERPC_MMU_VER(env->mmu_model) == POWERPC_MMU_VER_2_06 ||
> -            POWERPC_MMU_VER(env->mmu_model) == POWERPC_MMU_VER_2_07) {
> +        if (env->mmu_model == POWERPC_MMU_2_06 ||
> +            env->mmu_model == POWERPC_MMU_2_07) {
>              info->sps[i].page_shift = 16;
>              info->sps[i].slb_enc = 0x110;
>              info->sps[i].enc[0].page_shift = 16;
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index d964f2f5b0..3514995e16 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -1033,8 +1033,8 @@ void helper_store_lpcr(CPUPPCState *env, target_ulong val)
>      uint64_t lpcr = 0;
>  
>      /* Filter out bits */
> -    switch (POWERPC_MMU_VER(env->mmu_model)) {
> -    case POWERPC_MMU_VER_64B: /* 970 */
> +    switch (env->mmu_model) {
> +    case POWERPC_MMU_64B: /* 970 */
>          if (val & 0x40) {
>              lpcr |= LPCR_LPES0;
>          }
> @@ -1060,26 +1060,26 @@ void helper_store_lpcr(CPUPPCState *env, target_ulong val)
>           * to dig HRMOR out of HID5
>           */
>          break;
> -    case POWERPC_MMU_VER_2_03: /* P5p */
> +    case POWERPC_MMU_2_03: /* P5p */
>          lpcr = val & (LPCR_RMLS | LPCR_ILE |
>                        LPCR_LPES0 | LPCR_LPES1 |
>                        LPCR_RMI | LPCR_HDICE);
>          break;
> -    case POWERPC_MMU_VER_2_06: /* P7 */
> +    case POWERPC_MMU_2_06: /* P7 */
>          lpcr = val & (LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_DPFD |
>                        LPCR_VRMASD | LPCR_RMLS | LPCR_ILE |
>                        LPCR_P7_PECE0 | LPCR_P7_PECE1 | LPCR_P7_PECE2 |
>                        LPCR_MER | LPCR_TC |
>                        LPCR_LPES0 | LPCR_LPES1 | LPCR_HDICE);
>          break;
> -    case POWERPC_MMU_VER_2_07: /* P8 */
> +    case POWERPC_MMU_2_07: /* P8 */
>          lpcr = val & (LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_KBV |
>                        LPCR_DPFD | LPCR_VRMASD | LPCR_RMLS | LPCR_ILE |
>                        LPCR_AIL | LPCR_ONL | LPCR_P8_PECE0 | LPCR_P8_PECE1 |
>                        LPCR_P8_PECE2 | LPCR_P8_PECE3 | LPCR_P8_PECE4 |
>                        LPCR_MER | LPCR_TC | LPCR_LPES0 | LPCR_HDICE);
>          break;
> -    case POWERPC_MMU_VER_3_00: /* P9 */
> +    case POWERPC_MMU_3_00: /* P9 */
>          lpcr = val & (LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |
>                        (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_AIL |
>                        LPCR_UPRT | LPCR_EVIRT | LPCR_ONL |
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index 5568d1642b..8075b7149a 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -1266,7 +1266,7 @@ static void mmu6xx_dump_mmu(FILE *f, fprintf_function cpu_fprintf,
>  
>  void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUPPCState *env)
>  {
> -    switch (POWERPC_MMU_VER(env->mmu_model)) {
> +    switch (env->mmu_model) {
>      case POWERPC_MMU_BOOKE:
>          mmubooke_dump_mmu(f, cpu_fprintf, env);
>          break;
> @@ -1278,13 +1278,13 @@ void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUPPCState *env)
>          mmu6xx_dump_mmu(f, cpu_fprintf, env);
>          break;
>  #if defined(TARGET_PPC64)
> -    case POWERPC_MMU_VER_64B:
> -    case POWERPC_MMU_VER_2_03:
> -    case POWERPC_MMU_VER_2_06:
> -    case POWERPC_MMU_VER_2_07:
> +    case POWERPC_MMU_64B:
> +    case POWERPC_MMU_2_03:
> +    case POWERPC_MMU_2_06:
> +    case POWERPC_MMU_2_07:
>          dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
>          break;
> -    case POWERPC_MMU_VER_3_00:
> +    case POWERPC_MMU_3_00:
>          if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
>              /* TODO - Unsupported */
>          } else {
> @@ -1423,14 +1423,14 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>      CPUPPCState *env = &cpu->env;
>      mmu_ctx_t ctx;
>  
> -    switch (POWERPC_MMU_VER(env->mmu_model)) {
> +    switch (env->mmu_model) {
>  #if defined(TARGET_PPC64)
> -    case POWERPC_MMU_VER_64B:
> -    case POWERPC_MMU_VER_2_03:
> -    case POWERPC_MMU_VER_2_06:
> -    case POWERPC_MMU_VER_2_07:
> +    case POWERPC_MMU_64B:
> +    case POWERPC_MMU_2_03:
> +    case POWERPC_MMU_2_06:
> +    case POWERPC_MMU_2_07:
>          return ppc_hash64_get_phys_page_debug(cpu, addr);
> -    case POWERPC_MMU_VER_3_00:
> +    case POWERPC_MMU_3_00:
>          if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
>              return ppc_radix64_get_phys_page_debug(cpu, addr);
>          } else {
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 3457d29f8e..22ac7caa04 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -7121,17 +7121,17 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
>      if (env->spr_cb[SPR_LPCR].name)
>          cpu_fprintf(f, " LPCR " TARGET_FMT_lx "\n", env->spr[SPR_LPCR]);
>  
> -    switch (POWERPC_MMU_VER(env->mmu_model)) {
> +    switch (env->mmu_model) {
>      case POWERPC_MMU_32B:
>      case POWERPC_MMU_601:
>      case POWERPC_MMU_SOFT_6xx:
>      case POWERPC_MMU_SOFT_74xx:
>  #if defined(TARGET_PPC64)
> -    case POWERPC_MMU_VER_64B:
> -    case POWERPC_MMU_VER_2_03:
> -    case POWERPC_MMU_VER_2_06:
> -    case POWERPC_MMU_VER_2_07:
> -    case POWERPC_MMU_VER_3_00:
> +    case POWERPC_MMU_64B:
> +    case POWERPC_MMU_2_03:
> +    case POWERPC_MMU_2_06:
> +    case POWERPC_MMU_2_07:
> +    case POWERPC_MMU_3_00:
>  #endif
>          if (env->spr_cb[SPR_SDR1].name) { /* SDR1 Exists */
>              cpu_fprintf(f, " SDR1 " TARGET_FMT_lx " ", env->spr[SPR_SDR1]);
