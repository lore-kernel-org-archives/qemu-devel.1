Received: from eggs.gnu.org ([2001:4830:134:3::10]:50967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgkXg-0006ZO-Jg
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:58:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgkXd-0001Tv-SP
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:58:08 -0500
Date: Thu, 23 Feb 2017 14:57:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170223035753.GL12577@umbus.fritz.box>
References: <1487563478-22265-1-git-send-email-sjitindarsingh@gmail.com>
	<1487563478-22265-7-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GviraxgP0A7vmYdC"
Content-Disposition: inline
In-Reply-To: <1487563478-22265-7-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V3 06/10] target/ppc: Don't gen
 an SDR1 on POWER9 and rework register creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org, sam.bobroff@au1.ibm.com


--GviraxgP0A7vmYdC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:04:34PM +1100, Suraj Jitindar Singh wrote:
> POWER9 doesn't have a storage description register 1 (SDR1) which is used
> to store the base and size of the hash table. Thus we don't need to
> generate this register on the POWER9 cpu model and thus shouldn't read or
> write to it either. While we're here, init_proc_book3s_64 is a convoluted
> mess which attempts to be a generic function which will then call cpu mod=
el
> specific register gen functions, but we're calling it from a cpu model
> specific function (pcc->init_proc) anyway. So instead of going from
> cpu specific function -> generic function -> cpu specific functions, why
> not just call the cpu specific register gen functions directly from the
> cpu specific init_proc() function removing the need for init_proc_book3s_=
64
> function altogether and hopefully clarifying the cpu model specific
> register generation.
>=20
> We rename ppc_hash64_set_sdr1->ppc_hash64_store_hpt to better represent
> that the generic use of the function is to set the htab_[mask/base] and
> sdr1 only if appropriate, and update call sites accordingly.

This should become obsolete once rebased on my hpt-cleanup series -
set_sdr1() shouldn't be called on pseries any more.

> We update ppc_cpu_dump_state so that "info registers" will only display
> the value of sdr1 if the register has been generated.
>=20
> Finally, as mentioned above the register generation for the pcc->init_proc
> function for 970, POWER5+, POWER7, POWER8 and POWER9 has been reworked
> for improved clarity. Instead of calling init_proc_book3s_64 which then
> attempts to generate the correct registers through a mess of if
> statements, we remove this function and instead call the appropriate
> register generation functions directly. This follows the register
> generation model followed for earlier cpu models (pre-970) whereby cpu
> specific registers are generated directly in the init_proc function
> and makes it easier to add/remove specific registers for new cpu models.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

I wholeheartedly endorse the re-organization of the SPR construction.
As noted above it will need a little rework for rebasing, but apart
=66rom that.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

>=20
> ---
>=20
> V2->V3:
> - Add rework of register generation
> ---
>  target/ppc/mmu-hash64.c     |  17 ++-
>  target/ppc/mmu-hash64.h     |   4 +-
>  target/ppc/mmu_helper.c     |   2 +-
>  target/ppc/translate.c      |   7 +-
>  target/ppc/translate_init.c | 316 +++++++++++++++++++++++++++-----------=
------
>  5 files changed, 218 insertions(+), 128 deletions(-)
>=20
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 7c5d589..3e17a9f 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -285,13 +285,12 @@ target_ulong helper_load_slb_vsid(CPUPPCState *env,=
 target_ulong rb)
>  /*
>   * 64-bit hash table MMU handling
>   */
> -void ppc_hash64_set_sdr1(PowerPCCPU *cpu, target_ulong value,
> -                         Error **errp)
> +void ppc_hash64_store_hpt(PowerPCCPU *cpu, target_ulong value,
> +                          Error **errp)
>  {
>      CPUPPCState *env =3D &cpu->env;
>      target_ulong htabsize =3D value & SDR_64_HTABSIZE;
> =20
> -    env->spr[SPR_SDR1] =3D value;
>      if (htabsize > 28) {
>          error_setg(errp,
>                     "Invalid HTABSIZE 0x" TARGET_FMT_lx" stored in SDR1",
> @@ -300,6 +299,14 @@ void ppc_hash64_set_sdr1(PowerPCCPU *cpu, target_ulo=
ng value,
>      }
>      env->htab_mask =3D (1ULL << (htabsize + 18 - 7)) - 1;
>      env->htab_base =3D value & SDR_64_HTABORG;
> +
> +    switch (env->mmu_model) {
> +    case POWERPC_MMU_3_00:
> +        break; /* Power 9 doesn't have an SDR1 */
> +    default:
> +        env->spr[SPR_SDR1] =3D value;
> +        break;
> +    }
>  }
> =20
>  void ppc_hash64_set_external_hpt(PowerPCCPU *cpu, void *hpt, int shift,
> @@ -313,8 +320,8 @@ void ppc_hash64_set_external_hpt(PowerPCCPU *cpu, voi=
d *hpt, int shift,
>      } else {
>          env->external_htab =3D MMU_HASH64_KVM_MANAGED_HPT;
>      }
> -    ppc_hash64_set_sdr1(cpu, (target_ulong)(uintptr_t)hpt | (shift - 18),
> -                        &local_err);
> +    ppc_hash64_store_hpt(cpu, (target_ulong)(uintptr_t)hpt | (shift - 18=
),
> +                         &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
> index 7a0b7fc..2c00bce 100644
> --- a/target/ppc/mmu-hash64.h
> +++ b/target/ppc/mmu-hash64.h
> @@ -91,8 +91,8 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
>  #define HPTE64_V_1TB_SEG        0x4000000000000000ULL
>  #define HPTE64_V_VRMA_MASK      0x4001ffffff000000ULL
> =20
> -void ppc_hash64_set_sdr1(PowerPCCPU *cpu, target_ulong value,
> -                         Error **errp);
> +void ppc_hash64_store_hpt(PowerPCCPU *cpu, target_ulong value,
> +                          Error **errp);
>  void ppc_hash64_set_external_hpt(PowerPCCPU *cpu, void *hpt, int shift,
>                                   Error **errp);
> =20
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index 172a305..2911266 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -2005,7 +2005,7 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulong =
value)
>          PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
>          Error *local_err =3D NULL;
> =20
> -        ppc_hash64_set_sdr1(cpu, value, &local_err);
> +        ppc_hash64_store_hpt(cpu, value, &local_err);
>          if (local_err) {
>              error_report_err(local_err);
>              error_free(local_err);
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index b48abae..473a40a 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -6850,9 +6850,12 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fpr=
intf_function cpu_fprintf,
>      case POWERPC_MMU_2_06a:
>      case POWERPC_MMU_2_07:
>      case POWERPC_MMU_2_07a:
> +    case POWERPC_MMU_3_00:
>  #endif
> -        cpu_fprintf(f, " SDR1 " TARGET_FMT_lx "   DAR " TARGET_FMT_lx
> -                       "  DSISR " TARGET_FMT_lx "\n", env->spr[SPR_SDR1],
> +        if (env->spr_cb[SPR_SDR1].name) {
> +            cpu_fprintf(f, " SDR1 " TARGET_FMT_lx " ", env->spr[SPR_SDR1=
]);
> +        }
> +        cpu_fprintf(f, "  DAR " TARGET_FMT_lx "  DSISR " TARGET_FMT_lx "=
\n",
>                      env->spr[SPR_DAR], env->spr[SPR_DSISR]);
>          break;
>      case POWERPC_MMU_BOOKE206:
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index be35cbd..32c1619 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -723,7 +723,7 @@ static void gen_spr_generic (CPUPPCState *env)
>  }
> =20
>  /* SPR common to all non-embedded PowerPC, including 601 */
> -static void gen_spr_ne_601 (CPUPPCState *env)
> +static void gen_spr_ne_601(CPUPPCState *env)
>  {
>      /* Exception processing */
>      spr_register_kvm(env, SPR_DSISR, "DSISR",
> @@ -739,7 +739,11 @@ static void gen_spr_ne_601 (CPUPPCState *env)
>                   SPR_NOACCESS, SPR_NOACCESS,
>                   &spr_read_decr, &spr_write_decr,
>                   0x00000000);
> -    /* Memory management */
> +}
> +
> +/* Storage Description Register 1 */
> +static void gen_spr_sdr1(CPUPPCState *env)
> +{
>      spr_register(env, SPR_SDR1, "SDR1",
>                   SPR_NOACCESS, SPR_NOACCESS,
>                   &spr_read_generic, &spr_write_sdr1,
> @@ -1168,7 +1172,7 @@ static void spr_write_iamr(DisasContext *ctx, int s=
prn, int gprn)
>  }
>  #endif /* CONFIG_USER_ONLY */
> =20
> -static void gen_spr_amr(CPUPPCState *env, bool has_iamr)
> +static void gen_spr_amr(CPUPPCState *env)
>  {
>  #ifndef CONFIG_USER_ONLY
>      /* Virtual Page Class Key protection */
> @@ -1194,13 +1198,17 @@ static void gen_spr_amr(CPUPPCState *env, bool ha=
s_iamr)
>                      SPR_NOACCESS, SPR_NOACCESS,
>                      &spr_read_generic, &spr_write_generic,
>                      0);
> -    if (has_iamr) {
> -        spr_register_kvm_hv(env, SPR_IAMR, "IAMR",
> -                            SPR_NOACCESS, SPR_NOACCESS,
> -                            &spr_read_generic, &spr_write_iamr,
> -                            &spr_read_generic, &spr_write_generic,
> -                            KVM_REG_PPC_IAMR, 0);
> -    }
> +#endif /* !CONFIG_USER_ONLY */
> +}
> +
> +static void gen_spr_iamr(CPUPPCState *env)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    spr_register_kvm_hv(env, SPR_IAMR, "IAMR",
> +                        SPR_NOACCESS, SPR_NOACCESS,
> +                        &spr_read_generic, &spr_write_iamr,
> +                        &spr_read_generic, &spr_write_generic,
> +                        KVM_REG_PPC_IAMR, 0);
>  #endif /* !CONFIG_USER_ONLY */
>  }
>  #endif /* TARGET_PPC64 */
> @@ -4410,6 +4418,7 @@ POWERPC_FAMILY(MPC8xx)(ObjectClass *oc, void *data)
>  static void init_proc_G2 (CPUPPCState *env)
>  {
>      gen_spr_ne_601(env);
> +    gen_spr_sdr1(env);
>      gen_spr_G2_755(env);
>      gen_spr_G2(env);
>      /* Time base */
> @@ -4488,6 +4497,7 @@ POWERPC_FAMILY(G2)(ObjectClass *oc, void *data)
>  static void init_proc_G2LE (CPUPPCState *env)
>  {
>      gen_spr_ne_601(env);
> +    gen_spr_sdr1(env);
>      gen_spr_G2_755(env);
>      gen_spr_G2(env);
>      /* Time base */
> @@ -4723,6 +4733,7 @@ POWERPC_FAMILY(e200)(ObjectClass *oc, void *data)
>  static void init_proc_e300 (CPUPPCState *env)
>  {
>      gen_spr_ne_601(env);
> +    gen_spr_sdr1(env);
>      gen_spr_603(env);
>      /* Time base */
>      gen_tbl(env);
> @@ -5222,6 +5233,7 @@ POWERPC_FAMILY(e5500)(ObjectClass *oc, void *data)
>  static void init_proc_601 (CPUPPCState *env)
>  {
>      gen_spr_ne_601(env);
> +    gen_spr_sdr1(env);
>      gen_spr_601(env);
>      /* Hardware implementation registers */
>      /* XXX : not implemented */
> @@ -5336,6 +5348,7 @@ POWERPC_FAMILY(601v)(ObjectClass *oc, void *data)
>  static void init_proc_602 (CPUPPCState *env)
>  {
>      gen_spr_ne_601(env);
> +    gen_spr_sdr1(env);
>      gen_spr_602(env);
>      /* Time base */
>      gen_tbl(env);
> @@ -5405,6 +5418,7 @@ POWERPC_FAMILY(602)(ObjectClass *oc, void *data)
>  static void init_proc_603 (CPUPPCState *env)
>  {
>      gen_spr_ne_601(env);
> +    gen_spr_sdr1(env);
>      gen_spr_603(env);
>      /* Time base */
>      gen_tbl(env);
> @@ -5471,6 +5485,7 @@ POWERPC_FAMILY(603)(ObjectClass *oc, void *data)
>  static void init_proc_603E (CPUPPCState *env)
>  {
>      gen_spr_ne_601(env);
> +    gen_spr_sdr1(env);
>      gen_spr_603(env);
>      /* Time base */
>      gen_tbl(env);
> @@ -5537,6 +5552,7 @@ POWERPC_FAMILY(603E)(ObjectClass *oc, void *data)
>  static void init_proc_604 (CPUPPCState *env)
>  {
>      gen_spr_ne_601(env);
> +    gen_spr_sdr1(env);
>      gen_spr_604(env);
>      /* Time base */
>      gen_tbl(env);
> @@ -5600,6 +5616,7 @@ POWERPC_FAMILY(604)(ObjectClass *oc, void *data)
>  static void init_proc_604E (CPUPPCState *env)
>  {
>      gen_spr_ne_601(env);
> +    gen_spr_sdr1(env);
>      gen_spr_604(env);
>      /* XXX : not implemented */
>      spr_register(env, SPR_7XX_MMCR1, "MMCR1",
> @@ -5683,6 +5700,7 @@ POWERPC_FAMILY(604E)(ObjectClass *oc, void *data)
>  static void init_proc_740 (CPUPPCState *env)
>  {
>      gen_spr_ne_601(env);
> +    gen_spr_sdr1(env);
>      gen_spr_7xx(env);
>      /* Time base */
>      gen_tbl(env);
> @@ -5753,6 +5771,7 @@ POWERPC_FAMILY(740)(ObjectClass *oc, void *data)
>  static void init_proc_750 (CPUPPCState *env)
>  {
>      gen_spr_ne_601(env);
> +    gen_spr_sdr1(env);
>      gen_spr_7xx(env);
>      /* XXX : not implemented */
>      spr_register(env, SPR_L2CR, "L2CR",
> @@ -5831,6 +5850,7 @@ POWERPC_FAMILY(750)(ObjectClass *oc, void *data)
>  static void init_proc_750cl (CPUPPCState *env)
>  {
>      gen_spr_ne_601(env);
> +    gen_spr_sdr1(env);
>      gen_spr_7xx(env);
>      /* XXX : not implemented */
>      spr_register(env, SPR_L2CR, "L2CR",
> @@ -6032,6 +6052,7 @@ POWERPC_FAMILY(750cl)(ObjectClass *oc, void *data)
>  static void init_proc_750cx (CPUPPCState *env)
>  {
>      gen_spr_ne_601(env);
> +    gen_spr_sdr1(env);
>      gen_spr_7xx(env);
>      /* XXX : not implemented */
>      spr_register(env, SPR_L2CR, "L2CR",
> @@ -6114,6 +6135,7 @@ POWERPC_FAMILY(750cx)(ObjectClass *oc, void *data)
>  static void init_proc_750fx (CPUPPCState *env)
>  {
>      gen_spr_ne_601(env);
> +    gen_spr_sdr1(env);
>      gen_spr_7xx(env);
>      /* XXX : not implemented */
>      spr_register(env, SPR_L2CR, "L2CR",
> @@ -6201,6 +6223,7 @@ POWERPC_FAMILY(750fx)(ObjectClass *oc, void *data)
>  static void init_proc_750gx (CPUPPCState *env)
>  {
>      gen_spr_ne_601(env);
> +    gen_spr_sdr1(env);
>      gen_spr_7xx(env);
>      /* XXX : not implemented (XXX: different from 750fx) */
>      spr_register(env, SPR_L2CR, "L2CR",
> @@ -6288,6 +6311,7 @@ POWERPC_FAMILY(750gx)(ObjectClass *oc, void *data)
>  static void init_proc_745 (CPUPPCState *env)
>  {
>      gen_spr_ne_601(env);
> +    gen_spr_sdr1(env);
>      gen_spr_7xx(env);
>      gen_spr_G2_755(env);
>      /* Time base */
> @@ -6363,6 +6387,7 @@ POWERPC_FAMILY(745)(ObjectClass *oc, void *data)
>  static void init_proc_755 (CPUPPCState *env)
>  {
>      gen_spr_ne_601(env);
> +    gen_spr_sdr1(env);
>      gen_spr_7xx(env);
>      gen_spr_G2_755(env);
>      /* Time base */
> @@ -6449,6 +6474,7 @@ POWERPC_FAMILY(755)(ObjectClass *oc, void *data)
>  static void init_proc_7400 (CPUPPCState *env)
>  {
>      gen_spr_ne_601(env);
> +    gen_spr_sdr1(env);
>      gen_spr_7xx(env);
>      /* Time base */
>      gen_tbl(env);
> @@ -6527,6 +6553,7 @@ POWERPC_FAMILY(7400)(ObjectClass *oc, void *data)
>  static void init_proc_7410 (CPUPPCState *env)
>  {
>      gen_spr_ne_601(env);
> +    gen_spr_sdr1(env);
>      gen_spr_7xx(env);
>      /* Time base */
>      gen_tbl(env);
> @@ -6611,6 +6638,7 @@ POWERPC_FAMILY(7410)(ObjectClass *oc, void *data)
>  static void init_proc_7440 (CPUPPCState *env)
>  {
>      gen_spr_ne_601(env);
> +    gen_spr_sdr1(env);
>      gen_spr_7xx(env);
>      /* Time base */
>      gen_tbl(env);
> @@ -6718,6 +6746,7 @@ POWERPC_FAMILY(7440)(ObjectClass *oc, void *data)
>  static void init_proc_7450 (CPUPPCState *env)
>  {
>      gen_spr_ne_601(env);
> +    gen_spr_sdr1(env);
>      gen_spr_7xx(env);
>      /* Time base */
>      gen_tbl(env);
> @@ -6851,6 +6880,7 @@ POWERPC_FAMILY(7450)(ObjectClass *oc, void *data)
>  static void init_proc_7445 (CPUPPCState *env)
>  {
>      gen_spr_ne_601(env);
> +    gen_spr_sdr1(env);
>      gen_spr_7xx(env);
>      /* Time base */
>      gen_tbl(env);
> @@ -6987,6 +7017,7 @@ POWERPC_FAMILY(7445)(ObjectClass *oc, void *data)
>  static void init_proc_7455 (CPUPPCState *env)
>  {
>      gen_spr_ne_601(env);
> +    gen_spr_sdr1(env);
>      gen_spr_7xx(env);
>      /* Time base */
>      gen_tbl(env);
> @@ -7125,6 +7156,7 @@ POWERPC_FAMILY(7455)(ObjectClass *oc, void *data)
>  static void init_proc_7457 (CPUPPCState *env)
>  {
>      gen_spr_ne_601(env);
> +    gen_spr_sdr1(env);
>      gen_spr_7xx(env);
>      /* Time base */
>      gen_tbl(env);
> @@ -7287,6 +7319,7 @@ POWERPC_FAMILY(7457)(ObjectClass *oc, void *data)
>  static void init_proc_e600 (CPUPPCState *env)
>  {
>      gen_spr_ne_601(env);
> +    gen_spr_sdr1(env);
>      gen_spr_7xx(env);
>      /* Time base */
>      gen_tbl(env);
> @@ -7432,15 +7465,6 @@ POWERPC_FAMILY(e600)(ObjectClass *oc, void *data)
>  #define POWERPC970_HID5_INIT 0x00000000
>  #endif
> =20
> -enum BOOK3S_CPU_TYPE {
> -    BOOK3S_CPU_970,
> -    BOOK3S_CPU_POWER5PLUS,
> -    BOOK3S_CPU_POWER6,
> -    BOOK3S_CPU_POWER7,
> -    BOOK3S_CPU_POWER8,
> -    BOOK3S_CPU_POWER9
> -};
> -
>  static void gen_fscr_facility_check(DisasContext *ctx, int facility_sprn,
>                                      int bit, int sprn, int cause)
>  {
> @@ -7528,7 +7552,7 @@ static void gen_spr_970_hior(CPUPPCState *env)
>                   0x00000000);
>  }
> =20
> -static void gen_spr_book3s_common(CPUPPCState *env)
> +static void gen_spr_book3s_ctrl(CPUPPCState *env)
>  {
>      spr_register(env, SPR_CTRL, "SPR_CTRL",
>                   SPR_NOACCESS, SPR_NOACCESS,
> @@ -8198,112 +8222,42 @@ static void gen_spr_power8_rpr(CPUPPCState *env)
>  #endif
>  }
> =20
> -static void init_proc_book3s_64(CPUPPCState *env, int version)
> +static void init_proc_book3s_common(CPUPPCState *env)
>  {
>      gen_spr_ne_601(env);
>      gen_tbl(env);
>      gen_spr_book3s_altivec(env);
>      gen_spr_book3s_pmu_sup(env);
>      gen_spr_book3s_pmu_user(env);
> -    gen_spr_book3s_common(env);
> +    gen_spr_book3s_ctrl(env);
> +}
> =20
> -    switch (version) {
> -    case BOOK3S_CPU_970:
> -    case BOOK3S_CPU_POWER5PLUS:
> -        gen_spr_970_hid(env);
> -        gen_spr_970_hior(env);
> -        gen_low_BATs(env);
> -        gen_spr_970_pmu_sup(env);
> -        gen_spr_970_pmu_user(env);
> -        break;
> -    case BOOK3S_CPU_POWER7:
> -    case BOOK3S_CPU_POWER8:
> -    case BOOK3S_CPU_POWER9:
> -        gen_spr_book3s_ids(env);
> -        gen_spr_amr(env, version >=3D BOOK3S_CPU_POWER8);
> -        gen_spr_book3s_purr(env);
> -        env->ci_large_pages =3D true;
> -        break;
> -    default:
> -        g_assert_not_reached();
> -    }
> -    if (version >=3D BOOK3S_CPU_POWER5PLUS) {
> -        gen_spr_power5p_common(env);
> -        gen_spr_power5p_lpar(env);
> -        gen_spr_power5p_ear(env);
> -    } else {
> -        gen_spr_970_lpar(env);
> -    }
> -    if (version =3D=3D BOOK3S_CPU_970) {
> -        gen_spr_970_dbg(env);
> -    }
> -    if (version >=3D BOOK3S_CPU_POWER6) {
> -        gen_spr_power6_common(env);
> -        gen_spr_power6_dbg(env);
> -    }
> -    if (version =3D=3D BOOK3S_CPU_POWER7) {
> -        gen_spr_power7_book4(env);
> -    }
> -    if (version >=3D BOOK3S_CPU_POWER8) {
> -        gen_spr_power8_tce_address_control(env);
> -        gen_spr_power8_ids(env);
> -        gen_spr_power8_ebb(env);
> -        gen_spr_power8_fscr(env);
> -        gen_spr_power8_pmu_sup(env);
> -        gen_spr_power8_pmu_user(env);
> -        gen_spr_power8_tm(env);
> -        gen_spr_power8_pspb(env);
> -        gen_spr_vtb(env);
> -        gen_spr_power8_ic(env);
> -        gen_spr_power8_book4(env);
> -        gen_spr_power8_rpr(env);
> -    }
> -    if (version < BOOK3S_CPU_POWER8) {
> -        gen_spr_book3s_dbg(env);
> -    } else {
> -        gen_spr_book3s_207_dbg(env);
> -    }
> +static void init_proc_970(CPUPPCState *env)
> +{
> +    /* Common Registers */
> +    init_proc_book3s_common(env);
> +    gen_spr_sdr1(env);
> +    gen_spr_book3s_dbg(env);
> +
> +    /* 970 Specific Registers */
> +    gen_spr_970_hid(env);
> +    gen_spr_970_hior(env);
> +    gen_low_BATs(env);
> +    gen_spr_970_pmu_sup(env);
> +    gen_spr_970_pmu_user(env);
> +    gen_spr_970_lpar(env);
> +    gen_spr_970_dbg(env);
> +
> +    /* env variables */
>  #if !defined(CONFIG_USER_ONLY)
> -    switch (version) {
> -    case BOOK3S_CPU_970:
> -    case BOOK3S_CPU_POWER5PLUS:
> -        env->slb_nr =3D 64;
> -        break;
> -    case BOOK3S_CPU_POWER7:
> -    case BOOK3S_CPU_POWER8:
> -    case BOOK3S_CPU_POWER9:
> -    default:
> -        env->slb_nr =3D 32;
> -        break;
> -    }
> +    env->slb_nr =3D 64;
>  #endif
> -    /* Allocate hardware IRQ controller */
> -    switch (version) {
> -    case BOOK3S_CPU_970:
> -    case BOOK3S_CPU_POWER5PLUS:
> -        init_excp_970(env);
> -        ppc970_irq_init(ppc_env_get_cpu(env));
> -        break;
> -    case BOOK3S_CPU_POWER7:
> -        init_excp_POWER7(env);
> -        ppcPOWER7_irq_init(ppc_env_get_cpu(env));
> -        break;
> -    case BOOK3S_CPU_POWER8:
> -    case BOOK3S_CPU_POWER9:
> -        init_excp_POWER8(env);
> -        ppcPOWER7_irq_init(ppc_env_get_cpu(env));
> -        break;
> -    default:
> -        g_assert_not_reached();
> -    }
> -
>      env->dcache_line_size =3D 128;
>      env->icache_line_size =3D 128;
> -}
> =20
> -static void init_proc_970(CPUPPCState *env)
> -{
> -    init_proc_book3s_64(env, BOOK3S_CPU_970);
> +    /* Allocate hardware IRQ controller */
> +    init_excp_970(env);
> +    ppc970_irq_init(ppc_env_get_cpu(env));
>  }
> =20
>  POWERPC_FAMILY(970)(ObjectClass *oc, void *data)
> @@ -8355,7 +8309,31 @@ POWERPC_FAMILY(970)(ObjectClass *oc, void *data)
> =20
>  static void init_proc_power5plus(CPUPPCState *env)
>  {
> -    init_proc_book3s_64(env, BOOK3S_CPU_POWER5PLUS);
> +    /* Common Registers */
> +    init_proc_book3s_common(env);
> +    gen_spr_sdr1(env);
> +    gen_spr_book3s_dbg(env);
> +
> +    /* POWER5+ Specific Registers */
> +    gen_spr_970_hid(env);
> +    gen_spr_970_hior(env);
> +    gen_low_BATs(env);
> +    gen_spr_970_pmu_sup(env);
> +    gen_spr_970_pmu_user(env);
> +    gen_spr_power5p_common(env);
> +    gen_spr_power5p_lpar(env);
> +    gen_spr_power5p_ear(env);
> +
> +    /* env variables */
> +#if !defined(CONFIG_USER_ONLY)
> +    env->slb_nr =3D 64;
> +#endif
> +    env->dcache_line_size =3D 128;
> +    env->icache_line_size =3D 128;
> +
> +    /* Allocate hardware IRQ controller */
> +    init_excp_970(env);
> +    ppc970_irq_init(ppc_env_get_cpu(env));
>  }
> =20
>  POWERPC_FAMILY(POWER5P)(ObjectClass *oc, void *data)
> @@ -8508,7 +8486,33 @@ static const struct ppc_segment_page_sizes POWER7_=
POWER8_sps =3D {
> =20
>  static void init_proc_POWER7 (CPUPPCState *env)
>  {
> -    init_proc_book3s_64(env, BOOK3S_CPU_POWER7);
> +    /* Common Registers */
> +    init_proc_book3s_common(env);
> +    gen_spr_sdr1(env);
> +    gen_spr_book3s_dbg(env);
> +
> +    /* POWER7 Specific Registers */
> +    gen_spr_book3s_ids(env);
> +    gen_spr_amr(env);
> +    gen_spr_book3s_purr(env);
> +    gen_spr_power5p_common(env);
> +    gen_spr_power5p_lpar(env);
> +    gen_spr_power5p_ear(env);
> +    gen_spr_power6_common(env);
> +    gen_spr_power6_dbg(env);
> +    gen_spr_power7_book4(env);
> +
> +    /* env variables */
> +#if !defined(CONFIG_USER_ONLY)
> +    env->slb_nr =3D 32;
> +#endif
> +    env->ci_large_pages =3D true;
> +    env->dcache_line_size =3D 128;
> +    env->icache_line_size =3D 128;
> +
> +    /* Allocate hardware IRQ controller */
> +    init_excp_POWER7(env);
> +    ppcPOWER7_irq_init(ppc_env_get_cpu(env));
>  }
> =20
>  static bool ppc_pvr_match_power7(PowerPCCPUClass *pcc, uint32_t pvr)
> @@ -8624,7 +8628,45 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *data)
> =20
>  static void init_proc_POWER8(CPUPPCState *env)
>  {
> -    init_proc_book3s_64(env, BOOK3S_CPU_POWER8);
> +    /* Common Registers */
> +    init_proc_book3s_common(env);
> +    gen_spr_sdr1(env);
> +    gen_spr_book3s_207_dbg(env);
> +
> +    /* POWER8 Specific Registers */
> +    gen_spr_book3s_ids(env);
> +    gen_spr_amr(env);
> +    gen_spr_iamr(env);
> +    gen_spr_book3s_purr(env);
> +    gen_spr_power5p_common(env);
> +    gen_spr_power5p_lpar(env);
> +    gen_spr_power5p_ear(env);
> +    gen_spr_power6_common(env);
> +    gen_spr_power6_dbg(env);
> +    gen_spr_power8_tce_address_control(env);
> +    gen_spr_power8_ids(env);
> +    gen_spr_power8_ebb(env);
> +    gen_spr_power8_fscr(env);
> +    gen_spr_power8_pmu_sup(env);
> +    gen_spr_power8_pmu_user(env);
> +    gen_spr_power8_tm(env);
> +    gen_spr_power8_pspb(env);
> +    gen_spr_vtb(env);
> +    gen_spr_power8_ic(env);
> +    gen_spr_power8_book4(env);
> +    gen_spr_power8_rpr(env);
> +
> +    /* env variables */
> +#if !defined(CONFIG_USER_ONLY)
> +    env->slb_nr =3D 32;
> +#endif
> +    env->ci_large_pages =3D true;
> +    env->dcache_line_size =3D 128;
> +    env->icache_line_size =3D 128;
> +
> +    /* Allocate hardware IRQ controller */
> +    init_excp_POWER8(env);
> +    ppcPOWER7_irq_init(ppc_env_get_cpu(env));
>  }
> =20
>  static bool ppc_pvr_match_power8(PowerPCCPUClass *pcc, uint32_t pvr)
> @@ -8752,9 +8794,47 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
>      pcc->l1_icache_size =3D 0x8000;
>      pcc->interrupts_big_endian =3D ppc_cpu_interrupts_big_endian_lpcr;
>  }
> +
>  static void init_proc_POWER9(CPUPPCState *env)
>  {
> -    init_proc_book3s_64(env, BOOK3S_CPU_POWER9);
> +    /* Common Registers */
> +    init_proc_book3s_common(env);
> +    gen_spr_book3s_207_dbg(env);
> +
> +    /* POWER8 Specific Registers */
> +    gen_spr_book3s_ids(env);
> +    gen_spr_amr(env);
> +    gen_spr_iamr(env);
> +    gen_spr_book3s_purr(env);
> +    gen_spr_power5p_common(env);
> +    gen_spr_power5p_lpar(env);
> +    gen_spr_power5p_ear(env);
> +    gen_spr_power6_common(env);
> +    gen_spr_power6_dbg(env);
> +    gen_spr_power8_tce_address_control(env);
> +    gen_spr_power8_ids(env);
> +    gen_spr_power8_ebb(env);
> +    gen_spr_power8_fscr(env);
> +    gen_spr_power8_pmu_sup(env);
> +    gen_spr_power8_pmu_user(env);
> +    gen_spr_power8_tm(env);
> +    gen_spr_power8_pspb(env);
> +    gen_spr_vtb(env);
> +    gen_spr_power8_ic(env);
> +    gen_spr_power8_book4(env);
> +    gen_spr_power8_rpr(env);
> +
> +    /* env variables */
> +#if !defined(CONFIG_USER_ONLY)
> +    env->slb_nr =3D 32;
> +#endif
> +    env->ci_large_pages =3D true;
> +    env->dcache_line_size =3D 128;
> +    env->icache_line_size =3D 128;
> +
> +    /* Allocate hardware IRQ controller */
> +    init_excp_POWER8(env);
> +    ppcPOWER7_irq_init(ppc_env_get_cpu(env));
>  }
> =20
>  static bool ppc_pvr_match_power9(PowerPCCPUClass *pcc, uint32_t pvr)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GviraxgP0A7vmYdC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrl3BAAoJEGw4ysog2bOSs5IQANJ2/zLNTsn3OqYMeiH04L/R
8GFmUxHeT4fNQbTyfIJ/jd1oj3OVJWlLaa/Dt/n2FxkBYZ+jEtLlh2N5B0PPTguo
gG4wnxwUiYUSmdG0d3rDqiGTT8KzPp0xiG2/WCvjZsCzeKtRKJvFGf2teS/Way6d
I1F5YBrJ4N10eT92zPYKU8GYqzZe+xgCN784BMwp3phuOnRB448kALWS97j3lrC0
HrxwgIS59Qy0AjyMAbN2U7lpZ1rmBoLDqiJ7BRYKbm7JhqcfJnDakcOtKmkBHB2o
q7FJmOzzgqoKGfsiK+YGKYNiFKVSwM/8IT07POw0PSB5sdrOBDiiBh6jk/P69v4i
YCXv+T1pLVxbscDueIA5ytnYoyYzCkCsuKfJA7WzrEi0VWhXC4jBVbd8n7UxMknd
lmaodcuuMVyLoT47SjtiPKAj75YnQ5XQS0I9LzRINdayXMiBmdAE1iICUjnbU61f
WUpnRoklEJJzqsrVqdHGvPbvxs2q1VLU6VWb3sGoHM5IyG7CxsVK2KyFAy0VpP2C
e95j/67ixQ66XKFWt2hVPcVSHWMDmQRgJ9iuC6fNrPtTGUt0PO/8OuHoPz8Is+xy
hmLuusxkeXZdzNw81siWSscl1eUTlczU7bosmdgPG7R9Q+slJ3iRfbzwtmJGwNiP
pejPTU+107mw/PuwlJ85
=7/ns
-----END PGP SIGNATURE-----

--GviraxgP0A7vmYdC--
