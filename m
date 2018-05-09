Received: from eggs.gnu.org ([2001:4830:134:3::10]:41268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fGK2S-0000Ol-Rd
	for qemu-devel@nongnu.org; Wed, 09 May 2018 04:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fGK2N-0007tN-RJ
	for qemu-devel@nongnu.org; Wed, 09 May 2018 04:01:28 -0400
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:36137)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fGK2N-0007rq-IE
	for qemu-devel@nongnu.org; Wed, 09 May 2018 04:01:23 -0400
Received: from player714.ha.ovh.net (unknown [10.109.120.8])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 284EEB071D
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 10:01:21 +0200 (CEST)
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-8-clg@kaod.org>
	<20180426072501.GK8800@umbus.fritz.box>
	<312cdfe7-bc6b-3eed-588e-a71ce1385988@kaod.org>
	<20180503054534.GU13229@umbus.fritz.box>
	<cf8ab4bd-8704-aa3f-a4c2-5f459c7dddd4@kaod.org>
	<20180503062559.GW13229@umbus.fritz.box>
	<20cd899d-47be-f9a3-736b-bf3bcd10cfad@kaod.org>
	<20180504051940.GW13229@umbus.fritz.box>
	<9cc1092b-6312-aa6c-1fcd-8e6e7756aab7@kaod.org>
	<20180505042944.GL13229@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <151a5cb7-7739-8f06-8f3e-aa536c1cb203@kaod.org>
Date: Wed, 9 May 2018 10:01:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180505042944.GL13229@umbus.fritz.box>
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

On 05/05/2018 06:29 AM, David Gibson wrote:
> On Fri, May 04, 2018 at 03:29:02PM +0200, C=E9dric Le Goater wrote:
>> On 05/04/2018 07:19 AM, David Gibson wrote:
>>> On Thu, May 03, 2018 at 04:37:29PM +0200, C=E9dric Le Goater wrote:
>>>> On 05/03/2018 08:25 AM, David Gibson wrote:
>>>>> On Thu, May 03, 2018 at 08:07:54AM +0200, C=E9dric Le Goater wrote:
>>>>>> On 05/03/2018 07:45 AM, David Gibson wrote:
>>>>>>> On Thu, Apr 26, 2018 at 11:48:06AM +0200, C=E9dric Le Goater wrot=
e:
>>>>>>>> On 04/26/2018 09:25 AM, David Gibson wrote:
>>>>>>>>> On Thu, Apr 19, 2018 at 02:43:03PM +0200, C=E9dric Le Goater wr=
ote:
>>>>>>>>>> The Event Queue Descriptor (EQD) table is an internal table of=
 the
>>>>>>>>>> XIVE routing sub-engine. It specifies on which Event Queue the=
 event
>>>>>>>>>> data should be posted when an exception occurs (later on pulle=
d by the
>>>>>>>>>> OS) and which Virtual Processor to notify.
>>>>>>>>>
>>>>>>>>> Uhhh.. I thought the IVT said which queue and vp to notify, and=
 the
>>>>>>>>> EQD gave metadata for event queues.
>>>>>>>>
>>>>>>>> yes. the above poorly written. The Event Queue Descriptor contai=
ns the
>>>>>>>> guest address of the event queue in which the data is written. I=
 will=20
>>>>>>>> rephrase.     =20
>>>>>>>>
>>>>>>>> The IVT contains IVEs which indeed define for an IRQ which EQ to=
 notify=20
>>>>>>>> and what data to push on the queue.=20
>>>>>>>> =20
>>>>>>>>>> The Event Queue is a much
>>>>>>>>>> more complex structure but we start with a simple model for th=
e sPAPR
>>>>>>>>>> machine.
>>>>>>>>>>
>>>>>>>>>> There is one XiveEQ per priority and these are stored under th=
e XIVE
>>>>>>>>>> virtualization presenter (sPAPRXiveNVT). EQs are simply indexe=
d with :
>>>>>>>>>>
>>>>>>>>>>        (server << 3) | (priority & 0x7)
>>>>>>>>>>
>>>>>>>>>> This is not in the XIVE architecture but as the EQ index is ne=
ver
>>>>>>>>>> exposed to the guest, in the hcalls nor in the device tree, we=
 are
>>>>>>>>>> free to use what fits best the current model.
>>>>>>>>
>>>>>>>> This EQ indexing is important to notice because it will also sho=
w up=20
>>>>>>>> in KVM to build the IVE from the KVM irq state.
>>>>>>>
>>>>>>> Ok, are you saying that while this combined EQ index will never a=
ppear
>>>>>>> in guest <-> host interfaces,=20
>>>>>>
>>>>>> Indeed.
>>>>>>
>>>>>>> it might show up in qemu <-> KVM interfaces?
>>>>>>
>>>>>> Not directly but it is part of the IVE as the IVE_EQ_INDEX field. =
When
>>>>>> dumped, it has to be built in some ways, compatible with the emula=
ted=20
>>>>>> mode in QEMU.=20
>>>>>
>>>>> Hrm.  But is the exact IVE contents visible to qemu (for a PAPR
>>>>> guest)? =20
>>>>
>>>> The guest only uses hcalls which arguments are :
>>>> =20
>>>> 	- cpu numbers,
>>>> 	- priority numbers from defined ranges,=20
>>>> 	- logical interrupt numbers. =20
>>>> 	- physical address of the EQ=20
>>>>
>>>> The visible parts for the guest of the IVE are the 'priority', the '=
cpu',=20
>>>> and the 'eisn', which is the effective IRQ number the guest is assig=
ning=20
>>>> to the source. The 'eisn" will be pushed in the EQ.
>>>
>>> Ok.
>>>
>>>> The IVE EQ index is not visible.
>>>
>>> Good.
>>>
>>>>> I would have thought the qemu <-> KVM interfaces would have
>>>>> abstracted this the same way the guest <-> KVM interfaces do.  > Or=
 is there a reason not to?
>>>>
>>>> It is practical to dump 64bit IVEs directly from KVM into the QEMU=20
>>>> internal structures because it fits the emulated mode without doing=20
>>>> any translation ... This might be seen as a shortcut. You will tell=20
>>>> me when you reach the KVM part.  =20
>>>
>>> Ugh.. exposing to qemu the raw IVEs sounds like a bad idea to me.
>>
>> You definitely need to in QEMU in emulation mode. The whole routing=20
>> relies on it.=20
>=20
> I'm not exactly sure what you mean by "emulation mode" here.  Above,
> I'm talking specifically about a KVM HV, PAPR guest.

ah ok. I understand.=20

KVM does not manipulate raw IVEs. Only OPAL manipulates the raw=20
XIVE structures. But as the emulation mode under QEMU needs to=20
also manipulate these structures, it seemed practical to use raw=20
XIVE structures to transfer the state from KVM to QEMU.=20

But, It might not be such a great idea. I suppose we should define=20
a QEMU/KVM format for the exchanges with KVM and then, inside QEMU,=20
have a translation QEMU/KVM to XIVE. The XIVE format being the
format used for migration.


>>> When we migrate, we're going to have to assign the guest (server,
>>> priority) tuples to host EQ indicies, and I think it makes more sense
>>> to do that in KVM and hide the raw indices from qemu than to have qem=
u
>>> mangle them explicitly on migration.
>>
>> We will need some mangling mechanism for the KVM ioctls saving and
>> restoring state. This is very similar to XICS.=20
>> =20
>>>>>>>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>>>>>>>
>>>>>>>>> Is the EQD actually modifiable by a guest?  Or are the settings=
 of the
>>>>>>>>> EQs fixed by PAPR?
>>>>>>>>
>>>>>>>> The guest uses the H_INT_SET_QUEUE_CONFIG hcall to define the ad=
dress
>>>>>>>> of the event queue for a couple prio/server.
>>>>>>>
>>>>>>> Ok, so the EQD can be modified by the guest.  In which case we ne=
ed to
>>>>>>> work out what object owns it, since it'll need to migrate it.
>>>>>>
>>>>>> Indeed. The EQD are CPU related as there is one EQD per couple (cp=
u,=20
>>>>>> priority). The KVM patchset dumps/restores the eight XiveEQ struct=
=20
>>>>>> using per cpu ioctls. The EQ in the OS RAM is marked dirty at that
>>>>>> stage.
>>>>>
>>>>> To make sure I'm clear: for PAPR there's a strict relationship betw=
een
>>>>> EQD and CPU (one EQD for each (cpu, priority) tuple). =20
>>>>
>>>> Yes.
>>>>
>>>>> But for powernv that's not the case, right? =20
>>>>
>>>> It is.
>>>
>>> Uh.. I don't think either of us phrased that well, I'm still not sure
>>> which way you're answering that.
>>
>> there's a strict relationship between EQD and CPU (one EQD for each (c=
pu, priority) tuple) in spapr and in powernv.
>=20
> For powernv that seems to be contradicted by what you say below.

ok. I see what you mean. There is a difference for the hypervisor when=20
guests are running. As QEMU PowerNV does not support guests (yet),=20
when can start the model with a strict relationship between EQD and=20
CPU.

But it's not the case when guest are running, because the EQD refers=20
to a NVT/VP which can be a virtual processor or a group of such.=20

The current model is taking a shortcut, the CPU list should be scanned
to find matching CAM lines (W2 in the TIMA). I need to take a closer
look for powernv even if it is not strictly needed for the model=20
without guest.=20

> AFAICT there might be a strict association at the host kernel or even
> the OPAL level, but not at the hardware level.
>=20
>>>>> AIUI the mapping of EQs to cpus was configurable, is that right?
>>>>
>>>> Each cpu has 8 EQD. Same for virtual cpus.
>>>
>>> Hmm.. but is that 8 EQD per cpu something built into the hardware, or
>>> just a convention of how the host kernel and OPAL operate?
>>
>> It's not in the HW, it is used by the HW to route the notification.=20
>> The EQD contains the EQ characteristics :
>>
>> * functional bits :
>>   - valid bit
>>   - enqueue bit, to update OS in RAM EQ or not
>>   - unconditional notification
>>   - backlog
>>   - escalation
>>   - ...
>> * OS EQ fields=20
>>   - physical address
>>   - entry index
>>   - toggle bit
>> * NVT fields
>>   - block/chip
>>   - index
>> * etc.
>>
>> It's a big structure : 8 words.
>=20
> Ok.  So yeah, the cpu association of the EQ is there in the NVT
> fields, not baked into the hardware.

yes.

C.=20

>> The EQD table is allocated by OPAL/skiboot and fed to the HW for
>> its use. The OS powernv uses OPAL calls  configure the EQD with its=20
>> needs :=20
>>
>> int64_t opal_xive_set_queue_info(uint64_t vp, uint32_t prio,
>> 				 uint64_t qpage,
>> 				 uint64_t qsize,
>> 				 uint64_t qflags);
>>
>>
>> sPAPR uses an hcall :
>>
>> static long plpar_int_set_queue_config(unsigned long flags,
>> 				       unsigned long target,
>> 				       unsigned long priority,
>> 				       unsigned long qpage,
>> 				       unsigned long qsize)
>>
>>
>> but it is translated in an OPAL call in KVM.
>>
>> C.
>>
>> =20
>>> =20
>>>>
>>>> I am not sure what you understood before ? It is surely something
>>>> I wrote, my XIVE understanding is still making progress.
>>>>
>>>>
>>>> C.
>>>>
>>>
>>
>=20
