Received: from eggs.gnu.org ([2001:4830:134:3::10]:51002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWJdI-0003Pw-8m
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWJdD-0001K6-Uv
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:49:36 -0400
Date: Fri, 22 Jun 2018 20:49:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180622104907.GK612@umbus.fritz.box>
References: <cover.1529398335.git.balaton@eik.bme.hu>
	<ce619ddd11a875caae4c221c18ebf7c6a6f4bd4f.1529398335.git.balaton@eik.bme.hu>
	<20180620052044.GA24636@umbus.fritz.box>
	<alpine.BSF.2.21.1806210900160.16898@zero.eik.bme.hu>
	<20180622015940.GF612@umbus.fritz.box>
	<alpine.BSF.2.21.1806220952410.66303@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zPXeIxDajdrcF2en"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1806220952410.66303@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v4 02/11] ppc4xx_i2c: Implement directcntl
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


--zPXeIxDajdrcF2en
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 22, 2018 at 10:00:34AM +0200, BALATON Zoltan wrote:
> On Fri, 22 Jun 2018, David Gibson wrote:
> > On Thu, Jun 21, 2018 at 09:17:11AM +0200, BALATON Zoltan wrote:
> > > On Wed, 20 Jun 2018, David Gibson wrote:
> > > > On Tue, Jun 19, 2018 at 10:52:15AM +0200, BALATON Zoltan wrote:
> > > > > As well as being able to generate its own i2c transactions, the p=
pc4xx
> > > > > i2c controller has a DIRECTCNTL register which allows explicit co=
ntrol
> > > > > of the i2c lines.
> > > > >=20
> > > > > Using this register an OS can directly bitbang i2c operations. In
> > > > > order to let emulated i2c devices respond to this, we need to wir=
e up
> > > > > the DIRECTCNTL register to qemu's bitbanged i2c handling code.
> > > > >=20
> > > > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > > > > ---
> > > > > v4: Updated commit message and use defined constant where
> > > > > appropriate
> > > >=20
> > > > I'm still don't quite understand your approach to the symbolic
> > > > constants here, but I don't care enough to hold this up any further.
> > > > So, applied to ppc-for-3.0.
> > >=20
> > > Thanks, just to try to clear this up, I consider symbolic constants t=
o be
> > > the name of bits 0-3 in the directntl register so while MSCL equals 1=
 it's
> > > only appropriate to use the constant if I really mean (1 << 0) i.e. b=
it 0 of
> > > directcntl reg.
> >=20
> > Right..
> >=20
> > >=20
> > > > > diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
> > > > > index 4e0aaae..fca80d6 100644
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
> > > > > @@ -46,6 +47,11 @@
> > > > >=20
> > > > >  #define IIC_XTCNTLSS_SRST   (1 << 0)
> > > > >=20
> > > > > +#define IIC_DIRECTCNTL_SDAC (1 << 3)
> > > > > +#define IIC_DIRECTCNTL_SCLC (1 << 2)
> > > > > +#define IIC_DIRECTCNTL_MSDA (1 << 1)
> > > > > +#define IIC_DIRECTCNTL_MSCL (1 << 0)
> > > > > +
> > > > >  static void ppc4xx_i2c_reset(DeviceState *s)
> > > > >  {
> > > > >      PPC4xxI2CState *i2c =3D PPC4xx_I2C(s);
> > > > > @@ -289,7 +295,12 @@ static void ppc4xx_i2c_writeb(void *opaque, =
hwaddr addr, uint64_t value,
> > > > >          i2c->xtcntlss =3D value;
> > > > >          break;
> > > > >      case 16:
> > > > > -        i2c->directcntl =3D value & 0x7;
> > > > > +        i2c->directcntl =3D value & (IIC_DIRECTCNTL_SDAC & IIC_D=
IRECTCNTL_SCLC);
> > >=20
> > > This clears all bits but SDAC and SCLC so constants are OK here as th=
ey
> > > refer to bits in the register. (Guest can set the S* bits to say what=
 state
> > > it wants the i2c lines to become.)
> > >=20
> > > > > +        i2c->directcntl |=3D (value & IIC_DIRECTCNTL_SCLC ? 1 : =
0);
> > >=20
> > > This is directcntl[MSCL] =3D direcntl[SCLC] that is, set MSCL bit the=
 same as
> > > SCLC, the 1 : 0 here are the value of the bit not the MSCL bit so con=
stans
> > > are not appropriate here.
> >=20
> > This is what I don't get.  Regardless of the method of it, you *are*
> > setting bit 1 of the directcntl register, so why would the MSCL name
> > not be appropriate?
>=20
> I'm setting bit 0 (MSCL) to either 1 or 0. I could probably use the MSCL
> constant in place of the 1 here but would that make it clearer?

Yeah, it kinda would.  Instead of the line saying "it sets bit 0 based
on this" it would say "this sets the MSCL bit based on this" which is
probably more useful information.  In addition, if someone greps
looking find everywhere the MSCL bit is manipulated, they'll find it.

> It would
> just be longer and less clear without looking up the constants so to me t=
his
> looks more comprehensible this way.
>=20
> > > > > +        bitbang_i2c_set(i2c->bitbang, BITBANG_I2C_SCL,
> > > > > +                        i2c->directcntl & IIC_DIRECTCNTL_MSCL);
> > >=20
> > > This lets the bitbang_i2c emulation also know that MSCL is set to 1 o=
r 0 so
> > > constant here is OK, previously it was just 1 for brevity which may h=
ave
> > > confused you.
> > >=20
> > > > > +        i2c->directcntl |=3D bitbang_i2c_set(i2c->bitbang, BITBA=
NG_I2C_SDA,
> > > > > +                               (value & IIC_DIRECTCNTL_SDAC) !=
=3D 0) << 1;
> > >=20
> > > This sets MSDA bit of directcntl to the value returned by bitbang_i2c
> > > emulation when sending it the bit in SDAC. So the
> > > (value & IIC_DIRECTCNTL_SDAC) !=3D 0)
> > > tests what value the SDAC bit has so 0 means the value of the bit and
> > > constant refers to the bit in the register. (Because SDAC is not the =
LSB and
> > > we need 1 or 0 here hence the equality test to normalise the value, m=
aybe
> > > the !! construct could also be used, I'm not sure.) The << 1 at the e=
nd
> > > makes sure we set the MSDA bit but that constant cannot be used here =
and
> > > using MSCL instead is not correct because we mean the MSDA bit.
> >=20
> > Right, I'm not suggesting you use MSCL here, I'm suggesting you use
> > MSDA.
>=20
> But how? Third arg of bitbang_i2c_set is level, either 0 or 1. How could a
> constant with value 2 used here? (Also to set bit 1 I have to shift 1 not=
 2
> so I don't see how the constant could be used there either.)

Don't use the shift.

i2c->directcntl |=3D bitbang_i2c_set(i2c->bitmang, BITBANG_I2C_SDA,
				   !!(value & IIC_DIRECTCNTL_SDAC))
			? IIC_DIRECTCNTL_MSDA : 0;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zPXeIxDajdrcF2en
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlss1B8ACgkQbDjKyiDZ
s5LgmRAAnS++MRlJNHJ2BFXuGHRPKYvjCJm/Sq41xrGVfMBvkr8kw2b07XgI/8CZ
9ozPVCJE0LLV8V9FSrUu/S8EFHHZzUanIJbsk8Ze3CPvAZlPaFK6LIdG8ZQsbFzb
OJL4koQKmP7mU9kOYE0bM0dG2Ko3oR3eI9t7N/yH/TjC53rHBPHHHOsDtFzFa4ZU
kFl0OkfvPqtGVU6ALLIaz5qTTilLVDRkVgzsrnZgGA7sEl3an0f0ey7ZfvC0wzT5
CaqdFsu8REN3SYumXXmlYRy7x/K7YaBzfUCmKcu4UjGFXpVSE4ZnVAZKuQlBRceW
XOT6WuPB7sVKd+3slAy/oMv/u/zgo6Dmb6kXEBot1/lQMcS1xL0Grw7oFcQIkUHB
oqr/CkkvHWmVlYEoXgVQY7DdLkMESPs6uC6CwS5ZZ2B59IJjJ1tThNgKR6jv3Gax
/Sxao9AAQVsNPKHfDQaCvqT8O8wKnDzvfAg7TZy8b9y1gdr32N7TUWmRt17iJf+W
J2XL5cC9gYnTLU52xZXAdpeHrtHHiPp0uQ3esW+z9ruxzhygJ09Itg8WUNemQ1sJ
CW+aGyEejHX+LYinUGRhCenUQEApNmhkih/mTY+TQyIZ1RF4gfgzetrf0Th+KTxe
M0PVAFAZfhKjyINvSWLa5AV/7J97Dwz1Zgctq2hiSvv4uLAt9XU=
=kzb3
-----END PGP SIGNATURE-----

--zPXeIxDajdrcF2en--
