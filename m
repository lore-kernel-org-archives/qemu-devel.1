Received: from eggs.gnu.org ([2001:4830:134:3::10]:46680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbepn-0007c3-JC
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:51:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbepk-0006x5-GG
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:51:47 -0500
Date: Thu, 9 Feb 2017 12:20:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170209012033.GM17644@umbus.fritz.box>
References: <1486377000-25701-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1486377000-25701-2-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JvUS8mwutKMHKosv"
Content-Disposition: inline
In-Reply-To: <1486377000-25701-2-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] target-ppc: implement load atomic
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, Balamuruhan S <bala24@linux.vnet.ibm.com>, Harish S <harisrir@linux.vnet.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>


--JvUS8mwutKMHKosv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 06, 2017 at 03:59:57PM +0530, Nikunj A Dadhania wrote:
> From: Balamuruhan S <bala24@linux.vnet.ibm.com>
>=20
> lwat: Load Word Atomic
> ldat: Load Doubleword Atomic
>=20
> The instruction includes as function code (5 bits) which gives a detail
> on the operation to be performed. The patch implements five such
> functions.
>=20
> Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> Signed-off-by: Harish S <harisrir@linux.vnet.ibm.com>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> [ combine both lwat/ldat implementation using macro ]
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  target/ppc/internal.h  |  2 ++
>  target/ppc/translate.c | 50 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 52 insertions(+)
>=20
> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> index 5b5b180..1f441c6 100644
> --- a/target/ppc/internal.h
> +++ b/target/ppc/internal.h
> @@ -133,6 +133,8 @@ EXTRACT_HELPER(UIMM4, 16, 4);
>  EXTRACT_HELPER(NB, 11, 5);
>  /* Shift count */
>  EXTRACT_HELPER(SH, 11, 5);
> +/* lwat/stwat/ldat/lwat */
> +EXTRACT_HELPER(FC, 11, 5);
>  /* Vector shift count */
>  EXTRACT_HELPER(VSH, 6, 4);
>  /* Mask start */
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index b48abae..f59184f 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2976,6 +2976,54 @@ LARX(lbarx, DEF_MEMOP(MO_UB))
>  LARX(lharx, DEF_MEMOP(MO_UW))
>  LARX(lwarx, DEF_MEMOP(MO_UL))
> =20
> +#define LD_ATOMIC(name, memop, tp, op, eop)                             \
> +static void gen_##name(DisasContext *ctx)                               \
> +{                                                                       \
> +    int len =3D MEMOP_GET_SIZE(memop);                                  =
  \
> +    uint32_t gpr_FC =3D FC(ctx->opcode);                                =
  \
> +    TCGv EA =3D tcg_temp_local_new();                                   =
  \
> +    TCGv_##tp t0, t1;                                                   \
> +                                                                        \
> +    gen_addr_register(ctx, EA);                                         \
> +    if (len > 1) {                                                      \
> +        gen_check_align(ctx, EA, len - 1);                              \
> +    }                                                                   \
> +    t0 =3D tcg_temp_new_##tp();                                         =
  \
> +    t1 =3D tcg_temp_new_##tp();                                         =
  \
> +    tcg_gen_##op(t0, cpu_gpr[rD(ctx->opcode) + 1]);                     \
> +                                                                        \
> +    switch (gpr_FC) {                                                   \
> +    case 0: /* Fetch and add */                                         \
> +        tcg_gen_atomic_fetch_add_##tp(t1, EA, t0, ctx->mem_idx, memop); \
> +        break;                                                          \
> +    case 1: /* Fetch and xor */                                         \
> +        tcg_gen_atomic_fetch_xor_##tp(t1, EA, t0, ctx->mem_idx, memop); \
> +        break;                                                          \
> +    case 2: /* Fetch and or */                                          \
> +        tcg_gen_atomic_fetch_or_##tp(t1, EA, t0, ctx->mem_idx, memop);  \
> +        break;                                                          \
> +    case 3: /* Fetch and 'and' */                                       \
> +        tcg_gen_atomic_fetch_and_##tp(t1, EA, t0, ctx->mem_idx, memop); \
> +        break;                                                          \
> +    case 8: /* Swap */                                                  \
> +        tcg_gen_atomic_xchg_##tp(t1, EA, t0, ctx->mem_idx, memop);      \
> +        break;                                                          \
> +    default:                                                            \
> +        /* invoke data storage error handler */                         \
> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);             \

Both your comment and the ISA say that an invalid FC will result in a
data storage (0x300) exception, but here you seem to be invoking an
invalid instruction exception (0x700).  Which is correct?

> +        break;                                                          \
> +    }                                                                   \
> +    tcg_gen_##eop(cpu_gpr[rD(ctx->opcode)], t1);                        \
> +    tcg_temp_free_##tp(t0);                                             \
> +    tcg_temp_free_##tp(t1);                                             \
> +    tcg_temp_free(EA);                                                  \
> +}
> +
> +LD_ATOMIC(lwat, DEF_MEMOP(MO_UL), i32, trunc_tl_i32, extu_i32_tl)
> +#if defined(TARGET_PPC64)
> +LD_ATOMIC(ldat, DEF_MEMOP(MO_Q), i64, mov_i64, mov_i64)
> +#endif
> +
>  #if defined(CONFIG_USER_ONLY)
>  static void gen_conditional_store(DisasContext *ctx, TCGv EA,
>                                    int reg, int memop)
> @@ -6230,10 +6278,12 @@ GEN_HANDLER(isync, 0x13, 0x16, 0x04, 0x03FFF801, =
PPC_MEM),
>  GEN_HANDLER_E(lbarx, 0x1F, 0x14, 0x01, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
>  GEN_HANDLER_E(lharx, 0x1F, 0x14, 0x03, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
>  GEN_HANDLER(lwarx, 0x1F, 0x14, 0x00, 0x00000000, PPC_RES),
> +GEN_HANDLER_E(lwat, 0x1F, 0x06, 0x12, 0x00000001, PPC_NONE, PPC2_ISA300),
>  GEN_HANDLER_E(stbcx_, 0x1F, 0x16, 0x15, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
>  GEN_HANDLER_E(sthcx_, 0x1F, 0x16, 0x16, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
>  GEN_HANDLER2(stwcx_, "stwcx.", 0x1F, 0x16, 0x04, 0x00000000, PPC_RES),
>  #if defined(TARGET_PPC64)
> +GEN_HANDLER_E(ldat, 0x1F, 0x06, 0x13, 0x00000001, PPC_NONE, PPC2_ISA300),
>  GEN_HANDLER(ldarx, 0x1F, 0x14, 0x02, 0x00000000, PPC_64B),
>  GEN_HANDLER_E(lqarx, 0x1F, 0x14, 0x08, 0, PPC_NONE, PPC2_LSQ_ISA207),
>  GEN_HANDLER2(stdcx_, "stdcx.", 0x1F, 0x16, 0x06, 0x00000000, PPC_64B),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JvUS8mwutKMHKosv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYm8PfAAoJEGw4ysog2bOSNnwQAJsdGUGccr5lR7LFkLXr4m1X
IZzkqQRfKDqpYvn2261u9dbOZq8Y5lH0FhluCz/7vNIJjKfl7TRrO6qnJjeuoJ0Y
lk3iSvznZmmiJaAmwmEf7s8/ALGNYjMlZYSqwAGJy+xlU8MSel9qyeSBvbmYfrEZ
v9QhBBz2fxEtmtXDIsxBpVwyIyit0MHhrX8HgGFFesXoh1tRWbqAekSTkDmVgy1s
uByOtN+8gx36bFOlV6djmGCxqn4R46ypMR5Wo3MZ5XYZ9XazlLOeYEak40QJGGEx
t9iE/6h38Cmj2AGhfu7XGeCOuer1Me6Q8CF49TnEtKBu1gHxJyyD+H9yJDEgZ+Rq
R/gsxj2kvE5YI159LPkCk6rF8imo3H7g17l38PW0XN5xtGnywu5K4IvZT8A0hQ7R
vnSyjXNT2c2gk37KB5tPawmhrNZrQpW+QZrNGZMJvdC/FUQNFUCR4fcMlKZc3x59
uTcLcHmsjuxEmcFGIYWiYD6jnh61Kj0mLOL2ewieC1p40AYQFAT3RkXENAWO0I1B
V9vymZaOC27/j7zDj0JgJEYIHSnAIG9Q53GQco4YgfMGXQP0DF3+Wv6TYiK/UnyU
zbvareeoF7lqvuUiR452Bh+WnyZpKKvqAvNYAEA3hA7vQzwCOpsIAef8MadCoRWZ
0idylQDpb9U4uTDR+eFm
=Is9q
-----END PGP SIGNATURE-----

--JvUS8mwutKMHKosv--
