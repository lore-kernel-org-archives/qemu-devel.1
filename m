Received: from eggs.gnu.org ([2001:4830:134:3::10]:60188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fAuKG-0006KT-Jt
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 05:33:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fAuK6-00018O-JT
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 05:33:28 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:39530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fAuK6-00016j-AA
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 05:33:18 -0400
Received: from player774.ha.ovh.net (unknown [10.109.108.1])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 3F71212F0E9
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 11:33:16 +0200 (CEST)
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-4-clg@kaod.org>
	<20180423064644.GG19804@umbus.fritz.box>
	<8d1cb270-d62f-f08f-9167-3f130906f910@kaod.org>
	<20180424064629.GP19804@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3b57fde8-ee11-81a0-271b-9e514ed63856@kaod.org>
Date: Tue, 24 Apr 2018 11:33:11 +0200
MIME-Version: 1.0
In-Reply-To: <20180424064629.GP19804@umbus.fritz.box>
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

On 04/24/2018 08:46 AM, David Gibson wrote:
> On Mon, Apr 23, 2018 at 09:58:43AM +0200, C=E9dric Le Goater wrote:
>> On 04/23/2018 08:46 AM, David Gibson wrote:
>>> On Thu, Apr 19, 2018 at 02:42:59PM +0200, C=E9dric Le Goater wrote:
>>>> The XiveFabric offers a simple interface, between the XiveSourve
>>>> object and the device model owning the interrupt sources, to forward
>>>> an event notification to the XIVE interrupt controller of the machin=
e
>>>> and if the owner is the controller, to call directly the routing
>>>> sub-engine.
>>>>
>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>> ---
>>>>  hw/intc/xive.c        | 37 ++++++++++++++++++++++++++++++++++++-
>>>>  include/hw/ppc/xive.h | 25 +++++++++++++++++++++++++
>>>>  2 files changed, 61 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>>>> index 060976077dd7..b4c3d06c1219 100644
>>>> --- a/hw/intc/xive.c
>>>> +++ b/hw/intc/xive.c
>>>> @@ -17,6 +17,21 @@
>>>>  #include "hw/ppc/xive.h"
>>>> =20
>>>>  /*
>>>> + * XIVE Fabric
>>>> + */
>>>> +
>>>> +static void xive_fabric_route(XiveFabric *xf, int lisn)
>>>> +{
>>>> +
>>>> +}
>>>> +
>>>> +static const TypeInfo xive_fabric_info =3D {
>>>> +    .name =3D TYPE_XIVE_FABRIC,
>>>> +    .parent =3D TYPE_INTERFACE,
>>>> +    .class_size =3D sizeof(XiveFabricClass),
>>>> +};
>>>> +
>>>> +/*
>>>>   * XIVE Interrupt Source
>>>>   */
>>>> =20
>>>> @@ -97,11 +112,19 @@ static bool xive_source_pq_trigger(XiveSource *=
xsrc, uint32_t srcno)
>>>> =20
>>>>  /*
>>>>   * Forward the source event notification to the associated XiveFabr=
ic,
>>>> - * the device owning the sources.
>>>> + * the device owning the sources, or perform the routing if the dev=
ice
>>>> + * is the interrupt controller.
>>>>   */
>>>>  static void xive_source_notify(XiveSource *xsrc, int srcno)
>>>>  {
>>>> =20
>>>> +    XiveFabricClass *xfc =3D XIVE_FABRIC_GET_CLASS(xsrc->xive);
>>>> +
>>>> +    if (xfc->notify) {
>>>> +        xfc->notify(xsrc->xive, srcno + xsrc->offset);
>>>> +    } else {
>>>> +        xive_fabric_route(xsrc->xive, srcno + xsrc->offset);
>>>> +    }
>>>
>>> Why 2 cases?  Can't the XiveFabric object just make its notify equal
>>> to xive_fabric_route if that's what it wants?
>> Under sPAPR, all the sources, IPIs and virtual device interrupts,=20
>> generate events which are directly routed by xive_fabric_route().=20
>> There is no need of an extra hop. Indeed.=20
>=20
> Ok.
>=20
>> Under PowerNV, some sources forward the notification to the routing=20
>> engine using a specific MMIO load on a notify address which is stored=20
>> in one of the controller registers. So we need a hop to reach the=20
>> device model, owning the sources, and do that load :
>=20
> Hm.  So you're saying that in pnv some sources send their notification
> to some other unit,=20

Not to any unit/device, to the device owning the sources.

For the XiveSource object under PSI, the XIVEFabric interface is the=20
PSI device object it self, which knows how to forward the notification=20
on the XIVE Power "bus". To be more precise, the PSI HB device has=20
14 interrupt sources, which notifications are forwarded using a MMIO=20
load to some address. The load address is configured (by skiboot) in=20
one of the PSI device registers, and points to a MMIO region of the=20
main XIVE interrupt controller.=20

The PHB4 sources should be the same.

For the XiveSource object (all interrupts) under sPAPRXive, the=20
XIVEFabric is the main interrupt controller sPAPRXive.

For the XiveSource object (IPIs) under PnvXive, the XIVEFabric is=20
also the main interrupt controller PnvXive.

> that would then (after possible masking) forward on to the overall> xiv=
e fabric ?=20

yes. May be XIVEFabric is a confusing name. What about XIVEForwarder ?=20

> That seems like a property of the source object,=20

The source object is generic. It's a bunch of PQ bits that can be=20
controlled by MMIOs. Nothing more. =20

> rather than a
> property of the fabric.  Indeed varying this by source object would
> require the objects have a different xive pointer, when I thought the
> idea was that the XiveFabric was global.

When a notification is forwarded, the sources needs to call an=20
interface which generally is implemented by the source owner,=20
which is not necessarily the main IC.=20

>> 	static void pnv_psi_notify(XiveFabric *xf, uint32_t lisn)
>> 	{
>> 	    PnvPsi *psi =3D PNV_PSI(xf);
>> 	    uint64_t notif_port =3D
>> 	        psi->regs[PSIHB_REG(PSIHB9_ESB_NOTIF_ADDR)];
>> 	    bool valid =3D notif_port & PSIHB9_ESB_NOTIF_VALID;
>> 	    uint64_t notify_addr =3D notif_port & ~PSIHB9_ESB_NOTIF_VALID;
>> 	    uint32_t data =3D cpu_to_be32(lisn);
>> =09
>> 	    if (valid) {
>> 	        cpu_physical_memory_write(notify_addr, &data, sizeof(data));
>> 	    }
>> 	}
>>
>> The PnvXive model handles the load and forwards to the fabric again. =20
>>
>> The IPIs under PowerNV do not need an extra hop so they reach the=20
>> routing routine directly without the extra notify() hop.=20
>>
>> However, PowerNV at the end should be using xive_fabric_route()=20
>> but there are some differences on how the NVT registers are=20
>> updated (HV vs. OS mode) and it's not handled yet so it uses a=20
>> notify() handler. But is should disappear and call directly=20
>> xive_fabric_route() in a near future.
>>
>>
>> May be, XiveFabricNotifier would be a better name for this feature ?
>> I am adding a few ops later which are more related to routing.
>>
>> Thanks,
>>
>> C.
>>
>>
>>>
>>>>  }
>>>> =20
>>>>  /*
>>>> @@ -302,6 +325,17 @@ static void xive_source_reset(DeviceState *dev)
>>>>  static void xive_source_realize(DeviceState *dev, Error **errp)
>>>>  {
>>>>      XiveSource *xsrc =3D XIVE_SOURCE(dev);
>>>> +    Object *obj;
>>>> +    Error *local_err =3D NULL;
>>>> +
>>>> +    obj =3D object_property_get_link(OBJECT(dev), "xive", &local_er=
r);
>>>> +    if (!obj) {
>>>> +        error_propagate(errp, local_err);
>>>> +        error_prepend(errp, "required link 'xive' not found: ");
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    xsrc->xive =3D XIVE_FABRIC(obj);
>>>> =20
>>>>      if (!xsrc->nr_irqs) {
>>>>          error_setg(errp, "Number of interrupt needs to be greater t=
han 0");
>>>> @@ -376,6 +410,7 @@ static const TypeInfo xive_source_info =3D {
>>>>  static void xive_register_types(void)
>>>>  {
>>>>      type_register_static(&xive_source_info);
>>>> +    type_register_static(&xive_fabric_info);
>>>>  }
>>>> =20
>>>>  type_init(xive_register_types)
>>>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>>>> index 0b76dd278d9b..4fcae2c763e6 100644
>>>> --- a/include/hw/ppc/xive.h
>>>> +++ b/include/hw/ppc/xive.h
>>>> @@ -12,6 +12,8 @@
>>>> =20
>>>>  #include "hw/sysbus.h"
>>>> =20
>>>> +typedef struct XiveFabric XiveFabric;
>>>> +
>>>>  /*
>>>>   * XIVE Interrupt Source
>>>>   */
>>>> @@ -46,6 +48,8 @@ typedef struct XiveSource {
>>>>      hwaddr       esb_base;
>>>>      uint32_t     esb_shift;
>>>>      MemoryRegion esb_mmio;
>>>> +
>>>> +    XiveFabric   *xive;
>>>>  } XiveSource;
>>>> =20
>>>>  /*
>>>> @@ -143,4 +147,25 @@ static inline void xive_source_irq_set(XiveSour=
ce *xsrc, uint32_t srcno,
>>>>      xsrc->status[srcno] |=3D lsi ? XIVE_STATUS_LSI : 0;
>>>>  }
>>>> =20
>>>> +/*
>>>> + * XIVE Fabric
>>>> + */
>>>> +
>>>> +typedef struct XiveFabric {
>>>> +    Object parent;
>>>> +} XiveFabric;
>>>> +
>>>> +#define TYPE_XIVE_FABRIC "xive-fabric"
>>>> +#define XIVE_FABRIC(obj)                                     \
>>>> +    OBJECT_CHECK(XiveFabric, (obj), TYPE_XIVE_FABRIC)
>>>> +#define XIVE_FABRIC_CLASS(klass)                                   =
  \
>>>> +    OBJECT_CLASS_CHECK(XiveFabricClass, (klass), TYPE_XIVE_FABRIC)
>>>> +#define XIVE_FABRIC_GET_CLASS(obj)                                 =
  \
>>>> +    OBJECT_GET_CLASS(XiveFabricClass, (obj), TYPE_XIVE_FABRIC)
>>>> +
>>>> +typedef struct XiveFabricClass {
>>>> +    InterfaceClass parent;
>>>> +    void (*notify)(XiveFabric *xf, uint32_t lisn);
>>>> +} XiveFabricClass;
>>>> +
>>>>  #endif /* PPC_XIVE_H */
>>>
>>
>=20
