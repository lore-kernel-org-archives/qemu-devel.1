Received: from eggs.gnu.org ([2001:4830:134:3::10]:41933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVRu6-0004RB-3c
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 21:27:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVRu1-0003ZS-PM
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 21:27:22 -0400
Date: Wed, 20 Jun 2018 11:27:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180620012709.GI3546@umbus.fritz.box>
References: <cover.1528291908.git.balaton@eik.bme.hu>
	<d13ea58b288f386a12a76c41a617c500c4454341.1528291908.git.balaton@eik.bme.hu>
	<20180613012236.GQ30690@umbus.fritz.box>
	<alpine.BSF.2.21.1806131051410.620@zero.eik.bme.hu>
	<20180613100302.GJ30690@umbus.fritz.box>
	<alpine.BSF.2.21.1806131544190.90524@zero.eik.bme.hu>
	<20180618024619.GP25461@umbus.fritz.box>
	<alpine.BSF.2.21.1806191118540.87485@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nO3oAMapP4dBpMZi"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1806191118540.87485@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v2 3/8] ppc4xx_i2c: Implement directcntl
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>


--nO3oAMapP4dBpMZi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 19, 2018 at 11:29:09AM +0200, BALATON Zoltan wrote:
> On Mon, 18 Jun 2018, David Gibson wrote:
> > On Wed, Jun 13, 2018 at 04:03:18PM +0200, BALATON Zoltan wrote:
> > > On Wed, 13 Jun 2018, David Gibson wrote:
> > > > On Wed, Jun 13, 2018 at 10:54:22AM +0200, BALATON Zoltan wrote:
> > > > > On Wed, 13 Jun 2018, David Gibson wrote:
> > > > > > On Wed, Jun 06, 2018 at 03:31:48PM +0200, BALATON Zoltan wrote:
> > > > > > > diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
> > > > > > > index a68b5f7..5806209 100644
> > > > > > > --- a/hw/i2c/ppc4xx_i2c.c
> > > > > > > +++ b/hw/i2c/ppc4xx_i2c.c
> > > > > > > @@ -30,6 +30,7 @@
> > > > > > >  #include "cpu.h"
> > > > > > >  #include "hw/hw.h"
> > > > > > >  #include "hw/i2c/ppc4xx_i2c.h"
> > > > > > > +#include "bitbang_i2c.h"
> > > > > > >=20
> > > > > > >  #define PPC4xx_I2C_MEM_SIZE 18
> > > > > > >=20
> > > > > > > @@ -46,7 +47,13 @@
> > > > > > >=20
> > > > > > >  #define IIC_XTCNTLSS_SRST   (1 << 0)
> > > > > > >=20
> > > > > > > +#define IIC_DIRECTCNTL_SDAC (1 << 3)
> > > > > > > +#define IIC_DIRECTCNTL_SCLC (1 << 2)
> > > > > > > +#define IIC_DIRECTCNTL_MSDA (1 << 1)
> > > > > > > +#define IIC_DIRECTCNTL_MSCL (1 << 0)
> > > > > > > +
> > > > > > >  typedef struct {
> > > > > > > +    bitbang_i2c_interface *bitbang;
> > > > > > >      uint8_t mdata;
> > > > > > >      uint8_t lmadr;
> > > > > > >      uint8_t hmadr;
> > > > > > > @@ -308,7 +315,11 @@ static void ppc4xx_i2c_writeb(void *opaq=
ue, hwaddr addr, uint64_t value,
> > > > > > >          i2c->xtcntlss =3D value;
> > > > > > >          break;
> > > > > > >      case 16:
> > > > > > > -        i2c->directcntl =3D value & 0x7;
> > > > > > > +        i2c->directcntl =3D value & (IIC_DIRECTCNTL_SDAC & I=
IC_DIRECTCNTL_SCLC);
> > > > > > > +        i2c->directcntl |=3D (value & IIC_DIRECTCNTL_SCLC ? =
1 : 0);
> > > > > > > +        bitbang_i2c_set(i2c->bitbang, BITBANG_I2C_SCL, i2c->=
directcntl & 1);
> > > > > >=20
> > > > > > Shouldn't that use i2c->directcntl & IIC_DIRECTCNTL_MSCL ?
> > > > > >=20
> > > > > > > +        i2c->directcntl |=3D bitbang_i2c_set(i2c->bitbang, B=
ITBANG_I2C_SDA,
> > > > > > > +                               (value & IIC_DIRECTCNTL_SDAC)=
 !=3D 0) << 1;
> > > > > >=20
> > > > > > Last expression might be clearer as:
> > > > > > 	value & IIC_DIRECTCNTL_SDAC ? IIC_DIRECTCNTL_MSDA : 0
> > > > >=20
> > > > > I guess this is a matter of taste but to me IIC_DIRECTCNTL_MSDA i=
s a bit
> > > > > position in the register so I use that when accessing that bit bu=
t when I
> > > > > check for the values of a bit being 0 or 1 I don't use the define=
 which is
> > > > > for something else, just happens to have value 1 as well.
> > > >=20
> > > > Hmm.. but the bit is being store in i2c->directcntl, which means it
> > > > can be read back from the register in that position, no?
> > >=20
> > > Which of the above two do you mean?
> > >=20
> > > In the first one I test for the 1/0 value set by the previous line be=
fore
> > > the bitbang_i2c_set call. This could be accessed as MSCL later but us=
ing
> > > that here would just make it longer and less obvious. If I want to be
> > > absolutely precise maybe it should be (value & IIC_DIRECTCNTL_SCL ? 1=
 : 0)
> > > in this line too but that was just stored in the register one line be=
fore so
> > > I can reuse that here as well. Otherwise I could add another variable=
 just
> > > for this bit value and use that in both lines but why make it more
> > > complicated for a simple 1 or 0 value?
> >=20
> > Longer maybe, but I don't know about less obvious.  Actually I think
> > you should use IIC_DIRECTCNTL_MSCL instead of a bare '1' in both the
> > line setting i2c->directcntl, then the next line checking that bit to
> > pass it into bitbang_i2c_set.  The point is you're modifying the
> > effective register contents, so it makes sense to make it clearer
> > which bit of the register you're setting.
>=20
> When setting the bit it's the value 1 so that's not the bit
> position,

Huh??  The constants aren't bit positions either, they're masks.  How
is IIC_DIRECTCNTL_MSCL wrong here?

> I
> think 1 : 0 is correct there.

Correct, sure, but less clear than it could be.

> I've changed the next line in v4 I've just
> sent to the constant when checking the value of the MSCL bit.
>=20
> > > In the second case using MSDA is really not correct because the level=
 to set
> > > is defined by SDAC bit. The SDAC, SCLC bits are what the program sets=
 to
> > > tell which states the two i2c lines should be and the MSDA, MSCL are =
read
> > > only bits that show what states the lines really are.
> >=20
> > Ok...
> >=20
> > > IIC_DIRECTCNTL_MSDA has value of 1 but it means the second bit in the
> > > directcntl reg (which could have 0 or 1 value) not 1 value of a bit o=
r i2c
> > > line.
> >=20
> > Uh.. what?  AFAICT, based on the result of bitbang_i2c_set() you're
> > updating the value of the MSDA (=3D=3D 0x2) bit in i2c->directcntl
> > register state.  Why doesn't the symbolic name make sense here?
>=20
> Sorry, I may not have been able to clearly say what I mean. I meant that
> IIC_DIRECTCNTL_MSDA means the bit in position 1 (numbering from LSB being
> bit number 0) which may have value 1 or 0. In cases I mean the value I us=
e 1
> or 0. In case I refer to the bit position I use constants. In the line
>=20
> bitbang_i2c_set(i2c->bitbang, BITBANG_I2C_SCL, i2c->directcntl & 1);
>=20
> it should be the constant, just used 1 there for brevity because it's
> obvious from the previous line what's meant.

Maybe, but using the constant is still clearer, and friendly to people
grepping the source.

> I've changed this now. At other
> places the values of the bits are written as 1 or 0 so I think for those
> constants should not be needed.

I have no idea what you mean by this.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nO3oAMapP4dBpMZi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsprWwACgkQbDjKyiDZ
s5KQ2BAA5XKFhGkHMGAJFHAo9vgBYMY1GPxEzwe5b4mf/jWEDH/MEvBz8/tVYGjt
voUHSyLoEdU9S+uYqP4Oywlzr604Qh7JLRJfb5cA+0k3y2kzB86C2QMeMLiCs4N4
brIxQog53Q0fnQKF1hEqI64kd9JXK6Ws0lnnrfBEdTa27bUksK15kXPsYl26ZbvW
MEyLgj+tZPFZfk/BMpbG7N3qcjEDIiKztKPA9hDH1B1FrqYCWBX4HRZQPVfhIO9M
UkQ8Xsm1uuSoaHlySdXrTE4VV6bWPbvkAh7Yu2Mj+e6yGKul6nh9pnKHnK9HZaG4
a/SG7hip4a9ibKNeQXo9edKYGZjFno+7jdGbsGVncaoStLwtW/EBSrXRxgLKSwU3
C0KLZTLnDdMd5VNIqyAd8l6pKIdTFHJg4JMpDofXxCcTfLvI3gp3aOPH/6hczhtE
JaWT3GbzcXNxFsmuQCSDRBWv89qvdjKEZ8yWgAOwuAogiO7Dzo+bvdte5BsFEk9L
A9AmGxqnoOrKELSk3g0Bwz5u0sBipIfowjxSWk10bC9Ai0nja3EaTPdNPt1BcZcf
5gi2ielk6CS4b6CyRg6uMXTvshp0FZ3AfReUz+TSlXq2Qkc2aMhwj+OQPtceNXmK
XcEDDz0XeTYLEzM2wy+MWCxOqXsNkI8BGj9Nmx3TBQXMUx0/k9E=
=7yW6
-----END PGP SIGNATURE-----

--nO3oAMapP4dBpMZi--
