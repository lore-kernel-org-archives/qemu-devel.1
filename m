Received: from eggs.gnu.org ([2001:4830:134:3::10]:54857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1e58HB-00089L-Ul
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 06:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1e58H8-0001ch-OS
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 06:42:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1e58H8-0001cP-FG
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 06:42:06 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 85E6ED7912
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 10:42:05 +0000 (UTC)
References: <20171018095807.101406-1-marcel@redhat.com>
	<69cefa98-5681-5b12-719c-e13fcba969c4@redhat.com>
	<9d4b1fa8-e670-556b-278d-4993ad41b512@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <36a5b8e7-84d1-5ffd-d85b-7f0378801f3c@redhat.com>
Date: Thu, 19 Oct 2017 12:41:41 +0200
MIME-Version: 1.0
In-Reply-To: <9d4b1fa8-e670-556b-278d-4993ad41b512@redhat.com>
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

On 10/19/17 11:30, Marcel Apfelbaum wrote:
>=20
> Hi Laszlo,
>=20
> On 18/10/2017 14:40, Laszlo Ersek wrote:
>> Hi Marcel,
>>
>> On 10/18/17 11:58, Marcel Apfelbaum wrote:
>>> Currently there is no MMIO range over 4G
>>> reserved for PCI hotplug. Since the 32bit PCI hole
>>> depends on the number of cold-plugged PCI devices
>>> and other factors, it is very possible is too small
>>> to hotplug PCI devices with large BARs.
>>>
>>> Fix it by reserving all the address space after
>>> RAM (and the reserved space for RAM hotplug),
>>> but no more than 40bits. The later seems to be
>>> QEMU's magic number for the Guest physical CPU addressable
>>> bits and is safe with respect to migration.
>>>
>>> Note this is a regression since prev QEMU versions had
>>> some range reserved for 64bit PCI hotplug.
>>>
>>> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
>>> ---
>>> =C2=A0 hw/i386/pc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 22 ++++++++++++++++++++++
>>> =C2=A0 hw/pci-host/piix.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 10 ++++++++++
>>> =C2=A0 hw/pci-host/q35.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 9 +++++++++
>>> =C2=A0 include/hw/i386/pc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 ++++++=
++++
>>> =C2=A0 include/hw/pci-host/q35.h |=C2=A0 1 +
>>> =C2=A0 5 files changed, 52 insertions(+)
>>
>> - What are the symptoms of the problem?
>>
>=20
> PCI devices with *relatively* large BARs can't be hot-plugged.
> The reason is QEMU does not reserve MMIO range over 4G and
> uses whatever remains on the 32bit PCI window.
>=20
> If you coldplug enough PCI devices you will end up with
> with a 64bit PCI window that covers only the cold-plugged PCI
> devices, still no room for hotplug.
>=20
>> - What QEMU commit regressed the previous functionality?
>>
>=20
> =C2=A0- commit 39848901818 pc: limit 64 bit hole to 2G by default
> =C2=A0shows us QEMU had the 64bit PCI hole, so it is a regression.

(Side remark: this commit was part of release v1.6.0, and at that time
we also had the "etc/pci-info" fw_cfg file.)

>=20
> =C2=A0- commit 2028fdf3791 piix: use 64 bit window programmed by guest
> =C2=A0leaves no room for PCI hotplug

(Side remark: part of v1.7.0, from 2013. So, we can call this a
regression, but then it's a very old one.

Of course this is *not* a counter-argument to your patch, or commit
message wording; it's just that I'm surprised that the issue could
remain dormant this long -- usually users report regressions very quickly=
.)

>=20
>> - How exactly is the regression (and this fix) exposed to the guest?
>>
>=20
> The nuance is both above commits computed the actual MMIO
> range used by cold-plugged devices, but as side effect
> they influenced the remaining PCI window for hot-plugged devices.
>=20
> What the guest sees is the CRS MMIO range over 4G.

OK, understood.

>=20
>> I'm confused because semi-recently I've done multiple successful
>> hotplugs, with OVMF, Q35, PCIe root ports, and PCI Express devices
>> having large (64-bit) MMIO BARs. The examples include ivshmem / Linux
>> guest (based on your hints) and vfio-pci (XL710 NIC) / Windows Server
>> 2016 guest.
>=20
> Cool! These are actually great news!
> Back to the issue in hand, a few things:
> 1. It works with Q35 only, but not with the I440FX machines.

OK.

> 2. The hints are used for the PCIe root ports, meaning for PCI bridges
> =C2=A0=C2=A0 and addresses a slightly different issues: leave hotplug s=
pace
> =C2=A0=C2=A0 for secondary buses, while this patch tackles hotplug
> =C2=A0=C2=A0 space for root buses.

OK.

>=20
>>
>> By default, OVMF marks a 32GB area as 64-bit MMIO aperture, for BAR
>> allocation. This area is above the normal memory (plus reservation for
>> hotplug memory, if any). It is also GB-aligned. The aperture size can =
be
>> changed (currently) with an experimental -fw_cfg switch (the fw_cfg fi=
le
>> is called "opt/ovmf/X-PciMmio64Mb", it states the size of the 64-bit
>> MMIO aperture as a decimal number of megabytes).
>=20
> I'll try to explain how I see the "picture":
> CRS is created by QEMU and computed *after* the firmware finishes
> the PCI BARs allocations.

Yes.

> Then *QEMU* decides how big it will be the
> 64bit PCI hole, not the firmware - see the past commits.

Yes, first the guest-side programming happens, then QEMU (re-)calculates
the ACPI payload once the right ACPI fw_cfg file is selected / read.
This re-calculation (including the CRS) observes the previously
programmed values.

>=20
> So IMHO you don't need the opt/ovmf/X-PciMmio64Mb since the OVMF
> is not deciding this value. It actually should not care at all.

OVMF cannot *not* care. It must internally provide (to other,
platform-independent components in edk2) the 64-bit MMIO aperture that
the BARs can be allocated from.


But maybe I'm totally misunderstanding this patch! Are you saying that
the patch makes the following difference only: when the CRS is
recalculated (i.e., after the PCI enumeration has completed in the
guest, and the ACPI linker/loader fw_cfg files are opened), then you
only grow / round up the 64-bit range?

That would make sense, because a *superset* aperture exposed to the OS
via the _CRS does not invalidate any allocations done by the firmware
earlier. Furthermore, the firmware itself need not learn about the
details of said superset. In this sense I agree that OVMF should not
care at all.

[snip]

>> Also, how do you plan to integrate this feature with SeaBIOS?

(Ever since I sent my previous response, I've been glad that I finished
my email with this question -- I really think OVMF and SeaBIOS should
behave uniformly in this regard. So I'm happy about your answer:)

> Simple, no need :) . It just works as it should.
> SeaBIOS computes everything, *then* QEMU creates the CRs ranges
> based on firmware input and other properties.
> I think it works also with OVMF out of the box.

OK, so this explains it all, thank you very much -- my question is if
you could spell out those "other properties" in a bit more detail (I
apologize if these should be obvious to me already, from the commit
message and the patch):

(1) How exactly does the enlarged 64-bit hole remain a *superset* of the
firmware-programmed BARs? Can you point me to a location in the code?

(2) What happens if we do have more than 1TB RAM?

> A last note, when pxb/pxb-pcies will became hot-pluggable
> we need to leave some bits for them too. I wouldn't
> really want to add fw_config files for them too, or
> use a complicate fw_config, or rewrite
> the logic for all firmware if we don't have to.

OK.

>=20
> 64bit PCI window starts from memory(+reserved) end
> and finishes at 40bit.

OK, this seems to (partly) answer my question (1) -- can you please
confirm that the

  finishes at 40bit

part does not imply forcefully truncating the CRS at 1TB, in case the
firmware already allocated BARs higher than that?

> If you have 1T of RAM you
> get nothing for PCI hotplug, seems fair.

This is fine (as the answer to my question (2)) as long as you mean it
in the following sense: "QEMU will simply *not grow* the MMIO in the
_CRS past 1TB".

> When guests with more then 1T of RAM will become
> frequent, I suppose the QEMU's default CPU addressable
> bits will change and we will change it too.

Thanks Marcel, I feel a lot safer now.

Please confirm that the changes can only grow the area exposed in the
_CRS -- i.e., only lower or preserve the base, and only raise or
preserve the absolute limit. I'll shut up then :)

Thanks!
Laszlo
