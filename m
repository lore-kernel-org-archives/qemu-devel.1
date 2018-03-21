Received: from eggs.gnu.org ([2001:4830:134:3::10]:43806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eyURX-0007s2-Ar
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 23:29:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eyURU-0005JT-4E
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 23:29:39 -0400
Date: Wed, 21 Mar 2018 14:19:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180321031935.GO3905@umbus.fritz.box>
References: <20180315133402.13470-1-clg@kaod.org>
	<20180315133402.13470-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Vy1A5eXR7jld12ZH"
Content-Disposition: inline
In-Reply-To: <20180315133402.13470-3-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v3 2/4] target/ppc: add basic support for
 PTCR on POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>


--Vy1A5eXR7jld12ZH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15, 2018 at 01:34:00PM +0000, C=E9dric Le Goater wrote:
> The Partition Table Control Register (PTCR) is a hypervisor privileged
> SPR. It contains the host real address of the Partition Table and its
> size.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
>  Changes since v2:
>=20
>  - added an assert on MMU model in ppc_store_ptcr()
>  - renamed s/ptas/patbsize/
> =20
>  Changes since v1:
>=20
>  - renamed partition table definitions to match ISA
>  - moved definitions under mmu-book3s-v3.h
>=20
>  target/ppc/cpu.h            |  2 ++
>  target/ppc/helper.h         |  1 +
>  target/ppc/misc_helper.c    | 12 ++++++++++++
>  target/ppc/mmu-book3s-v3.h  |  6 ++++++
>  target/ppc/mmu_helper.c     | 29 +++++++++++++++++++++++++++++
>  target/ppc/translate.c      |  3 +++
>  target/ppc/translate_init.c | 18 ++++++++++++++++++
>  7 files changed, 71 insertions(+)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 4de0653a3984..7e900cf86a5f 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1314,6 +1314,7 @@ int ppc_cpu_handle_mmu_fault(CPUState *cpu, vaddr a=
ddress, int size, int rw,
> =20
>  #if !defined(CONFIG_USER_ONLY)
>  void ppc_store_sdr1 (CPUPPCState *env, target_ulong value);
> +void ppc_store_ptcr(CPUPPCState *env, target_ulong value);
>  #endif /* !defined(CONFIG_USER_ONLY) */
>  void ppc_store_msr (CPUPPCState *env, target_ulong value);
> =20
> @@ -1605,6 +1606,7 @@ void ppc_compat_add_property(Object *obj, const cha=
r *name,
>  #define SPR_BOOKE_GIVOR13     (0x1BC)
>  #define SPR_BOOKE_GIVOR14     (0x1BD)
>  #define SPR_TIR               (0x1BE)
> +#define SPR_PTCR              (0x1D0)
>  #define SPR_BOOKE_SPEFSCR     (0x200)
>  #define SPR_Exxx_BBEAR        (0x201)
>  #define SPR_Exxx_BBTAR        (0x202)
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 5b739179b8b5..19453c68138a 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -709,6 +709,7 @@ DEF_HELPER_FLAGS_1(load_601_rtcu, TCG_CALL_NO_RWG, tl=
, env)
>  #if !defined(CONFIG_USER_ONLY)
>  #if defined(TARGET_PPC64)
>  DEF_HELPER_FLAGS_1(load_purr, TCG_CALL_NO_RWG, tl, env)
> +DEF_HELPER_2(store_ptcr, void, env, tl)
>  #endif
>  DEF_HELPER_2(store_sdr1, void, env, tl)
>  DEF_HELPER_2(store_pidr, void, env, tl)
> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> index 0e4217821b8e..8c8cba5cc6f1 100644
> --- a/target/ppc/misc_helper.c
> +++ b/target/ppc/misc_helper.c
> @@ -88,6 +88,18 @@ void helper_store_sdr1(CPUPPCState *env, target_ulong =
val)
>      }
>  }
> =20
> +#if defined(TARGET_PPC64)
> +void helper_store_ptcr(CPUPPCState *env, target_ulong val)
> +{
> +    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> +
> +    if (env->spr[SPR_PTCR] !=3D val) {
> +        ppc_store_ptcr(env, val);
> +        tlb_flush(CPU(cpu));
> +    }
> +}
> +#endif /* defined(TARGET_PPC64) */
> +
>  void helper_store_pidr(CPUPPCState *env, target_ulong val)
>  {
>      PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
> index 56095dab522c..fdf80987d7b2 100644
> --- a/target/ppc/mmu-book3s-v3.h
> +++ b/target/ppc/mmu-book3s-v3.h
> @@ -22,6 +22,12 @@
> =20
>  #ifndef CONFIG_USER_ONLY
> =20
> +/*
> + * Partition table definitions
> + */
> +#define PTCR_PATB               0x0FFFFFFFFFFFF000ULL /* Partition Table=
 Base */
> +#define PTCR_PATS               0x000000000000001FULL /* Partition Table=
 Size */
> +
>  /* Partition Table Entry Fields */
>  #define PATBE1_GR 0x8000000000000000
> =20
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index 5568d1642b34..03009eee723a 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -2028,6 +2028,35 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulong=
 value)
>      env->spr[SPR_SDR1] =3D value;
>  }
> =20
> +#if defined(TARGET_PPC64)
> +void ppc_store_ptcr(CPUPPCState *env, target_ulong value)
> +{
> +    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> +    target_ulong ptcr_mask =3D PTCR_PATB | PTCR_PATS;
> +    target_ulong patbsize =3D value & PTCR_PATS;
> +
> +    qemu_log_mask(CPU_LOG_MMU, "%s: " TARGET_FMT_lx "\n", __func__, valu=
e);
> +
> +    assert(!cpu->vhyp);
> +    assert(env->mmu_model & POWERPC_MMU_V3);
> +
> +    if (value & ~ptcr_mask) {
> +        error_report("Invalid bits 0x"TARGET_FMT_lx" set in PTCR",
> +                     value & ~ptcr_mask);
> +        value &=3D ptcr_mask;
> +    }
> +
> +    if (patbsize > 24) {
> +        error_report("Invalid Partition Table size 0x" TARGET_FMT_lx
> +                     " stored in PTCR", patbsize);
> +        return;
> +    }
> +
> +    env->spr[SPR_PTCR] =3D value;
> +}
> +
> +#endif /* defined(TARGET_PPC64) */
> +
>  /* Segment registers load and store */
>  target_ulong helper_load_sr(CPUPPCState *env, target_ulong sr_num)
>  {
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 218665b4080b..172fbf35ae53 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -7136,6 +7136,9 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fpri=
ntf_function cpu_fprintf,
>          if (env->spr_cb[SPR_SDR1].name) { /* SDR1 Exists */
>              cpu_fprintf(f, " SDR1 " TARGET_FMT_lx " ", env->spr[SPR_SDR1=
]);
>          }
> +        if (env->spr_cb[SPR_PTCR].name) { /* PTCR Exists */
> +            cpu_fprintf(f, " PTCR " TARGET_FMT_lx " ", env->spr[SPR_PTCR=
]);
> +        }
>          cpu_fprintf(f, "  DAR " TARGET_FMT_lx "  DSISR " TARGET_FMT_lx "=
\n",
>                      env->spr[SPR_DAR], env->spr[SPR_DSISR]);
>          break;
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 391b94b97daa..e53cc8dfd188 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -420,6 +420,11 @@ static void spr_write_hior(DisasContext *ctx, int sp=
rn, int gprn)
>      tcg_gen_st_tl(t0, cpu_env, offsetof(CPUPPCState, excp_prefix));
>      tcg_temp_free(t0);
>  }
> +static void spr_write_ptcr(DisasContext *ctx, int sprn, int gprn)
> +{
> +    gen_helper_store_ptcr(cpu_env, cpu_gpr[gprn]);
> +}
> +
>  #endif
>  #endif
> =20
> @@ -8167,6 +8172,18 @@ static void gen_spr_power8_rpr(CPUPPCState *env)
>  #endif
>  }
> =20
> +static void gen_spr_power9_mmu(CPUPPCState *env)
> +{
> +#if !defined(CONFIG_USER_ONLY)
> +    /* Partition Table Control */
> +    spr_register_hv(env, SPR_PTCR, "PTCR",
> +                    SPR_NOACCESS, SPR_NOACCESS,
> +                    SPR_NOACCESS, SPR_NOACCESS,
> +                    &spr_read_generic, &spr_write_ptcr,
> +                    0x00000000);
> +#endif
> +}
> +
>  static void init_proc_book3s_common(CPUPPCState *env)
>  {
>      gen_spr_ne_601(env);
> @@ -8761,6 +8778,7 @@ static void init_proc_POWER9(CPUPPCState *env)
>      gen_spr_power8_ic(env);
>      gen_spr_power8_book4(env);
>      gen_spr_power8_rpr(env);
> +    gen_spr_power9_mmu(env);
> =20
>      /* POWER9 Specific registers */
>      spr_register_kvm(env, SPR_TIDR, "TIDR", NULL, NULL,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Vy1A5eXR7jld12ZH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqxz0cACgkQbDjKyiDZ
s5JxjhAAn678581dvMqEHI4L8JYoN3tDlweOwS7ZarI72iHML8W5EGmxgCprteYA
r69mDSIEB9HkDu/YrWnf7nV31ZI4slMpNEBweLAkKg9BzWdV35HYeqsROx3qDXXQ
X2QRxy0X7PBJ2lWC53TjIIIdCNMM72kJRRmFDsPQQZm9QFNPslHFinXhRgHCl0n+
r5MDXN3NC3JQY1mmU5nw7ErpRyb0Lr9DnHD3vCvVRQMeeT65dwdOmR5uj6Wfgdiz
EhYe/jkYxthOW0yKiHzkOQsyMTiH62/6jzj1EugHjlb46cxbB5zQ+sZIr5AYaO0s
qsXAvrIpc3Chqfiu14qjGYxABrri0YVuWwTUkxGM/0hL6hr3T0F/ckuvjjM27taK
fNmv8DMjYOPeLAdHOTPuzFhTO4QwluIhtzGeMRyWFlIF1ISdML2vgPlKlqMm+mvT
3o+1nPnAhR5uEwQtAEmkm2POLewGij1eAeugXKInlZuFGYzZgCWy2PJUUlLi/Bt8
3Q77cwDYZ8UP4TsaG+ML3zbKH++rvJYP1JDviY8dssSOW55oyhiuCxq5VjXtYurk
rNnRd2w5/QrIo8Y9WOMzvXpQEHHrM9/oAR54oemjxGRcCpjkdyJmh+4nC3VJLoEm
VCr7HXQMEb9KEZFOzFkgNRyLBmmlW9XcSqK+7MQVPgtiE/hRB3U=
=H5QB
-----END PGP SIGNATURE-----

--Vy1A5eXR7jld12ZH--
