Received: from eggs.gnu.org ([2001:4830:134:3::10]:38199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fE7PQ-00040v-JU
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:08:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fE7PN-00053q-DR
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:08:04 -0400
Received: from 20.mo4.mail-out.ovh.net ([46.105.33.73]:36483)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fE7PN-00053D-7B
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:08:01 -0400
Received: from player714.ha.ovh.net (unknown [10.109.108.61])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id AD55C16AAC8
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 08:07:59 +0200 (CEST)
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-8-clg@kaod.org>
	<20180426072501.GK8800@umbus.fritz.box>
	<312cdfe7-bc6b-3eed-588e-a71ce1385988@kaod.org>
	<20180503054534.GU13229@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <cf8ab4bd-8704-aa3f-a4c2-5f459c7dddd4@kaod.org>
Date: Thu, 3 May 2018 08:07:54 +0200
MIME-Version: 1.0
In-Reply-To: <20180503054534.GU13229@umbus.fritz.box>
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

On 05/03/2018 07:45 AM, David Gibson wrote:
> On Thu, Apr 26, 2018 at 11:48:06AM +0200, C=E9dric Le Goater wrote:
>> On 04/26/2018 09:25 AM, David Gibson wrote:
>>> On Thu, Apr 19, 2018 at 02:43:03PM +0200, C=E9dric Le Goater wrote:
>>>> The Event Queue Descriptor (EQD) table is an internal table of the
>>>> XIVE routing sub-engine. It specifies on which Event Queue the event
>>>> data should be posted when an exception occurs (later on pulled by t=
he
>>>> OS) and which Virtual Processor to notify.
>>>
>>> Uhhh.. I thought the IVT said which queue and vp to notify, and the
>>> EQD gave metadata for event queues.
>>
>> yes. the above poorly written. The Event Queue Descriptor contains the
>> guest address of the event queue in which the data is written. I will=20
>> rephrase.     =20
>>
>> The IVT contains IVEs which indeed define for an IRQ which EQ to notif=
y=20
>> and what data to push on the queue.=20
>> =20
>>>> The Event Queue is a much
>>>> more complex structure but we start with a simple model for the sPAP=
R
>>>> machine.
>>>>
>>>> There is one XiveEQ per priority and these are stored under the XIVE
>>>> virtualization presenter (sPAPRXiveNVT). EQs are simply indexed with=
 :
>>>>
>>>>        (server << 3) | (priority & 0x7)
>>>>
>>>> This is not in the XIVE architecture but as the EQ index is never
>>>> exposed to the guest, in the hcalls nor in the device tree, we are
>>>> free to use what fits best the current model.
>>
>> This EQ indexing is important to notice because it will also show up=20
>> in KVM to build the IVE from the KVM irq state.
>=20
> Ok, are you saying that while this combined EQ index will never appear
> in guest <-> host interfaces,=20

Indeed.

> it might show up in qemu <-> KVM interfaces?

Not directly but it is part of the IVE as the IVE_EQ_INDEX field. When
dumped, it has to be built in some ways, compatible with the emulated=20
mode in QEMU.=20

>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>
>>> Is the EQD actually modifiable by a guest?  Or are the settings of th=
e
>>> EQs fixed by PAPR?
>>
>> The guest uses the H_INT_SET_QUEUE_CONFIG hcall to define the address
>> of the event queue for a couple prio/server.
>=20
> Ok, so the EQD can be modified by the guest.  In which case we need to
> work out what object owns it, since it'll need to migrate it.

Indeed. The EQD are CPU related as there is one EQD per couple (cpu,=20
priority). The KVM patchset dumps/restores the eight XiveEQ struct=20
using per cpu ioctls. The EQ in the OS RAM is marked dirty at that
stage.

C.=20
