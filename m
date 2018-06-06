Received: from eggs.gnu.org ([2001:4830:134:3::10]:47622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQMhe-0004Te-K2
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 20:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQMhd-00083j-IQ
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 20:53:30 -0400
Date: Wed, 6 Jun 2018 10:18:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180606001852.GC17757@umbus.fritz.box>
References: <20180605065626.4304-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Content-Disposition: inline
In-Reply-To: <20180605065626.4304-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] spapr/vio: deprecate the "irq" property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2018 at 08:56:26AM +0200, C=E9dric Le Goater wrote:
> VIO devices have an "irq" property that can be used by the sPAPR IRQ
> allocator as an IRQ number hint. But it is not set in QEMU nor in
> libvirt. It brings unnecessary complexity to the underlying layers
> managing the IRQ number space and it is in full opposition with the
> new static IRQ allocator we want to introduce in sPAPR.
>=20
> Let's deprecate it to simplify the spapr_irq_alloc routine in the
> future.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-3.0.

Should we also add a section for deprecated properties to
https://wiki.qemu.org/Features/LegacyRemoval ?

> ---
>  qemu-doc.texi      | 12 ++++++++++--
>  hw/ppc/spapr_vio.c | 19 ++++++++++++++++++-
>  2 files changed, 28 insertions(+), 3 deletions(-)
>=20
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index f00706b9996c..fd25ddf7a06a 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2970,13 +2970,21 @@ support page sizes < 4096 any longer.
>  The ``xlnx-ep108'' machine has been replaced by the ``xlnx-zcu102'' mach=
ine.
>  The ``xlnx-zcu102'' machine has the same features and capabilites in QEM=
U.
> =20
> -@section Block device options
> +@section Device options
> =20
> -@subsection "backing": "" (since 2.12.0)
> +@subsection Block device options
> +
> +@subsubsection "backing": "" (since 2.12.0)
> =20
>  In order to prevent QEMU from automatically opening an image's backing
>  chain, use ``"backing": null'' instead.
> =20
> +@subsection vio-spapr-device device options
> +
> +@subsubsection "irq": "" (since 3.0.0)
> +
> +The ``irq'' property is obsoleted.
> +
>  @node Supported build platforms
>  @appendix Supported build platforms
> =20
> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
> index 472dd6f33a96..28bb3b849b9b 100644
> --- a/hw/ppc/spapr_vio.c
> +++ b/hw/ppc/spapr_vio.c
> @@ -22,6 +22,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> +#include "qapi/visitor.h"
>  #include "hw/hw.h"
>  #include "qemu/log.h"
>  #include "sysemu/sysemu.h"
> @@ -41,8 +42,24 @@
> =20
>  #include <libfdt.h>
> =20
> +static void spapr_vio_getset_irq(Object *obj, Visitor *v, const char *na=
me,
> +                              void *opaque, Error **errp)
> +{
> +    Property *prop =3D opaque;
> +    uint32_t *ptr =3D qdev_get_prop_ptr(DEVICE(obj), prop);
> +
> +    warn_report(TYPE_VIO_SPAPR_DEVICE " '%s' property is deprecated", na=
me);
> +    visit_type_uint32(v, name, ptr, errp);
> +}
> +
> +static const PropertyInfo spapr_vio_irq_propinfo =3D {
> +    .name =3D "irq",
> +    .get =3D spapr_vio_getset_irq,
> +    .set =3D spapr_vio_getset_irq,
> +};
> +
>  static Property spapr_vio_props[] =3D {
> -    DEFINE_PROP_UINT32("irq", VIOsPAPRDevice, irq, 0), \
> +    DEFINE_PROP("irq", VIOsPAPRDevice, irq, spapr_vio_irq_propinfo, uint=
32_t),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsXKGwACgkQbDjKyiDZ
s5LCEw//RiAX61zZ8hbmAk4IrFuW2deaIMOcDz27Dhts/vwa6H+8IIFzBdbScuyh
uk/vSnIFiBrg0pZes8bR9jo7IcF6BkMIYuzI1ad/A6rnJdcXelDL31JLgOhcF7cb
x2MZB72OLNa1aBMlvdeb8g8A1VWhkZ1/LYykQeDsnwKf/a0TJtNVA7UX7MWFCqCv
Zo7LoZyGea3FV45veeDlFEML4o2pupHIpbAVKnzw9seudfrJUNojrZu2FvCK2IZ9
HXer1XADsqf1FSap3e+zCNO7Ina3IFZ7nwe4crYCJ1LTeQvgI40owEGOvxpbcLzh
HKSFp+7JCpfdvqeDLmwAgUrN7ucG4KYQw//yRNr4hl6DUyqMlKSMYncbYIV3qSur
PvCf5bd672oz53PMcTLXkUJd/KrrTdCZltwlf2ifyyfn8rfSGUvNAPUGAoY1xcC0
FPVgCLJGqI48WLcAOEwqGKd+9vSbdqGaE+pN5OrQW+AiQgQPT7XoHPao7LrNb3T2
5BTnEsF8KBxI38AojTOuWGrwl1rt266bu8/EVqJOYqxDUWtVIrXKz03wQdLQOvIa
5/YL6trBr10LfyM3y3qiOzfreRYEzLnulVhtMMH57Lr7uIH0S/Q8QPFBCDl6Yiz0
NligxH7OPfPSLIbOLgxWhZoSfBx9iRoLZEvqKgCP0I4onTQb5zU=
=EfUB
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--
