Received: from eggs.gnu.org ([2001:4830:134:3::10]:39687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1elTGs-0002KO-8x
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 00:36:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1elTGq-0000aA-6M
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 00:36:49 -0500
Date: Tue, 13 Feb 2018 16:36:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180213053630.GL11634@umbus.fritz.box>
References: <20180209075503.16996-1-aik@ozlabs.ru>
	<20180209075503.16996-3-aik@ozlabs.ru>
	<20180212051954.GE11634@umbus.fritz.box>
	<0a57f0ec-4300-f4f3-3957-4bced8b57e14@ozlabs.ru>
	<20180212090653.42bdd2e2@w520.home>
	<0c594a0b-488c-b5f8-e8ed-ffa8f4a98088@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qx89ETaB+CVBQ6X0"
Content-Disposition: inline
In-Reply-To: <0c594a0b-488c-b5f8-e8ed-ffa8f4a98088@ozlabs.ru>
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


--Qx89ETaB+CVBQ6X0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2018 at 12:15:52PM +1100, Alexey Kardashevskiy wrote:
> On 13/02/18 03:06, Alex Williamson wrote:
> > On Mon, 12 Feb 2018 18:05:54 +1100
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >=20
> >> On 12/02/18 16:19, David Gibson wrote:
> >>> On Fri, Feb 09, 2018 at 06:55:01PM +1100, Alexey Kardashevskiy wrote:=
 =20
> >>>> At the moment if vfio_memory_listener is registered in the system me=
mory
> >>>> address space, it maps/unmaps every RAM memory region for DMA.
> >>>> It expects system page size aligned memory sections so vfio_dma_map
> >>>> would not fail and so far this has been the case. A mapping failure
> >>>> would be fatal. A side effect of such behavior is that some MMIO pag=
es
> >>>> would not be mapped silently.
> >>>>
> >>>> However we are going to change MSIX BAR handling so we will end havi=
ng
> >>>> non-aligned sections in vfio_memory_listener (more details is in
> >>>> the next patch) and vfio_dma_map will exit QEMU.
> >>>>
> >>>> In order to avoid fatal failures on what previously was not a failur=
e and
> >>>> was just silently ignored, this checks the section alignment to
> >>>> the smallest supported IOMMU page size and prints an error if not al=
igned;
> >>>> it also prints an error if vfio_dma_map failed despite the page size=
 check.
> >>>> Both errors are not fatal; only MMIO RAM regions are checked
> >>>> (aka "RAM device" regions).
> >>>>
> >>>> If the amount of errors printed is overwhelming, the MSIX relocation
> >>>> could be used to avoid excessive error output.
> >>>>
> >>>> This is unlikely to cause any behavioral change.
> >>>>
> >>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru> =20
> >>>
> >>> There are some relatively superficial problems noted below.
> >>>
> >>> But more fundamentally, this feels like it's extending an existing
> >>> hack past the point of usefulness.
> >>>
> >>> The explicit check for is_ram_device() here has always bothered me -
> >>> it's not like a real bus bridge magically knows whether a target
> >>> address maps to RAM or not.
> >>>
> >>> What I think is really going on is that even for systems without an
> >>> IOMMU, it's not really true to say that the PCI address space maps
> >>> directly onto address_space_memory.  Instead, there's a large, but
> >>> much less than 2^64 sized, "upstream window" at address 0 on the PCI
> >>> bus, which is identity mapped to the system bus.  Details will vary
> >>> with the system, but in practice we expect nothing but RAM to be in
> >>> that window.  Addresses not within that window won't be mapped to the
> >>> system bus but will just be broadcast on the PCI bus and might be
> >>> picked up as a p2p transaction. =20
> >>
> >> Currently this p2p works only via the IOMMU, direct p2p is not possibl=
e as
> >> the guest needs to know physical MMIO addresses to make p2p work and it
> >> does not.
> >=20
> > /me points to the Direct Translated P2P section of the ACS spec, though
> > it's as prone to spoofing by the device as ATS.  In any case, p2p
> > reflected from the IOMMU is still p2p and offloads the CPU even if
> > bandwidth suffers vs bare metal depending on if the data doubles back
> > over any links.  Thanks,
>=20
> Sure, I was just saying that p2p via IOMMU won't be as simple as broadcast
> on the PCI bus, IOMMU needs to be programmed in advance to make this work,
> and current that broadcast won't work for the passed through devices.

Well, sure, p2p in a guest with passthrough devices clearly needs to
be translated through the IOMMU (and p2p from a passthrough to an
emulated device is essentially impossible).

But.. what does that have to do with this code.  This is the memory
area watcher, looking for memory regions being mapped directly into
the PCI space.  NOT IOMMU regions, since those are handled separately
by wiring up the IOMMU notifier.  This will only trigger if RAM-like,
non-RAM regions are put into PCI space *not* behind an IOMMMU.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Qx89ETaB+CVBQ6X0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqCeVwACgkQbDjKyiDZ
s5LgTBAA56Cyp/cFLJer81ZP5kvVxksx3cML961V3e7dp7F6K1fq877I2GU9I2Uh
DppK3vHJCvwBUWISMjDujLSqtMzgDvhP1YC+9D3C8v7F2m1ZfrHX1Nwti3Y8eBpe
qf1lqOXgqVo77Eoy/kVoITmI4vifKvDFkVVP8MtrY/yrG23TiM8XFV2i7oFif8y4
+YPymwfiSwTOXEwYfAgBO8fNOcXDXny31NtyPv7b+fQVhH22zWxbaq15nWT7mfZt
dFQ1VqN6yRbpMJ4WDFjn4vGRL9Jj+TNd+vSWdN3pui4/wzhawaIqVCMvPYumttkR
3S5deieuwpd6CGxFdIx8oQ+WN09jRRDBMgEhucYl3jnHRAXwOcJW8jmCP/uXDeOv
seBDssMOUmdWeQyjKdWcevwkinTQXb6uv8ye1h+/3MIK5c3iN1jjA4L8mZuaV5b5
Kvzi7GVIoVUY9xSgMKh1NkJfLClC7uUcaaFDQubuT1yMwV+jXekcnRiLKKK2w6aL
COQt4JxkwryJp5e1YujTY/vZoEztj8v8xWwdyDulCwa5YJnbm20TCb//VOA7Ps/v
XM0BwqQ05Q/70G1Lfa9PEPmMTce6l4v1k5Q4po9Iw3zcMiOzqnmnXFtV9MPGFTjL
HOkZYpV/zTBk41VMm5f5G7A2pvR1Z1IczudWCJY72uvHAQxfeEc=
=r5mm
-----END PGP SIGNATURE-----

--Qx89ETaB+CVBQ6X0--
