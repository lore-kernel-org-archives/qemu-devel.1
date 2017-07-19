Received: from eggs.gnu.org ([2001:4830:134:3::10]:53681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dXfcs-0000pf-AJ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 23:26:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dXfcq-0007Jc-Ej
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 23:26:14 -0400
Date: Wed, 19 Jul 2017 13:23:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170719032311.GA26354@umbus>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-5-git-send-email-clg@kaod.org>
	<20170719030849.GQ3140@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <20170719030849.GQ3140@umbus.fritz.box>
Subject: Re: [Qemu-devel] [RFC PATCH 04/26] ppc/xive: introduce a skeleton
 for the XIVE interrupt controller model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2017 at 01:08:49PM +1000, David Gibson wrote:
> On Wed, Jul 05, 2017 at 07:13:17PM +0200, C=E9dric Le Goater wrote:
> > Let's provide an empty shell for the XIVE controller model with a
> > couple of attributes for the IRQ number allocator. The latter is
> > largely inspired by OPAL which allocates IPI IRQ numbers from the
> > bottom of the IRQ number space and allocates the HW IRQ numbers from
> > the top.
> >=20
> > The number of IPIs is simply deduced from the max number of CPUs the
> > guest supports and we provision a arbitrary number of HW irqs.
> >=20
> > The XIVE object is kept private because it will hold internal tables
> > which do not need to be exposed to sPAPR.
> >=20
> > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > ---
> >  default-configs/ppc64-softmmu.mak |  1 +
> >  hw/intc/Makefile.objs             |  1 +
> >  hw/intc/xive-internal.h           | 28 ++++++++++++
> >  hw/intc/xive.c                    | 94 +++++++++++++++++++++++++++++++=
++++++++
> >  include/hw/ppc/xive.h             | 27 +++++++++++
> >  5 files changed, 151 insertions(+)
> >  create mode 100644 hw/intc/xive-internal.h
> >  create mode 100644 hw/intc/xive.c
> >  create mode 100644 include/hw/ppc/xive.h
> >=20
> > diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-=
softmmu.mak
> > index 46c95993217d..1179c07e6e9f 100644
> > --- a/default-configs/ppc64-softmmu.mak
> > +++ b/default-configs/ppc64-softmmu.mak
> > @@ -56,6 +56,7 @@ CONFIG_SM501=3Dy
> >  CONFIG_XICS=3D$(CONFIG_PSERIES)
> >  CONFIG_XICS_SPAPR=3D$(CONFIG_PSERIES)
> >  CONFIG_XICS_KVM=3D$(and $(CONFIG_PSERIES),$(CONFIG_KVM))
> > +CONFIG_XIVE=3D$(CONFIG_PSERIES)
> >  # For PReP
> >  CONFIG_SERIAL_ISA=3Dy
> >  CONFIG_MC146818RTC=3Dy
> > diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
> > index 78426a7dafcd..28b83456bfcc 100644
> > --- a/hw/intc/Makefile.objs
> > +++ b/hw/intc/Makefile.objs
> > @@ -35,6 +35,7 @@ obj-$(CONFIG_SH4) +=3D sh_intc.o
> >  obj-$(CONFIG_XICS) +=3D xics.o
> >  obj-$(CONFIG_XICS_SPAPR) +=3D xics_spapr.o
> >  obj-$(CONFIG_XICS_KVM) +=3D xics_kvm.o
> > +obj-$(CONFIG_XIVE) +=3D xive.o
> >  obj-$(CONFIG_POWERNV) +=3D xics_pnv.o
> >  obj-$(CONFIG_ALLWINNER_A10_PIC) +=3D allwinner-a10-pic.o
> >  obj-$(CONFIG_S390_FLIC) +=3D s390_flic.o
> > diff --git a/hw/intc/xive-internal.h b/hw/intc/xive-internal.h
> > new file mode 100644
> > index 000000000000..155c2dcd6066
> > --- /dev/null
> > +++ b/hw/intc/xive-internal.h
> > @@ -0,0 +1,28 @@
> > +/*
> > + * Copyright 2016,2017 IBM Corporation.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version
> > + * 2 of the License, or (at your option) any later version.
> > + */
> > +#ifndef _INTC_XIVE_INTERNAL_H
> > +#define _INTC_XIVE_INTERNAL_H
> > +
> > +#include <hw/sysbus.h>
> > +
> > +struct XIVE {
> > +    SysBusDevice parent;
>=20
> XIVE probably shouldn't be a SysBusDevice.  According to agraf, that
> should only be used for things which have an MMIO presence on a bus
> structure that's not worth the bother of more specifically modelling.
>=20
> I don't think that's the case for XIVE, so it should just have
> TYPE_DEVICE as its parent.  There are several pseries things which
> already get this wrong (mostly because I made them before fully
> understanding the role of the SysBus), but we should avoid adding
> others.
>=20
> > +    /* Properties */
> > +    uint32_t     nr_targets;
> > +
> > +    /* IRQ number allocator */
> > +    uint32_t     int_count;     /* Number of interrupts: nr_targets + =
HW IRQs */
> > +    uint32_t     int_base;      /* Min index */
> > +    uint32_t     int_max;       /* Max index */
> > +    uint32_t     int_hw_bot;    /* Bottom index of HW IRQ allocator */
> > +    uint32_t     int_ipi_top;   /* Highest IPI index handed out so far=
 + 1 */
> > +};
> > +
> > +#endif /* _INTC_XIVE_INTERNAL_H */
> > diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> > new file mode 100644
> > index 000000000000..5b4ea915d87c
> > --- /dev/null
> > +++ b/hw/intc/xive.c
> > @@ -0,0 +1,94 @@
> > +/*
> > + * QEMU PowerPC XIVE model
> > + *
> > + * Copyright (c) 2017, IBM Corporation.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License, version 2, as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> > + */
> > +#include "qemu/osdep.h"
> > +#include "qemu/log.h"
> > +#include "qapi/error.h"
> > +#include "target/ppc/cpu.h"
> > +#include "sysemu/cpus.h"
> > +#include "sysemu/dma.h"
> > +#include "monitor/monitor.h"
> > +#include "hw/ppc/xive.h"
> > +
> > +#include "xive-internal.h"
> > +
> > +/*
> > + * Main XIVE object
>=20
> As with XICs, does it really make sense for there to be a "main" XIVE
> object, or should be an interface attached to the machine?
>=20
> > + */
> > +
> > +/* Let's provision some HW IRQ numbers. We could use a XIVE property
> > + * also but it does not seem necessary for the moment.
> > + */
> > +#define MAX_HW_IRQS_ENTRIES (8 * 1024)
> > +
> > +static void xive_init(Object *obj)
> > +{
> > +    ;
> > +}
> > +
> > +static void xive_realize(DeviceState *dev, Error **errp)
> > +{
> > +    XIVE *x =3D XIVE(dev);
> > +
> > +    if (!x->nr_targets) {
> > +        error_setg(errp, "Number of interrupt targets needs to be grea=
ter 0");
> > +        return;
> > +    }
> > +
> > +    /* Initialize IRQ number allocator. Let's use a base number if we
> > +     * need to introduce a notion of blocks one day.
> > +     */
> > +    x->int_base =3D 0;
> > +    x->int_count =3D x->nr_targets + MAX_HW_IRQS_ENTRIES;
> > +    x->int_max =3D x->int_base + x->int_count;

Also storing a value which is easily derivable from values already in
the structure is a bit silly.  I think you should drop either
int_count or int_max.

> > +    x->int_hw_bot =3D x->int_max;
> > +    x->int_ipi_top =3D x->int_base;
> > +
> > +    /* Reserve some numbers as OPAL does ? */
> > +    if (x->int_ipi_top < 0x10) {
> > +        x->int_ipi_top =3D 0x10;
> > +    }
>=20
> I'm somewhat uncomfortable with an irq allocater here in the intc
> code.  As a rule, irq allocation is the responsibility of the machine,
> not any sub-component.  Furthermore, it should allocate in a way which
> is repeatable, since they need to stay stable across reboots and
> migrations.
>=20
> And, yes, we have an allocator of sorts in XICS - it has caused a
> number of problems in the past.
>=20
> > +}
> > +
> > +static Property xive_properties[] =3D {
> > +    DEFINE_PROP_UINT32("nr-targets", XIVE, nr_targets, 0),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void xive_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->realize =3D xive_realize;
> > +    dc->props =3D xive_properties;
> > +    dc->desc =3D "XIVE";
> > +}
> > +
> > +static const TypeInfo xive_info =3D {
> > +    .name =3D TYPE_XIVE,
> > +    .parent =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_init =3D xive_init,
> > +    .instance_size =3D sizeof(XIVE),
> > +    .class_init =3D xive_class_init,
> > +};
> > +
> > +static void xive_register_types(void)
> > +{
> > +    type_register_static(&xive_info);
> > +}
> > +
> > +type_init(xive_register_types)
> > diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> > new file mode 100644
> > index 000000000000..863f5a9c6b5f
> > --- /dev/null
> > +++ b/include/hw/ppc/xive.h
> > @@ -0,0 +1,27 @@
> > +/*
> > + * QEMU PowerPC XIVE model
> > + *
> > + * Copyright (c) 2017, IBM Corporation.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License, version 2, as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#ifndef PPC_XIVE_H
> > +#define PPC_XIVE_H
> > +
> > +typedef struct XIVE XIVE;
> > +
> > +#define TYPE_XIVE "xive"
> > +#define XIVE(obj) OBJECT_CHECK(XIVE, (obj), TYPE_XIVE)
> > +
> > +#endif /* PPC_XIVE_H */
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAllu0JoACgkQbDjKyiDZ
s5K8bQ//as9kiBPLDuXMemTSY1nMndSkBda01AiXtJA8UUZ34HvCtDtnpkwmNxXV
Eep6uY3JRfScCmsC3cPp5wNwQxp3vJ0RX9A1MV/cKOfHw+gbVTCjudu/trDnzbyQ
nn/TRG2joNQl4i386aGOBtPw8iaPLmwfNr+u5TTaYz6PU0i+Pot0HwCmzgh9ENKK
WA37Qj4J6JMEPXGbAwGxsB94InSergM4tcGSxC4yH7KiHxn462blJqK19DnQORZl
iFBv6SZzETHn4x6sDqrW6nJFketDZtqtgiwd/PjnfdCSD2AIb5jk0XQQYyjagw4T
QRZW/syo8rLj0IuXvkU9cUZjmgdKP42m3XMplBMenky6EaJDqdwvAE2GLulhNNqS
89junQcJ+Vj/2WG3wDJTZLRaJEBYZoJZpFr88WZUVEvDJ6a4ceIccRN8ZrN2pw0C
9V3D9aNlpuEAZh2+EgCGNFHYBpAjR2z2Hqlo1cW7w8xB2LLhhfrb7mXcZblG8boc
wSdn1Y+hDDOAtN6toyiKGGIqoqsdVDVyjy/Klon8iCCCN5dPuARJjslI8edxynyJ
HafoNdvAJT7Ee6EkOJQOZogyUtX3dUo1hjWAxppVmtH0h2uYQWJMclrQ/s5PVvaH
FS7OVfaIXUiwG4xGxzYmGxbJnWfW2VvAw+L74ujkAciS4+8p6XE=
=ofi3
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
