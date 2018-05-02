Received: from eggs.gnu.org ([2001:4830:134:3::10]:43260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fDtgR-0006nU-OQ
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fDtgM-0007GB-Kb
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:28:43 -0400
Received: from 8.mo173.mail-out.ovh.net ([46.105.46.122]:42519)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fDtgM-0007Fh-A6
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:28:38 -0400
Received: from player714.ha.ovh.net (unknown [10.109.122.15])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 514AEC0332
	for <qemu-devel@nongnu.org>; Wed,  2 May 2018 17:28:36 +0200 (CEST)
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-4-clg@kaod.org>
	<20180423064644.GG19804@umbus.fritz.box>
	<8d1cb270-d62f-f08f-9167-3f130906f910@kaod.org>
	<20180424064629.GP19804@umbus.fritz.box>
	<3b57fde8-ee11-81a0-271b-9e514ed63856@kaod.org>
	<20180426035452.GE8800@umbus.fritz.box>
	<b11688ae-a08f-320f-2bb5-46262ccb6376@kaod.org>
	<20180427063211.GO8800@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <562fdbd3-cf09-0123-a481-b97e72802f5d@kaod.org>
Date: Wed, 2 May 2018 17:28:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180427063211.GO8800@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 03/35] ppc/xive: introduce the
 XiveFabric interface
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

On 04/27/2018 08:32 AM, David Gibson wrote:
> On Thu, Apr 26, 2018 at 12:30:42PM +0200, C=E9dric Le Goater wrote:
>> On 04/26/2018 05:54 AM, David Gibson wrote:
>>> On Tue, Apr 24, 2018 at 11:33:11AM +0200, C=E9dric Le Goater wrote:
>>>> On 04/24/2018 08:46 AM, David Gibson wrote:
>>>>> On Mon, Apr 23, 2018 at 09:58:43AM +0200, C=E9dric Le Goater wrote:
>>>>>> On 04/23/2018 08:46 AM, David Gibson wrote:
>>>>>>> On Thu, Apr 19, 2018 at 02:42:59PM +0200, C=E9dric Le Goater wrot=
e:
>>>>>>>> The XiveFabric offers a simple interface, between the XiveSourve
>>>>>>>> object and the device model owning the interrupt sources, to for=
ward
>>>>>>>> an event notification to the XIVE interrupt controller of the ma=
chine
>>>>>>>> and if the owner is the controller, to call directly the routing
>>>>>>>> sub-engine.
>>>>>>>>
>>>>>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>>>>>> ---
>>>>>>>>  hw/intc/xive.c        | 37 ++++++++++++++++++++++++++++++++++++=
-
>>>>>>>>  include/hw/ppc/xive.h | 25 +++++++++++++++++++++++++
>>>>>>>>  2 files changed, 61 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>>>>>>>> index 060976077dd7..b4c3d06c1219 100644
>>>>>>>> --- a/hw/intc/xive.c
>>>>>>>> +++ b/hw/intc/xive.c
>>>>>>>> @@ -17,6 +17,21 @@
>>>>>>>>  #include "hw/ppc/xive.h"
>>>>>>>> =20
>>>>>>>>  /*
>>>>>>>> + * XIVE Fabric
>>>>>>>> + */
>>>>>>>> +
>>>>>>>> +static void xive_fabric_route(XiveFabric *xf, int lisn)
>>>>>>>> +{
>>>>>>>> +
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static const TypeInfo xive_fabric_info =3D {
>>>>>>>> +    .name =3D TYPE_XIVE_FABRIC,
>>>>>>>> +    .parent =3D TYPE_INTERFACE,
>>>>>>>> +    .class_size =3D sizeof(XiveFabricClass),
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +/*
>>>>>>>>   * XIVE Interrupt Source
>>>>>>>>   */
>>>>>>>> =20
>>>>>>>> @@ -97,11 +112,19 @@ static bool xive_source_pq_trigger(XiveSour=
ce *xsrc, uint32_t srcno)
>>>>>>>> =20
>>>>>>>>  /*
>>>>>>>>   * Forward the source event notification to the associated Xive=
Fabric,
>>>>>>>> - * the device owning the sources.
>>>>>>>> + * the device owning the sources, or perform the routing if the=
 device
>>>>>>>> + * is the interrupt controller.
>>>>>>>>   */
>>>>>>>>  static void xive_source_notify(XiveSource *xsrc, int srcno)
>>>>>>>>  {
>>>>>>>> =20
>>>>>>>> +    XiveFabricClass *xfc =3D XIVE_FABRIC_GET_CLASS(xsrc->xive);
>>>>>>>> +
>>>>>>>> +    if (xfc->notify) {
>>>>>>>> +        xfc->notify(xsrc->xive, srcno + xsrc->offset);
>>>>>>>> +    } else {
>>>>>>>> +        xive_fabric_route(xsrc->xive, srcno + xsrc->offset);
>>>>>>>> +    }
>>>>>>>
>>>>>>> Why 2 cases?  Can't the XiveFabric object just make its notify eq=
ual
>>>>>>> to xive_fabric_route if that's what it wants?
>>>>>> Under sPAPR, all the sources, IPIs and virtual device interrupts,=20
>>>>>> generate events which are directly routed by xive_fabric_route().=20
>>>>>> There is no need of an extra hop. Indeed.=20
>>>>>
>>>>> Ok.
>>>>>
>>>>>> Under PowerNV, some sources forward the notification to the routin=
g=20
>>>>>> engine using a specific MMIO load on a notify address which is sto=
red=20
>>>>>> in one of the controller registers. So we need a hop to reach the=20
>>>>>> device model, owning the sources, and do that load :
>>>>>
>>>>> Hm.  So you're saying that in pnv some sources send their notificat=
ion
>>>>> to some other unit,=20
>>>>
>>>> Not to any unit/device, to the device owning the sources.
>>>>
>>>> For the XiveSource object under PSI, the XIVEFabric interface is the=
=20
>>>> PSI device object it self, which knows how to forward the notificati=
on=20
>>>> on the XIVE Power "bus". To be more precise, the PSI HB device has=20
>>>> 14 interrupt sources, which notifications are forwarded using a MMIO=
=20
>>>> load to some address. The load address is configured (by skiboot) in=
=20
>>>> one of the PSI device registers, and points to a MMIO region of the=20
>>>> main XIVE interrupt controller.=20
>>>>
>>>> The PHB4 sources should be the same.
>>>>
>>>> For the XiveSource object (all interrupts) under sPAPRXive, the=20
>>>> XIVEFabric is the main interrupt controller sPAPRXive.
>>>>
>>>> For the XiveSource object (IPIs) under PnvXive, the XIVEFabric is=20
>>>> also the main interrupt controller PnvXive.
>>>
>>> Hrm.  Apparently I'm missing something, I'm really not getting what
>>> you're trying to explain here.
>>
>> I see that. Let's try again.
>>
>>>>> that would then (after possible masking) forward on to the overall>=
 xive fabric ?=20
>>>>
>>>> yes. May be XIVEFabric is a confusing name. What about XIVEForwarder=
 ?=20
>>>
>>> Maybe..?
>>>
>>>>> That seems like a property of the source object,=20
>>>>
>>>> The source object is generic. It's a bunch of PQ bits that can be=20
>>>> controlled by MMIOs. Nothing more.
>>>
>>> Hmm.  Isn't the source object also responsible for forwarding the
>>> interrupt to something up the chain (whatever that is)?
>>
>> Yes but it can not forward directly. The XiveSource is generic and=20
>> can only call a handler :
>>
>> 	xfc->notify(xsrc->xive, srcno + xsrc->offset);
>=20
> But.. your patch doesn't do that always, it's conditional which I
> still don't understand.

Because at the end of the notify/forward chain, you route.

>> The device model owner, the parent of the XiveSource object, would=20
>> do the real forward.
>=20
> Why? =20

because, in my idea of the XiveSource concept, it does not have=20
the logic to do so: the register for the MMIO address to use,=20
another one for the IVT offset, etc

> I mean the XiveSource basically represents the xive irq related
> logic of the PHB or whatever, why would it not represent *all* of
> that, rather than just the ESB bits, meaning the owner has to have
> some more xive logic for the forwarding.

ok. This is where we diverge in the concept.=20

The PQ bits, the ESB MMIO region handlers can be easily shared=20
between the different device models. They are the common part
of devices with XIVE interrupt sources. =20

> Note that I don't think the fact that some sources notify via mmio and
> some are internal really matters.  It's not like we're modelling the
> power bus down to the wire-transaction level.

yes but the configuration of the devices are different. pnv devices=20
will have registers accessible through MMIO or XSCOM and configured
by the firmware. spapr is all set up by QEMU.

>> It's very similar to what we have today with XICS :
>>
>> 	- The sPAPR model has an ICSState =20
>> 	- The PnvPSI model has an ICSState=20
>> 	- The PnvPHB3 model has two ICSStates
>>
>> and the 'xics' pointer in ICSState points to the 'interrupt unit' of=20
>> the machine to do resends and to grab ICPs. So it used for routing=20
>> essentially.
>=20
> Hmm.  I think you and I are looking at XICSFabric kind of
> differently.  As I see it, it's not really an active component at
> all.  Rather it's basically a global "map" of the xics components so
> that they can find each other.

ok. I am not that far either.=20
=20
>> in Xive=20
>>
>> 	- sPAPRXive model has a XiveSource
>> 	- PnvXive model has a XiveSource
>> 	- PnvPSI model has a XiveSource
>> 	- PnvPHB4 model should have also.
>>
>> and the 'xive' pointer in XiveSource points to the parent object,
>=20
> Uh.. yeah.. the xics pointer in ICS units doesn't point to the parent
> object, except maybe by accident.  It's absolutely intended to be
> global, and so points to the machine.

yes. I agree.=20

XIVE has more layers and visible components due to the internal=20
tables used for routing.

>> which will handle the event notification forwarding or routing.
>=20
> Ok, how about this for a partial model.  We have:
>=20
> XiveSource objects:
> 	* Owns an ESB table
> 	* Knows the mapping of its local irq offsets to global irq
> 	  numbers

That is the 'offset' attribute I suppose. This is set at runtime=20
for the powernv devices. For pseries, we should need it for=20
passthrough. I think. I haven't looked at that part yet.

> 	* Provides the mmio interface for ESB manipulation
> 	* When neccessary, notifies a new interrupt to a XiveRouter

ok. I think that what we have today fits the idea then.=20

> XiveRouter objects:
> 	* Responsible for a fixed range of global irq numbers
> 	* Owns an IVT (but what that means can vary, see below)

the size of the IVT table is determined at runtime for powernv.

> 	* When notified of an irq, routes it to the appropriate EQ
> 	  (haven't thought about this part yet)

we will need a class handler to get EQs

> 	* Abstract class - needs subclasses to define how to get IVEs

OK. We will need a few other ops. The router needs to :

	- get IVEs
	- get EQ descriptors
	- update OS EQs (write event data in OS RAM)
	- update EQ descriptors (to set EQ descriptor index & toggle)
	- get an NVT/VP (to notify CPUs)

For powernv, we should also consider updating the NVT/VP. It can be=20
done later.=20

> XiveFabric interface:
> 	* Lets XIVE components locate each other

hmm, it should be a chain :=20

	source -> router -> presenter -> cpu

So the components should not have to locate each other. The presenter
does not know about the source for instance. Only the sources need
to forward events to the main controller logic doing the routing.

> 	* get_router() method: maps a global irq number to XiveRouter
> 	  object

Ah. you are thinking about the multichip case under powernv. I need
to look at that more closely. But XIVE has a concept of block which=20
is used by skiboot to map a chip to a block and the XIVE tables have=20
a block field.

> 	* Always global (implemented on the machine)

OK. this is more or less the object modeling the main interrupt=20
controller ? What I called sPAPRXive in the current patchset.

=20
> On pseries we have:
>=20
> 	? XiveSource objects.  We probably only need one, but 1 for
> 	LSI and one for MSI might be convenient. =20

It's not too ugly for the moment. If we create a source object=20
for LSIs only that might be more complex for passthrough devices=20
and their associated ESB MMIO region.

side note :

LSIs work under TCG, and used to work under KVM until we removed
the StoreEOI support. Since the EOI is now different, we need=20
to find a way to handle EOI for guest virtual LSIs which are=20
not LSIs for the host. We can still change the Linux spapr=20
backend or have QEMU handle the EOI for virtual LSIs. This is=20
on my TODO list.

>       More wouldn't break the model

It should not. Initially the pachset had two source objects :=20
one for IPIs and one for the virtual devices interrupts.=20

> 	1 sPAPRXiveRouter.  This is a subclass of XiveRouter that
> 	holds the IVT internall (and migrates it).

OK.

> 	the XiveFabric implementation always returns the single global
> 	router for get_router()

we can do that.=20

Do we gather all XIVE components objects under an object 'sPAPRXive'=20
modeling that way the main interrupt controller of the machine ?=20
It should not have any state but it will hold the TIMA region=20
most certainly, and the addresses where to map the ESB and=20
TIMA regions.

KVM support will bring extra needs.
=20
> On powernv we have:
> 	N XiveSource objects.  Some in PHBs, some extra ones on each
> 	chip

yes and PSI to start with. =20

> 	(#chips) PowerXiveRouter objects.  This subclass of XiveRouter
> 	stores the register giving the IVT base address and migrates
> 	that, but the IVT contents are in RAM
>=20
> 	the XiveFabric get_router() implementation returns the right
> 	chip's router based on the irq number
>=20
> Obviously the router->EQ sides still needs a bunch of thought.

These are all routing tables :=20

	- IVT
	- EQDT
	- VPDT =20

Thanks,

C.
