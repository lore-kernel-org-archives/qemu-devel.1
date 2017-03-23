Received: from eggs.gnu.org ([2001:4830:134:3::10]:45952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cquEt-0001rj-8q
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 00:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cquEr-0005oS-K2
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 00:20:43 -0400
Date: Thu, 23 Mar 2017 15:12:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170323041200.GH19078@umbus.fritz.box>
References: <1489674912-21942-1-git-send-email-clg@kaod.org>
	<1489674912-21942-5-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="poemUeGtc2GQvHuH"
Content-Disposition: inline
In-Reply-To: <1489674912-21942-5-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 4/8] ppc/pnv: add a PnvICPState object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--poemUeGtc2GQvHuH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2017 at 03:35:08PM +0100, C=E9dric Le Goater wrote:
> This provides a new ICPState object for the PowerNV machine (POWER8).
> Access to the Interrupt Management area is done though a memory
> region. It contains the registers of the Interrupt Control Presenters
> of each thread which are used to accept, return, forward interrupts in
> the system.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Revieed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
>  Changes since v1:
>=20
>  - moved the memory region from PnvCore to a specific PnvICPState object
>=20
>  hw/intc/Makefile.objs |   1 +
>  hw/intc/xics_pnv.c    | 180 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/xics.h |  12 ++++
>  3 files changed, 193 insertions(+)
>  create mode 100644 hw/intc/xics_pnv.c
>=20
> diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
> index adedd0da5fd8..78426a7dafcd 100644
> --- a/hw/intc/Makefile.objs
> +++ b/hw/intc/Makefile.objs
> @@ -35,6 +35,7 @@ obj-$(CONFIG_SH4) +=3D sh_intc.o
>  obj-$(CONFIG_XICS) +=3D xics.o
>  obj-$(CONFIG_XICS_SPAPR) +=3D xics_spapr.o
>  obj-$(CONFIG_XICS_KVM) +=3D xics_kvm.o
> +obj-$(CONFIG_POWERNV) +=3D xics_pnv.o
>  obj-$(CONFIG_ALLWINNER_A10_PIC) +=3D allwinner-a10-pic.o
>  obj-$(CONFIG_S390_FLIC) +=3D s390_flic.o
>  obj-$(CONFIG_S390_FLIC_KVM) +=3D s390_flic_kvm.o
> diff --git a/hw/intc/xics_pnv.c b/hw/intc/xics_pnv.c
> new file mode 100644
> index 000000000000..68a3ef6097a6
> --- /dev/null
> +++ b/hw/intc/xics_pnv.c
> @@ -0,0 +1,180 @@
> +/*
> + * QEMU PowerPC PowerNV ICP model
> + *
> + * Copyright (c) 2016, IBM Corporation.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public License
> + * as published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "sysemu/sysemu.h"
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +#include "hw/ppc/xics.h"
> +
> +static uint64_t pnv_icp_read(void *opaque, hwaddr addr, unsigned width)
> +{
> +    ICPState *icp =3D ICP(opaque);
> +    PnvICPState *picp =3D PNV_ICP(opaque);
> +    bool byte0 =3D (width =3D=3D 1 && (addr & 0x3) =3D=3D 0);
> +    uint64_t val =3D 0xffffffff;
> +
> +    switch (addr & 0xffc) {
> +    case 0: /* poll */
> +        val =3D icp_ipoll(icp, NULL);
> +        if (byte0) {
> +            val >>=3D 24;
> +        } else if (width !=3D 4) {
> +            goto bad_access;
> +        }
> +        break;
> +    case 4: /* xirr */
> +        if (byte0) {
> +            val =3D icp_ipoll(icp, NULL) >> 24;
> +        } else if (width =3D=3D 4) {
> +            val =3D icp_accept(icp);
> +        } else {
> +            goto bad_access;
> +        }
> +        break;
> +    case 12:
> +        if (byte0) {
> +            val =3D icp->mfrr;
> +        } else {
> +            goto bad_access;
> +        }
> +        break;
> +    case 16:
> +        if (width =3D=3D 4) {
> +            val =3D picp->links[0];
> +        } else {
> +            goto bad_access;
> +        }
> +        break;
> +    case 20:
> +        if (width =3D=3D 4) {
> +            val =3D picp->links[1];
> +        } else {
> +            goto bad_access;
> +        }
> +        break;
> +    case 24:
> +        if (width =3D=3D 4) {
> +            val =3D picp->links[2];
> +        } else {
> +            goto bad_access;
> +        }
> +        break;
> +    default:
> +bad_access:
> +        qemu_log_mask(LOG_GUEST_ERROR, "XICS: Bad ICP access 0x%"
> +                      HWADDR_PRIx"/%d\n", addr, width);
> +    }
> +
> +    return val;
> +}
> +
> +static void pnv_icp_write(void *opaque, hwaddr addr, uint64_t val,
> +                              unsigned width)
> +{
> +    ICPState *icp =3D ICP(opaque);
> +    PnvICPState *picp =3D PNV_ICP(opaque);
> +    bool byte0 =3D (width =3D=3D 1 && (addr & 0x3) =3D=3D 0);
> +
> +    switch (addr & 0xffc) {
> +    case 4: /* xirr */
> +        if (byte0) {
> +            icp_set_cppr(icp, val);
> +        } else if (width =3D=3D 4) {
> +            icp_eoi(icp, val);
> +        } else {
> +            goto bad_access;
> +        }
> +        break;
> +    case 12:
> +        if (byte0) {
> +            icp_set_mfrr(icp, val);
> +        } else {
> +            goto bad_access;
> +        }
> +        break;
> +    case 16:
> +        if (width =3D=3D 4) {
> +            picp->links[0] =3D val;
> +        } else {
> +            goto bad_access;
> +        }
> +        break;
> +    case 20:
> +        if (width =3D=3D 4) {
> +            picp->links[1] =3D val;
> +        } else {
> +            goto bad_access;
> +        }
> +        break;
> +    case 24:
> +        if (width =3D=3D 4) {
> +            picp->links[2] =3D val;
> +        } else {
> +            goto bad_access;
> +        }
> +        break;
> +    default:
> +bad_access:
> +        qemu_log_mask(LOG_GUEST_ERROR, "XICS: Bad ICP access 0x%"
> +                      HWADDR_PRIx"/%d\n", addr, width);
> +    }
> +}
> +
> +static const MemoryRegionOps pnv_icp_ops =3D {
> +    .read =3D pnv_icp_read,
> +    .write =3D pnv_icp_write,
> +    .valid.min_access_size =3D 1,
> +    .valid.max_access_size =3D 4,
> +    .impl.min_access_size =3D 1,
> +    .impl.max_access_size =3D 4,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
> +};
> +
> +static void pnv_icp_realize(DeviceState *dev, Error **errp)
> +{
> +    PnvICPState *icp =3D PNV_ICP(dev);
> +
> +    memory_region_init_io(&icp->mmio, OBJECT(dev), &pnv_icp_ops,
> +                          icp, "icp-thread", 0x1000);
> +}
> +
> +static void pnv_icp_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    ICPStateClass *icpc =3D ICP_CLASS(klass);
> +
> +    icpc->realize =3D pnv_icp_realize;
> +    dc->desc =3D "PowerNV ICP";
> +}
> +
> +static const TypeInfo pnv_icp_info =3D {
> +    .name          =3D TYPE_PNV_ICP,
> +    .parent        =3D TYPE_ICP,
> +    .instance_size =3D sizeof(PnvICPState),
> +    .class_init    =3D pnv_icp_class_init,
> +    .class_size    =3D sizeof(ICPStateClass),
> +};
> +
> +static void pnv_icp_register_types(void)
> +{
> +    type_register_static(&pnv_icp_info);
> +}
> +
> +type_init(pnv_icp_register_types)
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 0863e3a079f5..cfcf7ecece69 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -41,10 +41,12 @@
>   */
>  typedef struct ICPStateClass ICPStateClass;
>  typedef struct ICPState ICPState;
> +typedef struct PnvICPState PnvICPState;
>  typedef struct ICSStateClass ICSStateClass;
>  typedef struct ICSState ICSState;
>  typedef struct ICSIRQState ICSIRQState;
>  typedef struct XICSFabric XICSFabric;
> +typedef struct PowerPCCPU PowerPCCPU;
> =20
>  #define TYPE_ICP "icp"
>  #define ICP(obj) OBJECT_CHECK(ICPState, (obj), TYPE_ICP)
> @@ -52,6 +54,9 @@ typedef struct XICSFabric XICSFabric;
>  #define TYPE_KVM_ICP "icp-kvm"
>  #define KVM_ICP(obj) OBJECT_CHECK(ICPState, (obj), TYPE_KVM_ICP)
> =20
> +#define TYPE_PNV_ICP "pnv-icp"
> +#define PNV_ICP(obj) OBJECT_CHECK(PnvICPState, (obj), TYPE_PNV_ICP)
> +
>  #define ICP_CLASS(klass) \
>       OBJECT_CLASS_CHECK(ICPStateClass, (klass), TYPE_ICP)
>  #define ICP_GET_CLASS(obj) \
> @@ -81,6 +86,13 @@ struct ICPState {
>      XICSFabric *xics;
>  };
> =20
> +struct PnvICPState {
> +    ICPState parent_obj;
> +
> +    MemoryRegion mmio;
> +    uint32_t links[3];
> +};
> +
>  #define TYPE_ICS_BASE "ics-base"
>  #define ICS_BASE(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_BASE)
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--poemUeGtc2GQvHuH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY00sQAAoJEGw4ysog2bOST20QALswMcATMYKZd1aES1OlY6LE
KFdD81wVG70gsiUqozmI7y/y9hpiXbBN+N1WCH92wVsMcyFFtxt8JbGX2fjsYabZ
3zQDtKGndYK77jNLt/wsZbrLDZFZXv1CgawhHNBEMTjz++9PAQeRBh9KJ3xRisHQ
ClIERbxdazY8/cV3Stk3m7OR8cHj5FA94MIEJjVt6HJPFL/vTsU/hAubml7PrWUx
dy1ahDMJ5FNyjLuEbFuFEGUY24otbDebNg129WGd+nMDEyLl1opw+1lWnkJMcnM/
aXk6gEcvuiG/EFpWwk2R1W0iuZj+oc3wpqlIRl8bn0isU80YkYNWdDBa25AViftt
bP9jVyTi0b5H9Ai5On2WtM8RkcINv8fassEUO+XDJvUazSsY8HdR54nU7GbN9snl
uBRFIZKlDObIMYANTSB8wWklLasNiWWe4DtB/aSxw0lJpY2NeywUWh+FVgrsaRqz
+RHa6Hyz2KfFY5vwbwoC1d/cyX6+WHJXFL/zb6E3t3aw+o+Dh2vZeBxF2DFAUdAh
9joagZys7+TCc7TzDwezr6yRZtcvawMdIowoKSJgv3t9OYg5PjFMmBPyhvE5GoUV
SnTeBXclyrGUujOmx9B1xW5cgSFW8b2uGQZP3TsrMrwoGEu9uHiArInN78CLSwaR
VUvMIkY5K6lVUuGkppDg
=hIlk
-----END PGP SIGNATURE-----

--poemUeGtc2GQvHuH--
