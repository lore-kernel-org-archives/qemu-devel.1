Received: from eggs.gnu.org ([2001:4830:134:3::10]:58595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciTQa-0005bW-T4
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:05:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciTQZ-00029t-27
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:05:56 -0500
Date: Mon, 27 Feb 2017 17:22:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170227062235.GW17615@umbus.fritz.box>
References: <cover.1487829585.git.sam.bobroff@au1.ibm.com>
	<aee5e40fa506e88de7db0ba7b8fc8e431723a206.1487829585.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GSafuNNN4NHc9BES"
Content-Disposition: inline
In-Reply-To: <aee5e40fa506e88de7db0ba7b8fc8e431723a206.1487829585.git.sam.bobroff@au1.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 01/12] spapr: Small cleanup of PPC
 MMU enums
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, sjitindarsingh@gmail.com


--GSafuNNN4NHc9BES
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2017 at 04:59:54PM +1100, Sam Bobroff wrote:
> The PPC MMU types are sometimes treated as if they were a bit field
> and sometime as if they were an enum which causes maintenance
> problems: flipping bits in the MMU type (which is done on both the 1TB
> segment and 64K segment bits) currently produces new MMU type
> values that are not handled in every "switch" on it, sometimes causing
> an abort().
>=20
> This patch provides some macros that can be used to filter out the
> "bit field-like" bits so that the remainder of the value can be
> switched on, like an enum. This allows removal of all of the
> "degraded" types from the list and should ease maintenance.
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Seems like a good idea.

Reviewd-by: David Gibson <David@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c          |  8 +++---
>  target/ppc/cpu-qom.h    | 12 ++++-----
>  target/ppc/kvm.c        |  8 +++---
>  target/ppc/mmu-hash64.c | 10 ++++----
>  target/ppc/mmu_helper.c | 67 ++++++++++++++++++++-----------------------=
------
>  target/ppc/translate.c  | 12 ++++-----
>  6 files changed, 50 insertions(+), 67 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 5904e6498f..cceb35f083 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -359,14 +359,12 @@ static void spapr_populate_pa_features(CPUPPCState =
*env, void *fdt, int offset)
>      uint8_t *pa_features;
>      size_t pa_size;
> =20
> -    switch (env->mmu_model) {
> -    case POWERPC_MMU_2_06:
> -    case POWERPC_MMU_2_06a:
> +    switch (POWERPC_MMU_VER(env->mmu_model)) {
> +    case POWERPC_MMU_VER_2_06:
>          pa_features =3D pa_features_206;
>          pa_size =3D sizeof(pa_features_206);
>          break;
> -    case POWERPC_MMU_2_07:
> -    case POWERPC_MMU_2_07a:
> +    case POWERPC_MMU_VER_2_07:
>          pa_features =3D pa_features_207;
>          pa_size =3D sizeof(pa_features_207);
>          break;
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index 4e3132b56b..4807f4d86c 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -79,21 +79,21 @@ enum powerpc_mmu_t {
>      POWERPC_MMU_2_06       =3D POWERPC_MMU_64 | POWERPC_MMU_1TSEG
>                               | POWERPC_MMU_64K
>                               | POWERPC_MMU_AMR | 0x00000003,
> -    /* Architecture 2.06 "degraded" (no 1T segments)           */
> -    POWERPC_MMU_2_06a      =3D POWERPC_MMU_64 | POWERPC_MMU_AMR
> -                             | 0x00000003,
>      /* Architecture 2.07 variant                               */
>      POWERPC_MMU_2_07       =3D POWERPC_MMU_64 | POWERPC_MMU_1TSEG
>                               | POWERPC_MMU_64K
>                               | POWERPC_MMU_AMR | 0x00000004,
> -    /* Architecture 2.07 "degraded" (no 1T segments)           */
> -    POWERPC_MMU_2_07a      =3D POWERPC_MMU_64 | POWERPC_MMU_AMR
> -                             | 0x00000004,
>      /* Architecture 3.00 variant                               */
>      POWERPC_MMU_3_00       =3D POWERPC_MMU_64 | POWERPC_MMU_1TSEG
>                               | POWERPC_MMU_64K
>                               | POWERPC_MMU_AMR | 0x00000005,
>  };
> +#define POWERPC_MMU_VER(x) ((x) & (POWERPC_MMU_64 | 0xFFFF))
> +#define POWERPC_MMU_VER_64B POWERPC_MMU_VER(POWERPC_MMU_64B)
> +#define POWERPC_MMU_VER_2_03 POWERPC_MMU_VER(POWERPC_MMU_2_03)
> +#define POWERPC_MMU_VER_2_06 POWERPC_MMU_VER(POWERPC_MMU_2_06)
> +#define POWERPC_MMU_VER_2_07 POWERPC_MMU_VER(POWERPC_MMU_2_07)
> +#define POWERPC_MMU_VER_3_00 POWERPC_MMU_VER(POWERPC_MMU_3_00)
> =20
>  /***********************************************************************=
******/
>  /* Exception model                                                      =
     */
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 52bbea514a..d53ede8b4a 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -282,8 +282,8 @@ static void kvm_get_fallback_smmu_info(PowerPCCPU *cp=
u,
>              info->flags |=3D KVM_PPC_1T_SEGMENTS;
>          }
> =20
> -        if (env->mmu_model =3D=3D POWERPC_MMU_2_06 ||
> -            env->mmu_model =3D=3D POWERPC_MMU_2_07) {
> +        if (POWERPC_MMU_VER(env->mmu_model) =3D=3D POWERPC_MMU_VER_2_06 =
||
> +           POWERPC_MMU_VER(env->mmu_model) =3D=3D POWERPC_MMU_VER_2_07) {
>              info->slb_size =3D 32;
>          } else {
>              info->slb_size =3D 64;
> @@ -297,8 +297,8 @@ static void kvm_get_fallback_smmu_info(PowerPCCPU *cp=
u,
>          i++;
> =20
>          /* 64K on MMU 2.06 and later */
> -        if (env->mmu_model =3D=3D POWERPC_MMU_2_06 ||
> -            env->mmu_model =3D=3D POWERPC_MMU_2_07) {
> +        if (POWERPC_MMU_VER(env->mmu_model) =3D=3D POWERPC_MMU_VER_2_06 =
||
> +            POWERPC_MMU_VER(env->mmu_model) =3D=3D POWERPC_MMU_VER_2_07)=
 {
>              info->sps[i].page_shift =3D 16;
>              info->sps[i].slb_enc =3D 0x110;
>              info->sps[i].enc[0].page_shift =3D 16;
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 76669ed82c..6346167b48 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -1032,8 +1032,8 @@ void helper_store_lpcr(CPUPPCState *env, target_ulo=
ng val)
>      uint64_t lpcr =3D 0;
> =20
>      /* Filter out bits */
> -    switch (env->mmu_model) {
> -    case POWERPC_MMU_64B: /* 970 */
> +    switch (POWERPC_MMU_VER(env->mmu_model)) {
> +    case POWERPC_MMU_VER_64B: /* 970 */
>          if (val & 0x40) {
>              lpcr |=3D LPCR_LPES0;
>          }
> @@ -1059,19 +1059,19 @@ void helper_store_lpcr(CPUPPCState *env, target_u=
long val)
>           * to dig HRMOR out of HID5
>           */
>          break;
> -    case POWERPC_MMU_2_03: /* P5p */
> +    case POWERPC_MMU_VER_2_03: /* P5p */
>          lpcr =3D val & (LPCR_RMLS | LPCR_ILE |
>                        LPCR_LPES0 | LPCR_LPES1 |
>                        LPCR_RMI | LPCR_HDICE);
>          break;
> -    case POWERPC_MMU_2_06: /* P7 */
> +    case POWERPC_MMU_VER_2_06: /* P7 */
>          lpcr =3D val & (LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_DPFD |
>                        LPCR_VRMASD | LPCR_RMLS | LPCR_ILE |
>                        LPCR_P7_PECE0 | LPCR_P7_PECE1 | LPCR_P7_PECE2 |
>                        LPCR_MER | LPCR_TC |
>                        LPCR_LPES0 | LPCR_LPES1 | LPCR_HDICE);
>          break;
> -    case POWERPC_MMU_2_07: /* P8 */
> +    case POWERPC_MMU_VER_2_07: /* P8 */
>          lpcr =3D val & (LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_KBV |
>                        LPCR_DPFD | LPCR_VRMASD | LPCR_RMLS | LPCR_ILE |
>                        LPCR_AIL | LPCR_ONL | LPCR_P8_PECE0 | LPCR_P8_PECE=
1 |
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index eb2d482ef7..0f6016ff0d 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -1260,7 +1260,7 @@ static void mmu6xx_dump_mmu(FILE *f, fprintf_functi=
on cpu_fprintf,
> =20
>  void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUPPCState *env)
>  {
> -    switch (env->mmu_model) {
> +    switch (POWERPC_MMU_VER(env->mmu_model)) {
>      case POWERPC_MMU_BOOKE:
>          mmubooke_dump_mmu(f, cpu_fprintf, env);
>          break;
> @@ -1272,12 +1272,10 @@ void dump_mmu(FILE *f, fprintf_function cpu_fprin=
tf, CPUPPCState *env)
>          mmu6xx_dump_mmu(f, cpu_fprintf, env);
>          break;
>  #if defined(TARGET_PPC64)
> -    case POWERPC_MMU_64B:
> -    case POWERPC_MMU_2_03:
> -    case POWERPC_MMU_2_06:
> -    case POWERPC_MMU_2_06a:
> -    case POWERPC_MMU_2_07:
> -    case POWERPC_MMU_2_07a:
> +    case POWERPC_MMU_VER_64B:
> +    case POWERPC_MMU_VER_2_03:
> +    case POWERPC_MMU_VER_2_06:
> +    case POWERPC_MMU_VER_2_07:
>          dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
>          break;
>  #endif
> @@ -1412,14 +1410,12 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs, =
vaddr addr)
>      CPUPPCState *env =3D &cpu->env;
>      mmu_ctx_t ctx;
> =20
> -    switch (env->mmu_model) {
> +    switch (POWERPC_MMU_VER(env->mmu_model)) {
>  #if defined(TARGET_PPC64)
> -    case POWERPC_MMU_64B:
> -    case POWERPC_MMU_2_03:
> -    case POWERPC_MMU_2_06:
> -    case POWERPC_MMU_2_06a:
> -    case POWERPC_MMU_2_07:
> -    case POWERPC_MMU_2_07a:
> +    case POWERPC_MMU_VER_64B:
> +    case POWERPC_MMU_VER_2_03:
> +    case POWERPC_MMU_VER_2_06:
> +    case POWERPC_MMU_VER_2_07:
>          return ppc_hash64_get_phys_page_debug(cpu, addr);
>  #endif
> =20
> @@ -1904,6 +1900,12 @@ void ppc_tlb_invalidate_all(CPUPPCState *env)
>  {
>      PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> =20
> +#if defined(TARGET_PPC64)
> +    if (env->mmu_model & POWERPC_MMU_64) {
> +        env->tlb_need_flush =3D 0;
> +        tlb_flush(CPU(cpu));
> +    } else
> +#endif /* defined(TARGET_PPC64) */
>      switch (env->mmu_model) {
>      case POWERPC_MMU_SOFT_6xx:
>      case POWERPC_MMU_SOFT_74xx:
> @@ -1928,21 +1930,12 @@ void ppc_tlb_invalidate_all(CPUPPCState *env)
>          break;
>      case POWERPC_MMU_32B:
>      case POWERPC_MMU_601:
> -#if defined(TARGET_PPC64)
> -    case POWERPC_MMU_64B:
> -    case POWERPC_MMU_2_03:
> -    case POWERPC_MMU_2_06:
> -    case POWERPC_MMU_2_06a:
> -    case POWERPC_MMU_2_07:
> -    case POWERPC_MMU_2_07a:
> -    case POWERPC_MMU_3_00:
> -#endif /* defined(TARGET_PPC64) */
>          env->tlb_need_flush =3D 0;
>          tlb_flush(CPU(cpu));
>          break;
>      default:
>          /* XXX: TODO */
> -        cpu_abort(CPU(cpu), "Unknown MMU model %d\n", env->mmu_model);
> +        cpu_abort(CPU(cpu), "Unknown MMU model %x\n", env->mmu_model);
>          break;
>      }
>  }
> @@ -1951,6 +1944,16 @@ void ppc_tlb_invalidate_one(CPUPPCState *env, targ=
et_ulong addr)
>  {
>  #if !defined(FLUSH_ALL_TLBS)
>      addr &=3D TARGET_PAGE_MASK;
> +#if defined(TARGET_PPC64)
> +    if (env->mmu_model & POWERPC_MMU_64) {
> +        /* tlbie invalidate TLBs for all segments */
> +        /* XXX: given the fact that there are too many segments to inval=
idate,
> +         *      and we still don't have a tlb_flush_mask(env, n, mask) i=
n QEMU,
> +         *      we just invalidate all TLBs
> +         */
> +        env->tlb_need_flush |=3D TLB_NEED_LOCAL_FLUSH;
> +    } else
> +#endif /* defined(TARGET_PPC64) */
>      switch (env->mmu_model) {
>      case POWERPC_MMU_SOFT_6xx:
>      case POWERPC_MMU_SOFT_74xx:
> @@ -1968,22 +1971,6 @@ void ppc_tlb_invalidate_one(CPUPPCState *env, targ=
et_ulong addr)
>           */
>          env->tlb_need_flush |=3D TLB_NEED_LOCAL_FLUSH;
>          break;
> -#if defined(TARGET_PPC64)
> -    case POWERPC_MMU_64B:
> -    case POWERPC_MMU_2_03:
> -    case POWERPC_MMU_2_06:
> -    case POWERPC_MMU_2_06a:
> -    case POWERPC_MMU_2_07:
> -    case POWERPC_MMU_2_07a:
> -    case POWERPC_MMU_3_00:
> -        /* tlbie invalidate TLBs for all segments */
> -        /* XXX: given the fact that there are too many segments to inval=
idate,
> -         *      and we still don't have a tlb_flush_mask(env, n, mask) i=
n QEMU,
> -         *      we just invalidate all TLBs
> -         */
> -        env->tlb_need_flush |=3D TLB_NEED_LOCAL_FLUSH;
> -        break;
> -#endif /* defined(TARGET_PPC64) */
>      default:
>          /* Should never reach here with other MMU models */
>          assert(0);
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index b09e16ff76..2a24d1de67 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -6988,18 +6988,16 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fp=
rintf_function cpu_fprintf,
>      if (env->spr_cb[SPR_LPCR].name)
>          cpu_fprintf(f, " LPCR " TARGET_FMT_lx "\n", env->spr[SPR_LPCR]);
> =20
> -    switch (env->mmu_model) {
> +    switch (POWERPC_MMU_VER(env->mmu_model)) {
>      case POWERPC_MMU_32B:
>      case POWERPC_MMU_601:
>      case POWERPC_MMU_SOFT_6xx:
>      case POWERPC_MMU_SOFT_74xx:
>  #if defined(TARGET_PPC64)
> -    case POWERPC_MMU_64B:
> -    case POWERPC_MMU_2_03:
> -    case POWERPC_MMU_2_06:
> -    case POWERPC_MMU_2_06a:
> -    case POWERPC_MMU_2_07:
> -    case POWERPC_MMU_2_07a:
> +    case POWERPC_MMU_VER_64B:
> +    case POWERPC_MMU_VER_2_03:
> +    case POWERPC_MMU_VER_2_06:
> +    case POWERPC_MMU_VER_2_07:
>  #endif
>          cpu_fprintf(f, " SDR1 " TARGET_FMT_lx "   DAR " TARGET_FMT_lx
>                         "  DSISR " TARGET_FMT_lx "\n", env->spr[SPR_SDR1],

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GSafuNNN4NHc9BES
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYs8WoAAoJEGw4ysog2bOSYhkP/0DTiNC93JRsuhVnSVeBmszv
2WXArapcvzn5eSuIhO0bOZ8HS8ta/fS1eOMfNBSN8WFkhFbmv/q221SXpGoQuMFt
cxglP6NqdM3vld2PcskPRYIztVFw6xekRykcFxt8weXXgZEDO14A/8lRovkvV8JU
IfA0kD5i0o7YZM93fZAMxp49TWMx0nhkGLyvlI/VJI0bglCGJaBIHfKiBwMFSRes
C46LOQvi1fgy0q4cmelyC0qpOL17y7p1i+vSO0E3mOobZBc5clu5PnmHsYYSPHhG
ImPzG9Gs9iBWlu+TeDcAJOd4zsiUYN7YswDYiMwjSsOPQhHqK/DJ7EUG/TexNEf9
The+/GRvTP6ZdLxXIzHHcYLMC2Rt+buj+jVAHOpRMwN9NTHKJdOSqORQ9lXfqveb
CVou7GmFoJTklp1SzhkwAeZTUQUhk/xOWkmqtBwNtx2xsY1L5aNilXhab84m4SS4
h/OF4Xkz80CxDJmJrl3GjuK3iks7UhLeq23olHkT5b+qtEPRwG4BYXu87FXeN4la
1Byx3FiJpN7B3/bjShxVP06yuYJ3eauc71eA4UFmvUxxsKiOElnsGcZFfzpRhznX
DJI9B7AHAuHCf55ahBxNKyo/+bFIO7I5iIDHqKvRlVcCQl4dPoC/uuT4/TeODsF4
Q8Wb1180fASZlCYuqV3f
=nWvV
-----END PGP SIGNATURE-----

--GSafuNNN4NHc9BES--
