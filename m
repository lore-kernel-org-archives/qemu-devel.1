Received: from eggs.gnu.org ([2001:4830:134:3::10]:50538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWBjG-0003Ck-W0
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 22:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWBjD-0006F2-L0
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 22:23:14 -0400
Date: Fri, 22 Jun 2018 11:59:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180622015940.GF612@umbus.fritz.box>
References: <cover.1529398335.git.balaton@eik.bme.hu>
	<ce619ddd11a875caae4c221c18ebf7c6a6f4bd4f.1529398335.git.balaton@eik.bme.hu>
	<20180620052044.GA24636@umbus.fritz.box>
	<alpine.BSF.2.21.1806210900160.16898@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dgjlcl3Tl+kb3YDk"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1806210900160.16898@zero.eik.bme.hu>
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


--dgjlcl3Tl+kb3YDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 21, 2018 at 09:17:11AM +0200, BALATON Zoltan wrote:
> On Wed, 20 Jun 2018, David Gibson wrote:
> > On Tue, Jun 19, 2018 at 10:52:15AM +0200, BALATON Zoltan wrote:
> > > As well as being able to generate its own i2c transactions, the ppc4xx
> > > i2c controller has a DIRECTCNTL register which allows explicit control
> > > of the i2c lines.
> > >=20
> > > Using this register an OS can directly bitbang i2c operations. In
> > > order to let emulated i2c devices respond to this, we need to wire up
> > > the DIRECTCNTL register to qemu's bitbanged i2c handling code.
> > >=20
> > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > > ---
> > > v4: Updated commit message and use defined constant where
> > > appropriate
> >=20
> > I'm still don't quite understand your approach to the symbolic
> > constants here, but I don't care enough to hold this up any further.
> > So, applied to ppc-for-3.0.
>=20
> Thanks, just to try to clear this up, I consider symbolic constants to be
> the name of bits 0-3 in the directntl register so while MSCL equals 1 it's
> only appropriate to use the constant if I really mean (1 << 0) i.e. bit 0=
 of
> directcntl reg.

Right..

>=20
> > > diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
> > > index 4e0aaae..fca80d6 100644
> > > --- a/hw/i2c/ppc4xx_i2c.c
> > > +++ b/hw/i2c/ppc4xx_i2c.c
> > > @@ -30,6 +30,7 @@
> > >  #include "cpu.h"
> > >  #include "hw/hw.h"
> > >  #include "hw/i2c/ppc4xx_i2c.h"
> > > +#include "bitbang_i2c.h"
> > >=20
> > >  #define PPC4xx_I2C_MEM_SIZE 18
> > >=20
> > > @@ -46,6 +47,11 @@
> > >=20
> > >  #define IIC_XTCNTLSS_SRST   (1 << 0)
> > >=20
> > > +#define IIC_DIRECTCNTL_SDAC (1 << 3)
> > > +#define IIC_DIRECTCNTL_SCLC (1 << 2)
> > > +#define IIC_DIRECTCNTL_MSDA (1 << 1)
> > > +#define IIC_DIRECTCNTL_MSCL (1 << 0)
> > > +
> > >  static void ppc4xx_i2c_reset(DeviceState *s)
> > >  {
> > >      PPC4xxI2CState *i2c =3D PPC4xx_I2C(s);
> > > @@ -289,7 +295,12 @@ static void ppc4xx_i2c_writeb(void *opaque, hwad=
dr addr, uint64_t value,
> > >          i2c->xtcntlss =3D value;
> > >          break;
> > >      case 16:
> > > -        i2c->directcntl =3D value & 0x7;
> > > +        i2c->directcntl =3D value & (IIC_DIRECTCNTL_SDAC & IIC_DIREC=
TCNTL_SCLC);
>=20
> This clears all bits but SDAC and SCLC so constants are OK here as they
> refer to bits in the register. (Guest can set the S* bits to say what sta=
te
> it wants the i2c lines to become.)
>=20
> > > +        i2c->directcntl |=3D (value & IIC_DIRECTCNTL_SCLC ? 1 : 0);
>=20
> This is directcntl[MSCL] =3D direcntl[SCLC] that is, set MSCL bit the sam=
e as
> SCLC, the 1 : 0 here are the value of the bit not the MSCL bit so constans
> are not appropriate here.

This is what I don't get.  Regardless of the method of it, you *are*
setting bit 1 of the directcntl register, so why would the MSCL name
not be appropriate?

>=20
> > > +        bitbang_i2c_set(i2c->bitbang, BITBANG_I2C_SCL,
> > > +                        i2c->directcntl & IIC_DIRECTCNTL_MSCL);
>=20
> This lets the bitbang_i2c emulation also know that MSCL is set to 1 or 0 =
so
> constant here is OK, previously it was just 1 for brevity which may have
> confused you.
>=20
> > > +        i2c->directcntl |=3D bitbang_i2c_set(i2c->bitbang, BITBANG_I=
2C_SDA,
> > > +                               (value & IIC_DIRECTCNTL_SDAC) !=3D 0)=
 << 1;
>=20
> This sets MSDA bit of directcntl to the value returned by bitbang_i2c
> emulation when sending it the bit in SDAC. So the
> (value & IIC_DIRECTCNTL_SDAC) !=3D 0)
> tests what value the SDAC bit has so 0 means the value of the bit and
> constant refers to the bit in the register. (Because SDAC is not the LSB =
and
> we need 1 or 0 here hence the equality test to normalise the value, maybe
> the !! construct could also be used, I'm not sure.) The << 1 at the end
> makes sure we set the MSDA bit but that constant cannot be used here and
> using MSCL instead is not correct because we mean the MSDA bit.

Right, I'm not suggesting you use MSCL here, I'm suggesting you use
MSDA.

> In summary, guest sets SDAC and SCLC as it wants the i2c lines and MSDA a=
nd
> MSCL are set by the device to what state the lines are actually in. (The S
> in first two regs may stand for Set while M stands for Monitor.)
>=20
> Regards,
> BALATON Zoltan
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dgjlcl3Tl+kb3YDk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlssWAkACgkQbDjKyiDZ
s5KMdA/9Fidk1Yp6RhWjIup0J68whvOS/H8t5QRMb8ww4dSNzUmgrAqewpT5MXef
7ID6W/seZuwp1ZJCfZkaonz7JqYxpFUMC/CyiNCxvu6r4wdtJ/sZEVKy23OQo7oH
Dw9Q6UeLbM1KNyW7FN/x1e7e813JI5jEvWWw+CufklkASmvOoCiYXyfBM7kDVQ5W
BwxfYyFN1qFVh9GyOa8tYh4S2ulmfCTU8zMBwljtNN4xJAtza3wcKC08ezPSjUNY
Bhg8orjgtV1x0AAjuGXEf1em3jbdqR3T7FBCAEmQToJb2CqmQmLvEgexmLRaQ3bh
7ahzYlRpjd18FOQdiyl9sgRaPQt/eJWSNSj2vKqcL76t7Dmq3qYx1w2R01XiIeQZ
Sqnt+1oaL0uJ2FWxi63TKDOYVhGp8OkC/bs1bmWlILlxho8tQiqmkvG/pZ88g+mw
A67ljij4AXxiaA04WEuxL0Gj11cg0HIu+LwcyUbwUxSxV2n24ss+hyeNJbq5kBwH
c4FtCIvcNUuZ0/ockR9qcH3xNHgb66Omct6dKok80rGuhNFISGpjBVqzXFs7Kj8e
KzvSI4Bj1o/nWfXFaWsXSNqnOS48JOZhzIM/cBlZfCcSFpNdiidVw+SrC95ETeT2
wzlo0qtYBTZzb/27twpoqU3/+DNnHgTxmNUHc5o1WY5HrjJ/vOI=
=XDW6
-----END PGP SIGNATURE-----

--dgjlcl3Tl+kb3YDk--
