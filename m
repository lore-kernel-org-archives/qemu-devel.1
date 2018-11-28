Received: from eggs.gnu.org ([2001:4830:134:3::10]:52715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRoKy-0002do-7i
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 20:08:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRo6I-00021G-8O
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 19:53:14 -0500
Date: Wed, 28 Nov 2018 11:52:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181128005255.GT2251@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-11-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/7+LvQqw8N5lf/3J"
Content-Disposition: inline
In-Reply-To: <20181116105729.23240-11-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 10/36] spapr/xive: introduce a XIVE
 interrupt controller
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


--/7+LvQqw8N5lf/3J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 16, 2018 at 11:57:03AM +0100, C=E9dric Le Goater wrote:
> sPAPRXive models the XIVE interrupt controller of the sPAPR machine.
> It inherits from the XiveRouter and provisions storage for the routing
> tables :
>=20
>   - Event Assignment Structure (EAS)
>   - Event Notification Descriptor (END)
>=20
> The sPAPRXive model incorporates an internal XiveSource for the IPIs
> and for the interrupts of the virtual devices of the guest. This model
> is consistent with XIVE architecture which also incorporates an
> internal IVSE for IPIs and accelerator interrupts in the IVRE
> sub-engine.
>=20
> The sPAPRXive model exports two memory regions, one for the ESB
> trigger and management pages used to control the sources and one for
> the TIMA pages. They are mapped by default at the addresses found on
> chip 0 of a baremetal system. This is also consistent with the XIVE
> architecture which defines a Virtualization Controller BAR for the
> internal IVSE ESB pages and a Thread Managment BAR for the TIMA.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  default-configs/ppc64-softmmu.mak |   1 +
>  include/hw/ppc/spapr_xive.h       |  46 +++++
>  hw/intc/spapr_xive.c              | 323 ++++++++++++++++++++++++++++++
>  hw/intc/Makefile.objs             |   1 +
>  4 files changed, 371 insertions(+)
>  create mode 100644 include/hw/ppc/spapr_xive.h
>  create mode 100644 hw/intc/spapr_xive.c
>=20
> diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-so=
ftmmu.mak
> index 2d1e7c5c4668..7f34ad0528ed 100644
> --- a/default-configs/ppc64-softmmu.mak
> +++ b/default-configs/ppc64-softmmu.mak
> @@ -17,6 +17,7 @@ CONFIG_XICS=3D$(CONFIG_PSERIES)
>  CONFIG_XICS_SPAPR=3D$(CONFIG_PSERIES)
>  CONFIG_XICS_KVM=3D$(call land,$(CONFIG_PSERIES),$(CONFIG_KVM))
>  CONFIG_XIVE=3D$(CONFIG_PSERIES)
> +CONFIG_XIVE_SPAPR=3D$(CONFIG_PSERIES)
>  CONFIG_MEM_DEVICE=3Dy
>  CONFIG_DIMM=3Dy
>  CONFIG_SPAPR_RNG=3Dy
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> new file mode 100644
> index 000000000000..06727bd86aa9
> --- /dev/null
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -0,0 +1,46 @@
> +/*
> + * QEMU PowerPC sPAPR XIVE interrupt controller model
> + *
> + * Copyright (c) 2017-2018, IBM Corporation.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + */
> +
> +#ifndef PPC_SPAPR_XIVE_H
> +#define PPC_SPAPR_XIVE_H
> +
> +#include "hw/sysbus.h"
> +#include "hw/ppc/xive.h"
> +
> +#define TYPE_SPAPR_XIVE "spapr-xive"
> +#define SPAPR_XIVE(obj) OBJECT_CHECK(sPAPRXive, (obj), TYPE_SPAPR_XIVE)
> +
> +typedef struct sPAPRXive {
> +    XiveRouter    parent;
> +
> +    /* Internal interrupt source for IPIs and virtual devices */
> +    XiveSource    source;
> +    hwaddr        vc_base;
> +
> +    /* END ESB MMIOs */
> +    XiveENDSource end_source;
> +    hwaddr        end_base;
> +
> +    /* Routing table */
> +    XiveEAS       *eat;
> +    uint32_t      nr_irqs;
> +    XiveEND       *endt;
> +    uint32_t      nr_ends;
> +
> +    /* TIMA mapping address */
> +    hwaddr        tm_base;
> +    MemoryRegion  tm_mmio;
> +} sPAPRXive;
> +
> +bool spapr_xive_irq_enable(sPAPRXive *xive, uint32_t lisn, bool lsi);
> +bool spapr_xive_irq_disable(sPAPRXive *xive, uint32_t lisn);
> +void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
> +qemu_irq spapr_xive_qirq(sPAPRXive *xive, uint32_t lisn);
> +
> +#endif /* PPC_SPAPR_XIVE_H */
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> new file mode 100644
> index 000000000000..5d038146c08e
> --- /dev/null
> +++ b/hw/intc/spapr_xive.c
> @@ -0,0 +1,323 @@
> +/*
> + * QEMU PowerPC sPAPR XIVE interrupt controller model
> + *
> + * Copyright (c) 2017-2018, IBM Corporation.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "target/ppc/cpu.h"
> +#include "sysemu/cpus.h"
> +#include "monitor/monitor.h"
> +#include "hw/ppc/spapr.h"
> +#include "hw/ppc/spapr_xive.h"
> +#include "hw/ppc/xive.h"
> +#include "hw/ppc/xive_regs.h"
> +
> +/*
> + * XIVE Virtualization Controller BAR and Thread Managment BAR that we
> + * use for the ESB pages and the TIMA pages
> + */
> +#define SPAPR_XIVE_VC_BASE   0x0006010000000000ull
> +#define SPAPR_XIVE_TM_BASE   0x0006030203180000ull
> +
> +void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon)
> +{
> +    int i;
> +    uint32_t offset =3D 0;
> +
> +    monitor_printf(mon, "XIVE Source %08x .. %08x\n", offset,
> +                   offset + xive->source.nr_irqs - 1);
> +    xive_source_pic_print_info(&xive->source, offset, mon);
> +
> +    monitor_printf(mon, "XIVE EAT %08x .. %08x\n", 0, xive->nr_irqs - 1);
> +    for (i =3D 0; i < xive->nr_irqs; i++) {
> +        xive_eas_pic_print_info(&xive->eat[i], i, mon);
> +    }
> +
> +    monitor_printf(mon, "XIVE ENDT %08x .. %08x\n", 0, xive->nr_ends - 1=
);
> +    for (i =3D 0; i < xive->nr_ends; i++) {
> +        xive_end_pic_print_info(&xive->endt[i], i, mon);
> +    }

AIUI the PAPR model hides the details of ENDs, EQs and NVTs - instead
each logical EAS just points at a (thread, priority) pair, which under
the hood has exactly one END and one NVT bound to it.

Given that, would it make more sense to reformat the info here to show
things in terms of those (thread, priority) pairs, rather than the
internal EAS and END details?

> +}
> +
> +/* Map the ESB pages and the TIMA pages */
> +static void spapr_xive_mmio_map(sPAPRXive *xive)
> +{
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&xive->source), 0, xive->vc_base);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&xive->end_source), 0, xive->end_base=
);

Uh.. I didn't think the PAPR model exposed the END sources to the guest?

> +    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 0, xive->tm_base);
> +}
> +
> +static void spapr_xive_reset(DeviceState *dev)
> +{
> +    sPAPRXive *xive =3D SPAPR_XIVE(dev);
> +    int i;
> +
> +    /* Xive Source reset is done through SysBus, it should put all
> +     * IRQs to OFF (!P|Q) */
> +
> +    /* Mask all valid EASs in the IRQ number space. */
> +    for (i =3D 0; i < xive->nr_irqs; i++) {
> +        XiveEAS *eas =3D &xive->eat[i];
> +        if (eas->w & EAS_VALID) {
> +            eas->w |=3D EAS_MASKED;

To ensure consistent behaviour across reboots, it would be better to
reset the whole of the EAS, except those which have to be preserved
across reboots (which would be VALID, and maybe nothing else?).

> +        }
> +    }
> +
> +    for (i =3D 0; i < xive->nr_ends; i++) {
> +        xive_end_reset(&xive->endt[i]);
> +    }
> +
> +    spapr_xive_mmio_map(xive);

You shouldn't need to re-etablish MMIO mappings at reset time, only
during initialization.

> +}
> +
> +static void spapr_xive_instance_init(Object *obj)
> +{
> +    sPAPRXive *xive =3D SPAPR_XIVE(obj);
> +
> +    object_initialize(&xive->source, sizeof(xive->source), TYPE_XIVE_SOU=
RCE);

Yeah, embedding the source here makes sense, but it's a strong
indication that XiveSource should not be a SysBusDevice subclass.  I
really think it wants to be a TYPE_DEVICE subclass - and, in fact, I
think it can be object_initialize() embedded everywhere it's used.

I've also said elswhere that I suspect XiveRouter should also not be a
SysBusDevice.  With that approach it might make sense to embed it
here, rather than subclassing it (the old composition vs. inheritance
debate).

> +    object_property_add_child(obj, "source", OBJECT(&xive->source), NULL=
);
> +
> +    object_initialize(&xive->end_source, sizeof(xive->end_source),
> +                      TYPE_XIVE_END_SOURCE);
> +    object_property_add_child(obj, "end_source", OBJECT(&xive->end_sourc=
e),
> +                              NULL);
> +}
> +
> +static void spapr_xive_realize(DeviceState *dev, Error **errp)
> +{
> +    sPAPRXive *xive =3D SPAPR_XIVE(dev);
> +    XiveSource *xsrc =3D &xive->source;
> +    XiveENDSource *end_xsrc =3D &xive->end_source;
> +    Error *local_err =3D NULL;
> +
> +    if (!xive->nr_irqs) {
> +        error_setg(errp, "Number of interrupt needs to be greater 0");
> +        return;
> +    }
> +
> +    if (!xive->nr_ends) {
> +        error_setg(errp, "Number of interrupt needs to be greater 0");
> +        return;
> +    }
> +
> +    /*
> +     * Initialize the internal sources, for IPIs and virtual devices.
> +     */
> +    object_property_set_int(OBJECT(xsrc), xive->nr_irqs, "nr-irqs",
> +                            &error_fatal);
> +    object_property_add_const_link(OBJECT(xsrc), "xive", OBJECT(xive),
> +                                   &error_fatal);
> +    object_property_set_bool(OBJECT(xsrc), true, "realized", &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +    qdev_set_parent_bus(DEVICE(xsrc), sysbus_get_default());
> +
> +    /*
> +     * Initialize the END ESB source
> +     */
> +    object_property_set_int(OBJECT(end_xsrc), xive->nr_irqs, "nr-ends",
> +                            &error_fatal);
> +    object_property_add_const_link(OBJECT(end_xsrc), "xive", OBJECT(xive=
),
> +                                   &error_fatal);
> +    object_property_set_bool(OBJECT(end_xsrc), true, "realized", &local_=
err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +    qdev_set_parent_bus(DEVICE(end_xsrc), sysbus_get_default());
> +
> +    /* Set the mapping address of the END ESB pages after the source ESB=
s */
> +    xive->end_base =3D xive->vc_base + (1ull << xsrc->esb_shift) * xsrc-=
>nr_irqs;
> +
> +    /*
> +     * Allocate the routing tables
> +     */
> +    xive->eat =3D g_new0(XiveEAS, xive->nr_irqs);
> +    xive->endt =3D g_new0(XiveEND, xive->nr_ends);
> +
> +    /* TIMA initialization */
> +    memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_ops, xi=
ve,
> +                          "xive.tima", 4ull << TM_SHIFT);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &xive->tm_mmio);
> +}
> +
> +static int spapr_xive_get_eas(XiveRouter *xrtr, uint32_t lisn, XiveEAS *=
eas)
> +{
> +    sPAPRXive *xive =3D SPAPR_XIVE(xrtr);
> +
> +    if (lisn >=3D xive->nr_irqs) {
> +        return -1;
> +    }
> +
> +    *eas =3D xive->eat[lisn];
> +    return 0;
> +}
> +
> +static int spapr_xive_set_eas(XiveRouter *xrtr, uint32_t lisn, XiveEAS *=
eas)
> +{
> +    sPAPRXive *xive =3D SPAPR_XIVE(xrtr);
> +
> +    if (lisn >=3D xive->nr_irqs) {
> +        return -1;
> +    }
> +
> +    xive->eat[lisn] =3D *eas;
> +    return 0;
> +}
> +
> +static int spapr_xive_get_end(XiveRouter *xrtr,
> +                              uint8_t end_blk, uint32_t end_idx, XiveEND=
 *end)
> +{
> +    sPAPRXive *xive =3D SPAPR_XIVE(xrtr);
> +
> +    if (end_idx >=3D xive->nr_ends) {
> +        return -1;
> +    }
> +
> +    memcpy(end, &xive->endt[end_idx], sizeof(XiveEND));
> +    return 0;
> +}
> +
> +static int spapr_xive_set_end(XiveRouter *xrtr,
> +                              uint8_t end_blk, uint32_t end_idx, XiveEND=
 *end)
> +{
> +    sPAPRXive *xive =3D SPAPR_XIVE(xrtr);
> +
> +    if (end_idx >=3D xive->nr_ends) {
> +        return -1;
> +    }
> +
> +    memcpy(&xive->endt[end_idx], end, sizeof(XiveEND));
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_spapr_xive_end =3D {
> +    .name =3D TYPE_SPAPR_XIVE "/end",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField []) {
> +        VMSTATE_UINT32(w0, XiveEND),
> +        VMSTATE_UINT32(w1, XiveEND),
> +        VMSTATE_UINT32(w2, XiveEND),
> +        VMSTATE_UINT32(w3, XiveEND),
> +        VMSTATE_UINT32(w4, XiveEND),
> +        VMSTATE_UINT32(w5, XiveEND),
> +        VMSTATE_UINT32(w6, XiveEND),
> +        VMSTATE_UINT32(w7, XiveEND),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static const VMStateDescription vmstate_spapr_xive_eas =3D {
> +    .name =3D TYPE_SPAPR_XIVE "/eas",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField []) {
> +        VMSTATE_UINT64(w, XiveEAS),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static const VMStateDescription vmstate_spapr_xive =3D {
> +    .name =3D TYPE_SPAPR_XIVE,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32_EQUAL(nr_irqs, sPAPRXive, NULL),
> +        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(eat, sPAPRXive, nr_irqs,
> +                                     vmstate_spapr_xive_eas, XiveEAS),
> +        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(endt, sPAPRXive, nr_ends,
> +                                             vmstate_spapr_xive_end, Xiv=
eEND),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static Property spapr_xive_properties[] =3D {
> +    DEFINE_PROP_UINT32("nr-irqs", sPAPRXive, nr_irqs, 0),
> +    DEFINE_PROP_UINT32("nr-ends", sPAPRXive, nr_ends, 0),
> +    DEFINE_PROP_UINT64("vc-base", sPAPRXive, vc_base, SPAPR_XIVE_VC_BASE=
),
> +    DEFINE_PROP_UINT64("tm-base", sPAPRXive, tm_base, SPAPR_XIVE_TM_BASE=
),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void spapr_xive_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    XiveRouterClass *xrc =3D XIVE_ROUTER_CLASS(klass);
> +
> +    dc->desc    =3D "sPAPR XIVE Interrupt Controller";
> +    dc->props   =3D spapr_xive_properties;
> +    dc->realize =3D spapr_xive_realize;
> +    dc->reset   =3D spapr_xive_reset;
> +    dc->vmsd    =3D &vmstate_spapr_xive;
> +
> +    xrc->get_eas =3D spapr_xive_get_eas;
> +    xrc->set_eas =3D spapr_xive_set_eas;
> +    xrc->get_end =3D spapr_xive_get_end;
> +    xrc->set_end =3D spapr_xive_set_end;
> +}
> +
> +static const TypeInfo spapr_xive_info =3D {
> +    .name =3D TYPE_SPAPR_XIVE,
> +    .parent =3D TYPE_XIVE_ROUTER,
> +    .instance_init =3D spapr_xive_instance_init,
> +    .instance_size =3D sizeof(sPAPRXive),
> +    .class_init =3D spapr_xive_class_init,
> +};
> +
> +static void spapr_xive_register_types(void)
> +{
> +    type_register_static(&spapr_xive_info);
> +}
> +
> +type_init(spapr_xive_register_types)
> +
> +bool spapr_xive_irq_enable(sPAPRXive *xive, uint32_t lisn, bool lsi)
> +{
> +    XiveSource *xsrc =3D &xive->source;
> +
> +    if (lisn >=3D xive->nr_irqs) {
> +        return false;
> +    }
> +
> +    xive->eat[lisn].w |=3D EAS_VALID;
> +    xive_source_irq_set(xsrc, lisn, lsi);
> +    return true;
> +}
> +
> +bool spapr_xive_irq_disable(sPAPRXive *xive, uint32_t lisn)
> +{
> +    XiveSource *xsrc =3D &xive->source;
> +
> +    if (lisn >=3D xive->nr_irqs) {
> +        return false;
> +    }
> +
> +    xive->eat[lisn].w &=3D ~EAS_VALID;
> +    xive_source_irq_set(xsrc, lisn, false);
> +    return true;
> +}
> +
> +qemu_irq spapr_xive_qirq(sPAPRXive *xive, uint32_t lisn)
> +{
> +    XiveSource *xsrc =3D &xive->source;
> +
> +    if (lisn >=3D xive->nr_irqs) {
> +        return NULL;
> +    }
> +
> +    if (!(xive->eat[lisn].w & EAS_VALID)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %x\n", lisn);

I don't think this is a guest error - gettint the qirq by number
should generally be something qemu code does.

> +        return NULL;
> +    }
> +
> +    return xive_source_qirq(xsrc, lisn);
> +}
> diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
> index 72a46ed91c31..301a8e972d91 100644
> --- a/hw/intc/Makefile.objs
> +++ b/hw/intc/Makefile.objs
> @@ -38,6 +38,7 @@ obj-$(CONFIG_XICS) +=3D xics.o
>  obj-$(CONFIG_XICS_SPAPR) +=3D xics_spapr.o
>  obj-$(CONFIG_XICS_KVM) +=3D xics_kvm.o
>  obj-$(CONFIG_XIVE) +=3D xive.o
> +obj-$(CONFIG_XIVE_SPAPR) +=3D spapr_xive.o
>  obj-$(CONFIG_POWERNV) +=3D xics_pnv.o
>  obj-$(CONFIG_ALLWINNER_A10_PIC) +=3D allwinner-a10-pic.o
>  obj-$(CONFIG_S390_FLIC) +=3D s390_flic.o

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/7+LvQqw8N5lf/3J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv95uQACgkQbDjKyiDZ
s5L/CxAA0Udm2DxI4KfQHNs+9G5FYiuHZTeyAziVrIsF/LrZvTFjslm+CjzwcQ/Y
mc9K2rUOzeUqW9wwJal4+QkjgASz2VObqEwaXT07osJmAne/IugUU62PmPRB6v5N
0f7HyynztA/lWjtsNhhXTfUJ/eFTTJiJnhr+UmcjpRf1KIpYHfWgtRia//I64oRt
Sdu2hkIP6aBMBw6SjueAsdKS55Py4luhVQqMICRDh9YnhHBhKRchuudBdVCkW3WR
bEvL4wLYnvQqudOl9CNal3ekJbGaTDYVnUFofLHOVTysx57pLT/9nqFi5Lv/U3re
082Z6CHOryIzzJpVcB1KJeCcxSqWxqgVPCA40Ul2ejJ9uuLuKOXw9QqW5TJBne7t
PEYDoj6fkBOFPrwR7/nDkhOSbHIrURHnuDrvpEgrnLNPQQkWGiotVLQfqpIKUWH9
xM8cmat66BVanucbLG5So0lbpeouLBARsScnAJWjFCEKysx/UkK5hiRalFe2+ASB
SruK/cNAAAi1d+j2nVboUpaHlvC5BvlFsU/fL9G+7dWyXGtA//jouBpxKhCLwb07
lt6rEv1NOGsTJquZnyyHorb1YXYAVpFzbDnCj274LkC8Oqsu1q6qVqIN9vwHPqON
cKnyANJHedGeykUuW1TuHWUhnF6IpRAIftiPNHvxntALKMxZyC4=
=+sko
-----END PGP SIGNATURE-----

--/7+LvQqw8N5lf/3J--
