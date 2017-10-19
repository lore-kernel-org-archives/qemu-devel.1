Received: from eggs.gnu.org ([2001:4830:134:3::10]:45267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1e59NF-0006S5-Uu
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 07:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1e59NC-0001ec-Ox
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 07:52:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1e59NC-0001da-FD
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 07:52:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 914581B5E48
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 11:52:24 +0000 (UTC)
References: <20171018095807.101406-1-marcel@redhat.com>
	<69cefa98-5681-5b12-719c-e13fcba969c4@redhat.com>
	<9d4b1fa8-e670-556b-278d-4993ad41b512@redhat.com>
	<36a5b8e7-84d1-5ffd-d85b-7f0378801f3c@redhat.com>
	<7b08ea3e-d380-ac0c-a716-d0ac703feaea@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <6e21e32b-ce06-a6ff-8603-d864af129d7a@redhat.com>
Date: Thu, 19 Oct 2017 13:52:14 +0200
MIME-Version: 1.0
In-Reply-To: <7b08ea3e-d380-ac0c-a716-d0ac703feaea@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/pci-host: Fix x86 Host Bridges 64bit
 PCI hole
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com, Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 10/19/17 13:29, Marcel Apfelbaum wrote:
> Hi Laszlo,
>=20
> On 19/10/2017 13:41, Laszlo Ersek wrote:
>> On 10/19/17 11:30, Marcel Apfelbaum wrote:
>>>
>>> Hi Laszlo,
>>>
>>> On 18/10/2017 14:40, Laszlo Ersek wrote:
>>>> Hi Marcel,
>>>>
>>>> On 10/18/17 11:58, Marcel Apfelbaum wrote:
>>>>> Currently there is no MMIO range over 4G
>>>>> reserved for PCI hotplug. Since the 32bit PCI hole
>>>>> depends on the number of cold-plugged PCI devices
>>>>> and other factors, it is very possible is too small
>>>>> to hotplug PCI devices with large BARs.
>>>>>
>>>>> Fix it by reserving all the address space after
>>>>> RAM (and the reserved space for RAM hotplug),
>>>>> but no more than 40bits. The later seems to be
>>>>> QEMU's magic number for the Guest physical CPU addressable
>>>>> bits and is safe with respect to migration.
>>>>>
>>>>> Note this is a regression since prev QEMU versions had
>>>>> some range reserved for 64bit PCI hotplug.
>>>>>
>>>>> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
>>>>> ---
>>>>> =C2=A0=C2=A0 hw/i386/pc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 22 ++++++++++++++++++++++
>>>>> =C2=A0=C2=A0 hw/pci-host/piix.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 10 ++++++++++
>>>>> =C2=A0=C2=A0 hw/pci-host/q35.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 9 +++++++++
>>>>> =C2=A0=C2=A0 include/hw/i386/pc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1=
0 ++++++++++
>>>>> =C2=A0=C2=A0 include/hw/pci-host/q35.h |=C2=A0 1 +
>>>>> =C2=A0=C2=A0 5 files changed, 52 insertions(+)
>>>>
>>>> - What are the symptoms of the problem?
>>>>
>>>
>>> PCI devices with *relatively* large BARs can't be hot-plugged.
>>> The reason is QEMU does not reserve MMIO range over 4G and
>>> uses whatever remains on the 32bit PCI window.
>>>
>>> If you coldplug enough PCI devices you will end up with
>>> with a 64bit PCI window that covers only the cold-plugged PCI
>>> devices, still no room for hotplug.
>>>
>>>> - What QEMU commit regressed the previous functionality?
>>>>
>>>
>>> =C2=A0=C2=A0- commit 39848901818 pc: limit 64 bit hole to 2G by defau=
lt
>>> =C2=A0=C2=A0shows us QEMU had the 64bit PCI hole, so it is a regressi=
on.
>>
>> (Side remark: this commit was part of release v1.6.0, and at that time
>> we also had the "etc/pci-info" fw_cfg file.)
>>
>>>
>>> =C2=A0=C2=A0- commit 2028fdf3791 piix: use 64 bit window programmed b=
y guest
>>> =C2=A0=C2=A0leaves no room for PCI hotplug
>>
>> (Side remark: part of v1.7.0, from 2013. So, we can call this a
>> regression, but then it's a very old one.
>>
>> Of course this is *not* a counter-argument to your patch, or commit
>> message wording; it's just that I'm surprised that the issue could
>> remain dormant this long -- usually users report regressions very
>> quickly.)
>>
>=20
> I also thought I am proposing a new feature and I was pretty amazed
> I actually fix something that worked before.
>=20
>>>
>>>> - How exactly is the regression (and this fix) exposed to the guest?
>>>>
>>>
>>> The nuance is both above commits computed the actual MMIO
>>> range used by cold-plugged devices, but as side effect
>>> they influenced the remaining PCI window for hot-plugged devices.
>>>
>>> What the guest sees is the CRS MMIO range over 4G.
>>
>> OK, understood.
>>
>>>
>>>> I'm confused because semi-recently I've done multiple successful
>>>> hotplugs, with OVMF, Q35, PCIe root ports, and PCI Express devices
>>>> having large (64-bit) MMIO BARs. The examples include ivshmem / Linu=
x
>>>> guest (based on your hints) and vfio-pci (XL710 NIC) / Windows Serve=
r
>>>> 2016 guest.
>>>
>>> Cool! These are actually great news!
>>> Back to the issue in hand, a few things:
>>> 1. It works with Q35 only, but not with the I440FX machines.
>>
>> OK.
>>
>>> 2. The hints are used for the PCIe root ports, meaning for PCI bridge=
s
>>> =C2=A0=C2=A0=C2=A0 and addresses a slightly different issues: leave h=
otplug space
>>> =C2=A0=C2=A0=C2=A0 for secondary buses, while this patch tackles hotp=
lug
>>> =C2=A0=C2=A0=C2=A0 space for root buses.
>>
>> OK.
>>
>>>
>>>>
>>>> By default, OVMF marks a 32GB area as 64-bit MMIO aperture, for BAR
>>>> allocation. This area is above the normal memory (plus reservation f=
or
>>>> hotplug memory, if any). It is also GB-aligned. The aperture size
>>>> can be
>>>> changed (currently) with an experimental -fw_cfg switch (the fw_cfg
>>>> file
>>>> is called "opt/ovmf/X-PciMmio64Mb", it states the size of the 64-bit
>>>> MMIO aperture as a decimal number of megabytes).
>>>
>>> I'll try to explain how I see the "picture":
>>> CRS is created by QEMU and computed *after* the firmware finishes
>>> the PCI BARs allocations.
>>
>> Yes.
>>
>>> Then *QEMU* decides how big it will be the
>>> 64bit PCI hole, not the firmware - see the past commits.
>>
>> Yes, first the guest-side programming happens, then QEMU (re-)calculat=
es
>> the ACPI payload once the right ACPI fw_cfg file is selected / read.
>> This re-calculation (including the CRS) observes the previously
>> programmed values.
>>
>>>
>>> So IMHO you don't need the opt/ovmf/X-PciMmio64Mb since the OVMF
>>> is not deciding this value. It actually should not care at all.
>>
>> OVMF cannot *not* care. It must internally provide (to other,
>> platform-independent components in edk2) the 64-bit MMIO aperture that
>> the BARs can be allocated from.
>>
>>
>> But maybe I'm totally misunderstanding this patch! Are you saying that
>> the patch makes the following difference only: when the CRS is
>> recalculated (i.e., after the PCI enumeration has completed in the
>> guest, and the ACPI linker/loader fw_cfg files are opened), then you
>> only grow / round up the 64-bit range?
>>
>=20
> Exactly.
>=20
>> That would make sense, because a *superset* aperture exposed to the OS
>> via the _CRS does not invalidate any allocations done by the firmware
>> earlier. Furthermore, the firmware itself need not learn about the
>> details of said superset. In this sense I agree that OVMF should not
>> care at all.
>>
>=20
> Exactly, the range is a superset.
>=20
>> [snip]
>>
>>>> Also, how do you plan to integrate this feature with SeaBIOS?
>>
>> (Ever since I sent my previous response, I've been glad that I finishe=
d
>> my email with this question -- I really think OVMF and SeaBIOS should
>> behave uniformly in this regard. So I'm happy about your answer:)
>>
>>> Simple, no need :) . It just works as it should.
>>> SeaBIOS computes everything, *then* QEMU creates the CRs ranges
>>> based on firmware input and other properties.
>>> I think it works also with OVMF out of the box.
>>
>> OK, so this explains it all, thank you very much -- my question is if
>> you could spell out those "other properties" in a bit more detail (I
>> apologize if these should be obvious to me already, from the commit
>> message and the patch):
>>
>=20
> "Other properties" was a vague link to max RAM, and things like that.
> Nothing specific.
>=20
>> (1) How exactly does the enlarged 64-bit hole remain a *superset* of t=
he
>> firmware-programmed BARs? Can you point me to a location in the code?
>>
>=20
> Sure in the patch itself:
> =C2=A0We first take the firmware computed ranges:
> =C2=A0=C2=A0=C2=A0=C2=A0 pci_bus_get_w64_range(h->bus, &w64);
> =C2=A0Look at the *get_pci_hole64_start -> If the firmware set it we do=
n't
> touch.
> =C2=A0And to the *get_pci_hole64_end -> We only update the value if is =
smaller
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 than what=
 firmware set.
>=20
>=20
>=20
>> (2) What happens if we do have more than 1TB RAM?
>>
>=20
> You get no 64bit "hot-pluggable" reserved range.
> The code dealing with that is:
>=20
> +=C2=A0=C2=A0=C2=A0 if (hole64_start > PCI_HOST_PCI_HOLE64_END) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hole64_start =3D PCI_HOST_P=
CI_HOLE64_END;
> +=C2=A0=C2=A0=C2=A0 }
>=20
> And since the end is hard-coded to PCI_HOST_PCI_HOLE64_END
> we have a 0 size region which gets discarded.
>=20
> An interesting case is if we have more than 1T RAM and the
> firmware assigns BARs over that, we are increasing the
> 64bit window to include some of the RAM...
>=20
> A better approach is to check against the actual hole64
> end and not the magic value.
> I'll send a v3, thanks!

Ah, right; in v1 -- and possibly v2, I haven't looked yet --
hole64_start will be set to PCI_HOST_PCI_HOLE64_END, in preparation for
the end to be set the exact same way (resulting in an empty range) --
however, the end won't be modified at all if it's already above
PCI_HOST_PCI_HOLE64_END, so we'll end up with a non-empty range that
intersects with RAM.

Please CC me on v3 too; I feel that I'm now better equipped to comment :)

Thanks!
Laszlo

>=20
>>> A last note, when pxb/pxb-pcies will became hot-pluggable
>>> we need to leave some bits for them too. I wouldn't
>>> really want to add fw_config files for them too, or
>>> use a complicate fw_config, or rewrite
>>> the logic for all firmware if we don't have to.
>>
>> OK.
>>
>>>
>>> 64bit PCI window starts from memory(+reserved) end
>>> and finishes at 40bit.
>>
>> OK, this seems to (partly) answer my question (1) -- can you please
>> confirm that the
>>
>> =C2=A0=C2=A0 finishes at 40bit
>>
>> part does not imply forcefully truncating the CRS at 1TB, in case the
>> firmware already allocated BARs higher than that?
>>
>=20
> I confirm:
>=20
> +=C2=A0=C2=A0=C2=A0 if (s->pci_hole64_fix && value < PCI_HOST_PCI_HOLE6=
4_END) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value =3D PCI_HOST_PCI_HOLE=
64_END;
> +=C2=A0=C2=A0=C2=A0 }
>=20
> I touch the value only if is smaller than what the firmware set.
>=20
>>> If you have 1T of RAM you
>>> get nothing for PCI hotplug, seems fair.
>>
>> This is fine (as the answer to my question (2)) as long as you mean it
>> in the following sense: "QEMU will simply *not grow* the MMIO in the
>> _CRS past 1TB".
>>
>>> When guests with more then 1T of RAM will become
>>> frequent, I suppose the QEMU's default CPU addressable
>>> bits will change and we will change it too.
>>
>> Thanks Marcel, I feel a lot safer now.
>>
>> Please confirm that the changes can only grow the area exposed in the
>> _CRS -- i.e., only lower or preserve the base, and only raise or
>> preserve the absolute limit. I'll shut up then :)
>>
>=20
> Confirmed and thanks for the review!
>=20
> Thanks,
> Marcel
>=20
>> Thanks!
>> Laszlo
>>
>=20
