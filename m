Received: from eggs.gnu.org ([2001:4830:134:3::10]:33823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1daIsU-0002y8-6n
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:45:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1daIsP-0008RG-A6
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:45:14 -0400
Received: from 12.mo5.mail-out.ovh.net ([46.105.39.65]:59374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1daIsP-0008N9-2U
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:45:09 -0400
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id B43F9116CAE
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 11:45:02 +0200 (CEST)
Date: Wed, 26 Jul 2017 11:36:43 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170726113643.63fb2c89@bahia.lan>
In-Reply-To: <20170726040459.GT8978@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100557147.27487.5031800506520955290.stgit@bahia>
	<20170726040459.GT8978@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/hqvduljd0iR7PFG20tQXGhV";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [for-2.11 PATCH 07/26] spapr_drc: fix realize and
 unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

--Sig_/hqvduljd0iR7PFG20tQXGhV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Jul 2017 14:04:59 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Jul 25, 2017 at 07:59:31PM +0200, Greg Kurz wrote:
> > If object_property_add_alias() returns an error in realize(), we should
> > propagate it to the caller and certainly not unref the DRC.
> >=20
> > Same thing goes for unrealize(). Since object_property_del() is the last
> > call, we can even get rid of the intermediate Error *.
> >=20
> > And finally, unrealize() should undo all registrations performed by
> > realize().
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> I've applied this to ppc-for-2.11, but this looks like it could be a
> real bug fix.  So I'm wondering if I should push it for 2.10 (we're in
> hard freeze, but bugfixes can still be applied).
>=20

Yeah I guess it should also be merged in 2.10 but it has a dependency
with patch 4 (spapr_drc: use g_strdup_printf() instead  of snprintf()).
If you prefer, maybe I can repost this as a standalone fix for 2.10 ?

> > ---
> >  hw/ppc/spapr_drc.c |   15 ++++++---------
> >  1 file changed, 6 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > index e4e8383ec7b5..d72453bcb42f 100644
> > --- a/hw/ppc/spapr_drc.c
> > +++ b/hw/ppc/spapr_drc.c
> > @@ -506,12 +506,12 @@ static void realize(DeviceState *d, Error **errp)
> >      trace_spapr_drc_realize_child(spapr_drc_index(drc), child_name);
> >      object_property_add_alias(root_container, link_name,
> >                                drc->owner, child_name, &err);
> > +    g_free(child_name);
> >      g_free(link_name);
> >      if (err) {
> > -        error_report_err(err);
> > -        object_unref(OBJECT(drc));
> > +        error_propagate(errp, err);
> > +        return;
> >      }
> > -    g_free(child_name);
> >      vmstate_register(DEVICE(drc), spapr_drc_index(drc), &vmstate_spapr=
_drc,
> >                       drc);
> >      qemu_register_reset(drc_reset, drc);
> > @@ -523,17 +523,14 @@ static void unrealize(DeviceState *d, Error **err=
p)
> >      sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(d);
> >      Object *root_container;
> >      gchar *name;
> > -    Error *err =3D NULL;
> > =20
> >      trace_spapr_drc_unrealize(spapr_drc_index(drc));
> > +    qemu_unregister_reset(drc_reset, drc);
> > +    vmstate_unregister(DEVICE(drc), &vmstate_spapr_drc, drc);
> >      root_container =3D container_get(object_get_root(), DRC_CONTAINER_=
PATH);
> >      name =3D g_strdup_printf("%x", spapr_drc_index(drc));
> > -    object_property_del(root_container, name, &err);
> > +    object_property_del(root_container, name, errp);
> >      g_free(name);
> > -    if (err) {
> > -        error_report_err(err);
> > -        object_unref(OBJECT(drc));
> > -    }
> >  }
> > =20
> >  sPAPRDRConnector *spapr_dr_connector_new(Object *owner, const char *ty=
pe,
> >  =20
>=20


--Sig_/hqvduljd0iR7PFG20tQXGhV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAll4YqsACgkQAvw66wEB28Ju5wCfXAuvB6l18fgr6ew1Yc8E7ZTm
OmkAnRfpNbteqEZHXEdor90li6hOHeul
=6/i/
-----END PGP SIGNATURE-----

--Sig_/hqvduljd0iR7PFG20tQXGhV--
