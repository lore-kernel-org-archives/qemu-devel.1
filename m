Received: from eggs.gnu.org ([2001:4830:134:3::10]:48205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1cGpAg-00070W-An
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 10:39:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1cGpAd-0005r0-Nl
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 10:39:14 -0500
Message-ID: <1481642137.17253.68.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 13 Dec 2016 09:15:37 -0600
In-Reply-To: <491c0ca6-c559-441b-7a14-3656bfc0abfc@redhat.com>
References: <20161031025314.GJ18226@umbus.fritz.box>
	<ee1d7da4-373c-4be0-7e67-897a1c90042f@ozlabs.ru>
	<20161101024634.GA14860@umbus.fritz.box>
	<1479218565.3319.18.camel@redhat.com>
	<3353ecef-2308-13e3-025d-df41b2e89945@ozlabs.ru>
	<1479457042.1391.11.camel@redhat.com>
	<20161123050049.GD17795@umbus.fritz.box>
	<1480081581.4367.65.camel@redhat.com>
	<20161202041835.GF10089@umbus.fritz.box>
	<1481045447.6553.36.camel@redhat.com>
	<20161207041121.GB12489@umbus.fritz.box>
	<1481128923.3620.1.camel@redhat.com>
	<491c0ca6-c559-441b-7a14-3656bfc0abfc@redhat.com>
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
To: Marcel Apfelbaum <marcel@redhat.com>, Andrea Bolognani <abologna@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, libvir-list@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>, Marcel Apfelbaum <mapfelba@redhat.com>

On Tue, 2016-12-13 at 14:25 +0200, Marcel Apfelbaum wrote:
> > > Hrm, the suggestion of providing both a vanilla-PCI and PCI-E host
> > > bridge came up before.=C2=A0 I think one of us spotted a problem wi=
th that,
> > > but I don't recall what it was now.=C2=A0 I guess one is how libvir=
t would
> > > map it's stupid-fake-domain-numbers to which root bus to use.
>=20
> This would be a weird configuration, I never heard of something like th=
at
> on a bare metal machine, but I never worked on pseries, who knows...

That's the thing though, it's *not* bare metal ;-)

On bare metal, we use the "powernv" platform for which we haven't yet ups=
treamed
the PCIE support, but there we have real PCIe root ports with all what's =
exepcted
on them.

They come on physically different PHB, one root complex per PHB, but they=
 are
"proper" PCIe. Hotplug is a bit weird still because it has to go through =
some
FW interactions as the HW doesn't use the PCIe standard slot control bits=
 (and
our qemu model doesn't handle it yet) but otherwise it's standard.

"pseries" on the other hand is a paravirtualized platform. It's the envir=
onment
presented to guests by our propritary hypervisor (PowerVM, aka pHyp) and
KVM/qemu. I think there's a public spec these days but to cut the story s=
hort,
it doesn't expose PCIe "properly" for bad historical reasons.

It tends to hide the parent, ie, the root port for slots connected direct=
ly to
a PHB or the entire hierarchy from the root to (and including) the downst=
ream
switch port for slots under as switch.

So you end up with PCIe devices devoid of a proper "parent" which is a bi=
t
weird.

Hotplug is implemented using specific firmware interfaces that are identi=
cal
with pre-PCIe (ie PCI/PCI-X) systems. The FW has interface for supporting=
 3
kinds of hotplug:

   - Entire PHBs
   - P2P Bridges
   - Individual devices on an existing PHB or P2P bridge

In practice these days mostly the first one is used for everything under =
pHyp,
though I think we have a mix of 1 and 3 for KVM/qemu.

Cheers,
Ben.
