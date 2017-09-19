Received: from eggs.gnu.org ([2001:4830:134:3::10]:51265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtY-0001H4-GR
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtT-0002t3-R3
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:48 -0400
Date: Tue, 19 Sep 2017 12:39:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170919023943.GI27153@umbus>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dMdWWqg3F2Dv/qfw"
Content-Disposition: inline
In-Reply-To: <20170911171235.29331-4-clg@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH v2 03/21] ppc/xive: define the XIVE
 internal tables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>


--dMdWWqg3F2Dv/qfw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2017 at 07:12:17PM +0200, C=E9dric Le Goater wrote:
> The XIVE interrupt controller of the POWER9 uses a set of tables to
> redirect exception from event sources to CPU threads. Among which we
> choose to model :
>=20
>  - the State Bit Entries (SBE), also known as Event State Buffer
>    (ESB). This is a two bit state machine for each event source which
>    is used to trigger events. The bits are named "P" (pending) and "Q"
>    (queued) and can be controlled by MMIO.
>=20
>  - the Interrupt Virtualization Entry (IVE) table, also known as Event
>    Assignment Structure (EAS). This table is indexed by the IRQ number
>    and is looked up to find the Event Queue associated with a
>    triggered event.

Both the above are one entry per irq source, yes?  What's the
rationale for having them as parallel tables, rather than bits in a
single per-source structure?

>  - the Event Queue Descriptor (EQD) table, also known as Event
>    Notification Descriptor (END). The EQD contains fields that specify
>    the Event Queue on which event data is posted (and later pulled by
>    the OS) and also a target (or VPD) to notify.
>=20
> An additional table was not modeled but we might need to support the
> H_INT_SET_OS_REPORTING_LINE hcall:
>=20
>  - the Virtual Processor Descriptor (VPD) table, also known as
>    Notification Virtual Target (NVT).
>=20
> The XIVE object is expanded with the tables described above. The size
> of each table depends on the number of provisioned IRQ and the maximum
> number of CPUs in the system. The indexing is very basic and might
> need to be improved for the EQs.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/spapr_xive.c        | 108 ++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/intc/xive-internal.h     | 105 ++++++++++++++++++++++++++++++++++++++=
++++
>  include/hw/ppc/spapr_xive.h |   9 ++++
>  3 files changed, 222 insertions(+)
>  create mode 100644 hw/intc/xive-internal.h
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index c83796519586..6d98528fae68 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -25,11 +25,34 @@
>  #include "hw/ppc/xics.h"
>  #include "hw/ppc/spapr_xive.h"
> =20
> +#include "xive-internal.h"
> =20
>  /*
>   * Main XIVE object
>   */
> =20
> +void spapr_xive_reset(void *dev)
> +{
> +    sPAPRXive *xive =3D SPAPR_XIVE(dev);
> +    int i;
> +
> +    /* SBEs are initialized to 0b01 which corresponds to "ints off" */
> +    memset(xive->sbe, 0x55, xive->sbe_size);
> +
> +    /* Validate all available IVEs in the IRQ number space. It would
> +     * be more correct to validate only the allocated IRQs but this
> +     * would require some callback routine from the spapr machine into
> +     * XIVE. To be done later.
> +     */
> +    for (i =3D 0; i < xive->nr_irqs; i++) {
> +        XiveIVE *ive =3D &xive->ivt[i];
> +        ive->w =3D IVE_VALID | IVE_MASKED;
> +    }
> +
> +    /* clear all EQs */
> +    memset(xive->eqt, 0, xive->nr_eqs * sizeof(XiveEQ));
> +}
> +
>  static void spapr_xive_realize(DeviceState *dev, Error **errp)
>  {
>      sPAPRXive *xive =3D SPAPR_XIVE(dev);
> @@ -44,8 +67,64 @@ static void spapr_xive_realize(DeviceState *dev, Error=
 **errp)
>          error_setg(errp, "Number of interrupts too small");
>          return;
>      }
> +
> +    /* Allocate SBEs (State Bit Entry). 2 bits, so 4 entries per byte */
> +    xive->sbe_size =3D DIV_ROUND_UP(xive->nr_irqs, 4);
> +    xive->sbe =3D g_malloc0(xive->sbe_size);
> +
> +    /* Allocate the IVT (Interrupt Virtualization Table) */
> +    xive->ivt =3D g_malloc0(xive->nr_irqs * sizeof(XiveIVE));
> +
> +    /* Allocate the EQDT (Event Queue Descriptor Table), 8 priorities
> +     * for each thread in the system */
> +    xive->nr_eqs =3D xive->nr_targets * XIVE_EQ_PRIORITY_COUNT;
> +    xive->eqt =3D g_malloc0(xive->nr_eqs * sizeof(XiveEQ));
> +
> +    qemu_register_reset(spapr_xive_reset, dev);
>  }
> =20
> +static const VMStateDescription vmstate_spapr_xive_ive =3D {
> +    .name =3D "xive/ive",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField []) {
> +        VMSTATE_UINT64(w, XiveIVE),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static const VMStateDescription vmstate_spapr_xive_eq =3D {
> +    .name =3D "xive/eq",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField []) {
> +        VMSTATE_UINT32(w0, XiveEQ),
> +        VMSTATE_UINT32(w1, XiveEQ),
> +        VMSTATE_UINT32(w2, XiveEQ),
> +        VMSTATE_UINT32(w3, XiveEQ),
> +        VMSTATE_UINT32(w4, XiveEQ),
> +        VMSTATE_UINT32(w5, XiveEQ),
> +        VMSTATE_UINT32(w6, XiveEQ),
> +        VMSTATE_UINT32(w7, XiveEQ),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static const VMStateDescription vmstate_xive =3D {
> +    .name =3D "xive",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_VARRAY_UINT32_ALLOC(sbe, sPAPRXive, sbe_size, 0,
> +                                    vmstate_info_uint8, uint8_t),

Since you're treating the SBE as a packed buffer of u8s anyway, it's
probably simpler to use VMSTATE_BUFFER().  I don't see that you need
the ALLOC - it should have already been allocated on the destination.

Might be worth having a VMSTATE_UINT32_EQUAL to sanity check that
sbe_size is equal at either end.

> +        VMSTATE_STRUCT_VARRAY_UINT32_ALLOC(ivt, sPAPRXive, nr_irqs, 0,
> +                                    vmstate_spapr_xive_ive, XiveIVE),
> +        VMSTATE_STRUCT_VARRAY_UINT32_ALLOC(eqt, sPAPRXive, nr_eqs, 0,
> +                                    vmstate_spapr_xive_eq, XiveEQ),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static Property spapr_xive_properties[] =3D {
>      DEFINE_PROP_UINT32("nr-irqs", sPAPRXive, nr_irqs, 0),
>      DEFINE_PROP_UINT32("nr-targets", sPAPRXive, nr_targets, 0),
> @@ -59,6 +138,7 @@ static void spapr_xive_class_init(ObjectClass *klass, =
void *data)
>      dc->realize =3D spapr_xive_realize;
>      dc->props =3D spapr_xive_properties;
>      dc->desc =3D "sPAPR XIVE interrupt controller";
> +    dc->vmsd =3D &vmstate_xive;
>  }
> =20
>  static const TypeInfo spapr_xive_info =3D {
> @@ -74,3 +154,31 @@ static void spapr_xive_register_types(void)
>  }
> =20
>  type_init(spapr_xive_register_types)
> +
> +XiveIVE *spapr_xive_get_ive(sPAPRXive *xive, uint32_t idx)
> +{
> +    return idx < xive->nr_irqs ? &xive->ivt[idx] : NULL;
> +}
> +
> +XiveEQ *spapr_xive_get_eq(sPAPRXive *xive, uint32_t idx)
> +{
> +    return idx < xive->nr_eqs ? &xive->eqt[idx] : NULL;
> +}
> +
> +/* TODO: improve EQ indexing. This is very simple and relies on the
> + * fact that target (CPU) numbers start at 0 and are contiguous. It
> + * should be OK for sPAPR.
> + */
> +bool spapr_xive_eq_for_target(sPAPRXive *xive, uint32_t target,
> +                              uint8_t priority, uint32_t *out_eq_idx)
> +{
> +    if (priority > XIVE_PRIORITY_MAX || target >=3D xive->nr_targets) {
> +        return false;
> +    }
> +
> +    if (out_eq_idx) {
> +        *out_eq_idx =3D target + priority;

Don't you need to multiply target by XIVE_EQ_PRIORITY_COUNT?

> +    }
> +
> +    return true;
> +}
> diff --git a/hw/intc/xive-internal.h b/hw/intc/xive-internal.h
> new file mode 100644
> index 000000000000..95184bad5c1d
> --- /dev/null
> +++ b/hw/intc/xive-internal.h
> @@ -0,0 +1,105 @@
> +/*
> + * QEMU PowerPC XIVE model
> + *
> + * Copyright 2016,2017 IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +#ifndef _INTC_XIVE_INTERNAL_H
> +#define _INTC_XIVE_INTERNAL_H
> +
> +/* Utilities to manipulate these (originaly from OPAL) */
> +#define MASK_TO_LSH(m)          (__builtin_ffsl(m) - 1)
> +#define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
> +#define SETFIELD(m, v, val)                             \
> +        (((v) & ~(m)) | ((((typeof(v))(val)) << MASK_TO_LSH(m)) & (m)))
> +
> +#define PPC_BIT(bit)            (0x8000000000000000UL >> (bit))
> +#define PPC_BIT32(bit)          (0x80000000UL >> (bit))
> +#define PPC_BIT8(bit)           (0x80UL >> (bit))
> +#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(b=
s))
> +#define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
> +                                 PPC_BIT32(bs))
> +
> +/* IVE/EAS
> + *
> + * One per interrupt source. Targets that interrupt to a given EQ
> + * and provides the corresponding logical interrupt number (EQ data)
> + *
> + * We also map this structure to the escalation descriptor inside
> + * an EQ, though in that case the valid and masked bits are not used.
> + */
> +typedef struct XiveIVE {
> +        /* Use a single 64-bit definition to make it easier to
> +         * perform atomic updates
> +         */
> +        uint64_t        w;
> +#define IVE_VALID       PPC_BIT(0)
> +#define IVE_EQ_BLOCK    PPC_BITMASK(4, 7)        /* Destination EQ block=
# */
> +#define IVE_EQ_INDEX    PPC_BITMASK(8, 31)       /* Destination EQ index=
 */
> +#define IVE_MASKED      PPC_BIT(32)              /* Masked */
> +#define IVE_EQ_DATA     PPC_BITMASK(33, 63)      /* Data written to the =
EQ */
> +} XiveIVE;
> +
> +/* EQ */
> +typedef struct XiveEQ {
> +        uint32_t        w0;

It'd be nice if IBM came up with better names for its fields thatn w0,
w1, etc.   Oh well.

> +#define EQ_W0_VALID             PPC_BIT32(0)
> +#define EQ_W0_ENQUEUE           PPC_BIT32(1)
> +#define EQ_W0_UCOND_NOTIFY      PPC_BIT32(2)
> +#define EQ_W0_BACKLOG           PPC_BIT32(3)
> +#define EQ_W0_PRECL_ESC_CTL     PPC_BIT32(4)
> +#define EQ_W0_ESCALATE_CTL      PPC_BIT32(5)
> +#define EQ_W0_END_OF_INTR       PPC_BIT32(6)
> +#define EQ_W0_QSIZE             PPC_BITMASK32(12, 15)
> +#define EQ_W0_SW0               PPC_BIT32(16)
> +#define EQ_W0_FIRMWARE          EQ_W0_SW0 /* Owned by FW */
> +#define EQ_QSIZE_4K             0
> +#define EQ_QSIZE_64K            4
> +#define EQ_W0_HWDEP             PPC_BITMASK32(24, 31)
> +        uint32_t        w1;
> +#define EQ_W1_ESn               PPC_BITMASK32(0, 1)
> +#define EQ_W1_ESn_P             PPC_BIT32(0)
> +#define EQ_W1_ESn_Q             PPC_BIT32(1)
> +#define EQ_W1_ESe               PPC_BITMASK32(2, 3)
> +#define EQ_W1_ESe_P             PPC_BIT32(2)
> +#define EQ_W1_ESe_Q             PPC_BIT32(3)
> +#define EQ_W1_GENERATION        PPC_BIT32(9)
> +#define EQ_W1_PAGE_OFF          PPC_BITMASK32(10, 31)
> +        uint32_t        w2;
> +#define EQ_W2_MIGRATION_REG     PPC_BITMASK32(0, 3)
> +#define EQ_W2_OP_DESC_HI        PPC_BITMASK32(4, 31)
> +        uint32_t        w3;
> +#define EQ_W3_OP_DESC_LO        PPC_BITMASK32(0, 31)
> +        uint32_t        w4;
> +#define EQ_W4_ESC_EQ_BLOCK      PPC_BITMASK32(4, 7)
> +#define EQ_W4_ESC_EQ_INDEX      PPC_BITMASK32(8, 31)
> +        uint32_t        w5;
> +#define EQ_W5_ESC_EQ_DATA       PPC_BITMASK32(1, 31)
> +        uint32_t        w6;
> +#define EQ_W6_FORMAT_BIT        PPC_BIT32(8)
> +#define EQ_W6_NVT_BLOCK         PPC_BITMASK32(9, 12)
> +#define EQ_W6_NVT_INDEX         PPC_BITMASK32(13, 31)
> +        uint32_t        w7;
> +#define EQ_W7_F0_IGNORE         PPC_BIT32(0)
> +#define EQ_W7_F0_BLK_GROUPING   PPC_BIT32(1)
> +#define EQ_W7_F0_PRIORITY       PPC_BITMASK32(8, 15)
> +#define EQ_W7_F1_WAKEZ          PPC_BIT32(0)
> +#define EQ_W7_F1_LOG_SERVER_ID  PPC_BITMASK32(1, 31)
> +} XiveEQ;
> +
> +#define XIVE_EQ_PRIORITY_COUNT 8
> +#define XIVE_PRIORITY_MAX  (XIVE_EQ_PRIORITY_COUNT - 1)
> +
> +void spapr_xive_reset(void *dev);
> +XiveIVE *spapr_xive_get_ive(sPAPRXive *xive, uint32_t isn);
> +XiveEQ *spapr_xive_get_eq(sPAPRXive *xive, uint32_t idx);
> +
> +bool spapr_xive_eq_for_target(sPAPRXive *xive, uint32_t target, uint8_t =
prio,
> +                        uint32_t *out_eq_idx);
> +
> +
> +#endif /* _INTC_XIVE_INTERNAL_H */
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 5b99f7fc2b81..b17dd4f17b0b 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -22,6 +22,8 @@
>  #include <hw/sysbus.h>
> =20
>  typedef struct sPAPRXive sPAPRXive;
> +typedef struct XiveIVE XiveIVE;
> +typedef struct XiveEQ XiveEQ;
> =20
>  #define TYPE_SPAPR_XIVE "spapr-xive"
>  #define SPAPR_XIVE(obj) OBJECT_CHECK(sPAPRXive, (obj), TYPE_SPAPR_XIVE)
> @@ -32,6 +34,13 @@ struct sPAPRXive {
>      /* Properties */
>      uint32_t     nr_targets;
>      uint32_t     nr_irqs;
> +
> +    /* XIVE internal tables */
> +    uint8_t      *sbe;
> +    uint32_t     sbe_size;
> +    XiveIVE      *ivt;
> +    XiveEQ       *eqt;
> +    uint32_t     nr_eqs;
>  };
> =20
>  #endif /* PPC_SPAPR_XIVE_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dMdWWqg3F2Dv/qfw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnAg20ACgkQbDjKyiDZ
s5LjFw//bZY+uRCsbGYQBBsw+qrSl6gGKUTN9ToyKjqs/IKV5lRtUD/hZwVJbXgh
uUbvkG1b4V+jbquH5cOHyURslJKIznpicrYDMeKBwr9YunZGvTo8NQy2sCQeJMZ/
ZpfKNFGcqFKLm5D2CggWpJJjMXcClCMWQQHCeL9YBqI7DI33kT5iZVixQQIuEdj9
0E0TsNyxzqwvwkROWkmYZ3f+1LXHPtXSHqtw843b5T8I7x1sALzkSZbgP3ypY8TA
dY59zjBNBoOIAUpNqHLhJ+mm/KPKTBy1eS7HYbT7hUBmpYeK2c9QqVzkH7klXl2a
XDT0zo/8n5MPCSFrCg5biUB2WmPqwDTIf3xTBRldzbERMcnXUGwHVXCwjPBLAg7J
OMTu1PRt9UV5r4op/svEeTdBsLiO4fzEPlxkgpHa8QYnix0aOi4uPWSOQz8pcsl0
MhLkY+rNXgOK2WYdGQy7FI6iBrNQx//nEjeMd2+nT7zKPPGHk07V+00a/Mcsyw6s
Wk1hUcyZeolpjaHbg67XQWZT1YrZBTNcyS3hMNCQEFLYabHxUHMWwvpFhdve4kof
9Xud/mkfsCzhn6QMQsxAcILhItpdMCbxMDZSvSwwqdwhj7bfTPnQoHozYY7zKvh9
nLp1xPwcWqPw1W4mY5RnFyzRmwDpG5Znv9GSOa+utNSQvO67SWU=
=x2yr
-----END PGP SIGNATURE-----

--dMdWWqg3F2Dv/qfw--
