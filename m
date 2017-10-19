Received: from eggs.gnu.org ([2001:4830:134:3::10]:41243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e508Z-00035d-LU
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 22:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e508V-0007tE-PF
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 22:00:43 -0400
Date: Thu, 19 Oct 2017 12:31:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171019013126.GR2776@umbus.fritz.box>
References: <20171018223116.6035-1-programmingkidx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m1rwLFmcefDs/2Y3"
Content-Disposition: inline
In-Reply-To: <20171018223116.6035-1-programmingkidx@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] fdt_ro.c: implement strnlen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--m1rwLFmcefDs/2Y3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2017 at 06:31:16PM -0400, John Arbuckle wrote:
> Implement the strnlen() function if it isn't implemented.
>=20
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>

Nice idea, but this won't work.

> ---
>  libfdt/fdt_ro.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/libfdt/fdt_ro.c b/libfdt/fdt_ro.c
> index 3d00d2e..a7986fb 100644
> --- a/libfdt/fdt_ro.c
> +++ b/libfdt/fdt_ro.c
> @@ -55,6 +55,30 @@
> =20
>  #include "libfdt_internal.h"
> =20
> +/* if the current environment does not define strnlen */
> +#ifndef strnlen

This will only trigger if strnlen is defined as a macro.  The C
library (or other environment) *might* do that, but there's no
guarantee, whether or not it defines strnlen as a function.  With
extra complications if the compiler has a strnlen builtin like gcc.

> +
> +/* This eliminates the missing prototype warning */
> +int strnlen(const char *string, int max_count);
> +
> +/*
> + * strnlen: return the length of a string or max_count
> + * which ever is shortest
> + */
> +
> +int strnlen(const char *string, int max_count)

Also strnlen is supposed to take and return size_t, not int.

> +{
> +    int count;
> +    for(count =3D 0; count < max_count; count++) {
> +        if (string[count] =3D=3D '\0') {
> +            break;
> +        }
> +    }
> +    return count;
> +}
> +
> +#endif /* strnlen */
> +
>  static int _fdt_nodename_eq(const void *fdt, int offset,
>  			    const char *s, int len)
>  {

In any case, this sort of compatibility munging is the job of
libfdt_env.h.  It's purpose is to provide all the external things that
libfdt needs - there's not that many of them and strnlen() is one.
The included libfdt_env.h is intended for POSIXy userspace
environments, which should already include strnlen() in string.h.

If your environment does not provide strnlen(), you probably need your
own version of libfdt_env.h, which will need to define it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--m1rwLFmcefDs/2Y3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnoAGwACgkQbDjKyiDZ
s5IX2xAAqANMIrjEeh86iRkt69e3BezFzoVVDgCMHnZkPlI1oQrBvA7vGd2qTqvk
+eP2hKHRSKT0DV3faK2a1vPr2DTHLrTSegdUZex9bGvNNSbHH/uzc0AGzsn1+Rzg
qn7AYozVlJeAuxpZesN/ok+NXF1V+2A4pJUFA6zmf1owG6mNcLyhTU/OmQ58jima
kbgq86Ph084nxb7CoANqLeO2K8z38IAfz5+v7/LCDw4+weDZZVwVWtG1B/qYA0EF
PB02ZdXsTa/HfokxoamFFxCfKbDjUAg1XFXQbEmIp2xIqoPzYfT1a5DXAnAvtE0z
7abMrq5K0YmfOUxpzUqzdGdQQyKlh0XISbirujU/0Gl+/miLbNNTVGo1ca0N33Os
119Ea4ikV0UexAd+ivRKJojaZn+1vA7oSN9xKBvk/S3b+fIC4J1+/gxzpQmF5Tra
SBRLnsDyk4Sr3s2xMuRYr+3NrUeARQZDFWeifGAlSJH7+JJTR9QCz0IudXclQJJR
5OkmGI3qtab3rGG3cGn9VOttRdK8kcgg/f4dvIYCkegkwB/K1eby4u/dbJd+81j7
AqwG4HTZ5PMp2u4boPhy1ntXvPGcu/2ulvkV9eE9O8qsBXnyWXl8KWOHyBwfoiaO
s5hb7i3XDl8hkbHoH07Tb/QW2nZDsBjujcPzcQGhUnoYKNPOzLU=
=mfuS
-----END PGP SIGNATURE-----

--m1rwLFmcefDs/2Y3--
