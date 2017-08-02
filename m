Received: from eggs.gnu.org ([2001:4830:134:3::10]:35884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dcoo9-0007ry-1e
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 04:15:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dcoo5-00044Z-Qu
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 04:15:09 -0400
Received: from 7.mo178.mail-out.ovh.net ([46.105.58.91]:49841)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dcoo5-00043T-Iw
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 04:15:05 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id A56E84B241
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 10:15:03 +0200 (CEST)
Date: Wed, 2 Aug 2017 10:14:56 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170802101456.2a036225@bahia.lan>
In-Reply-To: <20170728042745.GM3098@umbus.fritz.box>
References: <150116311662.21142.16740109690791414399.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<150118863714.22858.14396414884081097996@loki>
	<20170728042745.GM3098@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/zH0irstaAU8W/oCvn2cMig6";
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

--Sig_/zH0irstaAU8W/oCvn2cMig6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Jul 2017 14:27:45 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Jul 27, 2017 at 03:50:37PM -0500, Michael Roth wrote:
> > Quoting Greg Kurz (2017-07-27 08:45:47) =20
> > > If object_property_add_alias() returns an error in realize(), we shou=
ld
> > > propagate it to the caller and certainly not unref the DRC. =20
> >=20
> > Indeed. I think that was the result of this part of the code
> > originally living in spapr_dr_connector_new() during development,
> > where it had previously made sense to free the object if there was a
> > failure and then return NULL. We definitely shouldn't be during it
> > now... =20
>=20
> Yes, I think that's right.
>=20
> I've applied this fix to ppc-for-2.10.
>=20
> >  =20
> > >=20
> > > Same thing goes for unrealize(). Since object_property_del() is the l=
ast
> > > call, we can even get rid of the intermediate Error *.
> > >=20
> > > And finally, unrealize() should undo all registrations performed by
> > > realize().
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >=20
> > > David,
> > >=20
> > > As agreed on the list, here's the version of the fix for 2.10. I'll r=
espin
> > > my PHB hotplug series on top of it.
> > >  =20
> >=20
> >=20
> > Since spapr_dr_connector_new() calls realize() with errp =3D NULL, we
> > basically lose the error now. I think maybe we should at least report it
> > still, but even better would be to have _new() call object_property_* w=
ith
> > error_abort, since callers of spapr_dr_connector_new() don't all check
> > for the return value and even if they did the appropriate action would
> > always be to report+abort() anyway. =20
>=20
> I agree.  Well, except I think it should be &error_fatal, not
> &error_abort.  But that can be a follow up patch.
>=20

Hmmm... when we'll hotplug a PHB, an error during the realization of
a PCI DRC would then terminate QEMU. I'd rather add an errp argument
to spapr_dr_connector_new() and propagate the error instead.

> >=20
> > Looks good otherwise.
> >  =20
> > >      }
> > > -    g_free(child_name);
> > >      vmstate_register(DEVICE(drc), spapr_drc_index(drc), &vmstate_spa=
pr_drc,
> > >                       drc);
> > >      qemu_register_reset(drc_reset, drc);
> > > @@ -522,16 +522,13 @@ static void unrealize(DeviceState *d, Error **e=
rrp)
> > >      sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(d);
> > >      Object *root_container;
> > >      char name[256];
> > > -    Error *err =3D NULL;
> > >=20
> > >      trace_spapr_drc_unrealize(spapr_drc_index(drc));
> > > +    qemu_unregister_reset(drc_reset, drc);
> > > +    vmstate_unregister(DEVICE(drc), &vmstate_spapr_drc, drc);
> > >      root_container =3D container_get(object_get_root(), DRC_CONTAINE=
R_PATH);
> > >      snprintf(name, sizeof(name), "%x", spapr_drc_index(drc));
> > > -    object_property_del(root_container, name, &err);
> > > -    if (err) {
> > > -        error_report_err(err);
> > > -        object_unref(OBJECT(drc));
> > > -    }
> > > +    object_property_del(root_container, name, errp);
> > >  }
> > >=20
> > >  sPAPRDRConnector *spapr_dr_connector_new(Object *owner, const char *=
type,
> > >=20
> > >  =20
> >  =20
>=20


--Sig_/zH0irstaAU8W/oCvn2cMig6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmBigAACgkQAvw66wEB28J9+QCfY/iz2U0a66Wg11kWNa7s193n
a+cAnA2XnQndix6t57ISMj4wx3LOJG8P
=h56s
-----END PGP SIGNATURE-----

--Sig_/zH0irstaAU8W/oCvn2cMig6--
