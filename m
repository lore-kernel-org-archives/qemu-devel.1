Received: from eggs.gnu.org ([2001:4830:134:3::10]:34741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gUl96-0007ls-Ul
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 23:20:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gUl8z-0003BY-4E
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 23:20:15 -0500
Date: Thu, 6 Dec 2018 14:41:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181206034124.GM768@umbus.fritz.box>
References: <20181205232251.10446-1-clg@kaod.org>
	<20181205232251.10446-5-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FxlYARId5dseejUu"
Content-Disposition: inline
In-Reply-To: <20181205232251.10446-5-clg@kaod.org>
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
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--FxlYARId5dseejUu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2018 at 12:22:18AM +0100, C=E9dric Le Goater wrote:
> The XiveRouter models the second sub-engine of the XIVE architecture :
> the Interrupt Virtualization Routing Engine (IVRE).
>=20
> The IVRE handles event notifications of the IVSE and performs the
> interrupt routing process. For this purpose, it uses a set of tables
> stored in system memory, the first of which being the Event Assignment
> Structure (EAS) table.
>=20
> The EAT associates an interrupt source number with an Event Notification
> Descriptor (END) which will be used in a second phase of the routing
> process to identify a Notification Virtual Target.
>=20
> The XiveRouter is an abstract class which needs to be inherited from
> to define a storage for the EAT, and other upcoming tables.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/xive.h      | 31 ++++++++++++++++
>  include/hw/ppc/xive_regs.h | 50 +++++++++++++++++++++++++
>  hw/intc/xive.c             | 76 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 157 insertions(+)
>  create mode 100644 include/hw/ppc/xive_regs.h
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 6770cffec67d..57ec9f84f527 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -141,6 +141,8 @@
>  #define PPC_XIVE_H
> =20
>  #include "hw/qdev-core.h"
> +#include "hw/sysbus.h"
> +#include "hw/ppc/xive_regs.h"
> =20
>  /*
>   * XIVE Fabric (Interface between Source and Router)
> @@ -297,4 +299,33 @@ static inline void xive_source_irq_set(XiveSource *x=
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

I thought the plan was to make XiveRouter as well as XiveSource a
TYPE_DEVICE descendent rather than a SysBusDevice?

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
> +    int (*get_eas)(XiveRouter *xrtr, uint8_t eas_blk, uint32_t eas_idx,
> +                   XiveEAS *eas);
> +} XiveRouterClass;
> +
> +void xive_eas_pic_print_info(XiveEAS *eas, uint32_t lisn, Monitor *mon);
> +
> +int xive_router_get_eas(XiveRouter *xrtr, uint8_t eas_blk, uint32_t eas_=
idx,
> +                        XiveEAS *eas);
> +
>  #endif /* PPC_XIVE_H */
> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
> new file mode 100644
> index 000000000000..15f2470ed9cc
> --- /dev/null
> +++ b/include/hw/ppc/xive_regs.h
> @@ -0,0 +1,50 @@
> +/*
> + * QEMU PowerPC XIVE internal structure definitions
> + *
> + *
> + * The XIVE structures are accessed by the HW and their format is
> + * architected to be big-endian. Some macros are provided to ease
> + * access to the different fields.
> + *
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
> +/*
> + * Interrupt source number encoding on PowerBUS
> + */
> +#define XIVE_SRCNO_BLOCK(srcno) (((srcno) >> 28) & 0xf)
> +#define XIVE_SRCNO_INDEX(srcno) ((srcno) & 0x0fffffff)
> +#define XIVE_SRCNO(blk, idx)    ((uint32_t)(blk) << 28 | (idx))
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
> +#define xive_eas_is_valid(eas)   (be64_to_cpu((eas)->w) & EAS_VALID)
> +#define xive_eas_is_masked(eas)  (be64_to_cpu((eas)->w) & EAS_MASKED)
> +
> +#define GETFIELD_BE64(m, v)      GETFIELD(m, be64_to_cpu(v))
> +#define SETFIELD_BE64(m, v, val) cpu_to_be64(SETFIELD(m, be64_to_cpu(v),=
 val))
> +
> +#endif /* PPC_XIVE_REGS_H */
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 79238eb57fae..d21df6674d8c 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -443,6 +443,81 @@ static const TypeInfo xive_source_info =3D {
>      .class_init    =3D xive_source_class_init,
>  };
> =20
> +/*
> + * XIVE Router (aka. Virtualization Controller or IVRE)
> + */
> +
> +int xive_router_get_eas(XiveRouter *xrtr, uint8_t eas_blk, uint32_t eas_=
idx,
> +                        XiveEAS *eas)
> +{
> +    XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
> +
> +    return xrc->get_eas(xrtr, eas_blk, eas_idx, eas);
> +}

Didn't spot this before, but it probably makes sense for such a
trivial wrapper to be a static inline in the header.

> +
> +static void xive_router_notify(XiveNotifier *xn, uint32_t lisn)
> +{
> +    XiveRouter *xrtr =3D XIVE_ROUTER(xn);
> +    uint8_t eas_blk =3D XIVE_SRCNO_BLOCK(lisn);
> +    uint32_t eas_idx =3D XIVE_SRCNO_INDEX(lisn);
> +    XiveEAS eas;
> +
> +    /* EAS cache lookup */
> +    if (xive_router_get_eas(xrtr, eas_blk, eas_idx, &eas)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Unknown LISN %x\n", lisn);
> +        return;
> +    }
> +
> +    /* The IVRE checks the State Bit Cache at this point. We skip the
> +     * SBC lookup because the state bits of the sources are modeled
> +     * internally in QEMU.
> +     */
> +
> +    if (!xive_eas_is_valid(&eas)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %x\n", lisn);
> +        return;
> +    }
> +
> +    if (xive_eas_is_masked(&eas)) {
> +        /* Notification completed */
> +        return;
> +    }
> +}
> +
> +static void xive_router_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    XiveNotifierClass *xnc =3D XIVE_NOTIFIER_CLASS(klass);
> +
> +    dc->desc    =3D "XIVE Router Engine";
> +    xnc->notify =3D xive_router_notify;
> +}
> +
> +static const TypeInfo xive_router_info =3D {
> +    .name          =3D TYPE_XIVE_ROUTER,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .abstract      =3D true,
> +    .class_size    =3D sizeof(XiveRouterClass),
> +    .class_init    =3D xive_router_class_init,
> +    .interfaces    =3D (InterfaceInfo[]) {
> +        { TYPE_XIVE_NOTIFIER },
> +        { }
> +    }
> +};
> +
> +void xive_eas_pic_print_info(XiveEAS *eas, uint32_t lisn, Monitor *mon)
> +{
> +    if (!xive_eas_is_valid(eas)) {
> +        return;
> +    }
> +
> +    monitor_printf(mon, "  %08x %s end:%02x/%04x data:%08x\n",
> +                   lisn, xive_eas_is_masked(eas) ? "M" : " ",
> +                   (uint8_t)  GETFIELD_BE64(EAS_END_BLOCK, eas->w),
> +                   (uint32_t) GETFIELD_BE64(EAS_END_INDEX, eas->w),
> +                   (uint32_t) GETFIELD_BE64(EAS_END_DATA, eas->w));
> +}
> +
>  /*
>   * XIVE Fabric
>   */
> @@ -456,6 +531,7 @@ static void xive_register_types(void)
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

--FxlYARId5dseejUu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwImmIACgkQbDjKyiDZ
s5JGLg/9EZldKdoKUrt65i3pphGWxqmSJHRkJSsOVH+Ke7vjif5CvL3QMK1Uaj/4
bYznfxaKG5qpKjTsIxS1HMPR5A811KfEfP9N1HRrFErQzk0Z2AbWhRdf76Q8m5C1
KiEWtDmZ9tXZqzojkxZ5GCfRZeHAM/tnfnDgaEfFZRU4ZEWyx7ykhb785oAuZ52n
3+GHncOBUrOuzmj8+BJ7uA/fYu0FTBOp9zK1xaXaMq7AOZvdMZIHPPHZJ2FjOQCu
m44WtYLUg/oK9qZR2/8FiFFqbIKkAaVku481yF75UtaRoL6sNY/5IDkfE/96zWWM
9W3FfNI5JDArZg3oyl4ABjMF+IxHQYNJCmcP3nhdO6XsxPGE1mD5cItL7MZwb48V
zC6SiDcbQIEhrMe7kePMAx/3INz1NbJTw4ArZcp4joQkVecJKZF/bHIe2unwvTZN
1aeIIdMNjCb4BYSWgsiekDFoQsAc+0PbgGVAjY5gOqPnL6DClm/TdemSq7KxA0R/
VbhRcBGW+PoR4fEWE11NhDA9X7vvecrKF8fq+zK1QL87OU47nz5DqiM9837NpGDF
PqzFW26srYsO8PgYMds/isFfgLNZrkMLw1tQxXjr2kgZinokh24mGZcbxEdk3xL9
UD7/EVNX7CpEfjpLeSM/0/58XoXq+2BdCPtf7qqHghw3Qr+/hlg=
=X1yv
-----END PGP SIGNATURE-----

--FxlYARId5dseejUu--
