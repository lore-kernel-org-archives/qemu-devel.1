Received: from eggs.gnu.org ([2001:4830:134:3::10]:50153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBZKP-00021L-HU
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 01:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBZKM-00031d-Ca
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 01:20:21 -0400
Date: Thu, 26 Apr 2018 14:20:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180426042002.GF8800@umbus.fritz.box>
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-5-clg@kaod.org>
	<20180424065131.GQ19804@umbus.fritz.box>
	<5def5bbb-9842-0121-e889-014ba88fd4c5@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lIrNkN/7tmsD/ALM"
Content-Disposition: inline
In-Reply-To: <5def5bbb-9842-0121-e889-014ba88fd4c5@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v3 04/35] spapr/xive: introduce a XIVE
 interrupt controller for sPAPR
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


--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 11:46:04AM +0200, C=E9dric Le Goater wrote:
> On 04/24/2018 08:51 AM, David Gibson wrote:
> > On Thu, Apr 19, 2018 at 02:43:00PM +0200, C=E9dric Le Goater wrote:
> >> sPAPRXive is a model for the XIVE interrupt controller device of the
> >> sPAPR machine. It holds the routing XIVE table, the Interrupt
> >> Virtualization Entry (IVE) table which associates interrupt source
> >> numbers with targets.
> >>
> >> Also extend the XiveFabric with an accessor to the IVT. This will be
> >> needed by the routing algorithm.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>
> >>  May be should introduce a XiveRouter model to hold the IVT. To be
> >>  discussed.
> >=20
> > Yeah, maybe.  Am I correct in thinking that on pnv there could be more
> > than one XiveRouter?
>=20
> There is only one, the main IC.=20

Ok, that's what I thought originally.  In that case some of the stuff
in the patches really doesn't make sense to me.

> > If we did have a XiveRouter, I'm not sure we'd need the XiveFabric
> > interface, possibly its methods could just be class methods of
> > XiveRouter.
>=20
> Yes. We could introduce a XiveRouter to share the ivt table between=20
> the sPAPRXive and the PnvXIVE models, the interrupt controllers of
> the machines. Methods would provide way to get the ivt/eq/nvt
> objects required for routing. I need to add a set_eq() to push the
> EQ data.

Hrm.  Well, to add some more clarity, let's say the XiveRouter is the
object which owns the IVT.  It may or may not do other stuff as well.

Now IIUC, on pnv the IVT lives in main system memory.  Under PAPR is
the IVT in guest memory, or is it outside (updated by
hypercalls/rtas)?
=20
> The XiveRouter would also be a XiveFabric (or some other name) to=20
> let the internal sources of the interrupt controller forward events.

The further we go here, the less sure I am that XiveFabric even makes
sense as a concept.

>=20
> >>
> >>  Changes since v2 :
> >>
> >>  - introduced the XiveFabric interface
> >>
> >>  default-configs/ppc64-softmmu.mak |   1 +
> >>  hw/intc/Makefile.objs             |   1 +
> >>  hw/intc/spapr_xive.c              | 159 +++++++++++++++++++++++++++++=
+++++++++
> >>  hw/intc/xive.c                    |   7 ++
> >>  include/hw/ppc/spapr_xive.h       |  31 ++++++++
> >>  include/hw/ppc/xive.h             |   5 ++
> >>  include/hw/ppc/xive_regs.h        |  33 ++++++++
> >>  7 files changed, 237 insertions(+)
> >>  create mode 100644 hw/intc/spapr_xive.c
> >>  create mode 100644 include/hw/ppc/spapr_xive.h
> >>  create mode 100644 include/hw/ppc/xive_regs.h
> >>
> >> diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64=
-softmmu.mak
> >> index c6d13e757977..f8d34722931d 100644
> >> --- a/default-configs/ppc64-softmmu.mak
> >> +++ b/default-configs/ppc64-softmmu.mak
> >> @@ -17,4 +17,5 @@ CONFIG_XICS=3D$(CONFIG_PSERIES)
> >>  CONFIG_XICS_SPAPR=3D$(CONFIG_PSERIES)
> >>  CONFIG_XICS_KVM=3D$(call land,$(CONFIG_PSERIES),$(CONFIG_KVM))
> >>  CONFIG_XIVE=3D$(CONFIG_PSERIES)
> >> +CONFIG_XIVE_SPAPR=3D$(CONFIG_PSERIES)
> >>  CONFIG_MEM_HOTPLUG=3Dy
> >> diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
> >> index 72a46ed91c31..301a8e972d91 100644
> >> --- a/hw/intc/Makefile.objs
> >> +++ b/hw/intc/Makefile.objs
> >> @@ -38,6 +38,7 @@ obj-$(CONFIG_XICS) +=3D xics.o
> >>  obj-$(CONFIG_XICS_SPAPR) +=3D xics_spapr.o
> >>  obj-$(CONFIG_XICS_KVM) +=3D xics_kvm.o
> >>  obj-$(CONFIG_XIVE) +=3D xive.o
> >> +obj-$(CONFIG_XIVE_SPAPR) +=3D spapr_xive.o
> >>  obj-$(CONFIG_POWERNV) +=3D xics_pnv.o
> >>  obj-$(CONFIG_ALLWINNER_A10_PIC) +=3D allwinner-a10-pic.o
> >>  obj-$(CONFIG_S390_FLIC) +=3D s390_flic.o
> >> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> >> new file mode 100644
> >> index 000000000000..020444e2665a
> >> --- /dev/null
> >> +++ b/hw/intc/spapr_xive.c
> >> @@ -0,0 +1,159 @@
> >> +/*
> >> + * QEMU PowerPC sPAPR XIVE interrupt controller model
> >> + *
> >> + * Copyright (c) 2017-2018, IBM Corporation.
> >> + *
> >> + * This code is licensed under the GPL version 2 or later. See the
> >> + * COPYING file in the top-level directory.
> >> + */
> >> +
> >> +#include "qemu/osdep.h"
> >> +#include "qemu/log.h"
> >> +#include "qapi/error.h"
> >> +#include "target/ppc/cpu.h"
> >> +#include "sysemu/cpus.h"
> >> +#include "monitor/monitor.h"
> >> +#include "hw/ppc/spapr_xive.h"
> >> +#include "hw/ppc/xive_regs.h"
> >> +
> >> +void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon)
> >> +{
> >> +    int i;
> >> +
> >> +    monitor_printf(mon, "IVE Table\n");
> >> +    for (i =3D 0; i < xive->nr_irqs; i++) {
> >> +        XiveIVE *ive =3D &xive->ivt[i];
> >> +
> >> +        if (!(ive->w & IVE_VALID)) {
> >> +            continue;
> >> +        }
> >> +
> >> +        monitor_printf(mon, "  %4x %s %08x %08x\n", i,
> >> +                       ive->w & IVE_MASKED ? "M" : " ",
> >> +                       (int) GETFIELD(IVE_EQ_INDEX, ive->w),
> >> +                       (int) GETFIELD(IVE_EQ_DATA, ive->w));
> >> +    }
> >> +}
> >> +
> >> +static void spapr_xive_reset(DeviceState *dev)
> >> +{
> >> +    sPAPRXive *xive =3D SPAPR_XIVE(dev);
> >> +    int i;
> >> +
> >> +    /* Mask all valid IVEs in the IRQ number space. */
> >> +    for (i =3D 0; i < xive->nr_irqs; i++) {
> >> +        XiveIVE *ive =3D &xive->ivt[i];
> >> +        if (ive->w & IVE_VALID) {
> >> +            ive->w |=3D IVE_MASKED;
> >> +        }
> >> +    }
> >> +}
> >> +
> >> +static void spapr_xive_init(Object *obj)
> >=20
> > I'm trying to standardize on init_instance methods being called
> > *_instance_init().  It helps to make it obvious that this is ineed an
> > instance_init() method, rather than one of the various other init
> > calls that exist in various places.
>=20
> ok. this is good practice. I will fix.
>=20
> Thanks,
>=20
> C.
>=20
> >=20
> >> +{
> >> +
> >> +}
> >> +
> >> +static void spapr_xive_realize(DeviceState *dev, Error **errp)
> >> +{
> >> +    sPAPRXive *xive =3D SPAPR_XIVE(dev);
> >> +
> >> +    if (!xive->nr_irqs) {
> >> +        error_setg(errp, "Number of interrupt needs to be greater 0");
> >> +        return;
> >> +    }
> >> +
> >> +    /* Allocate the Interrupt Virtualization Table */
> >> +    xive->ivt =3D g_new0(XiveIVE, xive->nr_irqs);
> >> +}
> >> +
> >> +static XiveIVE *spapr_xive_get_ive(XiveFabric *xf, uint32_t lisn)
> >> +{
> >> +    sPAPRXive *xive =3D SPAPR_XIVE(xf);
> >> +
> >> +    return lisn < xive->nr_irqs ? &xive->ivt[lisn] : NULL;
> >> +}
> >> +
> >> +static const VMStateDescription vmstate_spapr_xive_ive =3D {
> >> +    .name =3D TYPE_SPAPR_XIVE "/ive",
> >> +    .version_id =3D 1,
> >> +    .minimum_version_id =3D 1,
> >> +    .fields =3D (VMStateField []) {
> >> +        VMSTATE_UINT64(w, XiveIVE),
> >> +        VMSTATE_END_OF_LIST()
> >> +    },
> >> +};
> >> +
> >> +static const VMStateDescription vmstate_spapr_xive =3D {
> >> +    .name =3D TYPE_SPAPR_XIVE,
> >> +    .version_id =3D 1,
> >> +    .minimum_version_id =3D 1,
> >> +    .fields =3D (VMStateField[]) {
> >> +        VMSTATE_UINT32_EQUAL(nr_irqs, sPAPRXive, NULL),
> >> +        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(ivt, sPAPRXive, nr_irqs,
> >> +                                     vmstate_spapr_xive_ive, XiveIVE),
> >> +        VMSTATE_END_OF_LIST()
> >> +    },
> >> +};
> >> +
> >> +static Property spapr_xive_properties[] =3D {
> >> +    DEFINE_PROP_UINT32("nr-irqs", sPAPRXive, nr_irqs, 0),
> >> +    DEFINE_PROP_END_OF_LIST(),
> >> +};
> >> +
> >> +static void spapr_xive_class_init(ObjectClass *klass, void *data)
> >> +{
> >> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> >> +    XiveFabricClass *xfc =3D XIVE_FABRIC_CLASS(klass);
> >> +
> >> +    dc->realize =3D spapr_xive_realize;
> >> +    dc->reset =3D spapr_xive_reset;
> >> +    dc->props =3D spapr_xive_properties;
> >> +    dc->desc =3D "sPAPR XIVE interrupt controller";
> >> +    dc->vmsd =3D &vmstate_spapr_xive;
> >> +
> >> +    xfc->get_ive =3D spapr_xive_get_ive;
> >> +}
> >> +
> >> +static const TypeInfo spapr_xive_info =3D {
> >> +    .name =3D TYPE_SPAPR_XIVE,
> >> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> >> +    .instance_init =3D spapr_xive_init,
> >> +    .instance_size =3D sizeof(sPAPRXive),
> >> +    .class_init =3D spapr_xive_class_init,
> >> +    .interfaces =3D (InterfaceInfo[]) {
> >> +            { TYPE_XIVE_FABRIC },
> >> +            { },
> >> +    },
> >> +};
> >> +
> >> +static void spapr_xive_register_types(void)
> >> +{
> >> +    type_register_static(&spapr_xive_info);
> >> +}
> >> +
> >> +type_init(spapr_xive_register_types)
> >> +
> >> +bool spapr_xive_irq_enable(sPAPRXive *xive, uint32_t lisn, bool lsi)
> >> +{
> >> +    XiveIVE *ive =3D spapr_xive_get_ive(XIVE_FABRIC(xive), lisn);
> >> +
> >> +    if (!ive) {
> >> +        return false;
> >> +    }
> >> +
> >> +    ive->w |=3D IVE_VALID;
> >> +    return true;
> >> +}
> >> +
> >> +bool spapr_xive_irq_disable(sPAPRXive *xive, uint32_t lisn)
> >> +{
> >> +    XiveIVE *ive =3D spapr_xive_get_ive(XIVE_FABRIC(xive), lisn);
> >> +
> >> +    if (!ive) {
> >> +        return false;
> >> +    }
> >> +
> >> +    ive->w &=3D ~IVE_VALID;
> >> +    return true;
> >> +}
> >> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> >> index b4c3d06c1219..dccad0318834 100644
> >> --- a/hw/intc/xive.c
> >> +++ b/hw/intc/xive.c
> >> @@ -20,6 +20,13 @@
> >>   * XIVE Fabric
> >>   */
> >> =20
> >> +XiveIVE *xive_fabric_get_ive(XiveFabric *xf, uint32_t lisn)
> >> +{
> >> +    XiveFabricClass *xfc =3D XIVE_FABRIC_GET_CLASS(xf);
> >> +
> >> +    return xfc->get_ive(xf, lisn);
> >> +}
> >> +
> >>  static void xive_fabric_route(XiveFabric *xf, int lisn)
> >>  {
> >> =20
> >> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> >> new file mode 100644
> >> index 000000000000..1d966b5d3a96
> >> --- /dev/null
> >> +++ b/include/hw/ppc/spapr_xive.h
> >> @@ -0,0 +1,31 @@
> >> +/*
> >> + * QEMU PowerPC sPAPR XIVE interrupt controller model
> >> + *
> >> + * Copyright (c) 2017-2018, IBM Corporation.
> >> + *
> >> + * This code is licensed under the GPL version 2 or later. See the
> >> + * COPYING file in the top-level directory.
> >> + */
> >> +
> >> +#ifndef PPC_SPAPR_XIVE_H
> >> +#define PPC_SPAPR_XIVE_H
> >> +
> >> +#include "hw/sysbus.h"
> >> +#include "hw/ppc/xive.h"
> >> +
> >> +#define TYPE_SPAPR_XIVE "spapr-xive"
> >> +#define SPAPR_XIVE(obj) OBJECT_CHECK(sPAPRXive, (obj), TYPE_SPAPR_XIV=
E)
> >> +
> >> +typedef struct sPAPRXive {
> >> +    SysBusDevice parent;
> >> +
> >> +    /* Routing table */
> >> +    XiveIVE      *ivt;
> >> +    uint32_t     nr_irqs;
> >> +} sPAPRXive;
> >> +
> >> +bool spapr_xive_irq_enable(sPAPRXive *xive, uint32_t lisn, bool lsi);
> >> +bool spapr_xive_irq_disable(sPAPRXive *xive, uint32_t lisn);
> >> +void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
> >> +
> >> +#endif /* PPC_SPAPR_XIVE_H */
> >> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> >> index 4fcae2c763e6..5b145816acdc 100644
> >> --- a/include/hw/ppc/xive.h
> >> +++ b/include/hw/ppc/xive.h
> >> @@ -11,6 +11,7 @@
> >>  #define PPC_XIVE_H
> >> =20
> >>  #include "hw/sysbus.h"
> >> +#include "hw/ppc/xive_regs.h"
> >> =20
> >>  typedef struct XiveFabric XiveFabric;
> >> =20
> >> @@ -166,6 +167,10 @@ typedef struct XiveFabric {
> >>  typedef struct XiveFabricClass {
> >>      InterfaceClass parent;
> >>      void (*notify)(XiveFabric *xf, uint32_t lisn);
> >> +
> >> +    XiveIVE *(*get_ive)(XiveFabric *xf, uint32_t lisn);
> >>  } XiveFabricClass;
> >> =20
> >> +XiveIVE *xive_fabric_get_ive(XiveFabric *xf, uint32_t lisn);
> >> +
> >>  #endif /* PPC_XIVE_H */
> >> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
> >> new file mode 100644
> >> index 000000000000..5903f29eb789
> >> --- /dev/null
> >> +++ b/include/hw/ppc/xive_regs.h
> >> @@ -0,0 +1,33 @@
> >> +/*
> >> + * QEMU PowerPC XIVE interrupt controller model
> >> + *
> >> + * Copyright (c) 2016-2018, IBM Corporation.
> >> + *
> >> + * This code is licensed under the GPL version 2 or later. See the
> >> + * COPYING file in the top-level directory.
> >> + */
> >> +
> >> +#ifndef _PPC_XIVE_REGS_H
> >> +#define _PPC_XIVE_REGS_H
> >> +
> >> +/* IVE/EAS
> >> + *
> >> + * One per interrupt source. Targets that interrupt to a given EQ
> >> + * and provides the corresponding logical interrupt number (EQ data)
> >> + *
> >> + * We also map this structure to the escalation descriptor inside
> >> + * an EQ, though in that case the valid and masked bits are not used.
> >> + */
> >> +typedef struct XiveIVE {
> >> +        /* Use a single 64-bit definition to make it easier to
> >> +         * perform atomic updates
> >> +         */
> >> +        uint64_t        w;
> >> +#define IVE_VALID       PPC_BIT(0)
> >> +#define IVE_EQ_BLOCK    PPC_BITMASK(4, 7)        /* Destination EQ bl=
ock# */
> >> +#define IVE_EQ_INDEX    PPC_BITMASK(8, 31)       /* Destination EQ in=
dex */
> >> +#define IVE_MASKED      PPC_BIT(32)              /* Masked */
> >> +#define IVE_EQ_DATA     PPC_BITMASK(33, 63)      /* Data written to t=
he EQ */
> >> +} XiveIVE;
> >> +
> >> +#endif /* _INTC_XIVE_INTERNAL_H */
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lIrNkN/7tmsD/ALM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrhU3AACgkQbDjKyiDZ
s5L51RAAwoagbte1LUQz2CZH5L0Ds8l0WbSuBLF/cQX7y+tLypj3uHV0G/nPYWDE
dUbL1SzupX/4m3koY2aZPKqXo6qWjzxFErgp6OFhnRM7mSVp9oMd5TPSblkrgpFN
sMjPG24sQUpxlRE5RabQG68wFL/k0axC6qh1JfEOdAa6UxrazAdwm3Ve1a5fTbKk
ip77PHCLTkniKBiKX5lrMb+ZqM3txsrIElQTBQ3/LMfcsgh6joh7Q5+RzwVtXtFy
NS4wspfj1KZg08Vc7UDz7GmucSRd9PvahzEuinD0HEQ2Y8ritwdZzpMI+lJpUhhl
1dnNxBE3upFhpj6H0tKWrYPjv6yPq4S1TtlptLMLFDr0OSna8QvwCFnTXwrgWNNb
PPDlveuSHwGVTg3DcxS15+s4gZLn5ZNwflq5pjZiDd+zKt5H2V/Q0GMLcB6Sv+JU
GEv81t4vvk+p7sdfa5J+s1ssghm9RK8w1ywUbebP1lsvLG1VnqIeB0G3hvaeeM3S
vkLVcJuLcD3aylWRk3KUZHFAdl42LbnaRytsfunnoTHnAwyoI2eyXQypnswXQLRT
vxzBghWaae2VmeZhzpQYmeEyxWsosbDFBywaU+6DoavoZM/CQ/NidnZ9KJGAfvJN
idFANsRqwhg/WvR0T3U2yduqXW/mzdj0Faz4DFJVf9hyQlkKubc=
=3MaO
-----END PGP SIGNATURE-----

--lIrNkN/7tmsD/ALM--
