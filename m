Received: from eggs.gnu.org ([2001:4830:134:3::10]:46735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cJ1v3-0004Ag-7G
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 12:40:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cJ1v0-0001wo-0S
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 12:40:13 -0500
Message-ID: <1482169199.3732.6.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Mon, 19 Dec 2016 18:39:59 +0100
In-Reply-To: <7c5450f6-2688-d643-d020-2dcb92e8e52a@redhat.com>
References: <1479218565.3319.18.camel@redhat.com>
	<3353ecef-2308-13e3-025d-df41b2e89945@ozlabs.ru>
	<1479457042.1391.11.camel@redhat.com>
	<20161123050049.GD17795@umbus.fritz.box>
	<1480081581.4367.65.camel@redhat.com>
	<20161202041835.GF10089@umbus.fritz.box>
	<1481045447.6553.36.camel@redhat.com>
	<20161207041121.GB12489@umbus.fritz.box>
	<1481128923.3620.1.camel@redhat.com>
	<491c0ca6-c559-441b-7a14-3656bfc0abfc@redhat.com>
	<20161214024616.GE32647@umbus>
	<7c5450f6-2688-d643-d020-2dcb92e8e52a@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH qemu] spapr_pci: Create
 PCI-express root bus by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, libvir-list@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>, benh@kernel.crashing.org, Marcel Apfelbaum <mapfelba@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, 2016-12-14 at 20:26 +0200, Marcel Apfelbaum wrote:
> > > > > > Maybe I just don't quite get the relationship between Root
> > > > > > Complexes and Root Buses, but I guess my question is: what
> > > > > > is preventing us from simply doing whatever a
> > > > > > spapr-pci-host-bridge is doing in order to expose a legacy
> > > > > > PCI Root Bus (pci.*) to the guest, and create a new
> > > > > > spapr-pcie-host-bridge that exposes a PCIe Root Bus (pcie.*)
> > > > > > instead?
> > > > >=C2=A0
> > > > > Hrm, the suggestion of providing both a vanilla-PCI and PCI-E h=
ost
> > > > > bridge came up before.=C2=A0=C2=A0I think one of us spotted a p=
roblem with that,
> > > > > but I don't recall what it was now.=C2=A0=C2=A0I guess one is h=
ow libvirt would
> > > > > map it's stupid-fake-domain-numbers to which root bus to use.
> > >=C2=A0
> > > This would be a weird configuration, I never heard of something lik=
e that
> > > on a bare metal machine, but I never worked on pseries, who knows..=
.
> >=C2=A0
> > Which aspect?=C2=A0=C2=A0Having multiple independent host bridges is =
perfectly
> > reasonable - x86 just doesn't do it well for rather stupid historical
> > reasons.
>=C2=A0
> I agree about the multiple host-bridges, is actually what pxb/pxb-pcie
> devices (kind of) do.
>=C2=A0
> I was talking about having one PCI PHB and another PHB which is PCI Exp=
ress.
> I was referring to one system having both PCI and PCIe PHBs.

Sorry this confused you: what I was talking about was just
having both a legacy PCI PHB and a PCI Express PHB available
in QEMU, not using both for the same guest. The user would
pick one or the other and stick with it.

> > Again, one possible option here is to continue to treat pseries as
> > having a vanilla-PCI bus, but with a special flag saying that it's
> > magically able to connect PCI-E devices.
>=C2=A0
> A PCIe bus supporting PCI devices is strange (QEMU allows it ...),
> but a PCI bus supporting PCIe devices is hard to "swallow".

I agree.

> I would say maybe make it a special case of a PCIe bus with different r=
ules.
> It can derive from the PCIe bus class and override the usual behavior
> with PAPR specific rule which happen to be similar with the PCI bus rul=
es.

It's pretty clear by now that libvirt will need to have some
special handling of pseries guests. Having to choose between
"weird legacy PCI" and "weird PCI Express", I think I'd rather
go with the latter :)

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
