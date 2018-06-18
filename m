Received: from eggs.gnu.org ([2001:4830:134:3::10]:59276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUiVR-0006Vi-Cw
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 20:58:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUiVN-00081Z-Da
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 20:58:53 -0400
Date: Mon, 18 Jun 2018 10:58:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180618005840.GJ25461@umbus.fritz.box>
References: <cover.1528935420.git.balaton@eik.bme.hu>
	<51f6ea83be6b66d61e3129edecddc3399a1df1b8.1528935420.git.balaton@eik.bme.hu>
	<20180614011705.GS30690@umbus.fritz.box>
	<alpine.BSF.2.21.1806140948540.19899@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z8yxTSU1mh2gsre7"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1806140948540.19899@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v3 2/9] ppc4xx_i2c: Implement directcntl
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


--Z8yxTSU1mh2gsre7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 09:51:33AM +0200, BALATON Zoltan wrote:
> On Thu, 14 Jun 2018, David Gibson wrote:
> > On Thu, Jun 14, 2018 at 02:17:00AM +0200, BALATON Zoltan wrote:
> > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >=20
> > Patch looks good, but it needs a commit message.  What is the
> > directcntl register?  Now does the bitbang interface play into that?
> > (Note that I know the answer to those questions right now, but it
> > needs to be in the commit message for the benefit of people looking
> > back in the future).
>=20
> If you know the answer could you please suggest an appropriate commit
> message? I'm a bit lost what should be written here that would explain the
> patch to someone who knows nothing about what this is. And for those who
> know, the patch itself should be fairly simple and not need more
> explanation.

It's not really about explaining it to someone ho knows nothing about
what it is.  Rather it's about explaining to someone who has a general
familiarity but hasn't been looking at this code recently.  Try
imagining explaining itself to yourself in several years time having
been working on something entirely different.

So, perhaps:

| As well as being able to generate its own i2c transactions, the
| ppc4xx i2c controller has a DIRECTCNTL register which allows
| explicit control of the i2c lines.
|
| Using this register an OS can directly bitbang i2c operations.  In
| order to let emulated i2c devices respond to this, we need to wire
| up the DIRECTCNTL register to qemu's bitbanged i2c handling code.


>=20
> Regards,
> BALATON Zoltan
>=20
> > > ---
> > >  default-configs/ppc-softmmu.mak    |  1 +
> > >  default-configs/ppcemb-softmmu.mak |  1 +
> > >  hw/i2c/ppc4xx_i2c.c                | 13 ++++++++++++-
> > >  include/hw/i2c/ppc4xx_i2c.h        |  4 ++++
> > >  4 files changed, 18 insertions(+), 1 deletion(-)
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
> > > index 4e0aaae..c0a1930 100644
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
> > > @@ -289,7 +295,11 @@ static void ppc4xx_i2c_writeb(void *opaque, hwad=
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
> > > +        i2c->directcntl |=3D bitbang_i2c_set(i2c->bitbang, BITBANG_I=
2C_SDA,
> > > +                               (value & IIC_DIRECTCNTL_SDAC) !=3D 0)=
 << 1;
> > >          break;
> > >      default:
> > >          if (addr < PPC4xx_I2C_MEM_SIZE) {
> > > @@ -322,6 +332,7 @@ static void ppc4xx_i2c_init(Object *o)
> > >      sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
> > >      sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
> > >      s->bus =3D i2c_init_bus(DEVICE(s), "i2c");
> > > +    s->bitbang =3D bitbang_i2c_init(s->bus);
> > >  }
> > >=20
> > >  static void ppc4xx_i2c_class_init(ObjectClass *klass, void *data)
> > > diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
> > > index e4b6ded..ea6c8e1 100644
> > > --- a/include/hw/i2c/ppc4xx_i2c.h
> > > +++ b/include/hw/i2c/ppc4xx_i2c.h
> > > @@ -31,6 +31,9 @@
> > >  #include "hw/sysbus.h"
> > >  #include "hw/i2c/i2c.h"
> > >=20
> > > +/* from hw/i2c/bitbang_i2c.h */
> > > +typedef struct bitbang_i2c_interface bitbang_i2c_interface;
> > > +
> > >  #define TYPE_PPC4xx_I2C "ppc4xx-i2c"
> > >  #define PPC4xx_I2C(obj) OBJECT_CHECK(PPC4xxI2CState, (obj), TYPE_PPC=
4xx_I2C)
> > >=20
> > > @@ -42,6 +45,7 @@ typedef struct PPC4xxI2CState {
> > >      I2CBus *bus;
> > >      qemu_irq irq;
> > >      MemoryRegion iomem;
> > > +    bitbang_i2c_interface *bitbang;
> > >      uint8_t mdata;
> > >      uint8_t lmadr;
> > >      uint8_t hmadr;
> >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Z8yxTSU1mh2gsre7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsnA8AACgkQbDjKyiDZ
s5I57xAAnrKvycyXgLI6nPEL/0Wm4dXPeISNQAtzOEoC1FCyr24bwlc6nQIpstdc
BG1MdI7d7sKN6ggyzrTqVArjGWmizniPFEhvYRa7yOIiubv/glqtaSKcoTp494nj
hsS/zgmsWtK/XAnknRT23vyh99PTalQtkgcUy1iraOjWjb5+ywyoA6RJ5R1+8Un8
Q8lS0QESRoB0Gcxjc7/I3/2gdlQenKntVcD4lg9znv++LD0wop7FVdAfeMwtzQ4n
EujYI5GHvnN/9cuZQoDoSIM224NEdZqqGGRHFB8q3g+A8NPzOmQqj96+sJ9umjz3
+GD0dvxKWmRnZjOfSmdMJVMaCh9h8RII0E77Ary/BnHdiFH+NevJfx+RMR/yt0Jm
IZ5hq0vj7m5Bb0/LKV2LOzd0i4lHKCmp0tRsbr2p4b9da+7EOU8P+cJP2FvFjrG9
1UvFKrOWjhPsDtDFnFytnrPD8hB0OPG+UGQ80qYsTVS1PoQ8qDU8NsEUWHj1iPOq
rwy6h21S7TXoTz8z36MHGQ4qxPCEJzOd9eSPnAS3hZ2UayRtoWXxWm2BwKQr1Uxs
2p/oSDXH6RLXbq6WZ8N+uK131vtQSAkjumLsaDLLFR5q5pvVMpsCzCRrATjcAN7U
NHyWRLP1ZhXrVmi9NAU738UtTQqWysMQ1jDTLwL/LbroKfrK2yM=
=jdqB
-----END PGP SIGNATURE-----

--Z8yxTSU1mh2gsre7--
