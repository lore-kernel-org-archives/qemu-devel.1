Received: from eggs.gnu.org ([2001:4830:134:3::10]:40532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1elTLT-0005cE-3M
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 00:41:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1elTLR-00029v-PA
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 00:41:35 -0500
Date: Tue, 13 Feb 2018 16:41:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180213054124.GN11634@umbus.fritz.box>
References: <20180209075503.16996-1-aik@ozlabs.ru>
	<20180209075503.16996-3-aik@ozlabs.ru>
	<20180212051954.GE11634@umbus.fritz.box>
	<0a57f0ec-4300-f4f3-3957-4bced8b57e14@ozlabs.ru>
	<20180212090653.42bdd2e2@w520.home>
	<0c594a0b-488c-b5f8-e8ed-ffa8f4a98088@ozlabs.ru>
	<20180213053630.GL11634@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kY0AMSsGPnDJoAXR"
Content-Disposition: inline
In-Reply-To: <20180213053630.GL11634@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH qemu v7 2/4] vfio/pci: Relax DMA map errors
 for MMIO regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--kY0AMSsGPnDJoAXR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2018 at 04:36:30PM +1100, David Gibson wrote:
> On Tue, Feb 13, 2018 at 12:15:52PM +1100, Alexey Kardashevskiy wrote:
> > On 13/02/18 03:06, Alex Williamson wrote:
> > > On Mon, 12 Feb 2018 18:05:54 +1100
> > > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> > >=20
> > >> On 12/02/18 16:19, David Gibson wrote:
> > >>> On Fri, Feb 09, 2018 at 06:55:01PM +1100, Alexey Kardashevskiy wrot=
e: =20
> > >>>> At the moment if vfio_memory_listener is registered in the system =
memory
> > >>>> address space, it maps/unmaps every RAM memory region for DMA.
> > >>>> It expects system page size aligned memory sections so vfio_dma_map
> > >>>> would not fail and so far this has been the case. A mapping failure
> > >>>> would be fatal. A side effect of such behavior is that some MMIO p=
ages
> > >>>> would not be mapped silently.
> > >>>>
> > >>>> However we are going to change MSIX BAR handling so we will end ha=
ving
> > >>>> non-aligned sections in vfio_memory_listener (more details is in
> > >>>> the next patch) and vfio_dma_map will exit QEMU.
> > >>>>
> > >>>> In order to avoid fatal failures on what previously was not a fail=
ure and
> > >>>> was just silently ignored, this checks the section alignment to
> > >>>> the smallest supported IOMMU page size and prints an error if not =
aligned;
> > >>>> it also prints an error if vfio_dma_map failed despite the page si=
ze check.
> > >>>> Both errors are not fatal; only MMIO RAM regions are checked
> > >>>> (aka "RAM device" regions).
> > >>>>
> > >>>> If the amount of errors printed is overwhelming, the MSIX relocati=
on
> > >>>> could be used to avoid excessive error output.
> > >>>>
> > >>>> This is unlikely to cause any behavioral change.
> > >>>>
> > >>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru> =20
> > >>>
> > >>> There are some relatively superficial problems noted below.
> > >>>
> > >>> But more fundamentally, this feels like it's extending an existing
> > >>> hack past the point of usefulness.
> > >>>
> > >>> The explicit check for is_ram_device() here has always bothered me -
> > >>> it's not like a real bus bridge magically knows whether a target
> > >>> address maps to RAM or not.
> > >>>
> > >>> What I think is really going on is that even for systems without an
> > >>> IOMMU, it's not really true to say that the PCI address space maps
> > >>> directly onto address_space_memory.  Instead, there's a large, but
> > >>> much less than 2^64 sized, "upstream window" at address 0 on the PCI
> > >>> bus, which is identity mapped to the system bus.  Details will vary
> > >>> with the system, but in practice we expect nothing but RAM to be in
> > >>> that window.  Addresses not within that window won't be mapped to t=
he
> > >>> system bus but will just be broadcast on the PCI bus and might be
> > >>> picked up as a p2p transaction. =20
> > >>
> > >> Currently this p2p works only via the IOMMU, direct p2p is not possi=
ble as
> > >> the guest needs to know physical MMIO addresses to make p2p work and=
 it
> > >> does not.
> > >=20
> > > /me points to the Direct Translated P2P section of the ACS spec, thou=
gh
> > > it's as prone to spoofing by the device as ATS.  In any case, p2p
> > > reflected from the IOMMU is still p2p and offloads the CPU even if
> > > bandwidth suffers vs bare metal depending on if the data doubles back
> > > over any links.  Thanks,
> >=20
> > Sure, I was just saying that p2p via IOMMU won't be as simple as broadc=
ast
> > on the PCI bus, IOMMU needs to be programmed in advance to make this wo=
rk,
> > and current that broadcast won't work for the passed through devices.
>=20
> Well, sure, p2p in a guest with passthrough devices clearly needs to
> be translated through the IOMMU (and p2p from a passthrough to an
> emulated device is essentially impossible).
>=20
> But.. what does that have to do with this code.  This is the memory
> area watcher, looking for memory regions being mapped directly into
> the PCI space.  NOT IOMMU regions, since those are handled separately
> by wiring up the IOMMU notifier.  This will only trigger if RAM-like,
> non-RAM regions are put into PCI space *not* behind an IOMMMU.

Duh, sorry, realised I was mixing up host and guest IOMMU.  I guess
the point here is that this will map RAM-like devices into the host
IOMMU when there is no guest IOMMU, allowing p2p transactions between
passthrough devices (though not from passthrough to emulated devices).

The conditions still seem kind of awkward to me, but I guess it makes
sense.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kY0AMSsGPnDJoAXR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqCeoQACgkQbDjKyiDZ
s5LKqRAAiInKEROAuef1Jtg1BuhA2Oq0+QQp/WFgAKYaVGif9KXF7xqEU1oeCDY+
VTCATHp6b+vAZ3IR1VW2q9B6VS69byuHdu1xBuvjZuWcrlyZCSVPyTkSnt4PCuX7
VCr8T+YnW+MrlKBq8CjSsamepFzQyGKeMzETY7GyIj99wQt1g6gjC/WQu3MH+T1W
CYnsspph0VnrzR4Ixgew6goPn+TVD5JqCClcSc0Xp+kbHKfSwMU9gRVccdsHcGPb
PYIUaWtgtEfqlr2W2x+Y+D7+t1Hk5gfyKx+1DBk+2CpAe+/Gz0qZrthLqWuZNdJa
gkBd1ucd9gi9uNqLOXRKgx8Q5X79qAiRMo9/PaFogHJs4xctvbrSOtNAzDHd9KH+
ZqnlU0ovhSdW5R2/4vdtUK0JiiDvcG4wQsW8iOH5nU9pf2w1jXmKz64CvfnlEcW6
td6niFs0yX5bYSmlzroOxlDu9xUyJMUYfHATbJ9GYsNEL2zXNxAEjqDcmR16AuOB
51kX/OiCUs2wfrsnAVrVm2yreVw0Zkb8dq71WmB2NEqottmNuxxpwNvzuqZ/PYrc
K2Z74rdnxnot1lYXzpIq+uItZWmb932es+l6pGDvnn60IGCyi7Kr5kjb6nZd9g4P
9TiZDEoBMUDRDp/x6EQrErmCeq6jMIX5eQSa/BEhnT/w47L+6E4=
=QvwB
-----END PGP SIGNATURE-----

--kY0AMSsGPnDJoAXR--
