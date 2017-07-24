Received: from eggs.gnu.org ([2001:4830:134:3::10]:55720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dZfAJ-00018v-Qx
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dZfAG-0004fE-Lx
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:20:59 -0400
Received: from 3.mo3.mail-out.ovh.net ([46.105.44.175]:57332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dZfAG-0004by-B7
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:20:56 -0400
Received: from player732.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 59C3D123CC5
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 17:20:54 +0200 (CEST)
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-7-git-send-email-clg@kaod.org>
	<20170724040220.GC17228@umbus.fritz.box>
	<86b8aca2-ffc9-e912-da00-b64a78cfc338@ozlabs.ru>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ef215827-4d22-7386-d389-d058c6b1f292@kaod.org>
Date: Mon, 24 Jul 2017 17:20:48 +0200
MIME-Version: 1.0
In-Reply-To: <86b8aca2-ffc9-e912-da00-b64a78cfc338@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 06/26] ppc/xive: introduce a XIVE
 interrupt source model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org

On 07/24/2017 08:00 AM, Alexey Kardashevskiy wrote:
> On 24/07/17 14:02, David Gibson wrote:
>> On Wed, Jul 05, 2017 at 07:13:19PM +0200, C=C3=A9dric Le Goater wrote:
>>> This is very similar to the current ICS_SIMPLE model in XICS. We try
>>> to reuse the ICS model because the sPAPR machine is tied to the
>>> XICSFabric interface and should be using a common framework to switch
>>> from one controller model to another: XICS <-> XIVE.
>>
>> Hm.  I'm not entirely concvinced re-using the xics ICSState class in
>> this way is a good idea, though maybe it's a reasonable first step.
>> With this patch alone some code is shared, but there are some real
>> uglies around the edges.
>=20
>=20
> Agree, using the "ICS" term in XIVE is quite confusing as "ICS" is not
> mentioned in neither XIVE nor P9 specs.

Indeed.=20

The XIVE specs mention Source Controller (P3SC) or Interrupt=20
Virtualization Source Engine (IVSE). The sPAPR specs use=20
Interrupt Source a lot.

Let's unify them all under one name ? I propose ICS :)

Thanks,

C.=20


=20
>>
>> Seems to me at least long term you need to either 1) make the XIVE ics
>> separate, even if it has similarities to the XICS one or 2) truly
>> unify them, with a common base type and methods to handle the
>> differences.
>>
>>
>>> The next patch will introduce the MMIO handlers to interact with XIVE
>>> interrupt sources.
>>>
>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>> ---
>>>  hw/intc/xive.c        | 110 ++++++++++++++++++++++++++++++++++++++++=
++++++++++
>>>  include/hw/ppc/xive.h |  12 ++++++
>>>  2 files changed, 122 insertions(+)
>>>
>>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>>> index 5b14d8155317..9ff14c0da595 100644
>>> --- a/hw/intc/xive.c
>>> +++ b/hw/intc/xive.c
>>> @@ -26,6 +26,115 @@
>>> =20
>>>  #include "xive-internal.h"
>>> =20
>>> +static void xive_icp_irq(XiveICSState *xs, int lisn)
>>> +{
>>> +
>>> +}
>>> +
>>> +/*
>>> + * XIVE Interrupt Source
>>> + */
>>> +static void xive_ics_set_irq_msi(XiveICSState *xs, int srcno, int va=
l)
>>> +{
>>> +    if (val) {
>>> +        xive_icp_irq(xs, srcno + ICS_BASE(xs)->offset);
>>> +    }
>>> +}
>>> +
>>> +static void xive_ics_set_irq_lsi(XiveICSState *xs, int srcno, int va=
l)
>>> +{
>>> +    ICSIRQState *irq =3D &ICS_BASE(xs)->irqs[srcno];
>>> +
>>> +    if (val) {
>>> +        irq->status |=3D XICS_STATUS_ASSERTED;
>>> +    } else {
>>> +        irq->status &=3D ~XICS_STATUS_ASSERTED;
>>> +    }
>>> +
>>> +    if (irq->status & XICS_STATUS_ASSERTED
>>> +        && !(irq->status & XICS_STATUS_SENT)) {
>>> +        irq->status |=3D XICS_STATUS_SENT;
>>> +        xive_icp_irq(xs, srcno + ICS_BASE(xs)->offset);
>>> +    }
>>> +}
>>> +
>>> +static void xive_ics_set_irq(void *opaque, int srcno, int val)
>>> +{
>>> +    XiveICSState *xs =3D ICS_XIVE(opaque);
>>> +    ICSIRQState *irq =3D &ICS_BASE(xs)->irqs[srcno];
>>> +
>>> +    if (irq->flags & XICS_FLAGS_IRQ_LSI) {
>>> +        xive_ics_set_irq_lsi(xs, srcno, val);
>>> +    } else {
>>> +        xive_ics_set_irq_msi(xs, srcno, val);
>>> +    }
>>> +}
>>
>> e.g. you have some code re-use, but still need to more-or-less
>> duplicate the set_irq code as above.
>>
>>> +static void xive_ics_reset(void *dev)
>>> +{
>>> +    ICSState *ics =3D ICS_BASE(dev);
>>> +    int i;
>>> +    uint8_t flags[ics->nr_irqs];
>>> +
>>> +    for (i =3D 0; i < ics->nr_irqs; i++) {
>>> +        flags[i] =3D ics->irqs[i].flags;
>>> +    }
>>> +
>>> +    memset(ics->irqs, 0, sizeof(ICSIRQState) * ics->nr_irqs);
>>> +
>>> +    for (i =3D 0; i < ics->nr_irqs; i++) {
>>> +        ics->irqs[i].flags =3D flags[i];
>>> +    }
>>
>> This save, clear, restore is also kind ugly.  I'm also not sure why
>> this needs a reset method when I can't find one for the xics ICS.
>>
>> Does the xics irqstate structure really cover what you need for xive?
>> I had the impression elsewhere that xive had a different priority
>> model to xics.  And there's the xics pointer in the icsstate structure
>> which is definitely redundant.
>>
>>> +}
>>> +
>>> +static void xive_ics_realize(ICSState *ics, Error **errp)
>>> +{
>>> +    XiveICSState *xs =3D ICS_XIVE(ics);
>>> +    Object *obj;
>>> +    Error *err =3D NULL;
>>> +
>>> +    obj =3D object_property_get_link(OBJECT(xs), "xive", &err);
>>> +    if (!obj) {
>>> +        error_setg(errp, "%s: required link 'xive' not found: %s",
>>> +                   __func__, error_get_pretty(err));
>>> +        return;
>>> +    }
>>> +    xs->xive =3D XIVE(obj);
>>> +
>>> +    if (!ics->nr_irqs) {
>>> +        error_setg(errp, "Number of interrupts needs to be greater 0=
");
>>> +        return;
>>> +    }
>>> +
>>> +    ics->irqs =3D g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
>>> +    ics->qirqs =3D qemu_allocate_irqs(xive_ics_set_irq, xs, ics->nr_=
irqs);
>>> +
>>> +    qemu_register_reset(xive_ics_reset, xs);
>>> +}
>>> +
>>> +static Property xive_ics_properties[] =3D {
>>> +    DEFINE_PROP_UINT32("nr-irqs", ICSState, nr_irqs, 0),
>>> +    DEFINE_PROP_UINT32("irq-base", ICSState, offset, 0),
>>> +    DEFINE_PROP_END_OF_LIST(),
>>> +};
>>> +
>>> +static void xive_ics_class_init(ObjectClass *klass, void *data)
>>> +{
>>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>>> +    ICSStateClass *isc =3D ICS_BASE_CLASS(klass);
>>> +
>>> +    isc->realize =3D xive_ics_realize;
>>> +
>>> +    dc->props =3D xive_ics_properties;
>>> +}
>>> +
>>> +static const TypeInfo xive_ics_info =3D {
>>> +    .name =3D TYPE_ICS_XIVE,
>>> +    .parent =3D TYPE_ICS_BASE,
>>> +    .instance_size =3D sizeof(XiveICSState),
>>> +    .class_init =3D xive_ics_class_init,
>>> +};
>>> +
>>>  /*
>>>   * Main XIVE object
>>>   */
>>> @@ -123,6 +232,7 @@ static const TypeInfo xive_info =3D {
>>>  static void xive_register_types(void)
>>>  {
>>>      type_register_static(&xive_info);
>>> +    type_register_static(&xive_ics_info);
>>>  }
>>> =20
>>>  type_init(xive_register_types)
>>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>>> index 863f5a9c6b5f..544cc6e0c796 100644
>>> --- a/include/hw/ppc/xive.h
>>> +++ b/include/hw/ppc/xive.h
>>> @@ -19,9 +19,21 @@
>>>  #ifndef PPC_XIVE_H
>>>  #define PPC_XIVE_H
>>> =20
>>> +#include "hw/ppc/xics.h"
>>> +
>>>  typedef struct XIVE XIVE;
>>> +typedef struct XiveICSState XiveICSState;
>>> =20
>>>  #define TYPE_XIVE "xive"
>>>  #define XIVE(obj) OBJECT_CHECK(XIVE, (obj), TYPE_XIVE)
>>> =20
>>> +#define TYPE_ICS_XIVE "xive-source"
>>> +#define ICS_XIVE(obj) OBJECT_CHECK(XiveICSState, (obj), TYPE_ICS_XIV=
E)
>>> +
>>> +struct XiveICSState {
>>> +    ICSState parent_obj;
>>> +
>>> +    XIVE         *xive;
>>> +};
>>
>>>  #endif /* PPC_XIVE_H */
>>
>=20
>=20
