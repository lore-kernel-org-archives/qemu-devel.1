Received: from eggs.gnu.org ([2001:4830:134:3::10]:41783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbm-0001yk-Mp
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbk-0005ug-EK
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:34 -0500
Date: Wed, 19 Dec 2018 17:35:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181219063513.GT30570@umbus.fritz.box>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<20181218063911.2112-25-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VjP/dwTbBl6I9PQk"
Content-Disposition: inline
In-Reply-To: <20181218063911.2112-25-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 24/34] target/ppc: convert xxspltw to
 vector operations
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


--VjP/dwTbBl6I9PQk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 10:39:01PM -0800, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/translate/vsx-impl.inc.c | 36 +++++++++--------------------
>  1 file changed, 11 insertions(+), 25 deletions(-)
>=20
> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
> index d88d6bbd74..a040038ed4 100644
> --- a/target/ppc/translate/vsx-impl.inc.c
> +++ b/target/ppc/translate/vsx-impl.inc.c
> @@ -1318,38 +1318,24 @@ static void gen_xxsel(DisasContext * ctx)
> =20
>  static void gen_xxspltw(DisasContext *ctx)
>  {
> -    TCGv_i64 b, b2;
> -    TCGv_i64 vsr;
> -
> -    vsr =3D tcg_temp_new_i64();
> -    if (UIM(ctx->opcode) & 2) {
> -        get_cpu_vsrl(vsr, xB(ctx->opcode));
> -    } else {
> -        get_cpu_vsrh(vsr, xB(ctx->opcode));
> -    }
> +    int rt =3D xT(ctx->opcode);
> +    int rb =3D xB(ctx->opcode);
> +    int uim =3D UIM(ctx->opcode);
> +    int tofs, bofs;
> =20
>      if (unlikely(!ctx->vsx_enabled)) {
>          gen_exception(ctx, POWERPC_EXCP_VSXU);
>          return;
>      }
> =20
> -    b =3D tcg_temp_new_i64();
> -    b2 =3D tcg_temp_new_i64();
> +    tofs =3D vsr_full_offset(rt);
> +    bofs =3D vsr_full_offset(rb);
> +    bofs +=3D uim << MO_32;
> +#ifndef HOST_WORDS_BIG_ENDIAN
> +    bofs ^=3D 8 | 4;
> +#endif
> =20
> -    if (UIM(ctx->opcode) & 1) {
> -        tcg_gen_ext32u_i64(b, vsr);
> -    } else {
> -        tcg_gen_shri_i64(b, vsr, 32);
> -    }
> -
> -    tcg_gen_shli_i64(b2, b, 32);
> -    tcg_gen_or_i64(vsr, b, b2);
> -    set_cpu_vsrh(xT(ctx->opcode), vsr);
> -    set_cpu_vsrl(xT(ctx->opcode), vsr);
> -
> -    tcg_temp_free_i64(vsr);
> -    tcg_temp_free_i64(b);
> -    tcg_temp_free_i64(b2);
> +    tcg_gen_gvec_dup_mem(MO_32, tofs, bofs, 16, 16);
>  }
> =20
>  #define pattern(x) (((x) & 0xff) * (~(uint64_t)0 / 0xff))

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VjP/dwTbBl6I9PQk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwZ5qEACgkQbDjKyiDZ
s5J+nhAAuMQGg/T0RmRWpggCI5NnO1pwhb007nNJY4j76jp4H3GsTsLG9HSqSu4M
Sn20odmrB7VtbFcBUEZ2+ig8HtO1fCqqxQj6zC2odLpPp0GEiw755HevQ7eJUuE4
dtACvNJTgFq9TLljELIY6iJv4Ec52J6H44FGuzdbhf3GGaVncbCDJmCf573Pi2Fi
um8YoS8wx26eTtIPMXaX6Dz0ZUv+Qm1Xs6snYrrGs6lhR31g2nHR3b+5B46kNNkO
R4eghBdyHnX+xHUyiA+4Zz0aUAqlxK/QZisg6kOjrWX33Enr6aTkwC324a6wXIZz
i5q0PNavwd2HpM1eJ8B/5bDLP4oEj00U3HQWE2LzDnEwi0vx+J2tMX6dgHZ/00U6
DMJRB3APhJncYkok12M3OKpTABmyOq7Ta7kqwmHixZSVzd9cIi8iW1Rs9mQee4iE
CyzEuEbXUmvo988MMb1jKM960YnkzpU/KK/yo85t4HKE2cYptWlKMHqU5sfg4HGw
afkKNwJj3yuswB2HNxuqFcFQ28QVQ35MHIiM7YiDFsP7a/K6E/0p8VgwYpJgVVdR
IZSff5KSR4w74mvb4c+EWg3gwxJfbk4Uyl6HLwZMtDut5d+r1thJCHfT6ZZI11Vr
JUgq7qhNwEpSC5SowcW110S2rvx15OiQov8jC3vMTDJ/jJEvfd4=
=JNw9
-----END PGP SIGNATURE-----

--VjP/dwTbBl6I9PQk--
