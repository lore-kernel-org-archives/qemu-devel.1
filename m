Received: from eggs.gnu.org ([2001:4830:134:3::10]:50394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZ531-0004j9-Sv
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 21:23:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZ52z-0005Ai-4p
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 21:23:51 -0500
Date: Tue, 18 Dec 2018 13:23:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181218022339.GD23604@umbus.fritz.box>
References: <20181217223445.28594-1-clg@kaod.org>
	<20181217223445.28594-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5gxpn/Q6ypwruk0T"
Content-Disposition: inline
In-Reply-To: <20181217223445.28594-3-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v9 2/7] target/ppc: replace
 __builtin_ffssl() by the equivalent ctz routines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 11:34:40PM +0100, C=E9dric Le Goater wrote:
> And remove the intermediate MASK_TO_LSH macro which does not add any valu=
e.
>=20
> This fixes a compile breakage on windows.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

It's an improvement over what's there, but it still leaves macros
whose primary use would be for guest registers, but are typed
according to host values, which doesn't make much sense.

I think instead we should redefine your BE64 / BE32 variants in terms
of the existing extract*() and deposit*() primitives, and get rid of
the GETFIELD / SETFIELD macros.

> ---
>  target/ppc/cpu.h | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 527181c0f09f..f4ef4f214564 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -78,18 +78,21 @@
>                                   PPC_BIT32(bs))
>  #define PPC_BITMASK8(bs, be)    ((PPC_BIT8(bs) - PPC_BIT8(be)) | PPC_BIT=
8(bs))
> =20
> +/*
> + * OPAL PPC bitmask field manipulation, used in XIVE, PHB3 and PHB4
> + */
>  #if HOST_LONG_BITS =3D=3D 32
> -# define MASK_TO_LSH(m)          (__builtin_ffsll(m) - 1)
> +#  define GETFIELD(m, v)        (((v) & (m)) >> ctz32(m))
> +#  define SETFIELD(m, v, val)                                   \
> +    (((v) & ~(m)) | ((((typeof(v))(val)) << ctz32(m)) & (m)))
>  #elif HOST_LONG_BITS =3D=3D 64
> -# define MASK_TO_LSH(m)          (__builtin_ffsl(m) - 1)
> +#  define GETFIELD(m, v)        (((v) & (m)) >> ctz64(m))
> +#  define SETFIELD(m, v, val)                                   \
> +    (((v) & ~(m)) | ((((typeof(v))(val)) << ctz64(m)) & (m)))
>  #else
>  # error Unknown sizeof long
>  #endif
> =20
> -#define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
> -#define SETFIELD(m, v, val)                             \
> -        (((v) & ~(m)) | ((((typeof(v))(val)) << MASK_TO_LSH(m)) & (m)))
> -
>  /***********************************************************************=
******/
>  /* Exception vectors definitions                                        =
     */
>  enum {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5gxpn/Q6ypwruk0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwYWioACgkQbDjKyiDZ
s5L3LA//bbMjdy6l7i+UDKoRCPa5VIm/I5PfiOcza8n5PYBnwPkexJoJYQcXcBvW
hHt8BsXsc03p90fcaldtqrH8SuDqDReDY/OjNLnBdhHqPyoUY7BaTxETqARGscQv
HnoDDy3M2x0TC2kWOSf9qtNNYqZ6Wq6U5q+Dk/KzGVHevZYNtiJmYs0u9mwWn4Ru
iKJgD8evndmIJEwqHKd6/UdqPYt72PXHeCy31uKkMsygnJELvsxxJpdvydayDBxC
h7R9uyaT5Y7/15PlByS45wcoswbIxXKGPSwf1V4kHFIPLx6qK+wS1gww+cmDU0RF
tXT63A7NzjGf9+H34V0chSloNN4FndHmH8fyloNGk03rujPfusVlHygJNigb+gVT
BdUSe7FpJXwq4ezFisi623VnHM8AQLtK9VM0AZDSGORsMnEv/9XE1SaL5bAjawGh
3vgtlAikw2F9n0LmxSafmEDq7szTT4F2yvhuDZFd6jHrzfb6hbOzqtW4OCcy/7ys
BCFjtBqECzjh287dzeFIJZU6iXQjMu0AhVfaiwYzpwAv+W3tv3xILo/t+sez9cD4
iDpw2o23vKm0HA9iAki/PIKc4XuhnQ2IJK6vmvheRVFQseHmu8lL+8he3wd9A5o8
w3JvkRVh4Oey+hn4zqckdUwjNoOmHVdNP2eZxI2RS7MxbrfVRVw=
=IKjK
-----END PGP SIGNATURE-----

--5gxpn/Q6ypwruk0T--
