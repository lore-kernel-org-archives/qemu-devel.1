Received: from eggs.gnu.org ([2001:4830:134:3::10]:43852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eR9mY-0006Je-QF
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 23:45:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eR9mT-0000cW-O2
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 23:45:34 -0500
Date: Tue, 19 Dec 2017 15:42:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171219044257.GI4786@umbus.fritz.box>
References: <20171218100404.4427-1-david@gibson.dropbear.id.au>
	<20171218100404.4427-3-david@gibson.dropbear.id.au>
	<c791d1f7-d10c-9c8e-70d1-b600125d859f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ev7mvGV+3JQuI2Eo"
Content-Disposition: inline
In-Reply-To: <c791d1f7-d10c-9c8e-70d1-b600125d859f@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv2 2/4] tests/pxe-test: Use table of
 testcases rather than open-coding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: mst@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--ev7mvGV+3JQuI2Eo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2017 at 11:34:07AM +0100, Thomas Huth wrote:
> On 18.12.2017 11:04, David Gibson wrote:
> > Currently pxe-tests open codes the list of tests for each architecture.
> > This changes it to use tables of test parameters, somewhat similar to
> > boot-serial-test.
> >=20
> > This adds the machine type into the table as well, giving us the ability
> > to perform tests on multiple machine types for architectures where ther=
e's
> > more than one machine type that matters.
> >=20
> > NOTE: This changes the names of the tests in the output, to include the
> >       machine type and IPv4 vs. IPv6.  I'm not sure if this has the
> >       potential to break existing tooling.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  tests/pxe-test.c | 87 ++++++++++++++++++++++++++++++++++++++++++------=
--------
> >  1 file changed, 65 insertions(+), 22 deletions(-)
> >=20
> > diff --git a/tests/pxe-test.c b/tests/pxe-test.c
> > index eb70aa2bc6..8c310a8129 100644
> > --- a/tests/pxe-test.c
> > +++ b/tests/pxe-test.c
> > @@ -22,14 +22,52 @@
> > =20
> >  static char disk[] =3D "tests/pxe-test-disk-XXXXXX";
> > =20
> > -static void test_pxe_one(const char *params, bool ipv6)
> > +typedef struct testdef {
> > +    const char *machine;    /* Machine type */
> > +    const char *model;      /* NIC device model */
> > +    const char *devopts;    /* Device options */
> > +} testdef_t;
> [...]
> > +static testdef_t s390x_tests[] =3D {
> > +    { "s390-ccw-virtio", "virtio-net-ccw", ",bootindex=3D1" },
> > +    { NULL },
> > +};
> > +
> > +static void test_pxe_one(const testdef_t *test, bool ipv6)
> >  {
> >      char *args;
> > =20
> > -    args =3D g_strdup_printf("-machine accel=3Dkvm:tcg -nodefaults -bo=
ot order=3Dn "
> > -                           "-netdev user,id=3D" NETNAME ",tftp=3D./,bo=
otfile=3D%s,"
> > -                           "ipv4=3D%s,ipv6=3D%s %s", disk, ipv6 ? "off=
" : "on",
> > -                           ipv6 ? "on" : "off", params);
> > +    args =3D g_strdup_printf(
> > +        "-machine %s,accel=3Dkvm:tcg -nodefaults -boot order=3Dn "
> > +        "-netdev user,id=3D" NETNAME ",tftp=3D./,bootfile=3D%s,ipv4=3D=
%s,ipv6=3D%s "
> > +        "-device %s%s,netdev=3D" NETNAME,
> > +        test->machine, disk, ipv6 ? "off" : "on", ipv6 ? "on" : "off",
> > +        test->model, test->devopts ? test->devopts : "");
>=20
> Looking at this again, I think we could also simply always add the
> "bootindex=3D1" to the args string - this should not hurt, rather might
> help to boot faster, and then you could get rid of the"devopts" field in
> the testdef_t struct.

Good idea, I've made that change.

> Anyway, with or without that modification:
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ev7mvGV+3JQuI2Eo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo4mNEACgkQbDjKyiDZ
s5KNlA/+IXUT+KwIsd5x5YjPL5E0J75m9X5clgq9IBb02xgujk/Iz8OsML9C4yoH
HnnvAhLWENi4KkfldIcIpHR7C4d+O5vw3Gb8huM5Af2O9oSexBcoEW+cJ5OWI5H4
2ye1pfKk2FLhRJbpwVqA77jxqiExwHuoXVTZ3cpEoQccwQ2P/RLrGeKfHZl1dbEL
HG5txOsBSNjKUq3anwGRIpsn6tfsYUjWKaelaFuA4PvO5rd14bi4RLmRX7wYFGse
W/gyFP8kLJxbhBvrCK7dZa5w30Z5ov4QIsrXsdvkKadHjxbOzPAVK+zpP0QnORSH
H0D1/J9ZHcPXjMO5IlvLYuJtAMNEVQYzjfdI6HttacalXOSer0ATQiIDnA7CdXfF
Cz7zlUGBAVNhCln6bQzteNpVwBf/eO/U4H6z3k2zyiI969H/NQvYY26+5n7Yv6Yu
fspk7vfKtc3imAKq5vOGh6iMerVRTOyJ0G87y6SBSRNzZ9mvqQoSVKl9W1qQUOhL
OfMuiBxN5fl+DSc58Nd4yVwJzU8hU5RfWzPI5X+ZStDXOFSwnQn5LqQZZeSHRvud
DoiJfvtCuungvlFnlPj6JxmXz7iS3MqpFJGLy0flNY31RnOmZvIhLM+6/JZWsnku
Zafr0ZjAQOaeZFJkQtq5r+m+WbZ5QAPASY5e5bjOfaJFS63Jj+g=
=ChLs
-----END PGP SIGNATURE-----

--ev7mvGV+3JQuI2Eo--
