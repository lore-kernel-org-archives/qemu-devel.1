Received: from eggs.gnu.org ([2001:4830:134:3::10]:37247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daa2F-00057q-Sf
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 00:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daa2E-0006Wl-I8
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 00:04:27 -0400
Date: Thu, 27 Jul 2017 13:44:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170727034402.GK8978@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100557147.27487.5031800506520955290.stgit@bahia>
	<20170726040459.GT8978@umbus.fritz.box>
	<20170726113643.63fb2c89@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YRGgq4HRInt36X2w"
Content-Disposition: inline
In-Reply-To: <20170726113643.63fb2c89@bahia.lan>
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
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--YRGgq4HRInt36X2w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2017 at 11:36:43AM +0200, Greg Kurz wrote:
> On Wed, 26 Jul 2017 14:04:59 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Tue, Jul 25, 2017 at 07:59:31PM +0200, Greg Kurz wrote:
> > > If object_property_add_alias() returns an error in realize(), we shou=
ld
> > > propagate it to the caller and certainly not unref the DRC.
> > >=20
> > > Same thing goes for unrealize(). Since object_property_del() is the l=
ast
> > > call, we can even get rid of the intermediate Error *.
> > >=20
> > > And finally, unrealize() should undo all registrations performed by
> > > realize().
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org> =20
> >=20
> > I've applied this to ppc-for-2.11, but this looks like it could be a
> > real bug fix.  So I'm wondering if I should push it for 2.10 (we're in
> > hard freeze, but bugfixes can still be applied).
> >=20
>=20
> Yeah I guess it should also be merged in 2.10 but it has a dependency
> with patch 4 (spapr_drc: use g_strdup_printf() instead  of snprintf()).
> If you prefer, maybe I can repost this as a standalone fix for 2.10
> ?

Yes, that would be helpful, thank you.

>=20
> > > ---
> > >  hw/ppc/spapr_drc.c |   15 ++++++---------
> > >  1 file changed, 6 insertions(+), 9 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > > index e4e8383ec7b5..d72453bcb42f 100644
> > > --- a/hw/ppc/spapr_drc.c
> > > +++ b/hw/ppc/spapr_drc.c
> > > @@ -506,12 +506,12 @@ static void realize(DeviceState *d, Error **err=
p)
> > >      trace_spapr_drc_realize_child(spapr_drc_index(drc), child_name);
> > >      object_property_add_alias(root_container, link_name,
> > >                                drc->owner, child_name, &err);
> > > +    g_free(child_name);
> > >      g_free(link_name);
> > >      if (err) {
> > > -        error_report_err(err);
> > > -        object_unref(OBJECT(drc));
> > > +        error_propagate(errp, err);
> > > +        return;
> > >      }
> > > -    g_free(child_name);
> > >      vmstate_register(DEVICE(drc), spapr_drc_index(drc), &vmstate_spa=
pr_drc,
> > >                       drc);
> > >      qemu_register_reset(drc_reset, drc);
> > > @@ -523,17 +523,14 @@ static void unrealize(DeviceState *d, Error **e=
rrp)
> > >      sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(d);
> > >      Object *root_container;
> > >      gchar *name;
> > > -    Error *err =3D NULL;
> > > =20
> > >      trace_spapr_drc_unrealize(spapr_drc_index(drc));
> > > +    qemu_unregister_reset(drc_reset, drc);
> > > +    vmstate_unregister(DEVICE(drc), &vmstate_spapr_drc, drc);
> > >      root_container =3D container_get(object_get_root(), DRC_CONTAINE=
R_PATH);
> > >      name =3D g_strdup_printf("%x", spapr_drc_index(drc));
> > > -    object_property_del(root_container, name, &err);
> > > +    object_property_del(root_container, name, errp);
> > >      g_free(name);
> > > -    if (err) {
> > > -        error_report_err(err);
> > > -        object_unref(OBJECT(drc));
> > > -    }
> > >  }
> > > =20
> > >  sPAPRDRConnector *spapr_dr_connector_new(Object *owner, const char *=
type,
> > >  =20
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YRGgq4HRInt36X2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll5YYIACgkQbDjKyiDZ
s5LZpQ//ceefHoOpJqutjwIwSvqfzQI36YvqemeCvUA/bhhr01muXA5c0WlJmpvM
RImLhSnMsIarLeolLBHMKoY9P6siOr8J19ip2miZ9Bf+Lurq4TMLeEyCJEURl4/N
a7ecbM62G+1299/na4mL1w9CFRInrQpY7K5sMeunEF1bO8xuzG0QMcVlnvIn1h3C
5PgTpOU8sPD080Nm1bs6AIpoogs7eSCR98mc9HcNcJ0PYg46d41xjjEOEdTcbHh+
objpwGYBK6p9QT1iKo3F489zfcEll4VfHEcF+uxJhrN6m8UkLEyPg9wIVb2JFsVD
hCLe4ophPM+qnto7YxoPEBZ43ucfxMzYblXrODepg6quwxM4kjn2GihQgmHQrbUw
j/xdncejWNJxkKZa3rULyOr9mes+GcOZTFUHrXuhWGWosPR0f0NjvH9juDQR8o+6
uFsyohzx9D9JkCWchVuX4ZJFzekVQgJDwD3l/26hAgupmmF6qP3E+srOigtOLXxP
LpaOUl240V5xlv0jDj1WbUXsnh8if631NB3XXl78K9gdIQXt221ImecnjvdkGbmc
nQ9L1UxEpoHUkTQjgAg3n4Z5oDISy5e6L1oj3AREHXQUIM0uZdFMkgoyqoOKatHc
ilwvz5J45TvK28P0WpURG0G0GczIcPoKqxcpIjUETcAcc6IIZ/M=
=+Nvc
-----END PGP SIGNATURE-----

--YRGgq4HRInt36X2w--
