Received: from eggs.gnu.org ([2001:4830:134:3::10]:34783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e0reL-0002Aw-Hk
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 12:08:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e0reI-00015T-SJ
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 12:08:25 -0400
Received: from 16.mo4.mail-out.ovh.net ([188.165.55.104]:34102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e0reI-00014h-ME
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 12:08:22 -0400
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 31EA5D227D
	for <qemu-devel@nongnu.org>; Sat,  7 Oct 2017 18:08:21 +0200 (CEST)
Date: Sat, 7 Oct 2017 18:08:16 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171007180816.37a59497@bahia.lan>
In-Reply-To: <20171007100600.306d9280@bahia.lan>
References: <150730254473.16260.6484345241358746630.stgit@bahia>
	<20171007051925.GJ10050@umbus.fritz.box>
	<20171007100600.306d9280@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/QMX8f2/4gySHYR5LRjNvrkq";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr_pci: fail gracefully with
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

--Sig_/QMX8f2/4gySHYR5LRjNvrkq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 7 Oct 2017 10:06:00 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Sat, 7 Oct 2017 16:19:25 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, Oct 06, 2017 at 05:09:04PM +0200, Greg Kurz wrote: =20
> > > QEMU currently crashes when the user tries to add a spapr-pci-host-br=
idge
> > > on a non-pseries machine:
> > >=20
> > > $ qemu-system-ppc64 -M ppce500 -device spapr-pci-host-bridge,index=3D1
> > > hw/ppc/spapr_pci.c:1535:spapr_phb_realize:
> > > Object 0x1003dacae60 is not an instance of type spapr-machine
> > > Aborted (core dumped)
> > >=20
> > > The same thing happens with the deprecated but still available child =
type
> > > spapr-pci-vfio-host-bridge.
> > >=20
> > > Fix both by checking the machine type with object_dynamic_cast().
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>   =20
> >=20
> >=20
> >  =20
> > > ---
> > >  hw/ppc/spapr_pci.c |    8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > > index 5049ced4e8b4..9e85106f51f8 100644
> > > --- a/hw/ppc/spapr_pci.c
> > > +++ b/hw/ppc/spapr_pci.c
> > > @@ -1507,7 +1507,7 @@ static void spapr_pci_unplug_request(HotplugHan=
dler *plug_handler,
> > > =20
> > >  static void spapr_phb_realize(DeviceState *dev, Error **errp)
> > >  {
> > > -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> > > +    sPAPRMachineState *spapr;
> > >      SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
> > >      sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(s);
> > >      PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
> > > @@ -1519,6 +1519,12 @@ static void spapr_phb_realize(DeviceState *dev=
, Error **errp)
> > >      const unsigned windows_supported =3D
> > >          sphb->ddw_enabled ? SPAPR_PCI_DMA_MAX_WINDOWS : 1;
> > > =20
> > > +    spapr =3D (sPAPRMachineState *) qdev_get_machine();
> > > +    if (!object_dynamic_cast((Object *) spapr, TYPE_SPAPR_MACHINE)) {
> > > +        error_setg(errp, TYPE_SPAPR_PCI_HOST_BRIDGE " needs a pserie=
s machine");
> > > +        return;
> > > +    }   =20
> >=20
> > This is slightly clunky.  You could instead use OBJECT_CHECK in the
> > initializer, then just if (!spapr) here.
> >  =20
>=20
> Unless I'm missing something, OBJECT_CHECK() is precisely what we're
> removing with this patch to avoid the runtime assert...
>=20
> #define SPAPR_MACHINE(obj) \
>     OBJECT_CHECK(sPAPRMachineState, (obj), TYPE_SPAPR_MACHINE)
>=20

Since we already do this in spapr-cpu-core, I guess I'll hide the ugliness
in some macro. I'll send another patch.

> > > +
> > >      if (sphb->index !=3D (uint32_t)-1) {
> > >          sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> > >          Error *local_err =3D NULL;
> > >    =20
> >=20
> >  =20
>=20


--Sig_/QMX8f2/4gySHYR5LRjNvrkq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWdj78AAKCRAC/DrrAQHb
wuJFAKCIBOW3RefGimW6r6WeUWmbVX73EgCfVMbBbj2ugqe3zp+Z7s21izEaALo=
=g14q
-----END PGP SIGNATURE-----

--Sig_/QMX8f2/4gySHYR5LRjNvrkq--
