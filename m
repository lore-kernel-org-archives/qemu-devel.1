Received: from eggs.gnu.org ([2001:4830:134:3::10]:43778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fT2dC-0008TJ-JN
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:03:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fT2dB-00079a-0O
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:03:58 -0400
Date: Wed, 13 Jun 2018 20:03:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180613100302.GJ30690@umbus.fritz.box>
References: <cover.1528291908.git.balaton@eik.bme.hu>
	<d13ea58b288f386a12a76c41a617c500c4454341.1528291908.git.balaton@eik.bme.hu>
	<20180613012236.GQ30690@umbus.fritz.box>
	<alpine.BSF.2.21.1806131051410.620@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HwdYac1wHLTJyVrJ"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1806131051410.620@zero.eik.bme.hu>
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


--HwdYac1wHLTJyVrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2018 at 10:54:22AM +0200, BALATON Zoltan wrote:
> On Wed, 13 Jun 2018, David Gibson wrote:
> > On Wed, Jun 06, 2018 at 03:31:48PM +0200, BALATON Zoltan wrote:
> > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > > ---
> > >  default-configs/ppc-softmmu.mak    |  1 +
> > >  default-configs/ppcemb-softmmu.mak |  1 +
> > >  hw/i2c/ppc4xx_i2c.c                | 14 +++++++++++++-
> > >  3 files changed, 15 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-so=
ftmmu.mak
> > > index 4d7be45..7d0dc2f 100644
> > > --- a/default-configs/ppc-softmmu.mak
> > > +++ b/default-configs/ppc-softmmu.mak
> > > @@ -26,6 +26,7 @@ CONFIG_USB_EHCI_SYSBUS=3Dy
> > >  CONFIG_SM501=3Dy
> > >  CONFIG_IDE_SII3112=3Dy
> > >  CONFIG_I2C=3Dy
> > > +CONFIG_BITBANG_I2C=3Dy
> > >=20
> > >  # For Macs
> > >  CONFIG_MAC=3Dy
> > > diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs/ppc=
emb-softmmu.mak
> > > index 67d18b2..37af193 100644
> > > --- a/default-configs/ppcemb-softmmu.mak
> > > +++ b/default-configs/ppcemb-softmmu.mak
> > > @@ -19,3 +19,4 @@ CONFIG_USB_EHCI_SYSBUS=3Dy
> > >  CONFIG_SM501=3Dy
> > >  CONFIG_IDE_SII3112=3Dy
> > >  CONFIG_I2C=3Dy
> > > +CONFIG_BITBANG_I2C=3Dy
> > > diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
> > > index a68b5f7..5806209 100644
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
> > > @@ -46,7 +47,13 @@
> > >=20
> > >  #define IIC_XTCNTLSS_SRST   (1 << 0)
> > >=20
> > > +#define IIC_DIRECTCNTL_SDAC (1 << 3)
> > > +#define IIC_DIRECTCNTL_SCLC (1 << 2)
> > > +#define IIC_DIRECTCNTL_MSDA (1 << 1)
> > > +#define IIC_DIRECTCNTL_MSCL (1 << 0)
> > > +
> > >  typedef struct {
> > > +    bitbang_i2c_interface *bitbang;
> > >      uint8_t mdata;
> > >      uint8_t lmadr;
> > >      uint8_t hmadr;
> > > @@ -308,7 +315,11 @@ static void ppc4xx_i2c_writeb(void *opaque, hwad=
dr addr, uint64_t value,
> > >          i2c->xtcntlss =3D value;
> > >          break;
> > >      case 16:
> > > -        i2c->directcntl =3D value & 0x7;
> > > +        i2c->directcntl =3D value & (IIC_DIRECTCNTL_SDAC & IIC_DIREC=
TCNTL_SCLC);
> > > +        i2c->directcntl |=3D (value & IIC_DIRECTCNTL_SCLC ? 1 : 0);
> > > +        bitbang_i2c_set(i2c->bitbang, BITBANG_I2C_SCL, i2c->directcn=
tl & 1);
> >=20
> > Shouldn't that use i2c->directcntl & IIC_DIRECTCNTL_MSCL ?
> >=20
> > > +        i2c->directcntl |=3D bitbang_i2c_set(i2c->bitbang, BITBANG_I=
2C_SDA,
> > > +                               (value & IIC_DIRECTCNTL_SDAC) !=3D 0)=
 << 1;
> >=20
> > Last expression might be clearer as:
> > 	value & IIC_DIRECTCNTL_SDAC ? IIC_DIRECTCNTL_MSDA : 0
>=20
> I guess this is a matter of taste but to me IIC_DIRECTCNTL_MSDA is a bit
> position in the register so I use that when accessing that bit but when I
> check for the values of a bit being 0 or 1 I don't use the define which is
> for something else, just happens to have value 1 as well.

Hmm.. but the bit is being store in i2c->directcntl, which means it
can be read back from the register in that position, no?

> If this does not explain your question and you think it's better to use
> defines here I can change that in next version, please let me know.
>=20
> Regards,
> BALATON Zoltan
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HwdYac1wHLTJyVrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsg69UACgkQbDjKyiDZ
s5KaiQ//dpedZHcg8htPeYDOc/0ypc8gTSzYSggbJSn4n3nGzQnwzxTR5SmdQfe6
wTAjrfM737m3C/5u8JBKM7L/+sSUDaHn6/NWeGUCLSq3Y0d6OztY6+HficYoJjDD
J/IaSEivFO6GU1C73ywBSODjefl9M3G/BKEZ4qaK3dMXNyXVWUzvO2AqXYbzGTUE
sKRJ8b4MM6+njs4dLeKmaY7Jyf9uG+1OaFPnAyqy5nDVxW5o1E+2y70kFqUIqO+h
N8yfVL9Z2DtYlh8b3nh/eFflFQ8gZhdOGH25KnI/gGvmGI/FP+db/GwKSmLrAebx
1kKOA+FTFe6hp6pyocV6DqQdM7VBoABReMCiYZzsbnLblHzr92Gf24UYO8gUD7im
rX6w52L4J/H/g64JMBV3uY1DRM8FaHeJKA6oDAevD6XsN72K3MZQAVqjT+mArNUS
DurDzlm+gdGrpQK3Ud8pnhZLmJLjrTZWhGVLaehdLhiNGoddNb4JPwi/rfe6PAvm
br2XQkcWl/zbQvbM86mA4bT9n9g2PEyMlvcJmzvqrBwZsMxbZ1NwEK7lncFSceVh
lrQ0zsaSP3hTGRgpDSTzlospmOm9tv0FBIjsMztFT15HVddvQlDbzzcSwUEhzpFi
ETxme9NcbaLeJha+advW89RxwkS42wJGligq9yVB9BmZa4k9+es=
=BC6K
-----END PGP SIGNATURE-----

--HwdYac1wHLTJyVrJ--
