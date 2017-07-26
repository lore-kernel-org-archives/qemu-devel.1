Received: from eggs.gnu.org ([2001:4830:134:3::10]:52076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1daI0H-0005MB-6Q
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1daI0C-000717-Jc
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:49:13 -0400
Received: from 2.mo5.mail-out.ovh.net ([178.33.109.111]:49380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1daI0C-0006yP-9a
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:49:08 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id C8D51116409
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 10:49:06 +0200 (CEST)
Date: Wed, 26 Jul 2017 10:48:54 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170726104854.26ad0e3e@bahia.lan>
In-Reply-To: <180bce1f-9da5-969e-df03-421f05285d00@ozlabs.ru>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<180bce1f-9da5-969e-df03-421f05285d00@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/1b=lhkQlpNn_P5WH5pEniiG";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [for-2.11 PATCH 00/26] spapr: add support for PHB
 hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

--Sig_/1b=lhkQlpNn_P5WH5pEniiG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Jul 2017 13:44:55 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 26/07/17 03:57, Greg Kurz wrote:
> > This series is based on patches from Michel Roth posted in 2015:
> >=20
> > https://lists.gnu.org/archive/html/qemu-devel/2015-04/msg04246.html
> >=20
> > It addresses comments made during the RFC review, and also provides a b=
unch
> > of preliminary cleanup/fix patches. Since we have reached hard-freeze, =
this
> > feature is provided by a new pseries-2.11 machine type, introduced by t=
his
> > series. It is based on David Gibson's ppc-for-2.10 branch, and I believ=
e some
> > of the preliminary fixes are eligible for 2.10.
> >=20
> > Note that it also requires an updated SLOF that supports a new private =
hcall:
> > KVMPPC_H_UPDATE_PHANDLE. This is needed because SLOF changes FDT phandl=
es to
> > Open Firmware phandles. Since the guest only sees the latter, QEMU must=
 use
> > the updated value when populating the FDT for the hotplugged PHB (other=
wise
> > the guest can't setup IRQs for the PCI devices). SLOF part is already u=
pstream:
> >=20
> > http://git.qemu.org/?p=3DSLOF.git;h=3D604d28cc3f791657414f8b21103921fa0=
147fc63
> >=20
> > With these patches we support the following:
> >=20
> > (qemu) device_add spapr-pci-host-bridge,index=3D2,id=3Dphb2
> > (qemu) device_add virtio-net-pci,id=3Dhp2.0,bus=3Dphb2.0
> > (qemu) device_del hp2.0
> > (qemu) device_del phb2
> >=20
> > I could run some successful tests with a fedora25 guest:
> > - hotplug PHB + migrate + unplug PHB
> > - hotplug PHB + hotplug PCI device + unplug PHB =3D> PCI device gets un=
plugged
> > - migrate before OS starts + hotplug PHB =3D> destination uses OF phand=
les
> > - no regression observed with older machine types
> >=20
> > All the patches are also available here:
> >=20
> > https://github.com/gkurz/qemu/commits/spapr-hotplug-phb
> >=20
> > Cheers,
> >=20
> > --
> > Greg
> >=20
> > ---
> >=20
> > Greg Kurz (14):
> >       spapr: move spapr_create_phb() to core machine code
> >       spapr_pci: use memory_region_add_subregion() with DMA windows
> >       spapr_iommu: use g_strdup_printf() instead of snprintf()
> >       spapr_drc: use g_strdup_printf() instead of snprintf()
> >       spapr_iommu: convert TCE table object to realize()
> >       spapr_pci: parent the MSI memory region to the PHB
> >       spapr_drc: fix realize and unrealize
> >       spapr_drc: add unrealize method to physical DRC class
> >       spapr_iommu: unregister vmstate at unrealize time
> >       spapr: add pseries-2.11 machine type =20
>=20
> >       spapr_pci: introduce drc_id property
> >       spapr: allow guest to update the XICS phandle
> >       spapr_pci: drop abusive sanity check when migrating the LSI table
> >       spapr: add hotplug hooks for PHB hotplug =20
>=20
>=20
> This one did not make it to the lists.
>=20

Yeah, I've just realized that 'stg mail' failed to send this patch because
of a connection problem with OVH's mail relay... :-\

I've sent it again with --in-reply-to, so that it goes to the appropriate
thread.

>=20
>=20
> >=20
> > Michael Roth (11):
> >       spapr_drc: pass object ownership to parent/owner
> >       spapr_iommu: pass object ownership to parent/owner
> >       pci: allow cleanup/unregistration of PCI buses
> >       qdev: store DeviceState's canonical path to use when unparenting
> >       spapr_pci: add PHB unrealize
> >       spapr: enable PHB hotplug for pseries-2.11>       spapr: create D=
R connectors for PHBs =20
>=20
>=20
> >       spapr_events: add support for phb hotplug events
> >       qdev: pass an Object * to qbus_set_hotplug_handler()
> >       spapr_pci: provide node start offset via spapr_populate_pci_dt()
> >       spapr_pci: add ibm, my-drc-index property for PHB hotplug
> >=20
> > Nathan Fontenot (1):
> >       spapr: populate PHB DRC entries for root DT node
> >=20
> >=20
> >  hw/acpi/piix4.c               |    2=20
> >  hw/char/virtio-serial-bus.c   |    2=20
> >  hw/core/bus.c                 |   11 --
> >  hw/core/qdev.c                |   15 ++-
> >  hw/pci/pci.c                  |   33 +++++++
> >  hw/pci/pcie.c                 |    2=20
> >  hw/pci/shpc.c                 |    2=20
> >  hw/ppc/spapr.c                |  205 +++++++++++++++++++++++++++++++++=
+++++++-
> >  hw/ppc/spapr_drc.c            |   65 ++++++++++---
> >  hw/ppc/spapr_events.c         |    3 +
> >  hw/ppc/spapr_hcall.c          |   20 ++++
> >  hw/ppc/spapr_iommu.c          |   22 +++-
> >  hw/ppc/spapr_pci.c            |   86 +++++++++++++----
> >  hw/s390x/css-bridge.c         |    2=20
> >  hw/s390x/s390-pci-bus.c       |    6 +
> >  hw/scsi/virtio-scsi.c         |    2=20
> >  hw/scsi/vmw_pvscsi.c          |    2=20
> >  hw/usb/dev-smartcard-reader.c |    2=20
> >  include/hw/compat.h           |    3 +
> >  include/hw/pci-host/spapr.h   |    9 +-
> >  include/hw/pci/pci.h          |    3 +
> >  include/hw/ppc/spapr.h        |   15 +++
> >  include/hw/ppc/spapr_drc.h    |    8 ++
> >  include/hw/qdev-core.h        |    4 -
> >  24 files changed, 446 insertions(+), 78 deletions(-)
> >=20
> >  =20
>=20
>=20


--Sig_/1b=lhkQlpNn_P5WH5pEniiG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAll4V3YACgkQAvw66wEB28IZbwCfbfohYkqF7qL/jVlN45qKiXK3
4/IAn3y0qAcMUYzWXhutHvBAMw9QWCE/
=kPWJ
-----END PGP SIGNATURE-----

--Sig_/1b=lhkQlpNn_P5WH5pEniiG--
