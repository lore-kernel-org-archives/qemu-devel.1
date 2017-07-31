Received: from eggs.gnu.org ([2001:4830:134:3::10]:55356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dc82U-0005Jj-QY
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dc82R-0005to-Md
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:35:06 -0400
Received: from 6.mo7.mail-out.ovh.net ([188.165.39.218]:35241)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dc82R-0005pP-Fo
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:35:03 -0400
Received: from player762.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id DDFC066FD3
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 12:34:54 +0200 (CEST)
Date: Mon, 31 Jul 2017 12:34:41 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170731123441.488afecf@bahia.lan>
In-Reply-To: <9a4c0fee-68b7-bf36-674a-2868b827f428@amsat.org>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100553345.27487.10049014405920351882.stgit@bahia>
	<20170726035838.GQ8978@umbus.fritz.box>
	<9a4c0fee-68b7-bf36-674a-2868b827f428@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/QJa=xA9_F3KWYX3Ho1=AxYc";
	protocol="application/pgp-signature"
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
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

--Sig_/QJa=xA9_F3KWYX3Ho1=AxYc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 31 Jul 2017 07:11:45 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Hi David,
>=20
> On 07/26/2017 12:58 AM, David Gibson wrote:
> > On Tue, Jul 25, 2017 at 07:58:53PM +0200, Greg Kurz wrote: =20
> >> Passing a stack allocated buffer of arbitrary length to snprintf()
> >> without checking the return value can cause the resultant strings
> >> to be silently truncated.
> >>
> >> Signed-off-by: Greg Kurz <groug@kaod.org> =20
> >=20
> > Applied to ppc-for-2.11. =20
>=20
> Isn't it 2.10 material?
>=20

Hi Philippe,

Well... this patch doesn't fix any bug actually since the stack buffers
are large enough. It is more a question of coding style.

Something like below would have been more appropriate I guess:

"Building strings with g_strdup_printf() is a QEMU common practice."

No big deal.

Cheers,

--
Greg

> Regards,
>=20
> Phil.
>=20
> >  =20
> >> ---
> >>   hw/ppc/spapr_drc.c |   15 +++++++++------
> >>   1 file changed, 9 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> >> index 15bae5c216a9..e4e8383ec7b5 100644
> >> --- a/hw/ppc/spapr_drc.c
> >> +++ b/hw/ppc/spapr_drc.c
> >> @@ -488,7 +488,7 @@ static void realize(DeviceState *d, Error **errp)
> >>   {
> >>       sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(d);
> >>       Object *root_container;
> >> -    char link_name[256];
> >> +    gchar *link_name;
> >>       gchar *child_name;
> >>       Error *err =3D NULL;
> >>  =20
> >> @@ -501,11 +501,12 @@ static void realize(DeviceState *d, Error **errp)
> >>        * existing in the composition tree
> >>        */
> >>       root_container =3D container_get(object_get_root(), DRC_CONTAINE=
R_PATH);
> >> -    snprintf(link_name, sizeof(link_name), "%x", spapr_drc_index(drc)=
);
> >> +    link_name =3D g_strdup_printf("%x", spapr_drc_index(drc));
> >>       child_name =3D object_get_canonical_path_component(OBJECT(drc));
> >>       trace_spapr_drc_realize_child(spapr_drc_index(drc), child_name);
> >>       object_property_add_alias(root_container, link_name,
> >>                                 drc->owner, child_name, &err);
> >> +    g_free(link_name);
> >>       if (err) {
> >>           error_report_err(err);
> >>           object_unref(OBJECT(drc));
> >> @@ -521,13 +522,14 @@ static void unrealize(DeviceState *d, Error **er=
rp)
> >>   {
> >>       sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(d);
> >>       Object *root_container;
> >> -    char name[256];
> >> +    gchar *name;
> >>       Error *err =3D NULL;
> >>  =20
> >>       trace_spapr_drc_unrealize(spapr_drc_index(drc));
> >>       root_container =3D container_get(object_get_root(), DRC_CONTAINE=
R_PATH);
> >> -    snprintf(name, sizeof(name), "%x", spapr_drc_index(drc));
> >> +    name =3D g_strdup_printf("%x", spapr_drc_index(drc));
> >>       object_property_del(root_container, name, &err);
> >> +    g_free(name);
> >>       if (err) {
> >>           error_report_err(err);
> >>           object_unref(OBJECT(drc));
> >> @@ -729,10 +731,11 @@ static const TypeInfo spapr_drc_lmb_info =3D {
> >>   sPAPRDRConnector *spapr_drc_by_index(uint32_t index)
> >>   {
> >>       Object *obj;
> >> -    char name[256];
> >> +    gchar *name;
> >>  =20
> >> -    snprintf(name, sizeof(name), "%s/%x", DRC_CONTAINER_PATH, index);
> >> +    name =3D g_strdup_printf("%s/%x", DRC_CONTAINER_PATH, index);
> >>       obj =3D object_resolve_path(name, NULL);
> >> +    g_free(name);
> >>  =20
> >>       return !obj ? NULL : SPAPR_DR_CONNECTOR(obj);
> >>   }
> >> =20
> >  =20


--Sig_/QJa=xA9_F3KWYX3Ho1=AxYc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAll/B8EACgkQAvw66wEB28IZDACgomrX8Hogq1xcc41Gn04S8y3c
3cgAn0gK2yLvVesz+VxqgcrWn7c96SLb
=G1kY
-----END PGP SIGNATURE-----

--Sig_/QJa=xA9_F3KWYX3Ho1=AxYc--
