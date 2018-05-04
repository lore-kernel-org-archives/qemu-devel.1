Received: from eggs.gnu.org ([2001:4830:134:3::10]:47330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fEck5-0007wq-L4
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fEck2-00074j-FF
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:35:29 -0400
Received: from 14.mo4.mail-out.ovh.net ([46.105.40.29]:35529)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fEck2-00073k-4p
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:35:26 -0400
Received: from player714.ha.ovh.net (unknown [10.109.120.50])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 71B7E16C490
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 17:35:24 +0200 (CEST)
References: <20171220050947.GC5981@umbus.fritz.box>
	<3f2d34d0-9ba0-1321-a6bd-55546c67c8c7@kaod.org>
	<20180412050707.GK9425@umbus.fritz.box>
	<2737e5a4-8859-4790-b368-afef253225cf@kaod.org>
	<20180416042605.GC20551@umbus.fritz.box>
	<af9278d1-a0e7-2ee6-7901-d80536932245@kaod.org>
	<20180426053654.GH8800@umbus.fritz.box>
	<6ccceb5a-e2fc-6fa3-cc40-c701e5047590@kaod.org>
	<20180503022951.GK13229@umbus.fritz.box>
	<57a32761-c331-214d-7542-4b19a1632c22@kaod.org>
	<20180504063545.GB13229@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3d98bfee-54d5-251c-835b-9dff2efdbba3@kaod.org>
Date: Fri, 4 May 2018 17:35:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180504063545.GB13229@umbus.fritz.box>
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

On 05/04/2018 08:35 AM, David Gibson wrote:
> On Thu, May 03, 2018 at 10:43:47AM +0200, C=E9dric Le Goater wrote:
>> On 05/03/2018 04:29 AM, David Gibson wrote:
>>> On Thu, Apr 26, 2018 at 10:17:13AM +0200, C=E9dric Le Goater wrote:
>>>> On 04/26/2018 07:36 AM, David Gibson wrote:
>>>>> On Thu, Apr 19, 2018 at 07:40:09PM +0200, C=E9dric Le Goater wrote:
>>>>>> On 04/16/2018 06:26 AM, David Gibson wrote:
>>>>>>> On Thu, Apr 12, 2018 at 10:18:11AM +0200, C=E9dric Le Goater wrot=
e:
>>>>>>>> On 04/12/2018 07:07 AM, David Gibson wrote:
>>>>>>>>> On Wed, Dec 20, 2017 at 08:38:41AM +0100, C=E9dric Le Goater wr=
ote:
>>>>>>>>>> On 12/20/2017 06:09 AM, David Gibson wrote:
>>>>>>>>>>> On Sat, Dec 09, 2017 at 09:43:21AM +0100, C=E9dric Le Goater
>>>>>> wrote:
>>>>> [snip]
>>>>>>>> The XIVE tables are :
>>>>>>>>
>>>>>>>> * IVT
>>>>>>>>
>>>>>>>>   associate an interrupt source number with an event queue. the =
data
>>>>>>>>   to be pushed in the queue is stored there also.
>>>>>>>
>>>>>>> Ok, so there would be one of these tables for each IVRE,=20
>>>>>>
>>>>>> yes. one for each XIVE interrupt controller. That is one per proce=
ssor=20
>>>>>> or socket.
>>>>>
>>>>> Ah.. so there can be more than one in a multi-socket system.
>>>>>  >>> with one entry for each source managed by that IVSE, yes?
>>>>>>
>>>>>> yes. The table is simply indexed by the interrupt number in the
>>>>>> global IRQ number space of the machine.
>>>>>
>>>>> How does that work on a multi-chip machine?  Does each chip just ha=
ve
>>>>> a table for a slice of the global irq number space?
>>>>
>>>> yes. IRQ Allocation is done relative to the chip, each chip having=20
>>>> a range depending on its block id. XIVE has a concept of block,
>>>> which is used in skiboot in a one-to-one relationship with the chip.
>>>
>>> Ok.  I'm assuming this block id forms the high(ish) bits of the globa=
l
>>> irq number, yes?
>>
>> yes. the 8 top bits are reserved, the next 4 bits are for the=20
>> block id, 16 blocks for 16 socket/chips, and the 20 lower bits=20
>> are for the ISN.
>=20
> Ok.
>=20
>>>>>>> Do the XIVE IPIs have entries here, or do they bypass this?
>>>>>>
>>>>>> no. The IPIs have entries also in this table.
>>>>>>
>>>>>>>> * EQDT:
>>>>>>>>
>>>>>>>>   describes the queues in the OS RAM, also contains a set of fla=
gs,
>>>>>>>>   a virtual target, etc.
>>>>>>>
>>>>>>> So on real hardware this would be global, yes?  And it would be
>>>>>>> consulted by the IVRE?
>>>>>>
>>>>>> yes. Exactly. The XIVE routing routine :
>>>>>>
>>>>>> 	https://github.com/legoater/qemu/blob/xive/hw/intc/xive.c#L706
>>>>>>
>>>>>> gives a good overview of the usage of the tables.
>>>>>>
>>>>>>> For guests, we'd expect one table per-guest? =20
>>>>>>
>>>>>> yes but only in emulation mode.=20
>>>>>
>>>>> I'm not sure what you mean by this.
>>>>
>>>> I meant the sPAPR QEMU emulation mode. Linux/KVM relies on the overa=
ll=20
>>>> table allocated in OPAL for the system.=20
>>>
>>> Right.. I'm thinking of this from the point of view of the guest
>>> and/or qemu, rather than from the implementation.  Even if the actual
>>> storage of the entries is distributed across the host's global table,
>>> we still logically have a table per guest, right?
>>
>> Yes. (the XiveSource object would be the table-per-guest and its=20
>> counterpart in KVM: the source block)
>=20
> Uh.. I'm talking about the IVT (or a slice of it) here, so this would
> be a XiveRouter, not a XiveSource owning it.

yes. Sorry. sPAPR has a unique XiveSource and a corresponding IVT.

>>>>>>> How would those be integrated with the host table?
>>>>>>
>>>>>> Under KVM, this is handled by the host table (setup done in skiboo=
t)=20
>>>>>> and we are only interested in the state of the EQs for migration.
>>>>>
>>>>> This doesn't make sense to me; the guest is able to alter the IVT
>>>>> entries, so that configuration must be migrated somehow.
>>>>
>>>> yes. The IVE needs to be migrated. We use get/set KVM ioctls to save=
=20
>>>> and restore the value which is cached in the KVM irq state struct=20
>>>> (server, prio, eq data). no OPAL calls are needed though.
>>>
>>> Right.  Again, at this stage I don't particularly care what the
>>> backend details are - whether the host calls OPAL or whatever.  I'm
>>> more concerned with the logical model.
>>
>> ok.
>>
>>>
>>>>>> This state is set  with the H_INT_SET_QUEUE_CONFIG hcall,
>>>>>
>>>>> "This state" here meaning IVT entries?
>>>>
>>>> no. The H_INT_SET_QUEUE_CONFIG sets the event queue OS page for a=20
>>>> server/priority couple. That is where the event queue data is
>>>> pushed.
>>>
>>> Ah.  Doesn't that mean the guest *does* effectively have an EQD table=
,
>>
>> well, yes, it's behing the hood. but the guest does not know anything=20
>> about the Xive controller internal structures, IVE, EQD, VPD and table=
s.=20
>> Only OPAL does in fact.
>=20
> Right, it's under the hood.  But then so is the IVT (and the TCE
> tables and the HPT for that matter).  So we're probably going to have
> a (*get_eqd) method somewhere that looks up in guest RAM or in an
> external table depending.

yes. definitely.=20

C.

>>> updated by this call? =20
>>
>> it is indeed the purpose of H_INT_SET_QUEUE_CONFIG
>>
>>> We'd need to migrate that data as well,=20
>>
>> yes we do and some fields require OPAL support.
>>
>>> and it's not part of the IVT, right?
>>
>> yes. The IVT only contains the EQ index, the server/priority tuple use=
d=20
>> for routing.
>>
>>>> H_INT_SET_SOURCE_CONFIG does the targeting : irq, server, priority,
>>>> and the eq data to be pushed in case of an event.
>>>
>>> Ok - that's the IVT entries, yes?
>>
>> yes.
>>
>>
>>>>>> followed
>>>>>> by an OPAL call and then a HW update. It defines the EQ page in wh=
ich
>>>>>> to push event notification for the couple server/priority.=20
>>>>>>
>>>>>>>> * VPDT:
>>>>>>>>
>>>>>>>>   describe the virtual targets, which can have different natures=
,
>>>>>>>>   a lpar, a cpu. This is for powernv, spapr does not have this=20
>>>>>>>>   concept.
>>>>>>>
>>>>>>> Ok  On hardware that would also be global and consulted by the IV=
RE,
>>>>>>> yes?
>>>>>>
>>>>>> yes.
>>>>>
>>>>> Except.. is it actually global, or is there one per-chip/socket?
>>>>
>>>> There is a global VP allocator splitting the ids depending on the
>>>> block/chip, but, to be honest, I have not dug in the details
>>>>
>>>>> [snip]
>>>>>>>>    In the current version I am working on, the XiveFabric interf=
ace is
>>>>>>>>    more complex :
>>>>>>>>
>>>>>>>> 	typedef struct XiveFabricClass {
>>>>>>>> 	    InterfaceClass parent;
>>>>>>>> 	    XiveIVE *(*get_ive)(XiveFabric *xf, uint32_t lisn);
>>>>>>>
>>>>>>> This does an IVT lookup, I take it?
>>>>>>
>>>>>> yes. It is an interface for the underlying storage, which is diffe=
rent
>>>>>> in sPAPR and PowerNV. The goal is to make the routing generic.
>>>>>
>>>>> Right.  So, yes, we definitely want a method *somehwere* to do an I=
VT
>>>>> lookup.  I'm not entirely sure where it belongs yet.
>>>>
>>>> Me either. I have stuffed the XiveFabric with all the abstraction=20
>>>> needed for the moment.=20
>>>>
>>>> I am starting to think that there should be an interface to forward=20
>>>> events and another one to route them. The router being a special cas=
e=20
>>>> of the forwarder, the last one. The "simple" devices, like PSI, shou=
ld=20
>>>> only be forwarders for the sources they own but the interrupt contro=
llers=20
>>>> should be forwarders (they have sources) and also routers.
>>>
>>> I'm not really clear what you mean by "forward" here.
>>
>> When a interrupt source is triggered, a notification event can
>> be generated and forwarded to the XIVE router if the transition=20
>> algo (depending on the PQ bit) lets it through. A forward is=20
>> a simple load of the IRQ number at a specific MMIO address defined
>> by the main IC.
>>
>> For QEMU sPAPR, it's a funtion call but for QEMU powernv, it's a
>> load.
>>
>> C.
>>
>>
>>>>>>>> 	    XiveNVT *(*get_nvt)(XiveFabric *xf, uint32_t server);
>>>>>>>
>>>>>>> This one a VPDT lookup, yes?
>>>>>>
>>>>>> yes.
>>>>>>
>>>>>>>> 	    XiveEQ  *(*get_eq)(XiveFabric *xf, uint32_t eq_idx);
>>>>>>>
>>>>>>> And this one an EQDT lookup?
>>>>>>
>>>>>> yes.
>>>>>>
>>>>>>>> 	} XiveFabricClass;
>>>>>>>>
>>>>>>>>    It helps in making the routing algorithm independent of the m=
odel.=20
>>>>>>>>    I hope to make powernv converge and use it.
>>>>>>>>
>>>>>>>>  - a set of MMIOs for the TIMA. They model the presenter engine.=
=20
>>>>>>>>    current_cpu is used to retrieve the NVT object, which holds t=
he=20
>>>>>>>>    registers for interrupt management. =20
>>>>>>>
>>>>>>> Right.  Now the TIMA is local to a target/server not an EQ, right=
?
>>>>>>
>>>>>> The TIMA is the MMIO giving access to the registers which are per =
CPU.=20
>>>>>> The EQ are for routing. They are under the CPU object because it i=
s=20
>>>>>> convenient.
>>>>>> =20
>>>>>>> I guess we need at least one of these per-vcpu. =20
>>>>>>
>>>>>> yes.
>>>>>>
>>>>>>> Do we also need an lpar-global, or other special ones?
>>>>>>
>>>>>> That would be for the host. AFAICT KVM does not use such special
>>>>>> VPs.
>>>>>
>>>>> Um.. "does not use".. don't we get to decide that?
>>>>
>>>> Well, that part in the specs is still a little obscure for me and=20
>>>> I am not sure it will fit very well in the Linux/KVM model. It shoul=
d=20
>>>> be hidden to the guest anyway and can come in later.
>>>>
>>>>>>>> The EQs are stored under the NVT. This saves us an unnecessary E=
QDT=20
>>>>>>>> table. But we could add one under the XIVE device model.
>>>>>>>
>>>>>>> I'm not sure of the distinction you're drawing between the NVT an=
d the
>>>>>>> XIVE device mode.
>>>>>>
>>>>>> we could add a new table under the XIVE interrupt device model=20
>>>>>> sPAPRXive to store the EQs and indexed them like skiboot does.=20
>>>>>> But it seems unnecessary to me as we can use the object below=20
>>>>>> 'cpu->intc', which is the XiveNVT object. =20
>>>>>
>>>>> So, basically assuming a fixed set of EQs (one per priority?)
>>>>
>>>> yes. It's easier to capture the state and dump information from
>>>> the monitor.
>>>>
>>>>> per CPU for a PAPR guest? =20
>>>>
>>>> yes, that's own it works.
>>>>
>>>>> That makes sense (assuming PAPR doesn't provide guest interfaces to=
=20
>>>>> ask for something else).
>>>>
>>>> Yes. All hcalls take prio/server parameters and the reserved prio ra=
nge=20
>>>> for the platform is in the device tree. 0xFF is a special case to re=
set=20
>>>> targeting.=20
>>>>
>>>> Thanks,
>>>>
>>>> C.
>>>>
>>>
>>
>=20
