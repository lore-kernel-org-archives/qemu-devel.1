Received: from eggs.gnu.org ([2001:4830:134:3::10]:56692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daDTe-0004ME-9a
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:59:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daDTb-0004AQ-9S
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:59:14 -0400
Date: Wed, 26 Jul 2017 13:58:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170726035838.GQ8978@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100553345.27487.10049014405920351882.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i13qRg9tmWEwo36p"
Content-Disposition: inline
In-Reply-To: <150100553345.27487.10049014405920351882.stgit@bahia>
Subject: Re: [Qemu-devel] [for-2.11 PATCH 04/26] spapr_drc: use
 g_strdup_printf() instead of snprintf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--i13qRg9tmWEwo36p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 07:58:53PM +0200, Greg Kurz wrote:
> Passing a stack allocated buffer of arbitrary length to snprintf()
> without checking the return value can cause the resultant strings
> to be silently truncated.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.11.

> ---
>  hw/ppc/spapr_drc.c |   15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 15bae5c216a9..e4e8383ec7b5 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -488,7 +488,7 @@ static void realize(DeviceState *d, Error **errp)
>  {
>      sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(d);
>      Object *root_container;
> -    char link_name[256];
> +    gchar *link_name;
>      gchar *child_name;
>      Error *err =3D NULL;
> =20
> @@ -501,11 +501,12 @@ static void realize(DeviceState *d, Error **errp)
>       * existing in the composition tree
>       */
>      root_container =3D container_get(object_get_root(), DRC_CONTAINER_PA=
TH);
> -    snprintf(link_name, sizeof(link_name), "%x", spapr_drc_index(drc));
> +    link_name =3D g_strdup_printf("%x", spapr_drc_index(drc));
>      child_name =3D object_get_canonical_path_component(OBJECT(drc));
>      trace_spapr_drc_realize_child(spapr_drc_index(drc), child_name);
>      object_property_add_alias(root_container, link_name,
>                                drc->owner, child_name, &err);
> +    g_free(link_name);
>      if (err) {
>          error_report_err(err);
>          object_unref(OBJECT(drc));
> @@ -521,13 +522,14 @@ static void unrealize(DeviceState *d, Error **errp)
>  {
>      sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(d);
>      Object *root_container;
> -    char name[256];
> +    gchar *name;
>      Error *err =3D NULL;
> =20
>      trace_spapr_drc_unrealize(spapr_drc_index(drc));
>      root_container =3D container_get(object_get_root(), DRC_CONTAINER_PA=
TH);
> -    snprintf(name, sizeof(name), "%x", spapr_drc_index(drc));
> +    name =3D g_strdup_printf("%x", spapr_drc_index(drc));
>      object_property_del(root_container, name, &err);
> +    g_free(name);
>      if (err) {
>          error_report_err(err);
>          object_unref(OBJECT(drc));
> @@ -729,10 +731,11 @@ static const TypeInfo spapr_drc_lmb_info =3D {
>  sPAPRDRConnector *spapr_drc_by_index(uint32_t index)
>  {
>      Object *obj;
> -    char name[256];
> +    gchar *name;
> =20
> -    snprintf(name, sizeof(name), "%s/%x", DRC_CONTAINER_PATH, index);
> +    name =3D g_strdup_printf("%s/%x", DRC_CONTAINER_PATH, index);
>      obj =3D object_resolve_path(name, NULL);
> +    g_free(name);
> =20
>      return !obj ? NULL : SPAPR_DR_CONNECTOR(obj);
>  }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--i13qRg9tmWEwo36p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll4E24ACgkQbDjKyiDZ
s5JUHw//aadNXudCLW5fdTwHm2RZ1Ii0khfmYM2ZOAheL9K9grGV9FzCJtkiRNfO
e37r24b3PbY0MLeYc1wqAISbdW5yuDyOIVSpvGQOra37oJeRMp7dUdSEnM8q1zQ5
LqR7Iww/82J+aFbE2B9WTuFOVUldA+8MZeBh2AneOYcMb0QsxnQN0E4+RWDkbp36
bRUebThBxZfjvjU5bQ5cPjrFfM6bglr1OPnltvSNxhHcNlf6qs9SRYV92xpJig4Y
jVORZupjSiS7OfOC3tc2A8DjC3LeNWRlNNxAjr1KKCO1zStETKx9rqaPvWwKD+Fv
AhPGOL/bstP14AtzNKYyFnEgzVMvrb1dG9jcqRRxbPTlTfqEmn9/daXIxU/kZYqK
EjmkINg0iM6SZC7Z9sApgbxcbFcUHp9dq4dPC+irwj+ovjGSB2EOxbVDKtkURkuf
O5DEU7JuL+ckrJfq+xXCjbmFFyLwiEdYQlqbNj9wwTHMhi3lZizIlkys+BM22q8a
0jP2AqQdwmMUugj2OENI3uzf2tc7PAlqzKHzD+fSYYSPdhA12K3Dai3IZ8TYndQn
Wf9Cj6hA3gi7s3alWFegr6AT0S6koHAqOVvkkt7h/MxBGYQS9tJ3Wo8b5GQhMzX5
QVuMyloijxp8GqqwAkY5WDsRVQ5wW4olIsYpF+pSekkcyN4sjTg=
=G7AR
-----END PGP SIGNATURE-----

--i13qRg9tmWEwo36p--
