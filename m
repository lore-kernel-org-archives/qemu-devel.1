Received: from eggs.gnu.org ([2001:4830:134:3::10]:38337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fGtM5-0006Eg-GX
	for qemu-devel@nongnu.org; Thu, 10 May 2018 17:44:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fGtM2-0007yD-DM
	for qemu-devel@nongnu.org; Thu, 10 May 2018 17:44:05 -0400
Received: from 4.mo69.mail-out.ovh.net ([46.105.42.102]:58002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fGtM2-0007nf-7J
	for qemu-devel@nongnu.org; Thu, 10 May 2018 17:44:02 -0400
Received: from player696.ha.ovh.net (unknown [10.109.122.75])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id A3A6714160
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 23:43:52 +0200 (CEST)
References: <20180413075200.15217-1-clg@kaod.org>
	<20180419165800.GA2731@work-vm>
	<e5447136-8de7-73f3-ca6d-0c7a1fe11abe@kaod.org>
	<20180509110833.GD2527@work-vm>
	<CAFEAcA9T=UUXS1ABrtahv_LyDtAf6DT-pRoTRYFr3LvvSkdyTQ@mail.gmail.com>
	<20180510191556.GB2679@work-vm>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <4a8c637c-410c-9a53-4bae-9f682811a73c@kaod.org>
Date: Thu, 10 May 2018 23:43:33 +0200
MIME-Version: 1.0
In-Reply-To: <20180510191556.GB2679@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] migration: discard non-migratable
 RAMBlocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Yulei Zhang <yulei.zhang@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, Kirti Wankhede <kwankhede@nvidia.com>, zhi.a.wang@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Paul Burton <paul.burton@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

Hello David,

On 05/10/2018 09:15 PM, Dr. David Alan Gilbert wrote:
> * Peter Maydell (peter.maydell@linaro.org) wrote:
>> On 9 May 2018 at 12:08, Dr. David Alan Gilbert <dgilbert@redhat.com> w=
rote:
>>> This thread seems to have stalled; we've got the list of potential
>>> migration breaks that Peter found and only some minor comments on the
>>> actual patch.
>>>
>>> I'd like to get it going again sicne as well as C=C3=A9dric, and Pete=
r's
>>> cases, there's Lai Jiangshan and now Eric Wheeler was asking for
>>> something similar.
>>>
>>> Anyone understand the way forward? Do we have to go and fix the
>>> odd board failures first?
>>
>> aspeed and highbank I already changed in master. That leaves
>>
>> hw/mips/boston.c:    memory_region_init_rom_nomigrate(flash, NULL,
>> hw/mips/mips_malta.c:    memory_region_init_ram_nomigrate(bios_copy,
>> NULL, "bios.1fc", BIOS_SIZE,
>> hw/net/dp8393x.c:    memory_region_init_ram_nomigrate(&s->prom, OBJECT=
(dev),
>>   [device only used on mips jazz board]
>> hw/pci-host/xilinx-pcie.c:    memory_region_init_ram_nomigrate(&s->io,
>> OBJECT(s), "io", 16, NULL);
>>   [device only used on mips boston board]
>>
>> which affect mips boston, malta and jazz boards.
>>
>> I don't think we need to fix those first, but:
>>
>>  * we should note in the commit message for this patch that
>>    it is a de-facto migration break for those boards
>>  * we should fix those devices/boards in this release cycle,
>>    since we've broken migration compat anyway
>>  * we should check with the MIPS maintainers that they're ok
>>    with a cross-version migration compat break for those boards
>>    (I've cc'd them)
>=20
> OK, in that case, as long as they're OK, then I think
> we should go for it.
>=20
> C=C3=A9dric: Were you going to post a version that didn't
> do it in set_idstr?

I have a v3, ready to send, adding an error_report() in ram_save_host_pag=
e()=20
for consistency with the rest of the code. It really should not happen as=
=20
the 'found' bool in ram_find_and_save_block() is protecting the call.

As for setting RAM_MIGRATABLE in vmstate_un/register_ram() instead of=20
qemu_ram_un/set_idstr(), yes, I can add this change in v3 also.=20
This is not a problem.

C.
