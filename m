Received: from eggs.gnu.org ([2001:4830:134:3::10]:41293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZUrp-0002Gl-Qa
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 00:58:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZUro-0007Lo-Qq
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 00:58:01 -0500
Date: Wed, 19 Dec 2018 16:36:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181219053637.GD30570@umbus.fritz.box>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<20181218063911.2112-2-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Content-Disposition: inline
In-Reply-To: <20181218063911.2112-2-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 01/34] tcg: Add logical simplifications
 during gvec expand
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


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 10:38:38PM -0800, Richard Henderson wrote:
> We handle many of these during integer expansion, and the
> rest of them during integer optimization.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  tcg/tcg-op-gvec.c | 35 ++++++++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)
>=20
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index 61c25f5784..ec231b78fb 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -1840,7 +1840,12 @@ void tcg_gen_gvec_and(unsigned vece, uint32_t dofs=
, uint32_t aofs,
>          .opc =3D INDEX_op_and_vec,
>          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>      };
> -    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
> +
> +    if (aofs =3D=3D bofs) {
> +        tcg_gen_gvec_mov(vece, dofs, aofs, oprsz, maxsz);
> +    } else {
> +        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
> +    }
>  }
> =20
>  void tcg_gen_gvec_or(unsigned vece, uint32_t dofs, uint32_t aofs,
> @@ -1853,7 +1858,12 @@ void tcg_gen_gvec_or(unsigned vece, uint32_t dofs,=
 uint32_t aofs,
>          .opc =3D INDEX_op_or_vec,
>          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>      };
> -    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
> +
> +    if (aofs =3D=3D bofs) {
> +        tcg_gen_gvec_mov(vece, dofs, aofs, oprsz, maxsz);
> +    } else {
> +        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
> +    }
>  }
> =20
>  void tcg_gen_gvec_xor(unsigned vece, uint32_t dofs, uint32_t aofs,
> @@ -1866,7 +1876,12 @@ void tcg_gen_gvec_xor(unsigned vece, uint32_t dofs=
, uint32_t aofs,
>          .opc =3D INDEX_op_xor_vec,
>          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>      };
> -    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
> +
> +    if (aofs =3D=3D bofs) {
> +        tcg_gen_gvec_dup8i(dofs, oprsz, maxsz, 0);
> +    } else {
> +        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
> +    }
>  }
> =20
>  void tcg_gen_gvec_andc(unsigned vece, uint32_t dofs, uint32_t aofs,
> @@ -1879,7 +1894,12 @@ void tcg_gen_gvec_andc(unsigned vece, uint32_t dof=
s, uint32_t aofs,
>          .opc =3D INDEX_op_andc_vec,
>          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>      };
> -    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
> +
> +    if (aofs =3D=3D bofs) {
> +        tcg_gen_gvec_dup8i(dofs, oprsz, maxsz, 0);
> +    } else {
> +        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
> +    }
>  }
> =20
>  void tcg_gen_gvec_orc(unsigned vece, uint32_t dofs, uint32_t aofs,
> @@ -1892,7 +1912,12 @@ void tcg_gen_gvec_orc(unsigned vece, uint32_t dofs=
, uint32_t aofs,
>          .opc =3D INDEX_op_orc_vec,
>          .prefer_i64 =3D TCG_TARGET_REG_BITS =3D=3D 64,
>      };
> -    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
> +
> +    if (aofs =3D=3D bofs) {
> +        tcg_gen_gvec_dup8i(dofs, oprsz, maxsz, -1);
> +    } else {
> +        tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
> +    }
>  }
> =20
>  static const GVecGen2s gop_ands =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--48TaNjbzBVislYPb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwZ2N8ACgkQbDjKyiDZ
s5Iw6BAAnpsTwHnS13/VjOZUJkZhH/1EJpJEf2W9tcJBEHex5lhrx6k5bMkUcoN1
wltblFqW+JQ8T6TK6vsaE3imQnt/kgulAz/Wl8PrJBlOsvhfs8gJ2ActGlfnObT+
/vvmuE3aZTjJttAKh37XfIGUGmXCBTIa/7pJmHWuYniSu2uVbe4oYE8xxnIACuBD
tmuWOLKQiZpzO53RaWOpJSK/oHiFTyRuHHpIFvwI+mBRh+t0WDPDSZEj5PfhGkwx
cLK1Qw6Lilx+uKtz8g9AV8mwfm3PExN351K60jU4PCRvaWMSzuPkVBiIDRxIEImi
PrEJ23NxI7ZJFGuxPry+dsUgpJhIT/LPCN0hYj2709dWg5yFITirLgVZd9GHv/zv
e8L4Ga2iMwNNyvLOs9PmLtz8luiahcbB1/51M44/48IS5KMOkEs4xh9Xz18ItpRN
CvAAbuE8Bq388M0y3E6E9h5wsi7CVtYx/BdWO31aDas3JIbRN1MHWfsvrS8C7KiL
T67IQzfnVFQhad9FEX8yC3Bq1RBcz5HsI+9LSv7EUjKguIiNDcVb0Wx74PvgeMZ4
Da5606gIHmYYWqM5FhWcJALdJwZRfXogWq2UGV1tI3Hf1vSvt3IXNxPCOG8EqOHO
h96Pv9GRsEkoFM2Iq2VSXSfKiNuT4MAAamH5Erd+7ZCVjUlkaUo=
=oac+
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--
