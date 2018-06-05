Received: from eggs.gnu.org ([2001:4830:134:3::10]:33568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQ8He-0002pW-CE
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:29:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQ8Hb-00022f-1p
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:29:42 -0400
Received: from 5.mo68.mail-out.ovh.net ([46.105.62.179]:53083)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fQ8Ha-000213-R5
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:29:38 -0400
Received: from player698.ha.ovh.net (unknown [10.109.108.27])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 08D94E65B6
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 11:29:36 +0200 (CEST)
Date: Tue, 5 Jun 2018 11:29:27 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180605112927.797418d5@bahia.lan>
In-Reply-To: <20180605065626.4304-1-clg@kaod.org>
References: <20180605065626.4304-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] spapr/vio: deprecate the "irq" property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>

On Tue,  5 Jun 2018 08:56:26 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> VIO devices have an "irq" property that can be used by the sPAPR IRQ
> allocator as an IRQ number hint. But it is not set in QEMU nor in
> libvirt. It brings unnecessary complexity to the underlying layers
> managing the IRQ number space and it is in full opposition with the
> new static IRQ allocator we want to introduce in sPAPR.
>=20
> Let's deprecate it to simplify the spapr_irq_alloc routine in the
> future.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
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

"obsoleted" or "deprecated" ? Also maybe you could provide some
more context, so that users don't have to run git log to know
what's going on here ?

No big deal anyway, so:

Reviewed-by: Greg Kurz <groug@kaod.org>

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
