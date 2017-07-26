Received: from eggs.gnu.org ([2001:4830:134:3::10]:56670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daDTd-0004Lu-0R
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daDTb-0004Am-LP
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:59:13 -0400
Date: Wed, 26 Jul 2017 13:57:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170726035750.GP8978@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100552078.27487.390170136970607382.stgit@bahia>
	<506fd8f5-15e1-8b24-a942-f59fa8f52312@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nLMor0SRtNCuLS/8"
Content-Disposition: inline
In-Reply-To: <506fd8f5-15e1-8b24-a942-f59fa8f52312@ozlabs.ru>
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
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--nLMor0SRtNCuLS/8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2017 at 01:37:03PM +1000, Alexey Kardashevskiy wrote:
> On 26/07/17 03:58, Greg Kurz wrote:
> > Passing a stack allocated buffer of arbitrary length to snprintf()
> > without checking the return value can cause the resultant strings
> > to be silently truncated.
>=20
> The strings it is touching cannot be silently truncated as
> "tce-iommu-XXXXXXXX" are shorter than 32 chars.

That's true.  But I think using strdup_printf() is more in keeping
with qemu common practice, so I've applied this to ppc-for-2.11.

>=20
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
> >=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nLMor0SRtNCuLS/8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll4Ez4ACgkQbDjKyiDZ
s5JkNBAAyO4yQhOXMSw2ssU+EzFgl7WKQgQksa3bvKPnuV8Qu0rfePVhqSHaMZF/
rFpXnZmku/4gscVNGQ8/I+ObjyGbC3jUmaZVpHyr8OMoCKjcgecpi92V2ryiSS6c
UPvrw6wfgzZxIc4EORvHD8Oda8214rH7T3iB6ZKA7lRMPreKCpmkIkOyTw8jhkZM
pjry61Qfwi8cEhPKI05KipswyOmyeCU3KQDZZaZLtOwu72YXPnrH2RWOFM0xQoom
T19gv29drL6Mn3R102rrQLAbpKXZj2+TCOWB53PQ98xdRjvtQeTebvD9NbyFkGhR
ZniaWagv10u1NbNDODexHt20055T8Qq8WVcxMbT5k60ojn2WAwqQ+WXjwsmNdjhA
izw+Rm1JtgHLFcbTmfAL8cDEUVpQ7u5v0MWcf3FfiDWMyhP+BN+rrBVQ1qSmKvNs
wPDM3RksamPkJfVgnX4a74FWY7P1p4ZANSQKHC3MnbIQpY++65q3dOTBlD02/NiN
sW7lC/f3Dmh4hRAbQW+ecYWo16mUvxNzWPSERjY496prM7gBb3IyY0uM+Z4V0Qom
dDSWoUtiW4Jj6a2/RsD3wHz/JQf2Ef4yKzCz8fcyz3GPR8CtguU4XAk3pFl2aleC
u5gfh2HUlIeoaiHsM7ElyGvk3xH3bwvd9WsWhUd+L6TJj1yzG8s=
=SI58
-----END PGP SIGNATURE-----

--nLMor0SRtNCuLS/8--
