Received: from eggs.gnu.org ([2001:4830:134:3::10]:56050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cETbZ-00032e-1x
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 23:13:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cETbV-0000WI-Qg
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 23:13:17 -0500
Date: Wed, 7 Dec 2016 15:11:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161207041121.GB12489@umbus.fritz.box>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
In-Reply-To: <1481045447.6553.36.camel@redhat.com>
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
To: Andrea Bolognani <abologna@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, libvir-list@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>, benh@kernel.crashing.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2016 at 06:30:47PM +0100, Andrea Bolognani wrote:
> On Fri, 2016-12-02 at 15:18 +1100, David Gibson wrote:
> > > So, would the PCIe Root Bus in a pseries guest behave
> > > differently than the one in a q35 or mach-virt guest?
> >=A0
> > Yes.=A0=A0I had a long discussion with BenH and got a somewhat better i=
dea
> > about this.
>=20
> Sorry, but I'm afraid you're going to have to break this
> down even further for me :(
>=20
> > If only a single host PE (=3D=3D iommu group) is passed through and the=
re
> > are no emulated devices, the difference isn't too bad: basically on
> > pseries you'll see the subtree that would be below the root complex on
> > q35.
> >=A0
> > But if you pass through multiple groups, things get weird.
>=20
> Is the difference between q35 and pseries guests with
> respect to PCIe only relevant when it comes to assigned
> devices, or in general? I'm asking this because you seem to
> focus entirely on assigned devices.

Well, in a sense that's up to us.  The only existing model we have is
PowerVM, and PowerVM only does device passthrough, no emulated
devices.  PAPR doesn't really distinguish one way or the other, but
it's written from the perspective of assuming that all PCI devices
correspond to physical devices on the host

> > On q35,
> > you'd generally expect physically separate (different slot) devices to
> > appear under separate root complexes.
>=20
> This part I don't get at all, so please bear with me.
>=20
> The way I read it you're claiming that eg. a SCSI controller
> and a network adapter, being physically separate and assigned
> to separate PCI slots, should have a dedicated PCIe Root
> Complex each on a q35 guest.

Right, my understanding was that if the devices were slotted, rather
than integrated, each one would sit under a separate root complex, the
root complex being a pseudo PCI to PCI bridge.

> That doesn't match with my experience, where you would simply
> assign them to separate slots of the default PCIe Root Bus
> (pcie.0), eg. 00:01.0 and 00:02.0.

The qemu default, or the libvirt default?  I think this represents
treating the devices as though they were integrated devices in the
host bridge.  I believe on q35 they would not be hotpluggable - but on
pseries they would be (because we don't use the standard hot plug
controller).

> Maybe you're referring to the fact that you might want to
> create multiple PCIe Root Complexes in order to assign the
> host devices to separate guest NUMA nodes? How is creating
> multiple PCIe Root Complexes on q35 using pxb-pcie different
> than creating multiple PHBs using spapr-pci-host-bridge on
> pseries?

Uh.. AIUI the root complex is the PCI to PCI bridge under which PCI-E
slots appear.  PXB is something different - essentially different host
bridges as you say (though with some weird hacks to access config
space, which make it dependent on the primary bus in a way which spapr
PHBs are not).

I'll admit I'm pretty confused myself about the exact distinction
between root complex, root port and upstream and downstream ports.

> > Whereas on pseries they'll
> > appear as siblings on a virtual bus (which makes no physical sense for
> > point-to-point PCI-E).
>=20
> What is the virtual bus in question? Why would it matter
> that they're siblings?

On pseries it won't.  But my understanding is that libvirt won't
create them that way on q35 - instead it will insert the RCs / P2P
bridges to allow them to be hotplugged.  Inserting that bridge may
confuse pseries guests which aren't expecting it.

> I'm possibly missing the point entirely, but so far it
> looks to me like there are different configurations you
> might want to use depending on your goal, and both q35
> and pseries give you comparable tools to achieve such
> configurations.
>=20
> > I suppose we could try treating all devices on pseries as though they
> > were chipset builtin devices on q35, which will appear on the root
> > PCI-E bus without root complex.=A0=A0But I suspect that's likely to cau=
se
> > trouble with hotplug, and it will certainly need different address
> > allocation from libvirt.
>=20
> PCIe Integrated Endpoint Devices are not hotpluggable on
> q35, that's why libvirt will follow QEMU's PCIe topology
> recommendations and place a PCIe Root Port between them;
> I assume the same could be done for pseries guests as
> soon as QEMU grows support for generic PCIe Root Ports,
> something Marcel has already posted patches for.

Here you've hit on it.  No, we should not do that for pseries,
AFAICT.  PAPR doesn't really have the concept of integrated endpoint
devices, and all devices can be hotplugged via the PAPR mechanisms
(and none can via the PCI-E standard hotplug mechanism).

> Again, sorry for clearly misunderstanding your explanation,
> but I'm still not seeing the issue here. I'm sure it's very
> clear in your mind, but I'm afraid you're going to have to
> walk me through it :(

I wish it were entirely clear in my mind.  Like I say I'm still pretty
confused by exactly the root complex entails.

> > > Regardless of how we decide to move forward with the
> > > PCIe-enabled pseries machine type, libvirt will have to
> > > know about this so it can behave appropriately.
> >=A0
> > So there are kind of two extremes of how to address this.=A0=A0There ar=
e a
> > variety of options in between, but I suspect they're going to be even
> > more muddled and hideous than the extremes.
> >=A0
> > 1) Give up.=A0=A0You said there's already a flag that says a PCI-E bus =
is
> > able to accept vanilla-PCI devices.=A0=A0We add a hack flag that says a
> > vanilla-PCI bus is able to accept PCI-E devices.=A0=A0We keep address
> > allocation as it is now - the pseries topology really does resemble
> > vanilla-PCI much better than it does PCI-E. But, we allow PCI-E
> > devices, and PAPR has mechanisms for accessing the extended config
> > space.=A0=A0PCI-E standard hotplug and error reporting will never work,
> > but PAPR provides its own mechanisms for those, so that should be ok.
>=20
> We can definitely special-case pseries guests and take
> the "anything goes" approach to PCI vs PCIe, but it would
> certainly be nicer if we could avoid presenting our users
> the head-scratching situation of PCIe devices being plugged
> into legacy PCI slots and still showing up as PCIe in the
> guest.
>=20
> What about virtio devices, which present themselves either
> as legacy PCI or PCIe depending on the kind of slot they
> are plugged into? Would they show up as PCIe or legacy PCI
> on a PCIe-enabled pseries guest?

That we'd have to address on the qemu side with some=20

> > 2) Start exposing the PCI-E heirarchy for pseries guests much more
> > like q35, root complexes and all.=A0=A0It's not clear that PAPR actually
> > *forbids* exposing the root complex, it just doesn't require it and
> > that's not what PowerVM does.=A0=A0But.. there are big questions about
> > whether existing guests will cope with this or not.=A0=A0When you start
> > adding in multiple passed through devices and particularly virtual
> > functions as well, things could get very ugly - we might need to
> > construct multiple emulated virtual root complexes or other messes.
> >=A0
> > In the short to medium term, I'm thinking option (1) seems pretty
> > compelling.
>=20
> Is the Root Complex not currently exposed? The Root Bus
> certainly is,

Like I say, I'm fairly confused myself, but I'm pretty sure that Root
Complex !=3D Root Bus.  The RC sits under the root bus IIRC.. or
possibly it consists of the root bus plus something under it as well.

Now... from what Laine was saying it sounds like more of the
differences between PCI-E placement and PCI placement may be
implemented by libvirt than qemu than I realized.  So possibly we do
want to make the bus be PCI-E on the qemu side, but have libvirt use
the vanilla-PCI placement guidelines rather than PCI-E for pseries.

> otherwise PCI devices won't work at all, I
> assume. And I can clearly see a pci.0 bus in the output
> of 'info qtree' for a pseries guest, and a pci.1 too if
> I add a spapr-pci-host-bridge.
>=20
> Maybe I just don't quite get the relationship between Root
> Complexes and Root Buses, but I guess my question is: what
> is preventing us from simply doing whatever a
> spapr-pci-host-bridge is doing in order to expose a legacy
> PCI Root Bus (pci.*) to the guest, and create a new
> spapr-pcie-host-bridge that exposes a PCIe Root Bus (pcie.*)
> instead?

Hrm, the suggestion of providing both a vanilla-PCI and PCI-E host
bridge came up before.  I think one of us spotted a problem with that,
but I don't recall what it was now.  I guess one is how libvirt would
map it's stupid-fake-domain-numbers to which root bus to use.

> > So, I'm not sure if the idea of a new machine type has legs or not,
> > but let's think it through a bit further.=A0=A0Suppose we have a new
> > machine type, let's call it 'papr'.=A0=A0I'm thinking it would be (at
> > least with -nodefaults) basically a super-minimal version of pseries:
> > so each PHB would have to be explicitly created, the VIO bridge would
> > have to be explicitly created, likewise the NVRAM.=A0=A0Not sure about =
the
> > "devices" which really represent firmware features - the RTC, RNG,
> > hypervisor event source and so forth.
> >=A0
> > Might have some advantages.=A0=A0Then again, it doesn't really solve the
> > specific problem here.=A0=A0It means libvirt (or the user) has to
> > explicitly choose a PCI or PCI-E PHB to put things on,
>=20
> libvirt would probably add a
>=20
> =A0 <controller type=3D'pci' model=3D'pcie-root'/>
>=20
> to the guest XML by default, resulting in a
> spapr-pcie-host-bridge providing pcie.0 and the same
> controller / address allocation logic as q35; the user
> would be able to use
>=20
> =A0 <controller type=3D'pci' model=3D'pci-root'/>
>=20
> instead to stick with legacy PCI. This would only matter
> when using '-nodefaults' anyway, when that flag is not
> present a PCIe (or legacy PCI) could be created by QEMU
> to make it more convenient for people that are not using
> libvirt.
>=20
> Maybe we should have a different model, specific to
> pseries guests, instead, so that all PHBs would look the
> same in the guest XML, something like
>=20
> =A0 <controller type=3D'pci' model=3D'phb-pcie'/>
>=20
> It would require shuffling libvirt's PCI address allocation
> code around quite a bit, but it should be doable. And if it
> makes life easier for our users, then it's worth it.

Hrm.  So my first inclination would be to stick with the generic
names, and map those to creating new pseries host bridges on pseries
guests.  I would have thought that would be the easier option for
users.  But I may not have realized all the implications yet.

> > but libvirt's
> > PCI-E address allocation will still be wrong in all probability.
> >=A0
> > Guh.
>=20
> > As an aside, here's a RANT.
> [...]
>=20
> Laine already addressed your points extensively, but I'd
> like to add a few thoughts of my own.
>=20
> * PCI addresses for libvirt guests don't need to be stable
> =A0 only when performing migration, but also to guarantee
> =A0 that no change in guest ABI will happen as a consequence
> =A0 of eg. a simple power cycle.
>=20
> * Even if libvirt left all PCI address assignment to QEMU,
> =A0 we would need a way for users to override QEMU's choices,
> =A0 because one size never fits all and users have all kinds
> =A0 of crazy, yet valid, requirements. So the first time we
> =A0 run QEMU, we would have to take the backend-specific
> =A0 format you suggest, parse it to extract the PCI addresses
> =A0 that have been assigned, and reflect them in the guest
> =A0 XML so that the user can change a bunch of them. Then I
> =A0 guess we could re-encode it in the backend-specific format
> =A0 and pass it to QEMU the next time we run it but, at that
> =A0 point, what's the difference with simply putting the PCI
> =A0 addresses on the command line directly?
>=20
> * It's not just about the addresses, by the way, but also
> =A0 about the controllers - what model is used, how they are
> =A0 plugged together and so on. More stuff that would have to
> =A0 round-trip because users need to be able to take matters
> =A0 into their own hands.
>=20
> * Design mistakes in any software, combined with strict
> =A0 backwards compatibility requirements, make it difficult
> =A0 to make changes in both related components and the
> =A0 software itself, even when the changes would be very
> =A0 beneficial. It can be very frustrating at times, but
> =A0 it's the reality of things and unfortunately there's only
> =A0 so much we can do about it.

I think the above I've touched on in my reply to Laine.

> * Eduardo's work, which you mentioned, is going to be very
> =A0 beneficial in the long run; in the short run, Marcel's
> =A0 PCIe device placement guidelines, a document that has seen
> =A0 contributions from QEMU, OVMF and libvirt developers, have
> =A0 been invaluable to improve libvirt's PCI address allocation
> =A0 logic. So we're already doing better, and more improvements
> =A0 are on the way :)

Right.. so here's the thing, I strongly suspect that Marcel's
guidelines will not be correct for pseries.  I'm not sure if they'll
be definitively wrong, or just different enough from PowerVM that it
might confuse guests, but either way.  Can you send me a link to that
document though, which might help me figure this out.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYR4vmAAoJEGw4ysog2bOSJ+EQAJuy/V4UE6hiTSG2NE35gpQw
TiL5H0xiLcm5zg+XH+KoyPW/cJ51dtENumZf3976efqO2CYd7haumFqI2kF9uJ2U
ypp68O43bkCmpKq0Rd3+GYiyc40bFVcpkmi6BAqX86rEsmcwsSOISlwtRxhX69ku
9oUbOM5ycqQ3JiITMPHdXNC5r8DhtjhWOW3C6jNcLKkTvaN4YBOykOZa6TQQvC+0
kArU8KtUHzHSSVGQNdzoThmPK2QrS1bRD0DR19V8xTuj2UHptto26MPsP6KOoek6
OpsogF9oo8WZJLm3hdBaVgsU7MWAFcloe6jG5zlRRbskZ2P2CBxFHo1Ws5KjgOC3
ojfTKM4kXyINtysJ498rhIbQemxA9HwAuUekqLUwGrpnXpDS8jzi6Hj0gxGgiTj8
cjf9hob4oJDtSmuu7MHse/dUX/QSTERtUwAuKDiZ8UvsdcP6MLRCbsobMw/5Arbx
tKjq5Qkxa14VrB3FENsTl20uF/XCDnkb46JNNpSboXUYnkYoHDxmStX+ydEnZ+RY
JVfYyPX5g0oujiZEnLCL3ysxTl+0EoE9sPC0PcIAo1Qg+pNI1ngYMSbueaQNksU9
nft1IHlJ1tSZCB26ofQKjlwrHPaXTMvkU/M1hRm0z8+G/rr+QU2dp2KNyiSH+dmm
Jz6nUP6+8qQJQzUK1qou
=yXg3
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
