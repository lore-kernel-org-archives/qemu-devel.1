Received: from eggs.gnu.org ([2001:4830:134:3::10]:47042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbzFB-0002M7-NX
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:39:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbzF9-00067q-N5
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:39:21 -0500
Date: Fri, 10 Feb 2017 11:37:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170210003746.GP27610@umbus.fritz.box>
References: <20170208061602.17666-1-david@gibson.dropbear.id.au>
	<46d64512-1085-6d22-1e0f-660757ff7131@redhat.com>
	<20170209041634.GC14524@umbus>
	<95706652-0a80-92fc-951b-7a454d496ddf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wqJr86X7F8PBspU2"
Content-Disposition: inline
In-Reply-To: <95706652-0a80-92fc-951b-7a454d496ddf@redhat.com>
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: marcel@redhat.com, abologna@redhat.com, lvivier@redhat.com, thuth@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--wqJr86X7F8PBspU2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2017 at 10:04:47AM +0100, Laszlo Ersek wrote:
> On 02/09/17 05:16, David Gibson wrote:
> > On Wed, Feb 08, 2017 at 11:40:50AM +0100, Laszlo Ersek wrote:
> >> On 02/08/17 07:16, David Gibson wrote:
> >>> Marcel,
> >>>
> >>> Your original patch adding PCIe support to virtio-pci.c has the
> >>> limitation noted below that PCIe won't be enabled if the device is on
> >>> the root bus (rather than under a root or downstream port).  As
> >>> reasoned below, I think removing the check is correct, even for x86
> >>> (though it would rarely be useful there).  But I could well have
> >>> missed something.  Let me know if so...
> >>>
> >>>
> >>>
> >>> Virtio devices can appear as either vanilla PCI or PCI-Express devices
> >>> depending on the bus they're connected to.  At the moment it will only
> >>> appear as vanilla PCI if connected to the root bus of a PCIe host bri=
dge.
> >>>
> >>> Presumably this is to reflect the fact that PCIe devices usually need=
 to
> >>> be connected to a root (or further downstream) port rather than direc=
tly
> >>> on the root bus.  However, due to the odd requirements of the PAPR sp=
ec on the 'pseries'
> >>> machine type, it's normal for PCIe devices to appear on the root bus
> >>> without root ports.
> >>>
> >>> Further, even on x86, there's no inherent reason we couldn't present a
> >>> virtio device as an "integrated device" (typically used for things bu=
ilt
> >>> into the PCI chipset), and those devices *do* typically appear on the=
 root
> >>> bus.
> >>
> >> I'm not personally making a counter-argument, just qouting some of
> >> the relevant parts of "docs/pcie.txt" ("PCI EXPRESS GUIDELINES"):
> >=20
> > So, an earlier discussion more or less concluded that the PCIe
> > guidelines don't really work with PAPR guests.  That comes because
> > PAPR was designed with PowerVM in mind which allows PCI passthrough
> > but doesn't do any emulated PCI devices.  So they wanted to present
> > passed through devices (virtual or phyical) to the guest without
> > inserting virtual root ports.
> >=20
> > Now, you can argue that this was a silly decision in PAPR, and you
> > could well be right, but there it is.
>=20
> I can totally accept this, but then we should state it as a fact near
> the top of "docs/pcie.txt".
>=20
> >=20
> >>> Place only the following kinds of devices directly on the Root Comple=
x:
> >>>     (1) PCI Devices (e.g. network card, graphics card, IDE controller=
),
> >>>         not controllers. Place only legacy PCI devices on
> >>>         the Root Complex. These will be considered Integrated Endpoin=
ts.
> >>>         Note: Integrated Endpoints are not hot-pluggable.
> >>>
> >>>         Although the PCI Express spec does not forbid PCI Express dev=
ices as
> >>>         Integrated Endpoints, existing hardware mostly integrates leg=
acy PCI
> >>>         devices with the Root Complex.
> >=20
> > "Mostly".. on my laptop at least the GPU shows up as an integrated PCI
> > Express endpoint, so it's certainly not the case that *all* root bus
> > devices are legacy.
> >=20
> >> Guest OSes are suspected to behave
> >>>         strangely when PCI Express devices are integrated
> >>>         with the Root Complex.
> >=20
> > Clearly not that strangely, that often, since my laptop works just fine.
> >=20
> >>>
> >>>     [...]
> >>>
> >>> 2.2 PCI Express only hierarchy
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >>> Always use PCI Express Root Ports to start PCI Express hierarchies.
> >>
> >> Above you mention "it's normal for PCIe devices to appear on the root =
bus without root ports".
> >=20
> > Well "normal" perhaps wasn't the right word.  Let's say precedented,
> > if uncommon.
> >=20
> >> Let me turn the question around: is it a *problem* for "pseries" if
> >> we require root ports? If so, why exactly?
> >=20
> > That's.. a complex question.  At least Linux guests (and we don't
> > support any others yet) might cope with the addition of root ports.
> > Maybe.  I have discussed this option with BenH and others.
> >=20
> > However it is gratuitously different from how PCIe devices will
> > typically appear for the same guest running under PowerVM.  Although I
> > suspect Linux would cope with the "normal standard" rather than "PAPR
> > standard" presentation, I'm not as confident about it as I would like.
> >=20
> > Another consideration here is that other PCIe capable qemu emulated
> > devices, such as XHCI, will present fine as PCIe integrated endpoints
> > when attached to the root bus.  Libvirt won't do that usually, of
> > course, and it may not be the recommended way of doing things (on PC)
> > but it's possible.  I don't see any particular reason that virtio-pci
> > should enforce the root port requirement more so than any other
> > device.
> >=20
> >> On 02/08/17 07:16, David Gibson wrote:
> >>>
> >>> pcie_endpoint_cap_init() already automatically adjusts to advertise as
> >>> an integrated device rather than a "normal" PCIe endpoint when attach=
ed to
> >>> a root bus.  So we can remove the check for root bus within virtio and
> >>> allow (at the user's discretion) a PCIe virtio bus to be attached to a
> >>> root bus.
> >>
> >> If Marcel thinks this is a good change, then I think we should go
> >> through "docs/pcie.txt" with a fine-toothed comb, and update all
> >> relevant spots. (If Marcel agrees, perhaps you can include such
> >> hunks in your patch at once.)
> >=20
> > Actually, I think that would be a neverending process.  Maybe better
> > to put in a whole different spapr-pcie.txt with the assorted ways that
> > PAPR violates PCIe conventions.
>=20
> That works for me too, but I think it would be a lot more work for you
> and others.
>=20
> I plan on consulting "docs/pcie.txt" frequently; among other things, for
> deciding debates. Thus, improving the scope of "docs/pcie.txt" is very
> welcome IMO.
>=20
> >=20
> >> It also may have consequences for libvirt (but I see you addressed
> >> Andrea at once, which is great).
> >=20
> > Right, I've been discussed this with Andrea all along.  We're working
> > on a proposed PAPR specific way of allocating PCI and PCIe addresses
> > (different from the PCIe normal way, but the same as each other).
> > That will simplify adding PCIe support to PAPR, and also has some
> > other advantages for PAPR guests (related to the platform specific
> > isolation, hotplug  and error recovery mechanisms - also different
> > from the normal PCIe ones).
>=20
> Great, if Andrea is aware, that's a relief.
>=20
> Can you resubmit this patch with a small hunk for "docs/pcie.txt" that
> removes PAPR from the scope?

Well, first I'd like to see if Marcel knows of some reason I didn't
think of why this test is important for virtio particularly here.  But
assuming the basic idea is acceptable, then yes, I'll update pcie.txt.

> A short list of actual machine types would
> be appreciated too, if that makes sense. (By default we aim at
> multi-arch / multi-target with this document; we may not have stated it
> explicitly, but AFAIR we intend to cover aarch64 / "virt" too.)

Right, that was my understanding as well.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wqJr86X7F8PBspU2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnQtaAAoJEGw4ysog2bOSlC4P/0bX066e9NzWmhekMbkzkTxC
Nrem0rrUTn16MSYrUufGG658GYS4DJ3bxLr1idXQ9lBRa9CapJ6dTFbTIHBgDiLN
ntxw+oURFkqAHw03G0G5YkvlsajqOzKRGCiGkrmvwWa6KPCI67MzuN2+/jZSXOvO
GpanSsTl3IRh6u5di/pdvBV9MOHAiSPMMv7WYzpUnOYuRhW2Z6ZkDBXnW1SRWs+f
xFH9FdwjWXI5X0k1blPuuldRNraQAWqREcOS6G2/BeP28aoINS2LhTVOxGMUTlCk
AkfAEyiaxZWixqMFseqRNJZzrJkzelLImZ/IZOT+vXods4FlGhBt6G7QShWEc6+X
o8cM4343swqJwqM5PYb/EizyS7EJg2RPo29AWafEtjo1sEqY/fSWzIv5NuFLeDV+
dYUm52Ln86sATOn8WVoUyb2TaNx6n/gToWoIqko9q7M2Dq7+3nilf3VgivFAu+Tm
9qpoSf08dRsHkQ8aSPDWaqiHOioL8v9cHxrDt2b9j+ibXAdscJ15HFBvm+N9oRFF
sou1cAMAz5dVzCWVYblcGJpbhXOnJgj7IbS1LLRihNbR4jlGbT1NAX7nnUIvGPeH
iQBC3Q7gMwZsoNO4Ynt2sn390xZMFTHiVE7BxlWZXVmMC82cCGJCSeT2xUpw8g1v
w+0DNS+W/wv8Lnj1Qn5N
=EaaY
-----END PGP SIGNATURE-----

--wqJr86X7F8PBspU2--
