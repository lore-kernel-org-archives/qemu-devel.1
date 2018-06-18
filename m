Received: from eggs.gnu.org ([2001:4830:134:3::10]:40474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fUy8i-0000lF-6X
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:40:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fUy8f-0007tF-F3
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:40:28 -0400
Received: from 15.mo3.mail-out.ovh.net ([87.98.150.177]:36643)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fUy8f-0007rd-0D
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:40:25 -0400
Received: from player786.ha.ovh.net (unknown [10.109.122.67])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 1E8C41BCF0D
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 19:40:23 +0200 (CEST)
References: <20180615115303.31125-1-clg@kaod.org>
	<20180615115303.31125-4-clg@kaod.org>
	<20180615180311.6d16e506@bahia.lan>
	<c5182296-b9f5-0072-8d13-551d71560394@kaod.org>
	<20180618104208.66a9f09e@bahia.lan>
	<26b2695c-8b7e-d5f7-7069-cb234aaf5a2e@kaod.org>
	<20180618115444.094d4b1c@bahia.lan>
	<04de8df8-3951-442c-62f4-7ea0309c609b@kaod.org>
	<20180618144633.7dc1ba5f@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2458e1d4-3360-b113-dc65-b664085a6c3c@kaod.org>
Date: Mon, 18 Jun 2018 19:40:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180618144633.7dc1ba5f@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 3/3] spapr: introduce a fixed
 IRQ number space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 06/18/2018 02:46 PM, Greg Kurz wrote:
> On Mon, 18 Jun 2018 13:31:26 +0200
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> On 06/18/2018 11:54 AM, Greg Kurz wrote:
>>> On Mon, 18 Jun 2018 10:56:55 +0200
>>> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>>>  =20
>>>> [ ... ]
>>>> =20
>>>>>>> This is 4 irqs per PHB, hence up to 32 PHBs. Cool, we're currentl=
y
>>>>>>> limited to 31 PHBs.
>>>>>>>      =20
>>>>>>>> +#define SPAPR_IRQ_MSI        0x1100  /* Offset of the dynamic r=
ange covered     =20
>>>>>>>
>>>>>>> We only support dynamic MSIs with PCI, maybe rename to SPAPR_IRQ_=
PCI_MSI ?     =20
>>>>>>
>>>>>> hmm, no. We could have CAPI devices there. remember ? ;)
>>>>>>   =20
>>>>>
>>>>> Well... OpenCAPI devices are exposed to the OS as PCI devices, so I=
'm not
>>>>> sure we need a CAPI specific range.   =20
>>>>
>>>> yes. so this range is common to all devices doing dynamic allocation
>>>> of IRQs. How should we call it ?=20
>>>> =20
>>>>>>>> +                                      * by the bitmap allocator=
 */     =20
>>>>>>>
>>>>>>> The range size is hence 1k (XICS_IRQS_SPAPR) for the time being. =
    =20
>>>>>>
>>>>>> in fact we could this bogus limit and use spapr->irq_map_nr now.
>>>>>>   =20
>>>>>
>>>>> "we could *missing verb* this bogus limit"... so I'm not sure to
>>>>> understand...   =20
>>>>
>>>> oups. We could use spapr->irq_map_nr instead of XICS_IRQS_SPAPR when
>>>> defining :=20
>>>>
>>>>     _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi", XICS_IR=
QS_SPAPR));
>>>>
>>>> in spapr_pci.c
>>>> =20
>>>
>>> Ah... yeah, I've always found weird that all PHBs advertise the same =
number
>>> of available MSIs as the total number of irqs for the whole machine. =
And
>>> putting spapr->irq_map_nr looks weird all the same if all PHBs rely o=
n the
>>> same bitmap actually.
>>>
>>> I'm thinking of doing the other way around: keep XICS_IRQS_SPAPR in
>>> "ibm,pe-total-#msi" and have one XICS_IRQS_SPAPR sized bitmap per PHB=
. =20
>>
>> That could be the place where to put the msi allocator.
>>
>=20
> Are you suggesting to move @irq_map and @irq_map_nr to sPAPRPHBState an=
d
> to have these setup during PHB realize ? I guess we could do that.

Hmm, I think it's better to keep it under the machine. We only need=20
to define an IRQ number "quantity" per phb and not a specific IRQ=20
number range. The claimed numbers can be machine wide numbers. =20

C.
