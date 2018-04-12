Received: from eggs.gnu.org ([2001:4830:134:3::10]:38636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f6Xwo-0001X5-OV
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f6Xwl-0005Eb-GC
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:51:14 -0400
Received: from 8.mo7.mail-out.ovh.net ([46.105.77.114]:55985)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f6Xwl-0005EC-6y
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:51:11 -0400
Received: from player773.ha.ovh.net (unknown [10.109.105.118])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 888B9A11C2
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 10:51:09 +0200 (CEST)
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-3-clg@kaod.org>
	<20171220050947.GC5981@umbus.fritz.box>
	<1513815126.2743.34.camel@kernel.crashing.org>
	<6768575f-27e0-1277-3e7e-56ec44298e6a@kaod.org>
	<1513896817.2743.63.camel@kernel.crashing.org>
	<683d0912-ad48-927c-8235-5358417be44c@kaod.org>
	<1516187433.31850.189.camel@kernel.crashing.org>
	<2226ed5e-f666-8060-2edd-998d2f5107ed@kaod.org>
	<20180412051503.GN9425@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <53f375bf-bbff-f51d-0554-ff657a2424c5@kaod.org>
Date: Thu, 12 Apr 2018 10:51:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180412051503.GN9425@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/19] spapr: introduce a skeleton for
 the XIVE interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

On 04/12/2018 07:15 AM, David Gibson wrote:
> On Wed, Jan 17, 2018 at 03:39:46PM +0100, C=E9dric Le Goater wrote:
>> On 01/17/2018 12:10 PM, Benjamin Herrenschmidt wrote:
>>> On Wed, 2018-01-17 at 10:18 +0100, C=E9dric Le Goater wrote:
>>>>>>> Also, have we decided how the process of switching between XICS a=
nd
>>>>>>> XIVE will work vs. CAS ?=20
>>>>>>
>>>>>> That's how it is described in the architecture. The current choice=
 is
>>>>>> to create both XICS and XIVE objects and choose at CAS which one t=
o
>>>>>> use. It relies today on the capability of the pseries machine to=20
>>>>>> allocate IRQ numbers for both interrupt controller backends. These
>>>>>> patches have been merged in QEMU.
>>>>>>
>>>>>> A change of interrupt mode results in a reset. The device tree is=20
>>>>>> populated accordingly and the ICPs are switched for the model in=20
>>>>>> use.=20
>>>>>
>>>>> For KVM we need to only instanciate one of them though.
>>>>
>>>> Hmm,
>>>>
>>>> How would we handle a guest rebooting on a kernel without XIVE suppo=
rt ?=20
>>>
>>> It will do CAS again and we can change the devices.
>>
>> So, we would destroy the previous QEMU ICS object and create a new one=
=20
>> in the CAS hcall. That would probably work. There might be some issues=
=20
>> in creating and destroying the ICS KVM device, but that can be studied=
=20
>> without XIVE.
>=20
> Adding and removing devices at runtime based on guest requests like
> this will get really hairy in qemu.

I confirm ...

> As I've said before for the first cut, I think we want to select just
> one as a machine option to avoid this confusion.

OK

> Looking further ahead, I think we'll be better off having both the
> XIVE and XICS models always present (at least minimally) in qemu, but
> with only one "active" at any given time.

Under emulation it is not too complex to support both mode.=20
XIVE and XICS objects are both created but spapr->ov5_cas=20
filters their usage=20

However, syncing the change in KVM is more complex.

> Note that having the inactive one destroy and clean up the
> corresponding KVM devices is fine, as is deallocating as much of its
> runtime state as we can without changing the notional QOM tree.

yes. I will try to send a patchset organized that way :=20

 - spapr XIVE emulated mode (both mode supported)
 - XIVE KVM in an exclusive way, the machine will need to be
   restarted from the command line to change interrupt mode.  =20
 - support of change of interrupt mode under KVM=20
 - powernv device model (rough)


C.

>> It used to be considered ugly to create a QEMU device at reset time, s=
o=20
>> I wonder if this is still the case, because when the machine reaches C=
AS,=20
>> we really are beyond reset.  =20
>>
>> If this is OK, then the next "issue" is to keep in sync the allocated=20
>> IRQ numbers. The IRQ allocator is now merged at the machine level, so=20
>> the synchronization is obvious to do when both backend QEMU objects=20
>> are available. that's the path I took. If both QEMU objects are not=20
>> available, then we need to scan the IRQ number space in the current=20
>> interrupt mode and allocate the same IRQs in the newly negotiated mode=
.=20
>> Probably OK. I don't see major problems with the current code.=20
>>
>> Migration is a problem. We will need both backend QEMU objects to be=20
>> available anyhow if we want to migrate. So we are back to the current=20
>> solution creating both QEMU objects but we can try to defer some of th=
e=20
>> KVM inits and create the KVM device on demand at CAS time.
>>
>> The next problem is the ICP object that currently needs the KVM device=
=20
>> fd to connect the vcpus ... So, we will need to change that also.=20
>> That is probably the biggest problem today. We need a way to disconnec=
t=20
>> the vpcu from the KVM device and see how we can defer the connection.
>> I need to make sure this is possible, I can check that without XIVE
>> I think.
>>
>>>> Are you suggesting to create the XICS or XIVE device in the CAS nego=
tiation=20
>>>> process ? So, the machine would not have any interrupt controller be=
fore=20
>>>> CAS. That seems really late to me. grub uses the console for instanc=
e.=20
>>>
>>> We start with XICS by default.
>>
>> yes.
>>
>>>> I think it should prepare for both options, start in XIVE legacy mod=
e,=20
>>>> which is XICS, then possibly switch to XIVE exploitation mode.
>>>>
>>>>>>> And how that will interact with KVM ?=20
>>>>>>
>>>>>> I expect we will do the same, which is to create two KVM devices t=
o=20
>>>>>> be able to handle both interrupt controller backends depending on =
the=20
>>>>>> mode negotiated by the guest. =20
>>>>>
>>>>> That will be an ungodly mess, I'd rather we only instanciate the ri=
ght
>>>>> one.
>>>>
>>>> It's rather transparent currently in the emulated version. There are=
 two=20
>>>> sets of objects in QEMU, switching is done in CAS. KVM support shoul=
d not=20
>>>> change anything in that area.=20
>>>>
>>>> I expect the 'xive-kvm' object to get/set states for migration, just=
 like=20
>>>> for XICS and to setup the ESB+TIMA memory regions, which is new.=20
>>>
>>> But both XICS and XIVE are completely different kernel KVM devices th=
at will
>>> need to "hook" into the same set of internal hooks for things like in=
terrupts
>>> being passed through, RTAS calls etc...=20
>>>
>>> How does KVM knows which one to "activate" ?
>>
>> Can't we add an extra IRQ type and use vcpu->arch.irq_type for that ?=20
>> I haven't studied all the low level details though.
>>
>>> I don't think the kernel should have both.=20
>>
>> I hear that. From a QEMU perspective, it is much easier to put everyth=
ing=20
>> in place for both interrupt modes and let the guest decide what it wan=
ts=20
>> to use.=20
>>
>> If we choose not to, we will need to find solution to defer the KVM in=
its
>> and to disconnect/reconnect the vcpus. For the latter, we could add a=20
>> KVM_DISABLE_CAP ioctl or maybe better add a new capability like=20
>> KVM_CAP_IRQ_XIVE to perform the switch.
>>
>>
>> C.
>>
>=20
