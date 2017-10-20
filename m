Received: from eggs.gnu.org ([2001:4830:134:3::10]:55784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e5Taf-0007Cb-LU
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 05:27:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e5Tac-00080t-HD
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 05:27:41 -0400
Date: Fri, 20 Oct 2017 20:25:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171020092509.GH13245@umbus>
References: <20171020015005.2311-1-programmingkidx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2xzXx3ruJf7hsAzo"
Content-Disposition: inline
In-Reply-To: <20171020015005.2311-1-programmingkidx@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] implement strnlen for systems that need it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--2xzXx3ruJf7hsAzo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2017 at 09:50:05PM -0400, John Arbuckle wrote:
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>

I preferred the idea of just putting it inline into libfdt_env.h.
They're both ugly, but that one's small and ugly; the approach here
seems overkill.

Also, patch submissions for dtc and libfdt should go to
<devicetree-compiler@vger.kernel.org>

> ---
>  Makefile.dtc           |  3 ++-
>  libfdt/Makefile.libfdt |  2 +-
>  libfdt/libfdt_env.h    | 12 ++++++++++++
>  libfdt/strnlen.h       | 14 ++++++++++++++
>  strnlen.c              | 25 +++++++++++++++++++++++++
>  5 files changed, 54 insertions(+), 2 deletions(-)
>  create mode 100644 libfdt/strnlen.h
>  create mode 100644 strnlen.c
>=20
> diff --git a/Makefile.dtc b/Makefile.dtc
> index bece49b..14eaa4e 100644
> --- a/Makefile.dtc
> +++ b/Makefile.dtc
> @@ -12,7 +12,8 @@ DTC_SRCS =3D \
>  	livetree.c \
>  	srcpos.c \
>  	treesource.c \
> -	util.c
> +	util.c \
> +    strnlen.c
> =20
>  DTC_GEN_SRCS =3D dtc-lexer.lex.c dtc-parser.tab.c
>  DTC_OBJS =3D $(DTC_SRCS:%.c=3D%.o) $(DTC_GEN_SRCS:%.c=3D%.o)
> diff --git a/libfdt/Makefile.libfdt b/libfdt/Makefile.libfdt
> index 098b3f3..b20a85b 100644
> --- a/libfdt/Makefile.libfdt
> +++ b/libfdt/Makefile.libfdt
> @@ -7,5 +7,5 @@ LIBFDT_soname =3D libfdt.$(SHAREDLIB_EXT).1
>  LIBFDT_INCLUDES =3D fdt.h libfdt.h libfdt_env.h
>  LIBFDT_VERSION =3D version.lds
>  LIBFDT_SRCS =3D fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c fdt_strerror.=
c fdt_empty_tree.c \
> -	fdt_addresses.c fdt_overlay.c
> +	fdt_addresses.c fdt_overlay.c strnlen.c
>  LIBFDT_OBJS =3D $(LIBFDT_SRCS:%.c=3D%.o)
> diff --git a/libfdt/libfdt_env.h b/libfdt/libfdt_env.h
> index 952056c..a25a615 100644
> --- a/libfdt/libfdt_env.h
> +++ b/libfdt/libfdt_env.h
> @@ -109,4 +109,16 @@ static inline fdt64_t cpu_to_fdt64(uint64_t x)
>  #undef CPU_TO_FDT16
>  #undef EXTRACT_BYTE
> =20
> +#ifdef __APPLE__
> +#include <AvailabilityMacros.h>
> +
> +#define MAC_OS_X_VERSION_10_7 1070
> +
> +/* strnlen() is not available on Mac OS < 10.7 */
> +# if (MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_7)
> +#include "strnlen.h"
> +#endif /* (MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_7) */
> +
> +#endif /* __APPLE__ */
> +
>  #endif /* _LIBFDT_ENV_H */
> diff --git a/libfdt/strnlen.h b/libfdt/strnlen.h
> new file mode 100644
> index 0000000..62a45c0
> --- /dev/null
> +++ b/libfdt/strnlen.h
> @@ -0,0 +1,14 @@
> +/*
> + * File: strnlen.h
> + * Date: 10-19-2017
> + * Description: Implements functions that may be missing on the host sys=
tem
> + */
> +
> +#ifndef STRNLEN
> +#define STRNLEN
> +
> +#include <stddef.h>
> +
> +size_t strnlen(const char *string, size_t max_count);
> +
> +#endif /* STRNLEN */
> diff --git a/strnlen.c b/strnlen.c
> new file mode 100644
> index 0000000..3559c6f
> --- /dev/null
> +++ b/strnlen.c
> @@ -0,0 +1,25 @@
> +/*
> + * File: strnlen.c
> + * Date: 10-19-2017
> + * Description: Implement the strnlen() function for platforms that need=
 it
> + */
> +
> +#include <stddef.h>
> +#include "strnlen.h"
> +
> +/*=20
> + * strnlen: returns the length of a string or max_count - which ever is =
smallest
> + * Input 1 string: the string whose size is to be determined
> + * Input 2 max_count: the maximum value returned by this function
> + * Output: length of the string or max_count (the smallest of the two)
> + */
> +size_t strnlen(const char *string, size_t max_count)
> +{
> +    int count;
> +    for(count =3D 0; count < max_count; count++) {
> +        if (string[count] =3D=3D '\0') {
> +            break;
> +        }
> +    }
> +    return count;
> +}

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2xzXx3ruJf7hsAzo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnpwPMACgkQbDjKyiDZ
s5KHSBAAj+WS5Uc/QbpnuDcZGECijTsagOOBgPeEUk6S2LnYuoiz4ISZjK0dtKYy
rHMkJV9HSZiPCTjKi0YnGJa15l2B5k2EycwEVm2Xypho/fArlr2qCYsT13TEGQ11
j1m5Y8bTYzQj/qsH8Gc6qVVSmHJCbOJdM2JEZB/mo5Bnx0W+r/m7ezBJzcnxGpTT
jLAUqMfebGlw/cAp3UQaIzppdcJqhLgJtfo/PHmVuJO/Gi7kEiDz0lT/bzeHSxY5
sa5fnHLs8E7rZXY2JPNisE9I+pBTRxgs8hn6R+QXe1lYVTW8AzFSbDU2JGUIzrxu
SLamiDlsmuVRLgkeU+MP0hxd+L7QG/GeRz+WL8VcHP9fd8bRyojImMGJRpphHKw1
dedFcstM43JVNr2qjXVuU75Ult3kA9wM782Z8Yep53lbifs60pXafCVO05gbwQtX
Il/z6ylP2c9xpnSXEgBsOD6BqouzQPjLFqgbKZ0SFCFV68e+9EF9HttwTallruUI
eJHE7NKZS+F5toNOe36wgl+0YCBx3Lqw0280qDjW0H7tiFuygpTLAk6mxzyuotCu
C/tOunHaZbtiN5oR5KvaJFm6lU97YmwhUpHIF7Ctj+bd67rF3+zuZ8TfWWgivSl8
UYZzp9nTfKOAwKLV2FQHvRYDUNSk+uxucG1Y1cRSoYrloJgEEUI=
=p4lf
-----END PGP SIGNATURE-----

--2xzXx3ruJf7hsAzo--
