Received: from eggs.gnu.org ([2001:4830:134:3::10]:46996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1evnUl-0007C5-GC
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1evnUi-0000jO-3m
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:13:51 -0400
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
	<20180216052824.GI2074@umbus.fritz.box>
	<c11af933-3f08-f2c8-0552-ce43ac8f5741@ozlabs.ru>
	<a29658e8-d2da-161d-d9b8-41f186969927@ozlabs.ru>
	<821596dc-35b0-60cf-3e1f-3df0809b2f8e@ozlabs.ru>
	<8e909bd8-2c24-abde-aa42-fd3f46ff649e@ozlabs.ru>
	<20180313105606.18d0d8af@w520.home>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <f081b19e-b80d-b889-e916-ad0e361c9512@redhat.com>
Date: Tue, 13 Mar 2018 18:13:41 +0100
MIME-Version: 1.0
In-Reply-To: <20180313105606.18d0d8af@w520.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Alex Williamson <alex.williamson@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

Hi Alex,

On 13/03/18 17:56, Alex Williamson wrote:
> [Cc +Eric]
>=20
> On Tue, 13 Mar 2018 15:53:19 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>=20
>> On 7/3/18 1:17 pm, Alexey Kardashevskiy wrote:
>>> On 26/02/18 19:36, Alexey Kardashevskiy wrote: =20
>>>> On 19/02/18 13:46, Alexey Kardashevskiy wrote: =20
>>>>> On 16/02/18 16:28, David Gibson wrote: =20
>>>>>> On Wed, Feb 14, 2018 at 08:55:41AM -0700, Alex Williamson wrote: =20
>>>>>>> On Wed, 14 Feb 2018 19:09:16 +1100
>>>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>>>> =20
>>>>>>>> On 14/02/18 12:33, David Gibson wrote: =20
>>>>>>>>> On Tue, Feb 13, 2018 at 07:20:56PM +1100, Alexey Kardashevskiy =
wrote:   =20
>>>>>>>>>> On 13/02/18 16:41, David Gibson wrote:   =20
>>>>>>>>>>> On Tue, Feb 13, 2018 at 04:36:30PM +1100, David Gibson wrote:=
   =20
>>>>>>>>>>>> On Tue, Feb 13, 2018 at 12:15:52PM +1100, Alexey Kardashevsk=
iy wrote:   =20
>>>>>>>>>>>>> On 13/02/18 03:06, Alex Williamson wrote:   =20
>>>>>>>>>>>>>> On Mon, 12 Feb 2018 18:05:54 +1100
>>>>>>>>>>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>>>>>>>>>>>   =20
>>>>>>>>>>>>>>> On 12/02/18 16:19, David Gibson wrote:   =20
>>>>>>>>>>>>>>>> On Fri, Feb 09, 2018 at 06:55:01PM +1100, Alexey Kardash=
evskiy wrote:     =20
>>>>>>>>>>>>>>>>> At the moment if vfio_memory_listener is registered in =
the system memory
>>>>>>>>>>>>>>>>> address space, it maps/unmaps every RAM memory region f=
or DMA.
>>>>>>>>>>>>>>>>> It expects system page size aligned memory sections so =
vfio_dma_map
>>>>>>>>>>>>>>>>> would not fail and so far this has been the case. A map=
ping failure
>>>>>>>>>>>>>>>>> would be fatal. A side effect of such behavior is that =
some MMIO pages
>>>>>>>>>>>>>>>>> would not be mapped silently.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> However we are going to change MSIX BAR handling so we =
will end having
>>>>>>>>>>>>>>>>> non-aligned sections in vfio_memory_listener (more deta=
ils is in
>>>>>>>>>>>>>>>>> the next patch) and vfio_dma_map will exit QEMU.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> In order to avoid fatal failures on what previously was=
 not a failure and
>>>>>>>>>>>>>>>>> was just silently ignored, this checks the section alig=
nment to
>>>>>>>>>>>>>>>>> the smallest supported IOMMU page size and prints an er=
ror if not aligned;
>>>>>>>>>>>>>>>>> it also prints an error if vfio_dma_map failed despite =
the page size check.
>>>>>>>>>>>>>>>>> Both errors are not fatal; only MMIO RAM regions are ch=
ecked
>>>>>>>>>>>>>>>>> (aka "RAM device" regions).
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> If the amount of errors printed is overwhelming, the MS=
IX relocation
>>>>>>>>>>>>>>>>> could be used to avoid excessive error output.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> This is unlikely to cause any behavioral change.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>    =
 =20
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> There are some relatively superficial problems noted bel=
ow.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> But more fundamentally, this feels like it's extending a=
n existing
>>>>>>>>>>>>>>>> hack past the point of usefulness.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> The explicit check for is_ram_device() here has always b=
othered me -
>>>>>>>>>>>>>>>> it's not like a real bus bridge magically knows whether =
a target
>>>>>>>>>>>>>>>> address maps to RAM or not.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> What I think is really going on is that even for systems=
 without an
>>>>>>>>>>>>>>>> IOMMU, it's not really true to say that the PCI address =
space maps
>>>>>>>>>>>>>>>> directly onto address_space_memory.  Instead, there's a =
large, but
>>>>>>>>>>>>>>>> much less than 2^64 sized, "upstream window" at address =
0 on the PCI
>>>>>>>>>>>>>>>> bus, which is identity mapped to the system bus.  Detail=
s will vary
>>>>>>>>>>>>>>>> with the system, but in practice we expect nothing but R=
AM to be in
>>>>>>>>>>>>>>>> that window.  Addresses not within that window won't be =
mapped to the
>>>>>>>>>>>>>>>> system bus but will just be broadcast on the PCI bus and=
 might be
>>>>>>>>>>>>>>>> picked up as a p2p transaction.     =20
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Currently this p2p works only via the IOMMU, direct p2p i=
s not possible as
>>>>>>>>>>>>>>> the guest needs to know physical MMIO addresses to make p=
2p work and it
>>>>>>>>>>>>>>> does not.   =20
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> /me points to the Direct Translated P2P section of the ACS=
 spec, though
>>>>>>>>>>>>>> it's as prone to spoofing by the device as ATS.  In any ca=
se, p2p
>>>>>>>>>>>>>> reflected from the IOMMU is still p2p and offloads the CPU=
 even if
>>>>>>>>>>>>>> bandwidth suffers vs bare metal depending on if the data d=
oubles back
>>>>>>>>>>>>>> over any links.  Thanks,   =20
>>>>>>>>>>>>>
>>>>>>>>>>>>> Sure, I was just saying that p2p via IOMMU won't be as simp=
le as broadcast
>>>>>>>>>>>>> on the PCI bus, IOMMU needs to be programmed in advance to =
make this work,
>>>>>>>>>>>>> and current that broadcast won't work for the passed throug=
h devices.   =20
>>>>>>>>>>>>
>>>>>>>>>>>> Well, sure, p2p in a guest with passthrough devices clearly =
needs to
>>>>>>>>>>>> be translated through the IOMMU (and p2p from a passthrough =
to an
>>>>>>>>>>>> emulated device is essentially impossible).
>>>>>>>>>>>>
>>>>>>>>>>>> But.. what does that have to do with this code.  This is the=
 memory
>>>>>>>>>>>> area watcher, looking for memory regions being mapped direct=
ly into
>>>>>>>>>>>> the PCI space.  NOT IOMMU regions, since those are handled s=
eparately
>>>>>>>>>>>> by wiring up the IOMMU notifier.  This will only trigger if =
RAM-like,
>>>>>>>>>>>> non-RAM regions are put into PCI space *not* behind an IOMMM=
U.   =20
>>>>>>>>>>>
>>>>>>>>>>> Duh, sorry, realised I was mixing up host and guest IOMMU.  I=
 guess
>>>>>>>>>>> the point here is that this will map RAM-like devices into th=
e host
>>>>>>>>>>> IOMMU when there is no guest IOMMU, allowing p2p transactions=
 between
>>>>>>>>>>> passthrough devices (though not from passthrough to emulated =
devices).   =20
>>>>>>>>>>
>>>>>>>>>> Correct.
>>>>>>>>>>   =20
>>>>>>>>>>>
>>>>>>>>>>> The conditions still seem kind of awkward to me, but I guess =
it makes
>>>>>>>>>>> sense.   =20
>>>>>>>>>>
>>>>>>>>>> Is it the time to split this listener to RAM-listener and PCI =
bus listener?   =20
>>>>>>>>>
>>>>>>>>> I'm not really sure what you mean by that.
>>>>>>>>>    =20
>>>>>>>>>> On x86 it listens on the "memory" AS, on spapr - on the
>>>>>>>>>> "pci@800000020000000" AS, this will just create more confusion=
 over time...   =20
>>>>>>>>>
>>>>>>>>> Hm, it's still logically the same AS in each case - the PCI add=
ress
>>>>>>>>> space.  It's just that in the x86 case that happens to be the s=
ame as
>>>>>>>>> the memory AS (at least when there isn't a guest side IOMMU).  =
 =20
>>>>>>>>
>>>>>>>> Hm. Ok.
>>>>>>>> =20
>>>>>>>>> I do wonder if that's really right even for x86 without IOMMU. =
 The
>>>>>>>>> PCI address space is identity mapped to the "main" memory addre=
ss
>>>>>>>>> space there, but I'm not sure it's mapped th *all* of the main =
memory   =20
>>>>>>>>
>>>>>>>> What should have been in the place of "th" above? :)
>>>>>>>> =20
>>>>>>>>> address space, probably just certain ranges of it.  That's what=
 I was
>>>>>>>>> suggesting earlier in the thread.   =20
>>>>>>>>
>>>>>>>> afaict vfio is trying to mmap every RAM MR =3D=3D KVM memory slo=
t, no ranges or
>>>>>>>> anything like that. I am trying to figure out what is not correc=
t with the
>>>>>>>> patch. Thanks, =20
>>>>>>>
>>>>>>> It is possible for x86 systems to have translation applied to MMI=
O vs
>>>>>>> RAM such that the processor view and device view of MMIO are diff=
erent,
>>>>>>> putting them into separate address spaces, but this is not typica=
l and
>>>>>>> not available on the class of chipsets that QEMU emulates for PC.
>>>>>>> Therefore I think it's correct that MMIO and RAM all live in one =
big
>>>>>>> happy, flat address space as they do now (assuming the guest IOMM=
U is
>>>>>>> not present or disabled).  Thanks, =20
>>>>>>
>>>>>> Ah.. I think the thing I was missing is that on PC (at least with
>>>>>> typical chipsets) *all* MMIO essentially comes from PCI space.  Ev=
en
>>>>>> the legacy devices are essentially ISA which is treated as being o=
n a
>>>>>> bridge under the PCI space.  On non-x86 there are often at least a
>>>>>> handful of MMIO devices that aren't within the PCI space - say, th=
e
>>>>>> PCI host bridge itself at least.  x86 avoids that by using the
>>>>>> separate IO space, which is also a bit weird in that it's
>>>>>> simultaneously direct attached to the cpu (and so doesn't need bri=
dge
>>>>>> configuration), but also identified with the legay IO space treate=
d as
>>>>>> being under two bridges (host->PCI, PCI->ISA) for other purposes.
>>>>>>
>>>>>> Maybe it's just me, but I find it makes more sense to me if I thin=
k of
>>>>>> it as the two ASes being equal because on PC the system address ma=
p
>>>>>> (address_space_memory) is made equal to the PCI address map, rathe=
r
>>>>>> than the PCI address map being made equal to the system one. =20
>>>>>
>>>>> It makes more sense to me too, we just do not exploit/expose this o=
n SPAPR
>>>>> - the PCI address space only has 2xIOMMU and 1xMSI windows and that=
's it,
>>>>> no MMIO which is mapped to the system AS only (adding those to the =
PCI AS
>>>>> is little tricky as mentioned elsewhere).
>>>>>
>>>>> Anyway, I still wonder - what needs to be addressed in the 2/4 patc=
h in
>>>>> order to proceed? =20
>>>>
>>>> Ping?
>>>> =20
>>>
>>>
>>> Ping?
>>>
>>>  =20
>>
>>
>> Could anyone please enlighten me what needs to be done with this patch=
set
>> to proceed, or confirm that it is ok but not going anywhere as everybo=
dy is
>> busy with other things? :) Thanks,
>=20
> Actually making sure it compiles would have been nice:
>=20
> qemu.git/hw/vfio/common.c: In function =E2=80=98vfio_listener_region_ad=
d=E2=80=99:
> qemu.git/hw/vfio/common.c:550:40: error: invalid operands to binary & (=
have =E2=80=98Int128 {aka struct Int128}=E2=80=99 and =E2=80=98hwaddr {ak=
a long long unsigned int}=E2=80=99)
>          if ((iova & pgmask) || (llsize & pgmask)) {
>                                         ^
> qemu.git/hw/vfio/common.c: In function =E2=80=98vfio_listener_region_de=
l=E2=80=99:
> qemu.git/hw/vfio/common.c:669:50: error: invalid operands to binary & (=
have =E2=80=98Int128 {aka struct Int128}=E2=80=99 and =E2=80=98hwaddr {ak=
a long long unsigned int}=E2=80=99)
>          try_unmap =3D !((iova & pgmask) || (llsize & pgmask));
>                                                   ^
> Clearly llsize needs to be wrapped in int128_get64() here.  Should I
> presume that testing of this patch is equally lacking?  Eric, have you
> done any testing of this?  I think this was fixing a mapping issue you
> reported.  Thanks,
not that version unfortunately. I don't have access to the HW on which I
had the issue anymore. Maybe I could by the beg of next week?

Thanks

Eric
>=20
> Alex
>=20
