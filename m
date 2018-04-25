Received: from eggs.gnu.org ([2001:4830:134:3::10]:46116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBDvg-0001MB-Lq
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 02:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBDvd-0002Hw-Ft
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 02:29:24 -0400
Received: from ozlabs.org ([203.11.71.1]:35893)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fBDvc-0002GP-Ez
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 02:29:21 -0400
Date: Wed, 25 Apr 2018 16:29:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180425062908.GS19804@umbus.fritz.box>
References: <20180424222103.19946-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ShzQXCswyqjgWi6k"
Content-Disposition: inline
In-Reply-To: <20180424222103.19946-1-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v4] loader: Fix misaligned member access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Paul Burton <paul.burton@mips.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>


--ShzQXCswyqjgWi6k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 07:21:03PM -0300, Philippe Mathieu-Daud=E9 wrote:
> The libfdt does not guarantee than fdt_getprop() returns a pointer
> aligned to the property size.
>=20
> Assuming the base of the fdt is aligned, a 32-bit property returns
> a 32-bit aligned pointer. This is however not guaranteed for 64-bit
> properties, where 64-bit loads might trigger unaligned access.
>=20
> Fix the 64-bit access using the ldst (host) API, which uses a local
> copy on the stack, thus guaranteeing a safe aligned access.
>=20
> This fixes the following ASan warning:
>=20
>   $ qemu-system-mips64el -M boston -kernel vmlinux.gz.itb -nographic
>   hw/core/loader-fit.c:108:17: runtime error: load of misaligned address =
0x7f95cd7e4264 for type 'fdt64_t', which requires 8 byte alignment
>   0x7f95cd7e4264: note: pointer points here
>     00 00 00 3e ff ff ff ff  80 7d 2a c0 00 00 00 01  68 61 73 68 40 30 0=
0 00  00 00 00 03 00 00 00 14
>                 ^
>=20
> Reported-by: AddressSanitizer
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

I'll look at adding a hlper for this to libfdt, but no promises on timefram=
e.

> ---
> v4: do not change the 32-bit access, use ldq_he_p() for the 64-bit access
> v3: do not use memcpy(), incorrectly change ldl_he_p()
> v2: do not change the 32-bit access, use memcpy(), add comments (David Gi=
bson)
> v1: use memcpy()
>=20
>  hw/core/loader-fit.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
> index 0c4a7207f4..ed4140061b 100644
> --- a/hw/core/loader-fit.c
> +++ b/hw/core/loader-fit.c
> @@ -102,10 +102,17 @@ static int fit_image_addr(const void *itb, int img,=
 const char *name,
> =20
>      switch (len) {
>      case 4:
> +        /* Assuming the base of the fdt is aligned, then fdt_getprop()
> +         * returns 32-bit aligned properties, so this load is guaranteed
> +         * to be 32-bit aligned.
> +         */
>          *addr =3D fdt32_to_cpu(*(fdt32_t *)prop);
>          return 0;
>      case 8:
> -        *addr =3D fdt64_to_cpu(*(fdt64_t *)prop);
> +        /* Since the property is not guaranteed to be 64-bit aligned,
> +         * use ldq_he_p()'s stack to avoid an unaligned load.
> +         */
> +        *addr =3D fdt64_to_cpu(ldq_he_p(prop));
>          return 0;
>      default:
>          error_printf("invalid %s address length %d\n", name, len);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ShzQXCswyqjgWi6k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrgIDEACgkQbDjKyiDZ
s5LbERAA18DsEDR073uAKOtXrMbFT/V/+dynlZhjnM/ZzPSidN/vRS5oO8PKX8QU
L4kNSDLtl5RcUCU1Dlmrgl7yjk6ij9fUpdprgDrkweOl+rKBLeBNiIh4JtN0nXpX
1q/5o1P9g6IYwGYzQzYQgfzndPH0N8i0TKZRPjhWew2BUnyoOsLawWjJj8YqDXpk
0cZbPx3ljPwXVI0AlFHlBLDtNFy1UK2qgk3RflwN74C9ZGqFob9W32pz7fu6pJNJ
6bLWBtVIB2t7gSNhl8/85vL4Q+VvrMns4sFePBRznjcIgrtMZWZfZVSPUJhJir9t
qjMHv/hu+4q+cJ/QNGRg06A/Q2WDAq6VOQyXJLu74xpdDER0KSW/IXUoGPxFNzxA
FNQebWLbt8rxx+ZfCZo+dWuik5rIWU58Nof0yesQjiYTkQINzUzs+Tkduq6lD/Bk
u1MdbQTyO8YKr9ZcjOOB2NN9pONtiKgDWKryUaGLaZQcNfqTt/nrPwBOR8KycU1O
HywnAEt/b8IQnp0F7pRa5qmDr2JDGrS64PcxjXj7GENWPFKR1bYqwWbIMhZy2G0n
UcE19jJnPP+imFtzEbVxQcfcPrFjOwMiuzHXUWPOboRwShVfS6RS95Rqg533G9LW
cb7frZh+rjllyO8OdAB2k+czAaP/XbMH4PIW/yTkXXJhSTC6vCY=
=oPt2
-----END PGP SIGNATURE-----

--ShzQXCswyqjgWi6k--
