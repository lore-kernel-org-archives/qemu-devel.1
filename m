Received: from eggs.gnu.org ([2001:4830:134:3::10]:40444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fY7aw-0005rj-Lw
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fY7av-0003wl-Ez
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:22:38 -0400
Message-ID: <8a5d8ae0f382003f8fc2ebf9083c995177c90695.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Wed, 27 Jun 2018 12:22:31 +0200
In-Reply-To: <dfe396c1-05f2-c776-f2af-303e9325c332@kaod.org>
References: <20180626135928.23950-1-clg@kaod.org>
	<7d5dbadc1bb62c40da5de76c2a02807b0b96e7c0.camel@redhat.com>
	<dfe396c1-05f2-c776-f2af-303e9325c332@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: Add model for Power8 PHB3 PCIe
 Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Tue, 2018-06-26 at 19:02 +0200, C=C3=A9dric Le Goater wrote:
> On 06/26/2018 05:57 PM, Andrea Bolognani wrote:
> > On Tue, 2018-06-26 at 15:59 +0200, C=C3=A9dric Le Goater wrote:
> > > This is a model of the PCIe host bridge found on Power8 chips,
> > > including PowerBus logic interface, IOMMU support, PCIe root comple=
x,
> > > XICS MSI and LSI interrupt sources.
> > >=20
> > > 4 PHBs are provisioned under the Power8 chip model to fit hardware =
but
> > > only one is currently initialized.
> >=20
> > What's the advantage in creating 4 PHBs instead of a single one,
>=20
> The Power8 chip comes in different flavors: Venice, Murano, Naple,=20
> each having a different number of PHBs. We don't need to initialize=20
> them all to plug only a couple of devices (net, storage, usbs)=20
>=20
> When time comes, we might want to test some more complex configurations
> or extend the modeling with CAPI support. That's why we have a :
>=20
> 	#define PNV_MAX_CHIP_PHB 4
> 	    PnvPHB3      phbs[PNV_MAX_CHIP_PHB];
>=20
> under the chip, and a 'num_phbs' attribute to increase the number
> of controllers. It still needs to be tested but that's the goal.

I was a bit confused about the difference between "provisioning"
and "initializing" a PHB, I guess.

Now that I've looked at the code, my (very uneducated) reading is
that you're allocating memory for 4 PHBs along with the chip, but
only actually initializing num_phbs of them, with 1 being the
default.

I have no idea what this implies when it comes to adding PCI
controller to the guest, though. If I run a guest with num_phbs=3D1,
are ids pci.1..pci.3 reserved even though the corresponding PHBs
have not been initialized? Is num_phbs the only way you can control
how many PHBs a PowerNV guest will have?

I would play around and try to figure out all the kinks on my own,
but I can't actually compile QEMU with this patch applied:

  hw/pci-host/pnv_phb3_msi.c: In function =E2=80=98phb3_msi_reset=E2=80=99=
:
  hw/pci-host/pnv_phb3_msi.c:229:11: error: =E2=80=98ICSStateClass=E2=80=99=
 {aka =E2=80=98struct ICSStateClass=E2=80=99} has no member named =E2=80=98=
parent_reset=E2=80=99; did you mean =E2=80=98parent_class=E2=80=99?
       icsc->parent_reset(dev);
             ^~~~~~~~~~~~
             parent_class
  hw/pci-host/pnv_phb3_msi.c: In function =E2=80=98phb3_msi_realize=E2=80=
=99:
  hw/pci-host/pnv_phb3_msi.c:260:11: error: =E2=80=98ICSStateClass=E2=80=99=
 {aka =E2=80=98struct ICSStateClass=E2=80=99} has no member named =E2=80=98=
parent_realize=E2=80=99; did you mean =E2=80=98parent_class=E2=80=99?
       icsc->parent_realize(dev, &local_err);
             ^~~~~~~~~~~~~~
             parent_class
  hw/pci-host/pnv_phb3_msi.c: In function =E2=80=98phb3_msi_class_init=E2=
=80=99:
  hw/pci-host/pnv_phb3_msi.c:293:43: error: =E2=80=98ICSStateClass=E2=80=99=
 {aka =E2=80=98struct ICSStateClass=E2=80=99} has no member named =E2=80=98=
parent_realize=E2=80=99; did you mean =E2=80=98parent_class=E2=80=99?
                                       &isc->parent_realize);
                                             ^~~~~~~~~~~~~~
                                             parent_class
  hw/pci-host/pnv_phb3_msi.c:295:41: error: =E2=80=98ICSStateClass=E2=80=99=
 {aka =E2=80=98struct ICSStateClass=E2=80=99} has no member named =E2=80=98=
parent_reset=E2=80=99; did you mean =E2=80=98parent_class=E2=80=99?
                                     &isc->parent_reset);
                                           ^~~~~~~~~~~~
                                           parent_class

> > like we already do for pSeries guests?=20
>=20
> I didn't follow that discussion but this is "another" kind of PHB.
> This one models the baremetal controller as found on OpenPOWER and
> IBM Power machines. pSeries has a virtual PHB.

I understand that, and of course libvirt will need to learn about
this new type of PHB and make sure both pSeries and PowerNV guests
get the correct one assigned to them.

What I meant is that pSeries guests get a single PHB by default,
with additional ones being instantiable through -device; this is
also consistent with how PCI controllers are added to other guest
types including pc, q35 and aarch64/virt, so it would be really
nice if PowerNV behaved the same way.

> > As it is, this will confuse the heck out of libvirt's PCI address > a=
llocation algorithm :)
>=20
> The pci bus name should be directly related to the PHB index. But
> I agree we need to be careful. That's why you are in cc: :)

Thanks, I really appreciate you keeping me in the loop :)

--=20
Andrea Bolognani / Red Hat / Virtualization
