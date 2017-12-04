Received: from eggs.gnu.org ([2001:4830:134:3::10]:52170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eLteC-0000qu-Ro
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 11:31:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eLte8-0001YI-SN
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 11:31:12 -0500
Received: from 13.mo3.mail-out.ovh.net ([188.165.33.202]:34498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eLte8-0001UQ-FK
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 11:31:08 -0500
Received: from player732.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id C91E0178113
	for <qemu-devel@nongnu.org>; Mon,  4 Dec 2017 17:31:06 +0100 (CET)
References: <20171123132955.1261-14-clg@kaod.org>
	<20171130043836.GB3023@umbus.fritz.box>
	<52c97368-d50e-0b51-ec5d-7769d1df42d1@kaod.org>
	<20171130233537.GA30161@umbus.fritz.box>
	<c96bf1bf-b036-f5af-dfd5-c9d766e32eda@kaod.org>
	<20171204010932.GG2130@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6110943c-1fa6-2426-dffe-b92d58b7ac36@kaod.org>
Date: Mon, 4 Dec 2017 17:31:02 +0100
MIME-Version: 1.0
In-Reply-To: <20171204010932.GG2130@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 13/25] spapr: introduce the XIVE Event
 Queues
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

On 12/04/2017 02:09 AM, David Gibson wrote:
> On Fri, Dec 01, 2017 at 05:36:39PM +0100, C=E9dric Le Goater wrote:
>> On 12/01/2017 12:35 AM, David Gibson wrote:
>>> On Thu, Nov 30, 2017 at 02:06:27PM +0000, C=E9dric Le Goater wrote:
>>>> On 11/30/2017 04:38 AM, David Gibson wrote:
>>>>> On Thu, Nov 23, 2017 at 02:29:43PM +0100, C=E9dric Le Goater wrote:
>>>>>> The Event Queue Descriptor (EQD) table, also known as Event Notifi=
cation
>>>>>> Descriptor (END), is one of the internal tables the XIVE interrupt
>>>>>> controller uses to redirect exception from event sources to CPU
>>>>>> threads.
>>>>>>
>>>>>> The EQD specifies on which Event Queue the event data should be po=
sted
>>>>>> when an exception occurs (later on pulled by the OS) and which ser=
ver
>>>>>> (VPD in XIVE terminology) to notify. The Event Queue is a much mor=
e
>>>>>> complex structure but we start with a simple model for the sPAPR
>>>>>> machine.
>>>>>
>>>>> Just to clarify my understanding a server / VPD in XIVE would
>>>>> typically correspond to a cpu - either real or virtual, yes?
>>>>
>>>> yes. VP for "virtual processor" and VPD for "virtual processor=20
>>>> descriptor" which contains the XIVE interrupt state of the VP=20
>>>> when not dispatched. It is still described in some documentation=20
>>>> as an NVT : Notification Virtual Target. =20
>>>>
>>>> XIVE concepts were renamed at some time but the old name perdured.
>>>> I am still struggling my way through all the names.
>>>>
>>>>
>>>>>> There is one XiveEQ per priority and the model chooses to store th=
em
>>>>>> under the Xive Interrupt presenter model. It will be retrieved, ju=
st
>>>>>> like for XICS, through the 'intc' object pointer of the CPU.
>>>>>>
>>>>>> The EQ indexing follows a simple pattern:
>>>>>>
>>>>>>        (server << 3) | (priority & 0x7)
>>>>>>
>>>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>>>> ---
>>>>>>  hw/intc/spapr_xive.c    | 56 ++++++++++++++++++++++++++++++++++++=
+++++++++++++
>>>>>>  hw/intc/xive-internal.h | 50 ++++++++++++++++++++++++++++++++++++=
+++++++
>>>>>>  2 files changed, 106 insertions(+)
>>>>>>
>>>>>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>>>>>> index 554b25e0884c..983317a6b3f6 100644
>>>>>> --- a/hw/intc/spapr_xive.c
>>>>>> +++ b/hw/intc/spapr_xive.c
>>>>>> @@ -23,6 +23,7 @@
>>>>>>  #include "sysemu/dma.h"
>>>>>>  #include "monitor/monitor.h"
>>>>>>  #include "hw/ppc/spapr_xive.h"
>>>>>> +#include "hw/ppc/spapr.h"
>>>>>>  #include "hw/ppc/xics.h"
>>>>>> =20
>>>>>>  #include "xive-internal.h"
>>>>>> @@ -34,6 +35,8 @@ struct sPAPRXiveICP {
>>>>>>      uint8_t   tima[TM_RING_COUNT * 0x10];
>>>>>>      uint8_t   *tima_os;
>>>>>>      qemu_irq  output;
>>>>>> +
>>>>>> +    XiveEQ    eqt[XIVE_PRIORITY_MAX + 1];
>>>>>>  };
>>>>>> =20
>>>>>>  static uint64_t spapr_xive_icp_accept(sPAPRXiveICP *icp)
>>>>>> @@ -183,6 +186,13 @@ static const MemoryRegionOps spapr_xive_tm_op=
s =3D {
>>>>>>      },
>>>>>>  };
>>>>>> =20
>>>>>> +static sPAPRXiveICP *spapr_xive_icp_get(sPAPRXive *xive, int serv=
er)
>>>>>> +{
>>>>>> +    PowerPCCPU *cpu =3D spapr_find_cpu(server);
>>>>>> +
>>>>>> +    return cpu ? SPAPR_XIVE_ICP(cpu->intc) : NULL;
>>>>>> +}
>>>>>> +
>>>>>>  static void spapr_xive_irq(sPAPRXive *xive, int lisn)
>>>>>>  {
>>>>>> =20
>>>>>> @@ -632,6 +642,8 @@ static void spapr_xive_icp_reset(void *dev)
>>>>>>      sPAPRXiveICP *xicp =3D SPAPR_XIVE_ICP(dev);
>>>>>> =20
>>>>>>      memset(xicp->tima, 0, sizeof(xicp->tima));
>>>>>> +
>>>>>> +    memset(xicp->eqt, 0, sizeof(xicp->eqt));
>>>>>>  }
>>>>>> =20
>>>>>>  static void spapr_xive_icp_realize(DeviceState *dev, Error **errp=
)
>>>>>> @@ -683,6 +695,23 @@ static void spapr_xive_icp_init(Object *obj)
>>>>>>      xicp->tima_os =3D &xicp->tima[TM_QW1_OS];
>>>>>>  }
>>>>>> =20
>>>>>> +static const VMStateDescription vmstate_spapr_xive_icp_eq =3D {
>>>>>> +    .name =3D TYPE_SPAPR_XIVE_ICP "/eq",
>>>>>> +    .version_id =3D 1,
>>>>>> +    .minimum_version_id =3D 1,
>>>>>> +    .fields =3D (VMStateField []) {
>>>>>> +        VMSTATE_UINT32(w0, XiveEQ),
>>>>>> +        VMSTATE_UINT32(w1, XiveEQ),
>>>>>> +        VMSTATE_UINT32(w2, XiveEQ),
>>>>>> +        VMSTATE_UINT32(w3, XiveEQ),
>>>>>> +        VMSTATE_UINT32(w4, XiveEQ),
>>>>>> +        VMSTATE_UINT32(w5, XiveEQ),
>>>>>> +        VMSTATE_UINT32(w6, XiveEQ),
>>>>>> +        VMSTATE_UINT32(w7, XiveEQ),
>>>>>
>>>>> Wow.  Super descriptive field names there, but I guess that's not y=
our fault.
>>>>
>>>> The defines in the "xive-internal.h" give a better view ...=20
>>>>
>>>>>> +        VMSTATE_END_OF_LIST()
>>>>>> +    },
>>>>>> +};
>>>>>> +
>>>>>>  static bool vmstate_spapr_xive_icp_needed(void *opaque)
>>>>>>  {
>>>>>>      /* TODO check machine XIVE support */
>>>>>> @@ -696,6 +725,8 @@ static const VMStateDescription vmstate_spapr_=
xive_icp =3D {
>>>>>>      .needed =3D vmstate_spapr_xive_icp_needed,
>>>>>>      .fields =3D (VMStateField[]) {
>>>>>>          VMSTATE_BUFFER(tima, sPAPRXiveICP),
>>>>>> +        VMSTATE_STRUCT_ARRAY(eqt, sPAPRXiveICP, (XIVE_PRIORITY_MA=
X + 1), 1,
>>>>>> +                             vmstate_spapr_xive_icp_eq, XiveEQ),
>>>>>>          VMSTATE_END_OF_LIST()
>>>>>>      },
>>>>>>  };
>>>>>> @@ -755,3 +786,28 @@ bool spapr_xive_irq_unset(sPAPRXive *xive, ui=
nt32_t lisn)
>>>>>>      ive->w &=3D ~IVE_VALID;
>>>>>>      return true;
>>>>>>  }
>>>>>> +
>>>>>> +/*
>>>>>> + * Use a simple indexing for the EQs.
>>>>>
>>>>> Is this server+priority encoding architected anywhere? =20
>>>>
>>>> no. This is a model shortcut.
>>>>
>>>>> Otherwise, why not use separate parameters?
>>>>
>>>> yes. spapr_xive_get_eq() could use separate parameters and it would
>>>> shorten the some of the hcalls.
>>>>
>>>> The result is stored in a single field of the IVE, EQ_INDEX. So I wi=
ll=20
>>>> still need mangle/demangle routines but these could be simple macros=
.
>>>> I will look at it.
>>>
>>> Hm, ok.  So it's architected in the sense that you're using the
>>> encoding from the EQ_INDEX field throughout.  That's could be a
>>> reasonable choice, I can't really tell yet.
>>>
>>> On the other hand, it might be easier to read if we use server and
>>> priority as separate parameters until the point we actually encode
>>> into the EQ_INDEX field.
>>
>> In the architecture, the EQ_INDEX field contains an index to an=20
>> Event Queue Descriptor and the Event Queue Descriptor has a=20
>> EQ_W6_NVT_INDEX field pointing to an Notification Virtual Target.
>> So there are two extra tables for the EQs and for the NVTs
>> used by the HW.
>=20
> Ok.  In the PAPR interface is the EQ_INDEX ever exposed to the guest?

never.=20

> Or does it just supply target/priority numbers and the hypervisor
> manages the mapping to queues internally?

Yes. target/priority numbers is the interface used by the hcalls.=20

Same for baremetal. OPAL handles the EQ indexing because it creates=20
the EQ table and register it in the controller  =20

C.
=20
