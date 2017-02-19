Received: from eggs.gnu.org ([2001:4830:134:3::10]:44931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cfW5S-0007uj-Su
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 13:19:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cfW5O-0003EK-S9
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 13:19:54 -0500
Message-ID: <1487528383.3729.52.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Sun, 19 Feb 2017 19:19:43 +0100
In-Reply-To: <255b322c-f294-4653-ee18-c549962445f5@redhat.com>
References: <95706652-0a80-92fc-951b-7a454d496ddf@redhat.com>
	<20170210003746.GP27610@umbus.fritz.box>
	<5ea3785c-b979-8b8c-3ab0-243d69384697@redhat.com>
	<20170213043307.GT25381@umbus>
	<45446029-e404-77d4-754e-5541a506bb7c@redhat.com>
	<20170214041532.GF2169@umbus.fritz.box>
	<c0e368b1-c89d-ef5a-d475-c92266d3eb41@redhat.com>
	<20170215014544.GC12369@umbus.fritz.box>
	<22b4c89b-bfeb-e196-73c3-927115398e5e@redhat.com>
	<20170216024842.GQ12369@umbus.fritz.box>
	<20170216032808.GR12369@umbus.fritz.box>
	<255b322c-f294-4653-ee18-c549962445f5@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] virtio-pci: Allow PCIe virtio devices on
 root bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Laszlo Ersek <lersek@redhat.com>, lvivier@redhat.com, thuth@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, kraxel@redhat.com, Eduardo Habkost <ehabkost@redhat.com>

On Thu, 2017-02-16 at 21:14 +0200, Marcel Apfelbaum wrote:
>=C2=A0=C2=A0> Wait, actually.. we have two possible directions to go, bo=
th of which
>=C2=A0=C2=A0> have been mentioned in the thread, but I don't think we've=
 settled on
>=C2=A0=C2=A0> one:
>=C2=A0=C2=A0>
>=C2=A0=C2=A0> 1) Have pseries create a PCIe bus (as my first cut draft d=
oes).
>=C2=A0=C2=A0>
>=C2=A0=C2=A0> That should allow pure PCIe devices to appear either under=
 a port or
>=C2=A0=C2=A0> (more usually for PAPR) as "integrated endpoints".=C2=A0=C2=
=A0In addition we'd
>=C2=A0=C2=A0> need as suggested above a "pcie_hybrid_type()" function th=
at would
>=C2=A0=C2=A0> tell hybrid devices to also appear as PCIe rather than PCI=
.
>=C2=A0=C2=A0>
>=C2=A0=C2=A0> 2) Have pseries create a vanilla PCI bus (or a special PAP=
R PCI
>=C2=A0=C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0variant)
>=C2=A0=C2=A0>
>=C2=A0=C2=A0> Appearing as vanilla PCI would in a number of ways more cl=
osely match
>=C2=A0=C2=A0> the way PCI buses are handled on PAPR.=C2=A0=C2=A0However,=
 we still need to
>=C2=A0=C2=A0> connect PCIe devices to it.=C2=A0=C2=A0So we'd need some '=
bus_accepts_pcie()'
>=C2=A0=C2=A0> hook and use that (in place of pci_bus_is_express()) to de=
termine both
>=C2=A0=C2=A0> whether we can attach pure PCIe devices and that hybrid de=
vices should
>=C2=A0=C2=A0> appear as PCIe rather than plain PCI.
>=C2=A0=C2=A0>
>=C2=A0=C2=A0>
>=C2=A0=C2=A0> Based on the immediately preceding discussion, I was leani=
ng towards
>=C2=A0=C2=A0> (2).=C2=A0=C2=A0Is that your feeling as well?
>=C2=A0
> I also like option (2).

After catching up with the thread, I tend to agree.

I've also been thinking about what libvirt would need to
do to adapt to the changes proposed here, and I believe the
answer to be: not much, really.

The current code already places VirtIO devices on the root
bus, even though it does so because it assumes pSeries
guests are not PCIe capable; same for XHCI, and pretty much
all other devices including those assigned through VFIO.

Basically, as far as I can tell, the changes proposed here
would only affect the guest (eg. ability to access the
extended config space), not how the devices would have to
be placed on the various buses. Or did I miss something?

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
