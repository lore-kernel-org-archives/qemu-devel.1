Received: from eggs.gnu.org ([2001:4830:134:3::10]:49872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSqIo-0000lI-2T
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 15:49:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSqIm-0000EH-UE
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 15:49:34 -0400
References: <20170705190404.22449-1-mreitz@redhat.com>
	<20170705190404.22449-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <48adcb41-0d85-a2e9-6288-a5297de992a5@redhat.com>
Date: Wed, 5 Jul 2017 14:49:23 -0500
MIME-Version: 1.0
In-Reply-To: <20170705190404.22449-3-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AnlPLfNpvwKS4aHGVK2X20f87gPMMELsf"
Subject: Re: [Qemu-devel] [PATCH v4 2/5] qapi: Add qobject_is_equal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AnlPLfNpvwKS4aHGVK2X20f87gPMMELsf
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <48adcb41-0d85-a2e9-6288-a5297de992a5@redhat.com>
Subject: Re: [PATCH v4 2/5] qapi: Add qobject_is_equal()
References: <20170705190404.22449-1-mreitz@redhat.com>
 <20170705190404.22449-3-mreitz@redhat.com>
In-Reply-To: <20170705190404.22449-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/05/2017 02:04 PM, Max Reitz wrote:
> This generic function (along with its implementations for different
> types) determines whether two QObjects are equal.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> Markus also proposed just reporting two values as unequal if they have =
a
> different internal representation (i.e. a different QNum kind).
>=20
> I don't like this very much, because I feel like QInt and QFloat have
> been unified for a reason: Outside of these classes, nobody should care=

> about the exact internal representation.  In JSON, there is no
> difference anyway.  We probably want to use integers as long as we can
> and doubles whenever we cannot.
>=20
> In any case, I feel like the class should hide the different internal
> representations from the user.  This necessitates being able to compare=

> floating point values against integers.  Since apparently the main use
> of QObject is to parse and emit JSON (and represent such objects
> internally), we also have to agree that JSON doesn't make a difference:=

> 42 is just the same as 42.0.
>=20
> Finally, I think it's rather pointless not to consider 42u and 42 the
> same value.  But since unsigned/signed are two different kinds of QNums=

> already, we cannot consider them equal without considering 42.0 equal,
> too.
>=20
> Because of this, I have decided to continue to compare QNum values even=

> if they are of a different kind.

This explanation may deserve to be in the commit log proper.

>  /**
> + * qnum_is_equal(): Test whether the two QNums are equal
> + *
> + * Negative integers are never considered equal to unsigned integers.
> + * Doubles are only considered equal to integers if their fractional
> + * part is zero and their integral part is exactly equal to the
> + * integer.  Because doubles have limited precision, there are
> + * therefore integers which do not have an equal double (e.g.
> + * INT64_MAX).
> + */
> +bool qnum_is_equal(const QObject *x, const QObject *y)
> +{
> +    QNum *num_x =3D qobject_to_qnum(x);
> +    QNum *num_y =3D qobject_to_qnum(y);
> +    double integral_part; /* Needed for the modf() calls below */
> +
> +    switch (num_x->kind) {
> +    case QNUM_I64:
> +        switch (num_y->kind) {
> +        case QNUM_I64:
> +            /* Comparison in native int64_t type */
> +            return num_x->u.i64 =3D=3D num_y->u.i64;
> +        case QNUM_U64:
> +            /* Implicit conversion of x to uin64_t, so we have to
> +             * check its sign before */
> +            return num_x->u.i64 >=3D 0 && num_x->u.i64 =3D=3D num_y->u=
=2Eu64;
> +        case QNUM_DOUBLE:
> +            /* Comparing x to y in double (which the implicit
> +             * conversion would do) is not exact.  So after having
> +             * checked that y is an integer in the int64_t range
> +             * (i.e. that it is within bounds and its fractional part
> +             * is zero), compare both as integers. */
> +            return num_y->u.dbl >=3D -0x1p63 && num_y->u.dbl < 0x1p63 =
&&
> +                modf(num_y->u.dbl, &integral_part) =3D=3D 0.0 &&

'man modf': given modf(x, &iptr), if x is a NaN, a Nan is returned
(good, NaN, is never equal to any integer value). But if x is positive
infinity, +0 is returned...

> +                num_x->u.i64 =3D=3D (int64_t)num_y->u.dbl;

=2E..and *iptr is set to positive infinity.  You are now converting
infinity to int64_t (whether via num_y->u.dbl or via &integral_part),
which falls in the unspecified portion of C99 (your quotes from 6.3.1.4
mentioned converting a finite value of real to integer, and say nothing
about converting NaN or infinity to integer).

Adding an 'isfinite(num_y->u.dbl) &&' to the expression would cover your
bases (or even 'isfinite(integral_part)', if we are worried about a
static checker complaining that we assign but never read integral_part).

> +        }
> +        abort();
> +    case QNUM_U64:
> +        switch (num_y->kind) {
> +        case QNUM_I64:
> +            return qnum_is_equal(y, x);
> +        case QNUM_U64:
> +            /* Comparison in native uint64_t type */
> +            return num_x->u.u64 =3D=3D num_y->u.u64;
> +        case QNUM_DOUBLE:
> +            /* Comparing x to y in double (which the implicit
> +             * conversion would do) is not exact.  So after having
> +             * checked that y is an integer in the uint64_t range
> +             * (i.e. that it is within bounds and its fractional part
> +             * is zero), compare both as integers. */
> +            return num_y->u.dbl >=3D 0 && num_y->u.dbl < 0x1p64 &&
> +                modf(num_y->u.dbl, &integral_part) =3D=3D 0.0 &&
> +                num_x->u.u64 =3D=3D (uint64_t)num_y->u.dbl;

And again.

With that addition,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AnlPLfNpvwKS4aHGVK2X20f87gPMMELsf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZXULDAAoJEKeha0olJ0Nqt80H/jm8sLszc/M0Am9CymRD8H3r
9cNvX+TVkK7hXPdJbQs4eetzD5R9glxnYYBNoyqWlAj7YKQI86wvxp1T2X6KkAXj
q0DcBsf9GtkcdyV7sDwKphHPZ7Oe72YOwtuugZo1efqXlJ9X2LEERGIdy6AkAuO4
9JjZ4HTmCOAxIhdbPH3zdLfoyCsIUpHZ6ZmtBhsDSAKwhSZshPQ+QbFgQR3P16ds
OC2047M/dVimA+vOA0wfiwmgnWGCZbooUKwhVZNUNf8J0Xd1SyPQke7RLzsB/wY+
AUFXWa7bVup2OjNNtCHxx7nGgt08dTrnSYj/y95rKGaAgCbfxKrf6l06ci+JlrQ=
=n465
-----END PGP SIGNATURE-----

--AnlPLfNpvwKS4aHGVK2X20f87gPMMELsf--
