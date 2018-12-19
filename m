Received: from eggs.gnu.org ([2001:4830:134:3::10]:41901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbq-00020s-6V
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbn-0005yc-09
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:38 -0500
Date: Wed, 19 Dec 2018 17:40:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181219064034.GA30570@umbus.fritz.box>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<20181218063911.2112-32-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q5wOvoHkaccQRDme"
Content-Disposition: inline
In-Reply-To: <20181218063911.2112-32-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 31/34] target/ppc: Add set_vscr_sat
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


--q5wOvoHkaccQRDme
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 10:39:08PM -0800, Richard Henderson wrote:
> This is required before changing the representation of the register.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/int_helper.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
>=20
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index 75201bbba6..38aa3e85a6 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -480,6 +480,11 @@ uint32_t helper_mfvscr(CPUPPCState *env)
>      return env->vscr;
>  }
> =20
> +static inline void set_vscr_sat(CPUPPCState *env)
> +{
> +    env->vscr |=3D 1 << VSCR_SAT;
> +}
> +
>  void helper_vaddcuw(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
>  {
>      int i;
> @@ -593,7 +598,7 @@ VARITHFPFMA(nmsubfp, float_muladd_negate_result | flo=
at_muladd_negate_c);
>              }                                                           \
>          }                                                               \
>          if (sat) {                                                      \
> -            env->vscr |=3D (1 << VSCR_SAT);                             =
  \
> +            set_vscr_sat(env);                                          \
>          }                                                               \
>      }
>  #define VARITHSAT_SIGNED(suffix, element, optype, cvt)          \
> @@ -865,7 +870,7 @@ void helper_vcmpbfp_dot(CPUPPCState *env, ppc_avr_t *=
r, ppc_avr_t *a,
>              }                                                           \
>          }                                                               \
>          if (sat) {                                                      \
> -            env->vscr |=3D (1 << VSCR_SAT);                             =
  \
> +            set_vscr_sat(env);                                          \
>          }                                                               \
>      }
>  VCT(uxs, cvtsduw, u32)
> @@ -916,7 +921,7 @@ void helper_vmhaddshs(CPUPPCState *env, ppc_avr_t *r,=
 ppc_avr_t *a,
>      }
> =20
>      if (sat) {
> -        env->vscr |=3D (1 << VSCR_SAT);
> +        set_vscr_sat(env);
>      }
>  }
> =20
> @@ -933,7 +938,7 @@ void helper_vmhraddshs(CPUPPCState *env, ppc_avr_t *r=
, ppc_avr_t *a,
>      }
> =20
>      if (sat) {
> -        env->vscr |=3D (1 << VSCR_SAT);
> +        set_vscr_sat(env);
>      }
>  }
> =20
> @@ -1061,7 +1066,7 @@ void helper_vmsumshs(CPUPPCState *env, ppc_avr_t *r=
, ppc_avr_t *a,
>      }
> =20
>      if (sat) {
> -        env->vscr |=3D (1 << VSCR_SAT);
> +        set_vscr_sat(env);
>      }
>  }
> =20
> @@ -1114,7 +1119,7 @@ void helper_vmsumuhs(CPUPPCState *env, ppc_avr_t *r=
, ppc_avr_t *a,
>      }
> =20
>      if (sat) {
> -        env->vscr |=3D (1 << VSCR_SAT);
> +        set_vscr_sat(env);
>      }
>  }
> =20
> @@ -1633,7 +1638,7 @@ void helper_vpkpx(ppc_avr_t *r, ppc_avr_t *a, ppc_a=
vr_t *b)
>          }                                                               \
>          *r =3D result;                                                  =
  \
>          if (dosat && sat) {                                             \
> -            env->vscr |=3D (1 << VSCR_SAT);                             =
  \
> +            set_vscr_sat(env);                                          \
>          }                                                               \
>      }
>  #define I(x, y) (x)
> @@ -2106,7 +2111,7 @@ void helper_vsumsws(CPUPPCState *env, ppc_avr_t *r,=
 ppc_avr_t *a, ppc_avr_t *b)
>      *r =3D result;
> =20
>      if (sat) {
> -        env->vscr |=3D (1 << VSCR_SAT);
> +        set_vscr_sat(env);
>      }
>  }
> =20
> @@ -2133,7 +2138,7 @@ void helper_vsum2sws(CPUPPCState *env, ppc_avr_t *r=
, ppc_avr_t *a, ppc_avr_t *b)
> =20
>      *r =3D result;
>      if (sat) {
> -        env->vscr |=3D (1 << VSCR_SAT);
> +        set_vscr_sat(env);
>      }
>  }
> =20
> @@ -2152,7 +2157,7 @@ void helper_vsum4sbs(CPUPPCState *env, ppc_avr_t *r=
, ppc_avr_t *a, ppc_avr_t *b)
>      }
> =20
>      if (sat) {
> -        env->vscr |=3D (1 << VSCR_SAT);
> +        set_vscr_sat(env);
>      }
>  }
> =20
> @@ -2169,7 +2174,7 @@ void helper_vsum4shs(CPUPPCState *env, ppc_avr_t *r=
, ppc_avr_t *a, ppc_avr_t *b)
>      }
> =20
>      if (sat) {
> -        env->vscr |=3D (1 << VSCR_SAT);
> +        set_vscr_sat(env);
>      }
>  }
> =20
> @@ -2188,7 +2193,7 @@ void helper_vsum4ubs(CPUPPCState *env, ppc_avr_t *r=
, ppc_avr_t *a, ppc_avr_t *b)
>      }
> =20
>      if (sat) {
> -        env->vscr |=3D (1 << VSCR_SAT);
> +        set_vscr_sat(env);
>      }
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--q5wOvoHkaccQRDme
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwZ5+EACgkQbDjKyiDZ
s5I8gxAAl/+KTR2UHCJWqLkoKUWfW75TD2uhT+byGnTnEfcyyP2Qe8oSj4a3YNZQ
jDYnzBwjmRcTeH3ndyzT/ruHws+uZb/Conw0GDiOtfpDfpoVHOZ/p/UHMso6nedO
aMwSgpkYxQCGf3gJl8laGpeqcjP3sEbHyVUHCumpQw4tf6STEwqdnCw8iCWFvT2o
Abshyli7BUclu92ZQAUUfJQn8wKHSfZkv0GWwlCMfL/cXIk3hMJcipfkU34vjBL1
wR7h7OB6VfCvPulQIgWF0fa5Pw9NUOv4RoxzSmy2JLiSlx16Ksys05wKOW1wlwVW
1gOGRUitAByscNcWHDgo/HO6ANAHxzNU0cR9ZVBPvhOtMFHgmfwDxpa7takEAI0n
iN59ySpf+c3hqCRhrCNdbwUNjGm+4vMxXxpKd8OiROPLddoWRyi9jzLpgaZQXHkw
txxR1GTHGCE+G6d01dCMMG3/bERmc+CV9TaOScAOf32kGNKQut7uSzcJQx1f6ft+
KSOSWLNm6y5ecACalDXpDyTYcZH77qcjp7uMjBZpe1hFJ1P9bmYdeJavHNIFqR1g
YqmFKJ4UmzEFKIQ5D91RRyUhV1eVyIB28F1fXwveRZ1EHw8WKwuDxMpBjJtYg8Bd
kwZFxX5AYMxbjIJb9lxTF43CZ1stNR9d900AdFoGm+cOa0fDSWU=
=p49+
-----END PGP SIGNATURE-----

--q5wOvoHkaccQRDme--
