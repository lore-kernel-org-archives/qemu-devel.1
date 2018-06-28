Received: from eggs.gnu.org ([2001:4830:134:3::10]:47417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYO0n-0004pF-EB
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYO0l-0006xL-Rq
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:54:25 -0400
Date: Thu, 28 Jun 2018 13:49:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180628034955.GB23134@umbus.fritz.box>
References: <20180626161921.27941-1-richard.henderson@linaro.org>
	<20180626161921.27941-3-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
In-Reply-To: <20180626161921.27941-3-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 02/13] target/ppc: Use atomic load for LQ
 and LQARX
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


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2018 at 09:19:10AM -0700, Richard Henderson wrote:
> Section 1.4 of the Power ISA v3.0B states that both of these
> instructions are single-copy atomic.  As we cannot (yet) issue
> 128-bit loads within TCG, use the generic helpers provided.
>=20
> Since TCG cannot (yet) return a 128-bit value, add a slot within
> CPUPPCState for returning the high half of a 128-bit return value.
> This solution is preferred to the helper assigning to architectural
> registers directly, as it avoids clobbering all TCG live values.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/ppc/cpu.h        |  3 ++
>  target/ppc/helper.h     |  5 +++
>  target/ppc/mem_helper.c | 20 ++++++++-
>  target/ppc/translate.c  | 93 ++++++++++++++++++++++++++++++-----------
>  4 files changed, 95 insertions(+), 26 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index c7f3fb6b73..973cf44cda 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1015,6 +1015,9 @@ struct CPUPPCState {
>      /* Next instruction pointer */
>      target_ulong nip;
> =20
> +    /* High part of 128-bit helper return.  */
> +    uint64_t retxh;
> +

Adding a temporary here is kind of gross.  I guess the helper
interface doesn't allow for 128-bit returns, but couldn't you pass a
register number into the helper and have it update the right GPR
without going through a temp?

>      int access_type; /* when a memory exception occurs, the access
>                          type is stored here */
> =20
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index d751f0e219..3f451a5d7e 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -799,3 +799,8 @@ DEF_HELPER_4(dscliq, void, env, fprp, fprp, i32)
> =20
>  DEF_HELPER_1(tbegin, void, env)
>  DEF_HELPER_FLAGS_1(fixup_thrm, TCG_CALL_NO_RWG, void, env)
> +
> +#if defined(TARGET_PPC64) && defined(CONFIG_ATOMIC128)
> +DEF_HELPER_FLAGS_3(lq_le_parallel, TCG_CALL_NO_WG, i64, env, tl, i32)
> +DEF_HELPER_FLAGS_3(lq_be_parallel, TCG_CALL_NO_WG, i64, env, tl, i32)
> +#endif
> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> index a34e604db3..44a8f3445a 100644
> --- a/target/ppc/mem_helper.c
> +++ b/target/ppc/mem_helper.c
> @@ -21,9 +21,9 @@
>  #include "exec/exec-all.h"
>  #include "qemu/host-utils.h"
>  #include "exec/helper-proto.h"
> -
>  #include "helper_regs.h"
>  #include "exec/cpu_ldst.h"
> +#include "tcg.h"
>  #include "internal.h"
> =20
>  //#define DEBUG_OP
> @@ -215,6 +215,24 @@ target_ulong helper_lscbx(CPUPPCState *env, target_u=
long addr, uint32_t reg,
>      return i;
>  }
> =20
> +#if defined(TARGET_PPC64) && defined(CONFIG_ATOMIC128)
> +uint64_t helper_lq_le_parallel(CPUPPCState *env, target_ulong addr,
> +                               uint32_t opidx)
> +{
> +    Int128 ret =3D helper_atomic_ldo_le_mmu(env, addr, opidx, GETPC());
> +    env->retxh =3D int128_gethi(ret);
> +    return int128_getlo(ret);
> +}
> +
> +uint64_t helper_lq_be_parallel(CPUPPCState *env, target_ulong addr,
> +                               uint32_t opidx)
> +{
> +    Int128 ret =3D helper_atomic_ldo_be_mmu(env, addr, opidx, GETPC());
> +    env->retxh =3D int128_gethi(ret);
> +    return int128_getlo(ret);
> +}
> +#endif
> +
>  /***********************************************************************=
******/
>  /* Altivec extension helpers */
>  #if defined(HOST_WORDS_BIGENDIAN)
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 3a215a1dc6..0923cc24e3 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2607,7 +2607,7 @@ static void gen_ld(DisasContext *ctx)
>  static void gen_lq(DisasContext *ctx)
>  {
>      int ra, rd;
> -    TCGv EA;
> +    TCGv EA, hi, lo;
> =20
>      /* lq is a legal user mode instruction starting in ISA 2.07 */
>      bool legal_in_user_mode =3D (ctx->insns_flags2 & PPC2_LSQ_ISA207) !=
=3D 0;
> @@ -2633,16 +2633,35 @@ static void gen_lq(DisasContext *ctx)
>      EA =3D tcg_temp_new();
>      gen_addr_imm_index(ctx, EA, 0x0F);
> =20
> -    /* We only need to swap high and low halves. gen_qemu_ld64_i64 does
> -       necessary 64-bit byteswap already. */
> -    if (unlikely(ctx->le_mode)) {
> -        gen_qemu_ld64_i64(ctx, cpu_gpr[rd + 1], EA);
> +    /* Note that the low part is always in RD+1, even in LE mode.  */
> +    lo =3D cpu_gpr[rd + 1];
> +    hi =3D cpu_gpr[rd];
> +
> +    if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
> +#ifdef CONFIG_ATOMIC128
> +        TCGv_i32 oi =3D tcg_temp_new_i32();
> +        if (ctx->le_mode) {
> +            tcg_gen_movi_i32(oi, make_memop_idx(MO_LEQ, ctx->mem_idx));
> +            gen_helper_lq_le_parallel(lo, cpu_env, EA, oi);
> +        } else {
> +            tcg_gen_movi_i32(oi, make_memop_idx(MO_BEQ, ctx->mem_idx));
> +            gen_helper_lq_be_parallel(lo, cpu_env, EA, oi);
> +        }
> +        tcg_temp_free_i32(oi);
> +        tcg_gen_ld_i64(hi, cpu_env, offsetof(CPUPPCState, retxh));
> +#else
> +        /* Restart with exclusive lock.  */
> +        gen_helper_exit_atomic(cpu_env);
> +        ctx->base.is_jmp =3D DISAS_NORETURN;
> +#endif
> +    } else if (ctx->le_mode) {
> +        tcg_gen_qemu_ld_i64(lo, EA, ctx->mem_idx, MO_LEQ);
>          gen_addr_add(ctx, EA, EA, 8);
> -        gen_qemu_ld64_i64(ctx, cpu_gpr[rd], EA);
> +        tcg_gen_qemu_ld_i64(hi, EA, ctx->mem_idx, MO_LEQ);
>      } else {
> -        gen_qemu_ld64_i64(ctx, cpu_gpr[rd], EA);
> +        tcg_gen_qemu_ld_i64(hi, EA, ctx->mem_idx, MO_BEQ);
>          gen_addr_add(ctx, EA, EA, 8);
> -        gen_qemu_ld64_i64(ctx, cpu_gpr[rd + 1], EA);
> +        tcg_gen_qemu_ld_i64(lo, EA, ctx->mem_idx, MO_BEQ);
>      }
>      tcg_temp_free(EA);
>  }
> @@ -3236,9 +3255,8 @@ STCX(stdcx_, DEF_MEMOP(MO_Q))
>  /* lqarx */
>  static void gen_lqarx(DisasContext *ctx)
>  {
> -    TCGv EA;
>      int rd =3D rD(ctx->opcode);
> -    TCGv gpr1, gpr2;
> +    TCGv EA, hi, lo;
> =20
>      if (unlikely((rd & 1) || (rd =3D=3D rA(ctx->opcode)) ||
>                   (rd =3D=3D rB(ctx->opcode)))) {
> @@ -3247,24 +3265,49 @@ static void gen_lqarx(DisasContext *ctx)
>      }
> =20
>      gen_set_access_type(ctx, ACCESS_RES);
> -    EA =3D tcg_temp_local_new();
> +    EA =3D tcg_temp_new();
>      gen_addr_reg_index(ctx, EA);
> -    gen_check_align(ctx, EA, 15);
> -    if (unlikely(ctx->le_mode)) {
> -        gpr1 =3D cpu_gpr[rd+1];
> -        gpr2 =3D cpu_gpr[rd];
> -    } else {
> -        gpr1 =3D cpu_gpr[rd];
> -        gpr2 =3D cpu_gpr[rd+1];
> -    }
> -    tcg_gen_qemu_ld_i64(gpr1, EA, ctx->mem_idx, DEF_MEMOP(MO_Q));
> -    tcg_gen_mov_tl(cpu_reserve, EA);
> -    gen_addr_add(ctx, EA, EA, 8);
> -    tcg_gen_qemu_ld_i64(gpr2, EA, ctx->mem_idx, DEF_MEMOP(MO_Q));
> =20
> -    tcg_gen_st_tl(gpr1, cpu_env, offsetof(CPUPPCState, reserve_val));
> -    tcg_gen_st_tl(gpr2, cpu_env, offsetof(CPUPPCState, reserve_val2));
> +    /* Note that the low part is always in RD+1, even in LE mode.  */
> +    lo =3D cpu_gpr[rd + 1];
> +    hi =3D cpu_gpr[rd];
> +
> +    if (tb_cflags(ctx->base.tb) & CF_PARALLEL) {
> +#ifdef CONFIG_ATOMIC128
> +        TCGv_i32 oi =3D tcg_temp_new_i32();
> +        if (ctx->le_mode) {
> +            tcg_gen_movi_i32(oi, make_memop_idx(MO_LEQ | MO_ALIGN_16,
> +                                                ctx->mem_idx));
> +            gen_helper_lq_le_parallel(lo, cpu_env, EA, oi);
> +        } else {
> +            tcg_gen_movi_i32(oi, make_memop_idx(MO_BEQ | MO_ALIGN_16,
> +                                                ctx->mem_idx));
> +            gen_helper_lq_be_parallel(lo, cpu_env, EA, oi);
> +        }
> +        tcg_temp_free_i32(oi);
> +        tcg_gen_ld_i64(hi, cpu_env, offsetof(CPUPPCState, retxh));
> +#else
> +        /* Restart with exclusive lock.  */
> +        gen_helper_exit_atomic(cpu_env);
> +        ctx->base.is_jmp =3D DISAS_NORETURN;
> +        tcg_temp_free(EA);
> +        return;
> +#endif
> +    } else if (ctx->le_mode) {
> +        tcg_gen_qemu_ld_i64(lo, EA, ctx->mem_idx, MO_LEQ | MO_ALIGN_16);
> +        tcg_gen_mov_tl(cpu_reserve, EA);
> +        gen_addr_add(ctx, EA, EA, 8);
> +        tcg_gen_qemu_ld_i64(hi, EA, ctx->mem_idx, MO_LEQ);
> +    } else {
> +        tcg_gen_qemu_ld_i64(hi, EA, ctx->mem_idx, MO_BEQ | MO_ALIGN_16);
> +        tcg_gen_mov_tl(cpu_reserve, EA);
> +        gen_addr_add(ctx, EA, EA, 8);
> +        tcg_gen_qemu_ld_i64(lo, EA, ctx->mem_idx, MO_BEQ);
> +    }
>      tcg_temp_free(EA);
> +
> +    tcg_gen_st_tl(hi, cpu_env, offsetof(CPUPPCState, reserve_val));
> +    tcg_gen_st_tl(lo, cpu_env, offsetof(CPUPPCState, reserve_val2));
>  }
> =20
>  /* stqcx. */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls0WuMACgkQbDjKyiDZ
s5L8kA/8DSa6wwynnzU2fOZ0V3NiuEm5OZB/yqANDHJ0gETMjqxl38LwHb5UhfaP
eEBVrc7YFhD5wcgIcAD6WeqRYQuINQXk80xDNPA36qA6WbYsJ651PE4Mbff2MoyM
W14+hO+4NIEAcOLWxX+C2qpJXlKIhP8nJ3fsXst9Yq+n8WRSEWALDrkYzg0rKPom
4mbXduZ3MvWCk2H5pqj5Yrpqs9gCeDO7xh8aK6tiWdI2j9rab0SW7cLBYOJNmMa5
mmPLVrYr2lk9BEtG9iAkjqlcdYGNz3GIZOY0XrxcpIi0lOH1exMBCF1Bc9p2D8hh
1N6pwIDo/2fNFtLzHK0Z3wDoorPydvDNtnabawrvDeSahDhUGFDijxLMUFgjpr1K
6buUPG3FD1vUbZoRw7RQNR6vRGjDmE3KTo1nZPcgAhVmeLNNgU7yRVzwc+xK3Fgu
yi1SnlOlNJVMdDyeaEgfRq6nMfdT+AaOmKalZJxqoABqN2NPV1yca4G7L3YbaZn7
8Ndk97DPv8jGdsjNAP4Mr0YFOI5mTXWoo6eoixmKCk0QhbVD3+qdDgxCzmrVU2hm
CEck2s5NehT5YktLfgmcrwFrWNoejkLk/P74eN/8ic20XePgtXCa0YUJZcq5PyIS
FQl7pOuXzb+1tOExvHWFHPjNI2pNWvYaTuTzMSM9ItXSmfQxM40=
=wmID
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
