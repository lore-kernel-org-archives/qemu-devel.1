Received: from eggs.gnu.org ([2001:4830:134:3::10]:36114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsUJw-0003fj-2Z
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 09:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsUJs-0005rH-UB
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 09:36:44 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:51698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dsUJs-0005pn-OA
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 09:36:40 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 2E901AB8D1
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 15:36:39 +0200 (CEST)
Date: Thu, 14 Sep 2017 15:36:32 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170914153632.51ba6b86@bahia.lan>
In-Reply-To: <20170914123126.GN3972@umbus.fritz.box>
References: <150537259490.3298.1180094221641142666.stgit@bahia>
	<20170914123126.GN3972@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/hj_00OqpHjFhdPG5S9/jIcu";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] spapr_pci: make index property mandatory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

--Sig_/hj_00OqpHjFhdPG5S9/jIcu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Sep 2017 22:31:26 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Sep 14, 2017 at 09:03:15AM +0200, Greg Kurz wrote:
> > Creating several PHBs without index property confuses the DRC code
> > and causes issues:
> > - only the first index-less PHB is functional, the other ones will
> >   silently ignore hotplugging of PCI devices
> > - QEMU will even terminate if these PHBs have cold-plugged devices
> >=20
> > qemu-system-ppc64: -device virtio-net,bus=3Dpci2.0: an attached device
> >  is still awaiting release
> >=20
> > This happens because DR connectors for child PCI devices are created
> > with a DRC index that is derived from the PHB's index property. If the
> > PHBs are created without index, then the same value of -1 is used to
> > compute the DRC indexes for both PHBs, hence causing the collision.
> >=20
> > Also, the index property is used to compute the placement of the PHB's
> > memory regions. It is limited to 31 or 255, depending on the machine
> > type version. This fits well with the requirements of DRC indexes, which
> > need the PHB index to be a 16-bit value.
> >=20
> > This patch hence makes the index property mandatory. As a consequence,
> > the PHB's memory regions and BUID are now always configured according
> > to the index, and it is no longer possible to set them from the command
> > line. We have to introduce a PHB instance init function to initialize
> > the 64-bit window address to -1 because pseries-2.7 and older machines
> > don't set it.
> >=20
> > This DOES BREAK backwards compat, but we don't think the non-index
> > PHB feature was used in practice (at least libvirt doesn't) and the
> > simplification is worth it.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> > RFC->v1: - as suggested dy David, updated the changelog to explicitely
> >            mention that we intentionally break backwards compat.
> > ---
[...snip...]
> > +static void spapr_phb_instance_init(Object *obj)
> > +{
> > +    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(obj);
> > +
> > +    sphb->mem64_win_addr =3D (hwaddr)-1;
> > +}
> > + =20
>=20
> Why do we need to initialize this field especially?
>=20

It is *somehow* explained in the commit log:

We have to introduce a PHB instance init function to initialize the
64-bit window address to -1 because pseries-2.7 and older machines
don't set it. [in the phb_placement hook]

    /*
     * We don't set the 64-bit MMIO window, relying on the PHB's
     * fallback behaviour of automatically splitting a large "32-bit"
     * window into contiguous 32-bit and 64-bit windows
     */

and spapr_phb_realize() doesn't set it either unless
sphb->mem_win_size > SPAPR_PCI_MEM32_WIN_SIZE...

But thinking again, I guess I should add an else block in spapr_phb_realize=
()
instead.

I'll send a v2 (and I'll send the checkpatch fix along it if you don't
mind).

> >  static void spapr_phb_class_init(ObjectClass *klass, void *data)
> >  {
> >      PCIHostBridgeClass *hc =3D PCI_HOST_BRIDGE_CLASS(klass);
> > @@ -1960,6 +1927,7 @@ static const TypeInfo spapr_phb_info =3D {
> >      .parent        =3D TYPE_PCI_HOST_BRIDGE,
> >      .instance_size =3D sizeof(sPAPRPHBState),
> >      .class_init    =3D spapr_phb_class_init,
> > +    .instance_init =3D spapr_phb_instance_init,
> >      .interfaces    =3D (InterfaceInfo[]) {
> >          { TYPE_HOTPLUG_HANDLER },
> >          { }
> >  =20
>=20


--Sig_/hj_00OqpHjFhdPG5S9/jIcu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWbqF4AAKCRAC/DrrAQHb
wmx6AJ4yC1ziaZntoiXOVmsCKayasOxK9wCfRMB2Z/IiJZNryLL+fi0/Le12Eq8=
=kZ0E
-----END PGP SIGNATURE-----

--Sig_/hj_00OqpHjFhdPG5S9/jIcu--
