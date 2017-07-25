Received: from eggs.gnu.org ([2001:4830:134:3::10]:48620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1da0CC-0005ay-EO
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1da0C9-0001E3-94
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:48:20 -0400
Received: from 1.mo68.mail-out.ovh.net ([46.105.41.146]:42508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1da0C9-0001Cj-04
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:48:17 -0400
Received: from player737.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 3BFBC7012A
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 15:48:12 +0200 (CEST)
References: <20170719030849.GQ3140@umbus.fritz.box>
	<1500436938.3350.11.camel@kernel.crashing.org>
	<20170721075015.GE3717@umbus.fritz.box>
	<1500625291.10674.22.camel@kernel.crashing.org>
	<20170724032853.GB17228@umbus.fritz.box>
	<1500872645.10674.52.camel@kernel.crashing.org>
	<20170724053827.GI17228@umbus.fritz.box>
	<1500880826.10674.66.camel@kernel.crashing.org>
	<20170724100314.GP17228@umbus.fritz.box>
	<17c42efa-9ef0-077b-a29b-e836f6643768@kaod.org>
	<20170725123939.GG8978@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e35e00f4-c90a-3169-7c80-aa0f5e1f2ca0@kaod.org>
Date: Tue, 25 Jul 2017 15:48:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170725123939.GG8978@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 04/26] ppc/xive: introduce a skeleton
 for the XIVE interrupt controller model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org

On 07/25/2017 02:39 PM, David Gibson wrote:
> On Tue, Jul 25, 2017 at 10:52:27AM +0200, C=E9dric Le Goater wrote:
>> On 07/24/2017 12:03 PM, David Gibson wrote:
>>> On Mon, Jul 24, 2017 at 05:20:26PM +1000, Benjamin Herrenschmidt wrot=
e:
>>>> On Mon, 2017-07-24 at 15:38 +1000, David Gibson wrote:
>>>>>
>>>>> Can we assign our logical numbers sparsely, or will that cause othe=
r
>>>>> problems?
>>>>
>>>> The main issue is that they probably needs to be the same between XI=
CS
>>>> and XIVE because by the time we get the CAS call to chose between XI=
CS
>>>> and XIVE, we have already handed out interrupts and constructed the =
DT,
>>>> no ? Unless we do a real CAS reboot...
>>>
>>> A real CAS reboot probably isn't unreasonable for this case.
>>>
>>> I definitely think we need to go one way or the other - either fully
>>> unify the irq mapping between xics and xive, or fully separate them.
>>
>> To be able to change interrupt model at CAS time, we need to unify=20
>> the IRQ numbering.
>=20
> Not necessarily, though it certainly might make things easier.
>=20
>> We don't have much choice because the DT is already populated.
>=20
> We could change that, though.

It would certainly help to manage the change of interrupt mode.
May be we could even instantiate only one sPAPR interrupt source
object at a time. Today I am instantiating two and switch from=20
one to another. I am not sure how compatible this is with migration=20
tough.

We would need to postpone all IRQ allocation until the CAS=20
negotiation is complete and populate the DT accordingly in the=20
CAS response. Hopefully I think this is the only reason why we do
an early allocation of the XICS or XIVE objects today.=20

I need to take a closer look at the spapr_ics_alloc() calls in=20
spapr_{events,pci,vio}.c files.

C.
=20
=20
>> We also need to share the ICSIRQState flags unless
>> we share the interrupt source object between the XIVE and XICS mode.=20
>>
>> In my current tree, I made sure that the same IRQ number ranges=20
>> were being used in the XIVE and in the XICS allocator and that the=20
>> ICSIRQState flags of the different sPAPR Interrupt sources (XIVE=20
>> and XICS) were in sync. That works pretty well for reset, migration=20
>> and hotplug, but it is bit hacky.
>>
>> C.
>>
>>
>>>> Otherwise, there's no reason they can't be sparse no.
>>>>
>>>>> Note that for PAPR we also have the question of finding logical
>>>>> interrupts for legacy PAPR VIO devices.
>>>>
>>>> We just make them another range ? With KVM legacy today, I just use =
the
>>>> generic interrupt facility for those. So when you do the ioctl to
>>>> "trigger" one, I just do an MMIO to the corresponding page and the
>>>> interrupt magically shows up wherever the guest is running the targe=
t
>>>> vcpu. In fact, I'd like to add a way to mmap that page into qemu so
>>>> that qemu can triggers them without an ioctl.
>>>
>>> Ok.
>>>
>>>> The guest doesn't care, from the guest perspective they are interrup=
ts
>>>> coming from the DT, so they are like PCI etc...
>>>
>>> Ok.
>>>
>>>>>> We can fix the number of "generic" interrupts given to a guest. Th=
e
>>>>>> only requirements from a PAPR perspective is that there should be =
at
>>>>>> least as many as there are possible threads in the guest so they c=
an be
>>>>>> used as IPIs.
>>>>>
>>>>> Ok.  If we can do things sparsely, allocating these well away from =
the
>>>>> hw interrupts would make things easier.
>>>>>
>>>>>> But we may need more for other things. We can make this a machine
>>>>>> parameter with a default value of something like 4096. If we call =
N
>>>>>> that number of extra generic interrupts, then the number of generi=
c
>>>>>> interrutps would be #possible-vcpu's + N, or something like that.
>>>>>
>>>>> That seems reasonable.
>>>>>
>>>>>>>> But it's fundamentally an allocator that sits in the hypervisor,=
 so in
>>>>>>>> our case, I would say in the spapr "component" of XIVE, rather t=
han the
>>>>>>>> XIVE HW model itself.
>>>>>>>
>>>>>>> Maybe..
>>>>>>
>>>>>> You are right in that a mapping is a better term than an allocator
>>>>>> here.
>>>>>>
>>>>>>>> Now what Cedric did, because XIVE is very complex and we need so=
mething
>>>>>>>> for PAPR quickly, is not a complete HW model, but a somewhat sim=
plified
>>>>>>>> one that only handles what PAPR exposes. So in that case where t=
he
>>>>>>>> allocator sits is a bit of a TBD...
>>>>>>>
>>>>>>> Hm, ok.  My concern here is that "dynamic" allocation of irqs at =
the
>>>>>>> machine type level needs extreme caution, or the irqs may not be
>>>>>>> stable which will generally break migration.
>>>>>>
>>>>>> Yes you are right. We should probably create a more "static" schem=
e.
>>>>>
>>>>> Sounds like we're in violent agreement.
>>>>
>>>> Yup :)
>>>>
>>>
>>
>=20
