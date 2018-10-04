Received: from eggs.gnu.org ([2001:4830:134:3::10]:56377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g7rM9-0006uU-Mk
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 20:19:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g7rM8-0004UB-Cz
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 20:19:05 -0400
Date: Thu, 4 Oct 2018 10:18:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181004001847.GC7004@umbus.fritz.box>
References: <20181003180711.19335-1-richard.henderson@linaro.org>
	<20181003180711.19335-5-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Content-Disposition: inline
In-Reply-To: <20181003180711.19335-5-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] softfloat: Specialize udiv_qrnnd
 for ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, cota@braap.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 03, 2018 at 01:07:11PM -0500, Richard Henderson wrote:
> The ISA has a 128/64-bit division instruction, though it assumes the
> low 64-bits of the numerator are 0, and so requires a bit more fixup
> than a full 128-bit division insn.
>=20
> Cc: qemu-ppc@nongnu.org
> Cc: Alexander Graf <agraf@suse.de>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/fpu/softfloat-macros.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macro=
s.h
> index e702607b43..001bf4f23c 100644
> --- a/include/fpu/softfloat-macros.h
> +++ b/include/fpu/softfloat-macros.h
> @@ -632,6 +632,22 @@ static inline uint64_t udiv_qrnnd(uint64_t *r, uint6=
4_t n1,
>      asm("dlgr %0, %1" : "+r"(n) : "r"(d));
>      *r =3D n >> 64;
>      return n;
> +#elif defined(_ARCH_PPC64)
> +    /* From Power ISA 3.0B, programming note for divdeu.  */
> +    uint64_t q1, q2, Q, r1, r2, R;
> +    asm("divdeu %0,%2,%4; divdu %1,%3,%4"
> +        : "=3D&r"(q1), "=3Dr"(q2)
> +        : "r"(n1), "r"(n0), "r"(d));
> +    r1 =3D -(q1 * d);         /* low part of (n1<<64) - (q1 * d) */
> +    r2 =3D n0 - (q2 * d);
> +    Q =3D q1 + q2;
> +    R =3D r2 + r1;
> +    if (R < r2 || R >=3D d) { /* overflow implies R > d */
> +        Q +=3D 1;
> +        R -=3D d;
> +    }
> +    *r =3D R;
> +    return Q;
>  #else
>      uint64_t d0, d1, q0, q1, r1, r0, m;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu1XGIACgkQbDjKyiDZ
s5JAqw//RyatfCwmSIvaGOxiXkAzZ6v7O/6D8QYaFXuXESctYiiJFp58BYLDoz+8
HkOc5S5ErqYo80VzA5JJGLxvZbtfdOc+rAPmlkMMJdM+JP5eYETcWSzgTJz+EtNd
F+UJunaKVnM3zNeJn2QWhUSjqLSQ9Pyo97y9cyA03OA+EJz6v0PMce3nmoCkKZQP
/PgVCSYByacdzAQ3ZJ38jqFN38gr6ODbZl1ANLnNXDPv3s+bkXN4fl9EbAFyvGXD
wAufstg8YJArm1xQT4TS4MuhcwB5Tzj0+UUnki/ftroaA/XZU7Usgw1PxHsazsrm
KpKFtSdvwzfQ2HDpYQX1s9kkv4m32k/1xNf03UvaioB40uCIlXV0YbFb1YMZy5aI
aDe9rh+r/M33DKd64t6NYb/lDO35db9VaF0IA3NI4+bO0yFOJGpjmwttJkvg3Q05
ZcOfT/Ev7YODf7SrcQXFxx5i8wcTgrZpMAix9zcI0vO/Gs0fbomyhMQ234jdBd2R
tIXxEk3X9bwM/HgNwcI1zU7OymTshSiE4oQkhFkpMXMkDX1ZO6Gfs/vFUl+Z/G1Q
wrFcgMqbfCly49XNUKZGxoeSQW/qiXzpypOwfBx3jdx8J3NyGPx8/HhWeGWDN8oB
+VPByItLGqaiI2/sp51U8fHf286g30CwSqB8m5ALNT558BeqiY8=
=0vej
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
