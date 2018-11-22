Received: from eggs.gnu.org ([2001:4830:134:3::10]:47228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gPhGN-0004n8-Bx
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 00:10:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gPhGL-0005aw-Ot
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 00:10:51 -0500
Date: Thu, 22 Nov 2018 15:11:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181122041119.GD10448@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-5-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LTeJQqWS0MN7I/qa"
Content-Disposition: inline
In-Reply-To: <20181116105729.23240-5-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 04/36] ppc/xive: introduce the
 XiveRouter model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 16, 2018 at 11:56:57AM +0100, C=E9dric Le Goater wrote:
> The XiveRouter models the second sub-engine of the overall XIVE
> architecture : the Interrupt Virtualization Routing Engine (IVRE).
>=20
> The IVRE handles event notifications of the IVSE through MMIO stores
> and performs the interrupt routing process. For this purpose, it uses
> a set of table stored in system memory, the first of which being the
> Event Assignment Structure (EAS) table.
>=20
> The EAT associates an interrupt source number with an Event Notification
> Descriptor (END) which will be used in a second phase of the routing
> process to identify a Notification Virtual Target.
>=20
> The XiveRouter is an abstract class which needs to be inherited from
> to define a storage for the EAT, and other upcoming tables. The
> 'chip-id' atttribute is not strictly necessary for the sPAPR and
> PowerNV machines but it's a good way to test the routing algorithm.
> Without this atttribute, the XiveRouter could be a simple QOM
> interface.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/xive.h      | 32 ++++++++++++++
>  include/hw/ppc/xive_regs.h | 31 ++++++++++++++
>  hw/intc/xive.c             | 86 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 149 insertions(+)
>  create mode 100644 include/hw/ppc/xive_regs.h
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index be93fae6317b..5a0696366577 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -11,6 +11,7 @@
>  #define PPC_XIVE_H
> =20
>  #include "hw/sysbus.h"

Again, I don't think making this a SysBusDevice is quite right.
Even more so for the router than the source, because at least for PAPR
it might not have any MMIO presence at all.

> +#include "hw/ppc/xive_regs.h"
> =20
>  /*
>   * XIVE Fabric (Interface between Source and Router)
> @@ -168,4 +169,35 @@ static inline void xive_source_irq_set(XiveSource *x=
src, uint32_t srcno,
>      }
>  }
> =20
> +/*
> + * XIVE Router
> + */
> +
> +typedef struct XiveRouter {
> +    SysBusDevice    parent;
> +
> +    uint32_t        chip_id;

I don't think this belongs in the base class.  The PowerNV specific
variants will need it, but it doesn't make sense for the PAPR version.

> +} XiveRouter;
> +
> +#define TYPE_XIVE_ROUTER "xive-router"
> +#define XIVE_ROUTER(obj)                                \
> +    OBJECT_CHECK(XiveRouter, (obj), TYPE_XIVE_ROUTER)
> +#define XIVE_ROUTER_CLASS(klass)                                        \
> +    OBJECT_CLASS_CHECK(XiveRouterClass, (klass), TYPE_XIVE_ROUTER)
> +#define XIVE_ROUTER_GET_CLASS(obj)                              \
> +    OBJECT_GET_CLASS(XiveRouterClass, (obj), TYPE_XIVE_ROUTER)
> +
> +typedef struct XiveRouterClass {
> +    SysBusDeviceClass parent;
> +
> +    /* XIVE table accessors */
> +    int (*get_eas)(XiveRouter *xrtr, uint32_t lisn, XiveEAS *eas);
> +    int (*set_eas)(XiveRouter *xrtr, uint32_t lisn, XiveEAS *eas);
> +} XiveRouterClass;
> +
> +void xive_eas_pic_print_info(XiveEAS *eas, uint32_t lisn, Monitor *mon);
> +
> +int xive_router_get_eas(XiveRouter *xrtr, uint32_t lisn, XiveEAS *eas);
> +int xive_router_set_eas(XiveRouter *xrtr, uint32_t lisn, XiveEAS *eas);
> +
>  #endif /* PPC_XIVE_H */
> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
> new file mode 100644
> index 000000000000..12499b33614c
> --- /dev/null
> +++ b/include/hw/ppc/xive_regs.h
> @@ -0,0 +1,31 @@
> +/*
> + * QEMU PowerPC XIVE interrupt controller model
> + *
> + * Copyright (c) 2016-2018, IBM Corporation.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + */
> +
> +#ifndef PPC_XIVE_REGS_H
> +#define PPC_XIVE_REGS_H
> +
> +/* EAS (Event Assignment Structure)
> + *
> + * One per interrupt source. Targets an interrupt to a given Event
> + * Notification Descriptor (END) and provides the corresponding
> + * logical interrupt number (END data)
> + */
> +typedef struct XiveEAS {
> +        /* Use a single 64-bit definition to make it easier to
> +         * perform atomic updates
> +         */
> +        uint64_t        w;
> +#define EAS_VALID       PPC_BIT(0)
> +#define EAS_END_BLOCK   PPC_BITMASK(4, 7)        /* Destination END bloc=
k# */
> +#define EAS_END_INDEX   PPC_BITMASK(8, 31)       /* Destination END inde=
x */
> +#define EAS_MASKED      PPC_BIT(32)              /* Masked */
> +#define EAS_END_DATA    PPC_BITMASK(33, 63)      /* Data written to the =
END */
> +} XiveEAS;
> +
> +#endif /* PPC_XIVE_REGS_H */
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 014a2e41f71f..c4c90a25758e 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -442,6 +442,91 @@ static const TypeInfo xive_source_info =3D {
>      .class_init    =3D xive_source_class_init,
>  };
> =20
> +/*
> + * XIVE Router (aka. Virtualization Controller or IVRE)
> + */
> +
> +int xive_router_get_eas(XiveRouter *xrtr, uint32_t lisn, XiveEAS *eas)
> +{
> +    XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
> +
> +    return xrc->get_eas(xrtr, lisn, eas);
> +}
> +
> +int xive_router_set_eas(XiveRouter *xrtr, uint32_t lisn, XiveEAS *eas)
> +{
> +    XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
> +
> +    return xrc->set_eas(xrtr, lisn, eas);
> +}
> +
> +static void xive_router_notify(XiveFabric *xf, uint32_t lisn)
> +{
> +    XiveRouter *xrtr =3D XIVE_ROUTER(xf);
> +    XiveEAS eas;
> +
> +    /* EAS cache lookup */
> +    if (xive_router_get_eas(xrtr, lisn, &eas)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Unknown LISN %x\n", lisn);
> +        return;
> +    }

AFAICT a bad LISN here means a qemu error (in the source, probably),
not a user or guest error, so an assert() would be more appropriate.

> +
> +    /* The IVRE has a State Bit Cache for its internal sources which
> +     * is also involed at this point. We skip the SBC lookup because
> +     * the state bits of the sources are modeled internally in QEMU.
> +     */
> +
> +    if (!(eas.w & EAS_VALID)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %x\n", lisn);
> +        return;
> +    }
> +
> +    if (eas.w & EAS_MASKED) {
> +        /* Notification completed */
> +        return;
> +    }
> +}
> +
> +static Property xive_router_properties[] =3D {
> +    DEFINE_PROP_UINT32("chip-id", XiveRouter, chip_id, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void xive_router_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    XiveFabricClass *xfc =3D XIVE_FABRIC_CLASS(klass);
> +
> +    dc->desc    =3D "XIVE Router Engine";
> +    dc->props   =3D xive_router_properties;
> +    xfc->notify =3D xive_router_notify;
> +}
> +
> +static const TypeInfo xive_router_info =3D {
> +    .name          =3D TYPE_XIVE_ROUTER,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .abstract      =3D true,
> +    .class_size    =3D sizeof(XiveRouterClass),
> +    .class_init    =3D xive_router_class_init,
> +    .interfaces    =3D (InterfaceInfo[]) {
> +        { TYPE_XIVE_FABRIC },

So as far as I can see so far, the XiveFabric interface will
essentially have to be implemented on the router object, so I'm not
seeing much point to having the interface rather than just a direct
call on the router object.  But I haven't read the whole series yet,
so maybe I'm missing something.


> +        { }
> +    }
> +};
> +
> +void xive_eas_pic_print_info(XiveEAS *eas, uint32_t lisn, Monitor *mon)
> +{
> +    if (!(eas->w & EAS_VALID)) {
> +        return;
> +    }
> +
> +    monitor_printf(mon, "  %08x %s end:%02x/%04x data:%08x\n",
> +                   lisn, eas->w & EAS_MASKED ? "M" : " ",
> +                   (uint8_t)  GETFIELD(EAS_END_BLOCK, eas->w),
> +                   (uint32_t) GETFIELD(EAS_END_INDEX, eas->w),
> +                   (uint32_t) GETFIELD(EAS_END_DATA, eas->w));
> +}
> +
>  /*
>   * XIVE Fabric
>   */
> @@ -455,6 +540,7 @@ static void xive_register_types(void)
>  {
>      type_register_static(&xive_source_info);
>      type_register_static(&xive_fabric_info);
> +    type_register_static(&xive_router_info);
>  }
> =20
>  type_init(xive_register_types)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LTeJQqWS0MN7I/qa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv2LGQACgkQbDjKyiDZ
s5Kg1w//Xy7xLxAfTWvGBwPY6sMP5wLf2hImgYOeTJmq+oytbZCK4SCYmI7iDGwm
UwDHOs/lKFt01AJzoZ6RS2CYCY3+9xEsZ5R8RGvqiRqB6SSeyR2oDNzoCzc3ZML2
gW7QCdebH6DPT2lAMC4tyw4RB3jpvSQzAO/gOGcwvIwBK6GpeHSvLRJJu+BwxoAz
ATq4Ds2kFdZL6hYoKZEm57CgcKzwk3MTtPjUZC0kw8BkkyN/Ra20N1T4K4zFNtt2
MB2HewRwxhn4qVmVE1RCcixurVZEIfBvtsdgeiV2T6R/VJ5ANFc9P/IrAL5JV1Bi
2+c1o9EzqxQzHBz5h6Ru5nYIZ2nYG8shu3e0+wz03UVg8/GM8m7wAK21Rai7hyqP
qMmyfW/odk0Jtz+0VoPAYAW445O2wqeikvIwGOVj6ELTPoQhozHaGxL0IhKGobzD
e7E4GZZdouL9pSGofzplTb642W7hSBlCT7jkpKv7+i+CfHcesuCfOEqNDv9sjLPx
ijLj8Doh7ZNAkCUxGT1EbYOFEYrCBLxt8E9A04J+L1MqyOub/ihqaRe5eTMNrG9q
enJgVZELd/Kfres5j93r8h3sPc4+wh8ZilpKbGTX+a+7UKTQN598GjX2UdTgAToJ
F30w4Y2/cpNEk8ET7zXKO/Fu41C449AlOYgTTVwyR1U8dOaluuM=
=gWaw
-----END PGP SIGNATURE-----

--LTeJQqWS0MN7I/qa--
