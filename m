Received: from eggs.gnu.org ([2001:4830:134:3::10]:41212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dalpB-0001TU-Rc
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 12:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dalp8-0006Rd-Eg
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 12:39:45 -0400
Received: from 11.mo4.mail-out.ovh.net ([46.105.34.195]:51719)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dalp8-0006QP-4m
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 12:39:42 -0400
Received: from player759.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 868398916A
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 18:39:38 +0200 (CEST)
Date: Thu, 27 Jul 2017 18:39:26 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170727183926.246b5beb@bahia.lan>
In-Reply-To: <07a10650-f216-99ea-fb48-286887279bf1@linux.vnet.ibm.com>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<07a10650-f216-99ea-fb48-286887279bf1@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/IuboGY8+OVRWeyR=hCEQHyB";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [for-2.11 PATCH 00/26] spapr: add
 support for PHB hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Cedric Le Goater <clg@kaod.org>

--Sig_/IuboGY8+OVRWeyR=hCEQHyB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Jul 2017 17:31:17 -0300
Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> wrote:

> I've tested the patch set using Greg's Github branch. It worked fine in=20
> my tests
> using a Fedora 26 and an Ubuntu 17.04 guests. I have two observations
> though:
>=20
> 1 - This is not related to this patch set per se because it is=20
> reproducible on master, but
> I think it is interfering with this new feature.  There is a=20
> warning/error message in
> the kernel right after SLOF that goes:
>=20
> (...)
>   -> smp_release_cpus() =20
> spinning_secondaries =3D 0
>   <- smp_release_cpus()
> Linux ppc64le
> #1 SMP Mon Jul 1[    0.030450] pci 0000:00:02.0: of_irq_parse_pci:=20
> failed with rc=3D-22
> [    0.030552] pci 0000:00:0f.0: of_irq_parse_pci: failed with rc=3D-22
> [  OK  ] Started Security Auditing Service.
> (...)
>=20

This is a regression in QEMU master introduced by this commit:

commit b87680427e8a3ff682f66514e99a8344e7437247
Author: C=C3=A9dric Le Goater <clg@kaod.org>
Date:   Wed Jul 5 19:13:15 2017 +0200

    spapr: populate device tree depending on XIVE_EXPLOIT option
   =20
    When XIVE is supported, the device tree should be populated
    accordingly and the XIVE memory regions mapped to activate MMIOs.
   =20
    Depending on the design we choose, we could also allocate different
    ICS and ICP objects, or switch between objects. This needs to be
    discussed.
   =20
    Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
    Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

It is very similar to the issue that motivated the new KVMPPC_H_UPDATE_PHAN=
DLE
hcall (see patch 24 and 26 in this series):

- QEMU creates an "interrupt-controller" node with a phandle property
  with the value 0x1111
- QEMU passes the FDT to SLOF
- SLOF converts all references to the phandle to an SLOF internal value

=3D> from now on (ie, until the next machine reset), the guest only knows
   the OF phandle.

- during CAS, if we go XICS, we send back an updated FDT with the
  phandle of the "interrupt-controller" node reverted to 0x1111

=3D> the guest complains because all cold-plugged devices nodes refer
   to the OF phandle, not 0x1111

A solution is to use the value set by KVMPPC_H_UPDATE_PHANDLE during CAS
instead of 0x1111. I could verify it makes the guest warning disappear.

I'll send a dedicated patchset to fix this in 2.10.

> I get this same message after hotplugging a PCI device with this series,=
=20
> but the
> hotplug shows up in the lspci as expected:
>=20
> (qemu) device_add virtio-net-pci,id=3Dhp2.0,bus=3Dphb2.0
> (qemu) [  412.233441] pci 0002:00:00.0: of_irq_parse_pci: failed with rc=
=3D-22
>=20

This is the same error (the devices plugged in the new PHB all refer to
the OF phandle).

>=20
> 2 - when hotplugging the same PHB for the second time (device_add phb2,
> device_del phb2, device_add phb2 again) the hotplug works but dmesg got=20
> spammed
> by the messages:
>=20
> (qemu) device_add spapr-pci-host-bridge,index=3D2,id=3Dphb2
> (qemu) [  378.309490] rpaphp: rpaphp_register_slot: slot[C131106] is=20
> already registered
> [  378.309674] rpaphp: rpaphp_register_slot: slot[C131074] is already=20
> registered
> [  378.309841] rpaphp: rpaphp_register_slot: slot[C131087] is already=20
> registered
> [  378.310847] rpaphp: rpaphp_register_slot: slot[C131078] is already=20
> registered

Yeah, I saw that but I haven't investigated that yet.

> ( .... about 250+ messages like that )
>=20

The current default is to have 256 slots per PHB.

> Looks like device_del isn't cleaning up everything after the first hotplu=
g.
>=20

Or maybe the guest part (rpaphp or drmgr) ?

>=20
>=20
> Thanks,
>=20


Thanks very much for the testing! :)

Cheers,

--
Greg

>=20
> Daniel
>=20
>=20
> On 07/25/2017 02:57 PM, Greg Kurz wrote:
> > This series is based on patches from Michel Roth posted in 2015:
> >
> > https://lists.gnu.org/archive/html/qemu-devel/2015-04/msg04246.html
> >
> > It addresses comments made during the RFC review, and also provides a b=
unch
> > of preliminary cleanup/fix patches. Since we have reached hard-freeze, =
this
> > feature is provided by a new pseries-2.11 machine type, introduced by t=
his
> > series. It is based on David Gibson's ppc-for-2.10 branch, and I believ=
e some
> > of the preliminary fixes are eligible for 2.10.
> >
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
> >
> > http://git.qemu.org/?p=3DSLOF.git;h=3D604d28cc3f791657414f8b21103921fa0=
147fc63
> >
> > With these patches we support the following:
> >
> > (qemu) device_add spapr-pci-host-bridge,index=3D2,id=3Dphb2
> > (qemu) device_add virtio-net-pci,id=3Dhp2.0,bus=3Dphb2.0
> > (qemu) device_del hp2.0
> > (qemu) device_del phb2
> >
> > I could run some successful tests with a fedora25 guest:
> > - hotplug PHB + migrate + unplug PHB
> > - hotplug PHB + hotplug PCI device + unplug PHB =3D> PCI device gets un=
plugged
> > - migrate before OS starts + hotplug PHB =3D> destination uses OF phand=
les
> > - no regression observed with older machine types
> >
> > All the patches are also available here:
> >
> > https://github.com/gkurz/qemu/commits/spapr-hotplug-phb
> >
> > Cheers,
> >
> > --
> > Greg
> >
> > ---
> >
> > Greg Kurz (14):
> >        spapr: move spapr_create_phb() to core machine code
> >        spapr_pci: use memory_region_add_subregion() with DMA windows
> >        spapr_iommu: use g_strdup_printf() instead of snprintf()
> >        spapr_drc: use g_strdup_printf() instead of snprintf()
> >        spapr_iommu: convert TCE table object to realize()
> >        spapr_pci: parent the MSI memory region to the PHB
> >        spapr_drc: fix realize and unrealize
> >        spapr_drc: add unrealize method to physical DRC class
> >        spapr_iommu: unregister vmstate at unrealize time
> >        spapr: add pseries-2.11 machine type
> >        spapr_pci: introduce drc_id property
> >        spapr: allow guest to update the XICS phandle
> >        spapr_pci: drop abusive sanity check when migrating the LSI table
> >        spapr: add hotplug hooks for PHB hotplug
> >
> > Michael Roth (11):
> >        spapr_drc: pass object ownership to parent/owner
> >        spapr_iommu: pass object ownership to parent/owner
> >        pci: allow cleanup/unregistration of PCI buses
> >        qdev: store DeviceState's canonical path to use when unparenting
> >        spapr_pci: add PHB unrealize
> >        spapr: enable PHB hotplug for pseries-2.11
> >        spapr: create DR connectors for PHBs
> >        spapr_events: add support for phb hotplug events
> >        qdev: pass an Object * to qbus_set_hotplug_handler()
> >        spapr_pci: provide node start offset via spapr_populate_pci_dt()
> >        spapr_pci: add ibm, my-drc-index property for PHB hotplug
> >
> > Nathan Fontenot (1):
> >        spapr: populate PHB DRC entries for root DT node
> >
> >
> >   hw/acpi/piix4.c               |    2
> >   hw/char/virtio-serial-bus.c   |    2
> >   hw/core/bus.c                 |   11 --
> >   hw/core/qdev.c                |   15 ++-
> >   hw/pci/pci.c                  |   33 +++++++
> >   hw/pci/pcie.c                 |    2
> >   hw/pci/shpc.c                 |    2
> >   hw/ppc/spapr.c                |  205 ++++++++++++++++++++++++++++++++=
++++++++-
> >   hw/ppc/spapr_drc.c            |   65 ++++++++++---
> >   hw/ppc/spapr_events.c         |    3 +
> >   hw/ppc/spapr_hcall.c          |   20 ++++
> >   hw/ppc/spapr_iommu.c          |   22 +++-
> >   hw/ppc/spapr_pci.c            |   86 +++++++++++++----
> >   hw/s390x/css-bridge.c         |    2
> >   hw/s390x/s390-pci-bus.c       |    6 +
> >   hw/scsi/virtio-scsi.c         |    2
> >   hw/scsi/vmw_pvscsi.c          |    2
> >   hw/usb/dev-smartcard-reader.c |    2
> >   include/hw/compat.h           |    3 +
> >   include/hw/pci-host/spapr.h   |    9 +-
> >   include/hw/pci/pci.h          |    3 +
> >   include/hw/ppc/spapr.h        |   15 +++
> >   include/hw/ppc/spapr_drc.h    |    8 ++
> >   include/hw/qdev-core.h        |    4 -
> >   24 files changed, 446 insertions(+), 78 deletions(-)
> >
> > =20
>=20


--Sig_/IuboGY8+OVRWeyR=hCEQHyB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAll6Fz4ACgkQAvw66wEB28K3ngCeIJ1fOsT35LOACmJf9fJYjPs4
QbYAn108kQI3QN7uqi5x0y+/MCfjyT33
=YXTl
-----END PGP SIGNATURE-----

--Sig_/IuboGY8+OVRWeyR=hCEQHyB--
