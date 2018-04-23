Received: from eggs.gnu.org ([2001:4830:134:3::10]:42419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fARyI-0005Sp-TS
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 23:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fARyE-0000aD-TW
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 23:16:54 -0400
Received: from ozlabs.org ([203.11.71.1]:44887)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fARyD-0000W1-OG
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 23:16:50 -0400
Date: Mon, 23 Apr 2018 13:16:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180423031639.GB19804@umbus.fritz.box>
References: <20180421211652.14794-1-f4bug@amsat.org>
	<CAFEAcA_mSu00gEHgmfdpcvtaqfn7X0wbkUX54TCUW_FG+iURWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_mSu00gEHgmfdpcvtaqfn7X0wbkUX54TCUW_FG+iURWQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] loader: Fix misaligned member access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Paul Burton <paul.burton@mips.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 22, 2018 at 11:41:20AM +0100, Peter Maydell wrote:
> On 21 April 2018 at 22:16, Philippe Mathieu-Daud=E9 <f4bug@amsat.org> wro=
te:
> > This fixes the following ASan warning:
> >
> >   $ mips64el-softmmu/qemu-system-mips64el -M boston -kernel vmlinux.gz.=
itb -nographic
> >   hw/core/loader-fit.c:108:17: runtime error: load of misaligned addres=
s 0x7f95cd7e4264 for type 'fdt64_t', which requires 8 byte alignment
> >   0x7f95cd7e4264: note: pointer points here
> >     00 00 00 3e ff ff ff ff  80 7d 2a c0 00 00 00 01  68 61 73 68 40 30=
 00 00  00 00 00 03 00 00 00 14
> >                 ^
> >
> > Reported-by: AddressSanitizer
> > Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > ---
> >  hw/core/loader-fit.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
> > index 0c4a7207f4..1a69697f89 100644
> > --- a/hw/core/loader-fit.c
> > +++ b/hw/core/loader-fit.c
> > @@ -93,6 +93,8 @@ static int fit_image_addr(const void *itb, int img, c=
onst char *name,
> >                            hwaddr *addr)
> >  {
> >      const void *prop;
> > +    fdt32_t v32;
> > +    fdt64_t v64;
> >      int len;
> >
> >      prop =3D fdt_getprop(itb, img, name, &len);
> > @@ -102,10 +104,12 @@ static int fit_image_addr(const void *itb, int im=
g, const char *name,
> >
> >      switch (len) {
> >      case 4:
> > -        *addr =3D fdt32_to_cpu(*(fdt32_t *)prop);
> > +        memcpy(&v32, prop, sizeof(v32));
> > +        *addr =3D fdt32_to_cpu(v32);

So, assuming the base of the fdt is aligned (which I'd expect), then
properties should also be 32-bit aligned, so this shouldn't be
necessary.  They may not be 64-bit aligned, so the equivalent for
length 8 *is* required.

(Really old fdt versions did attempt to 64-bit align larger
properties, but it caused a bunch of other complications)

> If we need to do an unaligned load, then ldl_p() is the
> right way to do it. (We could also just do
>  *addr =3D ldl_be_p(prop) but we maybe don't want to
> bake in knowledge that FDT is big-endian).
>=20
> This does make me suspicious that maybe we're not using
> the fdt APIs right here though. Since 'prop' is the return
> value of fdt_getprop(), shouldn't libfdt be providing
> APIs for "give me the fdt32 here" that don't require
> the libfdt user to either implement its own unaligned
> access helpers or invoke C undefined behaviour? David,
> any suggestions?

It's pretty much correct usage.  Properties in fdt - as in Open
Firmware - are defined to be bytestrings.  libfdt is concerned with
extracting those bytestrings from the tree encoding, and parsing
what's inside the bytestring is mostly out of scope for it.

Mostly.. because we do have some helpers for common cases -
e.g. fdt_setprop_u32().  We don't currently have an fdt_getprop_u32()
or fdt_getprop_u64().  I'm not in principle opposed to adding them,
but the right interface isn't immediately obvious to me: we can't just
return a u32/u64, because then we have no way of reporting errors
(like "no such property").

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrdUBQACgkQbDjKyiDZ
s5KfFRAApUvNDv9r+PUCrd3sTb+GQ6QUlGxOMpnftkLO+e4tcVdtEYFqcleM3nny
oz0Ndb9rIVjNq1UT/C/U0WKDSPQVe7YZRWsGUeEzqHX9Mnrwv2/ptUkHKywk/Szu
cPcXFE04ZWBfmGISAJ937A4PQOmvxqkGLlaJreciIbbD6YxTRxa1k+uGn9fa7FT0
0Wtc76s+1iwMf1y1cQ2wgtZWyGWR7p5giI42SL/wlZQFtcplVSiv9vuMkOBj+B/N
QlWBwGOxA/J1XCqBqcraLK3/YuTQXWS/YBx18ZC1QLKbJz2VQQCIPPAyOa5D9Qb3
IeN93yETUKdlXqRzFBOJQseFc62FFYqJYhC6dtcgfA+gicCtHsJLOdujAY+9yIUT
godtgI01qp1IcYtExn4P7jlTGc6r2quyWcAxeEIfL5eSHHI6uzuUeaJvGJ7QS2IX
J+lXD60EnHJXn5gI2QMdw7e2qVsgDm97QG0sq8Ea1nXRX3QcDBAgKw4ITjDvXosX
mXE50EOy6/J3y+DZBnWYt15Zj8zetD9V43jIhsfcWMq4l5xG5fp6ghkbEGyUcP2e
Oeh/xD9gagSCG204oilOryrOeHlnwhO5fGl6luNzV5sXzZPzBUmbHmt4VL/jeWOB
XNDAVM3E31QHEUQSncDK/kx4OQs/CxEfYZ/jEAyQ/XW3LqNMRgU=
=bxdI
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
