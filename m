Received: from eggs.gnu.org ([2001:4830:134:3::10]:52674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cdUWo-0007vT-NR
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 23:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cdUWl-0005n7-Oi
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 23:15:46 -0500
Date: Tue, 14 Feb 2017 15:15:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170214041532.GF2169@umbus.fritz.box>
References: <20170208061602.17666-1-david@gibson.dropbear.id.au>
	<46d64512-1085-6d22-1e0f-660757ff7131@redhat.com>
	<20170209041634.GC14524@umbus>
	<95706652-0a80-92fc-951b-7a454d496ddf@redhat.com>
	<20170210003746.GP27610@umbus.fritz.box>
	<5ea3785c-b979-8b8c-3ab0-243d69384697@redhat.com>
	<20170213043307.GT25381@umbus>
	<45446029-e404-77d4-754e-5541a506bb7c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="juZjCTNxrMaZdGZC"
Content-Disposition: inline
In-Reply-To: <45446029-e404-77d4-754e-5541a506bb7c@redhat.com>
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
Cc: Laszlo Ersek <lersek@redhat.com>, abologna@redhat.com, lvivier@redhat.com, thuth@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--juZjCTNxrMaZdGZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2017 at 12:14:23PM +0200, Marcel Apfelbaum wrote:
> On 02/13/2017 06:33 AM, David Gibson wrote:
> > On Sun, Feb 12, 2017 at 09:05:46PM +0200, Marcel Apfelbaum wrote:
> > > On 02/10/2017 02:37 AM, David Gibson wrote:
> > > > On Thu, Feb 09, 2017 at 10:04:47AM +0100, Laszlo Ersek wrote:
> > > > > On 02/09/17 05:16, David Gibson wrote:
> > > > > > On Wed, Feb 08, 2017 at 11:40:50AM +0100, Laszlo Ersek wrote:
> > > > > > > On 02/08/17 07:16, David Gibson wrote:
> > > > > > > > Marcel,
> > > > > > > >=20
> > > > > > > > Your original patch adding PCIe support to virtio-pci.c has=
 the
> > > > > > > > limitation noted below that PCIe won't be enabled if the de=
vice is on
> > > > > > > > the root bus (rather than under a root or downstream port).=
  As
> > > > > > > > reasoned below, I think removing the check is correct, even=
 for x86
> > > > > > > > (though it would rarely be useful there).  But I could well=
 have
> > > > > > > > missed something.  Let me know if so...
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > Virtio devices can appear as either vanilla PCI or PCI-Expr=
ess devices
> > > > > > > > depending on the bus they're connected to.  At the moment i=
t will only
> > > > > > > > appear as vanilla PCI if connected to the root bus of a PCI=
e host bridge.
> > > > > > > >=20
> > > > > > > > Presumably this is to reflect the fact that PCIe devices us=
ually need to
> > > > > > > > be connected to a root (or further downstream) port rather =
than directly
> > > > > > > > on the root bus.  However, due to the odd requirements of t=
he PAPR spec on the 'pseries'
> > > > > > > > machine type, it's normal for PCIe devices to appear on the=
 root bus
> > > > > > > > without root ports.
> > > > > > > >=20
> > > > > > > > Further, even on x86, there's no inherent reason we couldn'=
t present a
> > > > > > > > virtio device as an "integrated device" (typically used for=
 things built
> > > > > > > > into the PCI chipset), and those devices *do* typically app=
ear on the root
> > > > > > > > bus.
> > > > > > >=20
> > > > > > > I'm not personally making a counter-argument, just qouting so=
me of
> > > > > > > the relevant parts of "docs/pcie.txt" ("PCI EXPRESS GUIDELINE=
S"):
> > > > > >=20
> > > > > > So, an earlier discussion more or less concluded that the PCIe
> > > > > > guidelines don't really work with PAPR guests.  That comes beca=
use
> > > > > > PAPR was designed with PowerVM in mind which allows PCI passthr=
ough
> > > > > > but doesn't do any emulated PCI devices.  So they wanted to pre=
sent
> > > > > > passed through devices (virtual or phyical) to the guest without
> > > > > > inserting virtual root ports.
> > > > > >=20
> > > > > > Now, you can argue that this was a silly decision in PAPR, and =
you
> > > > > > could well be right, but there it is.
> > > > >=20
> > > > > I can totally accept this, but then we should state it as a fact =
near
> > > > > the top of "docs/pcie.txt".
> > > > >=20
> > > > > >=20
> > > > > > > > Place only the following kinds of devices directly on the R=
oot Complex:
> > > > > > > >     (1) PCI Devices (e.g. network card, graphics card, IDE =
controller),
> > > > > > > >         not controllers. Place only legacy PCI devices on
> > > > > > > >         the Root Complex. These will be considered Integrat=
ed Endpoints.
> > > > > > > >         Note: Integrated Endpoints are not hot-pluggable.
> > > > > > > >=20
> > > > > > > >         Although the PCI Express spec does not forbid PCI E=
xpress devices as
> > > > > > > >         Integrated Endpoints, existing hardware mostly inte=
grates legacy PCI
> > > > > > > >         devices with the Root Complex.
> > > > > >=20
> > > > > > "Mostly".. on my laptop at least the GPU shows up as an integra=
ted PCI
> > > > > > Express endpoint, so it's certainly not the case that *all* roo=
t bus
> > > > > > devices are legacy.
> > > > > >=20
> > > > > > > Guest OSes are suspected to behave
> > > > > > > >         strangely when PCI Express devices are integrated
> > > > > > > >         with the Root Complex.
> > > > > >=20
> > > > > > Clearly not that strangely, that often, since my laptop works j=
ust fine.
> > > > > >=20
> > > > > > > >=20
> > > > > > > >     [...]
> > > > > > > >=20
> > > > > > > > 2.2 PCI Express only hierarchy
> > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > Always use PCI Express Root Ports to start PCI Express hier=
archies.
> > > > > > >=20
> > > > > > > Above you mention "it's normal for PCIe devices to appear on =
the root bus without root ports".
> > > > > >=20
> > > > > > Well "normal" perhaps wasn't the right word.  Let's say precede=
nted,
> > > > > > if uncommon.
> > > > > >=20
> > > > > > > Let me turn the question around: is it a *problem* for "pseri=
es" if
> > > > > > > we require root ports? If so, why exactly?
> > > > > >=20
> > > > > > That's.. a complex question.  At least Linux guests (and we don=
't
> > > > > > support any others yet) might cope with the addition of root po=
rts.
> > > > > > Maybe.  I have discussed this option with BenH and others.
> > > > > >=20
> > > > > > However it is gratuitously different from how PCIe devices will
> > > > > > typically appear for the same guest running under PowerVM.  Alt=
hough I
> > > > > > suspect Linux would cope with the "normal standard" rather than=
 "PAPR
> > > > > > standard" presentation, I'm not as confident about it as I woul=
d like.
> > > > > >=20
> > > > > > Another consideration here is that other PCIe capable qemu emul=
ated
> > > > > > devices, such as XHCI, will present fine as PCIe integrated end=
points
> > > > > > when attached to the root bus.  Libvirt won't do that usually, =
of
> > > > > > course, and it may not be the recommended way of doing things (=
on PC)
> > > > > > but it's possible.  I don't see any particular reason that virt=
io-pci
> > > > > > should enforce the root port requirement more so than any other
> > > > > > device.
> > > > > >=20
> > > > > > > On 02/08/17 07:16, David Gibson wrote:
> > > > > > > >=20
> > > > > > > > pcie_endpoint_cap_init() already automatically adjusts to a=
dvertise as
> > > > > > > > an integrated device rather than a "normal" PCIe endpoint w=
hen attached to
> > > > > > > > a root bus.  So we can remove the check for root bus within=
 virtio and
> > > > > > > > allow (at the user's discretion) a PCIe virtio bus to be at=
tached to a
> > > > > > > > root bus.
> > > > > > >=20
> > > > > > > If Marcel thinks this is a good change, then I think we shoul=
d go
> > > > > > > through "docs/pcie.txt" with a fine-toothed comb, and update =
all
> > > > > > > relevant spots. (If Marcel agrees, perhaps you can include su=
ch
> > > > > > > hunks in your patch at once.)
> > > > > >=20
> > > > > > Actually, I think that would be a neverending process.  Maybe b=
etter
> > > > > > to put in a whole different spapr-pcie.txt with the assorted wa=
ys that
> > > > > > PAPR violates PCIe conventions.
> > > > >=20
> > > > > That works for me too, but I think it would be a lot more work fo=
r you
> > > > > and others.
> > > > >=20
> > > > > I plan on consulting "docs/pcie.txt" frequently; among other thin=
gs, for
> > > > > deciding debates. Thus, improving the scope of "docs/pcie.txt" is=
 very
> > > > > welcome IMO.
> > > > >=20
> > > > > >=20
> > > > > > > It also may have consequences for libvirt (but I see you addr=
essed
> > > > > > > Andrea at once, which is great).
> > > > > >=20
> > > > > > Right, I've been discussed this with Andrea all along.  We're w=
orking
> > > > > > on a proposed PAPR specific way of allocating PCI and PCIe addr=
esses
> > > > > > (different from the PCIe normal way, but the same as each other=
).
> > > > > > That will simplify adding PCIe support to PAPR, and also has so=
me
> > > > > > other advantages for PAPR guests (related to the platform speci=
fic
> > > > > > isolation, hotplug  and error recovery mechanisms - also differ=
ent
> > > > > > from the normal PCIe ones).
> > > > >=20
> > > > > Great, if Andrea is aware, that's a relief.
> > > > >=20
> > > > > Can you resubmit this patch with a small hunk for "docs/pcie.txt"=
 that
> > > > > removes PAPR from the scope?
> > > >=20
> > >=20
> > > Hi David,
> > > Sorry for the delay, I just came back from PTO.
> > >=20
> > > > Well, first I'd like to see if Marcel knows of some reason I didn't
> > > > think of why this test is important for virtio particularly here.  =
But
> > > > assuming the basic idea is acceptable, then yes, I'll update pcie.t=
xt.
> > > >=20
> > >=20
> > > There are two reasons for keeping virtio Integrated Endpoints as PCI =
devices.
> > > 1. The first point is generic; even if having PCIe devices as Integra=
ted Endpoints should be OK,
> > >    is not recommended because some guests may miss-behave (*). X86 ar=
ch supports a large number
> > >    of guests and we don't want to check and fix everything if *we don=
't have to*.
> > >    Even if is not written anywhere and there are actually some PCI Ex=
press Integrated Endpoints,
> > >    most of them are legacy PCI devices (I actually think this is why =
we have Integrated Endpoints
> > >    at all, but I might be wrong).
> >=20
> > Hm, ok.  Could we implement that restriction in the pci/pcie core
> > rather than in the virtio device?
>=20
> I am not sure if we should do that. Most of the devices are PCI or PCIe.
> Only some devices are "hybrid", the virtio devices, XHCI and I am not sur=
e we have more.

Ok, I see your point, the pcie core might not be right.  But it still
seems really weird to have it explicitly in each hybrid device, even
if it's just the two.  As the code stands right now, XHCI and virtio
have different behaviour, without a clear reason for it.

Maybe a hybrid_setup() helper function?

> > That would then protect things like
> > XHCI as well.
>=20
> I don't see a reason to have XHCI as Integrated Endpoint, I think it shou=
ld be always
> plugged into a root port. (for x86. arm and power)

No, not for Power.  Well, ok, yes for most ppc machine types, but not
for the paravirtualized 'pseries' machine (which is the one we most
care about).

Well.. I guess it doesn't need to be an Integrated Endpoint per se,
but we should be able to have it appear on the guest root bus.

The thing to realize is that the paravirtualized PCI interfaces in
PAPR mean there's very little guest visible difference between PCI and
PCIe.  In fact in most ways you could say that the paravirtualized bus
operates like a vanilla PCI bus.. except that it does provide a way to
access PCIe extended config space.  Which means that you can use it to
drive PCIe devices just fine.  "Bus level" PCIe extensions like AER
and PCIe standard hotplug won't work, but PAPR has its own mechanisms
for those (common between PCI and PCIe).

I did float the idea of having the pseries PCI bus remain plain PCI
but with a special flag to allow PCIe devices to be attached to it
anyway.  It wasn't greeted with much enthusiasm..

>   And for my purposes it would also make it easier to
> > implement aa machine type specific hook to re-allow that configuration
> > on pseries.
>=20
> I agree we need a solution for PAPR.
>=20
> What about a pcie_papr() function and then:
>=20
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 5ce42af..2c646ae 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1804,7 +1804,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev, =
Error **errp)
>          return;
>      }
>=20
> -    if (pcie_port && pci_is_express(pci_dev)) {
> +    if ((pcie_port || pcie_parp()) && pci_is_express(pci_dev)) {
>          int pos;
>=20
>          pos =3D pcie_endpoint_cap_init(pci_dev, 0);

That would be sufficient, yes, so I'll take it if we don't come to any
other solutions.  It still seems weird to me to have this logic within
a specific device implementation though.

> >=20
> > At the moment XHCI and virtio-pci behave differently, which seems less
> > than ideal.
> >=20
> > > 2. The second point is virtio specific. Not all the guests have virti=
o 1.0 support (e.g RHEL 6) and we allow them
> > >    to use legacy virtio devices as Integrated Endpoints (following th=
e thought that this is why we have Integrated Endpoints)
> > >    Making the virtio devices PCI Express, but not virtio 1.0 is also =
problematic since now we will have too much
> > >    types of virtio devices. We want to keep it simple: virtio legacy
> > >    -> PCI, virtio modern -> PCIe.
> >=20
> > Ok.. it's not obvious to me why integrated endpoint vs. under a root
> > port is relevant to this.  Can't we enable/disable PCIe mode based
> > directly on the legacy/modern settings?
> >=20
>=20
> Yes, we can, but we don't want to do that. Previous setups will stop work=
ing
> and we will need libvirt to mange the disable-* properties.
> As a matter of fact the code today is after some discussions with libvirt=
 guys.

Uh.. I think I'm missing something.. but it's still not clear to me
why this would break existing setups or impose more work on libvirt.

> > > (*) A while ago Alex Williamson found such of issue, I think is this =
one:
> > > 0282ab (vfio/pci: Hide device PCIe capability on non-express buses fo=
r PCIe VMs)
> >=20
> > It's also not clear to me why this fix is relevant to the question.
> > That change disables the PCIe capability on a bus which is
> > not-express, but is under an express root bridge (and is therefore
> > clearly *not* on the root bus).  For the case I'm talking about the
> > *is* on an express bus and it *is* the root bus.  AFAICT that patch
> > would be relevant only for devices under a PCIe-to-PCI bridge on a
> > PCIe system.
> >=20
>=20
> I might have selected the wrong patch.

Ok.

>=20
> Thanks,
> Marcel
>=20
>=20
> > > > > be appreciated too, if that makes sense. (By default we aim at
> > > > > multi-arch / multi-target with this document; we may not have sta=
ted it
> > > > > explicitly, but AFAIR we intend to cover aarch64 / "virt" too.)
> > > >=20
> > > > Right, that was my understanding as well.
> > > >=20
> > >=20
> > > Indeed, we want the document to support them all. If PAPR is differen=
t, we should mention it.
> >=20
> > Sure.  I'm trying to work out what we can/should do for pseries first;
> > I'll write something up for the docs when I have something I think is
> > ready to merge.
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--juZjCTNxrMaZdGZC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYooRiAAoJEGw4ysog2bOSGD8P/j5V9XRZ7VYv7DltdXW0CEDR
GjVUgKqVm3sH7jZGyE7YQ355lJxMELkmIxNX0ehd5I9KiXX9ClYORyUMrK1ymqUR
BQPQXRMp47jB2Fn7ji6B/Vz8C4OdnUIccSke+BBddRxge1WOYbCZADV6V/KAVE9s
OVKaI55dZwqU+B5yv3GNEYJYqmCUTjwlTYrlDhJafkb/9nmodvZQ52cou4wv82bq
bzW1HHyNQ8WA7WkhpCK7mNHWqQMStU718W0IN7/Nn6nHXfdPhBUj1ex391RMuvM5
dLXpRLTuqp8OgBVBHIF5LiE0ytXeur5k0CQswiPtcJ2/5OVeFe5Kl972nir26vbg
zJdf01j5firIXC/LggaaZWbqAZt1ZtV3m31LIe+ONeLXyRKbDlaO3WQxSOAWMZRE
RIs1v+/K57oXhTtUdeVYH1KMYQNFvZbRxAr8QBuTqHrQjj/RI3JcBSccRNlIPHVc
UcXmoajKRyZLNOGtAw/o4aKi4oTy3yFVqLZjkVLQWcVTPihDYHtg4+XF6MiO0cT6
HJHYlfkowxkPRCA+v9BMYG1yY6IOF2EZp5HiGJsNfPUjvTQdEqhJb+Xq2Y3jNgNr
bIJz6PzQzMHGgLl4f3pwnPh6QehUS8FhbxVrma9v55Ym+TniEi10A2cU4ZfY0DQW
R1uY+EEG55vgq4X/5Q79
=Bfj0
-----END PGP SIGNATURE-----

--juZjCTNxrMaZdGZC--
