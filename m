Received: from eggs.gnu.org ([2001:4830:134:3::10]:56715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fAsh4-0000A8-82
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 03:48:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fAsh2-0000Xr-E5
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 03:48:54 -0400
Date: Tue, 24 Apr 2018 16:46:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180424064629.GP19804@umbus.fritz.box>
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-4-clg@kaod.org>
	<20180423064644.GG19804@umbus.fritz.box>
	<8d1cb270-d62f-f08f-9167-3f130906f910@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xXygN3QAmJYWdGtb"
Content-Disposition: inline
In-Reply-To: <8d1cb270-d62f-f08f-9167-3f130906f910@kaod.org>
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


--xXygN3QAmJYWdGtb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 23, 2018 at 09:58:43AM +0200, C=E9dric Le Goater wrote:
> On 04/23/2018 08:46 AM, David Gibson wrote:
> > On Thu, Apr 19, 2018 at 02:42:59PM +0200, C=E9dric Le Goater wrote:
> >> The XiveFabric offers a simple interface, between the XiveSourve
> >> object and the device model owning the interrupt sources, to forward
> >> an event notification to the XIVE interrupt controller of the machine
> >> and if the owner is the controller, to call directly the routing
> >> sub-engine.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  hw/intc/xive.c        | 37 ++++++++++++++++++++++++++++++++++++-
> >>  include/hw/ppc/xive.h | 25 +++++++++++++++++++++++++
> >>  2 files changed, 61 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> >> index 060976077dd7..b4c3d06c1219 100644
> >> --- a/hw/intc/xive.c
> >> +++ b/hw/intc/xive.c
> >> @@ -17,6 +17,21 @@
> >>  #include "hw/ppc/xive.h"
> >> =20
> >>  /*
> >> + * XIVE Fabric
> >> + */
> >> +
> >> +static void xive_fabric_route(XiveFabric *xf, int lisn)
> >> +{
> >> +
> >> +}
> >> +
> >> +static const TypeInfo xive_fabric_info =3D {
> >> +    .name =3D TYPE_XIVE_FABRIC,
> >> +    .parent =3D TYPE_INTERFACE,
> >> +    .class_size =3D sizeof(XiveFabricClass),
> >> +};
> >> +
> >> +/*
> >>   * XIVE Interrupt Source
> >>   */
> >> =20
> >> @@ -97,11 +112,19 @@ static bool xive_source_pq_trigger(XiveSource *xs=
rc, uint32_t srcno)
> >> =20
> >>  /*
> >>   * Forward the source event notification to the associated XiveFabric,
> >> - * the device owning the sources.
> >> + * the device owning the sources, or perform the routing if the device
> >> + * is the interrupt controller.
> >>   */
> >>  static void xive_source_notify(XiveSource *xsrc, int srcno)
> >>  {
> >> =20
> >> +    XiveFabricClass *xfc =3D XIVE_FABRIC_GET_CLASS(xsrc->xive);
> >> +
> >> +    if (xfc->notify) {
> >> +        xfc->notify(xsrc->xive, srcno + xsrc->offset);
> >> +    } else {
> >> +        xive_fabric_route(xsrc->xive, srcno + xsrc->offset);
> >> +    }
> >=20
> > Why 2 cases?  Can't the XiveFabric object just make its notify equal
> > to xive_fabric_route if that's what it wants?
> Under sPAPR, all the sources, IPIs and virtual device interrupts,=20
> generate events which are directly routed by xive_fabric_route().=20
> There is no need of an extra hop. Indeed.=20

Ok.

> Under PowerNV, some sources forward the notification to the routing=20
> engine using a specific MMIO load on a notify address which is stored=20
> in one of the controller registers. So we need a hop to reach the=20
> device model, owning the sources, and do that load :

Hm.  So you're saying that in pnv some sources send their notification
to some other unit, that would then (after possible masking) forward
on to the overall xive fabric?

That seems like a property of the source object, rather than a
property of the fabric.  Indeed varying this by source object would
require the objects have a different xive pointer, when I thought the
idea was that the XiveFabric was global.

> 	static void pnv_psi_notify(XiveFabric *xf, uint32_t lisn)
> 	{
> 	    PnvPsi *psi =3D PNV_PSI(xf);
> 	    uint64_t notif_port =3D
> 	        psi->regs[PSIHB_REG(PSIHB9_ESB_NOTIF_ADDR)];
> 	    bool valid =3D notif_port & PSIHB9_ESB_NOTIF_VALID;
> 	    uint64_t notify_addr =3D notif_port & ~PSIHB9_ESB_NOTIF_VALID;
> 	    uint32_t data =3D cpu_to_be32(lisn);
> =09
> 	    if (valid) {
> 	        cpu_physical_memory_write(notify_addr, &data, sizeof(data));
> 	    }
> 	}
>=20
> The PnvXive model handles the load and forwards to the fabric again. =20
>=20
> The IPIs under PowerNV do not need an extra hop so they reach the=20
> routing routine directly without the extra notify() hop.=20
>=20
> However, PowerNV at the end should be using xive_fabric_route()=20
> but there are some differences on how the NVT registers are=20
> updated (HV vs. OS mode) and it's not handled yet so it uses a=20
> notify() handler. But is should disappear and call directly=20
> xive_fabric_route() in a near future.
>=20
>=20
> May be, XiveFabricNotifier would be a better name for this feature ?
> I am adding a few ops later which are more related to routing.
>=20
> Thanks,
>=20
> C.
>=20
>=20
> >=20
> >>  }
> >> =20
> >>  /*
> >> @@ -302,6 +325,17 @@ static void xive_source_reset(DeviceState *dev)
> >>  static void xive_source_realize(DeviceState *dev, Error **errp)
> >>  {
> >>      XiveSource *xsrc =3D XIVE_SOURCE(dev);
> >> +    Object *obj;
> >> +    Error *local_err =3D NULL;
> >> +
> >> +    obj =3D object_property_get_link(OBJECT(dev), "xive", &local_err);
> >> +    if (!obj) {
> >> +        error_propagate(errp, local_err);
> >> +        error_prepend(errp, "required link 'xive' not found: ");
> >> +        return;
> >> +    }
> >> +
> >> +    xsrc->xive =3D XIVE_FABRIC(obj);
> >> =20
> >>      if (!xsrc->nr_irqs) {
> >>          error_setg(errp, "Number of interrupt needs to be greater tha=
n 0");
> >> @@ -376,6 +410,7 @@ static const TypeInfo xive_source_info =3D {
> >>  static void xive_register_types(void)
> >>  {
> >>      type_register_static(&xive_source_info);
> >> +    type_register_static(&xive_fabric_info);
> >>  }
> >> =20
> >>  type_init(xive_register_types)
> >> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> >> index 0b76dd278d9b..4fcae2c763e6 100644
> >> --- a/include/hw/ppc/xive.h
> >> +++ b/include/hw/ppc/xive.h
> >> @@ -12,6 +12,8 @@
> >> =20
> >>  #include "hw/sysbus.h"
> >> =20
> >> +typedef struct XiveFabric XiveFabric;
> >> +
> >>  /*
> >>   * XIVE Interrupt Source
> >>   */
> >> @@ -46,6 +48,8 @@ typedef struct XiveSource {
> >>      hwaddr       esb_base;
> >>      uint32_t     esb_shift;
> >>      MemoryRegion esb_mmio;
> >> +
> >> +    XiveFabric   *xive;
> >>  } XiveSource;
> >> =20
> >>  /*
> >> @@ -143,4 +147,25 @@ static inline void xive_source_irq_set(XiveSource=
 *xsrc, uint32_t srcno,
> >>      xsrc->status[srcno] |=3D lsi ? XIVE_STATUS_LSI : 0;
> >>  }
> >> =20
> >> +/*
> >> + * XIVE Fabric
> >> + */
> >> +
> >> +typedef struct XiveFabric {
> >> +    Object parent;
> >> +} XiveFabric;
> >> +
> >> +#define TYPE_XIVE_FABRIC "xive-fabric"
> >> +#define XIVE_FABRIC(obj)                                     \
> >> +    OBJECT_CHECK(XiveFabric, (obj), TYPE_XIVE_FABRIC)
> >> +#define XIVE_FABRIC_CLASS(klass)                                     \
> >> +    OBJECT_CLASS_CHECK(XiveFabricClass, (klass), TYPE_XIVE_FABRIC)
> >> +#define XIVE_FABRIC_GET_CLASS(obj)                                   \
> >> +    OBJECT_GET_CLASS(XiveFabricClass, (obj), TYPE_XIVE_FABRIC)
> >> +
> >> +typedef struct XiveFabricClass {
> >> +    InterfaceClass parent;
> >> +    void (*notify)(XiveFabric *xf, uint32_t lisn);
> >> +} XiveFabricClass;
> >> +
> >>  #endif /* PPC_XIVE_H */
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xXygN3QAmJYWdGtb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlre0sUACgkQbDjKyiDZ
s5IYyBAApKJ447hCYIGMg4ZStljeXJTUk8oHxhwe2n5COskV6dAr4cvPeAsuZACX
NZ98JNV6ujEuDb6UTVYsAOmPjdRWWsftIUbjVCVQsqC9zDA0oTNm9wMbrlnUesPh
9W1488Smc+vt9L94TiKINs/82/ejqVvEBiywTrl57rYldBGQVM1LNsmKor9gvd6z
8d7RHofEmHuNaZYmgIVJ9VMSwsbFWWJ11FquFyWMmA+paljeftiyobmqnU13pUwH
YzUZPtWxjwVkIu2AE3JWxdHgIFLyAfZXisGCnVtiPwqyU1dX4wQnoCvN32Zhy2jg
j1aGHhC5T0f4vFsh6uGi3d/aV9mlbCCUL188b5AJ+CZ3fXoG/WWETrm6QQi2FvIC
/9Y7G3KWBo1LsPbR5hBlxfecamj+AAFYlRAUBeKdisAWyGJq30CCfoIlOFasziFl
Q3ZpNu3ZTdbPbTOOqlBLMN5QDSscRnxHzxUG8wB2W7rvspqzdyUHKaoLPw4e1Nhm
shYR+WzRoPHStNuiUQ75wn5QuLBkXiI5XyxdnkHYcoN3YnzMazN9V6lvmwiYOeb4
Orp4sztZEY7vmrA2OS2q6nTGuRMRWkk3omCIViMPgaogX0e72+O+cbvvcp70B6wI
G3+z2NQFa0UihP1cTj/wETeeNHomzv7xS+VPe2ffL90fxx+l+hg=
=LI5J
-----END PGP SIGNATURE-----

--xXygN3QAmJYWdGtb--
