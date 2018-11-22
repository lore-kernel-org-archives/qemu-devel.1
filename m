Received: from eggs.gnu.org ([2001:4830:134:3::10]:47213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gPhGM-0004n6-Ow
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 00:10:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gPhGL-0005ab-OI
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 00:10:50 -0500
Date: Thu, 22 Nov 2018 15:44:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181122044450.GF10448@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-5-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="924gEkU1VlJlwnwX"
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


--924gEkU1VlJlwnwX
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

Sorry, didn't think of this in my first reply.

1) Does the hardware ever actually write back to the EAS?  I know it
does for the END, but it's not clear why it would need to for the
EAS.  If not, we don't need the setter.

2) The signatures are a bit odd here.  For the setter, a value would
make sense than a (XiveEAS *), since it's just a word.  For the getter
you could return the EAS value directly rather than using a pointer -
there's already a valid bit in the EAS so you can construct a value
with that cleared if the lisn is out of bounds.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--924gEkU1VlJlwnwX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv2NEIACgkQbDjKyiDZ
s5Lxqg/9GmYYTsrfTyw8/mqHTGyhG4z7Z7O2VqY3rLguPotiRFrz8FVKHX6y8kXa
Zgm15L5E16dZpc/PsBsnZWoPYEsrXm6cfLEDpLv6QHL43ZxUmgyeET1GH/a4DGxx
m8MvTyFKl0s3SpgOh2tfd8eILxlWvS5v4OpA5I7aZGapg/jrGCNnYwsZbZAn7A+n
iJAV1Jt+f1fpVnh/M7fQCN8eWVH13BWsg/zJOWnUHk2aa9wVTM+XBqa2h//pwBiZ
ZrjXqymSPw2dOufKbfy/rUn8k0gM+/1IscFC/WwjLSp+m/UvcZsgIL4/dMI33jsG
1ajIzI9NGydz4t/Jo3aLVnYr4Flm/UWoikga+6K6ib7LgER6J3GPxtaHH/aw3KdD
5/D2nLINcZp2v5u5JUFe4WxNZH6Prw0yXXKzrfm/jZF/iXKYV/OemTlQjF7vKO4g
e7XU6FpYAGLkkFbHY7z4gdIBudXaWf3X1wKNp9Fb7eQK+hpBvhyef+xoB3CnQLVF
u+6uDROYOJlEzcg3ogJGpzr2AyUu+kDdemOoHv4ak8ndFQh7/SksjLQWh5IXr9Ab
MsWR/ecIsFhf+t0zUhhccHd3MvNpGNxOZeG+GKoyD3LZLVW49hYtb9BLDTUI0khP
MNEuBikll1t7CzTHdaAuEbhcMCILOLhxTVt2wwYMJgYlaSB+pHo=
=JgRp
-----END PGP SIGNATURE-----

--924gEkU1VlJlwnwX--
