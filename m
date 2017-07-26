Received: from eggs.gnu.org ([2001:4830:134:3::10]:34634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1daIwG-0004l8-V9
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1daIwC-0001CO-28
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:49:09 -0400
Received: from 15.mo5.mail-out.ovh.net ([178.33.107.29]:55834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1daIwB-0001Bt-Ro
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:49:03 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 06CDF116C5D
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 11:48:57 +0200 (CEST)
Date: Wed, 26 Jul 2017 11:48:46 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170726114846.6449ff78@bahia.lan>
In-Reply-To: <506fd8f5-15e1-8b24-a942-f59fa8f52312@ozlabs.ru>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100552078.27487.390170136970607382.stgit@bahia>
	<506fd8f5-15e1-8b24-a942-f59fa8f52312@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/lDpbnjfOOMi4+RKmkqzD1qm";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [for-2.11 PATCH 03/26] spapr_iommu: use
 g_strdup_printf() instead of snprintf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

--Sig_/lDpbnjfOOMi4+RKmkqzD1qm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Jul 2017 13:37:03 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 26/07/17 03:58, Greg Kurz wrote:
> > Passing a stack allocated buffer of arbitrary length to snprintf()
> > without checking the return value can cause the resultant strings
> > to be silently truncated. =20
>=20
> The strings it is touching cannot be silently truncated as
> "tce-iommu-XXXXXXXX" are shorter than 32 chars.
>=20

True but if the string was to be changed (unlikely, I admit) then we should
ensure the array is large enough. And anyway, this means we waste stack spa=
ce,
which is suboptimal. As noted by David, it is a common practice in QEMU to =
use
g_strdup_printf().

>=20
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/ppc/spapr_iommu.c |   13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> > index e614621a8317..740d42608b61 100644
> > --- a/hw/ppc/spapr_iommu.c
> > +++ b/hw/ppc/spapr_iommu.c
> > @@ -252,17 +252,19 @@ static int spapr_tce_table_realize(DeviceState *d=
ev)
> >  {
> >      sPAPRTCETable *tcet =3D SPAPR_TCE_TABLE(dev);
> >      Object *tcetobj =3D OBJECT(tcet);
> > -    char tmp[32];
> > +    gchar *tmp;
> > =20
> >      tcet->fd =3D -1;
> >      tcet->need_vfio =3D false;
> > -    snprintf(tmp, sizeof(tmp), "tce-root-%x", tcet->liobn);
> > +    tmp =3D g_strdup_printf("tce-root-%x", tcet->liobn);
> >      memory_region_init(&tcet->root, tcetobj, tmp, UINT64_MAX);
> > +    g_free(tmp);
> > =20
> > -    snprintf(tmp, sizeof(tmp), "tce-iommu-%x", tcet->liobn);
> > +    tmp =3D g_strdup_printf("tce-iommu-%x", tcet->liobn);
> >      memory_region_init_iommu(&tcet->iommu, sizeof(tcet->iommu),
> >                               TYPE_SPAPR_IOMMU_MEMORY_REGION,
> >                               tcetobj, tmp, 0);
> > +    g_free(tmp);
> > =20
> >      QLIST_INSERT_HEAD(&spapr_tce_tables, tcet, list);
> > =20
> > @@ -307,7 +309,7 @@ void spapr_tce_set_need_vfio(sPAPRTCETable *tcet, b=
ool need_vfio)
> >  sPAPRTCETable *spapr_tce_new_table(DeviceState *owner, uint32_t liobn)
> >  {
> >      sPAPRTCETable *tcet;
> > -    char tmp[32];
> > +    gchar *tmp;
> > =20
> >      if (spapr_tce_find_by_liobn(liobn)) {
> >          error_report("Attempted to create TCE table with duplicate"
> > @@ -318,8 +320,9 @@ sPAPRTCETable *spapr_tce_new_table(DeviceState *own=
er, uint32_t liobn)
> >      tcet =3D SPAPR_TCE_TABLE(object_new(TYPE_SPAPR_TCE_TABLE));
> >      tcet->liobn =3D liobn;
> > =20
> > -    snprintf(tmp, sizeof(tmp), "tce-table-%x", liobn);
> > +    tmp =3D g_strdup_printf("tce-table-%x", liobn);
> >      object_property_add_child(OBJECT(owner), tmp, OBJECT(tcet), NULL);
> > +    g_free(tmp);
> > =20
> >      object_property_set_bool(OBJECT(tcet), true, "realized", NULL);
> > =20
> >=20
> >  =20
>=20
>=20


--Sig_/lDpbnjfOOMi4+RKmkqzD1qm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAll4ZX4ACgkQAvw66wEB28KnDgCdHyW/q0Bi5XR5thpPYBZRJSdj
rN4AoJRMR79yvwpsDBgY5KkplYac5bGN
=Uj1c
-----END PGP SIGNATURE-----

--Sig_/lDpbnjfOOMi4+RKmkqzD1qm--
