Received: from eggs.gnu.org ([209.51.188.92]:57705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ggLfQ-00071E-Gd
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 22:33:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ggLfN-0003CU-9c
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 22:33:30 -0500
Date: Mon, 7 Jan 2019 11:39:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190107003950.GA13339@umbus.fritz.box>
References: <20190104181208.7809-1-philmd@redhat.com>
	<20190104181208.7809-2-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <20190104181208.7809-2-philmd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] util/cutils: Move size_to_str()
 from "qemu-common.h" to "cutils.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, qemu-trivial@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Stefano Garzarella <sgarzare@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 04, 2019 at 07:12:06PM +0100, Philippe Mathieu-Daud=E9 wrote:
> The size_to_str() function doesn't need to be in a generic header.
>=20
> It makes also sens to find this function in the same header than
> the opposite string to size functions: qemu_strtosz*().
> Note than this function is already implemented in util/cutils.c.
>=20
> Since we introduce a new function in a header, we document it,
> using the previous comment from the source file.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/qemu-common.h        |  1 -
>  include/qemu/cutils.h        | 13 +++++++++++++
>  qapi/string-output-visitor.c |  2 +-
>  util/cutils.c                |  6 ------
>  4 files changed, 14 insertions(+), 8 deletions(-)
>=20
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index ed60ba251d..760527294f 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -153,7 +153,6 @@ void qemu_hexdump(const char *buf, FILE *fp, const ch=
ar *prefix, size_t size);
>  int parse_debug_env(const char *name, int max, int initial);
> =20
>  const char *qemu_ether_ntoa(const MACAddr *mac);
> -char *size_to_str(uint64_t val);
>  void page_size_init(void);
> =20
>  /* returns non-zero if dump is in progress, otherwise zero is
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index d2dad3057c..9ee40470e3 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -157,6 +157,19 @@ int qemu_strtosz(const char *nptr, const char **end,=
 uint64_t *result);
>  int qemu_strtosz_MiB(const char *nptr, const char **end, uint64_t *resul=
t);
>  int qemu_strtosz_metric(const char *nptr, const char **end, uint64_t *re=
sult);
> =20
> +/**
> + * size_to_str:
> + *
> + * Return human readable string for size @val.
> + * Use IEC binary units like KiB, MiB, and so forth.
> + *
> + * @val: The value to format.
> + *       Can be anything that uint64_t allows (no more than "16 EiB").
> + *
> + * Caller is responsible for passing it to g_free().
> + */
> +char *size_to_str(uint64_t val);
> +
>  /* used to print char* safely */
>  #define STR_OR_NULL(str) ((str) ? (str) : "null")
> =20
> diff --git a/qapi/string-output-visitor.c b/qapi/string-output-visitor.c
> index 7ab64468d9..edf268b373 100644
> --- a/qapi/string-output-visitor.c
> +++ b/qapi/string-output-visitor.c
> @@ -11,9 +11,9 @@
>   */
> =20
>  #include "qemu/osdep.h"
> -#include "qemu-common.h"
>  #include "qapi/string-output-visitor.h"
>  #include "qapi/visitor-impl.h"
> +#include "qemu/cutils.h"
>  #include "qemu/host-utils.h"
>  #include <math.h>
>  #include "qemu/range.h"
> diff --git a/util/cutils.c b/util/cutils.c
> index e098debdc0..a8a3a3ba3b 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -816,12 +816,6 @@ const char *qemu_ether_ntoa(const MACAddr *mac)
>      return ret;
>  }
> =20
> -/*
> - * Return human readable string for size @val.
> - * @val can be anything that uint64_t allows (no more than "16 EiB").
> - * Use IEC binary units like KiB, MiB, and so forth.
> - * Caller is responsible for passing it to g_free().
> - */
>  char *size_to_str(uint64_t val)
>  {
>      static const char *suffixes[] =3D { "", "Ki", "Mi", "Gi", "Ti", "Pi"=
, "Ei" };

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwyn9QACgkQbDjKyiDZ
s5L3gxAAvuTpr5cr4DTxOkcEEzmD79trpIIFHjuFJgiiVFGOQp166pYygUDpnCgL
4tygWXrRfcUWxWRQ9Nxhu9NFfPx881i76Yfds05+Mg+BCJ5XR5m0i66xcsaECEx4
6MpJF1kNBR7GrEBbTAPHYr3c8NKRUw9jxcLbTmlBF5L5Fwz5J2hMWTsbNrpW9/5g
UsmIgdVoL7BnG83zc/OeqiV9NIgQ6T4ZMWvnuMPqbm/Ru2/4Ln31vOD7xqPRmoW6
XEG0V/PVgpbdiv6moEl6GFjMer9obu86gG+B5EEiMEEiT63OzdM51P6XdJB1fq8m
970JF7i+Fc1kC5HYOfZwJgjLogURZUoV++950M5qabD8GMf0L1csGi24XYkt2qis
fkATXiLj2R0sc0MDjEShgRd8SKPbPQ8efv3LtIZls28/JFBepoC8JkSFxqwOtTe5
RwT4AL+in9cdLwVTrcyr4T0gHneJQf3ZpxxEl/DXOHGV7unYj4ZViimSga1PFZQk
9YwSmvicVXnBWrFDiGyeO6pSKiq3l0R7KgIw36SZT9alhvBPGq6+zxhDG+i7d6sZ
aQBFXUOhKx2kQoOd80B0EVmowEye3oGbLqkOtocUC0i4rD8Z+BRG0MPpkZiXzITl
yG2sJstFp+txUYhPP2uL4NBO0Fxxm0rWRmk3XwDvJTrjqXIY0jU=
=gAQg
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
