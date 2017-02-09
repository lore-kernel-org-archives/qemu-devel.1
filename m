Received: from eggs.gnu.org ([2001:4830:134:3::10]:46746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbepp-0007cR-Ak
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbepn-0006y0-Cq
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:51:49 -0500
Date: Thu, 9 Feb 2017 13:49:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170209024945.GW17644@umbus.fritz.box>
References: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
	<02c42ec7c0d07633c974e2ecd30054cc82e3d1c6.1486436186.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ulNsWUvGrZAj8PMr"
Content-Disposition: inline
In-Reply-To: <02c42ec7c0d07633c974e2ecd30054cc82e3d1c6.1486436186.git.sam.bobroff@au1.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 9/9] spapr: Small cleanup of PPC MMU
 enums
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--ulNsWUvGrZAj8PMr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 01:56:52PM +1100, Sam Bobroff wrote:
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

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

This looks like a good fix independent of the POWER9 stuff.  Can you
move this to the front of the series (which will require fixing some
rebase conflicts) so I can apply it without waiting on the rest?

> ---
>  hw/ppc/spapr.c          | 10 +++-----
>  target/ppc/cpu-qom.h    | 12 ++++-----
>  target/ppc/kvm.c        |  8 +++---
>  target/ppc/mmu-hash64.c | 10 ++++----
>  target/ppc/mmu_helper.c | 67 ++++++++++++++++++++-----------------------=
------
>  target/ppc/translate.c  | 12 ++++-----
>  6 files changed, 51 insertions(+), 68 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 325a9c587b..f9de02759a 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -222,18 +222,16 @@ static int spapr_populate_pa_features(CPUPPCState *=
env, void *fdt, int offset,
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
> -    case POWERPC_MMU_3_00:
> +    case POWERPC_MMU_VER_3_00:
>          pa_features =3D pa_features_300;
>          pa_size =3D sizeof(pa_features_300);
>          break;
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index 1577cc8224..8ea055c18d 100644
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
> index 0d1443616c..1687d8e47e 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -285,8 +285,8 @@ static void kvm_get_fallback_smmu_info(PowerPCCPU *cp=
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
> @@ -300,8 +300,8 @@ static void kvm_get_fallback_smmu_info(PowerPCCPU *cp=
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
> index 0efc8c63fa..7f0b7b3df5 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -1004,8 +1004,8 @@ void helper_store_lpcr(CPUPPCState *env, target_ulo=
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
> @@ -1031,19 +1031,19 @@ void helper_store_lpcr(CPUPPCState *env, target_u=
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
> index 172a305e0f..e65e4d337f 100644
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
> index 121218087f..1edf3f2133 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -6910,18 +6910,16 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fp=
rintf_function cpu_fprintf,
>      }
>  #endif
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

--ulNsWUvGrZAj8PMr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYm9jIAAoJEGw4ysog2bOSG0cQAMCNA5YFOfyCZOTRbjUBqY/u
QIlbZXmQdtP20SyA2b+MSGYCxhIiGGXpXxwGkVWRPCcUN/lvsrepgL0YaqkjVxdi
SQpsSb+/CAHsq/89e8fWQ0efzk608TeM6v9rumuE2fJOerBy/4ZC1ohRjM3QR1cX
m6Qkwuyh9sOhpXQLfqFWTvamEt4aqPD2xs7NX9eH/RlM4bKtwWB8B1Yl7u6zytx5
EDoyu0dHB2Wiz1JruJ6X2/vBM+81PeeKqXQy6HtNfyb+9QppiIVXSs8up292vh4y
GGXgo7SiryjHBEuLQ+yGMawjR2zZfAMD1KZwvqVGO/cRqAYcenGCjXvLriSFiac5
DiGd+FIZnY70h39SGKIhs3B/VAZLA6R/bi9yNgE7dIJPGNdpDm48W8BG8CFy+xFS
r+BQJV5OFm2eMLbn8GPxplmgLbyFAVXf2k/bbti8l5UAas4l/fbc21BAM1IhaZHC
5zCVaMFhgPN9+0VcoBJf28a7dahiO0/z0kusOOVEHgOt1cK47mmRPFv3gKq87FYg
rjQtk2EzCO8VM8zGFt338XQ4VF8oUyLtQs4evvjFMukAZA1/6R1NEPJODfC8UVnM
SXhU+v6uNnc4YCbre1uG2n4UtceL/ZYoVEUTlW2V3rnNCOislouYmM5ncDn5lp/Z
VdK5BmW9c6qhGM+6+esY
=9DlB
-----END PGP SIGNATURE-----

--ulNsWUvGrZAj8PMr--
