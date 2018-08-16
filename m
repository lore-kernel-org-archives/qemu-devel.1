Received: from eggs.gnu.org ([2001:4830:134:3::10]:36726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fq9xZ-0000xz-Cz
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 00:32:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fq9xX-0001Vq-PK
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 00:32:33 -0400
Date: Thu, 16 Aug 2018 14:22:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180816042251.GA6091@umbus.fritz.box>
References: <20180814160951.11199-1-rka@sysgo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <20180814160951.11199-1-rka@sysgo.com>
Subject: Re: [Qemu-devel] [PATCH v2] ppc: add DBCR based debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kapl <rka@sysgo.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 14, 2018 at 06:09:51PM +0200, Roman Kapl wrote:
> Add support for DBCR (debug control register) based debugging as used on
> BookE ppc. So far supports only branch and single-step events, but these =
are
> the important ones. GDB in Linux guest can now do single-stepping.
>=20
> Signed-off-by: Roman Kapl <rka@sysgo.com>

Applied to ppc-for-3.1.

> ---
>=20
> v1 -> v2
>  Only handle the xception (in powerpc_excp) if the processor model is rig=
ht.
>  Improve comment on prep_dbgex.
>  Note: The gen_spr/load_spr is indeed used by the new code (in prep_dbgex=
).
>=20
>  target/ppc/cpu.h                |   5 ++
>  target/ppc/excp_helper.c        |  11 ++---
>  target/ppc/translate.c          | 107 ++++++++++++++++++++++++++++++----=
------
>  target/ppc/translate_init.inc.c |  17 +++++++
>  4 files changed, 107 insertions(+), 33 deletions(-)
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
> index d6e97a90e0..0ec7ae1ad4 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -348,19 +348,16 @@ static inline void powerpc_excp(PowerPCCPU *cpu, in=
t excp_model, int excp)
>      case POWERPC_EXCP_ITLB:      /* Instruction TLB error               =
     */
>          break;
>      case POWERPC_EXCP_DEBUG:     /* Debug interrupt                     =
     */
> -        switch (excp_model) {
> -        case POWERPC_EXCP_BOOKE:
> +        if (env->flags & POWERPC_FLAG_DE) {
>              /* FIXME: choose one or the other based on CPU type */
>              srr0 =3D SPR_BOOKE_DSRR0;
>              srr1 =3D SPR_BOOKE_DSRR1;
>              asrr0 =3D SPR_BOOKE_CSRR0;
>              asrr1 =3D SPR_BOOKE_CSRR1;
> -            break;
> -        default:
> -            break;
> +            /* DBSR already modified by caller */
> +        } else {
> +            cpu_abort(cs, "Debug exception triggered on unsupported mode=
l\n");
>          }
> -        /* XXX: TODO */
> -        cpu_abort(cs, "Debug exception is not implemented yet !\n");
>          break;
>      case POWERPC_EXCP_SPEU:      /* SPE/embedded floating-point unavaila=
ble  */
>          env->spr[SPR_BOOKE_ESR] =3D ESR_SPV;
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 9eaa10b421..881743571b 100644
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
> +/* Translates the EXCP_TRACE/BRANCH exceptions used on most PowerPCs to
> + * EXCP_DEBUG, if we are running on cores using the debug enable bit (e.=
g.
> + * BookE).
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

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlt0/BgACgkQbDjKyiDZ
s5Iprw/+Mge4GnEH/Lc0KfkxvLL/UbkrrhFqgtI5fZ2PrmJXJ4n0kB2aX76HHvk1
z5WjlLAv8CcCsjVBVxuyTpr1/ggS3srZ4u4Y1QWfdCbPG0N2PXDTPC2OCK29V0U8
jJOvYDGi2cfWsrYnXf56/x8nTE4S+VwCp6nJPQd8cOyn30u45QEFwcX6V0AMTSZ8
FHBy7qzLrZH3DMi2L2sdo9Rdo8cNdDMFaJBS1DMX+15/zWb7YDYkd/mzMgmVGzY5
uIB7FrBAvN6eFlaijfprOIRVZ83eT3Ejcyzc3g4QCG97JExBmzJGQQFUOzAGIro9
IdsLhuHWrCq0mdJrQc7REVU42ivN8QXMpdwvnIIuLcdoA4OFbAtFObcjhtV3XMC4
g4lL9/JUdYRNOQW107joIiAnEFa5Edc00+6qyR2E15LnQIyyNzO55ueEJdYpgyG9
Ka74PIJ1+2yMJ5eDV1z4JEAvCgaSZLAgcWY4fFFFTelN7+0ghqxB6bRxmb9KhyEd
3A7MdRhJXnmAcbnzZVTji6yOrz++3tx9JaXzWU3scMPhZy+x4kclzrHZId68PZwV
4aRQBIjHzYxoAJ6b5q1fGANE4JpnkH1Gv1vf56I5FXxImYHLX1ioZMg0JQlrnifM
pXiw+dQRsYlnVRq12wnSU9Unkqe+nRpTSzQiRibpBIWKyfeGWXI=
=iHjy
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
