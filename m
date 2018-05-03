Received: from eggs.gnu.org ([2001:4830:134:3::10]:53368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fEFMZ-0002BA-0I
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:37:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fEFMV-00024a-0j
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:37:39 -0400
Received: from 15.mo4.mail-out.ovh.net ([91.121.62.11]:33819)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fEFMU-00023V-PE
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:37:34 -0400
Received: from player714.ha.ovh.net (unknown [10.109.120.70])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id A037D16BB79
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 16:37:32 +0200 (CEST)
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-8-clg@kaod.org>
	<20180426072501.GK8800@umbus.fritz.box>
	<312cdfe7-bc6b-3eed-588e-a71ce1385988@kaod.org>
	<20180503054534.GU13229@umbus.fritz.box>
	<cf8ab4bd-8704-aa3f-a4c2-5f459c7dddd4@kaod.org>
	<20180503062559.GW13229@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <20cd899d-47be-f9a3-736b-bf3bcd10cfad@kaod.org>
Date: Thu, 3 May 2018 16:37:29 +0200
MIME-Version: 1.0
In-Reply-To: <20180503062559.GW13229@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 07/35] spapr/xive: introduce the XIVE
 Event Queues
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

On 05/03/2018 08:25 AM, David Gibson wrote:
> On Thu, May 03, 2018 at 08:07:54AM +0200, C=E9dric Le Goater wrote:
>> On 05/03/2018 07:45 AM, David Gibson wrote:
>>> On Thu, Apr 26, 2018 at 11:48:06AM +0200, C=E9dric Le Goater wrote:
>>>> On 04/26/2018 09:25 AM, David Gibson wrote:
>>>>> On Thu, Apr 19, 2018 at 02:43:03PM +0200, C=E9dric Le Goater wrote:
>>>>>> The Event Queue Descriptor (EQD) table is an internal table of the
>>>>>> XIVE routing sub-engine. It specifies on which Event Queue the eve=
nt
>>>>>> data should be posted when an exception occurs (later on pulled by=
 the
>>>>>> OS) and which Virtual Processor to notify.
>>>>>
>>>>> Uhhh.. I thought the IVT said which queue and vp to notify, and the
>>>>> EQD gave metadata for event queues.
>>>>
>>>> yes. the above poorly written. The Event Queue Descriptor contains t=
he
>>>> guest address of the event queue in which the data is written. I wil=
l=20
>>>> rephrase.     =20
>>>>
>>>> The IVT contains IVEs which indeed define for an IRQ which EQ to not=
ify=20
>>>> and what data to push on the queue.=20
>>>> =20
>>>>>> The Event Queue is a much
>>>>>> more complex structure but we start with a simple model for the sP=
APR
>>>>>> machine.
>>>>>>
>>>>>> There is one XiveEQ per priority and these are stored under the XI=
VE
>>>>>> virtualization presenter (sPAPRXiveNVT). EQs are simply indexed wi=
th :
>>>>>>
>>>>>>        (server << 3) | (priority & 0x7)
>>>>>>
>>>>>> This is not in the XIVE architecture but as the EQ index is never
>>>>>> exposed to the guest, in the hcalls nor in the device tree, we are
>>>>>> free to use what fits best the current model.
>>>>
>>>> This EQ indexing is important to notice because it will also show up=
=20
>>>> in KVM to build the IVE from the KVM irq state.
>>>
>>> Ok, are you saying that while this combined EQ index will never appea=
r
>>> in guest <-> host interfaces,=20
>>
>> Indeed.
>>
>>> it might show up in qemu <-> KVM interfaces?
>>
>> Not directly but it is part of the IVE as the IVE_EQ_INDEX field. When
>> dumped, it has to be built in some ways, compatible with the emulated=20
>> mode in QEMU.=20
>=20
> Hrm.  But is the exact IVE contents visible to qemu (for a PAPR
> guest)? =20

The guest only uses hcalls which arguments are :
=20
	- cpu numbers,
	- priority numbers from defined ranges,=20
	- logical interrupt numbers. =20
	- physical address of the EQ=20

The visible parts for the guest of the IVE are the 'priority', the 'cpu',=
=20
and the 'eisn', which is the effective IRQ number the guest is assigning=20
to the source. The 'eisn" will be pushed in the EQ.

The IVE EQ index is not visible.
=20
> I would have thought the qemu <-> KVM interfaces would have
> abstracted this the same way the guest <-> KVM interfaces do.  > Or is =
there a reason not to?

It is practical to dump 64bit IVEs directly from KVM into the QEMU=20
internal structures because it fits the emulated mode without doing=20
any translation ... This might be seen as a shortcut. You will tell=20
me when you reach the KVM part.  =20

>>>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>>>
>>>>> Is the EQD actually modifiable by a guest?  Or are the settings of =
the
>>>>> EQs fixed by PAPR?
>>>>
>>>> The guest uses the H_INT_SET_QUEUE_CONFIG hcall to define the addres=
s
>>>> of the event queue for a couple prio/server.
>>>
>>> Ok, so the EQD can be modified by the guest.  In which case we need t=
o
>>> work out what object owns it, since it'll need to migrate it.
>>
>> Indeed. The EQD are CPU related as there is one EQD per couple (cpu,=20
>> priority). The KVM patchset dumps/restores the eight XiveEQ struct=20
>> using per cpu ioctls. The EQ in the OS RAM is marked dirty at that
>> stage.
>=20
> To make sure I'm clear: for PAPR there's a strict relationship between
> EQD and CPU (one EQD for each (cpu, priority) tuple). =20

Yes.

> But for powernv that's not the case, right? =20

It is.

> AIUI the mapping of EQs to cpus was configurable, is that right?

Each cpu has 8 EQD. Same for virtual cpus.=20

I am not sure what you understood before ? It is surely something
I wrote, my XIVE understanding is still making progress.


C.
