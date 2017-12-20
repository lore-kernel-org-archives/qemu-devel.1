Received: from eggs.gnu.org ([2001:4830:134:3::10]:49795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eRYxy-0006qM-3K
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 02:39:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eRYxt-0003Ek-UQ
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 02:39:02 -0500
Received: from 5.mo177.mail-out.ovh.net ([46.105.39.154]:51512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eRYxt-00038o-Ln
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 02:38:57 -0500
Received: from player779.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 562FA91A7E
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 08:38:48 +0100 (CET)
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-3-clg@kaod.org>
	<20171220050947.GC5981@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3f2d34d0-9ba0-1321-a6bd-55546c67c8c7@kaod.org>
Date: Wed, 20 Dec 2017 08:38:41 +0100
MIME-Version: 1.0
In-Reply-To: <20171220050947.GC5981@umbus.fritz.box>
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

On 12/20/2017 06:09 AM, David Gibson wrote:
> On Sat, Dec 09, 2017 at 09:43:21AM +0100, C=E9dric Le Goater wrote:
>> With the POWER9 processor comes a new interrupt controller called
>> XIVE. It is composed of three sub-engines :
>>
>>   - Interrupt Virtualization Source Engine (IVSE). These are in PHBs,
>>     in the main controller for the IPIS and in the PSI host
>>     bridge. They are configured to feed the IVRE with events.
>>
>>   - Interrupt Virtualization Routing Engine (IVRE). Their job is to
>>     match an event source with a Notification Virtualization Target
>>     (NVT), a priority and an Event Queue (EQ) to determine if a
>>     Virtual Processor can handle the event.
>>
>>   - Interrupt Virtualization Presentation Engine (IVPE). It maintains
>>     the interrupt state of each hardware thread and present the
>>     notification as an external exception.
>>
>> Each of the engines uses a set of internal tables to redirect
>> exceptions from event sources to CPU threads. The first table we
>> introduce is the Interrupt Virtualization Entry (IVE) table, part of
>> the virtualization engine in charge of routing events. It associates
>> event sources (IRQ numbers) to event queues which will forward, or
>> not, the event notification to the presentation controller.
>>
>> The XIVE model is designed to make use of the full range of the IRQ
>> number space and does not use an offset like the XICS mode does.
>> Hence, the IVE table is directly indexed by the IRQ number.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> As you've suggested in yourself, I think we might need to more
> explicitly model the different components of the XIVE system.  As part
> of that, I think you need to be clearer in this base skeleton about
> exactly what component your XIVE object represents.

ok. The base skeleton is the IVRE, the central engine handling=20
the routing.=20

> If the answer is "the overall thing"=20

Yes, it is more or less that currently.=20

The sPAPRXive object models the source engine and the routing=20
engine in one object. =20

I have merged these for simplicity and because the interrupt=20
controller has an internal source for the interrupts of the "IPI"=20
type, which are used for the CPU IPIs but also for other generic=20
interrupts, like the OpenCAPI ones. The XIVE sPAPR interface is=20
also much simpler than the baremetal one, all the tables are=20
maintained in the hypervisor, so this choice made some sense.=20

But since, I have started the PowerNV model and I am duplicating=20
a lot of code to handle the triggering and the MMIOs in the=20
different sources. So I am not convinced anymore. Nevertheless,=20
the overall routing logic is the same even if some the tables=20
are not located in QEMU anymore, but in the machine memory.

The sPAPRXiveNVT models some of the CPU presenter engine. It=20
holds the virtual CPU interrupt states when not dispatched on=20
a real HW thread. Real world is more complex. There are "CAM"=20
lines in the HW threads which are compared to find a matching=20
candidate. But I don't think we need to anything more complex=20
than today unless we want to support KVM under TCG ...
  =20
> I suspect that's not what you
> want - I had one of those for XICs which proved to be a mistake
> (eventually replaced by the XICSFabric interface).

The XICSFabric would be the main Xive object. The interface=20
between the sources and the routing engine is hidden in sPAPR,=20
we can use a simple function call :=20

	spapr_xive_irq(pnv->xive, irq);

we could get rid of the qirqs but they are required for XICS.

PowerNV uses MMIOs to notify an event and it makes the modeling
somewhat easier. Each controller model has a notify port address=20
register on which a interrupt number is written to forward an=20
event to the routing engine. So it is a simple store.=20

I don't know why there is a different notify port address per
source, may be for extra filtering at the routing engine level.  =20

> Changing the model later isn't impossible, but doing so without
> breaking migration can be a real pain, so I think it's worth a
> reasonable effort to try and get it right initially.

I completely agree.=20

This is why I have started the PnvXive model to challenge the=20
current PAPR design. I have hacked a bunch of patches for XIVE,=20
LPC, PSI, OCC and basic PPC support which boot a PowerNV P9 up to=20
petitboot. It would look better with a source object, but the=20
location of the PQ bits is a bit problematic. It highly depends=20
on the controller. The main controller uses tables in the hypervisor
memory. The PSIHB controller has its own bits. I suppose it is=20
the same for PHB4. I need to take a closer look at how we could
have a common source object.=20

The most important part is KVM support and how we expose the=20
MMIO region. We need to make progress on that topic.

Thanks,

C. =20
=20

>> ---
>>
>>  Changes since v1 :
>>
>>  - used g_new0 instead of g_malloc0
>>  - removed VMSTATE_STRUCT_VARRAY_UINT32_ALLOC=20
>>  - introduced a device reset handler. the object needs to be parented
>>    to sysbus when created.
>>  - renamed spapr_xive_irq_set to spapr_xive_irq_enable
>>  - renamed spapr_xive_irq_unset to spapr_xive_irq_disable
>>  - moved the PPC_BIT macros under target/ppc/cpu.h
>>  - shrinked file copyright header
>>
>>  default-configs/ppc64-softmmu.mak |   1 +
>>  hw/intc/Makefile.objs             |   1 +
>>  hw/intc/spapr_xive.c              | 156 +++++++++++++++++++++++++++++=
+++++++++
>>  hw/intc/xive-internal.h           |  41 ++++++++++
>>  include/hw/ppc/spapr_xive.h       |  35 +++++++++
>>  5 files changed, 234 insertions(+)
>>  create mode 100644 hw/intc/spapr_xive.c
>>  create mode 100644 hw/intc/xive-internal.h
>>  create mode 100644 include/hw/ppc/spapr_xive.h
>>
>> diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64=
-softmmu.mak
>> index d1b3a6dd50f8..4a7f6a0696de 100644
>> --- a/default-configs/ppc64-softmmu.mak
>> +++ b/default-configs/ppc64-softmmu.mak
>> @@ -56,6 +56,7 @@ CONFIG_SM501=3Dy
>>  CONFIG_XICS=3D$(CONFIG_PSERIES)
>>  CONFIG_XICS_SPAPR=3D$(CONFIG_PSERIES)
>>  CONFIG_XICS_KVM=3D$(call land,$(CONFIG_PSERIES),$(CONFIG_KVM))
>> +CONFIG_XIVE_SPAPR=3D$(CONFIG_PSERIES)
>>  # For PReP
>>  CONFIG_SERIAL_ISA=3Dy
>>  CONFIG_MC146818RTC=3Dy
>> diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
>> index ae358569a155..49e13e7aeeee 100644
>> --- a/hw/intc/Makefile.objs
>> +++ b/hw/intc/Makefile.objs
>> @@ -35,6 +35,7 @@ obj-$(CONFIG_SH4) +=3D sh_intc.o
>>  obj-$(CONFIG_XICS) +=3D xics.o
>>  obj-$(CONFIG_XICS_SPAPR) +=3D xics_spapr.o
>>  obj-$(CONFIG_XICS_KVM) +=3D xics_kvm.o
>> +obj-$(CONFIG_XIVE_SPAPR) +=3D spapr_xive.o
>>  obj-$(CONFIG_POWERNV) +=3D xics_pnv.o
>>  obj-$(CONFIG_ALLWINNER_A10_PIC) +=3D allwinner-a10-pic.o
>>  obj-$(CONFIG_S390_FLIC) +=3D s390_flic.o
>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>> new file mode 100644
>> index 000000000000..e6e8841add17
>> --- /dev/null
>> +++ b/hw/intc/spapr_xive.c
>> @@ -0,0 +1,156 @@
>> +/*
>> + * QEMU PowerPC sPAPR XIVE interrupt controller model
>> + *
>> + * Copyright (c) 2017, IBM Corporation.
>> + *
>> + * This code is licensed under the GPL version 2 or later. See the
>> + * COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/log.h"
>> +#include "qapi/error.h"
>> +#include "target/ppc/cpu.h"
>> +#include "sysemu/cpus.h"
>> +#include "sysemu/dma.h"
>> +#include "monitor/monitor.h"
>> +#include "hw/ppc/spapr_xive.h"
>> +
>> +#include "xive-internal.h"
>> +
>> +/*
>> + * Main XIVE object
>> + */
>> +
>> +void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon)
>> +{
>> +    int i;
>> +
>> +    for (i =3D 0; i < xive->nr_irqs; i++) {
>> +        XiveIVE *ive =3D &xive->ivt[i];
>> +
>> +        if (!(ive->w & IVE_VALID)) {
>> +            continue;
>> +        }
>> +
>> +        monitor_printf(mon, "  %4x %s %08x %08x\n", i,
>> +                       ive->w & IVE_MASKED ? "M" : " ",
>> +                       (int) GETFIELD(IVE_EQ_INDEX, ive->w),
>> +                       (int) GETFIELD(IVE_EQ_DATA, ive->w));
>> +    }
>> +}
>> +
>> +static void spapr_xive_reset(DeviceState *dev)
>> +{
>> +    sPAPRXive *xive =3D SPAPR_XIVE(dev);
>> +    int i;
>> +
>> +    /* Mask all valid IVEs in the IRQ number space. */
>> +    for (i =3D 0; i < xive->nr_irqs; i++) {
>> +        XiveIVE *ive =3D &xive->ivt[i];
>> +        if (ive->w & IVE_VALID) {
>> +            ive->w |=3D IVE_MASKED;
>> +        }
>> +    }
>> +}
>> +
>> +static void spapr_xive_realize(DeviceState *dev, Error **errp)
>> +{
>> +    sPAPRXive *xive =3D SPAPR_XIVE(dev);
>> +
>> +    if (!xive->nr_irqs) {
>> +        error_setg(errp, "Number of interrupt needs to be greater 0")=
;
>> +        return;
>> +    }
>> +
>> +    /* Allocate the IVT (Interrupt Virtualization Table) */
>> +    xive->ivt =3D g_new0(XiveIVE, xive->nr_irqs);
>> +}
>> +
>> +static const VMStateDescription vmstate_spapr_xive_ive =3D {
>> +    .name =3D TYPE_SPAPR_XIVE "/ive",
>> +    .version_id =3D 1,
>> +    .minimum_version_id =3D 1,
>> +    .fields =3D (VMStateField []) {
>> +        VMSTATE_UINT64(w, XiveIVE),
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +};
>> +
>> +static bool vmstate_spapr_xive_needed(void *opaque)
>> +{
>> +    /* TODO check machine XIVE support */
>> +    return true;
>> +}
>> +
>> +static const VMStateDescription vmstate_spapr_xive =3D {
>> +    .name =3D TYPE_SPAPR_XIVE,
>> +    .version_id =3D 1,
>> +    .minimum_version_id =3D 1,
>> +    .needed =3D vmstate_spapr_xive_needed,
>> +    .fields =3D (VMStateField[]) {
>> +        VMSTATE_UINT32_EQUAL(nr_irqs, sPAPRXive, NULL),
>> +        VMSTATE_STRUCT_VARRAY_UINT32(ivt, sPAPRXive, nr_irqs, 1,
>> +                                     vmstate_spapr_xive_ive, XiveIVE)=
,
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +};
>> +
>> +static Property spapr_xive_properties[] =3D {
>> +    DEFINE_PROP_UINT32("nr-irqs", sPAPRXive, nr_irqs, 0),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void spapr_xive_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +
>> +    dc->realize =3D spapr_xive_realize;
>> +    dc->reset =3D spapr_xive_reset;
>> +    dc->props =3D spapr_xive_properties;
>> +    dc->desc =3D "sPAPR XIVE interrupt controller";
>> +    dc->vmsd =3D &vmstate_spapr_xive;
>> +}
>> +
>> +static const TypeInfo spapr_xive_info =3D {
>> +    .name =3D TYPE_SPAPR_XIVE,
>> +    .parent =3D TYPE_SYS_BUS_DEVICE,
>> +    .instance_size =3D sizeof(sPAPRXive),
>> +    .class_init =3D spapr_xive_class_init,
>> +};
>> +
>> +static void spapr_xive_register_types(void)
>> +{
>> +    type_register_static(&spapr_xive_info);
>> +}
>> +
>> +type_init(spapr_xive_register_types)
>> +
>> +XiveIVE *spapr_xive_get_ive(sPAPRXive *xive, uint32_t lisn)
>> +{
>> +    return lisn < xive->nr_irqs ? &xive->ivt[lisn] : NULL;
>> +}
>> +
>> +bool spapr_xive_irq_enable(sPAPRXive *xive, uint32_t lisn)
>> +{
>> +    XiveIVE *ive =3D spapr_xive_get_ive(xive, lisn);
>> +
>> +    if (!ive) {
>> +        return false;
>> +    }
>> +
>> +    ive->w |=3D IVE_VALID;
>> +    return true;
>> +}
>> +
>> +bool spapr_xive_irq_disable(sPAPRXive *xive, uint32_t lisn)
>> +{
>> +    XiveIVE *ive =3D spapr_xive_get_ive(xive, lisn);
>> +
>> +    if (!ive) {
>> +        return false;
>> +    }
>> +
>> +    ive->w &=3D ~IVE_VALID;
>> +    return true;
>> +}
>> diff --git a/hw/intc/xive-internal.h b/hw/intc/xive-internal.h
>> new file mode 100644
>> index 000000000000..132b71a6daf0
>> --- /dev/null
>> +++ b/hw/intc/xive-internal.h
>> @@ -0,0 +1,41 @@
>> +/*
>> + * QEMU PowerPC XIVE interrupt controller model
>> + *
>> + * Copyright (c) 2016-2017, IBM Corporation.
>> + *
>> + * This code is licensed under the GPL version 2 or later. See the
>> + * COPYING file in the top-level directory.
>> + */
>> +
>> +#ifndef _INTC_XIVE_INTERNAL_H
>> +#define _INTC_XIVE_INTERNAL_H
>> +
>> +/* Utilities to manipulate these (originaly from OPAL) */
>> +#define MASK_TO_LSH(m)          (__builtin_ffsl(m) - 1)
>> +#define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
>> +#define SETFIELD(m, v, val)                             \
>> +        (((v) & ~(m)) | ((((typeof(v))(val)) << MASK_TO_LSH(m)) & (m)=
))
>> +
>> +/* IVE/EAS
>> + *
>> + * One per interrupt source. Targets that interrupt to a given EQ
>> + * and provides the corresponding logical interrupt number (EQ data)
>> + *
>> + * We also map this structure to the escalation descriptor inside
>> + * an EQ, though in that case the valid and masked bits are not used.
>> + */
>> +typedef struct XiveIVE {
>> +        /* Use a single 64-bit definition to make it easier to
>> +         * perform atomic updates
>> +         */
>> +        uint64_t        w;
>> +#define IVE_VALID       PPC_BIT(0)
>> +#define IVE_EQ_BLOCK    PPC_BITMASK(4, 7)        /* Destination EQ bl=
ock# */
>> +#define IVE_EQ_INDEX    PPC_BITMASK(8, 31)       /* Destination EQ in=
dex */
>> +#define IVE_MASKED      PPC_BIT(32)              /* Masked */
>> +#define IVE_EQ_DATA     PPC_BITMASK(33, 63)      /* Data written to t=
he EQ */
>> +} XiveIVE;
>> +
>> +XiveIVE *spapr_xive_get_ive(sPAPRXive *xive, uint32_t lisn);
>> +
>> +#endif /* _INTC_XIVE_INTERNAL_H */
>> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
>> new file mode 100644
>> index 000000000000..5b1f78e06a1e
>> --- /dev/null
>> +++ b/include/hw/ppc/spapr_xive.h
>> @@ -0,0 +1,35 @@
>> +/*
>> + * QEMU PowerPC sPAPR XIVE interrupt controller model
>> + *
>> + * Copyright (c) 2017, IBM Corporation.
>> + *
>> + * This code is licensed under the GPL version 2 or later. See the
>> + * COPYING file in the top-level directory.
>> + */
>> +
>> +#ifndef PPC_SPAPR_XIVE_H
>> +#define PPC_SPAPR_XIVE_H
>> +
>> +#include <hw/sysbus.h>
>> +
>> +typedef struct sPAPRXive sPAPRXive;
>> +typedef struct XiveIVE XiveIVE;
>> +
>> +#define TYPE_SPAPR_XIVE "spapr-xive"
>> +#define SPAPR_XIVE(obj) OBJECT_CHECK(sPAPRXive, (obj), TYPE_SPAPR_XIV=
E)
>> +
>> +struct sPAPRXive {
>> +    SysBusDevice parent;
>> +
>> +    /* Properties */
>> +    uint32_t     nr_irqs;
>> +
>> +    /* XIVE internal tables */
>> +    XiveIVE      *ivt;
>> +};
>> +
>> +bool spapr_xive_irq_enable(sPAPRXive *xive, uint32_t lisn);
>> +bool spapr_xive_irq_disable(sPAPRXive *xive, uint32_t lisn);
>> +void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
>> +
>> +#endif /* PPC_SPAPR_XIVE_H */
>=20
