Received: from eggs.gnu.org ([2001:4830:134:3::10]:58101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dayFn-0007ph-NB
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dayFl-00036a-39
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:56:03 -0400
Date: Fri, 28 Jul 2017 14:27:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170728042745.GM3098@umbus.fritz.box>
References: <150116311662.21142.16740109690791414399.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<150118863714.22858.14396414884081097996@loki>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="I4g3zIzscEHdx6fd"
Content-Disposition: inline
In-Reply-To: <150118863714.22858.14396414884081097996@loki>
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
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--I4g3zIzscEHdx6fd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2017 at 03:50:37PM -0500, Michael Roth wrote:
> Quoting Greg Kurz (2017-07-27 08:45:47)
> > If object_property_add_alias() returns an error in realize(), we should
> > propagate it to the caller and certainly not unref the DRC.
>=20
> Indeed. I think that was the result of this part of the code
> originally living in spapr_dr_connector_new() during development,
> where it had previously made sense to free the object if there was a
> failure and then return NULL. We definitely shouldn't be during it
> now...

Yes, I think that's right.

I've applied this fix to ppc-for-2.10.

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
>=20
>=20
> Since spapr_dr_connector_new() calls realize() with errp =3D NULL, we
> basically lose the error now. I think maybe we should at least report it
> still, but even better would be to have _new() call object_property_* with
> error_abort, since callers of spapr_dr_connector_new() don't all check
> for the return value and even if they did the appropriate action would
> always be to report+abort() anyway.

I agree.  Well, except I think it should be &error_fatal, not
&error_abort.  But that can be a follow up patch.

>=20
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
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--I4g3zIzscEHdx6fd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll6vUEACgkQbDjKyiDZ
s5LP1RAAp2JJzcEvRxiCgo2QHYXeFob9mtHJy8P4y6CTzap5PqpF9tpmkWaN31k5
SiMHeI8MPe1VlzDBCJ3fA9rKFTYgKEWR+zWYVQ8JLAXW9U7ARCK4sko+cm+f7JmW
wyodgYhn8eagwOgxj/+htLQSEBr0mPutZ07zH1XsqOKhVv5D4EnAFttLxtKPSmhd
3hLVfzoNgzX5AiBFt9QkkiPqlsXdrob5238SA/LS037Lr5zD1txyXFPPigSKDZuD
i7GZezy0MbNypGAq67sCP5nxSljhKdyBljYLHPEnuYUbdWKZutqC44v15EWF+IKD
X13FciV5Qyy73k1knMekaAqpwOjqKn48GexM5mRTatimneHtyBEXdtk/+TehReMP
NoKHsLWKcYwxyqX8H0Qrjt2u/r7ao0G1aOvpH1GPci+jnyaDbQUMkagE/5wTOgTu
CnfpmKZfLy9UFwTQ9pNVmYnpxB46gDV+zAuLJ3o7QBP0ymF7YF6Afkd8FwTtHC3P
gM5DsmeEVjgalCrUnOlzVafjoPFxCnn/vwDVbVwTBXOxpyElKKAByAhYHlwFKskJ
zVqMQXqA3D0u02EuSDpsS55ikvoTaaiK8knPQH1E144JV+0PMZUf0ks7V49aJXQ0
XumdpXoOscsz1mSqQv6xs2wLDRQh7BjaZWYQxuiy8D2Oajiq+7g=
=iANn
-----END PGP SIGNATURE-----

--I4g3zIzscEHdx6fd--
