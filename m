Received: from eggs.gnu.org ([2001:4830:134:3::10]:43497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUn45-0007UC-Ti
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:23:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUn3w-0000I7-TT
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:23:10 -0500
Received: from 10.mo4.mail-out.ovh.net ([188.165.33.109]:44544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gUn3s-0000Do-N9
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:23:01 -0500
Received: from player791.ha.ovh.net (unknown [10.109.160.230])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id CCBDE1C36B8
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 07:22:58 +0100 (CET)
References: <20181205232251.10446-1-clg@kaod.org>
	<20181205232251.10446-5-clg@kaod.org>
	<20181206034124.GM768@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0ed7f319-7ae1-e407-96c1-266463d2a472@kaod.org>
Date: Thu, 6 Dec 2018 07:22:54 +0100
MIME-Version: 1.0
In-Reply-To: <20181206034124.GM768@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 04/37] ppc/xive: introduce the
 XiveRouter model
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

On 12/6/18 4:41 AM, David Gibson wrote:
> On Thu, Dec 06, 2018 at 12:22:18AM +0100, C=E9dric Le Goater wrote:
>> The XiveRouter models the second sub-engine of the XIVE architecture :
>> the Interrupt Virtualization Routing Engine (IVRE).
>>
>> The IVRE handles event notifications of the IVSE and performs the
>> interrupt routing process. For this purpose, it uses a set of tables
>> stored in system memory, the first of which being the Event Assignment
>> Structure (EAS) table.
>>
>> The EAT associates an interrupt source number with an Event Notificati=
on
>> Descriptor (END) which will be used in a second phase of the routing
>> process to identify a Notification Virtual Target.
>>
>> The XiveRouter is an abstract class which needs to be inherited from
>> to define a storage for the EAT, and other upcoming tables.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/xive.h      | 31 ++++++++++++++++
>>  include/hw/ppc/xive_regs.h | 50 +++++++++++++++++++++++++
>>  hw/intc/xive.c             | 76 +++++++++++++++++++++++++++++++++++++=
+
>>  3 files changed, 157 insertions(+)
>>  create mode 100644 include/hw/ppc/xive_regs.h
>>
>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>> index 6770cffec67d..57ec9f84f527 100644
>> --- a/include/hw/ppc/xive.h
>> +++ b/include/hw/ppc/xive.h
>> @@ -141,6 +141,8 @@
>>  #define PPC_XIVE_H
>> =20
>>  #include "hw/qdev-core.h"
>> +#include "hw/sysbus.h"
>> +#include "hw/ppc/xive_regs.h"
>> =20
>>  /*
>>   * XIVE Fabric (Interface between Source and Router)
>> @@ -297,4 +299,33 @@ static inline void xive_source_irq_set(XiveSource=
 *xsrc, uint32_t srcno,
>>      }
>>  }
>> =20
>> +/*
>> + * XIVE Router
>> + */
>> +
>> +typedef struct XiveRouter {
>> +    SysBusDevice    parent;
>=20
> I thought the plan was to make XiveRouter as well as XiveSource a
> TYPE_DEVICE descendent rather than a SysBusDevice?

We start talking about that, indeed, but then :

	https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg06407.html

I thought we concluded that it was going to get too complex.

Also, sPAPRXive is a direct descendant of XiveRouter and we want sPAPRXiv=
e=20
on SysBus.

C.

>=20
>> +} XiveRouter;
>> +
>> +#define TYPE_XIVE_ROUTER "xive-router"
>> +#define XIVE_ROUTER(obj)                                \
>> +    OBJECT_CHECK(XiveRouter, (obj), TYPE_XIVE_ROUTER)
>> +#define XIVE_ROUTER_CLASS(klass)                                     =
   \
>> +    OBJECT_CLASS_CHECK(XiveRouterClass, (klass), TYPE_XIVE_ROUTER)
>> +#define XIVE_ROUTER_GET_CLASS(obj)                              \
>> +    OBJECT_GET_CLASS(XiveRouterClass, (obj), TYPE_XIVE_ROUTER)
>> +
>> +typedef struct XiveRouterClass {
>> +    SysBusDeviceClass parent;
>> +
>> +    /* XIVE table accessors */
>> +    int (*get_eas)(XiveRouter *xrtr, uint8_t eas_blk, uint32_t eas_id=
x,
>> +                   XiveEAS *eas);
>> +} XiveRouterClass;
>> +
>> +void xive_eas_pic_print_info(XiveEAS *eas, uint32_t lisn, Monitor *mo=
n);
>> +
>> +int xive_router_get_eas(XiveRouter *xrtr, uint8_t eas_blk, uint32_t e=
as_idx,
>> +                        XiveEAS *eas);
>> +
>>  #endif /* PPC_XIVE_H */
>> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
>> new file mode 100644
>> index 000000000000..15f2470ed9cc
>> --- /dev/null
>> +++ b/include/hw/ppc/xive_regs.h
>> @@ -0,0 +1,50 @@
>> +/*
>> + * QEMU PowerPC XIVE internal structure definitions
>> + *
>> + *
>> + * The XIVE structures are accessed by the HW and their format is
>> + * architected to be big-endian. Some macros are provided to ease
>> + * access to the different fields.
>> + *
>> + *
>> + * Copyright (c) 2016-2018, IBM Corporation.
>> + *
>> + * This code is licensed under the GPL version 2 or later. See the
>> + * COPYING file in the top-level directory.
>> + */
>> +
>> +#ifndef PPC_XIVE_REGS_H
>> +#define PPC_XIVE_REGS_H
>> +
>> +/*
>> + * Interrupt source number encoding on PowerBUS
>> + */
>> +#define XIVE_SRCNO_BLOCK(srcno) (((srcno) >> 28) & 0xf)
>> +#define XIVE_SRCNO_INDEX(srcno) ((srcno) & 0x0fffffff)
>> +#define XIVE_SRCNO(blk, idx)    ((uint32_t)(blk) << 28 | (idx))
>> +
>> +/* EAS (Event Assignment Structure)
>> + *
>> + * One per interrupt source. Targets an interrupt to a given Event
>> + * Notification Descriptor (END) and provides the corresponding
>> + * logical interrupt number (END data)
>> + */
>> +typedef struct XiveEAS {
>> +        /* Use a single 64-bit definition to make it easier to
>> +         * perform atomic updates
>> +         */
>> +        uint64_t        w;
>> +#define EAS_VALID       PPC_BIT(0)
>> +#define EAS_END_BLOCK   PPC_BITMASK(4, 7)        /* Destination END b=
lock# */
>> +#define EAS_END_INDEX   PPC_BITMASK(8, 31)       /* Destination END i=
ndex */
>> +#define EAS_MASKED      PPC_BIT(32)              /* Masked */
>> +#define EAS_END_DATA    PPC_BITMASK(33, 63)      /* Data written to t=
he END */
>> +} XiveEAS;
>> +
>> +#define xive_eas_is_valid(eas)   (be64_to_cpu((eas)->w) & EAS_VALID)
>> +#define xive_eas_is_masked(eas)  (be64_to_cpu((eas)->w) & EAS_MASKED)
>> +
>> +#define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
>> +#define SETFIELD_BE64(m, v, val) cpu_to_be64(SETFIELD(m, be64_to_cpu(=
v), val))
>> +
>> +#endif /* PPC_XIVE_REGS_H */
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index 79238eb57fae..d21df6674d8c 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -443,6 +443,81 @@ static const TypeInfo xive_source_info =3D {
>>      .class_init    =3D xive_source_class_init,
>>  };
>> =20
>> +/*
>> + * XIVE Router (aka. Virtualization Controller or IVRE)
>> + */
>> +
>> +int xive_router_get_eas(XiveRouter *xrtr, uint8_t eas_blk, uint32_t e=
as_idx,
>> +                        XiveEAS *eas)
>> +{
>> +    XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
>> +
>> +    return xrc->get_eas(xrtr, eas_blk, eas_idx, eas);
>> +}
>=20
> Didn't spot this before, but it probably makes sense for such a
> trivial wrapper to be a static inline in the header.
>=20
>> +
>> +static void xive_router_notify(XiveNotifier *xn, uint32_t lisn)
>> +{
>> +    XiveRouter *xrtr =3D XIVE_ROUTER(xn);
>> +    uint8_t eas_blk =3D XIVE_SRCNO_BLOCK(lisn);
>> +    uint32_t eas_idx =3D XIVE_SRCNO_INDEX(lisn);
>> +    XiveEAS eas;
>> +
>> +    /* EAS cache lookup */
>> +    if (xive_router_get_eas(xrtr, eas_blk, eas_idx, &eas)) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Unknown LISN %x\n", lis=
n);
>> +        return;
>> +    }
>> +
>> +    /* The IVRE checks the State Bit Cache at this point. We skip the
>> +     * SBC lookup because the state bits of the sources are modeled
>> +     * internally in QEMU.
>> +     */
>> +
>> +    if (!xive_eas_is_valid(&eas)) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %x\n", lis=
n);
>> +        return;
>> +    }
>> +
>> +    if (xive_eas_is_masked(&eas)) {
>> +        /* Notification completed */
>> +        return;
>> +    }
>> +}
>> +
>> +static void xive_router_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +    XiveNotifierClass *xnc =3D XIVE_NOTIFIER_CLASS(klass);
>> +
>> +    dc->desc    =3D "XIVE Router Engine";
>> +    xnc->notify =3D xive_router_notify;
>> +}
>> +
>> +static const TypeInfo xive_router_info =3D {
>> +    .name          =3D TYPE_XIVE_ROUTER,
>> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
>> +    .abstract      =3D true,
>> +    .class_size    =3D sizeof(XiveRouterClass),
>> +    .class_init    =3D xive_router_class_init,
>> +    .interfaces    =3D (InterfaceInfo[]) {
>> +        { TYPE_XIVE_NOTIFIER },
>> +        { }
>> +    }
>> +};
>> +
>> +void xive_eas_pic_print_info(XiveEAS *eas, uint32_t lisn, Monitor *mo=
n)
>> +{
>> +    if (!xive_eas_is_valid(eas)) {
>> +        return;
>> +    }
>> +
>> +    monitor_printf(mon, "  %08x %s end:%02x/%04x data:%08x\n",
>> +                   lisn, xive_eas_is_masked(eas) ? "M" : " ",
>> +                   (uint8_t)  GETFIELD_BE64(EAS_END_BLOCK, eas->w),
>> +                   (uint32_t) GETFIELD_BE64(EAS_END_INDEX, eas->w),
>> +                   (uint32_t) GETFIELD_BE64(EAS_END_DATA, eas->w));
>> +}
>> +
>>  /*
>>   * XIVE Fabric
>>   */
>> @@ -456,6 +531,7 @@ static void xive_register_types(void)
>>  {
>>      type_register_static(&xive_source_info);
>>      type_register_static(&xive_fabric_info);
>> +    type_register_static(&xive_router_info);
>>  }
>> =20
>>  type_init(xive_register_types)
>=20
