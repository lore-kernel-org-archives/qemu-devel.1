Received: from eggs.gnu.org ([2001:4830:134:3::10]:51922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fRDDQ-0002Cj-Dy
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fRDDP-0003Oy-IF
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:57:48 -0400
Date: Fri, 8 Jun 2018 18:50:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180608085054.GS3344@umbus.fritz.box>
References: <cover.1528291908.git.balaton@eik.bme.hu>
	<53f9d0b04374a3f4449af65ce01bd68dbe757ab5.1528291908.git.balaton@eik.bme.hu>
	<428ea537-a8d7-1c7c-7052-ea959797022d@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="e9fMjeYs+GPci+mg"
Content-Disposition: inline
In-Reply-To: <428ea537-a8d7-1c7c-7052-ea959797022d@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v2 1/8] ppc4xx_i2c: Clean up and improve
 error logging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>


--e9fMjeYs+GPci+mg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 06, 2018 at 12:56:32PM -0300, Philippe Mathieu-Daud=E9 wrote:
> On 06/06/2018 10:31 AM, BALATON Zoltan wrote:
> > Make it more readable by converting register indexes to decimal
> > (avoids lot of superfluous 0x0) and distinguish errors caused by
> > accessing non-existent vs. unimplemented registers.
> > No functional change.
> >=20
> > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > ---
> >  hw/i2c/ppc4xx_i2c.c | 94 +++++++++++++++++++++++++++++----------------=
--------
> >  1 file changed, 51 insertions(+), 43 deletions(-)
> >=20
> > diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
> > index ab64d19..d1936db 100644
> > --- a/hw/i2c/ppc4xx_i2c.c
> > +++ b/hw/i2c/ppc4xx_i2c.c
> > @@ -31,7 +31,7 @@
> >  #include "hw/hw.h"
> >  #include "hw/i2c/ppc4xx_i2c.h"
> > =20
> > -#define PPC4xx_I2C_MEM_SIZE 0x12
> > +#define PPC4xx_I2C_MEM_SIZE 18
>=20
> This looks weird, it seems all memory range sizes are in hex in other
> QEMU devices.

[snip]
> > @@ -263,32 +267,31 @@ static void ppc4xx_i2c_writeb(void *opaque, hwadd=
r addr, uint64_t value,
> >              }
> >          }
> >          break;
> > -    case 0x07:
> > -        i2c->mdcntl =3D value & 0xDF;
> > +    case 7:
> > +        i2c->mdcntl =3D value & 0xdf;
> >          break;
> > -    case 0x08:
> > -        i2c->sts &=3D ~(value & 0x0A);
> > +    case 8:
> > +        i2c->sts &=3D ~(value & 0xa);
>=20
> 'value & 0x0a' implicitly denotes than 'value' is a 8-bit register.
> Matter of taste...

I tend to prefer the forms you suggest, Philippe, but not by enough to
delay this otherwise good cleanup.  Especially since Balaton is taking
on this long neglected area of the code.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--e9fMjeYs+GPci+mg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsaQ2sACgkQbDjKyiDZ
s5K4GhAAtgSbvkYV87H9qyqqKrm5MZxNJmDqtDHt+SN1XAQq586fc1upxL66lrLk
M+TVe3G9dKGCHFm7c+I1V/R8nJTyglyHOdiYkqGhZITj4e6w0+TLOA1kd22Y9gpL
7T2cV3dd46cN4IIG7xbNd8xkwXr7QGRNoANdz5th0lBnjhijaqUzPLowmy48OZ+m
fKSF1QCRJA8ybsx0KHMv9fveRFBpr9Bv7OG2OU6EFkZXLkdrN9l4mgGvbttOcO4u
9/WJLCd0RuKAdg7WjpBHlIraaC04brleltSCGSqMyT5loQPWivdbgkKR/gIKvb51
1MRAfwKcLrw3vyXObJh9h9EHScyDOnYqh1Z3oizcqK868/yI07IYR4Wakcfx0Wdi
E//gfUQvE5QKyGkW7o6ujgWTSSJVDod9XPlLewfP+tDAY5Od0uwh1VW1Uthg8QKK
KwZj2JjiOL3oUvUuxtrVx88MTboqI65EePRqHTJdnQMmTY1bbmLvVOFMcFp7pFdB
iqIqFycRopjyDdRy4Y8hbJycqU5tT8ft4v4Kvn6u6cVf5kQjEH+BcUrF46RE62Bl
gZ9VqeXmpMRrj07mhyDM9aeJWUIpsq86FgBtjIhfh4HAbKCERUVu57XKpvzRNooK
ji8Z6f0ONPsO83l5KacGk5L0Up5zlnVbNKrNVrw3TbEp87wyIFw=
=/m5p
-----END PGP SIGNATURE-----

--e9fMjeYs+GPci+mg--
