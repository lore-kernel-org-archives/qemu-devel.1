Received: from eggs.gnu.org ([2001:4830:134:3::10]:51786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fAVK4-0002tN-MM
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 02:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fAVK3-0004C7-GF
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 02:51:36 -0400
Date: Mon, 23 Apr 2018 16:46:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180423064644.GG19804@umbus.fritz.box>
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AGZzQgpsuUlWC1xT"
Content-Disposition: inline
In-Reply-To: <20180419124331.3915-4-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v3 03/35] ppc/xive: introduce the
 XiveFabric interface
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


--AGZzQgpsuUlWC1xT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2018 at 02:42:59PM +0200, C=E9dric Le Goater wrote:
> The XiveFabric offers a simple interface, between the XiveSourve
> object and the device model owning the interrupt sources, to forward
> an event notification to the XIVE interrupt controller of the machine
> and if the owner is the controller, to call directly the routing
> sub-engine.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/xive.c        | 37 ++++++++++++++++++++++++++++++++++++-
>  include/hw/ppc/xive.h | 25 +++++++++++++++++++++++++
>  2 files changed, 61 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 060976077dd7..b4c3d06c1219 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -17,6 +17,21 @@
>  #include "hw/ppc/xive.h"
> =20
>  /*
> + * XIVE Fabric
> + */
> +
> +static void xive_fabric_route(XiveFabric *xf, int lisn)
> +{
> +
> +}
> +
> +static const TypeInfo xive_fabric_info =3D {
> +    .name =3D TYPE_XIVE_FABRIC,
> +    .parent =3D TYPE_INTERFACE,
> +    .class_size =3D sizeof(XiveFabricClass),
> +};
> +
> +/*
>   * XIVE Interrupt Source
>   */
> =20
> @@ -97,11 +112,19 @@ static bool xive_source_pq_trigger(XiveSource *xsrc,=
 uint32_t srcno)
> =20
>  /*
>   * Forward the source event notification to the associated XiveFabric,
> - * the device owning the sources.
> + * the device owning the sources, or perform the routing if the device
> + * is the interrupt controller.
>   */
>  static void xive_source_notify(XiveSource *xsrc, int srcno)
>  {
> =20
> +    XiveFabricClass *xfc =3D XIVE_FABRIC_GET_CLASS(xsrc->xive);
> +
> +    if (xfc->notify) {
> +        xfc->notify(xsrc->xive, srcno + xsrc->offset);
> +    } else {
> +        xive_fabric_route(xsrc->xive, srcno + xsrc->offset);
> +    }

Why 2 cases?  Can't the XiveFabric object just make its notify equal
to xive_fabric_route if that's what it wants?

>  }
> =20
>  /*
> @@ -302,6 +325,17 @@ static void xive_source_reset(DeviceState *dev)
>  static void xive_source_realize(DeviceState *dev, Error **errp)
>  {
>      XiveSource *xsrc =3D XIVE_SOURCE(dev);
> +    Object *obj;
> +    Error *local_err =3D NULL;
> +
> +    obj =3D object_property_get_link(OBJECT(dev), "xive", &local_err);
> +    if (!obj) {
> +        error_propagate(errp, local_err);
> +        error_prepend(errp, "required link 'xive' not found: ");
> +        return;
> +    }
> +
> +    xsrc->xive =3D XIVE_FABRIC(obj);
> =20
>      if (!xsrc->nr_irqs) {
>          error_setg(errp, "Number of interrupt needs to be greater than 0=
");
> @@ -376,6 +410,7 @@ static const TypeInfo xive_source_info =3D {
>  static void xive_register_types(void)
>  {
>      type_register_static(&xive_source_info);
> +    type_register_static(&xive_fabric_info);
>  }
> =20
>  type_init(xive_register_types)
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 0b76dd278d9b..4fcae2c763e6 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -12,6 +12,8 @@
> =20
>  #include "hw/sysbus.h"
> =20
> +typedef struct XiveFabric XiveFabric;
> +
>  /*
>   * XIVE Interrupt Source
>   */
> @@ -46,6 +48,8 @@ typedef struct XiveSource {
>      hwaddr       esb_base;
>      uint32_t     esb_shift;
>      MemoryRegion esb_mmio;
> +
> +    XiveFabric   *xive;
>  } XiveSource;
> =20
>  /*
> @@ -143,4 +147,25 @@ static inline void xive_source_irq_set(XiveSource *x=
src, uint32_t srcno,
>      xsrc->status[srcno] |=3D lsi ? XIVE_STATUS_LSI : 0;
>  }
> =20
> +/*
> + * XIVE Fabric
> + */
> +
> +typedef struct XiveFabric {
> +    Object parent;
> +} XiveFabric;
> +
> +#define TYPE_XIVE_FABRIC "xive-fabric"
> +#define XIVE_FABRIC(obj)                                     \
> +    OBJECT_CHECK(XiveFabric, (obj), TYPE_XIVE_FABRIC)
> +#define XIVE_FABRIC_CLASS(klass)                                     \
> +    OBJECT_CLASS_CHECK(XiveFabricClass, (klass), TYPE_XIVE_FABRIC)
> +#define XIVE_FABRIC_GET_CLASS(obj)                                   \
> +    OBJECT_GET_CLASS(XiveFabricClass, (obj), TYPE_XIVE_FABRIC)
> +
> +typedef struct XiveFabricClass {
> +    InterfaceClass parent;
> +    void (*notify)(XiveFabric *xf, uint32_t lisn);
> +} XiveFabricClass;
> +
>  #endif /* PPC_XIVE_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AGZzQgpsuUlWC1xT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrdgVQACgkQbDjKyiDZ
s5JVPQ/+O9DHgRMsuZs0QNutYijdgabX60fF29tqK76/kdavs0lUWf3AXIWzspJO
LBehzUg9anRt5Ye54ehXZuM0tqN9M78Prt0GYYZUlWwRMHr9Im+WH4S8uLhoDHK4
11CyGS/y6Flwr6WXl9aYPuJXc5fRo6UhfDZJYB8kGeyn0WQtrZlABrxJF/+pOZVH
gpIiPXULhoXMivPI7BFoJkePNkpX0qolNXLGdMWUUGlxv8FMWkdoY+JT+XCIxqJf
sCWvhxu8thmC58TjLrKx9GMXFVLtJCU5IktEIKzrH5De2b6/cdhdtJZBbBZiDInz
eKk11Kz6K737TxPkgE1PORG0ZeGzjKEqZP5lLXVRu8KDaM+Q+AH5nkEM9JFdKZzR
40n8avQ6efWRU7R9aRUfI4xiIvZI8TarktPdiJVlx1boMDU5D0gGpEH+fkhh17/C
EFPDRvIINOXhtxYPfmAPvJelCpwCh7T0TaJo4O+wbz+XBSjg++smwp3X22x50I8F
ejtNEg8PI3SuGk+4bZ1MHkKXPRX9RIE0NV/pSWNbQQVG5lUa7BDTcX7pGIzNTxgz
Qp+SqKSGny3cObC+xhL3DCfLeThQMupfpYaCfKiw/BKL4mGBFOXaweJPBH8QUj9A
cO2rwXMCTniRZOgq525SZ5DLDGrnaqHN7blvMlK9PJyzU1GYUNo=
=yzvi
-----END PGP SIGNATURE-----

--AGZzQgpsuUlWC1xT--
