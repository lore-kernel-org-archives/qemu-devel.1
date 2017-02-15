Received: from eggs.gnu.org ([2001:4830:134:3::10]:47479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cdofO-0002Eg-5P
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 20:46:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cdofL-0004wO-0q
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 20:45:58 -0500
Date: Wed, 15 Feb 2017 12:45:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170215014544.GC12369@umbus.fritz.box>
References: <20170208061602.17666-1-david@gibson.dropbear.id.au>
	<46d64512-1085-6d22-1e0f-660757ff7131@redhat.com>
	<20170209041634.GC14524@umbus>
	<95706652-0a80-92fc-951b-7a454d496ddf@redhat.com>
	<20170210003746.GP27610@umbus.fritz.box>
	<5ea3785c-b979-8b8c-3ab0-243d69384697@redhat.com>
	<20170213043307.GT25381@umbus>
	<45446029-e404-77d4-754e-5541a506bb7c@redhat.com>
	<20170214041532.GF2169@umbus.fritz.box>
	<c0e368b1-c89d-ef5a-d475-c92266d3eb41@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Content-Disposition: inline
In-Reply-To: <c0e368b1-c89d-ef5a-d475-c92266d3eb41@redhat.com>
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
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, abologna@redhat.com, lvivier@redhat.com, thuth@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, kraxel@redhat.com, Eduardo Habkost <ehabkost@redhat.com>


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 14, 2017 at 02:53:08PM +0200, Marcel Apfelbaum wrote:
> On 02/14/2017 06:15 AM, David Gibson wrote:
> > On Mon, Feb 13, 2017 at 12:14:23PM +0200, Marcel Apfelbaum wrote:
> > > On 02/13/2017 06:33 AM, David Gibson wrote:
> > > > On Sun, Feb 12, 2017 at 09:05:46PM +0200, Marcel Apfelbaum wrote:
> > > > > On 02/10/2017 02:37 AM, David Gibson wrote:
> > > > > > On Thu, Feb 09, 2017 at 10:04:47AM +0100, Laszlo Ersek wrote:
> > > > > > > On 02/09/17 05:16, David Gibson wrote:
> > > > > > > > On Wed, Feb 08, 2017 at 11:40:50AM +0100, Laszlo Ersek wrot=
e:
> > > > > > > > > On 02/08/17 07:16, David Gibson wrote:
> > > > > > > > > > Marcel,
> > > > > > > > > >=20
> > > > > > > > > > Your original patch adding PCIe support to virtio-pci.c=
 has the
> > > > > > > > > > limitation noted below that PCIe won't be enabled if th=
e device is on
> > > > > > > > > > the root bus (rather than under a root or downstream po=
rt).  As
> > > > > > > > > > reasoned below, I think removing the check is correct, =
even for x86
> > > > > > > > > > (though it would rarely be useful there).  But I could =
well have
> > > > > > > > > > missed something.  Let me know if so...
> > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > Virtio devices can appear as either vanilla PCI or PCI-=
Express devices
> > > > > > > > > > depending on the bus they're connected to.  At the mome=
nt it will only
> > > > > > > > > > appear as vanilla PCI if connected to the root bus of a=
 PCIe host bridge.
> > > > > > > > > >=20
> > > > > > > > > > Presumably this is to reflect the fact that PCIe device=
s usually need to
> > > > > > > > > > be connected to a root (or further downstream) port rat=
her than directly
> > > > > > > > > > on the root bus.  However, due to the odd requirements =
of the PAPR spec on the 'pseries'
> > > > > > > > > > machine type, it's normal for PCIe devices to appear on=
 the root bus
> > > > > > > > > > without root ports.
> > > > > > > > > >=20
> > > > > > > > > > Further, even on x86, there's no inherent reason we cou=
ldn't present a
> > > > > > > > > > virtio device as an "integrated device" (typically used=
 for things built
> > > > > > > > > > into the PCI chipset), and those devices *do* typically=
 appear on the root
> > > > > > > > > > bus.
> > > > > > > > >=20
> > > > > > > > > I'm not personally making a counter-argument, just qoutin=
g some of
> > > > > > > > > the relevant parts of "docs/pcie.txt" ("PCI EXPRESS GUIDE=
LINES"):
> > > > > > > >=20
> > > > > > > > So, an earlier discussion more or less concluded that the P=
CIe
> > > > > > > > guidelines don't really work with PAPR guests.  That comes =
because
> > > > > > > > PAPR was designed with PowerVM in mind which allows PCI pas=
sthrough
> > > > > > > > but doesn't do any emulated PCI devices.  So they wanted to=
 present
> > > > > > > > passed through devices (virtual or phyical) to the guest wi=
thout
> > > > > > > > inserting virtual root ports.
> > > > > > > >=20
> > > > > > > > Now, you can argue that this was a silly decision in PAPR, =
and you
> > > > > > > > could well be right, but there it is.
> > > > > > >=20
> > > > > > > I can totally accept this, but then we should state it as a f=
act near
> > > > > > > the top of "docs/pcie.txt".
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > > > Place only the following kinds of devices directly on t=
he Root Complex:
> > > > > > > > > >     (1) PCI Devices (e.g. network card, graphics card, =
IDE controller),
> > > > > > > > > >         not controllers. Place only legacy PCI devices =
on
> > > > > > > > > >         the Root Complex. These will be considered Inte=
grated Endpoints.
> > > > > > > > > >         Note: Integrated Endpoints are not hot-pluggabl=
e.
> > > > > > > > > >=20
> > > > > > > > > >         Although the PCI Express spec does not forbid P=
CI Express devices as
> > > > > > > > > >         Integrated Endpoints, existing hardware mostly =
integrates legacy PCI
> > > > > > > > > >         devices with the Root Complex.
> > > > > > > >=20
> > > > > > > > "Mostly".. on my laptop at least the GPU shows up as an int=
egrated PCI
> > > > > > > > Express endpoint, so it's certainly not the case that *all*=
 root bus
> > > > > > > > devices are legacy.
> > > > > > > >=20
> > > > > > > > > Guest OSes are suspected to behave
> > > > > > > > > >         strangely when PCI Express devices are integrat=
ed
> > > > > > > > > >         with the Root Complex.
> > > > > > > >=20
> > > > > > > > Clearly not that strangely, that often, since my laptop wor=
ks just fine.
> > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > >     [...]
> > > > > > > > > >=20
> > > > > > > > > > 2.2 PCI Express only hierarchy
> > > > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > > Always use PCI Express Root Ports to start PCI Express =
hierarchies.
> > > > > > > > >=20
> > > > > > > > > Above you mention "it's normal for PCIe devices to appear=
 on the root bus without root ports".
> > > > > > > >=20
> > > > > > > > Well "normal" perhaps wasn't the right word.  Let's say pre=
cedented,
> > > > > > > > if uncommon.
> > > > > > > >=20
> > > > > > > > > Let me turn the question around: is it a *problem* for "p=
series" if
> > > > > > > > > we require root ports? If so, why exactly?
> > > > > > > >=20
> > > > > > > > That's.. a complex question.  At least Linux guests (and we=
 don't
> > > > > > > > support any others yet) might cope with the addition of roo=
t ports.
> > > > > > > > Maybe.  I have discussed this option with BenH and others.
> > > > > > > >=20
> > > > > > > > However it is gratuitously different from how PCIe devices =
will
> > > > > > > > typically appear for the same guest running under PowerVM. =
 Although I
> > > > > > > > suspect Linux would cope with the "normal standard" rather =
than "PAPR
> > > > > > > > standard" presentation, I'm not as confident about it as I =
would like.
> > > > > > > >=20
> > > > > > > > Another consideration here is that other PCIe capable qemu =
emulated
> > > > > > > > devices, such as XHCI, will present fine as PCIe integrated=
 endpoints
> > > > > > > > when attached to the root bus.  Libvirt won't do that usual=
ly, of
> > > > > > > > course, and it may not be the recommended way of doing thin=
gs (on PC)
> > > > > > > > but it's possible.  I don't see any particular reason that =
virtio-pci
> > > > > > > > should enforce the root port requirement more so than any o=
ther
> > > > > > > > device.
> > > > > > > >=20
> > > > > > > > > On 02/08/17 07:16, David Gibson wrote:
> > > > > > > > > >=20
> > > > > > > > > > pcie_endpoint_cap_init() already automatically adjusts =
to advertise as
> > > > > > > > > > an integrated device rather than a "normal" PCIe endpoi=
nt when attached to
> > > > > > > > > > a root bus.  So we can remove the check for root bus wi=
thin virtio and
> > > > > > > > > > allow (at the user's discretion) a PCIe virtio bus to b=
e attached to a
> > > > > > > > > > root bus.
> > > > > > > > >=20
> > > > > > > > > If Marcel thinks this is a good change, then I think we s=
hould go
> > > > > > > > > through "docs/pcie.txt" with a fine-toothed comb, and upd=
ate all
> > > > > > > > > relevant spots. (If Marcel agrees, perhaps you can includ=
e such
> > > > > > > > > hunks in your patch at once.)
> > > > > > > >=20
> > > > > > > > Actually, I think that would be a neverending process.  May=
be better
> > > > > > > > to put in a whole different spapr-pcie.txt with the assorte=
d ways that
> > > > > > > > PAPR violates PCIe conventions.
> > > > > > >=20
> > > > > > > That works for me too, but I think it would be a lot more wor=
k for you
> > > > > > > and others.
> > > > > > >=20
> > > > > > > I plan on consulting "docs/pcie.txt" frequently; among other =
things, for
> > > > > > > deciding debates. Thus, improving the scope of "docs/pcie.txt=
" is very
> > > > > > > welcome IMO.
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > > It also may have consequences for libvirt (but I see you =
addressed
> > > > > > > > > Andrea at once, which is great).
> > > > > > > >=20
> > > > > > > > Right, I've been discussed this with Andrea all along.  We'=
re working
> > > > > > > > on a proposed PAPR specific way of allocating PCI and PCIe =
addresses
> > > > > > > > (different from the PCIe normal way, but the same as each o=
ther).
> > > > > > > > That will simplify adding PCIe support to PAPR, and also ha=
s some
> > > > > > > > other advantages for PAPR guests (related to the platform s=
pecific
> > > > > > > > isolation, hotplug  and error recovery mechanisms - also di=
fferent
> > > > > > > > from the normal PCIe ones).
> > > > > > >=20
> > > > > > > Great, if Andrea is aware, that's a relief.
> > > > > > >=20
> > > > > > > Can you resubmit this patch with a small hunk for "docs/pcie.=
txt" that
> > > > > > > removes PAPR from the scope?
> > > > > >=20
> > > > >=20
> > > > > Hi David,
> > > > > Sorry for the delay, I just came back from PTO.
> > > > >=20
> > > > > > Well, first I'd like to see if Marcel knows of some reason I di=
dn't
> > > > > > think of why this test is important for virtio particularly her=
e.  But
> > > > > > assuming the basic idea is acceptable, then yes, I'll update pc=
ie.txt.
> > > > > >=20
> > > > >=20
> > > > > There are two reasons for keeping virtio Integrated Endpoints as =
PCI devices.
> > > > > 1. The first point is generic; even if having PCIe devices as Int=
egrated Endpoints should be OK,
> > > > >    is not recommended because some guests may miss-behave (*). X8=
6 arch supports a large number
> > > > >    of guests and we don't want to check and fix everything if *we=
 don't have to*.
> > > > >    Even if is not written anywhere and there are actually some PC=
I Express Integrated Endpoints,
> > > > >    most of them are legacy PCI devices (I actually think this is =
why we have Integrated Endpoints
> > > > >    at all, but I might be wrong).
> > > >=20
> > > > Hm, ok.  Could we implement that restriction in the pci/pcie core
> > > > rather than in the virtio device?
> > >=20
> > > I am not sure if we should do that. Most of the devices are PCI or PC=
Ie.
> > > Only some devices are "hybrid", the virtio devices, XHCI and I am not=
 sure we have more.
> >=20
> > Ok, I see your point, the pcie core might not be right.  But it still
> > seems really weird to have it explicitly in each hybrid device, even
> > if it's just the two.  As the code stands right now, XHCI and virtio
> > have different behaviour, without a clear reason for it.
> >=20
>=20
> I suppose XHCI can behave the same as virtio if Gerd has nothing against =
it
> (remain PCI if plugged into the Root Complex), but I don't know how it wi=
ll help your case.

> > Maybe a hybrid_setup() helper function?
> >=20
>=20
> How would it help PAPR scenario?

It doesn't, directly, but it means there would only be a single place
to fix with a PAPR hack, instead of both virtio and XHCI and any
future hybrid devices.

> Anyway, Eduardo is working on supplying
> new query interfaces for libvirt and he touches this subject, I think
> he does plan to mark the hybrid devices in some way.
>=20
>=20
> > > > That would then protect things like
> > > > XHCI as well.
> > >=20
> > > I don't see a reason to have XHCI as Integrated Endpoint, I think it =
should be always
> > > plugged into a root port. (for x86. arm and power)
> >=20
> > No, not for Power.  Well, ok, yes for most ppc machine types, but not
> > for the paravirtualized 'pseries' machine (which is the one we most
> > care about).
> >=20
> > Well.. I guess it doesn't need to be an Integrated Endpoint per se,
> > but we should be able to have it appear on the guest root bus.
> >=20
> > The thing to realize is that the paravirtualized PCI interfaces in
> > PAPR mean there's very little guest visible difference between PCI and
> > PCIe.  In fact in most ways you could say that the paravirtualized bus
> > operates like a vanilla PCI bus.. except that it does provide a way to
> > access PCIe extended config space.
>=20
> Maybe we can have a new bus type deriving from PCIBus and sibling of the =
PCIe Bus.
> Then we can have the same rules as the PCI bus and add tweaks when
> necessary.

Sounds possible.  I guess it would need to return true for
pci_bus_is_express(), so that PCIe devices will attach to it.  In
which case I'm not entirely sure how it would differ from a PCIe bus
=66rom the qemu side.  AFAICT with the exception of the virtio check and
maybe a handful of others, the PCIe placement rules are handled by
libvirt, rather than by qemu.

> This does not solve the virtio problem since the code is actively looking=
 for
> a PCIe Root Port and we don't have it for PAPR.

Technically, it's not even looking for a root port, just excluding
being on the root bus itself.  I guess any kind of bridge that has
something PCI-ish on the upstream side and PCIe on the downstream side
more or less has to be either a root port or a PCIe switch downstream
port, though.

>   Which means that you can use it to
> > drive PCIe devices just fine.  "Bus level" PCIe extensions like AER
> > and PCIe standard hotplug won't work, but PAPR has its own mechanisms
> > for those (common between PCI and PCIe).
> >=20
> > I did float the idea of having the pseries PCI bus remain plain PCI
> > but with a special flag to allow PCIe devices to be attached to it
> > anyway.  It wasn't greeted with much enthusiasm..
> >=20
>=20
> Can you point me to the discussion please? It seems similar to what I pro=
posed above.

Sorry, I was misleading.  I think I just raised that idea with Andrea
and a few other people internally, not on one of the lists at large.

> As you properly described it, is much closer to PCI then PCIe, even the o=
nly characteristic
> that makes it "a little" PCIe, the Extended Configuration Space support,
> is done with an alternative interface.
>=20
> I agree the PAPR bus is not PCIe.

Ok, so if we take that direction, the question becomes how do we let
PCIe devices plug into this mostly-not-PCIe bus.  Maybe introduce a
"pci_bus_accepts_express()" function that will replace many, but not
all current uses of "pci_bus_is_express()"?

Such a helper could maybe simplify the logic in virtio-pci (and XHCI?)
by returning false on an x86 root bus.

>=20
> > >   And for my purposes it would also make it easier to
> > > > implement aa machine type specific hook to re-allow that configurat=
ion
> > > > on pseries.
> > >=20
> > > I agree we need a solution for PAPR.
> > >=20
> > > What about a pcie_papr() function and then:
> > >=20
> > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > > index 5ce42af..2c646ae 100644
> > > --- a/hw/virtio/virtio-pci.c
> > > +++ b/hw/virtio/virtio-pci.c
> > > @@ -1804,7 +1804,7 @@ static void virtio_pci_realize(PCIDevice *pci_d=
ev, Error **errp)
> > >          return;
> > >      }
> > >=20
> > > -    if (pcie_port && pci_is_express(pci_dev)) {
> > > +    if ((pcie_port || pcie_parp()) && pci_is_express(pci_dev)) {
> > >          int pos;
> > >=20
> > >          pos =3D pcie_endpoint_cap_init(pci_dev, 0);
> >=20
> > That would be sufficient, yes, so I'll take it if we don't come to any
> > other solutions.
>=20
> OK
>=20
>  It still seems weird to me to have this logic within
> > a specific device implementation though.
> >=20
>=20
> I suppose you have a point, let's wait for Gerd and maybe Michael to comm=
ent
> on that, but anyway it will not help your case. (it will only make XHCI P=
CI if plugged into Root Complex)

It won't help directly, but it means we could put that pcie_papr()
test in just the common code, rather than having to look at every
hybrid and PCIe device.

> > > >=20
> > > > At the moment XHCI and virtio-pci behave differently, which seems l=
ess
> > > > than ideal.
> > > >=20
> > > > > 2. The second point is virtio specific. Not all the guests have v=
irtio 1.0 support (e.g RHEL 6) and we allow them
> > > > >    to use legacy virtio devices as Integrated Endpoints (followin=
g the thought that this is why we have Integrated Endpoints)
> > > > >    Making the virtio devices PCI Express, but not virtio 1.0 is a=
lso problematic since now we will have too much
> > > > >    types of virtio devices. We want to keep it simple: virtio leg=
acy
> > > > >    -> PCI, virtio modern -> PCIe.
> > > >=20
> > > > Ok.. it's not obvious to me why integrated endpoint vs. under a root
> > > > port is relevant to this.  Can't we enable/disable PCIe mode based
> > > > directly on the legacy/modern settings?
> > > >=20
> > >=20
> > > Yes, we can, but we don't want to do that. Previous setups will stop =
working
> > > and we will need libvirt to mange the disable-* properties.
> > > As a matter of fact the code today is after some discussions with lib=
virt guys.
> >=20
> > Uh.. I think I'm missing something.. but it's still not clear to me
> > why this would break existing setups or impose more work on libvirt.
> >=20
>=20
> Long story short, libvirt guys don't want to manually set the disable-* p=
roperties
> of virtio devices to make them comply to our goal (legacy -> PCI, modern =
PCIe).
> They also don't want to look at QEMU version/machine type to make a decis=
ion on the above properties.
>=20
> I agree the solution is not perfect, but at least it makes our testing ma=
trix smaller
> and makes our PCIe guidelines a little easier to understand (e.g. all sup=
ported devices are PCIe,
> but if want legacy PCI devices put them on the Root Complex)

Ok.. I'm still missing something.  Are you saying that instead of the
legacy/modern status determining PCIe support, that PCIe status is
determining legacy/modern support by default?  That would actually
seem to simplify things: whatever method we end up allowing PCIe
virtio on PAPR, that should automatically enable modern mode, which is
fine.

Although.. I do wonder about legacy/modern for PAPR in general.
Current kernels will support virtio 1.0 fine, but we have older
released versions which only support legacy.  Unlike PC we won't (I
hope) have a whole machine type switch to handle this.  At this stage
I think we want virtio devices (whatever their bus type) on PAPR to
default to allowing both legacy and modern for the forseeable future.
How does that affect the matrix?

> XHCI being PCIe on Root Complex is an unintended exception, but we want i=
t connected to a
> Root Port anyway, we don't have anything to gain from having it as Integr=
ated Endpoint.
> We only loose a slot that can be used by 8 Root Ports assembled into one =
multi-function device.
>=20
> PAPR bus should not be considered PCIe and should have a different set of=
 rules allowing PCIe
> devices to be plugged into Root Complex.

Alright, I can work with that.  Michael, Andrea, how does this idea
seem to you?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYo7LGAAoJEGw4ysog2bOSyA4QALk/4Ivz9VujDiej7HWQ+58O
/GT11lWBFTYC6EdZRLKEs9N41AGeimf/ki3Sqc2hZWZP+1BepH5vdawjDLPJa+1G
OiXkcR6kpCpeBhXJoxqRPBvj9CKu9FRQhiZp23BeIvafnkRDlbADtI0QAOD0gb9F
sx//H7cmXCXdPkqPgIn8U3xZHn+czpp88RBWmC0kwgtp6amYmTvm8PWPaveqUTdt
j2LfCk5MpwTrEeSU2OGIC54sKF2z4f+w/8K3HsfmjGS6BwsEGUytksZRpYnGWh0t
e5DO7xSd5f3hZCZlTJ7Vc8t5opeOJmVdWq1utoMfoBv9xa04gbwYAtQFAWWRMBPE
TK57jp81+F2O05oO4hh2/+qii1xjpEf1LtTIq62LRDvfFCe2lz/F5w15YW11VuQ/
bIVUf0UzoiARPz5kL9kGzRU3ONhSMC3VxaoPZopKf7tM3mBDG/T2agrQu/N4j+8h
An+jl18DZCQ30TNKjuKgmUmxozo3s8EBwBBwKNMkPK/heWRjUhFh3LHFGmHRw9vx
NAUQ8Y/xBjk2a+W8hPYl3UaIvywvCLydA8ratoAZBPMSvGcwTzl4KfPdXKUdTQeH
UMV/X/LzpKQVuXDOimqwnL8zjsGwTfdBhpqdYEn+mbfTmHcFjdvrPoeT7Xe/ncvY
WTzwptPpAA7JobMAQFuS
=gc5m
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
