Received: from eggs.gnu.org ([2001:4830:134:3::10]:46597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYkoC-0003i1-B7
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 00:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYko9-0003oF-1L
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 00:14:56 -0400
Date: Fri, 29 Jun 2018 13:33:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180629033353.GB3422@umbus.fritz.box>
References: <20180626161921.27941-1-richard.henderson@linaro.org>
	<20180626161921.27941-4-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
In-Reply-To: <20180626161921.27941-4-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 03/13] target/ppc: Use atomic store for STQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2018 at 09:19:11AM -0700, Richard Henderson wrote:
> Section 1.4 of the Power ISA v3.0B states that this insn is
> single-copy atomic.  As we cannot (yet) issue 128-bit loads
> within TCG, use the generic helpers provided.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Applied to ppc-for-3.0, thanks.

> ---
>  target/ppc/helper.h     |  4 ++++
>  target/ppc/mem_helper.c | 14 ++++++++++++++
>  target/ppc/translate.c  | 35 +++++++++++++++++++++++++++--------
>  3 files changed, 45 insertions(+), 8 deletions(-)
>=20
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 3f451a5d7e..cbc1228570 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -803,4 +803,8 @@ DEF_HELPER_FLAGS_1(fixup_thrm, TCG_CALL_NO_RWG, void,=
 env)
>  #if defined(TARGET_PPC64) && defined(CONFIG_ATOMIC128)
>  DEF_HELPER_FLAGS_3(lq_le_parallel, TCG_CALL_NO_WG, i64, env, tl, i32)
>  DEF_HELPER_FLAGS_3(lq_be_parallel, TCG_CALL_NO_WG, i64, env, tl, i32)
> +DEF_HELPER_FLAGS_5(stq_le_parallel, TCG_CALL_NO_WG,
> +                   void, env, tl, i64, i64, i32)
> +DEF_HELPER_FLAGS_5(stq_be_parallel, TCG_CALL_NO_WG,
> +                   void, env, tl, i64, i64, i32)
>  #endif
> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> index 44a8f3445a..57e301edc3 100644
> --- a/target/ppc/mem_helper.c
> +++ b/target/ppc/mem_helper.c
> @@ -231,6 +231,20 @@ uint64_t helper_lq_be_parallel(CPUPPCState *env, tar=
get_ulong addr,
>      env->retxh =3D int128_gethi(ret);
>      return int128_getlo(ret);
>  }
> +
> +void helper_stq_le_parallel(CPUPPCState *env, target_ulong addr,
> +                            uint64_t lo, uint64_t hi, uint32_t opidx)
> +{
> +    Int128 val =3D int128_make128(lo, hi);
> +    helper_atomic_sto_le_mmu(env, addr, val, opidx, GETPC());
> +}
> +
> +void helper_stq_be_parallel(CPUPPCState *env, target_ulong addr,
> +                            uint64_t lo, uint64_t hi, uint32_t opidx)
> +{
> +    Int128 val =3D int128_make128(lo, hi);
> +    helper_atomic_sto_be_mmu(env, addr, val, opidx, GETPC());
> +}
>  #endif
> =20
>  /***********************************************************************=
******/
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 0923cc24e3..3d63a62269 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2760,6 +2760,7 @@ static void gen_std(DisasContext *ctx)
>      if ((ctx->opcode & 0x3) =3D=3D 0x2) { /* stq */
>          bool legal_in_user_mode =3D (ctx->insns_flags2 & PPC2_LSQ_ISA207=
) !=3D 0;
>          bool le_is_supported =3D (ctx->insns_flags2 & PPC2_LSQ_ISA207) !=
=3D 0;
> +        TCGv hi, lo;
> =20
>          if (!(ctx->insns_flags & PPC_64BX)) {
>              gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
> @@ -2783,20 +2784,38 @@ static void gen_std(DisasContext *ctx)
>          EA =3D tcg_temp_new();
>          gen_addr_imm_index(ctx, EA, 0x03);
> =20
> -        /* We only need to swap high and low halves. gen_qemu_st64_i64 d=
oes
> -           necessary 64-bit byteswap already. */
> -        if (unlikely(ctx->le_mode)) {
> -            gen_qemu_st64_i64(ctx, cpu_gpr[rs + 1], EA);
> +        /* Note that the low part is always in RS+1, even in LE mode.  */
> +        lo =3D cpu_gpr[rs + 1];
> +        hi =3D cpu_gpr[rs];
> +
> +        if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
> +#ifdef CONFIG_ATOMIC128
> +            TCGv_i32 oi =3D tcg_temp_new_i32();
> +            if (ctx->le_mode) {
> +                tcg_gen_movi_i32(oi, make_memop_idx(MO_LEQ, ctx->mem_idx=
));
> +                gen_helper_stq_le_parallel(cpu_env, EA, lo, hi, oi);
> +            } else {
> +                tcg_gen_movi_i32(oi, make_memop_idx(MO_BEQ, ctx->mem_idx=
));
> +                gen_helper_stq_be_parallel(cpu_env, EA, lo, hi, oi);
> +            }
> +            tcg_temp_free_i32(oi);
> +#else
> +            /* Restart with exclusive lock.  */
> +            gen_helper_exit_atomic(cpu_env);
> +            ctx->base.is_jmp =3D DISAS_NORETURN;
> +#endif
> +        } else if (ctx->le_mode) {
> +            tcg_gen_qemu_st_i64(lo, EA, ctx->mem_idx, MO_LEQ);
>              gen_addr_add(ctx, EA, EA, 8);
> -            gen_qemu_st64_i64(ctx, cpu_gpr[rs], EA);
> +            tcg_gen_qemu_st_i64(hi, EA, ctx->mem_idx, MO_LEQ);
>          } else {
> -            gen_qemu_st64_i64(ctx, cpu_gpr[rs], EA);
> +            tcg_gen_qemu_st_i64(hi, EA, ctx->mem_idx, MO_BEQ);
>              gen_addr_add(ctx, EA, EA, 8);
> -            gen_qemu_st64_i64(ctx, cpu_gpr[rs + 1], EA);
> +            tcg_gen_qemu_st_i64(lo, EA, ctx->mem_idx, MO_BEQ);
>          }
>          tcg_temp_free(EA);
>      } else {
> -        /* std / stdu*/
> +        /* std / stdu */
>          if (Rc(ctx->opcode)) {
>              if (unlikely(rA(ctx->opcode) =3D=3D 0)) {
>                  gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls1qKEACgkQbDjKyiDZ
s5Kq5g/+Kz0sixeINq9a/VGsh5WQ+zEAkTakGCtNIzSXrKpDui0gsF4iGGsxExxE
cGOotYLHp6OUrEziYJUDLvZZ+II0vDARbl7zmzEPZ4S7oU6SCNYLgGlWndG5sbwk
6qki5zpGNBaoQYxZOQSkUAjnU6HywjJe64EHkdxmbhO/5QjflsQX9l8L5PBRmEPl
z9n9lD6AtpXrhE8zlBBEW4sw6F3ofaK53m+1D8aLvKD/HLzIPTI51pb8mXmiGMkq
DFGqCyMMCwlGuduyq68Vs/VfDMDAO+Qu41c0L0G+PsLAPrVjX7Gf9I9H4fsqN6UD
gu3czO1zIB/Pif7fbR1Q4ajzSWqdw5GFis/kwt4eyqspgLRaHmeG5cewiGbs6cAT
eje+mezPU99i2T0ZcacsHLXC8N+xvH8NXwyTvGTFnBKs4eI5GUPGRezdOiwL+XZr
h6yRsyeA/TbZ9kvUhBOjjdiWsHPwfO+fC4jPp/FP5HY1issykAZpTxlvs68DH789
AJEyY9m5Pnn/+opUhg9IPZgtSsF/N0lmrgf5MuJ30DZgwArv6Ba22U1mZ3gS5ja/
TAP0UzyYRkLV+jp7nboOO8dI4Azyx8IV/SueRM6Q+IURVMEOlTkd4jegcThBRPQy
UMmh7vYgg8OANamFQuB6dUr+YK3cXFAXzEGF1ouknwrLan9nTb4=
=QqrB
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
