Received: from eggs.gnu.org ([2001:4830:134:3::10]:35395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fEFsq-0001SB-W1
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:11:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fEFsm-000880-0h
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:11:00 -0400
Received: from 9.mo4.mail-out.ovh.net ([46.105.40.176]:36608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fEFsl-00087E-Qm
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:10:55 -0400
Received: from player714.ha.ovh.net (unknown [10.109.122.15])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 01ABB169341
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 17:10:53 +0200 (CEST)
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-7-clg@kaod.org>
	<20180426071129.GJ8800@umbus.fritz.box>
	<9273a240-6518-155f-ed78-79abe53761e3@kaod.org>
	<4e3ece34-2373-c887-affe-f793b585599a@kaod.org>
	<20180503053944.GS13229@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e1ab26c9-013f-c645-c89f-dbd36f139d0e@kaod.org>
Date: Thu, 3 May 2018 17:10:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180503053944.GS13229@umbus.fritz.box>
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

On 05/03/2018 07:39 AM, David Gibson wrote:
> On Thu, Apr 26, 2018 at 07:15:29PM +0200, C=E9dric Le Goater wrote:
>> On 04/26/2018 11:27 AM, C=E9dric Le Goater wrote:
>>> On 04/26/2018 09:11 AM, David Gibson wrote:
>>>> On Thu, Apr 19, 2018 at 02:43:02PM +0200, C=E9dric Le Goater wrote:
> [snip]
>>>>> +static void xive_tm_os_write(void *opaque, hwaddr offset,
>>>>> +                                   uint64_t value, unsigned size)
>>>>> +{
>>>>> +    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
>>>>> +    XiveNVT *nvt =3D XIVE_NVT(cpu->intc);
>>>>> +    int i;
>>>>> +
>>>>> +    if (offset >=3D TM_SPC_ACK_EBB) {
>>>>> +        xive_tm_write_special(nvt, offset, value, size);
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>> +    if (TM_RING(offset) !=3D TM_QW1_OS) {
>>>>
>>>> Why have this if you have separate OS and user regions as you appear
>>>> to do below?
>>>
>>> This is another problem we are trying to solve.=20
>>>
>>> The registers a CPU can access depends on the TIMA view it is using.=20
>>> The OS TIMA view only sees the OS ring registers. The HV view sees al=
l.=20
>>
>> So, I gave a deeper look at the specs and I understood a little more=20
>> details of the concepts behind. You need to do frequent round-trips=20
>> to this document ... =20
>>
>> These registers are accessible through four aligned pages, each exposi=
ng=20
>> a different view of the registers. First page (page address ending=20
>> in 0b00) gives access to the entire context and is reserved for the=20
>> ring 0 security monitor. The second (page address ending in 0b01)=20
>> is for the hypervisor, ring 1. The third (page address ending in 0b10)=
=20
>> is for the operating system, ring 2. The fourth (page address ending=20
>> in 0b11) is for user level, ring 3.
>>
>> The sPAPR machine runs at the OS privilege and therefore can only=20
>> accesses the OS and the User rings, 2 and 3. The others are for
>> hypervisor levels.
>=20
> Ok, that much is what I thought.  What I'm less clear on is what each
> page looks like compared to the others.  Previously I thought each one
> had the same registers,=20

yes.

> just manipulating the corresponding ring. =20

no.=20

> Are you saying instead that each ring's page basically has a subset=20
> of the registers in the next most privileged page?

That's the idea.=20

The registers are defined as follow :

	QW-0 User     =20
	QW-1 O/S     =20
	QW-2 Pool  =20
	QW-3 Physical=20

and the pages :

- 0006030203180000 security monitor=20
  can access all registers=20

- 0006030203190000 hv
  can access all registers minus the secure regs

- 00060302031a0000 os
  can access some of the OS (QW1) and User (QW0) registers
=20
- 00060302031b0000 user
  can access NSR reg of User (QW0) registers

On sPAPR, we can remap the os/user pages to some other base address=20
but we should keep the same page offset.


>> I will try to come with a better implementation of the model and
>> make sure the ring numbers are respected. I am not sure we should=20
>> have only one memory region or four distinct ones with their
>> own ops. There are some differences in the load/store of each view.
>=20
> Right.  I'm not clear at this point if that's for good reasons, or
> just because IBM's hardware designers don't seem to have gotten the
> hang of Don't Repeat Yourself.
>=20
