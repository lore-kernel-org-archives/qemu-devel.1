Received: from eggs.gnu.org ([2001:4830:134:3::10]:55616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJuYa-0001RJ-Bi
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 00:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJuYW-0007ZP-CO
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 00:05:12 -0500
Date: Wed, 29 Nov 2017 15:47:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171129044710.GG3023@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-9-clg@kaod.org>
	<20171128054051.GN11775@umbus.fritz.box>
	<81964635-468b-1800-eb64-5b0016678bc6@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hcut4fGOf7Kh6EdG"
Content-Disposition: inline
In-Reply-To: <81964635-468b-1800-eb64-5b0016678bc6@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 08/25] spapr: introduce a skeleton for the
 XIVE interrupt controller
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


--hcut4fGOf7Kh6EdG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2017 at 10:44:03AM +0000, C=E9dric Le Goater wrote:
> On 11/28/2017 05:40 AM, David Gibson wrote:
> > On Thu, Nov 23, 2017 at 02:29:38PM +0100, C=E9dric Le Goater wrote:
> >> The XIVE interrupt controller uses a set of tables to redirect excepti=
on
> >> from event sources to CPU threads. The Interrupt Virtualization Entry =
(IVE)
> >> table, also known as Event Assignment Structure (EAS), is one them.
> >>
> >> The XIVE model is designed to make use of the full range of the IRQ
> >> number space and does not use an offset like the XICS mode does.
> >> Hence, the IVE table is directly indexed by the IRQ number.
> >>
> >> The IVE stores Event Queue data associated with a source. The lookups
> >> are performed when the source is configured or when an event is
> >> triggered.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  default-configs/ppc64-softmmu.mak |   1 +
> >>  hw/intc/Makefile.objs             |   1 +
> >>  hw/intc/spapr_xive.c              | 165 +++++++++++++++++++++++++++++=
+++++++++
> >>  hw/intc/xive-internal.h           |  50 ++++++++++++
> >>  include/hw/ppc/spapr_xive.h       |  44 ++++++++++
> >>  5 files changed, 261 insertions(+)
> >>  create mode 100644 hw/intc/spapr_xive.c
> >>  create mode 100644 hw/intc/xive-internal.h
> >>  create mode 100644 include/hw/ppc/spapr_xive.h
> >>
> >> diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64=
-softmmu.mak
> >> index d1b3a6dd50f8..4a7f6a0696de 100644
> >> --- a/default-configs/ppc64-softmmu.mak
> >> +++ b/default-configs/ppc64-softmmu.mak
> >> @@ -56,6 +56,7 @@ CONFIG_SM501=3Dy
> >>  CONFIG_XICS=3D$(CONFIG_PSERIES)
> >>  CONFIG_XICS_SPAPR=3D$(CONFIG_PSERIES)
> >>  CONFIG_XICS_KVM=3D$(call land,$(CONFIG_PSERIES),$(CONFIG_KVM))
> >> +CONFIG_XIVE_SPAPR=3D$(CONFIG_PSERIES)
> >>  # For PReP
> >>  CONFIG_SERIAL_ISA=3Dy
> >>  CONFIG_MC146818RTC=3Dy
> >> diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
> >> index ae358569a155..49e13e7aeeee 100644
> >> --- a/hw/intc/Makefile.objs
> >> +++ b/hw/intc/Makefile.objs
> >> @@ -35,6 +35,7 @@ obj-$(CONFIG_SH4) +=3D sh_intc.o
> >>  obj-$(CONFIG_XICS) +=3D xics.o
> >>  obj-$(CONFIG_XICS_SPAPR) +=3D xics_spapr.o
> >>  obj-$(CONFIG_XICS_KVM) +=3D xics_kvm.o
> >> +obj-$(CONFIG_XIVE_SPAPR) +=3D spapr_xive.o
> >>  obj-$(CONFIG_POWERNV) +=3D xics_pnv.o
> >>  obj-$(CONFIG_ALLWINNER_A10_PIC) +=3D allwinner-a10-pic.o
> >>  obj-$(CONFIG_S390_FLIC) +=3D s390_flic.o
> >> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> >> new file mode 100644
> >> index 000000000000..b2fc3007c85f
> >> --- /dev/null
> >> +++ b/hw/intc/spapr_xive.c
> >> @@ -0,0 +1,165 @@
> >> +/*
> >> + * QEMU PowerPC sPAPR XIVE model
> >> + *
> >> + * Copyright (c) 2017, IBM Corporation.
> >> + *
> >> + * This program is free software; you can redistribute it and/or modi=
fy
> >> + * it under the terms of the GNU General Public License, version 2, as
> >> + * published by the Free Software Foundation.
> >> + *
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> + * GNU General Public License for more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public License
> >> + * along with this program; if not, see <http://www.gnu.org/licenses/=
>.
> >> + */
> >> +#include "qemu/osdep.h"
> >> +#include "qemu/log.h"
> >> +#include "qapi/error.h"
> >> +#include "target/ppc/cpu.h"
> >> +#include "sysemu/cpus.h"
> >> +#include "sysemu/dma.h"
> >> +#include "monitor/monitor.h"
> >> +#include "hw/ppc/spapr_xive.h"
> >> +
> >> +#include "xive-internal.h"
> >> +
> >> +/*
> >> + * Main XIVE object
> >> + */
> >> +
> >> +void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon)
> >> +{
> >> +    int i;
> >> +
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
> >> +void spapr_xive_reset(void *dev)
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
> >> +static void spapr_xive_realize(DeviceState *dev, Error **errp)
> >> +{
> >> +    sPAPRXive *xive =3D SPAPR_XIVE(dev);
> >> +
> >> +    if (!xive->nr_irqs) {
> >> +        error_setg(errp, "Number of interrupt needs to be greater 0");
> >> +        return;
> >> +    }
> >> +
> >> +    /* Allocate the IVT (Interrupt Virtualization Table) */
> >> +    xive->ivt =3D g_malloc0(xive->nr_irqs * sizeof(XiveIVE));
> >> +
> >> +    qemu_register_reset(spapr_xive_reset, dev);
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
> >> +static bool vmstate_spapr_xive_needed(void *opaque)
> >> +{
> >> +    /* TODO check machine XIVE support */
> >> +    return true;
> >> +}
> >> +
> >> +static const VMStateDescription vmstate_spapr_xive =3D {
> >> +    .name =3D TYPE_SPAPR_XIVE,
> >> +    .version_id =3D 1,
> >> +    .minimum_version_id =3D 1,
> >> +    .needed =3D vmstate_spapr_xive_needed,
> >> +    .fields =3D (VMStateField[]) {
> >> +        VMSTATE_UINT32_EQUAL(nr_irqs, sPAPRXive, NULL),
> >> +        VMSTATE_STRUCT_VARRAY_UINT32_ALLOC(ivt, sPAPRXive, nr_irqs, 1,
> >> +                                           vmstate_spapr_xive_ive, Xi=
veIVE),
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
> >> +
> >> +    dc->realize =3D spapr_xive_realize;
> >> +    dc->props =3D spapr_xive_properties;
> >> +    dc->desc =3D "sPAPR XIVE interrupt controller";
> >> +    dc->vmsd =3D &vmstate_spapr_xive;
> >> +}
> >> +
> >> +static const TypeInfo spapr_xive_info =3D {
> >> +    .name =3D TYPE_SPAPR_XIVE,
> >> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> >> +    .instance_size =3D sizeof(sPAPRXive),
> >> +    .class_init =3D spapr_xive_class_init,
> >> +};
> >> +
> >> +static void spapr_xive_register_types(void)
> >> +{
> >> +    type_register_static(&spapr_xive_info);
> >> +}
> >> +
> >> +type_init(spapr_xive_register_types)
> >> +
> >> +XiveIVE *spapr_xive_get_ive(sPAPRXive *xive, uint32_t lisn)
> >> +{
> >> +    return lisn < xive->nr_irqs ? &xive->ivt[lisn] : NULL;
> >> +}
> >> +
> >> +bool spapr_xive_irq_set(sPAPRXive *xive, uint32_t lisn)
> >> +{
> >> +    XiveIVE *ive =3D spapr_xive_get_ive(xive, lisn);
> >> +
> >> +    if (!ive) {
> >> +        return false;
> >> +    }
> >> +
> >> +    ive->w |=3D IVE_VALID;
> >> +    return true;
> >> +}
> >=20
> > As I said in another comment, I don't like the name: sets what, exactly?
>=20
> may be spapr_xive_irq_alloc() would be better ? I guess so.=20

Or enable/disable.

> > It's not really clear to me what the VALID bit means.  Why would an
> > irq within the allocated range be invalid?
>=20
> 'enable' might be better a better choice but that is how the specs=20
> refer to this bit.

Right, definitely the VALID name for the bit constant, if that's
what's in the specs.  But it still might be better to use
enable/disable for the functions to change it since that's clearer.

Unless there's something else we might want to do with the irq that
could also be called enable/disable.

> It it used by the HW to let through or stop the notification process=20
> immediately when a trigger is performed on the ESB MMIOs.

Ok, so the concept does exist in hardware.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hcut4fGOf7Kh6EdG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloeO84ACgkQbDjKyiDZ
s5LMjw//eoDhQy0cTBKujMJI/uoJLYM9aa64gX8y9CVpoJ2Bw5aJgMC5nFF8b17L
ecOUDcgKpf4Jr9bU43rK/3lH9O/jlq/gWIXv+3BTCCb3kFwK14oZHVB9RkpTbfMU
vuxwxUtxydlE6NWR3aLoYsl9STjpNd8exlaXzomtqud8vuXkFvDmoKqOM+e/n30c
RxlJ2SZ5HzBsxf0P5gT2ks02p+K/XL9lrUOrXLSe00qRVCSwE3PKgBX2u8Oea70d
bNDSbmQ6kCmiiETtTQumTulTHLlmXmC1ec83ZkcoKS+PncU3YVNpF8/P3O85APTU
+v8fMZBzlD/k3synhjZrjNkr+vcFLr9gV9nXz/vMuIEtHjFpPi5GJkFRUZxErHYq
LqKQixMEavKvHJfiIBBhzc3JwMgqIxB1xxKrDhUSN8xFOjSXSMdVDepWXvHlnxlQ
ptPAnRdMEu9JDlEmaNtA3Zhu0UUNy7fi8ziMEzQm587uKa2q98SO1taYvS6QHirm
1uqEgWFzc1ZRSAgwOvzW6mxn8inhqpIUJMTDOAVa9CFfiZl01LsStzWH/Odukx21
bR9BNjtEuf/4gtvH7VvpJxQB6EDa6G0+0wmMq78krMqyQjAJr+iJpPo1NSsVssmO
TjE7CVLakWrokmeIJE2Xy8dVIPEqaSvLpRLPa6Lpk3gJICVmZmo=
=2bMY
-----END PGP SIGNATURE-----

--hcut4fGOf7Kh6EdG--
