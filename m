Received: from eggs.gnu.org ([2001:4830:134:3::10]:55879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fEbVA-0006eN-2l
	for qemu-devel@nongnu.org; Fri, 04 May 2018 10:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fEbV6-0007TQ-Oy
	for qemu-devel@nongnu.org; Fri, 04 May 2018 10:16:00 -0400
Received: from 4.mo69.mail-out.ovh.net ([46.105.42.102]:50975)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fEbV6-0007Sn-E4
	for qemu-devel@nongnu.org; Fri, 04 May 2018 10:15:56 -0400
Received: from player714.ha.ovh.net (unknown [10.109.122.75])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id DE26E141BA
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 16:15:54 +0200 (CEST)
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-7-clg@kaod.org>
	<20180426071129.GJ8800@umbus.fritz.box>
	<9273a240-6518-155f-ed78-79abe53761e3@kaod.org>
	<4e3ece34-2373-c887-affe-f793b585599a@kaod.org>
	<20180503053944.GS13229@umbus.fritz.box>
	<e1ab26c9-013f-c645-c89f-dbd36f139d0e@kaod.org>
	<20180504044416.GS13229@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <bab301fe-8ab9-c47c-96aa-1d8575320d97@kaod.org>
Date: Fri, 4 May 2018 16:15:50 +0200
MIME-Version: 1.0
In-Reply-To: <20180504044416.GS13229@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 06/35] spapr/xive: introduce a XIVE
 interrupt presenter model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 05/04/2018 06:44 AM, David Gibson wrote:
> On Thu, May 03, 2018 at 05:10:48PM +0200, C=E9dric Le Goater wrote:
>> On 05/03/2018 07:39 AM, David Gibson wrote:
>>> On Thu, Apr 26, 2018 at 07:15:29PM +0200, C=E9dric Le Goater wrote:
>>>> On 04/26/2018 11:27 AM, C=E9dric Le Goater wrote:
>>>>> On 04/26/2018 09:11 AM, David Gibson wrote:
>>>>>> On Thu, Apr 19, 2018 at 02:43:02PM +0200, C=E9dric Le Goater wrote=
:
>>> [snip]
>>>>>>> +static void xive_tm_os_write(void *opaque, hwaddr offset,
>>>>>>> +                                   uint64_t value, unsigned size=
)
>>>>>>> +{
>>>>>>> +    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
>>>>>>> +    XiveNVT *nvt =3D XIVE_NVT(cpu->intc);
>>>>>>> +    int i;
>>>>>>> +
>>>>>>> +    if (offset >=3D TM_SPC_ACK_EBB) {
>>>>>>> +        xive_tm_write_special(nvt, offset, value, size);
>>>>>>> +        return;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    if (TM_RING(offset) !=3D TM_QW1_OS) {
>>>>>>
>>>>>> Why have this if you have separate OS and user regions as you appe=
ar
>>>>>> to do below?
>>>>>
>>>>> This is another problem we are trying to solve.=20
>>>>>
>>>>> The registers a CPU can access depends on the TIMA view it is using=
.=20
>>>>> The OS TIMA view only sees the OS ring registers. The HV view sees =
all.=20
>>>>
>>>> So, I gave a deeper look at the specs and I understood a little more=
=20
>>>> details of the concepts behind. You need to do frequent round-trips=20
>>>> to this document ... =20
>>>>
>>>> These registers are accessible through four aligned pages, each expo=
sing=20
>>>> a different view of the registers. First page (page address ending=20
>>>> in 0b00) gives access to the entire context and is reserved for the=20
>>>> ring 0 security monitor. The second (page address ending in 0b01)=20
>>>> is for the hypervisor, ring 1. The third (page address ending in 0b1=
0)=20
>>>> is for the operating system, ring 2. The fourth (page address ending=
=20
>>>> in 0b11) is for user level, ring 3.
>>>>
>>>> The sPAPR machine runs at the OS privilege and therefore can only=20
>>>> accesses the OS and the User rings, 2 and 3. The others are for
>>>> hypervisor levels.
>>>
>>> Ok, that much is what I thought.  What I'm less clear on is what each
>>> page looks like compared to the others.  Previously I thought each on=
e
>>> had the same registers,=20
>>
>> yes.
>>
>>> just manipulating the corresponding ring. =20
>>
>> no.=20
>>
>>> Are you saying instead that each ring's page basically has a subset=20
>>> of the registers in the next most privileged page?
>>
>> That's the idea.=20
>=20
> Ah, ok.
>=20
>> The registers are defined as follow :
>>
>> 	QW-0 User     =20
>> 	QW-1 O/S     =20
>> 	QW-2 Pool  =20
>> 	QW-3 Physical=20
>>
>> and the pages :
>>
>> - 0006030203180000 security monitor=20
>>   can access all registers=20
>>
>> - 0006030203190000 hv
>>   can access all registers minus the secure regs
>>
>> - 00060302031a0000 os
>>   can access some of the OS (QW1) and User (QW0) registers
>> =20
>> - 00060302031b0000 user
>>   can access NSR reg of User (QW0) registers
>=20
> I can see two reasonable ways of doing this:
>=20
> A)
>=20
> Have a single set of read/write functions.  These implement all the
> registers but take a "privilege level" parameter which controls which
> will actually work.  Those could then be wired up in one of two ways:
>=20
>   A1) Single memory region.  The accessor derives the priv level from
>   the relevant address bits, before masking it down to a single
>   register page.  Then, as above

Yes. That's the goal behind the page ordering :

page address ending in 0b00 : ring 0, security monitor=20
page address ending in 0b01 : ring 1, hypervisor=20
page address ending in 0b10 : ring 2, operating system =20
page address ending in 0b11 : ring 3, user level

I don't why the registers are ordered the other way around though.

That's would be the direction to take for the emulated mode, I think.
It covers well the PowerNV (4 pages) and the sPAPR case (2 pages),=20
in each case, the machine IC controller decides how much pages to map.
The memory region ops do the rest.

For KVM, we need to populate the VMA with the host TIMA page associated=20
with ring 2 (OS) and then ring 3 (USER).=20

This option looks better overall. I will see how ugly it gets with the im=
plementation.

C.


>   A2) Multiple memory regions with the same accessor functions but
>   different opaque pointer.  The accessor gets the priv level from
>   its opaque pointer, then the address is just within a single ring's
>   page.
>
> B)
>=20
> Separate memory regions with separate accessors.  The ring-0 accessor
> implements the ring-0 registers, then calls the ring-1 accessor
> function for everything else.  ring-1 calls ring-2 and so forth.
>
>> On sPAPR, we can remap the os/user pages to some other base address=20
>> but we should keep the same page offset.
>=20
> Sure.
>=20
>>
>>
>>>> I will try to come with a better implementation of the model and
>>>> make sure the ring numbers are respected. I am not sure we should=20
>>>> have only one memory region or four distinct ones with their
>>>> own ops. There are some differences in the load/store of each view.
>>>
>>> Right.  I'm not clear at this point if that's for good reasons, or
>>> just because IBM's hardware designers don't seem to have gotten the
>>> hang of Don't Repeat Yourself.
>>>
>>
>=20
