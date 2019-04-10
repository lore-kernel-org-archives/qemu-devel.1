Received: from eggs.gnu.org ([209.51.188.92]:36902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hE1El-00070g-8A
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 20:37:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hE1Ek-0004Wh-0r
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 20:37:11 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49981 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hE1Ei-0004Mk-BI
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 20:37:09 -0400
Date: Wed, 10 Apr 2019 10:29:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190410002930.GM16627@umbus.fritz.box>
References: <20190409174018.25798-1-armbru@redhat.com>
	<f018f4d8-7fb2-9037-3b5a-b34f1c5d876d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lbQeYSs6J2ITmUo7"
Content-Disposition: inline
In-Reply-To: <f018f4d8-7fb2-9037-3b5a-b34f1c5d876d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0-maybe] device_tree: Fix integer
 overflowing in load_device_tree()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, alistair.francis@wdc.com, slp@redhat.com


--lbQeYSs6J2ITmUo7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2019 at 08:59:55PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 4/9/19 7:40 PM, Markus Armbruster wrote:
> > If the value of get_image_size() exceeds INT_MAX / 2 - 10000, the
> > computation of @dt_size overflows to a negative number, which then
> > gets converted to a very large size_t for g_malloc0() and
> > load_image_size().  In the (fortunately improbable) case g_malloc0()
> > succeeds and load_image_size() survives, we'd assign the negative
> > number to *sizep.  What that would do to the callers I can't say, but
> > it's unlikely to be good.
> >=20
> > Fix by rejecting images whose size would overflow.
> >=20
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > ---
> >  device_tree.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/device_tree.c b/device_tree.c
> > index 296278e12a..f8b46b3c73 100644
> > --- a/device_tree.c
> > +++ b/device_tree.c
> > @@ -84,6 +84,10 @@ void *load_device_tree(const char *filename_path, in=
t *sizep)
> >                       filename_path);
> >          goto fail;
> >      }
> > +    if (dt_size > INT_MAX / 2 - 10000) {
>=20
> We should avoid magic number duplication.
> That said, this patch looks safe.
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

As Philippe says, the test condition is kinda ugly and I hope we can
refine it in future.  But since it fixes a real problem for now,

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lbQeYSs6J2ITmUo7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlytOOcACgkQbDjKyiDZ
s5I+eA/+KBsDfN495s/Zc2DWFdJVJOfFu6IpSLE+uXW/h0cNdfKXY92xtbbrja/D
QgB8NTxx24jZEVqyHvdcHGCT+EB130iqXukKNKAsg7ERBlXHw+8ve7DXFmC3xmiQ
N5y/haQV6FinDB9piMvAxxHzNsN4ycLxIy3sOX1yGFu3sdUpigjO3BVWSa9oFHIZ
YPLvUNn5ravQvZHC4MwHfkYSovmGFeSkSPMKvcbgzSxKv43u5pACu/Zb/kD4f76g
5ld0e2onlMH+N5HwMHuKXt9eclwkolbIPEwWpEvND7M1z6XxbSEgwSr38yT1vzYk
S53ESmmUyGaMLuvovAxHIQ2C1YcTjHLaUMOeeB6smw/J+gEKjfHoZZaSVHPHqjt1
FZiSoirDKiXwlgXwItCSEeNqfU+sKbYv3DINon24VjPxfVdJ0AmVv+4Z+XM2Pv19
oXfoRv54If8q2D5eQ3hp/sLRJ+4h0AU2n/QyRjoYw9SO0BeruxZLRyKRhEr1cFkq
H4mSMVnXD9xPea7wBiyrjAHMpItVCeLUefEJ9PNbG36K1ClVu1qWJslchRKJrXtz
EpuMRip1ByjA9nA5srQ91Fdy9wP3NuGE5jnvcma/3nEB3zHjRaY/nRHMwI/jXbAX
VA6pElKKkV21YTkhvJagTZS4qwPIoF/yV+0PE+KnbA6vcXz3ZY8=
=eS2N
-----END PGP SIGNATURE-----

--lbQeYSs6J2ITmUo7--
