Received: from eggs.gnu.org ([2001:4830:134:3::10]:44550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cdqOO-0004eF-In
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 22:36:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cdqOL-0001Fp-Fr
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 22:36:32 -0500
Date: Wed, 15 Feb 2017 14:35:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170215033515.GF12369@umbus.fritz.box>
References: <1486978404-17509-1-git-send-email-clg@kaod.org>
	<20170214015843.GA2169@umbus.fritz.box>
	<0d8bcb67-2712-d15b-5989-99a40436b417@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oFbHfjnMgUMsrGjO"
Content-Disposition: inline
In-Reply-To: <0d8bcb67-2712-d15b-5989-99a40436b417@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] ppc/xics: fix XICSStateClass parent class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--oFbHfjnMgUMsrGjO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 14, 2017 at 07:25:07AM +0100, C=E9dric Le Goater wrote:
> On 02/14/2017 02:58 AM, David Gibson wrote:
> > On Mon, Feb 13, 2017 at 10:33:24AM +0100, C=E9dric Le Goater wrote:
> >> XICSState inherits from SysBusDevice and so the object class should
> >> inherit from SysBusDeviceClass.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > That's definitely a bug, but I don't think this is the right fix.
> >=20
> > XICS was put on sysbus back when I thought that was where you put any
> > "system" devices that didn't belong on a more specific bus.  I've
> > since discovered that's not the case, and - particularly since xics
> > doesn't expose any mmio - it shouldn't be a sysbus device at all.
> >=20
> > I've instead made a patch changing it to a direct child of
> > TYPE_DEVICE.  Since the device shouldn't ever be command line
> > instantiated, and it has no migratable state I believe this should be
> > a safe change.
> >=20
> > This is in ppc-for-2.9, tentatively; please review:
> >=20
> > From eae21fcf2430588f17e6a58d505aa8eaa580b507 Mon Sep 17 00:00:00 2001
> > From: David Gibson <david@gibson.dropbear.id.au>
> > Date: Tue, 14 Feb 2017 12:58:05 +1100
> > Subject: [PATCH] xics: XICS should not be a SysBusDevice
> >=20
> > Currently xics - the component of the IBM POWER interrupt controller
> > representing the overall interrupt fabric / architecture is represented=
 as
> > a descedent of SysBusDevice.  However, this is not really correct - the
>=20
> descendant ?

descendent, actually, we were both wrong.

>=20
> > xics presents nothing in MMIO space so it should be an "unattached" dev=
ice
> > in the current QOM model.
> >=20
> > Since this device will always be created by the machine type, not creat=
ed
> > specifically from the command line, and because it has no migrated state
> > it should be safe to move it around the device composition tree.
> >=20
> > Therefore this patch changes it to a descendent of TYPE_DEVICE, and mak=
es
> > it an unattached device.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Thanks,
>=20
> C.
>=20
> > ---
> >  hw/intc/xics.c | 2 +-
> >  hw/ppc/spapr.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> > index 095c16a..372b831 100644
> > --- a/hw/intc/xics.c
> > +++ b/hw/intc/xics.c
> > @@ -260,7 +260,7 @@ static void xics_common_class_init(ObjectClass *oc,=
 void *data)
> > =20
> >  static const TypeInfo xics_common_info =3D {
> >      .name          =3D TYPE_XICS_COMMON,
> > -    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > +    .parent        =3D TYPE_DEVICE,
> >      .instance_size =3D sizeof(XICSState),
> >      .class_size    =3D sizeof(XICSStateClass),
> >      .instance_init =3D xics_common_initfn,
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 6f37288..9b6ad0f 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -101,7 +101,7 @@ static XICSState *try_create_xics(const char *type,=
 int nr_servers,
> >      Error *err =3D NULL;
> >      DeviceState *dev;
> > =20
> > -    dev =3D qdev_create(NULL, type);
> > +    dev =3D DEVICE(object_new(type));
> >      qdev_prop_set_uint32(dev, "nr_servers", nr_servers);
> >      qdev_prop_set_uint32(dev, "nr_irqs", nr_irqs);
> >      object_property_set_bool(OBJECT(dev), true, "realized", &err);
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oFbHfjnMgUMsrGjO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYo8xxAAoJEGw4ysog2bOSc2YP/1uVVPlL0SbshWt36MZX1TDm
Dhg2TaVK8Na+v+Bb0gV+m6qi/CDbVnSy1igTRIUofeGmPLQT3vucdNuUTNYW5dvn
Xnm1HH7YZ9D4QjQKxblg8aKZFPrJyfQDk/vYPjP9QkGFSJ9hjDjvRRMljo0KUNZz
cek9jCVHDGrCwc+Z0ZEmSG/iASyuPMyyaHIfm/iNFYomfQdtJdArCTHdaAeK/iFG
S8sivd/KlHN3P8blEbkRhHmJ40914bG/GeaqR3XCU66wKyM8pICxsvm0oTKBi4NS
CwBy458SldEulyXFU+2uGS/sn17hx2cua/1wuIUcsFs76LylxwX6UKkBHqxeic6R
dAoGkFQYGERHb+xz12uk4JUfP2+5/itdex+vkkdid7p1FvbUDT+Lq4pYDRK8V2yd
9gSTd9VsxXvsfVdJpilCDHu3rAApNyviJ+zhBtjSI+Imd0+woxug7n1CQ7ALtLCt
u8tlHaJXeu6Ph1kIRg884m+hUF2saHF96uA9MXvjg3D9F+Rjr68S7qFVcuN869tT
1qOksMPPM5t5PLjLoxxhyrycdpXRip4zORdeekQy64A3cbGgEV6clnLw0ULMMqmx
+sL9C8wU02YTFz/x1zGhxGrhEzxuCjy2BKW9UdNId5KG2GBEJ0vm3L8meb/ZaUls
W/qQrbMKOW6tpmpEATsF
=iCfD
-----END PGP SIGNATURE-----

--oFbHfjnMgUMsrGjO--
