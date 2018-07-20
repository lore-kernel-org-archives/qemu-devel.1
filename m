Received: from eggs.gnu.org ([2001:4830:134:3::10]:48611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fgLJw-0007F6-OO
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 22:39:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fgLJv-00019p-A1
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 22:39:04 -0400
Date: Fri, 20 Jul 2018 12:38:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180720023839.GF18205@umbus.fritz.box>
References: <20180706090713.15712-1-clg@kaod.org>
	<20180706090713.15712-2-clg@kaod.org>
	<20180706153624.77494d28@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vA66WO2vHvL/CRSR"
Content-Disposition: inline
In-Reply-To: <20180706153624.77494d28@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v4 1/3] spapr: introduce a fixed IRQ number
 space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--vA66WO2vHvL/CRSR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 06, 2018 at 03:36:24PM +0200, Greg Kurz wrote:
> On Fri,  6 Jul 2018 11:07:11 +0200
> C=E9dric Le Goater <clg@kaod.org> wrote:
[snip]
> > +/*
> > + * The register property of a VIO device is defined in livirt using a
> > + * base number + 0x1000 increment and in QEMU by incrementing the base
> > + * register number 0x71000000.
> > + *
> > + * The formula below tries to compute a unique index number from the
> > + * register value that will be used to define the IRQ number of the
> > + * VIO device. A maximum of 256 (0x100) VIO devices is covered.
> > + *
> > + * To minimize collisions, we define two distinct ranges depending on
> > + * the "reg" value definition:
> > + *
> > + *     [0x00 - 0x7f]    user/libvirt
> > + *     [0x80 - 0xff]    QEMU VIO model
> > + *
> > + * Collisions will be detected when the IRQ is claimed.
> > + */
> > +static inline uint32_t spapr_vio_reg_to_irq(uint32_t reg)
> > +{
> > +    if (reg >=3D SPAPR_VIO_REG_BASE) {
> > +        return SPAPR_IRQ_VIO | (reg & 0x7f) | 0x80;
> > +    } else {
> > +        return SPAPR_IRQ_VIO | ((reg & 0x7f) ^ ((reg >> 12) & 0x7f));
>=20
> Hmm... if you put a VIO net and two VIO vty in the domain XML, libvirt
> will generate reg =3D=3D 0x1000 for the VIO net and reg =3D=3D 0x30001000=
 for the
> second VIO vty... this will necessarily collide, won't it ?

Ah, drat, yeah, this will still need some tweaking.

> With a 256 VIO devices limit, libvirt can only add 255 devices since
> the nvram is created by QEMU by default (libvirt can only change its
> reg using -global).

Note that the 256 limit is basically arbitrary.  I don't think it
exists in the code now, but it should be way more than sufficient.

> As David mentioned in another mail:
>=20
> 	VIO net devices start at reg=3D0x1000
> 	VIO scsi devices start at reg=3D0x2000
> 	VIO nvram devices start at reg=3D0x3000
> 	VIO vty devices start at reg=3D0x30000000
> 	    and increment by 0x1000 each type
>=20
>=20
> The values for net, scsi and nvram overlap... which makes me wonder why
> do we even care to have per-type base value !?!

We don't, really, I'm not sure why it ended up like that.

> Anyway, I don't think
> it's important for what you're trying to achieve.
>=20
> Basically libvirt can generate regs in two distinct ranges:
>=20
> - one for scsi/net/nvram:
>=20
> smallest possible reg: 0x1000
> largest possible reg: 0x2000 + 254 * 0x1000 =3D 0x100000
>=20
> ie, 254 scsi devices starting at 0x2000 and 1 nvram
>=20
> - one for vty=20
>=20
> smallest possible reg: 0x30000000
> largest possible reg: 0x30000000 + 253 * 0x1000 =3D 0x300fd000
>=20
> ie, 254 vty devices
>=20
> Thinking about the bit shifting magic that is needed to convert
> reg into a usable index makes my brain hurt, but I'll happily
> review anything you propose :)

Considering just the libvirt assigned addresses how about:

	if (reg >=3D 0x30000000)
		irq =3D VIO_BASE + 240 + (reg >> 12); // up to 16 vtys
	else
		irq =3D VIO_BASE + (reg >> 12);       // up to 238 others

(+ some masking to enforce the limits).

I think it's ok to overlap the "qemu" and "libvirt" ranges, since
(with the exception of the nvram device) I don't see any natural way
you'd get both schemes in use at once.  If the user overrides things,
either on the qemu command line or in the libvirt XML to combine the
two schemes, then we're back to "fix your own mess by manually
allocating irqs as well".

Note that the above formula doesn't use VIO_BASE+0 itself, so I think
we can then factor in the qemu assigned devices with just a:
	irq ^=3D (reg & 0xff);

>=20
> > +    }
> > +}
> > +
> >  static void spapr_vio_busdev_realize(DeviceState *qdev, Error **errp)
> >  {
> >      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> > @@ -485,10 +512,18 @@ static void spapr_vio_busdev_realize(DeviceState =
*qdev, Error **errp)
> >      }
> > =20
> >      if (!dev->irq) {
> > -        dev->irq =3D spapr_irq_findone(spapr, &local_err);
> > -        if (local_err) {
> > -            error_propagate(errp, local_err);
> > -            return;
> > +        if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> > +            dev->irq =3D spapr_irq_findone(spapr, &local_err);
> > +            if (local_err) {
> > +                error_propagate(errp, local_err);
> > +                return;
> > +            }
> > +        } else {
> > +            dev->irq =3D spapr_vio_reg_to_irq(dev->reg);
> > +            if (dev->irq =3D=3D SPAPR_IRQ_PCI_LSI) {
> > +                error_setg(errp, "Too many VIO devices");
> > +                return;
> > +            }
> >          }
> >      }
> > =20
> > @@ -557,7 +592,7 @@ VIOsPAPRBus *spapr_vio_bus_init(void)
> >      /* Create bus on bridge device */
> >      qbus =3D qbus_create(TYPE_SPAPR_VIO_BUS, dev, "spapr-vio");
> >      bus =3D SPAPR_VIO_BUS(qbus);
> > -    bus->next_reg =3D 0x71000000;
> > +    bus->next_reg =3D SPAPR_VIO_REG_BASE;
> > =20
> >      /* hcall-vio */
> >      spapr_register_hypercall(H_VIO_SIGNAL, h_vio_signal);
> > diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> > index bcab6323b7ed..4ab556467289 100644
> > --- a/hw/ppc/Makefile.objs
> > +++ b/hw/ppc/Makefile.objs
> > @@ -4,7 +4,7 @@ obj-y +=3D ppc.o ppc_booke.o fdt.o
> >  obj-$(CONFIG_PSERIES) +=3D spapr.o spapr_caps.o spapr_vio.o spapr_even=
ts.o
> >  obj-$(CONFIG_PSERIES) +=3D spapr_hcall.o spapr_iommu.o spapr_rtas.o
> >  obj-$(CONFIG_PSERIES) +=3D spapr_pci.o spapr_rtc.o spapr_drc.o spapr_r=
ng.o
> > -obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o
> > +obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o spapr_irq.o
> >  # IBM PowerNV
> >  obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_=
psi.o pnv_occ.o pnv_bmc.o
> >  ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vA66WO2vHvL/CRSR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltRSy0ACgkQbDjKyiDZ
s5I8ahAAkXpvhrgtJZ3yhMewYiX41autQadlNKAvPiqCei4loAVRy7tbA8Kg4Avq
JawL2CfqeTzx1yYr2GY/qWmUYLaoxAupIETj2nx6RWOXAHLMvXt904UWTfEIe8bz
iioblLScyM7X4qxsa3NpKVB4luVLUVyJSDjLQZLM1cYKQ3RUaYTOPmb0ddXclR+e
tiaNGQm5ozp8yuqKV8H/e+JmLFxoy8jyoZ8K5xRKETx14u+RJ3D/ZGhMaveDl+xc
7lipzOIuGxl1ajvK0WlpqepS7D0XVIxeGflB2x9zxUfkKoEaR6YqWJ1ubX6tNjvY
ijhtuwwl5gohyC+hR9s2e6ce5XesOZXddE8Mv3fYb11vAir7XHcSTdTUvQRHBu6V
5vRA23hmwS5HU1fe7yErlQczwDgItGsr0u7S4gIMa+H1uiBEh7Pu/yUBTUq3ktFf
u0Dgi5Xw/emyUn723WpIwEpMChtDUwyxJ9JsSpRdn4QuRADWh1OuJUNoXZCg4yIN
VDcnfU/1eVb/1MgsQtdFoceglqMWttyntZWId2W7Bt71j6ayy9QrrnYFv4HoOm4P
VDwmd+Eei+HwlBh1O0nbC3zIuwbhx/WFBzr9IqVzeNZUmDb+w8zXpOIEZgQy/9F0
SlHzOdkZM9WiQ6llABhb+O2AQdaNjN9va1DGxkOcnqJXBf8Tp50=
=cnxF
-----END PGP SIGNATURE-----

--vA66WO2vHvL/CRSR--
