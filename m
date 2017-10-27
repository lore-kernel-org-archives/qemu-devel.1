Received: from eggs.gnu.org ([2001:4830:134:3::10]:57936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e8CcH-00029W-L2
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 17:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e8CcG-0001zv-JX
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 17:56:37 -0400
Date: Fri, 27 Oct 2017 23:46:33 +0200
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171027214633.GH7115@umbus>
References: <20171026011346.5758-1-programmingkidx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CNfT9TXqV7nd4cfk"
Content-Disposition: inline
In-Reply-To: <20171026011346.5758-1-programmingkidx@gmail.com>
Subject: Re: [Qemu-devel] [libfdt][PATCH v4] implement strnlen for systems
 that need it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: stefanha@gmail.com, peter.maydell@linaro.org, richard.henderson@linaro.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, devicetree-compiler@vger.kernel.org, ian@freebsd.org


--CNfT9TXqV7nd4cfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2017 at 09:13:46PM -0400, John Arbuckle wrote:
> Prior the Mac OS 10.7, the function strnlen() was not available. This pat=
ch
> implements strnlen() on Mac OS X versions that are below 10.7.
>=20
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>

Applied, thanks.

> ---
> v4 changes:
> - Added check for definition of MAC_OS_X_VERSION_10_7
> - Renamed strnlen to fdt_strnlen
> - Added macro that defines strnlen as fdt_strnlen
>=20
> v3 changes:
> - Replaced loop with memchr()
>=20
> v2 changes:
> - Simplified the code to make it static inline'ed
> - Changed the type of count to size_t
>=20
>  libfdt/libfdt_env.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/libfdt/libfdt_env.h b/libfdt/libfdt_env.h
> index 952056c..41fac04 100644
> --- a/libfdt/libfdt_env.h
> +++ b/libfdt/libfdt_env.h
> @@ -109,4 +109,31 @@ static inline fdt64_t cpu_to_fdt64(uint64_t x)
>  #undef CPU_TO_FDT16
>  #undef EXTRACT_BYTE
> =20
> +#ifdef __APPLE__
> +#include <AvailabilityMacros.h>
> +
> +/* strnlen() is not available on Mac OS < 10.7 */
> +# if !defined(MAC_OS_X_VERSION_10_7) || (MAC_OS_X_VERSION_MAX_ALLOWED < \
> +                                         MAC_OS_X_VERSION_10_7)
> +
> +#define strnlen fdt_strnlen
> +
> +/*
> + * fdt_strnlen: returns the length of a string or max_count - which ever=
 is
> + * smallest.
> + * Input 1 string: the string whose size is to be determined
> + * Input 2 max_count: the maximum value returned by this function
> + * Output: length of the string or max_count (the smallest of the two)
> + */
> +static inline size_t fdt_strnlen(const char *string, size_t max_count)
> +{
> +    const char *p =3D memchr(string, 0, max_count);
> +    return p ? p - string : max_count;
> +}
> +
> +#endif /* !defined(MAC_OS_X_VERSION_10_7) || (MAC_OS_X_VERSION_MAX_ALLOW=
ED <
> +          MAC_OS_X_VERSION_10_7) */
> +
> +#endif /* __APPLE__ */
> +
>  #endif /* _LIBFDT_ENV_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CNfT9TXqV7nd4cfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnzqTkACgkQbDjKyiDZ
s5KnRQ/8DcR/3t230Rv3539PivJ2Z18wKQAYU0Hr8OL5hBQv2vMx7+UkyK78qzmZ
SEYJRl6fGDrpJJnchMXs71kGrTRJ4/BwiLU7mKYx3gUaQ6zD/qbZX3ow8khvzh8d
A094OeWC3FsLh3evgbgxjLGLpU2bqbIWe9K6taJusbflL2lqNRI2MTH/FIOMDAQd
i1g8DYquPCsKf/I8nvwR+nHye8UffImPAdxvBkZU40DvYZszm/ChBBp5li0l1mrV
adJ9zOQcf3XfonNS0EmO4wX7NPFB0Q5oFOPK8KVGWZku9fRNWGyOJVU/zhcLL6NG
DvklbH88hj1+E0KyPRSvF+V8csTziuLVgtpu6kn0Us6WCEGVWbLY3QoZ6uaym1MY
eVTpfZX5/q1ELAmyb2PnmzuR82A8zxFp9jWcLMhxogcRyCSkBibBcpI3Vbndsqtu
ki7E6H677c09DldI5aOitVw9f/8IYxTC7leXv2AKT6zzMOfcguEjWF4lWrM+UZBs
FI/Oss07Vi/1SZyVT+TL/3S1vQ6mWOiG+JfsjdDAM7HiUgbPBVT1JGCiMFv5B5rp
GfDz7f7YUYGFVyJxYv4Yi7Ble0KJ2tb6kJ+c04OpCOEaDeaGDKSNY853SmG5IguA
BRFiRBwfYvrDk7TC2z8OAanvWloKVKm6f2ft5pAAG3dv+5D4a2I=
=MzBN
-----END PGP SIGNATURE-----

--CNfT9TXqV7nd4cfk--
