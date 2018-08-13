Received: from eggs.gnu.org ([2001:4830:134:3::10]:38769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fp4Bl-0002BI-FJ
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 00:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fp4Bj-0004y9-N4
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 00:10:41 -0400
Date: Mon, 13 Aug 2018 14:02:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180813040259.GL4079@umbus>
References: <20180807092948.28134-1-rka@sysgo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ai3I8gwHc37+ASRI"
Content-Disposition: inline
In-Reply-To: <20180807092948.28134-1-rka@sysgo.com>
Subject: Re: [Qemu-devel] [PATCH] ppc: add DBCR based debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kapl <rka@sysgo.com>
Cc: Alexander Graf <agraf@suse.de>, "open list:PowerPC" <qemu-ppc@nongnu.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>


--ai3I8gwHc37+ASRI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 07, 2018 at 11:29:48AM +0200, Roman Kapl wrote:
> Add support for DBCR (debug control register) based debugging as used on
> BookE ppc. So far supports only branch and single-step events, but these =
are
> the important ones. GDB in Linux guest can now do single-stepping.
>=20
> Signed-off-by: Roman Kapl <rka@sysgo.com>
> ---
>  target/ppc/cpu.h                |   5 ++
>  target/ppc/excp_helper.c        |   3 +-
>  target/ppc/translate.c          | 107 ++++++++++++++++++++++++++++++----=
------
>  target/ppc/translate_init.inc.c |  17 +++++++
>  4 files changed, 104 insertions(+), 28 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 4edcf62cf7..ec149349e2 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -481,6 +481,11 @@ struct ppc_slb_t {
>  #define msr_ts   ((env->msr >> MSR_TS1)  & 3)
>  #define msr_tm   ((env->msr >> MSR_TM)   & 1)
> =20
> +#define DBCR0_ICMP (1 << 27)
> +#define DBCR0_BRT (1 << 26)
> +#define DBSR_ICMP (1 << 27)
> +#define DBSR_BRT (1 << 26)
> +
>  /* Hypervisor bit is more specific */
>  #if defined(TARGET_PPC64)
>  #define MSR_HVB (1ULL << MSR_SHV)
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index d6e97a90e0..3463efaf4e 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -359,8 +359,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
>          default:
>              break;
>          }
> -        /* XXX: TODO */
> -        cpu_abort(cs, "Debug exception is not implemented yet !\n");
> +        /* DBSR already modified by caller */

Ths is unconditionally enabling the exception for every platform,
which doesn't seem right.  I think it would be better to add the
specific exception models which use the DBCR to the switch statement
above this.

>          break;
>      case POWERPC_EXCP_SPEU:      /* SPE/embedded floating-point unavaila=
ble  */
>          env->spr[SPR_BOOKE_ESR] =3D ESR_SPV;
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 9eaa10b421..69cd45dd81 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -211,6 +211,7 @@ struct DisasContext {
>      bool gtse;
>      ppc_spr_t *spr_cb; /* Needed to check rights for mfspr/mtspr */
>      int singlestep_enabled;
> +    uint32_t flags;
>      uint64_t insns_flags;
>      uint64_t insns_flags2;
>  };
> @@ -251,6 +252,17 @@ struct opc_handler_t {
>  #endif
>  };
> =20
> +/* SPR load/store helpers */
> +static inline void gen_load_spr(TCGv t, int reg)
> +{
> +    tcg_gen_ld_tl(t, cpu_env, offsetof(CPUPPCState, spr[reg]));
> +}
> +
> +static inline void gen_store_spr(int reg, TCGv t)
> +{
> +    tcg_gen_st_tl(t, cpu_env, offsetof(CPUPPCState, spr[reg]));
> +}
> +
>  static inline void gen_set_access_type(DisasContext *ctx, int access_typ=
e)
>  {
>      if (ctx->need_access_type && ctx->access_type !=3D access_type) {
> @@ -313,6 +325,38 @@ static void gen_exception_nip(DisasContext *ctx, uin=
t32_t excp,
>      ctx->exception =3D (excp);
>  }
> =20
> +/* Translates the EXCP_TRACE/BRANCH to an appropriate exception depending
> + * on processor version (BookE vs regular)

It's not obvious what "regular" means in this context.

> + */
> +static uint32_t gen_prep_dbgex(DisasContext *ctx, uint32_t excp)
> +{
> +    if ((ctx->singlestep_enabled & CPU_SINGLE_STEP)
> +        && (excp =3D=3D POWERPC_EXCP_BRANCH)) {
> +        /* Trace excpt. has priority */
> +        excp =3D POWERPC_EXCP_TRACE;
> +    }
> +    if (ctx->flags & POWERPC_FLAG_DE) {
> +        target_ulong dbsr =3D 0;
> +        switch (excp) {
> +        case POWERPC_EXCP_TRACE:
> +            dbsr =3D DBCR0_ICMP;
> +            break;
> +        case POWERPC_EXCP_BRANCH:
> +            dbsr =3D DBCR0_BRT;
> +            break;
> +        }
> +        TCGv t0 =3D tcg_temp_new();
> +        gen_load_spr(t0, SPR_BOOKE_DBSR);
> +        tcg_gen_ori_tl(t0, t0, dbsr);
> +        gen_store_spr(SPR_BOOKE_DBSR, t0);
> +        tcg_temp_free(t0);
> +        return POWERPC_EXCP_DEBUG;
> +    } else {
> +        return excp;
> +    }
> +    return POWERPC_EXCP_NONE;
> +}
> +
>  static void gen_debug_exception(DisasContext *ctx)
>  {
>      TCGv_i32 t0;
> @@ -575,17 +619,6 @@ typedef struct opcode_t {
>  }
>  #endif
> =20
> -/* SPR load/store helpers */
> -static inline void gen_load_spr(TCGv t, int reg)
> -{
> -    tcg_gen_ld_tl(t, cpu_env, offsetof(CPUPPCState, spr[reg]));
> -}
> -
> -static inline void gen_store_spr(int reg, TCGv t)
> -{
> -    tcg_gen_st_tl(t, cpu_env, offsetof(CPUPPCState, spr[reg]));
> -}
> -

You move these around, but the new code doesn't seem to use them, so
I'm not sure why.

>  /* Invalid instruction */
>  static void gen_invalid(DisasContext *ctx)
>  {
> @@ -3602,6 +3635,24 @@ static inline bool use_goto_tb(DisasContext *ctx, =
target_ulong dest)
>  #endif
>  }
> =20
> +static void gen_lookup_and_goto_ptr(DisasContext *ctx)
> +{
> +    int sse =3D ctx->singlestep_enabled;
> +    if (unlikely(sse)) {
> +        if (sse & GDBSTUB_SINGLE_STEP) {
> +            gen_debug_exception(ctx);
> +        } else if (sse & (CPU_SINGLE_STEP | CPU_BRANCH_STEP)) {
> +            uint32_t excp =3D gen_prep_dbgex(ctx, POWERPC_EXCP_BRANCH);
> +            if (excp !=3D POWERPC_EXCP_NONE) {
> +                gen_exception(ctx, excp);
> +            }
> +        }
> +        tcg_gen_exit_tb(NULL, 0);
> +    } else {
> +        tcg_gen_lookup_and_goto_ptr();
> +    }
> +}
> +
>  /***                                Branch                              =
   ***/
>  static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
>  {
> @@ -3614,18 +3665,7 @@ static void gen_goto_tb(DisasContext *ctx, int n, =
target_ulong dest)
>          tcg_gen_exit_tb(ctx->base.tb, n);
>      } else {
>          tcg_gen_movi_tl(cpu_nip, dest & ~3);
> -        if (unlikely(ctx->singlestep_enabled)) {
> -            if ((ctx->singlestep_enabled &
> -                (CPU_BRANCH_STEP | CPU_SINGLE_STEP)) &&
> -                (ctx->exception =3D=3D POWERPC_EXCP_BRANCH ||
> -                 ctx->exception =3D=3D POWERPC_EXCP_TRACE)) {
> -                gen_exception_nip(ctx, POWERPC_EXCP_TRACE, dest);
> -            }
> -            if (ctx->singlestep_enabled & GDBSTUB_SINGLE_STEP) {
> -                gen_debug_exception(ctx);
> -            }
> -        }
> -        tcg_gen_lookup_and_goto_ptr();
> +        gen_lookup_and_goto_ptr(ctx);
>      }
>  }
> =20
> @@ -3668,8 +3708,8 @@ static void gen_bcond(DisasContext *ctx, int type)
>      uint32_t bo =3D BO(ctx->opcode);
>      TCGLabel *l1;
>      TCGv target;
> -
>      ctx->exception =3D POWERPC_EXCP_BRANCH;
> +
>      if (type =3D=3D BCOND_LR || type =3D=3D BCOND_CTR || type =3D=3D BCO=
ND_TAR) {
>          target =3D tcg_temp_local_new();
>          if (type =3D=3D BCOND_CTR)
> @@ -3733,10 +3773,11 @@ static void gen_bcond(DisasContext *ctx, int type)
>          } else {
>              tcg_gen_andi_tl(cpu_nip, target, ~3);
>          }
> -        tcg_gen_lookup_and_goto_ptr();
> +        gen_lookup_and_goto_ptr(ctx);
>          tcg_temp_free(target);
>      }
>      if ((bo & 0x14) !=3D 0x14) {
> +        /* fallthrough case */
>          gen_set_label(l1);
>          gen_goto_tb(ctx, 1, ctx->base.pc_next);
>      }
> @@ -7419,6 +7460,7 @@ static void ppc_tr_init_disas_context(DisasContextB=
ase *dcbase, CPUState *cs)
>      ctx->need_access_type =3D !(env->mmu_model & POWERPC_MMU_64B);
>      ctx->le_mode =3D !!(env->hflags & (1 << MSR_LE));
>      ctx->default_tcg_memop_mask =3D ctx->le_mode ? MO_LE : MO_BE;
> +    ctx->flags =3D env->flags;
>  #if defined(TARGET_PPC64)
>      ctx->sf_mode =3D msr_is_64bit(env, env->msr);
>      ctx->has_cfar =3D !!(env->flags & POWERPC_FLAG_CFAR);
> @@ -7455,6 +7497,17 @@ static void ppc_tr_init_disas_context(DisasContext=
Base *dcbase, CPUState *cs)
>          ctx->singlestep_enabled =3D 0;
>      if ((env->flags & POWERPC_FLAG_BE) && msr_be)
>          ctx->singlestep_enabled |=3D CPU_BRANCH_STEP;
> +    if ((env->flags & POWERPC_FLAG_DE) && msr_de) {
> +        ctx->singlestep_enabled =3D 0;
> +        target_ulong dbcr0 =3D env->spr[SPR_BOOKE_DBCR0];
> +        if (dbcr0 & DBCR0_ICMP) {
> +            ctx->singlestep_enabled |=3D CPU_SINGLE_STEP;
> +        }
> +        if (dbcr0 & DBCR0_BRT) {
> +            ctx->singlestep_enabled |=3D CPU_BRANCH_STEP;
> +        }
> +
> +    }
>      if (unlikely(ctx->base.singlestep_enabled)) {
>          ctx->singlestep_enabled |=3D GDBSTUB_SINGLE_STEP;
>      }
> @@ -7565,7 +7618,9 @@ static void ppc_tr_translate_insn(DisasContextBase =
*dcbase, CPUState *cs)
>                   ctx->exception !=3D POWERPC_SYSCALL &&
>                   ctx->exception !=3D POWERPC_EXCP_TRAP &&
>                   ctx->exception !=3D POWERPC_EXCP_BRANCH)) {
> -        gen_exception_nip(ctx, POWERPC_EXCP_TRACE, ctx->base.pc_next);
> +        uint32_t excp =3D gen_prep_dbgex(ctx, POWERPC_EXCP_TRACE);
> +        if (excp !=3D POWERPC_EXCP_NONE)
> +            gen_exception_nip(ctx, excp, ctx->base.pc_next);
>      }
> =20
>      if (tcg_check_temp_count()) {
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 7813b1b004..f1be7b7953 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -498,6 +498,7 @@ static void spr_write_40x_pit(DisasContext *ctx, int =
sprn, int gprn)
> =20
>  static void spr_write_40x_dbcr0(DisasContext *ctx, int sprn, int gprn)
>  {
> +    gen_store_spr(sprn, cpu_gpr[gprn]);
>      gen_helper_store_40x_dbcr0(cpu_env, cpu_gpr[gprn]);
>      /* We must stop translation as we may have rebooted */
>      gen_stop_exception(ctx);
> @@ -1769,6 +1770,14 @@ static void gen_spr_BookE(CPUPPCState *env, uint64=
_t ivor_mask)
>                   SPR_NOACCESS, SPR_NOACCESS,
>                   &spr_read_generic, &spr_write_generic,
>                   0x00000000);
> +    spr_register(env, SPR_BOOKE_DSRR0, "DSRR0",
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 &spr_read_generic, &spr_write_generic,
> +                 0x00000000);
> +    spr_register(env, SPR_BOOKE_DSRR1, "DSRR1",
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 &spr_read_generic, &spr_write_generic,
> +                 0x00000000);
>      /* XXX : not implemented */
>      spr_register(env, SPR_BOOKE_DBSR, "DBSR",
>                   SPR_NOACCESS, SPR_NOACCESS,
> @@ -1841,6 +1850,14 @@ static void gen_spr_BookE(CPUPPCState *env, uint64=
_t ivor_mask)
>                   SPR_NOACCESS, SPR_NOACCESS,
>                   &spr_read_generic, &spr_write_generic,
>                   0x00000000);
> +    spr_register(env, SPR_BOOKE_SPRG8, "SPRG8",
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 &spr_read_generic, &spr_write_generic,
> +                 0x00000000);
> +    spr_register(env, SPR_BOOKE_SPRG9, "SPRG9",
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 &spr_read_generic, &spr_write_generic,
> +                 0x00000000);
>  }
> =20
>  static inline uint32_t gen_tlbncfg(uint32_t assoc, uint32_t minsize,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ai3I8gwHc37+ASRI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltxAvEACgkQbDjKyiDZ
s5JFNRAAj0b8mDBx7TLuxDScvs83cfv4Qs+KerNyFITVmjgK/c/2t4PNofKTfBM0
qFHplNzRCCKbtCeEtD2M7H22v1Li+rnoF2gZeyVyAme8b8t0E3oHgUrQ0w036zg8
ICBS4kpWlWi5LXKvzAs/cM+XdMhyfEBAVUH0rbZDm3RIhBv4KKUR2O9NW5/4UWPT
4mOC/fG92UcTe+AjhbMxlpoe+UNfqaPMMY3TrWT5SvytlPTCoUoVMzC/ioTeWDu2
rFuhFJPy3trZYfqezggTSLP8sneyDIZ1EJzejBbg1ieU+Ugov5ec5z3gn5ffkig7
tvj32L17LIn6O0F1y2gDW/Sbl2fgHlR+2kXZcw5LB71BnR9OC1DhqyBqj92wIVr5
e+Tqh9mCX69kB8QJ8UmWbP/2H3xufJRneU2uuk9hAZ7yaZl76AIE/AvccQHo0hIQ
gI80EsCmxpGesSkd0MJuAigOu0e+V/FrkpfaJAn65b8BaFsQjk5EMt7u7AIM1nsd
WRja6tvTdaNZP2ed7ZAJ+hag9RBSwNg/GmyBhRGKP/JknHG0wSJFwjmoQ8dyQ4v4
Tp11clHfNLF2Zm5QNeA88Y/DO7NMXlAG0sn7sC03ZZJowR1SKRcwCNGVfRVRcSyp
GMoFeMMEAkrdlEaTJptK9ih4DxFzeOoEMOcrmGn1m0J9yc61hLw=
=EIhy
-----END PGP SIGNATURE-----

--ai3I8gwHc37+ASRI--
