Received: from eggs.gnu.org ([2001:4830:134:3::10]:43769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUkBb-0005Nd-Tc
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 22:46:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUkBa-0001RG-IP
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 22:46:31 -0400
Date: Mon, 18 Jun 2018 12:46:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180618024619.GP25461@umbus.fritz.box>
References: <cover.1528291908.git.balaton@eik.bme.hu>
	<d13ea58b288f386a12a76c41a617c500c4454341.1528291908.git.balaton@eik.bme.hu>
	<20180613012236.GQ30690@umbus.fritz.box>
	<alpine.BSF.2.21.1806131051410.620@zero.eik.bme.hu>
	<20180613100302.GJ30690@umbus.fritz.box>
	<alpine.BSF.2.21.1806131544190.90524@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DBUa/BSa4z6QPQv1"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1806131544190.90524@zero.eik.bme.hu>
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


--DBUa/BSa4z6QPQv1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2018 at 04:03:18PM +0200, BALATON Zoltan wrote:
> On Wed, 13 Jun 2018, David Gibson wrote:
> > On Wed, Jun 13, 2018 at 10:54:22AM +0200, BALATON Zoltan wrote:
> > > On Wed, 13 Jun 2018, David Gibson wrote:
> > > > On Wed, Jun 06, 2018 at 03:31:48PM +0200, BALATON Zoltan wrote:
> > > > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > > > > ---
> > > > >  default-configs/ppc-softmmu.mak    |  1 +
> > > > >  default-configs/ppcemb-softmmu.mak |  1 +
> > > > >  hw/i2c/ppc4xx_i2c.c                | 14 +++++++++++++-
> > > > >  3 files changed, 15 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/default-configs/ppc-softmmu.mak b/default-configs/pp=
c-softmmu.mak
> > > > > index 4d7be45..7d0dc2f 100644
> > > > > --- a/default-configs/ppc-softmmu.mak
> > > > > +++ b/default-configs/ppc-softmmu.mak
> > > > > @@ -26,6 +26,7 @@ CONFIG_USB_EHCI_SYSBUS=3Dy
> > > > >  CONFIG_SM501=3Dy
> > > > >  CONFIG_IDE_SII3112=3Dy
> > > > >  CONFIG_I2C=3Dy
> > > > > +CONFIG_BITBANG_I2C=3Dy
> > > > >=20
> > > > >  # For Macs
> > > > >  CONFIG_MAC=3Dy
> > > > > diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs=
/ppcemb-softmmu.mak
> > > > > index 67d18b2..37af193 100644
> > > > > --- a/default-configs/ppcemb-softmmu.mak
> > > > > +++ b/default-configs/ppcemb-softmmu.mak
> > > > > @@ -19,3 +19,4 @@ CONFIG_USB_EHCI_SYSBUS=3Dy
> > > > >  CONFIG_SM501=3Dy
> > > > >  CONFIG_IDE_SII3112=3Dy
> > > > >  CONFIG_I2C=3Dy
> > > > > +CONFIG_BITBANG_I2C=3Dy
> > > > > diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
> > > > > index a68b5f7..5806209 100644
> > > > > --- a/hw/i2c/ppc4xx_i2c.c
> > > > > +++ b/hw/i2c/ppc4xx_i2c.c
> > > > > @@ -30,6 +30,7 @@
> > > > >  #include "cpu.h"
> > > > >  #include "hw/hw.h"
> > > > >  #include "hw/i2c/ppc4xx_i2c.h"
> > > > > +#include "bitbang_i2c.h"
> > > > >=20
> > > > >  #define PPC4xx_I2C_MEM_SIZE 18
> > > > >=20
> > > > > @@ -46,7 +47,13 @@
> > > > >=20
> > > > >  #define IIC_XTCNTLSS_SRST   (1 << 0)
> > > > >=20
> > > > > +#define IIC_DIRECTCNTL_SDAC (1 << 3)
> > > > > +#define IIC_DIRECTCNTL_SCLC (1 << 2)
> > > > > +#define IIC_DIRECTCNTL_MSDA (1 << 1)
> > > > > +#define IIC_DIRECTCNTL_MSCL (1 << 0)
> > > > > +
> > > > >  typedef struct {
> > > > > +    bitbang_i2c_interface *bitbang;
> > > > >      uint8_t mdata;
> > > > >      uint8_t lmadr;
> > > > >      uint8_t hmadr;
> > > > > @@ -308,7 +315,11 @@ static void ppc4xx_i2c_writeb(void *opaque, =
hwaddr addr, uint64_t value,
> > > > >          i2c->xtcntlss =3D value;
> > > > >          break;
> > > > >      case 16:
> > > > > -        i2c->directcntl =3D value & 0x7;
> > > > > +        i2c->directcntl =3D value & (IIC_DIRECTCNTL_SDAC & IIC_D=
IRECTCNTL_SCLC);
> > > > > +        i2c->directcntl |=3D (value & IIC_DIRECTCNTL_SCLC ? 1 : =
0);
> > > > > +        bitbang_i2c_set(i2c->bitbang, BITBANG_I2C_SCL, i2c->dire=
ctcntl & 1);
> > > >=20
> > > > Shouldn't that use i2c->directcntl & IIC_DIRECTCNTL_MSCL ?
> > > >=20
> > > > > +        i2c->directcntl |=3D bitbang_i2c_set(i2c->bitbang, BITBA=
NG_I2C_SDA,
> > > > > +                               (value & IIC_DIRECTCNTL_SDAC) !=
=3D 0) << 1;
> > > >=20
> > > > Last expression might be clearer as:
> > > > 	value & IIC_DIRECTCNTL_SDAC ? IIC_DIRECTCNTL_MSDA : 0
> > >=20
> > > I guess this is a matter of taste but to me IIC_DIRECTCNTL_MSDA is a =
bit
> > > position in the register so I use that when accessing that bit but wh=
en I
> > > check for the values of a bit being 0 or 1 I don't use the define whi=
ch is
> > > for something else, just happens to have value 1 as well.
> >=20
> > Hmm.. but the bit is being store in i2c->directcntl, which means it
> > can be read back from the register in that position, no?
>=20
> Which of the above two do you mean?
>=20
> In the first one I test for the 1/0 value set by the previous line before
> the bitbang_i2c_set call. This could be accessed as MSCL later but using
> that here would just make it longer and less obvious. If I want to be
> absolutely precise maybe it should be (value & IIC_DIRECTCNTL_SCL ? 1 : 0)
> in this line too but that was just stored in the register one line before=
 so
> I can reuse that here as well. Otherwise I could add another variable just
> for this bit value and use that in both lines but why make it more
> complicated for a simple 1 or 0 value?

Longer maybe, but I don't know about less obvious.  Actually I think
you should use IIC_DIRECTCNTL_MSCL instead of a bare '1' in both the
line setting i2c->directcntl, then the next line checking that bit to
pass it into bitbang_i2c_set.  The point is you're modifying the
effective register contents, so it makes sense to make it clearer
which bit of the register you're setting.

> In the second case using MSDA is really not correct because the level to =
set
> is defined by SDAC bit. The SDAC, SCLC bits are what the program sets to
> tell which states the two i2c lines should be and the MSDA, MSCL are read
> only bits that show what states the lines really are.

Ok...

> IIC_DIRECTCNTL_MSDA has value of 1 but it means the second bit in the
> directcntl reg (which could have 0 or 1 value) not 1 value of a bit or i2c
> line.

Uh.. what?  AFAICT, based on the result of bitbang_i2c_set() you're
updating the value of the MSDA (=3D=3D 0x2) bit in i2c->directcntl
register state.  Why doesn't the symbolic name make sense here?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DBUa/BSa4z6QPQv1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsnHPkACgkQbDjKyiDZ
s5JZehAAvB8JdEUYykdK1Oax7wdbCkmzENU/uaQsh6eVbYgOi+Hefdt4t9DrhETe
0XuRgXhNrQq+zwH76jqB6qt1XHfxe244pzq+ENcNKfOOYOIXzEDnKdlYMWyLXD8I
Px2QDlqjdUBLOHLnrkFF/2tF37xXsfol13UwAWUyGDnD0NJESavnSJm9wya+ck/W
Uq+sctBowbWAb/wpPuhvIBr+3OywDqbl+TU+C8mKT0fFmzYXkr7PrxyoG9nMxIcD
FTapODxBK1ibnz9FIzvJ+OyiU8QxsmYHkRa4BVsHNfNVnFvldjLp8v+OI4/Rvxsd
wlkrHP2AOKqzu1EKqFwMd5MA9qSJJEeANsX/0jJIogL8kLBi+EvpEjgeftnuwxvP
EXLgJCVsWO0b01E+GqNFuS6Aa4luOwd378K4x7J5+3GQq/v0Y26zijSAk+CyN6R0
FhXEd3Isnw0IsR8rbS4GTmlNhksuU37GZZ8OYhrDC7Tz5NZ/5ZKBPXmUxI2Bwx3z
NDcGEC8MO11c5iLaCsm1GfgU4pZoowqakqZ92xxp5upnJvJ3KEBBSqo6R8/cdYkP
1hmJnaAHfz8uxfKFfMMrzz3CPYDeXpXwWWaqhwScUm6JuojUSwEZnSkHVxgqJ2aW
GaQuhrUgqy2o1AmjSPazWxNcgxzMZgjAw1UmEXOJiH/BHHaewVs=
=YDWM
-----END PGP SIGNATURE-----

--DBUa/BSa4z6QPQv1--
