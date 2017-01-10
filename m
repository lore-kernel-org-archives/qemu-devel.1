Received: from eggs.gnu.org ([2001:4830:134:3::10]:54075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQxVU-0001ls-KU
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:34:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQxVQ-0003LS-Ja
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:34:36 -0500
References: <1484014214-32533-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1484014214-32533-3-git-send-email-joserz@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6ed8225a-65ed-67a0-ee35-a238b7c6408c@redhat.com>
Date: Tue, 10 Jan 2017 08:34:29 -0600
MIME-Version: 1.0
In-Reply-To: <1484014214-32533-3-git-send-email-joserz@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rxPDW6KRiFmQvoVuLOkjwRJsl4eJ7QEoK"
Subject: Re: [Qemu-devel] [PATCH v5 2/7] host-utils: Implement unsigned
 quadword left/right shift and unit tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, nikunj@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rxPDW6KRiFmQvoVuLOkjwRJsl4eJ7QEoK
From: Eric Blake <eblake@redhat.com>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au,
 nikunj@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com
Message-ID: <6ed8225a-65ed-67a0-ee35-a238b7c6408c@redhat.com>
Subject: Re: [PATCH v5 2/7] host-utils: Implement unsigned quadword left/right
 shift and unit tests
References: <1484014214-32533-1-git-send-email-joserz@linux.vnet.ibm.com>
 <1484014214-32533-3-git-send-email-joserz@linux.vnet.ibm.com>
In-Reply-To: <1484014214-32533-3-git-send-email-joserz@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/09/2017 08:10 PM, Jose Ricardo Ziviani wrote:
> Implements 128-bit left shift and right shift as well as their
> testcases. By design, shift silently mods by 128, so the caller is
> responsible to assert the shift range if necessary.
>=20
> Left shift sets the overflow flag if any non-zero digit is shifted out.=

>=20
> Examples:
>  ulshift(&low, &high, 250, &overflow);
>  equivalent: n << 122
>=20
>  urshift(&low, &high, -2);
>  equivalent: n << 126
>=20
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> ---

> +typedef struct {
> +    uint64_t low;
> +    uint64_t high;
> +    uint64_t rlow;
> +    uint64_t rhigh;
> +    int32_t shift;
> +    bool overflow;
> +} test_data;
> +
> +static const test_data test_ltable[] =3D {
> +    { 0x4C7ULL, 0x0ULL, 0x00000000000004C7ULL,
> +      0x0000000000000000ULL,   0, false },

I might have laid it out as:

{ 0x00000000000004c7ULL, 0x0000000000000000ULL,
  0x00000000000004c7ULL, 0x0000000000000000ULL,
  0, false }

to make the pre- and post-shift values line up better.  It's not fatal
to the patch, so it's up to the maintainer if they want a v6 to improve
the alignment.

> +    { 0x8888888888888888ULL, 0x9999999999999999ULL,
> +      0x8000000000000000ULL, 0x9888888888888888ULL, 60, true },
> +    { 0x8888888888888888ULL, 0x9999999999999999ULL,
> +      0x0000000000000000ULL, 0x8888888888888888ULL, 64, true },

These two are the most legible.

> +};
> +
> +static const test_data test_rtable[] =3D {

> +++ b/util/host-utils.c
> @@ -161,3 +161,67 @@ int divs128(int64_t *plow, int64_t *phigh, int64_t=
 divisor)
>  }
>  #endif
> =20
> +/**
> + * urshift - 128-bit Unsigned Right Shift.
> + * @plow: in/out - lower 64-bit integer.
> + * @phigh: in/out - higher 64-bit integer.
> + * @shift: in - bytes to shift, between 0 and 127.
> + *
> + * Result is zero-extended and stored in plow/phigh, which are
> + * input/output variables. Shift values outside the range will
> + * be mod to 128. In other words, the caller is responsible to
> + * verify/assert both the shift range and plow/phigh pointers.
> + */

Duplicating docs in the .h and .c doesn't hurt, but risks one getting
out of date; we have other spots that put the docs in the .h (where
callers will look up what's available) or the .c (where the
implementation is there to check against the docs). I don't have any
strong preference on how to do it, though, so I don't mind leaving it as =
is.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--rxPDW6KRiFmQvoVuLOkjwRJsl4eJ7QEoK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYdPD1AAoJEKeha0olJ0Nq0RkH/iGaVwDqgxivedt+V5sE0/oL
58X2qx4v5EAMHtJWK371cJ4VgykH3TipldtwZjDuyDyPUwFVTF3UaS+VuovH56KS
o+UiTvN7LgHyMRG0m5OXY25z+f4mORiqPg/voOseA/E4BxNbZCC4ij2AUouOryGc
wvInySJNJNLbH/5Iqk+bUtoAB7tU0RKcgiG6NpYGQp0gjdfoQCsA9t4KYGsXLLys
Dia1oGIqakBtQz+qZJkZpbmXHHQWpI6Sr9bngXIDGb7PygyAy53L4EPE6szOEC8w
bBFXqy6xS73fXdh6HXO+e0aVVMPP0BokHa+LF3LzEtSLFCUZG53Pq7sRmpAbtSI=
=oXoI
-----END PGP SIGNATURE-----

--rxPDW6KRiFmQvoVuLOkjwRJsl4eJ7QEoK--
