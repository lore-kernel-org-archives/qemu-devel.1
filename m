Received: from eggs.gnu.org ([2001:4830:134:3::10]:55583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cGzdL-0004FQ-T2
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 21:49:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cGzdJ-00047j-Hm
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 21:49:31 -0500
Date: Wed, 14 Dec 2016 13:46:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161214024616.GE32647@umbus>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ryJZkp9/svQ58syV"
Content-Disposition: inline
In-Reply-To: <491c0ca6-c559-441b-7a14-3656bfc0abfc@redhat.com>
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
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Andrea Bolognani <abologna@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, libvir-list@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>, benh@kernel.crashing.org, Marcel Apfelbaum <mapfelba@redhat.com>


--ryJZkp9/svQ58syV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2016 at 02:25:44PM +0200, Marcel Apfelbaum wrote:
> On 12/07/2016 06:42 PM, Andrea Bolognani wrote:
> > [Added Marcel to CC]
> >=20
>=20
>=20
> Hi,
>=20
> Sorry for the late reply.
>=20
> > On Wed, 2016-12-07 at 15:11 +1100, David Gibson wrote:
> > > > Is the difference between q35 and pseries guests with
> > > > respect to PCIe only relevant when it comes to assigned
> > > > devices, or in general? I'm asking this because you seem to
> > > > focus entirely on assigned devices.
> > >=20
> > > Well, in a sense that's up to us.  The only existing model we have is
> > > PowerVM, and PowerVM only does device passthrough, no emulated
> > > devices.  PAPR doesn't really distinguish one way or the other, but
> > > it's written from the perspective of assuming that all PCI devices
> > > correspond to physical devices on the host
> >=20
> > Okay, that makes sense.
> >=20
> > > > > On q35,
> > > > > you'd generally expect physically separate (different slot) devic=
es to
> > > > > appear under separate root complexes.
> > > >=20
> > > > This part I don't get at all, so please bear with me.
> > > >=20
> > > > The way I read it you're claiming that eg. a SCSI controller
> > > > and a network adapter, being physically separate and assigned
> > > > to separate PCI slots, should have a dedicated PCIe Root
> > > > Complex each on a q35 guest.
> > >=20
>=20
> Not a PCIe Root Complex, but a PCIe Root port.

Ah, sorry.  As I said, I've been pretty confused by all the terminology.

> > > Right, my understanding was that if the devices were slotted, rather
> > > than integrated, each one would sit under a separate root complex, the
> > > root complex being a pseudo PCI to PCI bridge.
> >=20
> > I assume "slotted" means "plugged into a slot that's not one
> > of those provided by pcie.0" or something along those lines.
> >=20
> > More on the root complex bit later.
> >=20
> > > > That doesn't match with my experience, where you would simply
> > > > assign them to separate slots of the default PCIe Root Bus
> > > > (pcie.0), eg. 00:01.0 and 00:02.0.
> > >=20
> > > The qemu default, or the libvirt default?
> >=20
> > I'm talking about the libvirt default, which is supposed to
> > follows Marcel's PCIe Guidelines.
> >=20
> > > I think this represents
> > > treating the devices as though they were integrated devices in the
> > > host bridge.  I believe on q35 they would not be hotpluggable
> >=20
>=20
> Correct. Please have a look to the new document
> regarding pcie: docs/pcie.txt and the corresponding presentations.
>=20
>=20
> > Yeah, that's indeed not quite what libvirt would do by
> > default: in reality, there would be a ioh3420 between the
> > pcie.0 slots and each device exactly to enable hotplug.
> >=20
> > > but on
> > > pseries they would be (because we don't use the standard hot plug
> > > controller).
> >=20
> > We can account for that in libvirt and avoid adding the
> > extra ioh3420s (or rather the upcoming generic PCIe Root
> > Ports) for pseries guests.
> >=20
> > > > Maybe you're referring to the fact that you might want to
> > > > create multiple PCIe Root Complexes in order to assign the
> > > > host devices to separate guest NUMA nodes? How is creating
> > > > multiple PCIe Root Complexes on q35 using pxb-pcie different
> > > > than creating multiple PHBs using spapr-pci-host-bridge on
> > > > pseries?
> > >=20
> > > Uh.. AIUI the root complex is the PCI to PCI bridge under which PCI-E
> > > slots appear.  PXB is something different - essentially different host
> > > bridges as you say (though with some weird hacks to access config
> > > space, which make it dependent on the primary bus in a way which spapr
> > > PHBs are not).
> > >=20
> > > I'll admit I'm pretty confused myself about the exact distinction
> > > between root complex, root port and upstream and downstream ports.
> >=20
> > I think we both need to get our terminology straight :)
> > I'm sure Marcel will be happy to point us in the right
> > direction.
> >=20
> > My understanding is that the PCIe Root Complex is the piece
> > of hardware that exposes a PCIe Root Bus (pcie.0 in QEMU);
>=20
> right

Oh.. I wasn't as clear as I'd like to be on what the root complex is.
But I thought the root complex did have some guest visible presence in
the PCI tree.  What you're describing here seems equivalent to what
I'd call the PCI Host Bridge (=3D=3D PHB).

> > PXBs can be connected to slots in pcie.0 to create more buses
> > that behave, for the most part, like pcie.0 and are mostly
> > useful to bind devices to specific NUMA nodes.
>=20
> right
>=20
>  Same applies
> > to legacy PCI with the pxb (instead of pxb-pcie) device.
> >=20
>=20
> pxb should not be used for PCIe machines, only for legacy PCI ones.

Noted.  And not for pseries at all.  Note that because we have a
para-virtualized platform (all PCI config access goes via hypercalls)
the distinction between PCI and PCI-E is much blurrier than in the x86
case.

> > In a similar fashion, PHBs are the hardware thingies that
> > expose a PCI Root Bus (pci.0 and so on), the main difference
> > being that they are truly independent: so a q35 guest will
> > always have a "primary" PCIe Root Bus and (optionally) a
> > bunch of "secondary" ones, but the same will not be the case
> > for pseries guests.
>=20
> OK
>=20
> > I don't think the difference is that important though, at
> > least from libvirt's point of view: whether you're creating
> > a pseries guest with two PHBs, or a q35 guest with its
> > built-in PCIe Root Complex and an extra PCIe Expander Bus,
> > you will end up with two "top level" buses that you can plug
> > more devices into.
>=20
> I agree
>=20
>  If we had spapr-pcie-host-bridge, we
> > could treat them mostly the same - with caveats such as the
> > one described above, of course.
> >=20
> > > > > Whereas on pseries they'll
> > > > > appear as siblings on a virtual bus (which makes no physical sens=
e for
> > > > > point-to-point PCI-E).
> > > >=20
> > > > What is the virtual bus in question? Why would it matter
> > > > that they're siblings?
> > >=20
> > > On pseries it won't.  But my understanding is that libvirt won't
> > > create them that way on q35 - instead it will insert the RCs / P2P
> > > bridges to allow them to be hotplugged.  Inserting that bridge may
> > > confuse pseries guests which aren't expecting it.
> >=20
> > libvirt will automatically add PCIe Root Ports to make the
> > devices hotpluggable on q35 guests, yes. But, as mentioned
> > above, we can teach it not to.
> >=20
> > > > I'm possibly missing the point entirely, but so far it
> > > > looks to me like there are different configurations you
> > > > might want to use depending on your goal, and both q35
> > > > and pseries give you comparable tools to achieve such
> > > > configurations.
> > > > >=20
> > > > > I suppose we could try treating all devices on pseries as though =
they
> > > > > were chipset builtin devices on q35, which will appear on the root
> > > > > PCI-E bus without root complex.
>=20
> Actually the root PCIe bus is part of a root complex.

So I think what I meant above was "root port".  The point is that
there won't be the (pseudo) PCI to PCI bridge appearing above the
device that there typically would be on q35.

>  But I suspect that's likely to cause
> > > > > trouble with hotplug, and it will certainly need different address
> > > > > allocation from libvirt.
> > > >=20
> > > > PCIe Integrated Endpoint Devices are not hotpluggable on
> > > > q35, that's why libvirt will follow QEMU's PCIe topology
> > > > recommendations and place a PCIe Root Port between them;
> > > > I assume the same could be done for pseries guests as
> > > > soon as QEMU grows support for generic PCIe Root Ports,
> > > > something Marcel has already posted patches for.
> > >=20
> > > Here you've hit on it.  No, we should not do that for pseries,
> > > AFAICT.  PAPR doesn't really have the concept of integrated endpoint
> > > devices, and all devices can be hotplugged via the PAPR mechanisms
> > > (and none can via the PCI-E standard hotplug mechanism).
> >=20
>=20
> This seems to be interfering with the PCIe spec:
>   1. No PCIe root ports ? those are part of the spec.

Yes, I dare say it does interfere with the spec.  Nonetheless, there
it is.

>   2. Only integrated devices ? hotplug is not PCIe native?

That's correct.  PAPR supplies its own hotplug mechanism, which works
for both PCI and PCI-E devices, which is different from the standard
PCI-E hotplug mechanism.

>=20
> > Cool, I get it now.
> >=20
> > > > Again, sorry for clearly misunderstanding your explanation,
> > > > but I'm still not seeing the issue here. I'm sure it's very
> > > > clear in your mind, but I'm afraid you're going to have to
> > > > walk me through it :(
> > >=20
> > > I wish it were entirely clear in my mind.  Like I say I'm still pretty
> > > confused by exactly the root complex entails.
> >=20
> > Same here, but this back-and-forth is helping! :)
> >=20
> > [...]
> > > > What about virtio devices, which present themselves either
> > > > as legacy PCI or PCIe depending on the kind of slot they
> > > > are plugged into? Would they show up as PCIe or legacy PCI
> > > > on a PCIe-enabled pseries guest?
> > >=20
> > > That we'd have to address on the qemu side with some
> >=20
> > Unfinished sentence?
> >=20
> > [...]
> > > > Is the Root Complex not currently exposed? The Root Bus
> > > > certainly is,
> > >=20
> > > Like I say, I'm fairly confused myself, but I'm pretty sure that Root
> > > Complex !=3D Root Bus.  The RC sits under the root bus IIRC.. or
> > > possibly it consists of the root bus plus something under it as well.
> > >=20
>=20
> The Root complex includes the PCI bus, some configuration registers if
> needed, provides access to the configuration space, translates relevant C=
PU
> reads/writes to PCI(e) transactions...

Do those configuration registers appear within PCI space, or outside
it (e.g. raw MMIO or PIO registers)?

> > > Now... from what Laine was saying it sounds like more of the
> > > differences between PCI-E placement and PCI placement may be
> > > implemented by libvirt than qemu than I realized.  So possibly we do
> > > want to make the bus be PCI-E on the qemu side, but have libvirt use
> > > the vanilla-PCI placement guidelines rather than PCI-E for pseries.
> >=20
> > Basically the special casing I was mentioning earlier.
>=20
> That looks complicated.. I wish I would no more about the pseries
> PCIe stuff, does any one know where I can get the info ? (besides 'google=
 it'...)

Andrea gave a pointer to the PAPR document.  Unfortunately how much it
covers here I'm not sure about.  In particular I'm not sure how much
of this is actually PAPR mandated, and how much is just copying
PowerVM as the pre-existing PAPR implementation.

>=20
> >=20
> > [...]
> > > > Maybe I just don't quite get the relationship between Root
> > > > Complexes and Root Buses, but I guess my question is: what
> > > > is preventing us from simply doing whatever a
> > > > spapr-pci-host-bridge is doing in order to expose a legacy
> > > > PCI Root Bus (pci.*) to the guest, and create a new
> > > > spapr-pcie-host-bridge that exposes a PCIe Root Bus (pcie.*)
> > > > instead?
> > >=20
> > > Hrm, the suggestion of providing both a vanilla-PCI and PCI-E host
> > > bridge came up before.  I think one of us spotted a problem with that,
> > > but I don't recall what it was now.  I guess one is how libvirt would
> > > map it's stupid-fake-domain-numbers to which root bus to use.
>=20
> This would be a weird configuration, I never heard of something like that
> on a bare metal machine, but I never worked on pseries, who knows...

Which aspect?  Having multiple independent host bridges is perfectly
reasonable - x86 just doesn't do it well for rather stupid historical
reasons.

PAPR is quite explicitly a paravirtual platform, you cannot have a
bare-metal PAPR machine.

> > That issue is relevant whether or nor we have different PHB
> > flavors, isn't it? As soon as multiple PHBs are present in
> > a pseries guest, multiple PCI domains will be there as well,
> > and we need to handle that somehow.
> >=20
> > On q35, on the other hand, I haven't been able to find a way
> > to create extra PCI domains: adding a pxb-pcie certainly
> > didn't work the same as adding an extra spapr-pci-host-bridge
> > in that regard.
> >=20
>=20
> Indeed, all the pxb-pcie devices "share" the same domain.
>=20
> > [...]
> > > > Maybe we should have a different model, specific to
> > > > pseries guests, instead, so that all PHBs would look the
> > > > same in the guest XML, something like
> > > >=20
> > > >    <controller type=3D'pci' model=3D'phb-pcie'/>
> > > >=20
> > > > It would require shuffling libvirt's PCI address allocation
> > > > code around quite a bit, but it should be doable. And if it
> > > > makes life easier for our users, then it's worth it.
> > >=20
> > > Hrm.  So my first inclination would be to stick with the generic
> > > names, and map those to creating new pseries host bridges on pseries
> > > guests.  I would have thought that would be the easier option for
> > > users.  But I may not have realized all the implications yet.
> >=20
> > You're probably right, but I can't immediately see how we
> > would make the user aware of which PHB is which. Maybe we
> > could add some sub-element or extra attribute...
> >=20
> > Anyway, we should not focus too much on this specific bit
> > at the moment, deciding on a specific XML is mostly
> > bikeshedding :)
> >=20
> > [...]
> > > > * Eduardo's work, which you mentioned, is going to be very
> > > >    beneficial in the long run; in the short run, Marcel's
> > > >    PCIe device placement guidelines, a document that has seen
> > > >    contributions from QEMU, OVMF and libvirt developers, have
> > > >    been invaluable to improve libvirt's PCI address allocation
> > > >    logic. So we're already doing better, and more improvements
> > > >    are on the way :)
> > >=20
> > > Right.. so here's the thing, I strongly suspect that Marcel's
> > > guidelines will not be correct for pseries.
>=20
> We should make the document stick for all PCIe archs, if we need
> to modify it, let's do it.

Yeah, I'm not sure it's possible to cover both x86 and pseries at
once.  As you noted, it looks rather like PAPR is contradicting the
PCI-E spec.

Again, one possible option here is to continue to treat pseries as
having a vanilla-PCI bus, but with a special flag saying that it's
magically able to connect PCI-E devices.

>   I'm not sure if they'll
> > > be definitively wrong, or just different enough from PowerVM that it
> > > might confuse guests, but either way.
> >=20
>=20
> I really need to understand how it would confuse the guests,
> it does not deviate from the PCIe spec, it only adds some restrictions.

Because the guests are written to work with PowerVM, which seems to do
something other than the PCIe spec...

> > Those guidelines have been developed with q35/mach-virt in
> > mind[1], so I wouldn't at all be surprised if they didn't
> > apply to pseries guests. And in fact, we just found out
> > that they don't!
> >=20
> > My point is that we could easily create a similar document
> > for pseries guests, and then libvirt will be able to pick
> > up whatever recommendations we come up with just like it
> > did for q35/mach-virt.
> >=20
> > > Can you send me a link to that
> > > document though, which might help me figure this out.
> >=20
> > It's docs/pcie.txt in QEMU's git repository.
> >=20
> >=20
> > [1] Even though I now realize that this is not immediately
> >     clear by looking at the document itself
>=20
>=20
> I kind of miss the core issue, what is the main problem?

The core problem is that at this stage it's not possible to attach
PCIe devices (either emulated or passthrough) to a pseries guest.  We
need to be able to do that - specifically allowing the guest to access
PCIe extended config space.

The PAPR virtualized PCI interfaces definitely do allow a guest to
access extended config space, but in most other regards they behave
more like vanilla-PCI than PCIe.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ryJZkp9/svQ58syV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYULJ2AAoJEGw4ysog2bOSaL8QAOegrjs6vuDjz3Mojnw5552I
/FurQ8cnCwyb6/t7n4lizzvwWCSXICoCzZmakDgMo3CHhalUDFRGI+aI3Lag9LKJ
ed42sv+rXn9jPLEQ9nKX0a1N0xYOXZ4sao1RGn2QBa2qE67/SxeBjYC4dsIaCLNv
UCMzWk9ELIsXEPuAdYE541+eDXHAK7wZqHK8QNNSf/AbvntXgLrLylzTs07vz0sj
pKYgKkmrNGo2ZvDKxoiT5qREHoT5hJd/sVpQwQKaMYKQ89rXKLIh7cCa3UPpjXZe
6P3CgmVMHHZt45uej3kcoNG4JcmcDFKR0MuOIQZtwRY7tcdDkGw56s6LHeYjg6eB
scs6k/LOtD8nEU1/RvXkbFGLC7VUiTflfFf7N6r2sMCxdm0YkD8FEeAmiV+drNj7
F1Jf1MfhVFJN1YqIYfOgfE8n8uLKmG1AGFr16Nw52xYKTwjJe+Mdw5qefOP8nDq9
ZRQws56MvcXJXGvcmGoj5OFWCTalSeZKv12ESVH4PKbiCHDCpZoI2DZWkucr2gXs
a9Ufy+r4qlhXflTkpZ35j48c/+lj+Mqtt8obTKb+MRZ/06tjVC2328rr/IBSkek7
86PaMA5mimYLfYIWP4XfENI4Q/lG+1GJcS7l2BAqamWXMn/BBLFZYJzyKMT+Dlju
gjqAX7p+5fcn6zktP6IG
=gJRl
-----END PGP SIGNATURE-----

--ryJZkp9/svQ58syV--
