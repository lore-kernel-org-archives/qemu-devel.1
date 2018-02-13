Received: from eggs.gnu.org ([2001:4830:134:3::10]:37806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1elVps-0006WE-CB
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 03:21:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1elVpp-0004mN-6w
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 03:21:08 -0500
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:40506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1elVpo-0004lw-S6
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 03:21:05 -0500
Received: by mail-ot0-x22a.google.com with SMTP id s4so16540465oth.7
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 00:21:04 -0800 (PST)
References: <20180209075503.16996-1-aik@ozlabs.ru>
	<20180209075503.16996-3-aik@ozlabs.ru>
	<20180212051954.GE11634@umbus.fritz.box>
	<0a57f0ec-4300-f4f3-3957-4bced8b57e14@ozlabs.ru>
	<20180212090653.42bdd2e2@w520.home>
	<0c594a0b-488c-b5f8-e8ed-ffa8f4a98088@ozlabs.ru>
	<20180213053630.GL11634@umbus.fritz.box>
	<20180213054124.GN11634@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <8282d070-b2d3-7e43-3da9-b17c77b99a67@ozlabs.ru>
Date: Tue, 13 Feb 2018 19:20:56 +1100
MIME-Version: 1.0
In-Reply-To: <20180213054124.GN11634@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="yGlW27qbHoKuPAwV6gylMMqoixLroGBKs"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yGlW27qbHoKuPAwV6gylMMqoixLroGBKs
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Message-ID: <8282d070-b2d3-7e43-3da9-b17c77b99a67@ozlabs.ru>
Subject: Re: [PATCH qemu v7 2/4] vfio/pci: Relax DMA map errors for MMIO
 regions
References: <20180209075503.16996-1-aik@ozlabs.ru>
 <20180209075503.16996-3-aik@ozlabs.ru>
 <20180212051954.GE11634@umbus.fritz.box>
 <0a57f0ec-4300-f4f3-3957-4bced8b57e14@ozlabs.ru>
 <20180212090653.42bdd2e2@w520.home>
 <0c594a0b-488c-b5f8-e8ed-ffa8f4a98088@ozlabs.ru>
 <20180213053630.GL11634@umbus.fritz.box>
 <20180213054124.GN11634@umbus.fritz.box>
In-Reply-To: <20180213054124.GN11634@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13/02/18 16:41, David Gibson wrote:
> On Tue, Feb 13, 2018 at 04:36:30PM +1100, David Gibson wrote:
>> On Tue, Feb 13, 2018 at 12:15:52PM +1100, Alexey Kardashevskiy wrote:
>>> On 13/02/18 03:06, Alex Williamson wrote:
>>>> On Mon, 12 Feb 2018 18:05:54 +1100
>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>
>>>>> On 12/02/18 16:19, David Gibson wrote:
>>>>>> On Fri, Feb 09, 2018 at 06:55:01PM +1100, Alexey Kardashevskiy wro=
te: =20
>>>>>>> At the moment if vfio_memory_listener is registered in the system=
 memory
>>>>>>> address space, it maps/unmaps every RAM memory region for DMA.
>>>>>>> It expects system page size aligned memory sections so vfio_dma_m=
ap
>>>>>>> would not fail and so far this has been the case. A mapping failu=
re
>>>>>>> would be fatal. A side effect of such behavior is that some MMIO =
pages
>>>>>>> would not be mapped silently.
>>>>>>>
>>>>>>> However we are going to change MSIX BAR handling so we will end h=
aving
>>>>>>> non-aligned sections in vfio_memory_listener (more details is in
>>>>>>> the next patch) and vfio_dma_map will exit QEMU.
>>>>>>>
>>>>>>> In order to avoid fatal failures on what previously was not a fai=
lure and
>>>>>>> was just silently ignored, this checks the section alignment to
>>>>>>> the smallest supported IOMMU page size and prints an error if not=
 aligned;
>>>>>>> it also prints an error if vfio_dma_map failed despite the page s=
ize check.
>>>>>>> Both errors are not fatal; only MMIO RAM regions are checked
>>>>>>> (aka "RAM device" regions).
>>>>>>>
>>>>>>> If the amount of errors printed is overwhelming, the MSIX relocat=
ion
>>>>>>> could be used to avoid excessive error output.
>>>>>>>
>>>>>>> This is unlikely to cause any behavioral change.
>>>>>>>
>>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru> =20
>>>>>>
>>>>>> There are some relatively superficial problems noted below.
>>>>>>
>>>>>> But more fundamentally, this feels like it's extending an existing=

>>>>>> hack past the point of usefulness.
>>>>>>
>>>>>> The explicit check for is_ram_device() here has always bothered me=
 -
>>>>>> it's not like a real bus bridge magically knows whether a target
>>>>>> address maps to RAM or not.
>>>>>>
>>>>>> What I think is really going on is that even for systems without a=
n
>>>>>> IOMMU, it's not really true to say that the PCI address space maps=

>>>>>> directly onto address_space_memory.  Instead, there's a large, but=

>>>>>> much less than 2^64 sized, "upstream window" at address 0 on the P=
CI
>>>>>> bus, which is identity mapped to the system bus.  Details will var=
y
>>>>>> with the system, but in practice we expect nothing but RAM to be i=
n
>>>>>> that window.  Addresses not within that window won't be mapped to =
the
>>>>>> system bus but will just be broadcast on the PCI bus and might be
>>>>>> picked up as a p2p transaction. =20
>>>>>
>>>>> Currently this p2p works only via the IOMMU, direct p2p is not poss=
ible as
>>>>> the guest needs to know physical MMIO addresses to make p2p work an=
d it
>>>>> does not.
>>>>
>>>> /me points to the Direct Translated P2P section of the ACS spec, tho=
ugh
>>>> it's as prone to spoofing by the device as ATS.  In any case, p2p
>>>> reflected from the IOMMU is still p2p and offloads the CPU even if
>>>> bandwidth suffers vs bare metal depending on if the data doubles bac=
k
>>>> over any links.  Thanks,
>>>
>>> Sure, I was just saying that p2p via IOMMU won't be as simple as broa=
dcast
>>> on the PCI bus, IOMMU needs to be programmed in advance to make this =
work,
>>> and current that broadcast won't work for the passed through devices.=

>>
>> Well, sure, p2p in a guest with passthrough devices clearly needs to
>> be translated through the IOMMU (and p2p from a passthrough to an
>> emulated device is essentially impossible).
>>
>> But.. what does that have to do with this code.  This is the memory
>> area watcher, looking for memory regions being mapped directly into
>> the PCI space.  NOT IOMMU regions, since those are handled separately
>> by wiring up the IOMMU notifier.  This will only trigger if RAM-like,
>> non-RAM regions are put into PCI space *not* behind an IOMMMU.
>=20
> Duh, sorry, realised I was mixing up host and guest IOMMU.  I guess
> the point here is that this will map RAM-like devices into the host
> IOMMU when there is no guest IOMMU, allowing p2p transactions between
> passthrough devices (though not from passthrough to emulated devices).

Correct.

>=20
> The conditions still seem kind of awkward to me, but I guess it makes
> sense.

Is it the time to split this listener to RAM-listener and PCI bus listene=
r?

On x86 it listens on the "memory" AS, on spapr - on the
"pci@800000020000000" AS, this will just create more confusion over time.=
=2E.



--=20
Alexey


--yGlW27qbHoKuPAwV6gylMMqoixLroGBKs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEZSrPibrORRTHQ99dhhM92CvBILkFAlqCn+gOHGFpa0Bvemxh
YnMucnUACgkQhhM92CvBILkiog/+OCvikPbL9buK4F7l9X0Z+/ik0U3wIpgWuS2v
R2OqhnhrCOxGJ0DWcA1PhZBXZxTIRepV4CLyufJ7EKnuppWuXpfYqguxRSOJLk5M
6+KtXijzzHGxhrW554liL5PLIP6t8+GMjkjgjntnFxAEIwHgbkidkWDbfT5qVGeb
xpQ1FL/LudA3bFtMCPh/H3onqVliWbpvNP2x5bwFBzZVfR+49UUJFG4Vpjyi4Rbv
xMoiJqc636cUxJ8KRLHXyeVQzgogw3+WHsFCad7B3+m0//yUVcb2CFLOhVZA9FXw
nusnFEX+5zCQk6ZUoIUL3u0jdCXjOHlcw59Z2Ovx0aqHIJUM37s4TqkO/hXbvfaZ
X0/iAEeOK50MDQbYJTbKdFADreChEnAmdFRof7SyQLEoQJKJqAaXTnAPP5KbonbN
V1el4eerscpCfqeP4e7vKbU/BPRojlcc1/07gf00XPpxQDzPE/fH2ka3c70NeVZT
T8zKgji3BGFYp0ZKtHhRdJ4B07UtqvJ/ksJBaukCzD+Dtor53HsgpLgvrvlJWlck
Kbeyd7HSNycQBW3a+BQhZfG+pWFdXnWDy/4c6QN9V+dCi3zoKIeoaXMik3V14DdB
vW8zk5v26WUxSpbRfOdiPswkB1bFi4tBX7GLuipgA+3xoZqJY6aRZS+yPx5Sc80b
T6Async=
=wKM1
-----END PGP SIGNATURE-----

--yGlW27qbHoKuPAwV6gylMMqoixLroGBKs--
