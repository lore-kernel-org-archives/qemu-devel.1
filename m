Received: from eggs.gnu.org ([2001:4830:134:3::10]:44992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fEHQx-0004t5-6z
	for qemu-devel@nongnu.org; Thu, 03 May 2018 12:50:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fEHQu-0007rU-Fd
	for qemu-devel@nongnu.org; Thu, 03 May 2018 12:50:19 -0400
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:37811)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fEHQu-0007fW-5X
	for qemu-devel@nongnu.org; Thu, 03 May 2018 12:50:16 -0400
Received: from player714.ha.ovh.net (unknown [10.109.122.9])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id F23EDBCCB4
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 18:50:13 +0200 (CEST)
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-5-clg@kaod.org>
	<20180424065131.GQ19804@umbus.fritz.box>
	<5def5bbb-9842-0121-e889-014ba88fd4c5@kaod.org>
	<20180426042002.GF8800@umbus.fritz.box>
	<660d1e36-b269-0202-7ac5-570479bb4083@kaod.org>
	<20180503052205.GQ13229@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a671a058-ab56-6a97-d172-7fa22dca1f25@kaod.org>
Date: Thu, 3 May 2018 18:50:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180503052205.GQ13229@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 04/35] spapr/xive: introduce a XIVE
 interrupt controller for sPAPR
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

On 05/03/2018 07:22 AM, David Gibson wrote:
> On Thu, Apr 26, 2018 at 12:43:29PM +0200, C=E9dric Le Goater wrote:
>> On 04/26/2018 06:20 AM, David Gibson wrote:
>>> On Tue, Apr 24, 2018 at 11:46:04AM +0200, C=E9dric Le Goater wrote:
>>>> On 04/24/2018 08:51 AM, David Gibson wrote:
>>>>> On Thu, Apr 19, 2018 at 02:43:00PM +0200, C=E9dric Le Goater wrote:
>>>>>> sPAPRXive is a model for the XIVE interrupt controller device of t=
he
>>>>>> sPAPR machine. It holds the routing XIVE table, the Interrupt
>>>>>> Virtualization Entry (IVE) table which associates interrupt source
>>>>>> numbers with targets.
>>>>>>
>>>>>> Also extend the XiveFabric with an accessor to the IVT. This will =
be
>>>>>> needed by the routing algorithm.
>>>>>>
>>>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>>>> ---
>>>>>>
>>>>>>  May be should introduce a XiveRouter model to hold the IVT. To be
>>>>>>  discussed.
>>>>>
>>>>> Yeah, maybe.  Am I correct in thinking that on pnv there could be m=
ore
>>>>> than one XiveRouter?
>>>>
>>>> There is only one, the main IC.=20
>>>
>>> Ok, that's what I thought originally.  In that case some of the stuff
>>> in the patches really doesn't make sense to me.
>>
>> well, there is one IC per chip on powernv, but we haven't reach that p=
art
>> yet.
>=20
> Hmm.  There's some things we can delay dealing with, but I don't think
> this is one of them.  I think we need to understand how multichip is
> going to work in order to come up with a sane architecture.  Otherwise
> I fear we'll end up with something that we either need to horribly
> bastardize for multichip, or have to rework things dramatically
> leading to migration nightmares.

So, it is all controlled by MMIO, so we should be fine on that part.=20
As for the internal tables, they are all configured by firmware, using
a chip identifier (block). I need to check how the remote XIVE are=20
accessed. I think this is by MMIO.=20

I haven't looked at multichip XIVE support but I am not too worried as=20
the framework is already in place for the machine.
=20
>>>>> If we did have a XiveRouter, I'm not sure we'd need the XiveFabric
>>>>> interface, possibly its methods could just be class methods of
>>>>> XiveRouter.
>>>>
>>>> Yes. We could introduce a XiveRouter to share the ivt table between=20
>>>> the sPAPRXive and the PnvXIVE models, the interrupt controllers of
>>>> the machines. Methods would provide way to get the ivt/eq/nvt
>>>> objects required for routing. I need to add a set_eq() to push the
>>>> EQ data.
>>>
>>> Hrm.  Well, to add some more clarity, let's say the XiveRouter is the
>>> object which owns the IVT. =20
>>
>> OK. that would be a model with some state and not an interface.
>=20
> Yes.  For papr variant it would have the whole IVT contents as its
> state.  For the powernv, just the registers telling it where to find
> the IVT in RAM.
>=20
>>> It may or may not do other stuff as well.
>>
>> Its only task would be to do the final event routing: get the IVE,
>> get the EQ, push the EQ DATA in the OS event queue, notify the CPU.
>=20
> That seems like a lot of steps.  Up to push the EQ DATA, certainly.
> And I guess it'll have to ping an NVT somehow, but I'm not sure it
> should know about CPUs as such.

For PowerNV, the concept could be generalized, yes. An NVT can=20
contain the interrupt state of a logical server but the common=20
case is baremetal without guests for QEMU and so we have a NVT=20
per cpu.=20

PowerNV will have some limitation but we can make it better than=20
today for sure. It boots.

We can improve some of the NVT notification process, the way NVT=20
are matched eventually. may be support remote engines if the
NVT is not local. I have not looked at the details.

> I'm not sure at this stage what should own the EQD table.

The EQDT is in RAM.

> In the multichip case is there one EQD table for every IVT?

There is one EQDT per chip, same for the IVT. They are in RAM,=20
identified with a block ID.

>  I'm guessing
> not - I figure the EQD table must be effectively global so that any
> chip's router can send events to any EQ in the whole system.
>>>> Now IIUC, on pnv the IVT lives in main system memory. =20
>>
>> yes. It is allocated by skiboot in RAM and fed to the HW using some=20
>> IC configuration registers. Then, each entry is configured with OPAL=20
>> calls and the HW is updated using cache scrub registers.=20
>=20
> Right.  At least for the first pass we should be able to treat the
> cache scrub registers as no-ops and just not cache anything in the
> qemu implementation.

The model currently supports the cache scrub registers, we need it
to update some values. It's not too complex.=20


>>> Under PAPR is the IVT in guest memory, or is it outside (updated by
>>> hypercalls/rtas)?
>>
>> Under sPAPR, the IVT is updated by the H_INT_SET_SOURCE_CONFIG hcall
>> which configures the targeting of an IRQ. It's not in the guest=20
>> memory.
>=20
> Right.
>=20
>> Behind the hood, the IVT is still configured by OPAL under KVM and=20
>> by QEMU when kernel_irqchip=3Doff
>=20
> Sure.  Even with kernel_irqchip=3Don there's still logically a guest IV=
T
> (or "IVT view" I guess), even if it's actual entries are stored
> distributed across various places in the host's IVTs.

yes. The XIVE KVM device caches the info. This is used to dump the=20
state without doing OPAL calls.

C.=20


>>>> The XiveRouter would also be a XiveFabric (or some other name) to=20
>>>> let the internal sources of the interrupt controller forward events.
>>>
>>> The further we go here, the less sure I am that XiveFabric even makes
>>> sense as a concept.
>>
>> See previous email.
>=20
