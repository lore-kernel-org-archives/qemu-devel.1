Received: from eggs.gnu.org ([2001:4830:134:3::10]:50691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKH1A-0005PE-5k
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 00:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKH17-0005aj-3p
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 00:04:12 -0500
Date: Thu, 30 Nov 2017 15:22:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171130042210.GX3023@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-9-clg@kaod.org>
	<20171129124904.13a30582@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Sh7h4lnU5nPTsIof"
Content-Disposition: inline
In-Reply-To: <20171129124904.13a30582@bahia.lan>
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
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--Sh7h4lnU5nPTsIof
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 12:49:04PM +0100, Greg Kurz wrote:
> On Thu, 23 Nov 2017 14:29:38 +0100
> C=E9dric Le Goater <clg@kaod.org> wrote:
>=20
> > The XIVE interrupt controller uses a set of tables to redirect exception
> > from event sources to CPU threads. The Interrupt Virtualization Entry (=
IVE)
> > table, also known as Event Assignment Structure (EAS), is one them.
> >=20
> > The XIVE model is designed to make use of the full range of the IRQ
> > number space and does not use an offset like the XICS mode does.
> > Hence, the IVE table is directly indexed by the IRQ number.
> >=20
> > The IVE stores Event Queue data associated with a source. The lookups
> > are performed when the source is configured or when an event is
> > triggered.
> >=20
> > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > ---
> >  default-configs/ppc64-softmmu.mak |   1 +
> >  hw/intc/Makefile.objs             |   1 +
> >  hw/intc/spapr_xive.c              | 165 ++++++++++++++++++++++++++++++=
++++++++
> >  hw/intc/xive-internal.h           |  50 ++++++++++++
> >  include/hw/ppc/spapr_xive.h       |  44 ++++++++++
> >  5 files changed, 261 insertions(+)
> >  create mode 100644 hw/intc/spapr_xive.c
> >  create mode 100644 hw/intc/xive-internal.h
> >  create mode 100644 include/hw/ppc/spapr_xive.h
> >=20
> > diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-=
softmmu.mak
> > index d1b3a6dd50f8..4a7f6a0696de 100644
> > --- a/default-configs/ppc64-softmmu.mak
> > +++ b/default-configs/ppc64-softmmu.mak
> > @@ -56,6 +56,7 @@ CONFIG_SM501=3Dy
> >  CONFIG_XICS=3D$(CONFIG_PSERIES)
> >  CONFIG_XICS_SPAPR=3D$(CONFIG_PSERIES)
> >  CONFIG_XICS_KVM=3D$(call land,$(CONFIG_PSERIES),$(CONFIG_KVM))
> > +CONFIG_XIVE_SPAPR=3D$(CONFIG_PSERIES)
> >  # For PReP
> >  CONFIG_SERIAL_ISA=3Dy
> >  CONFIG_MC146818RTC=3Dy
> > diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
> > index ae358569a155..49e13e7aeeee 100644
> > --- a/hw/intc/Makefile.objs
> > +++ b/hw/intc/Makefile.objs
> > @@ -35,6 +35,7 @@ obj-$(CONFIG_SH4) +=3D sh_intc.o
> >  obj-$(CONFIG_XICS) +=3D xics.o
> >  obj-$(CONFIG_XICS_SPAPR) +=3D xics_spapr.o
> >  obj-$(CONFIG_XICS_KVM) +=3D xics_kvm.o
> > +obj-$(CONFIG_XIVE_SPAPR) +=3D spapr_xive.o
> >  obj-$(CONFIG_POWERNV) +=3D xics_pnv.o
> >  obj-$(CONFIG_ALLWINNER_A10_PIC) +=3D allwinner-a10-pic.o
> >  obj-$(CONFIG_S390_FLIC) +=3D s390_flic.o
> > diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> > new file mode 100644
> > index 000000000000..b2fc3007c85f
> > --- /dev/null
> > +++ b/hw/intc/spapr_xive.c
> > @@ -0,0 +1,165 @@
> > +/*
> > + * QEMU PowerPC sPAPR XIVE model
> > + *
> > + * Copyright (c) 2017, IBM Corporation.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License, version 2, as
>=20
> version 2 or (at your option) any later version.
>=20
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
> > +#include "hw/ppc/spapr_xive.h"
> > +
> > +#include "xive-internal.h"
> > +
> > +/*
> > + * Main XIVE object
> > + */
> > +
> > +void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon)
> > +{
> > +    int i;
> > +
> > +    for (i =3D 0; i < xive->nr_irqs; i++) {
> > +        XiveIVE *ive =3D &xive->ivt[i];
> > +
> > +        if (!(ive->w & IVE_VALID)) {
> > +            continue;
> > +        }
> > +
> > +        monitor_printf(mon, "  %4x %s %08x %08x\n", i,
> > +                       ive->w & IVE_MASKED ? "M" : " ",
> > +                       (int) GETFIELD(IVE_EQ_INDEX, ive->w),
> > +                       (int) GETFIELD(IVE_EQ_DATA, ive->w));
> > +    }
> > +}
> > +
> > +void spapr_xive_reset(void *dev)
> > +{
> > +    sPAPRXive *xive =3D SPAPR_XIVE(dev);
> > +    int i;
> > +
> > +    /* Mask all valid IVEs in the IRQ number space. */
> > +    for (i =3D 0; i < xive->nr_irqs; i++) {
> > +        XiveIVE *ive =3D &xive->ivt[i];
> > +        if (ive->w & IVE_VALID) {
> > +            ive->w |=3D IVE_MASKED;
> > +        }
> > +    }
> > +}
> > +
> > +static void spapr_xive_realize(DeviceState *dev, Error **errp)
> > +{
> > +    sPAPRXive *xive =3D SPAPR_XIVE(dev);
> > +
> > +    if (!xive->nr_irqs) {
> > +        error_setg(errp, "Number of interrupt needs to be greater 0");
> > +        return;
> > +    }
> > +
> > +    /* Allocate the IVT (Interrupt Virtualization Table) */
> > +    xive->ivt =3D g_malloc0(xive->nr_irqs * sizeof(XiveIVE));
>=20
> Even if it isn't documented, AFAIK current recommended practice is to do:

Yeah, that's a good idea - protects against integer overflows if
nothing else.

>     xive->ivt =3D g_new0(XiveIVE, xive->nr_irqs);
>=20
> > +
> > +    qemu_register_reset(spapr_xive_reset, dev);
>=20
> Shouldn't you set dc->reset in spapr_xive_class_init() instead ?

Yeah, that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Sh7h4lnU5nPTsIof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlofh3IACgkQbDjKyiDZ
s5LuMw/8CZXpNPQNh3Mv4YW1NxhsuQP5q3rTNcSDdqc/gBP7MF7WXVzdyv+xC8zU
MW2V9o0P22U3MOH2p1HGMOjJ6yd4SoRHxUYGmOmaOHsoxNivI6vhMu6Ic9FNZa4h
alBHlN4+b3E8UFuRNt2nUqpaHDvDvyUUFyw/Pca1cO8hCUdR0DyL09QoiZerRz9r
UA9g0eG0j5HIlGJAUouG8Rup4J7JwpzZDLuavklVIQXSqcFnVZVDJA0WQR4kQwSV
si9bVvW4YxMb0NNk0Xg0qn3Aox46zBKbv0Founf0u0GI6Tu91uVvy65o/ta3lKmB
6qPKYI6Ueo1o/nTrwERTtBodfjAROAF5LGcWI6JdAYUKSLpv2wrI7nh7oUUnW67q
VyX0YbGNOwQ1F3g6q8YL3W0btheYexPNrtnju++o4D/W3wHLzEPbRu8NaZAdO/34
2YKoLcpG9y1HA2m8m//SlJo0R6YoxyiRqDdILRe3hW4Y7QIkVF2TvlKbHRJ4AvWe
3gol/HEAiZef+pSvG0fCktjkB3eLTt8QxAJGEGqEVHxzgB72Tgsrn0cReBqTweDD
zLew3C7Nrk1Jt0e+dRrtDzRhOCdWL8Qfr6tyP49M+M3w+YcjksEdP6mkydx2xGB6
CGbCD9RmbljU8LWfm7AjK2UTJYAYSCZwpoFCM+tj+ROTPXOas5M=
=SOFs
-----END PGP SIGNATURE-----

--Sh7h4lnU5nPTsIof--
