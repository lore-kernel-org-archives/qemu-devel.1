Received: from eggs.gnu.org ([2001:4830:134:3::10]:35364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emZ0a-0001yN-R8
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 00:56:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emZ0X-0007bC-M0
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 00:56:32 -0500
Date: Fri, 16 Feb 2018 16:28:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180216052824.GI2074@umbus.fritz.box>
References: <20180212051954.GE11634@umbus.fritz.box>
	<0a57f0ec-4300-f4f3-3957-4bced8b57e14@ozlabs.ru>
	<20180212090653.42bdd2e2@w520.home>
	<0c594a0b-488c-b5f8-e8ed-ffa8f4a98088@ozlabs.ru>
	<20180213053630.GL11634@umbus.fritz.box>
	<20180213054124.GN11634@umbus.fritz.box>
	<8282d070-b2d3-7e43-3da9-b17c77b99a67@ozlabs.ru>
	<20180214013323.GA5247@umbus.fritz.box>
	<843efd62-7a39-8536-91ad-1abea2beb190@ozlabs.ru>
	<20180214085541.5491705f@w520.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Xssso5lpTBgMxDfe"
Content-Disposition: inline
In-Reply-To: <20180214085541.5491705f@w520.home>
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
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--Xssso5lpTBgMxDfe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2018 at 08:55:41AM -0700, Alex Williamson wrote:
> On Wed, 14 Feb 2018 19:09:16 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>=20
> > On 14/02/18 12:33, David Gibson wrote:
> > > On Tue, Feb 13, 2018 at 07:20:56PM +1100, Alexey Kardashevskiy wrote:=
 =20
> > >> On 13/02/18 16:41, David Gibson wrote: =20
> > >>> On Tue, Feb 13, 2018 at 04:36:30PM +1100, David Gibson wrote: =20
> > >>>> On Tue, Feb 13, 2018 at 12:15:52PM +1100, Alexey Kardashevskiy wro=
te: =20
> > >>>>> On 13/02/18 03:06, Alex Williamson wrote: =20
> > >>>>>> On Mon, 12 Feb 2018 18:05:54 +1100
> > >>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> > >>>>>> =20
> > >>>>>>> On 12/02/18 16:19, David Gibson wrote: =20
> > >>>>>>>> On Fri, Feb 09, 2018 at 06:55:01PM +1100, Alexey Kardashevskiy=
 wrote:   =20
> > >>>>>>>>> At the moment if vfio_memory_listener is registered in the sy=
stem memory
> > >>>>>>>>> address space, it maps/unmaps every RAM memory region for DMA.
> > >>>>>>>>> It expects system page size aligned memory sections so vfio_d=
ma_map
> > >>>>>>>>> would not fail and so far this has been the case. A mapping f=
ailure
> > >>>>>>>>> would be fatal. A side effect of such behavior is that some M=
MIO pages
> > >>>>>>>>> would not be mapped silently.
> > >>>>>>>>>
> > >>>>>>>>> However we are going to change MSIX BAR handling so we will e=
nd having
> > >>>>>>>>> non-aligned sections in vfio_memory_listener (more details is=
 in
> > >>>>>>>>> the next patch) and vfio_dma_map will exit QEMU.
> > >>>>>>>>>
> > >>>>>>>>> In order to avoid fatal failures on what previously was not a=
 failure and
> > >>>>>>>>> was just silently ignored, this checks the section alignment =
to
> > >>>>>>>>> the smallest supported IOMMU page size and prints an error if=
 not aligned;
> > >>>>>>>>> it also prints an error if vfio_dma_map failed despite the pa=
ge size check.
> > >>>>>>>>> Both errors are not fatal; only MMIO RAM regions are checked
> > >>>>>>>>> (aka "RAM device" regions).
> > >>>>>>>>>
> > >>>>>>>>> If the amount of errors printed is overwhelming, the MSIX rel=
ocation
> > >>>>>>>>> could be used to avoid excessive error output.
> > >>>>>>>>>
> > >>>>>>>>> This is unlikely to cause any behavioral change.
> > >>>>>>>>>
> > >>>>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>   =20
> > >>>>>>>>
> > >>>>>>>> There are some relatively superficial problems noted below.
> > >>>>>>>>
> > >>>>>>>> But more fundamentally, this feels like it's extending an exis=
ting
> > >>>>>>>> hack past the point of usefulness.
> > >>>>>>>>
> > >>>>>>>> The explicit check for is_ram_device() here has always bothere=
d me -
> > >>>>>>>> it's not like a real bus bridge magically knows whether a targ=
et
> > >>>>>>>> address maps to RAM or not.
> > >>>>>>>>
> > >>>>>>>> What I think is really going on is that even for systems witho=
ut an
> > >>>>>>>> IOMMU, it's not really true to say that the PCI address space =
maps
> > >>>>>>>> directly onto address_space_memory.  Instead, there's a large,=
 but
> > >>>>>>>> much less than 2^64 sized, "upstream window" at address 0 on t=
he PCI
> > >>>>>>>> bus, which is identity mapped to the system bus.  Details will=
 vary
> > >>>>>>>> with the system, but in practice we expect nothing but RAM to =
be in
> > >>>>>>>> that window.  Addresses not within that window won't be mapped=
 to the
> > >>>>>>>> system bus but will just be broadcast on the PCI bus and might=
 be
> > >>>>>>>> picked up as a p2p transaction.   =20
> > >>>>>>>
> > >>>>>>> Currently this p2p works only via the IOMMU, direct p2p is not =
possible as
> > >>>>>>> the guest needs to know physical MMIO addresses to make p2p wor=
k and it
> > >>>>>>> does not. =20
> > >>>>>>
> > >>>>>> /me points to the Direct Translated P2P section of the ACS spec,=
 though
> > >>>>>> it's as prone to spoofing by the device as ATS.  In any case, p2p
> > >>>>>> reflected from the IOMMU is still p2p and offloads the CPU even =
if
> > >>>>>> bandwidth suffers vs bare metal depending on if the data doubles=
 back
> > >>>>>> over any links.  Thanks, =20
> > >>>>>
> > >>>>> Sure, I was just saying that p2p via IOMMU won't be as simple as =
broadcast
> > >>>>> on the PCI bus, IOMMU needs to be programmed in advance to make t=
his work,
> > >>>>> and current that broadcast won't work for the passed through devi=
ces. =20
> > >>>>
> > >>>> Well, sure, p2p in a guest with passthrough devices clearly needs =
to
> > >>>> be translated through the IOMMU (and p2p from a passthrough to an
> > >>>> emulated device is essentially impossible).
> > >>>>
> > >>>> But.. what does that have to do with this code.  This is the memory
> > >>>> area watcher, looking for memory regions being mapped directly into
> > >>>> the PCI space.  NOT IOMMU regions, since those are handled separat=
ely
> > >>>> by wiring up the IOMMU notifier.  This will only trigger if RAM-li=
ke,
> > >>>> non-RAM regions are put into PCI space *not* behind an IOMMMU. =20
> > >>>
> > >>> Duh, sorry, realised I was mixing up host and guest IOMMU.  I guess
> > >>> the point here is that this will map RAM-like devices into the host
> > >>> IOMMU when there is no guest IOMMU, allowing p2p transactions betwe=
en
> > >>> passthrough devices (though not from passthrough to emulated device=
s). =20
> > >>
> > >> Correct.
> > >> =20
> > >>>
> > >>> The conditions still seem kind of awkward to me, but I guess it mak=
es
> > >>> sense. =20
> > >>
> > >> Is it the time to split this listener to RAM-listener and PCI bus li=
stener? =20
> > >=20
> > > I'm not really sure what you mean by that.
> > >  =20
> > >> On x86 it listens on the "memory" AS, on spapr - on the
> > >> "pci@800000020000000" AS, this will just create more confusion over =
time... =20
> > >=20
> > > Hm, it's still logically the same AS in each case - the PCI address
> > > space.  It's just that in the x86 case that happens to be the same as
> > > the memory AS (at least when there isn't a guest side IOMMU). =20
> >=20
> > Hm. Ok.
> >=20
> > > I do wonder if that's really right even for x86 without IOMMU.  The
> > > PCI address space is identity mapped to the "main" memory address
> > > space there, but I'm not sure it's mapped th *all* of the main memory=
 =20
> >=20
> > What should have been in the place of "th" above? :)
> >=20
> > > address space, probably just certain ranges of it.  That's what I was
> > > suggesting earlier in the thread. =20
> >=20
> > afaict vfio is trying to mmap every RAM MR =3D=3D KVM memory slot, no r=
anges or
> > anything like that. I am trying to figure out what is not correct with =
the
> > patch. Thanks,
>=20
> It is possible for x86 systems to have translation applied to MMIO vs
> RAM such that the processor view and device view of MMIO are different,
> putting them into separate address spaces, but this is not typical and
> not available on the class of chipsets that QEMU emulates for PC.
> Therefore I think it's correct that MMIO and RAM all live in one big
> happy, flat address space as they do now (assuming the guest IOMMU is
> not present or disabled).  Thanks,

Ah.. I think the thing I was missing is that on PC (at least with
typical chipsets) *all* MMIO essentially comes from PCI space.  Even
the legacy devices are essentially ISA which is treated as being on a
bridge under the PCI space.  On non-x86 there are often at least a
handful of MMIO devices that aren't within the PCI space - say, the
PCI host bridge itself at least.  x86 avoids that by using the
separate IO space, which is also a bit weird in that it's
simultaneously direct attached to the cpu (and so doesn't need bridge
configuration), but also identified with the legay IO space treated as
being under two bridges (host->PCI, PCI->ISA) for other purposes.

Maybe it's just me, but I find it makes more sense to me if I think of
it as the two ASes being equal because on PC the system address map
(address_space_memory) is made equal to the PCI address map, rather
than the PCI address map being made equal to the system one.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Xssso5lpTBgMxDfe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqGa/UACgkQbDjKyiDZ
s5I4+A/+IiFgFD00wMmlpApzxEHYmJEj8NdOhBEOLcFa7eUFZIxDnBU8aV2q+VDB
Gz9PJ+xDPGmvbbwPdg6LfTB55t2WMD3KES86VMzjbUy68HYG1lWnmnSY5mfugGs8
vPPgk+qva26RBhcEIOPC9Nnm8vlU0iHSz5sf+YuWdOhK2FR/rvFK/MgH006U6R2L
f4feRk5rT7/9lCfg1OskPCNP/w6JquEGlbqYXsV/rQ3dXbOY9DkkM+jH8ol3IkV7
ORGinhZm3RIg7FNqKIB/LyBkRIymDBWOCtVDoguJdIB+j/XR37flFF3G0UH7MMge
7BAVLxS8D2YXqNWnXqcTyESU32pSSnDX4G5393KdVlXt/OYq6SEVXKOsfDdmL5FW
aK8uxxKBOF2pKgwG2spfq7yYQGAvY2e5HqqElaapHw7U1QfRrs7iyQGuMFu5RknT
VKbbqNfZOQo74SOoO0toTymcP1AO8OQk84rcPpSYSRz+YKyFaLWqtL55eKS9LqVs
6owXh3pEWdI2zOkFCzspD0LPVnHJcQhJiPT24SYW2//vkUCgjlVgOwml7KNYdODP
0LdhdD+rBzgWkznSe5EjnCChgH0vrHX4cF3NGjfxBxF83vl33N59vb1fjOEeZpJ9
qHYtism8xTWA7WfsFvXe85+o5ptHtmD7Uyd3f6RwKGkVa+9EV+s=
=EZvg
-----END PGP SIGNATURE-----

--Xssso5lpTBgMxDfe--
