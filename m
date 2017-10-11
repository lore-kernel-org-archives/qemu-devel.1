Received: from eggs.gnu.org ([2001:4830:134:3::10]:43287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e2BSA-0006aJ-Ej
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 03:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e2BS6-0005bN-Fd
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 03:29:18 -0400
Received: from 7.mo4.mail-out.ovh.net ([178.33.253.54]:52910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e2BS6-0005an-9O
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 03:29:14 -0400
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 951DCDA4E4
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 09:29:12 +0200 (CEST)
Date: Wed, 11 Oct 2017 09:29:08 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171011092908.291c6cd6@bahia.lan>
In-Reply-To: <20171007051925.GJ10050@umbus.fritz.box>
References: <150730254473.16260.6484345241358746630.stgit@bahia>
	<20171007051925.GJ10050@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/CZH3pr41fEXM+vD.sVXwb9F";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] spapr_pci: fail gracefully with
 non-pseries machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

--Sig_/CZH3pr41fEXM+vD.sVXwb9F
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 7 Oct 2017 16:19:25 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Oct 06, 2017 at 05:09:04PM +0200, Greg Kurz wrote:
> > QEMU currently crashes when the user tries to add a spapr-pci-host-brid=
ge
> > on a non-pseries machine:
> >=20
> > $ qemu-system-ppc64 -M ppce500 -device spapr-pci-host-bridge,index=3D1
> > hw/ppc/spapr_pci.c:1535:spapr_phb_realize:
> > Object 0x1003dacae60 is not an instance of type spapr-machine
> > Aborted (core dumped)
> >=20
> > The same thing happens with the deprecated but still available child ty=
pe
> > spapr-pci-vfio-host-bridge.
> >=20
> > Fix both by checking the machine type with object_dynamic_cast().
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
>=20
>=20
> > ---
> >  hw/ppc/spapr_pci.c |    8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 5049ced4e8b4..9e85106f51f8 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1507,7 +1507,7 @@ static void spapr_pci_unplug_request(HotplugHandl=
er *plug_handler,
> > =20
> >  static void spapr_phb_realize(DeviceState *dev, Error **errp)
> >  {
> > -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> > +    sPAPRMachineState *spapr;
> >      SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
> >      sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(s);
> >      PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
> > @@ -1519,6 +1519,12 @@ static void spapr_phb_realize(DeviceState *dev, =
Error **errp)
> >      const unsigned windows_supported =3D
> >          sphb->ddw_enabled ? SPAPR_PCI_DMA_MAX_WINDOWS : 1;
> > =20
> > +    spapr =3D (sPAPRMachineState *) qdev_get_machine();
> > +    if (!object_dynamic_cast((Object *) spapr, TYPE_SPAPR_MACHINE)) {
> > +        error_setg(errp, TYPE_SPAPR_PCI_HOST_BRIDGE " needs a pseries =
machine");
> > +        return;
> > +    } =20
>=20
> This is slightly clunky.  You could instead use OBJECT_CHECK in the
> initializer, then just if (!spapr) here.
>=20

The negative review on v2 seem to indicate we have an agreement on using
object_dynamic_cast() explicitly. So we have two possibilities, either
the "clunky" v1, or possibly:

-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
+    /* We don't use SPAPR_MACHINE() in order to exit gracefully if the user
+     * tries to add a PHB to a non-pseries machine.
+     */
+    sPAPRMachineState *spapr =3D
+        (sPAPRMachineState *) object_dynamic_cast(qdev_get_machine(),
+                                                  TYPE_SPAPR_MACHINE);
     SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
     sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(s);
     PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
     char *namebuf;
     int i;
     PCIBus *bus;
     uint64_t msi_window_size =3D 4096;
     sPAPRTCETable *tcet;
     const unsigned windows_supported =3D
         sphb->ddw_enabled ? SPAPR_PCI_DMA_MAX_WINDOWS : 1;
=20
+    if (!spapr) {
+        error_setg(errp, TYPE_SPAPR_PCI_HOST_BRIDGE " needs a pseries mach=
ine");
+        return;
+    }
+

Which one do you prefer ? I'll also change spapr_cpu_core_realize()
if needed.

> > +
> >      if (sphb->index !=3D (uint32_t)-1) {
> >          sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> >          Error *local_err =3D NULL;
> >  =20
>=20
>=20


--Sig_/CZH3pr41fEXM+vD.sVXwb9F
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWd3IRAAKCRAC/DrrAQHb
wob6AKCfSmULTLUXx/AcF+ze/GxAWpXCDACffNJgtUHTODcmkRoueGAzo7Z/D1E=
=RBeO
-----END PGP SIGNATURE-----

--Sig_/CZH3pr41fEXM+vD.sVXwb9F--
