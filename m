Received: from eggs.gnu.org ([2001:4830:134:3::10]:34861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gUl9J-0007te-Qh
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 23:20:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gUl9E-0003OF-MX
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 23:20:29 -0500
Date: Thu, 6 Dec 2018 14:25:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181206032535.GL768@umbus.fritz.box>
References: <20181205232251.10446-1-clg@kaod.org>
	<20181205232251.10446-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2EnvhqpWJq810sZn"
Content-Disposition: inline
In-Reply-To: <20181205232251.10446-4-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v6 03/37] ppc/xive: introduce the
 XiveNotifier interface
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


--2EnvhqpWJq810sZn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2018 at 12:22:17AM +0100, C=E9dric Le Goater wrote:
> The XiveNotifier offers a simple interface, between the XiveSource
> object and the main interrupt controller of the machine. It will
> forward event notifications to the XIVE Interrupt Virtualization
> Routing Engine (IVRE).
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/xive.h | 23 +++++++++++++++++++++++
>  hw/intc/xive.c        | 25 +++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 7cebc32eba4c..6770cffec67d 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -142,6 +142,27 @@
> =20
>  #include "hw/qdev-core.h"
> =20
> +/*
> + * XIVE Fabric (Interface between Source and Router)
> + */
> +
> +typedef struct XiveNotifier {
> +    Object parent;
> +} XiveNotifier;
> +
> +#define TYPE_XIVE_NOTIFIER "xive-fabric"

I'm applying this, but changing the string here from "xive-fabric" to
"xive-notifier".


> +#define XIVE_NOTIFIER(obj)                                     \
> +    OBJECT_CHECK(XiveNotifier, (obj), TYPE_XIVE_NOTIFIER)
> +#define XIVE_NOTIFIER_CLASS(klass)                                     \
> +    OBJECT_CLASS_CHECK(XiveNotifierClass, (klass), TYPE_XIVE_NOTIFIER)
> +#define XIVE_NOTIFIER_GET_CLASS(obj)                                   \
> +    OBJECT_GET_CLASS(XiveNotifierClass, (obj), TYPE_XIVE_NOTIFIER)
> +
> +typedef struct XiveNotifierClass {
> +    InterfaceClass parent;
> +    void (*notify)(XiveNotifier *xn, uint32_t lisn);
> +} XiveNotifierClass;
> +
>  /*
>   * XIVE Interrupt Source
>   */
> @@ -171,6 +192,8 @@ typedef struct XiveSource {
>      uint64_t        esb_flags;
>      uint32_t        esb_shift;
>      MemoryRegion    esb_mmio;
> +
> +    XiveNotifier    *xive;
>  } XiveSource;
> =20
>  /*
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 11c7aac962de..79238eb57fae 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -155,7 +155,11 @@ static bool xive_source_esb_eoi(XiveSource *xsrc, ui=
nt32_t srcno)
>   */
>  static void xive_source_notify(XiveSource *xsrc, int srcno)
>  {
> +    XiveNotifierClass *xnc =3D XIVE_NOTIFIER_GET_CLASS(xsrc->xive);
> =20
> +    if (xnc->notify) {
> +        xnc->notify(xsrc->xive, srcno);
> +    }
>  }
> =20
>  /*
> @@ -362,6 +366,17 @@ static void xive_source_reset(void *dev)
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
> +    xsrc->xive =3D XIVE_NOTIFIER(obj);
> =20
>      if (!xsrc->nr_irqs) {
>          error_setg(errp, "Number of interrupt needs to be greater than 0=
");
> @@ -428,9 +443,19 @@ static const TypeInfo xive_source_info =3D {
>      .class_init    =3D xive_source_class_init,
>  };
> =20
> +/*
> + * XIVE Fabric
> + */
> +static const TypeInfo xive_fabric_info =3D {
> +    .name =3D TYPE_XIVE_NOTIFIER,
> +    .parent =3D TYPE_INTERFACE,
> +    .class_size =3D sizeof(XiveNotifierClass),
> +};
> +
>  static void xive_register_types(void)
>  {
>      type_register_static(&xive_source_info);
> +    type_register_static(&xive_fabric_info);
>  }
> =20
>  type_init(xive_register_types)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2EnvhqpWJq810sZn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwIlqwACgkQbDjKyiDZ
s5I8jQ//YT2rbeR8S24yfWuJCjaAPrHedEi/35an7bcoKO/nb03EuEMSHv//LWmz
3jyXMaPlMk1mL4N4ZRsfgR0S/aeDPKhHG9DQvH0q0JciyXC8tsEmrT2G5SyHJS8Q
Ypc03FgpOluEcIZds5pRJqCxykk/59ohWPp00mNb6b97HgoyV8lLIHBiepBVIdfv
BdtjMeYk2087B16Xe7dSCY449DeI+1K8ytjqVw5lZOjNqf+4V/AzkWQagKWungBc
297fzs28hzb3RPkOPVGkeEDRONJBbZ7JCIehjWOpagAGYezRUg+tB8lXFV2m+yCW
p3W1vq47KsWcr73cLfNbdvHjn+pD3eqtDX7bodtSxJro0eVrOZEMJ5GwnZH6eSBU
9P/c0Fxjvt7MyQMV9I6+BzuFwfe0ubBPw80WegImOoZisUZyJAUBsfBVvQaxhR38
QrloGs415VRYctOSfvBLArSf5I66kI9X7XZT8eK6Ef2kMh3xNnbH3xVXXqylKmeg
Wv5IS4L2HUeSXrmjzqcZGP1ncZBvbIp19XS/EEvp2RAwzgUXEbmY+fMlgy/oDumz
u3bWDpmYuZdrZWskd7rhoqOWnffKb/8DDxwrctD/f5BSkeSo6VcC3szIUnPWsX1d
VI/EP96QGkle0vcApKAPl6Fy0pBnE1Ee/0nZBMRHPceW2qFml0Q=
=/+/O
-----END PGP SIGNATURE-----

--2EnvhqpWJq810sZn--
