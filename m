Received: from eggs.gnu.org ([2001:4830:134:3::10]:41760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbm-0001yW-7W
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbj-0005t4-LY
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:34 -0500
Date: Wed, 19 Dec 2018 17:33:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181219063338.GR30570@umbus.fritz.box>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<20181218063911.2112-23-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0Qexx6XJGNEACt6j"
Content-Disposition: inline
In-Reply-To: <20181218063911.2112-23-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 22/34] target/ppc: convert VSX logical
 operations to vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org


--0Qexx6XJGNEACt6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 10:38:59PM -0800, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/translate/vsx-impl.inc.c | 43 ++++++++++++-----------------
>  1 file changed, 17 insertions(+), 26 deletions(-)
>=20
> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
> index 1608ad48b1..8ab1290026 100644
> --- a/target/ppc/translate/vsx-impl.inc.c
> +++ b/target/ppc/translate/vsx-impl.inc.c
> @@ -10,6 +10,11 @@ static inline void set_vsr(int n, TCGv_i64 src)
>      tcg_gen_st_i64(src, cpu_env, offsetof(CPUPPCState, vsr[n].u64[1]));
>  }
> =20
> +static inline int vsr_full_offset(int n)
> +{
> +    return offsetof(CPUPPCState, vsr[n].u64[0]);
> +}
> +
>  static inline void get_cpu_vsrh(TCGv_i64 dst, int n)
>  {
>      if (n < 32) {
> @@ -1214,40 +1219,26 @@ static void gen_xxbrw(DisasContext *ctx)
>      tcg_temp_free_i64(xbl);
>  }
> =20
> -#define VSX_LOGICAL(name, tcg_op)                                    \
> +#define VSX_LOGICAL(name, vece, tcg_op)                              \
>  static void glue(gen_, name)(DisasContext * ctx)                     \
>      {                                                                \
> -        TCGv_i64 t0;                                                 \
> -        TCGv_i64 t1;                                                 \
> -        TCGv_i64 t2;                                                 \
>          if (unlikely(!ctx->vsx_enabled)) {                           \
>              gen_exception(ctx, POWERPC_EXCP_VSXU);                   \
>              return;                                                  \
>          }                                                            \
> -        t0 =3D tcg_temp_new_i64();                                     \
> -        t1 =3D tcg_temp_new_i64();                                     \
> -        t2 =3D tcg_temp_new_i64();                                     \
> -        get_cpu_vsrh(t0, xA(ctx->opcode));                           \
> -        get_cpu_vsrh(t1, xB(ctx->opcode));                           \
> -        tcg_op(t2, t0, t1);                                          \
> -        set_cpu_vsrh(xT(ctx->opcode), t2);                           \
> -        get_cpu_vsrl(t0, xA(ctx->opcode));                           \
> -        get_cpu_vsrl(t1, xB(ctx->opcode));                           \
> -        tcg_op(t2, t0, t1);                                          \
> -        set_cpu_vsrl(xT(ctx->opcode), t2);                           \
> -        tcg_temp_free_i64(t0);                                       \
> -        tcg_temp_free_i64(t1);                                       \
> -        tcg_temp_free_i64(t2);                                       \
> +        tcg_op(vece, vsr_full_offset(xT(ctx->opcode)),               \
> +               vsr_full_offset(xA(ctx->opcode)),                     \
> +               vsr_full_offset(xB(ctx->opcode)), 16, 16);            \
>      }
> =20
> -VSX_LOGICAL(xxland, tcg_gen_and_i64)
> -VSX_LOGICAL(xxlandc, tcg_gen_andc_i64)
> -VSX_LOGICAL(xxlor, tcg_gen_or_i64)
> -VSX_LOGICAL(xxlxor, tcg_gen_xor_i64)
> -VSX_LOGICAL(xxlnor, tcg_gen_nor_i64)
> -VSX_LOGICAL(xxleqv, tcg_gen_eqv_i64)
> -VSX_LOGICAL(xxlnand, tcg_gen_nand_i64)
> -VSX_LOGICAL(xxlorc, tcg_gen_orc_i64)
> +VSX_LOGICAL(xxland, MO_64, tcg_gen_gvec_and)
> +VSX_LOGICAL(xxlandc, MO_64, tcg_gen_gvec_andc)
> +VSX_LOGICAL(xxlor, MO_64, tcg_gen_gvec_or)
> +VSX_LOGICAL(xxlxor, MO_64, tcg_gen_gvec_xor)
> +VSX_LOGICAL(xxlnor, MO_64, tcg_gen_gvec_nor)
> +VSX_LOGICAL(xxleqv, MO_64, tcg_gen_gvec_eqv)
> +VSX_LOGICAL(xxlnand, MO_64, tcg_gen_gvec_nand)
> +VSX_LOGICAL(xxlorc, MO_64, tcg_gen_gvec_orc)
> =20
>  #define VSX_XXMRG(name, high)                               \
>  static void glue(gen_, name)(DisasContext * ctx)            \

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0Qexx6XJGNEACt6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwZ5kIACgkQbDjKyiDZ
s5JCuA/+O3sQwGJAvNK4hqP++9aSbpM67aJg3KhrtVETWSC1hQu8S7HWBjlCnCqL
PNSpSlSBkLxr5BvN5UfvzD8I7keyorFVlA+Hyg20VIlaY4aXMuqoVcnqkngnFz3z
2u2aKHs3FSFIrJqk6EVtCpxJe8drVGbmqwiUek3k4ilYvLPTef6mXk1kf81F8Rqv
6A7Er6Ch6pO6t3/f/+2yBE8jeeRn21B9GWyDPC+a/m4p1D4+UvxgbzAqX2VPiUsb
kP60PuEBF7uL2CFLUFb56LRsraTEt8mHfSKSAAh9Bh06/78WqZtzsnBekjzooSK6
G6gVsdI7HxWUN0VsszmNN/mkZvtCfgf0rmicVV2de6ppy/jI2hhxUVq7p1OJegZZ
a/So6lX7PFVrl8STU9UADa5N6VGhUQd/2VSKx1UdGCJQDYlJ2IHuLODQz02VX+t4
F0spVgxX//ERmzZw/BNDzOm1oSGoU2L6Ox3Yh7NleeMBARXiS3vse9FnugRcNF+w
RnBTxnw6Zv0+78bZ7Ax+Ahdb+ZUA5Nrt+33rvzBZXgvxPcZ7QQefXhH2nb5Jp5PG
MVzGx9ySHgIUAtA1nk2bQLa34Qd3I7tHcpvYcDlnHjW4eyzPReWw3C68O8dcKHWP
LpnPzkOyoQAvf8TTYQSeC1QPCwa54/mqw71YGyHlWaKOVvrsuJA=
=6y0L
-----END PGP SIGNATURE-----

--0Qexx6XJGNEACt6j--
