Received: from eggs.gnu.org ([2001:4830:134:3::10]:58459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRVsf-0004Be-BM
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 22:16:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRVsd-0005CI-S2
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 22:16:49 -0500
Date: Thu, 12 Jan 2017 13:52:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170112025241.GF14026@umbus.fritz.box>
References: <1484014214-32533-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1484014214-32533-3-git-send-email-joserz@linux.vnet.ibm.com>
	<6ed8225a-65ed-67a0-ee35-a238b7c6408c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p8PhoBjPxaQXD0vg"
Content-Disposition: inline
In-Reply-To: <6ed8225a-65ed-67a0-ee35-a238b7c6408c@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, nikunj@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com


--p8PhoBjPxaQXD0vg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 10, 2017 at 08:34:29AM -0600, Eric Blake wrote:
> On 01/09/2017 08:10 PM, Jose Ricardo Ziviani wrote:
> > Implements 128-bit left shift and right shift as well as their
> > testcases. By design, shift silently mods by 128, so the caller is
> > responsible to assert the shift range if necessary.
> >=20
> > Left shift sets the overflow flag if any non-zero digit is shifted out.
> >=20
> > Examples:
> >  ulshift(&low, &high, 250, &overflow);
> >  equivalent: n << 122
> >=20
> >  urshift(&low, &high, -2);
> >  equivalent: n << 126
> >=20
> > Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> > ---
>=20
> > +typedef struct {
> > +    uint64_t low;
> > +    uint64_t high;
> > +    uint64_t rlow;
> > +    uint64_t rhigh;
> > +    int32_t shift;
> > +    bool overflow;
> > +} test_data;
> > +
> > +static const test_data test_ltable[] =3D {
> > +    { 0x4C7ULL, 0x0ULL, 0x00000000000004C7ULL,
> > +      0x0000000000000000ULL,   0, false },
>=20
> I might have laid it out as:
>=20
> { 0x00000000000004c7ULL, 0x0000000000000000ULL,
>   0x00000000000004c7ULL, 0x0000000000000000ULL,
>   0, false }
>=20
> to make the pre- and post-shift values line up better.  It's not fatal
> to the patch, so it's up to the maintainer if they want a v6 to improve
> the alignment.

host-utils doesn't have a maintainer.  So, I'm intending to take it
through my tree with your R-b.

> > +    { 0x8888888888888888ULL, 0x9999999999999999ULL,
> > +      0x8000000000000000ULL, 0x9888888888888888ULL, 60, true },
> > +    { 0x8888888888888888ULL, 0x9999999999999999ULL,
> > +      0x0000000000000000ULL, 0x8888888888888888ULL, 64, true },
>=20
> These two are the most legible.
>=20
> > +};
> > +
> > +static const test_data test_rtable[] =3D {
>=20
> > +++ b/util/host-utils.c
> > @@ -161,3 +161,67 @@ int divs128(int64_t *plow, int64_t *phigh, int64_t=
 divisor)
> >  }
> >  #endif
> > =20
> > +/**
> > + * urshift - 128-bit Unsigned Right Shift.
> > + * @plow: in/out - lower 64-bit integer.
> > + * @phigh: in/out - higher 64-bit integer.
> > + * @shift: in - bytes to shift, between 0 and 127.
> > + *
> > + * Result is zero-extended and stored in plow/phigh, which are
> > + * input/output variables. Shift values outside the range will
> > + * be mod to 128. In other words, the caller is responsible to
> > + * verify/assert both the shift range and plow/phigh pointers.
> > + */
>=20
> Duplicating docs in the .h and .c doesn't hurt, but risks one getting
> out of date; we have other spots that put the docs in the .h (where
> callers will look up what's available) or the .c (where the
> implementation is there to check against the docs). I don't have any
> strong preference on how to do it, though, so I don't mind leaving it as =
is.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20




--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--p8PhoBjPxaQXD0vg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYdu95AAoJEGw4ysog2bOSaP4P/Rfi9ooZTxP44MLXeGqpLrMw
nWn4w2x0N5LGKtB33a+A3x8nEAwceygi6g8/vxBxlmgxSGQOACvCt/DtuEEmUV/v
DJoIfF+6ZG4o8Vldo+3hjKnIr1CnwjJR5uuRCV2OBpTnLq+/96okdqIbXM7ZV4/g
eI7SssX1f5jnLBtzAUxC7tqCr0ptYm8N1MQUJeBurFJsyXvFab5BnsX0bM1vV3dm
Oiqq2d7ncZ5npRUFiNiEVUe+CYsXvm/aSaV5RdS7VAMnHqeR8xADF9nn/2KqoP1O
l0TZQEjksHhSJJKL7UXjvta5rFx2MJcSP589ws/bW7PMDMPzMpMPY55M5Bt5+Who
HfVOvkkPW4c3WuF/thwX9BBvtoUQmzq3b2KW+OvYUjORMr1gTaPU/Ww42LBCcxzj
ZkWrJxOA2DqxQUraHEI4+eOjY/6ZTXjeVPoir8i+G0THC7ZDScW7FgSUglw1am68
aO4JmZxGoMa7iVxzB/QyL0N+I/Kruct/N5hvlUczOrS8d+vbKX0KPzJ4m0Fh6gBv
vAm03cq433cj8+XqBoJMeE+0FSucy3SeX72v1A/CsDfdn0Gm1a1tTSk3rW0sHKTq
94c614fz37TFWsQdShX5jey378lYId8zB5gBlUSVjtydcGg7ldTuQL+AvHInfjgd
FjDCL5CTRESivfkzL205
=yTDC
-----END PGP SIGNATURE-----

--p8PhoBjPxaQXD0vg--
