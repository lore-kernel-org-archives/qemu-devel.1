Received: from eggs.gnu.org ([2001:4830:134:3::10]:35818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gYl20-00087c-EG
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 00:01:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gYl1x-0007TE-7E
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 00:01:28 -0500
Date: Mon, 17 Dec 2018 15:50:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181217045022.GB5597@umbus.fritz.box>
References: <20181215184222.15127-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
In-Reply-To: <20181215184222.15127-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: fix compilation breakage on
 windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 15, 2018 at 07:42:22PM +0100, C=E9dric Le Goater wrote:
> Fix the PPC_BIT definitions to use ULL instead in UL and replace
> __builtin_ffssl() by the equivalent ctz routines.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>=20
>  Compile tested with --cross-prefix=3Dx86_64-w64-mingw32-. When I have
>  some more time, I might try runtime on windows also.

Which version of the mingw compiler do you have?  As I've noted
elsewhere, I haven't been able to reproduce the problem with the mingw
in Fedora 29.

>  The PPC compile failures have been there for a while (pre 2.12) and
>  the MASK_TO_LSH macro was not used until the XIVE definitions were
>  introduced.
>=20
>  I let you guys decide on how you want to proceed, but I think it is
>  safe to merge this patch as a prereq of the pull request.
>=20
>  Thanks,
>=20
>  C.
>=20
>  target/ppc/cpu.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index ab68abe8a23c..a3d3e91eb4ce 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -70,18 +70,18 @@
>  #define PPC_ELF_MACHINE     EM_PPC
>  #endif
> =20
> -#define PPC_BIT(bit)            (0x8000000000000000UL >> (bit))
> -#define PPC_BIT32(bit)          (0x80000000UL >> (bit))
> -#define PPC_BIT8(bit)           (0x80UL >> (bit))
> +#define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
> +#define PPC_BIT32(bit)          (0x80000000ULL >> (bit))
> +#define PPC_BIT8(bit)           (0x80ULL >> (bit))

We shouldn't need the ULL for the 32-bit and (especially) 8-bit
versions.

>  #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(b=
s))
>  #define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
>                                   PPC_BIT32(bs))
>  #define PPC_BITMASK8(bs, be)    ((PPC_BIT8(bs) - PPC_BIT8(be)) | PPC_BIT=
8(bs))
> =20
>  #if HOST_LONG_BITS =3D=3D 32
> -# define MASK_TO_LSH(m)          (__builtin_ffsll(m) - 1)
> +# define MASK_TO_LSH(m)          ctz32(m)
>  #elif HOST_LONG_BITS =3D=3D 64
> -# define MASK_TO_LSH(m)          (__builtin_ffsl(m) - 1)
> +# define MASK_TO_LSH(m)          ctz64(m)

Having another look at this, this seems bogus: we're defining an
interface that's only correct on a *host long*.  But when we use it
we're almost certain to be working on guest values with a fixed size,
so using this wrapper just adds confusion.

I'm not really seeing any reason to use MASK_TO_LSH() rather than
using ctz32() and ctz64() explicitly.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwXKwwACgkQbDjKyiDZ
s5JVHxAAwqFXLiV9SlmEI/FbOUjnWMUZsq0fn97lyZo6YVLwWd/Uh41heNVJmW2e
i/GJ2li0hy8bZfJ6kydcjEgR2InVFhMu8H8KJMgJJ5VpndFaDeJjpzUI8enV0RSA
ymvXTlAFykN8jW+gqRLycZLTZFtl0cYmvRC8gW03Rg4N9dFjRontTAhqiBJrisdo
xqfJiZiXbcYPvjf5qhw52BKR7sGhGObdvJf85ZRkhVL79pHiCL2L51zw8YDTj6xM
GHWc2xeMbAsKo/f/oNDbAH17qcu+dqj+0ybHSNoKiGFODNwJZQNa+550NciC30rP
hjwj7/wz4H1LUVRzA4NA0z28RdRo3piR5YatqVU0ohue7ibcLh9kGuqM4Rb+NxKZ
g3McxfZS6/z4x8r0H0TdBXdXq2qriK4QWr6M4U4NlEtqI8YjtkpxwoUiUxFyyVV0
lknir8KQfBvS/M3GxAvapOMQz4y528BI/pnQ8uUiji64e9eYI8TJnapU2ARxJI7B
IyK98kuTFzupEidLVkHU72j7gFUX/zzA/9wmpQCEvj5X3wRH7RdNamiB3XBIpZbb
Jn/6q4chG5FZHIEPgMhPno1ScCoCcnXuI/tQH93vGqeZQmWGq3d1UMWcXADhCLRs
Ig4tbJc7JNlBGa2c7AejyHWhuR42gPOWCcF05Ee75zkpdmL+ms0=
=2NZ0
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
