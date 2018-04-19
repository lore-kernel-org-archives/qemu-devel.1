Received: from eggs.gnu.org ([2001:4830:134:3::10]:38609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f9DXl-0003x9-Aa
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f9DXi-0005fO-1J
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:40:25 -0400
Received: from 6.mo178.mail-out.ovh.net ([46.105.53.132]:36984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f9DXh-0005eS-JG
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:40:21 -0400
Received: from player792.ha.ovh.net (unknown [10.109.105.75])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 8F1C913EC9
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 19:40:19 +0200 (CEST)
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-3-clg@kaod.org>
	<20171220050947.GC5981@umbus.fritz.box>
	<3f2d34d0-9ba0-1321-a6bd-55546c67c8c7@kaod.org>
	<20180412050707.GK9425@umbus.fritz.box>
	<2737e5a4-8859-4790-b368-afef253225cf@kaod.org>
	<20180416042605.GC20551@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <af9278d1-a0e7-2ee6-7901-d80536932245@kaod.org>
Date: Thu, 19 Apr 2018 19:40:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180416042605.GC20551@umbus.fritz.box>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kurz <groug@kaod.org>

On 04/16/2018 06:26 AM, David Gibson wrote:
> On Thu, Apr 12, 2018 at 10:18:11AM +0200, C=E9dric Le Goater wrote:
>> On 04/12/2018 07:07 AM, David Gibson wrote:
>>> On Wed, Dec 20, 2017 at 08:38:41AM +0100, C=E9dric Le Goater wrote:
>>>> On 12/20/2017 06:09 AM, David Gibson wrote:
>>>>> On Sat, Dec 09, 2017 at 09:43:21AM +0100, C=E9dric Le Goater wrote:
>>>>>> With the POWER9 processor comes a new interrupt controller called
>>>>>> XIVE. It is composed of three sub-engines :
>>>>>>
>>>>>>   - Interrupt Virtualization Source Engine (IVSE). These are in PH=
Bs,
>>>>>>     in the main controller for the IPIS and in the PSI host
>>>>>>     bridge. They are configured to feed the IVRE with events.
>>>>>>
>>>>>>   - Interrupt Virtualization Routing Engine (IVRE). Their job is t=
o
>>>>>>     match an event source with a Notification Virtualization Targe=
t
>>>>>>     (NVT), a priority and an Event Queue (EQ) to determine if a
>>>>>>     Virtual Processor can handle the event.
>>>>>>
>>>>>>   - Interrupt Virtualization Presentation Engine (IVPE). It mainta=
ins
>>>>>>     the interrupt state of each hardware thread and present the
>>>>>>     notification as an external exception.
>>>>>>
>>>>>> Each of the engines uses a set of internal tables to redirect
>>>>>> exceptions from event sources to CPU threads. The first table we
>>>>>> introduce is the Interrupt Virtualization Entry (IVE) table, part =
of
>>>>>> the virtualization engine in charge of routing events. It associat=
es
>>>>>> event sources (IRQ numbers) to event queues which will forward, or
>>>>>> not, the event notification to the presentation controller.
>>>>>>
>>>>>> The XIVE model is designed to make use of the full range of the IR=
Q
>>>>>> number space and does not use an offset like the XICS mode does.
>>>>>> Hence, the IVE table is directly indexed by the IRQ number.
>>>>>>
>>>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>>>
>>>>> As you've suggested in yourself, I think we might need to more
>>>>> explicitly model the different components of the XIVE system.  As p=
art
>>>>> of that, I think you need to be clearer in this base skeleton about
>>>>> exactly what component your XIVE object represents.
>>>
>>> Sorry it's been so long since I looked at these.
>>
>> That's fine. I have been working on a XIVE device model for the PowerN=
V
>> machine and KVM support for the pseries. I have a better understanding
>> of the overall picture.
>>
>> The patchset has not changed much so we can still discuss on this
>> basis without me flooding the mailing list.
>>
>>>> ok. The base skeleton is the IVRE, the central engine handling=20
>>>> the routing.=20
>>>>
>>>>> If the answer is "the overall thing"=20
>>>>
>>>> Yes, it is more or less that currently.=20
>>>>
>>>> The sPAPRXive object models the source engine and the routing=20
>>>> engine in one object.
>>>
>>> Yeah, I suspect we don't want that.  Although it might seem simpler i=
n
>>> the spapr case, at least at first glance, I think it will cause us
>>> problems later.  At the very least, it's likely to make it harder to
>>> share code between the spapr and powernv case.  I think it will also
>>> make for more confusion about exactly what things belong where.
>>
>> I tend to agree.=20
>>
>> We need to clarify (a bit) what is in the XIVE interrupt controller=20
>> silicon, and how XIVE works. The XIVE device models for spapr and=20
>> powernv should be very close as the differences are small. KVM support=
=20
>> should be built on the spapr model.
>>
>> There are 3 different sub-engines in the XIVE interrupt controller
>> device :
>>
>> * IVSE (XiveSource model)
>>
>>   interrupt sources, which expose their PQ bits through ESB MMIO pages=
=20
>>   (there are different levels of support depending on HW revision)=20
>>
>>   The XIVE interrupt controller has a set of internal sources for=20
>>   IPIs and CAPI like interrupts.
>=20
> Ok.  IIUC in hardware there's one of these in each PHB,=20

yes

> plus maybe one or two others.  Is that right?

yes. PSI for instance on PowerNV. I have this device as a first
xive source on Power?V

>>
>> * IVRE (No real model)
>>
>>   in the middle, doing the routing of source event notification to
>>   (cpu) targets. It relies on internal tables which are stored in=20
>>   the hypervisor/QEMU/KVM for the spapr machine and in the VM RAM=20
>>   for the powernv machine.
>=20
> What does VM RAM mean in the powernv context?

The PowerNV is indeed not a VM. So I meant the RAM of the QEMU PowerNV=20
machine. skiboot does the allocation and the HW setup using a set of=20
IC registers exposed as MMIOs.=20

>>   Configuration updates of the XIVE tables are done through hcalls=20
>>   on spapr and with MMIOs on the IC regs on powernv. On the latter,
>>   the changes are flushed backed in the VM RAM.=20
>>
>> * IVPE (XiveNVT)
>>
>>   set of registers for interrupt management at the CPU level. Exposed
>>   in a specific MMIO region called the TIMA.
>=20
> Ok.
>=20
>> The XIVE tables are :
>>
>> * IVT
>>
>>   associate an interrupt source number with an event queue. the data
>>   to be pushed in the queue is stored there also.
>=20
> Ok, so there would be one of these tables for each IVRE,=20

yes. one for each XIVE interrupt controller. That is one per processor=20
or socket.

> with one entry for each source managed by that IVSE, yes?

yes. The table is simply indexed by the interrupt number in the
global IRQ number space of the machine.

> Do the XIVE IPIs have entries here, or do they bypass this?

no. The IPIs have entries also in this table.

>> * EQDT:
>>
>>   describes the queues in the OS RAM, also contains a set of flags,
>>   a virtual target, etc.
>=20
> So on real hardware this would be global, yes?  And it would be
> consulted by the IVRE?

yes. Exactly. The XIVE routing routine :

	https://github.com/legoater/qemu/blob/xive/hw/intc/xive.c#L706

gives a good overview of the usage of the tables.

> For guests, we'd expect one table per-guest? =20

yes but only in emulation mode.=20

> How would those be integrated with the host table?

Under KVM, this is handled by the host table (setup done in skiboot)=20
and we are only interested in the state of the EQs for migration.=20
This state is set  with the H_INT_SET_QUEUE_CONFIG hcall, followed
by an OPAL call and then a HW update. It defines the EQ page in which
to push event notification for the couple server/priority.=20

>> * VPDT:
>>
>>   describe the virtual targets, which can have different natures,
>>   a lpar, a cpu. This is for powernv, spapr does not have this=20
>>   concept.
>=20
> Ok  On hardware that would also be global and consulted by the IVRE,
> yes?

yes.=20

> Under PAPR, I'm guessing the concept is missing because it essentially
> has a fixed contents: an entry for each vcpu=20

yes.

> and maybe one for the lpar as a whole?
That would be more a host concept. But, yes, it exists in XIVE.=20
=20
>> So, the idea behind the sPAPRXive object is to model a XIVE interrupt
>> controller device. It contains today :
>=20
> Yeah, what a "XIVE interrupt controller device" is not really clear to
> me.  If it's something that is necessarily global, I think you'll be
> better off making it a machine-interface rather than a distinct
> object.

hmm, OK. We do need a XiveSource object (like in the XICS) and an IVE=20
table. reshuffling is not a big problem. But then, we also have the
associated KVM device which is very much like the QEMU emulated device. =20

>>  - an internal source block for all interrupts : IPIs and virtual=20
>>    device interrupts. In the IRQ number space, the IPIs are below
>>    4096 and the device interrupts above, which keeps compatibility=20
>>    with XICS. This is important to be able to change interrupt mode.
>>
>>    PowerNV has different source blocks, like for P8.
>>
>>  - a routing engine, which is limited to the IVT. This is a shortcut=20
>>    and it might be better to introduce a specific object. Anyhow, this=
=20
>>    is a state to capture.
>=20
> Ok.  It sounds like this is roughly the equivalent of the XICSFabric,
> and likewise would probably be better handled by an interface on the
> machine=20

yes indeed. it is the case in v3. PowerNV isn't quite in sync with
this concept but it is getting close.=20

> rather than a distinct object.  But I'm not clear enough to be
> certain of that yet.

but we need to put the IVT somewhere.

>>    In the current version I am working on, the XiveFabric interface is
>>    more complex :
>>
>> 	typedef struct XiveFabricClass {
>> 	    InterfaceClass parent;
>> 	    XiveIVE *(*get_ive)(XiveFabric *xf, uint32_t lisn);
>=20
> This does an IVT lookup, I take it?

yes. It is an interface for the underlying storage, which is different
in sPAPR and PowerNV. The goal is to make the routing generic.=20

>> 	    XiveNVT *(*get_nvt)(XiveFabric *xf, uint32_t server);
>=20
> This one a VPDT lookup, yes?

yes.

>> 	    XiveEQ  *(*get_eq)(XiveFabric *xf, uint32_t eq_idx);
>=20
> And this one an EQDT lookup?

yes.

>> 	} XiveFabricClass;
>>
>>    It helps in making the routing algorithm independent of the model.=20
>>    I hope to make powernv converge and use it.
>>
>>  - a set of MMIOs for the TIMA. They model the presenter engine.=20
>>    current_cpu is used to retrieve the NVT object, which holds the=20
>>    registers for interrupt management. =20
>=20
> Right.  Now the TIMA is local to a target/server not an EQ, right?

The TIMA is the MMIO giving access to the registers which are per CPU.=20
The EQ are for routing. They are under the CPU object because it is=20
convenient.
=20
> I guess we need at least one of these per-vcpu. =20

yes.

> Do we also need an lpar-global, or other special ones?

That would be for the host. AFAICT KVM does not use such special
VPs.=20

>> The EQs are stored under the NVT. This saves us an unnecessary EQDT=20
>> table. But we could add one under the XIVE device model.
>=20
> I'm not sure of the distinction you're drawing between the NVT and the
> XIVE device mode.

we could add a new table under the XIVE interrupt device model=20
sPAPRXive to store the EQs and indexed them like skiboot does.=20
But it seems unnecessary to me as we can use the object below=20
'cpu->intc', which is the XiveNVT object. =20

C.
