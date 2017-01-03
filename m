Received: from eggs.gnu.org ([2001:4830:134:3::10]:55645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOQtS-0004fo-Bc
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:20:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOQtO-0004d9-W8
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:20:54 -0500
References: <1482166064-18121-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1482166064-18121-2-git-send-email-joserz@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8cb9e1d4-3dca-8a32-9f0d-2173bea52771@redhat.com>
Date: Tue, 3 Jan 2017 09:20:37 -0600
MIME-Version: 1.0
In-Reply-To: <1482166064-18121-2-git-send-email-joserz@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bGlgLg0nISaNQNi6wkdjui3Hg2seq7uJo"
Subject: Re: [Qemu-devel] [PATCH v4 1/6] target-ppc: Implement unsigned
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
Cc: bharata@linux.vnet.ibm.com, qemu-devel@nongnu.org, nikunj@linux.vnet.ibm.com, david@gibson.dropbear.id.au

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bGlgLg0nISaNQNi6wkdjui3Hg2seq7uJo
From: Eric Blake <eblake@redhat.com>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, qemu-ppc@nongnu.org
Cc: bharata@linux.vnet.ibm.com, qemu-devel@nongnu.org,
 nikunj@linux.vnet.ibm.com, david@gibson.dropbear.id.au
Message-ID: <8cb9e1d4-3dca-8a32-9f0d-2173bea52771@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/6] target-ppc: Implement unsigned
 quadword left/right shift and unit tests
References: <1482166064-18121-1-git-send-email-joserz@linux.vnet.ibm.com>
 <1482166064-18121-2-git-send-email-joserz@linux.vnet.ibm.com>
In-Reply-To: <1482166064-18121-2-git-send-email-joserz@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/19/2016 10:47 AM, Jose Ricardo Ziviani wrote:
> This commit implements functions to right and left shifts and the
> unittest for them. Such functions is needed due to instructions
> that requires them.
>=20
> Today, there is already a right shift implementation in int128.h
> but it's designed for signed numbers.
>=20
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> ---

> +static const test_data test_ltable[] =3D {
> +    { 1223ULL, 0, 1223ULL,   0, 0, false },
> +    { 1ULL,    0, 2ULL,   0, 1, false },
> +    { 1ULL,    0, 4ULL,   0, 2, false },
> +    { 1ULL,    0, 16ULL,  0, 4, false },
> +    { 1ULL,    0, 256ULL, 0, 8, false },
> +    { 1ULL,    0, 65536ULL, 0, 16, false },
> +    { 1ULL,    0, 2147483648ULL, 0, 31, false },
> +    { 1ULL,    0, 35184372088832ULL, 0, 45, false },
> +    { 1ULL,    0, 1152921504606846976ULL, 0, 60, false },
> +    { 1ULL,    0, 0, 1ULL, 64, false },
> +    { 1ULL,    0, 0, 65536ULL, 80, false },
> +    { 1ULL,    0, 0, 9223372036854775808ULL, 127, false },

I concur with the request to write these tests in hex.

> +    { 0ULL,    1, 0, 0, 64, true },
> +    { 0x8888888888888888ULL, 0x9999999999999999ULL,
> +        0x8000000000000000ULL, 0x9888888888888888ULL, 60, true },
> +    { 0x8888888888888888ULL, 0x9999999999999999ULL,
> +        0, 0x8888888888888888ULL, 64, true },
> +    { 0x8ULL, 0, 0, 0x8ULL, 64, false },
> +    { 0x8ULL, 0, 0, 0x8000000000000000ULL, 124, false },
> +    { 0x1ULL, 0, 0, 0x4000000000000000ULL, 126, false },
> +    { 0x1ULL, 0, 0, 0x8000000000000000ULL, 127, false },
> +    { 0x1ULL, 0, 0x1ULL, 0, 128, true },

Do we really want this to be well-defined behavior?  Or would it be
better to require shift to be in the bounded range [0,127] and assert()
that it is always in range?  At least your testsuite ensures that if we
want it to be well-defined, we won't go breaking it.

> +    { 0, 0, 0ULL, 0, 200, false },

If you are going to support shifts larger than 127, your testsuite
should include a shift of a non-zero number.  Also, if you are going to
implicitly truncate the shift value into range, then accepting a signed
shift might be nicer (as there are cases where it is easier to code a
shift by -1 than it is a shift by 127).

> +++ b/util/host-utils.c
> @@ -26,6 +26,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/host-utils.h"
> =20
> +#ifndef CONFIG_INT128
>  /* Long integer helpers */
>  static inline void mul64(uint64_t *plow, uint64_t *phigh,
>                           uint64_t a, uint64_t b)
> @@ -158,4 +159,47 @@ int divs128(int64_t *plow, int64_t *phigh, int64_t=
 divisor)
> =20
>      return overflow;
>  }
> +#endif

How is the addition of this #ifndef related to the rest of the patch?  I
almost wonder if it needs two patches (one to compile the file
regardless of 128-bit support, the other to add new 128-bit shifts); if
not, mentioning it in the commit message doesn't hurt.

> =20
> +void urshift(uint64_t *plow, uint64_t *phigh, uint32_t shift)

Comments on the function contract would be much appreciated (for
example, what range must shift belong to, and the fact that the shift is
modifying the value in-place, and that the result is always zero-extended=
).

> +{
> +    shift &=3D 127;

This says you allow any shift value (whether negative or beyond 127);
either the testsuite must cover this, or you should tighten the contract
and assert that the callers pass a value in range.

> +    uint64_t h =3D *phigh >> (shift & 63);
> +    if (shift =3D=3D 0) {
> +        return;

Depending on the compiler, this may waste the work of computing h; maybe
you can float this conditional first.

> +    } else if (shift >=3D 64) {
> +        *plow =3D h;
> +        *phigh =3D 0;
> +    } else {
> +        *plow =3D (*plow >> (shift & 63)) | (*phigh << (64 - (shift & =
63)));
> +        *phigh =3D h;
> +    }

At any rate, the math looks correct.

> +}
> +
> +void ulshift(uint64_t *plow, uint64_t *phigh, uint32_t shift, bool *ov=
erflow)

Again, doc comments are useful, including what overflow represents, and
a repeat of the question on whether a signed shift amount makes sense if
you intend to allow silent truncation of the shift value.

> +{
> +    uint64_t low =3D *plow;
> +    uint64_t high =3D *phigh;
> +
> +    if (shift > 127 && (low | high)) {
> +        *overflow =3D true;
> +    }
> +    shift &=3D 127;
> +
> +    if (shift =3D=3D 0) {
> +        return;
> +    }
> +
> +    urshift(&low, &high, 128 - shift);
> +    if (low > 0 || high > 0) {

Can't this be written 'if (low | high)' as above?

> +        *overflow =3D true;
> +    }
> +
> +    if (shift >=3D 64) {
> +        *phigh =3D *plow << (shift & 63);
> +        *plow =3D 0;
> +    } else {
> +        *phigh =3D (*plow >> (64 - (shift & 63))) | (*phigh << (shift =
& 63));
> +        *plow =3D *plow << shift;
> +    }
> +}
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--bGlgLg0nISaNQNi6wkdjui3Hg2seq7uJo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYa8FFAAoJEKeha0olJ0Nq8CgH/1HPDlWC1zegZ/zjjOIQcY32
rNs1UGiuaPKPWd6y9u+jf6SYNpN5OoZkNmOoP22dUjlX/g7Dbfz9ayxuJzQbpPAc
rcvZyYiGQKqpY602Ql9mHP2DsxD2zj5x8dbNkfqEy8Rete+bCp3p9lk81upwi9U2
QJIn2BCofsjBodGWtp/PZERaudLCx3uHD2SOq6iueEF9jueUtS+N4iPzX/Am4OWN
388Rg61LKo7tsxEx1TtBdC0f90coTZAOLVF21jJlNgGWjUN5wxD8ix+0jolsKYH3
fKWLjYkfN5/O8tN+MPQRB/SYOSZbZMRev8OVFj/bN23NgS4D9aB8ajIzjEkEEy4=
=Bh8T
-----END PGP SIGNATURE-----

--bGlgLg0nISaNQNi6wkdjui3Hg2seq7uJo--
