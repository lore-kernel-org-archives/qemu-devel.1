Received: from eggs.gnu.org ([2001:4830:134:3::10]:49767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cET0I-0005oy-LY
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 22:34:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cET0E-0004ZQ-LB
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 22:34:46 -0500
Date: Wed, 7 Dec 2016 14:34:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161207033431.GA12489@umbus.fritz.box>
References: <20161031025314.GJ18226@umbus.fritz.box>
	<ee1d7da4-373c-4be0-7e67-897a1c90042f@ozlabs.ru>
	<20161101024634.GA14860@umbus.fritz.box>
	<1479218565.3319.18.camel@redhat.com>
	<3353ecef-2308-13e3-025d-df41b2e89945@ozlabs.ru>
	<1479457042.1391.11.camel@redhat.com>
	<20161123050049.GD17795@umbus.fritz.box>
	<1480081581.4367.65.camel@redhat.com>
	<20161202041835.GF10089@umbus.fritz.box>
	<718634d6-a1c8-95e5-646c-69e7153fc2d9@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <718634d6-a1c8-95e5-646c-69e7153fc2d9@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] [Qemu-ppc] [RFC PATCH qemu] spapr_pci:
 Create PCI-express root bus by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laine Stump <laine@redhat.com>
Cc: qemu-ppc@nongnu.org, Andrea Bolognani <abologna@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, benh@kernel.crashing.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 03:54:49PM -0500, Laine Stump wrote:
> (Sorry for any duplicates. I sent it from the wrong address the first tim=
e)
>=20
> On 12/01/2016 11:18 PM, David Gibson wrote:
> > On Fri, Nov 25, 2016 at 02:46:21PM +0100, Andrea Bolognani wrote:
> > > On Wed, 2016-11-23 at 16:00 +1100, David Gibson wrote:
> > > > > Existing libvirt versions assume that pseries guests have
> > > > > a legacy PCI root bus, and will base their PCI address
> > > > > allocation / PCI topology decisions on that fact: they
> > > > > will, for example, use legacy PCI bridges.
> > > >   Um.. yeah.. trouble is libvirt's PCI-E address allocation probably
> > > > won't work for spapr PCI-E either, because of the weird PCI-E witho=
ut
> > > > root complex presentation we get in PAPR.
> > > So, would the PCIe Root Bus in a pseries guest behave
> > > differently than the one in a q35 or mach-virt guest?
> > Yes.  I had a long discussion with BenH and got a somewhat better idea
> > about this.
> >=20
> > If only a single host PE (=3D=3D iommu group) is passed through and the=
re
> > are no emulated devices, the difference isn't too bad: basically on
> > pseries you'll see the subtree that would be below the root complex on
> > q35.
> >=20
> > But if you pass through multiple groups, things get weird.  On q35,
> > you'd generally expect physically separate (different slot) devices to
> > appear under separate root complexes.  Whereas on pseries they'll
> > appear as siblings on a virtual bus (which makes no physical sense for
> > point-to-point PCI-E).
> >=20
> > I suppose we could try treating all devices on pseries as though they
> > were chipset builtin devices on q35, which will appear on the root
> > PCI-E bus without root complex.  But I suspect that's likely to cause
> > trouble with hotplug, and it will certainly need different address
> > allocation from libvirt.
> >=20
> > > Does it have a different number of slots, do we have to
> > > plug different controllers into them, ...?
> > >=20
> > > Regardless of how we decide to move forward with the
> > > PCIe-enabled pseries machine type, libvirt will have to
> > > know about this so it can behave appropriately.
> > So there are kind of two extremes of how to address this.  There are a
> > variety of options in between, but I suspect they're going to be even
> > more muddled and hideous than the extremes.
> >=20
> > 1) Give up.  You said there's already a flag that says a PCI-E bus is
> > able to accept vanilla-PCI devices.  We add a hack flag that says a
> > vanilla-PCI bus is able to accept PCI-E devices.  We keep address
> > allocation as it is now - the pseries topology really does resemble
> > vanilla-PCI much better than it does PCI-E. But, we allow PCI-E
> > devices, and PAPR has mechanisms for accessing the extended config
> > space.  PCI-E standard hotplug and error reporting will never work,
> > but PAPR provides its own mechanisms for those, so that should be ok.
> >=20
> > 2) Start exposing the PCI-E heirarchy for pseries guests much more
> > like q35, root complexes and all.  It's not clear that PAPR actually
> > *forbids* exposing the root complex, it just doesn't require it and
> > that's not what PowerVM does.  But.. there are big questions about
> > whether existing guests will cope with this or not.  When you start
> > adding in multiple passed through devices and particularly virtual
> > functions as well, things could get very ugly - we might need to
> > construct multiple emulated virtual root complexes or other messes.
> >=20
> > In the short to medium term, I'm thinking option (1) seems pretty
> > compelling.
> >=20
> > > > > > I believe after we introduced the very first
> > > > > > pseries-pcie-X.Y, we will just stop adding new pseries-X.Y.
> > > > >   Isn't i440fx still being updated despite the fact that q35
> > > > > exists? Granted, there are a lot more differences between
> > > > > those two machine types than just the root bus type.
> > > >   Right, there are heaps of differences between i440fx and q35, and
> > > > reasons to keep both updated.  For pseries we have neither the impe=
tus
> > > > nor the resources to maintain two different machine type variant,
> > > > where the only difference is between legacy PCI and weirdly present=
ed
> > > > PCI-E.
> > > Calling the PCIe machine type either pseries-2.8 or
> > > pseries-pcie-2.8 would result in the very same amount of
> > > work, and in both cases it would be understood that the
> > > legacy PCI machine type is no longer going to be updated,
> > > but can still be used to run existing guests.
> > So, I'm not sure if the idea of a new machine type has legs or not,
> > but let's think it through a bit further.  Suppose we have a new
> > machine type, let's call it 'papr'.  I'm thinking it would be (at
> > least with -nodefaults) basically a super-minimal version of pseries:
> > so each PHB would have to be explicitly created, the VIO bridge would
> > have to be explicitly created, likewise the NVRAM.  Not sure about the
> > "devices" which really represent firmware features - the RTC, RNG,
> > hypervisor event source and so forth.
> >=20
> > Might have some advantages.  Then again, it doesn't really solve the
> > specific problem here.  It means libvirt (or the user) has to
> > explicitly choose a PCI or PCI-E PHB to put things on, but libvirt's
> > PCI-E address allocation will still be wrong in all probability.
>=20
> That's a broad statement. Why? If qemu reports the default devices and
> characteristics of the devices properly (and libvirt uses that informatio=
n)
> there's no reason for it to make the wrong decision.

Actually, unlike the comments below, this assertion is neither
particularly broad, nor critical of libvirt (it is obliquely critical
of PAPR and PowerVM).

The point is that the way PCI-E devices are presented under PAPR is
different from the way they'd appear on a hardware bus or on
virtualized PC or ARM.  Specifically we don't present the pseudo-P2P
bridges of the root complexes to the guest.  Instead (unless you
explicitly ask for a bridge) all the devices will appear directly on
the root "bus" - obviously this bus is a fiction since PCI-E is point
to point in hardware.

In short, from the point of view of topology, PAPR PCI-E will look
much more like vanilla PCI than PCI-E on an x86.  So to the extent
that libvirt address allocation differs between PCI and PCI-E, and I
gather it does, the PCI-E variant will be wrong for PAPR.

That's why for the medium term I advocate option (1) above of treating
PAPR PCI-E as if it was a vanilla PCI bus, but with a flag indicating
that PCI-E devices can be attached to it.

> > Guh.
> >=20
> >=20
> > As an aside, here's a RANT.
> >=20
> > libvirt address allocation.  Seriously, W. T. F!
> >=20
> > libvirt insists on owning address allocation.  That's so it can
> > recreate the exact same machine at the far end of a migration.  So far
> > so good, except it insists on recording that information in the domain
> > XML in kinda-sorta-but-not-really back end independent form.
>=20
> Explain "kinda-sorta-but-not-really". If there's a deficiency in the model
> maybe it can be fixed.

My point is that the variety of constraints we can have in the back
end is so broad that it's impossible to construct a representation to
that level of detail which is truly backend independent.

> > But the
> > thing is libvirt fundamentally CAN NOT get this right.
>=20
> True, but not for the reasons you think. If qemu is able to respond to
> queries with adequate details about the devices available for a machinety=
pe
> (and what buses are in place by default), there's no reason that libvirt
> can't add devices addressed such that all the connections are legal;

The problem here is "adequate details".  Again, AFAICT the variety of
possible constraints given all the vagaries of different platforms is
so great that I don't think any format short of code is sufficient to
describe it.

> what
> libvirt *can't* get right is the policy requested in the next higher layer
> of management (and ultimately of the user) - does this device need to be
> hotpluggable? Does the user want to keep all devices on the root complex =
to
> avoid extra PCI controllers?
>=20
> And qemu fundamentally CAN NOT get it right either. qemu knows what is
> possible and what is allowed, but it doesn't know what the user *wants*
> (beyond "they want device X", which is only 1/2 the story), and has no way
> of being told what the user wants other than with a PCI address.

So, here's a more specific point.  You *don't* give PCI addresses to
qemu - rather you give device/slot numbers, and which bus/bridge
they're attached to.  libvirt's use of DDDD:BB:SS.F addresses is a
fundamental error, because such addresses aren't meaningful until
*after* the bus is enumerated.  The bus number is explicitly allocated
during enumeration (by guest firmware or OS).  You can kind of predict
what they'll do, but it requires knowing about every bridge and device
on the system, which means it risks breakage every time the backend
changes its default setup - and the interpretation of the addresses
could be changed by an insertion of a bridge somewhere apparently
unrelated in the XML.

The domain number is an entirely guest-local concept, except - sorta -
on x86 where there's an obvious choice of the index that's used to
control the multiplexed access to all the host bridges' config spaces.
On platforms which have separate registers for each host bridge, it's
entirely possible for libvirt's idea of domain numbers to differ from
the guest's which is wonderfully confusing.

> To back up for a minute, some background info: once a device has been add=
ed
> to a domain, at *any* time in the future (not just during a migration, but
> forever more until the end of time) that device must always have the same
> PCI address as it had that first time. In order to guarantee that, libvirt
> needs to either:

I dispute the "any time".  I'll grant you want to keep the virtual
hardware stable for an extended period.  But if you ever want to
update your backend to newer behaviour (meaning new machine type
version, not just new qemu version) then you should revisit address
allocation.  And, yes, that potentially breaks the guest, but so could
the backend changes anyway, just like any hardware update for a
physical machine.  In most case - assuming it's been set up sensibly -
the guest OS will cope with minor hw reshuffles.  That is, after all,
why RHEL locates filesystems by UUID and NICs by MAC in normal
operation.

> a) keep track of the order the devices were added and always put the devi=
ces
> in the same order on the commandline (assuming that qemu guarantees that =
it
> actually assigns addresses based on the order of the devices' appearance =
on
> the commandline, which has never been stated anywhere as an API guarantee=
 of
> qemu),
>=20
> or
>=20
> b) remember the address of each device as it is added and specify that on
> the commandline in the future. libvirt chooses (b). And where is the logi=
cal
> place to store that address? In the config.

Putting in the config seems like the logical place at first, but it's
a mistake:

First, the information we need to ensure stable guest hardware is
inherently backend specific.  On qemu we need to say which bridges and
bus ids each device is connected to.  Some other system could use PCI
addresses (I think that would be a a design flaw in the backend, but
if libvirt can't deal with imperfect backends it has failed its
remit), for containers the whole question doesn't even make sense.  A
really simplistic hypervisor could take simply an (ordered) list of
plugin devices and always put them into a fixed set of slots.

Putting this into the general config forces us to attempt a solution
to the insoluble: greating a neutral representation translatable to
any backend specific representation.

Second, this means that the config now contains both information that
was originally entered by the user (or next level up) as what they
want for the VM, and also information that libvirt decided once upon a
time and is now sticking with.  We can no longer separate which bits
of information are which.  That means when we want to update the
backend, we can't tell what we should regenerate.

[Meta rant, when it comes to design flaws that breed other design
 flaws the fact that the domain XML is both a read and write interface
 is just about the granddaddy of them all.  It has two awful
 consequences:
  1) After the VM is first run, we can no longer tell which config
     constraints were ones actually requested by the user, and which
     were added by some version of libvirt in the past and are now
     just there so we make the same decisions as before.  That
     distinction matters.
  2) Because the user could be relying on *seeing* something in the
     XML, not just that whatever it put in there will still be
     understood by new libvirt versions means we basically can't ever
     fix errors in the XML design.]

> So we've established that the PCI address of a device needs to be stored =
in
> the config. So why does libvirt need to choose it the first time?
>=20
> 1) Because qemu doesn't have (and CAN NOT have) all the information about
> what are the user's plans for that device:

CAN not?  Why not?  Fundamentally it seems like we need to get the
information about what the user wants and what the virtual hardware
can do into the same place.  At least from the examples you've
mentioned so far, pushing "needs to be hotpluggable" and so forth
flags down into qemu seems a lot more feasible that pulling up the
complex and platform dependent set of constraints into libvirt.

And yes, qemu is very far from perfect in this area - the
introspection interfaces need to be greatly improved.

>   a) It has no idea if the user wants that device to be hotpluggable (on a
> root-port)
>       or not (on root complex as an integrated device)
>=20
>   b) it doesn't know if the user wants the device to be placed on an
> expander bus
>       so that its NUMA status can be discovered by the guest OS.

So both (a) and (b) are precisely examples of what I'm describing.
libvirt is assuming
	(a) requires hotplug =3D> must be on a root port
	(b) device bound to NUMA node =3D> use expander bus

But (a) is only true for guest platforms using the standard hotplug
mechanism.  pseries does not.  (b) is essentially only true for x86 -
the whole concept of the expander bus is a hack to workaround x86's
historical inability to have truly independent PCI host bridge.  On
pseries we can create independent host bridges and assign them each a
NUMA node (including the default one).

qemu already knew that, libvirt needs to be taught.  Just as it seems
like libvirt needs to be taught about practically every platform
quirk.

> If there is a choice, there must be a way to make that choice. The way th=
at
> qemu provides to make the choice is by specifying an address. So libvirt
> must specify an address in its config.

Again, no, qemu does not take addresses at all.  At least not in the
"DDDD:BB:SS.F" sense.  Even if it did, DDDD:BB:SS.F addresses have no
place in a supposedly back-end independent config.

> 2) Because qemu is unable/unwilling to automatically add PCIe root ports
> when necessary, it's *not even possible* (on PCIe machinetypes) for it to
> place a device on a hotpluggable port without libvirt specifying a PCI
> address the very first time the device is added (and also adding in a
> root-port), but libvirt's default policy is that (almost) all devices sho=
uld
> be hotpluggable. If we were to follow your recommendation ("libvirt never
> specifies PCI addresses, but instead allows qemu to assign them"), hotplug
> on PCIe-based machinetypes would not be possible, though.

Ok, so, yes, I see that a lot of this allocation mess originates
because qemu didn't provide sufficient auto-allocation, or
introspection, so libvirt had to work around that.  The trouble is
that those workarounds have now been baked into the libvirt interface
- primarily by the fact that the data is integrated back into the
primary config rather than stored as adjunct back end specific data.
That means it's now insanely difficult to improve the interfaces to
qemu, because libvirt XMLs now have all this address information.  A
few of them are because the user really did request that for some
reason, but many are because that was how libvirt tried to implement
some more abstract user request.  We can now no longer tell the
difference, which means we can't translate those abstract requests
into a new saner qemu interface.

> There have even been mentions that even libvirt is too *low* in the stack=
 to
> be specifying the PCI address of devices (i.e. that all PCI address
> decisions should be up to higher level management applications)

Frankly, if the higher level management needs that much control over
the PCI topology, going via an abstraction layer like libvirt seems
not the right choice.  In that case the management needs to understand
the guest platform in great detail anyway, so what does libvirt buy you.

>- I had
> posted a patch that would allow specifying "hotpluggable=3D'yes|no'" in t=
he
> XML rather than forcing the call to specify an address, and this was NACK=
ed
>because it was seen as libvirt dictating policy.

Huh.  Your patch makes perfect sense to me - a step in the right
direction - and the reason for NACK seems completely bogus.

> (In the end, libvirt *does*
> dictate a default policy, (it's just that the only way to modify that pol=
icy
> is by manually specifying addresses) - libvirt's default PCI address poli=
cy
> is that (almost) all devices will be assigned an address that makes them
> hotpluggable, and will not be placed on a non-0 NUMA node.

Yeah, but "address which makes them hotpluggable" depends on guest
platform (machine type).  As does how you assign them to NUMA nodes.

> So, in spite of libvirt's effort, in the end we *still* need to expose
> address configuration to higher level management applications, since they
> may want to force all devices onto the root complex (e.g. libguestfs, whi=
ch
> does it to reduce PCI controller count, and thus startup time) or force
> certain devices to be on a non-0 NUMA node (e.g. OpenStack when it wants =
to
> place a VFIO assigned device on the same NUMA node in the guest as it is =
in
> the host).

So, I'm not necessarily against allowing an explicit address override
for special cases (although DDDD:BB:SS.F is the wrong way to encode
it).  If that breaks due to a backend update, it's reasonable to just
punt the error back to the user and get them to fix it - if they
didn't understand the guest platform well enough to fix this, they
shouldn't have been overriding addresses.

But it's not reasonable to punt back to the user when the only thing
that got broken by the backend update was information libvirt (maybe
not even the current version) decided some time in the past, based on
faulty assumptions about the guest platform.

But libvirt has no way to distinguish these cases because all the info
is folded back into the one XML blob.

> With all of that, I fail to see how it would be at all viable to simply
> leave PCI address assignment up to qemu.
>=20
> > There are all
> > sorts of possible machine specific address allocation constraints that
> > can exist - from simply which devices are already created by default
> > (for varying values of "default") to complicated constraints depending
> > on details of board wiring.  The back end has to know about these - it
> > implements them.
>=20
> And since qemu knows about them, it should be able to report them. Which =
is
> what Eduardo's work is doing. And then libvirt will know about all the
> constraints in an programmatic manner (rather than the horrible (tedious,
> error prone) hardcoding of all those details that we've had to suffer with
> until now).

I haven't had a chance to look in detail at Eduardo's latest stuff,
but yes it should be an improvement.  But I think you vastly
underestimate how many different platform quirks we could have which
won't be easy to encode.

> > The ONLY way libvirt can get this (temporarily)
> > right is by duplicating a huge chunk of the back end's allocation
> > logic, which will inevitably get out of date causing problems just
> > like this.
> >=20
> > Basically the back end will *always* have better information about how
> > to place devices than libvirt can.
>=20
> And since no matter how hard qemu might try to come up with a policy for
> address assignment that will satisfy the needs of 100% of the users 100% =
of
> the time, it will fail (because different users have different needs).
> Because qemu will be unable to properly place all devices all the time,
> libvirt (and higher level management) will still need to do it. Even in t=
he
> basic case qemu doesn't provide what libvirt requires as default - that
> devices be hotpluggable.
>=20
> > So, libvirt should be allowing the
> > back end to do the allocation, then snapshotting that in a back end
> > specific format which can be used for creating migration
> > destinations. But that breaks libvirt's the-domain-XML-is-everything
> > model.
>=20
> No, that doesn't work because qemu would in many situations place the
> devices at the wrong address / on the wrong controller, because there are
> many possible topologies that are legal, and the user may (for perfectly
> valid reasons) want something different from what qemu would have chosen.

Right, there are certainly reasons for overrides.  But at the moment
*every* device is overridden, which means when there is something
wrong in libvirt's assumptions about how to place things, every device
can break, not just overridden ones.

> (An example of two differing (and valid) policies - libguestfs needs gues=
ts
> to startup as quickly as possible, and thus wants as few PCI controllers =
as
> possible (this makes a noticeable difference in Linux boot time), so it
> wants all devices to be integrated on the root complex. On the other hand=
, a
> generic guest in libvirt should make all devices hotpluggable just in case
> the user wants to unplug them, so by default it tries to place all devices
> on a pcie-root-port. You can't support both of these if addressing is all
> left up to qemu)

With the tools that qemu currently gives you.  But now the assumption
that address allocation belongs to libvirt means that it's insanely
difficult to build those tools without breaking libvirt.

> > In this regard libvirt doesn't just have a design flaw, it has design
> > flaws which breed more design flaws like pestilent cancer.
>=20
>=20
> It may make you feel good to say that, but the facts don't back it up. Any
> project makes design mistakes, but in the specific case you're discussing
> here, I think you haven't looked from a wide enough viewpoint to see the
> necessity of what libvirt is doing and why it can't be done by qemu
> (certainly not all the time anyway).
>=20
>=20
> > And what's
> > worse the consequences of those design flaws are now making sane
> > design decisions increasingly difficult in adjacent projects like
> > qemu.
>=20
> libvirt has always done the best that could be done with the information
> provided by qemu. The problem isn't that libvirt is creating new problems
> for qemu out of thin air, it's that qemu is unable to automatically addre=
ss
> PCI devices for all possible situations and user policy preferences, so
> higher levels need to make the decisions about addressing to satisfy their
> policies (ie what they *want*, eg hotpluggable, integrated on root comple=
x),
> and qemu hasn't (until Eduardo's patches) been able to provide adequate
> information about what is *legal* (e.g which devices can be plugged into
> which model of pci controller, what slots are available on each type of
> controller, whether those slots are hotpluggable) in a programmatic way, =
so
> libvirt has had to hardcode rules about bus-device compatibility and
> capabilities, slot ranges, etc in order to make proper decisions itself w=
hen
> possible, and to sanity-check decisions about addresses made by higher le=
vel
> management when not. I don't think that's a design flaw. I think that's
> making the best of a "less than ideal" situation.
>=20
>=20
> > I'd feel better about this if there seemed to be some recognition of
> > it, and some necessarily long term plan to improve it, but if there is
> > I haven't heard of it.  Or at least the closest thing seems to be
> > coming from the qemu side (witness Eduardo's talk at the last KVM
> > forum, and mine at the one before).
>=20
> Eduardo's work isn't being done to make up for some mythical design flaw =
in
> libvirt. It is being done in order to give libvirt the (previously
> unavailable) information it needs to do a necessary job, and is being done
> at least partly at the request of libvirt (we've certainly been demanding
> some of that stuff for a long time!)

Well, I did warn you it was a rant.  That said, while there are
understandable historical reasons for them design flaws in libvirt
which make it really difficult to design other things properly are
alas not a myth.  Three examples:

1) Read/write XML interface.  Makes it nigh-impossible to fix flaws by
updating to a more coherent internal representation (with backwards
compat glue to parse the old format into the new one).

2) Not separating original user config from libvirt additions /
annotations.  Discussed repeatedly above.

3) Use of DDDD:BB.SS.F addresses (rather than a reference to bus
attachment point + SS.F).  You can't use addresses to construct a
machine in an address space which only exists once the machine is
constructed.

And that's just the first three I came up with that have at least a
slight connection to the problem at hand.

> The summary is that it's impossible for qemu to correctly decide where to
> put new devices, especially in a PCIe hierarchy for a few reasons (at
> least); because of this, libvirt (and higher level management) needs to be
> able to assign addresses to devices, and in order for us/them to be able =
to
> do that properly, qemu needs to provide detailed and accurate information
> about what buses/controllers/devices are in each machinetype, what
> controllers/devices are available to add, and what are the legal ways of
> connecting those devices and controllers.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYR4M/AAoJEGw4ysog2bOSPNAQANgYR3tQnBSjroiBgpIagHMs
Y3rN4yi/cxVZ0KvmEy3puWwLtRGy7Xlu0dMYdyGTGRi3Bbln8T9TMHBodwgn7ZTM
xKO6dZRrJI8zlGdsJxOncugXMmtUgfKuMdJjFv7yCkLLKS+mNgsbccsJjjh5is4R
SDQX7fMGji9tyGvOpCHXduCR8hPQ65a6/jbS8bGN31KLf6psOjZLxW7mpppislg7
zmzQYlmfk2k/muFXw2qlDqSOlAmaIMH20yPQ01Y2WekKk8+cBvvCotHN6dn6N7SB
KwiW1ngKT8XlQyBZvKxtwYSwa4FMAZLelLb/ln1Z6/AVIgGxcgsxFnVhiihh12lR
BIF56VP+2+qAtXZq+VaBk2DQcuG61pAR8PxhEKM5IqHgf6qiMFigQAEVEcD4koQa
Sazp0p6Dy1DwhAwxep8amTYatYSFKVBmCb5dGv38CuRcSDeyGQ9/bw3sfMINepkF
DmQMhvcznSlfXcnDEEJkbc6eHBn4UtvvIMtkSL56w8H4BigP5+dJhbErqnLXzmEi
uykNgpQtXifEIj7LDMb9wfvIwxSI9EoHHscv6zIqz7Bye7hi2nV4ZNmtjTe+2epa
QpKPMqslGjCvgwqQMn/uVFjP2z9w65QHdckO5Lb2Vbq9yZbMGjSQaJTNWBOBuzPA
SBPMPYfz23C8PhhjQRf2
=nLdi
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
