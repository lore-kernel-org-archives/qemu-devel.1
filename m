Received: from eggs.gnu.org ([2001:4830:134:3::10]:39446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cEJa2-0004i5-4f
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 12:31:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cEJZw-0000Gh-Sd
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 12:31:02 -0500
Message-ID: <1481045447.6553.36.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Tue, 06 Dec 2016 18:30:47 +0100
In-Reply-To: <20161202041835.GF10089@umbus.fritz.box>
References: <1477641400-23292-1-git-send-email-aik@ozlabs.ru>
	<20161028120712.4a911866@bahia>
	<20161031025314.GJ18226@umbus.fritz.box>
	<ee1d7da4-373c-4be0-7e67-897a1c90042f@ozlabs.ru>
	<20161101024634.GA14860@umbus.fritz.box>
	<1479218565.3319.18.camel@redhat.com>
	<3353ecef-2308-13e3-025d-df41b2e89945@ozlabs.ru>
	<1479457042.1391.11.camel@redhat.com>
	<20161123050049.GD17795@umbus.fritz.box>
	<1480081581.4367.65.camel@redhat.com>
	<20161202041835.GF10089@umbus.fritz.box>
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, libvir-list@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>, benh@kernel.crashing.org

On Fri, 2016-12-02 at 15:18 +1100, David Gibson wrote:
> > So, would the PCIe Root Bus in a pseries guest behave
> > differently than the one in a q35 or mach-virt guest?
>=C2=A0
> Yes.=C2=A0=C2=A0I had a long discussion with BenH and got a somewhat be=
tter idea
> about this.

Sorry, but I'm afraid you're going to have to break this
down even further for me :(

> If only a single host PE (=3D=3D iommu group) is passed through and the=
re
> are no emulated devices, the difference isn't too bad: basically on
> pseries you'll see the subtree that would be below the root complex on
> q35.
>=C2=A0
> But if you pass through multiple groups, things get weird.

Is the difference between q35 and pseries guests with
respect to PCIe only relevant when it comes to assigned
devices, or in general? I'm asking this because you seem to
focus entirely on assigned devices.

> On q35,
> you'd generally expect physically separate (different slot) devices to
> appear under separate root complexes.

This part I don't get at all, so please bear with me.

The way I read it you're claiming that eg. a SCSI controller
and a network adapter, being physically separate and assigned
to separate PCI slots, should have a dedicated PCIe Root
Complex each on a q35 guest.

That doesn't match with my experience, where you would simply
assign them to separate slots of the default PCIe Root Bus
(pcie.0), eg. 00:01.0 and 00:02.0.

Maybe you're referring to the fact that you might want to
create multiple PCIe Root Complexes in order to assign the
host devices to separate guest NUMA nodes? How is creating
multiple PCIe Root Complexes on q35 using pxb-pcie different
than creating multiple PHBs using spapr-pci-host-bridge on
pseries?

> Whereas on pseries they'll
> appear as siblings on a virtual bus (which makes no physical sense for
> point-to-point PCI-E).

What is the virtual bus in question? Why would it matter
that they're siblings?

I'm possibly missing the point entirely, but so far it
looks to me like there are different configurations you
might want to use depending on your goal, and both q35
and pseries give you comparable tools to achieve such
configurations.

> I suppose we could try treating all devices on pseries as though they
> were chipset builtin devices on q35, which will appear on the root
> PCI-E bus without root complex.=C2=A0=C2=A0But I suspect that's likely =
to cause
> trouble with hotplug, and it will certainly need different address
> allocation from libvirt.

PCIe Integrated Endpoint Devices are not hotpluggable on
q35, that's why libvirt will follow QEMU's PCIe topology
recommendations and place a PCIe Root Port between them;
I assume the same could be done for pseries guests as
soon as QEMU grows support for generic PCIe Root Ports,
something Marcel has already posted patches for.

Again, sorry for clearly misunderstanding your explanation,
but I'm still not seeing the issue here. I'm sure it's very
clear in your mind, but I'm afraid you're going to have to
walk me through it :(

> > Regardless of how we decide to move forward with the
> > PCIe-enabled pseries machine type, libvirt will have to
> > know about this so it can behave appropriately.
>=C2=A0
> So there are kind of two extremes of how to address this.=C2=A0=C2=A0Th=
ere are a
> variety of options in between, but I suspect they're going to be even
> more muddled and hideous than the extremes.
>=C2=A0
> 1) Give up.=C2=A0=C2=A0You said there's already a flag that says a PCI-=
E bus is
> able to accept vanilla-PCI devices.=C2=A0=C2=A0We add a hack flag that =
says a
> vanilla-PCI bus is able to accept PCI-E devices.=C2=A0=C2=A0We keep add=
ress
> allocation as it is now - the pseries topology really does resemble
> vanilla-PCI much better than it does PCI-E. But, we allow PCI-E
> devices, and PAPR has mechanisms for accessing the extended config
> space.=C2=A0=C2=A0PCI-E standard hotplug and error reporting will never=
 work,
> but PAPR provides its own mechanisms for those, so that should be ok.

We can definitely special-case pseries guests and take
the "anything goes" approach to PCI vs PCIe, but it would
certainly be nicer if we could avoid presenting our users
the head-scratching situation of PCIe devices being plugged
into legacy PCI slots and still showing up as PCIe in the
guest.

What about virtio devices, which present themselves either
as legacy PCI or PCIe depending on the kind of slot they
are plugged into? Would they show up as PCIe or legacy PCI
on a PCIe-enabled pseries guest?

> 2) Start exposing the PCI-E heirarchy for pseries guests much more
> like q35, root complexes and all.=C2=A0=C2=A0It's not clear that PAPR a=
ctually
> *forbids* exposing the root complex, it just doesn't require it and
> that's not what PowerVM does.=C2=A0=C2=A0But.. there are big questions =
about
> whether existing guests will cope with this or not.=C2=A0=C2=A0When you=
 start
> adding in multiple passed through devices and particularly virtual
> functions as well, things could get very ugly - we might need to
> construct multiple emulated virtual root complexes or other messes.
>=C2=A0
> In the short to medium term, I'm thinking option (1) seems pretty
> compelling.

Is the Root Complex not currently exposed? The Root Bus
certainly is, otherwise PCI devices won't work at all, I
assume. And I can clearly see a pci.0 bus in the output
of 'info qtree' for a pseries guest, and a pci.1 too if
I add a spapr-pci-host-bridge.

Maybe I just don't quite get the relationship between Root
Complexes and Root Buses, but I guess my question is: what
is preventing us from simply doing whatever a
spapr-pci-host-bridge is doing in order to expose a legacy
PCI Root Bus (pci.*) to the guest, and create a new
spapr-pcie-host-bridge that exposes a PCIe Root Bus (pcie.*)
instead?

> So, I'm not sure if the idea of a new machine type has legs or not,
> but let's think it through a bit further.=C2=A0=C2=A0Suppose we have a =
new
> machine type, let's call it 'papr'.=C2=A0=C2=A0I'm thinking it would be=
 (at
> least with -nodefaults) basically a super-minimal version of pseries:
> so each PHB would have to be explicitly created, the VIO bridge would
> have to be explicitly created, likewise the NVRAM.=C2=A0=C2=A0Not sure =
about the
> "devices" which really represent firmware features - the RTC, RNG,
> hypervisor event source and so forth.
>=C2=A0
> Might have some advantages.=C2=A0=C2=A0Then again, it doesn't really so=
lve the
> specific problem here.=C2=A0=C2=A0It means libvirt (or the user) has to
> explicitly choose a PCI or PCI-E PHB to put things on,

libvirt would probably add a

=C2=A0 <controller type=3D'pci' model=3D'pcie-root'/>

to the guest XML by default, resulting in a
spapr-pcie-host-bridge providing pcie.0 and the same
controller / address allocation logic as q35; the user
would be able to use

=C2=A0 <controller type=3D'pci' model=3D'pci-root'/>

instead to stick with legacy PCI. This would only matter
when using '-nodefaults' anyway, when that flag is not
present a PCIe (or legacy PCI) could be created by QEMU
to make it more convenient for people that are not using
libvirt.

Maybe we should have a different model, specific to
pseries guests, instead, so that all PHBs would look the
same in the guest XML, something like

=C2=A0 <controller type=3D'pci' model=3D'phb-pcie'/>

It would require shuffling libvirt's PCI address allocation
code around quite a bit, but it should be doable. And if it
makes life easier for our users, then it's worth it.

> but libvirt's
> PCI-E address allocation will still be wrong in all probability.
>=C2=A0
> Guh.

> As an aside, here's a RANT.
[...]

Laine already addressed your points extensively, but I'd
like to add a few thoughts of my own.

* PCI addresses for libvirt guests don't need to be stable
=C2=A0 only when performing migration, but also to guarantee
=C2=A0 that no change in guest ABI will happen as a consequence
=C2=A0 of eg. a simple power cycle.

* Even if libvirt left all PCI address assignment to QEMU,
=C2=A0 we would need a way for users to override QEMU's choices,
=C2=A0 because one size never fits all and users have all kinds
=C2=A0 of crazy, yet valid, requirements. So the first time we
=C2=A0 run QEMU, we would have to take the backend-specific
=C2=A0 format you suggest, parse it to extract the PCI addresses
=C2=A0 that have been assigned, and reflect them in the guest
=C2=A0 XML so that the user can change a bunch of them. Then I
=C2=A0 guess we could re-encode it in the backend-specific format
=C2=A0 and pass it to QEMU the next time we run it but, at that
=C2=A0 point, what's the difference with simply putting the PCI
=C2=A0 addresses on the command line directly?

* It's not just about the addresses, by the way, but also
=C2=A0 about the controllers - what model is used, how they are
=C2=A0 plugged together and so on. More stuff that would have to
=C2=A0 round-trip because users need to be able to take matters
=C2=A0 into their own hands.

* Design mistakes in any software, combined with strict
=C2=A0 backwards compatibility requirements, make it difficult
=C2=A0 to make changes in both related components and the
=C2=A0 software itself, even when the changes would be very
=C2=A0 beneficial. It can be very frustrating at times, but
=C2=A0 it's the reality of things and unfortunately there's only
=C2=A0 so much we can do about it.

* Eduardo's work, which you mentioned, is going to be very
=C2=A0 beneficial in the long run; in the short run, Marcel's
=C2=A0 PCIe device placement guidelines, a document that has seen
=C2=A0 contributions from QEMU, OVMF and libvirt developers, have
=C2=A0 been invaluable to improve libvirt's PCI address allocation
=C2=A0 logic. So we're already doing better, and more improvements
=C2=A0 are on the way :)

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
