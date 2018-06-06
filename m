Received: from eggs.gnu.org ([2001:4830:134:3::10]:57139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQRLD-00036Z-Bh
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 01:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQRLA-000806-6t
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 01:50:39 -0400
Received: from 5.mo3.mail-out.ovh.net ([87.98.178.36]:48079)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fQRL9-0007zq-RZ
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 01:50:36 -0400
Received: from player773.ha.ovh.net (unknown [10.109.122.118])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 315061BB6F0
	for <qemu-devel@nongnu.org>; Wed,  6 Jun 2018 07:50:33 +0200 (CEST)
Date: Wed, 6 Jun 2018 07:50:24 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180606075024.7181d0ec@bahia.lan>
In-Reply-To: <20180606001852.GC17757@umbus.fritz.box>
References: <20180605065626.4304-1-clg@kaod.org>
	<20180606001852.GC17757@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/+Io=cti=un6eRXQcBYJrPJz";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] spapr/vio: deprecate the "irq" property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>

--Sig_/+Io=cti=un6eRXQcBYJrPJz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Jun 2018 10:18:52 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Jun 05, 2018 at 08:56:26AM +0200, C=C3=A9dric Le Goater wrote:
> > VIO devices have an "irq" property that can be used by the sPAPR IRQ
> > allocator as an IRQ number hint. But it is not set in QEMU nor in
> > libvirt. It brings unnecessary complexity to the underlying layers
> > managing the IRQ number space and it is in full opposition with the
> > new static IRQ allocator we want to introduce in sPAPR.
> >=20
> > Let's deprecate it to simplify the spapr_irq_alloc routine in the
> > future.
> >=20
> > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org> =20
>=20
> Applied to ppc-for-3.0.
>=20
> Should we also add a section for deprecated properties to
> https://wiki.qemu.org/Features/LegacyRemoval ?
>=20

It isn't formally required but it wouldn't hurt.

"Note: This page is used to gather ideas about deprecated features and inte=
rfaces,
 the lists here are by no means mandatory!"

> > ---
> >  qemu-doc.texi      | 12 ++++++++++--
> >  hw/ppc/spapr_vio.c | 19 ++++++++++++++++++-
> >  2 files changed, 28 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/qemu-doc.texi b/qemu-doc.texi
> > index f00706b9996c..fd25ddf7a06a 100644
> > --- a/qemu-doc.texi
> > +++ b/qemu-doc.texi
> > @@ -2970,13 +2970,21 @@ support page sizes < 4096 any longer.
> >  The ``xlnx-ep108'' machine has been replaced by the ``xlnx-zcu102'' ma=
chine.
> >  The ``xlnx-zcu102'' machine has the same features and capabilites in Q=
EMU.
> > =20
> > -@section Block device options
> > +@section Device options
> > =20
> > -@subsection "backing": "" (since 2.12.0)
> > +@subsection Block device options
> > +
> > +@subsubsection "backing": "" (since 2.12.0)
> > =20
> >  In order to prevent QEMU from automatically opening an image's backing
> >  chain, use ``"backing": null'' instead.
> > =20
> > +@subsection vio-spapr-device device options
> > +
> > +@subsubsection "irq": "" (since 3.0.0)
> > +
> > +The ``irq'' property is obsoleted.
> > +
> >  @node Supported build platforms
> >  @appendix Supported build platforms
> > =20
> > diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
> > index 472dd6f33a96..28bb3b849b9b 100644
> > --- a/hw/ppc/spapr_vio.c
> > +++ b/hw/ppc/spapr_vio.c
> > @@ -22,6 +22,7 @@
> >  #include "qemu/osdep.h"
> >  #include "qemu/error-report.h"
> >  #include "qapi/error.h"
> > +#include "qapi/visitor.h"
> >  #include "hw/hw.h"
> >  #include "qemu/log.h"
> >  #include "sysemu/sysemu.h"
> > @@ -41,8 +42,24 @@
> > =20
> >  #include <libfdt.h>
> > =20
> > +static void spapr_vio_getset_irq(Object *obj, Visitor *v, const char *=
name,
> > +                              void *opaque, Error **errp)
> > +{
> > +    Property *prop =3D opaque;
> > +    uint32_t *ptr =3D qdev_get_prop_ptr(DEVICE(obj), prop);
> > +
> > +    warn_report(TYPE_VIO_SPAPR_DEVICE " '%s' property is deprecated", =
name);
> > +    visit_type_uint32(v, name, ptr, errp);
> > +}
> > +
> > +static const PropertyInfo spapr_vio_irq_propinfo =3D {
> > +    .name =3D "irq",
> > +    .get =3D spapr_vio_getset_irq,
> > +    .set =3D spapr_vio_getset_irq,
> > +};
> > +
> >  static Property spapr_vio_props[] =3D {
> > -    DEFINE_PROP_UINT32("irq", VIOsPAPRDevice, irq, 0), \
> > +    DEFINE_PROP("irq", VIOsPAPRDevice, irq, spapr_vio_irq_propinfo, ui=
nt32_t),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >   =20
>=20


--Sig_/+Io=cti=un6eRXQcBYJrPJz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlsXdiAACgkQcdTV5YIv
c9YAkQ//XtLf7nJeLmlNQ+Z3caQWnbND4+3JS6LmGq0Ld2Tr5Zi1a9H6ABPbd3CG
owuDUYgjX6nE1/BYtKD7uuI1mRlcgX/oy/LK7gP2VaEptcQTDd18aZvT8XNkKQp5
vUQuXZvkUggt3xHhCfg9MasNeWu5bc2V4sNjVN/wnBE5E7ET3ZRwuzZU+ucWS2Fy
Okk0GB4+/di8ffgN+Vm3ksz8K+CQKVO6tMrk9gQLzQs/Xqgx6gQAdWnCxCm4pb+R
YMM3LqWMXoVH7LLxgsswDAdY2qbuRrbjYGxGTPVNcOAKsAKElY+x4YtVwcAeL1Vu
GE8r94mq0pj5MUQqaflMR3xMIGam9dvPI+LJX/0EI1LV8KAUBuxzlEKQpQRwzlXd
7Fb3ilxwSgAO8oNH3J8oNRYMJPTwqeZL7UNV+aOCJqwS5zgSbQjABRN93NHHB/ud
UHeZtD2kzYuDrgEqf86+zlS8AdXeMP0/Y/rFYOHwBBFzzr9BgSqrFzEwJlWeuCYm
6JNRirthQ7vwSIns9G8+0opyOk2WKfJWJJ1GCaEamR7iqxjfXuew+mxgCenJMthU
4stHWCqCpe2YQmZQ3FWVi3xje9E6Xvp/cC/XvhRXePV29TMAxBnaJ9TUWl3SIsWG
NXE9lyHLkyyaSauPoZqllH0wAmQ26xb2OWx/BDyrY+RzBhaLOWE=
=MaDf
-----END PGP SIGNATURE-----

--Sig_/+Io=cti=un6eRXQcBYJrPJz--
