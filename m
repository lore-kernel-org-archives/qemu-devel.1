Received: from eggs.gnu.org ([2001:4830:134:3::10]:51362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eK2hh-000344-Nm
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:47:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eK2he-00070v-HW
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:47:09 -0500
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:41542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eK2he-00070Z-8B
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:47:06 -0500
Received: from player731.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 7E5CCD3F87
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 14:47:04 +0100 (CET)
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-9-clg@kaod.org>
	<20171129124904.13a30582@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <1eb874c0-6ffb-0a2f-15e7-86c1edcd020e@kaod.org>
Date: Wed, 29 Nov 2017 14:46:56 +0100
MIME-Version: 1.0
In-Reply-To: <20171129124904.13a30582@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 08/25] spapr: introduce a
 skeleton for the XIVE interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 11/29/2017 12:49 PM, Greg Kurz wrote:
> On Thu, 23 Nov 2017 14:29:38 +0100
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> The XIVE interrupt controller uses a set of tables to redirect excepti=
on
>> from event sources to CPU threads. The Interrupt Virtualization Entry =
(IVE)
>> table, also known as Event Assignment Structure (EAS), is one them.
>>
>> The XIVE model is designed to make use of the full range of the IRQ
>> number space and does not use an offset like the XICS mode does.
>> Hence, the IVE table is directly indexed by the IRQ number.
>>
>> The IVE stores Event Queue data associated with a source. The lookups
>> are performed when the source is configured or when an event is
>> triggered.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  default-configs/ppc64-softmmu.mak |   1 +
>>  hw/intc/Makefile.objs             |   1 +
>>  hw/intc/spapr_xive.c              | 165 +++++++++++++++++++++++++++++=
+++++++++
>>  hw/intc/xive-internal.h           |  50 ++++++++++++
>>  include/hw/ppc/spapr_xive.h       |  44 ++++++++++
>>  5 files changed, 261 insertions(+)
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
>> index 000000000000..b2fc3007c85f
>> --- /dev/null
>> +++ b/hw/intc/spapr_xive.c
>> @@ -0,0 +1,165 @@
>> +/*
>> + * QEMU PowerPC sPAPR XIVE model
>> + *
>> + * Copyright (c) 2017, IBM Corporation.
>> + *
>> + * This program is free software; you can redistribute it and/or modi=
fy
>> + * it under the terms of the GNU General Public License, version 2, a=
s
>=20
> version 2 or (at your option) any later version.

yep. I will shorten the headers at the same time.

>=20
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, see <http://www.gnu.org/licenses/=
>.
>> + */
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
>> +void spapr_xive_reset(void *dev)
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
>> +    xive->ivt =3D g_malloc0(xive->nr_irqs * sizeof(XiveIVE));
>=20
> Even if it isn't documented, AFAIK current recommended practice is to d=
o:
>=20
>     xive->ivt =3D g_new0(XiveIVE, xive->nr_irqs);

OK.
=20
>> +
>> +    qemu_register_reset(spapr_xive_reset, dev);
>=20
> Shouldn't you set dc->reset in spapr_xive_class_init() instead ?

qemu_register_reset() is a more general API. What is the best
practice ?=20

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
>> +        VMSTATE_STRUCT_VARRAY_UINT32_ALLOC(ivt, sPAPRXive, nr_irqs, 1=
,
>> +                                           vmstate_spapr_xive_ive, Xi=
veIVE),
>=20
> Hmm... this array is allocated at realize and this will cause
> the migration code to re-allocate it again with the same size,
> and leak memory IIUC.

I thought so but something was going wrong on the receive side (memory=20
corruption detected by valgrind). I did not find why yet.

Thanks,

C.

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
>> +bool spapr_xive_irq_set(sPAPRXive *xive, uint32_t lisn)
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
>> +bool spapr_xive_irq_unset(sPAPRXive *xive, uint32_t lisn)
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
>> index 000000000000..bea88d82992c
>> --- /dev/null
>> +++ b/hw/intc/xive-internal.h
>> @@ -0,0 +1,50 @@
>> +/*
>> + * QEMU PowerPC XIVE model
>> + *
>> + * Copyright 2016,2017 IBM Corporation.
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the License, or (at your option) any later version.
>> + */
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
>> +#define PPC_BIT(bit)            (0x8000000000000000UL >> (bit))
>> +#define PPC_BIT32(bit)          (0x80000000UL >> (bit))
>> +#define PPC_BIT8(bit)           (0x80UL >> (bit))
>> +#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BI=
T(bs))
>> +#define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
>> +                                 PPC_BIT32(bs))
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
>> +void spapr_xive_reset(void *dev);
>> +XiveIVE *spapr_xive_get_ive(sPAPRXive *xive, uint32_t lisn);
>> +
>> +#endif /* _INTC_XIVE_INTERNAL_H */
>> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
>> new file mode 100644
>> index 000000000000..795b3f4ded7c
>> --- /dev/null
>> +++ b/include/hw/ppc/spapr_xive.h
>> @@ -0,0 +1,44 @@
>> +/*
>> + * QEMU PowerPC sPAPR XIVE model
>> + *
>> + * Copyright (c) 2017, IBM Corporation.
>> + *
>> + * This program is free software; you can redistribute it and/or modi=
fy
>> + * it under the terms of the GNU General Public License, version 2, a=
s
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, see <http://www.gnu.org/licenses/=
>.
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
>> +bool spapr_xive_irq_set(sPAPRXive *xive, uint32_t lisn);
>> +bool spapr_xive_irq_unset(sPAPRXive *xive, uint32_t lisn);
>> +void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
>> +
>> +#endif /* PPC_SPAPR_XIVE_H */
>=20
