Received: from eggs.gnu.org ([2001:4830:134:3::10]:57374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1db25P-0004FZ-OI
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 06:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1db25L-0004FT-JX
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 06:01:35 -0400
Received: from 9.mo7.mail-out.ovh.net ([46.105.60.248]:55542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1db25L-0004En-DR
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 06:01:31 -0400
Received: from player762.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id F147B669FE
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 12:01:29 +0200 (CEST)
Date: Fri, 28 Jul 2017 12:01:23 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170728120123.6077e1fb@bahia.lan>
In-Reply-To: <150118863714.22858.14396414884081097996@loki>
References: <150116311662.21142.16740109690791414399.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<150118863714.22858.14396414884081097996@loki>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/jQ_wD7ym.RT9wgOwztaTxCk";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [for-2.10 PATCH] spapr_drc: fix realize and
 unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

--Sig_/jQ_wD7ym.RT9wgOwztaTxCk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Jul 2017 15:50:37 -0500
Michael Roth <mdroth@linux.vnet.ibm.com> wrote:

> Quoting Greg Kurz (2017-07-27 08:45:47)
> > If object_property_add_alias() returns an error in realize(), we should
> > propagate it to the caller and certainly not unref the DRC. =20
>=20
> Indeed. I think that was the result of this part of the code
> originally living in spapr_dr_connector_new() during development,
> where it had previously made sense to free the object if there was a
> failure and then return NULL. We definitely shouldn't be during it
> now...
>=20
> >=20
> > Same thing goes for unrealize(). Since object_property_del() is the last
> > call, we can even get rid of the intermediate Error *.
> >=20
> > And finally, unrealize() should undo all registrations performed by
> > realize().
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >=20
> > David,
> >=20
> > As agreed on the list, here's the version of the fix for 2.10. I'll res=
pin
> > my PHB hotplug series on top of it.
> >=20
> > Cheers,
> >=20
> > --
> > Greg
> >=20
> >  hw/ppc/spapr_drc.c |   15 ++++++---------
> >  1 file changed, 6 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > index 15bae5c216a9..47d94e782ac2 100644
> > --- a/hw/ppc/spapr_drc.c
> > +++ b/hw/ppc/spapr_drc.c
> > @@ -506,11 +506,11 @@ static void realize(DeviceState *d, Error **errp)
> >      trace_spapr_drc_realize_child(spapr_drc_index(drc), child_name);
> >      object_property_add_alias(root_container, link_name,
> >                                drc->owner, child_name, &err);
> > +    g_free(child_name);
> >      if (err) {
> > -        error_report_err(err);
> > -        object_unref(OBJECT(drc));
> > +        error_propagate(errp, err);
> > +        return; =20
>=20
>=20
> Since spapr_dr_connector_new() calls realize() with errp =3D NULL, we

Yeah, there are a many of places in the code where we still pass a NULL
errp... :-\

> basically lose the error now. I think maybe we should at least report it
> still, but even better would be to have _new() call object_property_* with
> error_abort, since callers of spapr_dr_connector_new() don't all check
> for the return value and even if they did the appropriate action would
> always be to report+abort() anyway.
>=20

I agree.

> Looks good otherwise.
>=20
> >      }
> > -    g_free(child_name);
> >      vmstate_register(DEVICE(drc), spapr_drc_index(drc), &vmstate_spapr=
_drc,
> >                       drc);
> >      qemu_register_reset(drc_reset, drc);
> > @@ -522,16 +522,13 @@ static void unrealize(DeviceState *d, Error **err=
p)
> >      sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(d);
> >      Object *root_container;
> >      char name[256];
> > -    Error *err =3D NULL;
> >=20
> >      trace_spapr_drc_unrealize(spapr_drc_index(drc));
> > +    qemu_unregister_reset(drc_reset, drc);
> > +    vmstate_unregister(DEVICE(drc), &vmstate_spapr_drc, drc);
> >      root_container =3D container_get(object_get_root(), DRC_CONTAINER_=
PATH);
> >      snprintf(name, sizeof(name), "%x", spapr_drc_index(drc));
> > -    object_property_del(root_container, name, &err);
> > -    if (err) {
> > -        error_report_err(err);
> > -        object_unref(OBJECT(drc));
> > -    }
> > +    object_property_del(root_container, name, errp);
> >  }
> >=20
> >  sPAPRDRConnector *spapr_dr_connector_new(Object *owner, const char *ty=
pe,
> >=20
> >  =20
>=20


--Sig_/jQ_wD7ym.RT9wgOwztaTxCk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAll7C3MACgkQAvw66wEB28IOfACbBtTa05fMejJK68xL8XuxVWgG
g4oAoIj4kTkhJdBntD0gsib3KEf6zgOp
=OdyH
-----END PGP SIGNATURE-----

--Sig_/jQ_wD7ym.RT9wgOwztaTxCk--
