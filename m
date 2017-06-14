Received: from eggs.gnu.org ([2001:4830:134:3::10]:44629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dL8zA-0005ad-QI
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dL8z5-0003Ux-Rd
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:09:28 -0400
Received: from 7.mo5.mail-out.ovh.net ([178.32.124.100]:42047)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dL8z5-0003UK-LV
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:09:23 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id D21FC1064E8
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 16:09:21 +0200 (CEST)
Date: Wed, 14 Jun 2017 16:09:13 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170614160913.1adce952@bahia.ttt.fr.ibm.com>
In-Reply-To: <73052dd1-21df-9f2b-7c7f-ff90860473b8@redhat.com>
References: <149744692318.5507.14451686460325895979.stgit@bahia.lan>
	<149744695027.5507.7049830187351447969.stgit@bahia.lan>
	<73052dd1-21df-9f2b-7c7f-ff90860473b8@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/IMGOc8RKah6LpiPX=uBLc3z";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v5 2/3] xics: directly register ICPState
 objects to vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, "Dr. David Alan
	Gilbert" <dgilbert@redhat.com>

--Sig_/IMGOc8RKah6LpiPX=uBLc3z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Jun 2017 16:04:12 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> On 14/06/2017 15:29, Greg Kurz wrote:
> > The ICPState objects are currently registered to vmstate as qdev object=
s.
> > Their instance ids are hence computed automatically in the migration co=
de,
> > and thus depends on the order the CPU cores were plugged.
> >=20
> > If the destination had its CPU cores plugged in a different order than =
the
> > source, then ICPState objects will have different instance_ids and load
> > the wrong state.
> >=20
> > Since CPU objects have a reliable cpu_index which is already used as
> > instance_id in vmstate, let's use it for ICPState as well.
> >=20
> > Please note that this doesn't break migration. Older machine types used=
 to
> > allocate and realize all ICPState objects at machine init time, for the=
 whole
> > lifetime of the machine. The qdev instance ids are thus 0,1,2... nr_ser=
vers
> > and happen to map to the vCPU indexes.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
>=20
> CC: dgilbert
>=20

Oops, I had planned to Cc: dgilbert and I fumbled just before the
goal... of course. :P

Thanks Laurent !

> > ---
> > v5: - explain why it doesn't break migration in the changelog
> > ---
> >  hw/intc/xics.c |    5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> > index 7ccfb53c55a0..faa5c631f655 100644
> > --- a/hw/intc/xics.c
> > +++ b/hw/intc/xics.c
> > @@ -344,10 +344,14 @@ static void icp_realize(DeviceState *dev, Error *=
*errp)
> >      }
> > =20
> >      qemu_register_reset(icp_reset, dev);
> > +    vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, ic=
p);
> >  }
> > =20
> >  static void icp_unrealize(DeviceState *dev, Error **errp)
> >  {
> > +    ICPState *icp =3D ICP(dev);
> > +
> > +    vmstate_unregister(NULL, &vmstate_icp_server, icp);
> >      qemu_unregister_reset(icp_reset, dev);
> >  }
> > =20
> > @@ -355,7 +359,6 @@ static void icp_class_init(ObjectClass *klass, void=
 *data)
> >  {
> >      DeviceClass *dc =3D DEVICE_CLASS(klass);
> > =20
> > -    dc->vmsd =3D &vmstate_icp_server;
> >      dc->realize =3D icp_realize;
> >      dc->unrealize =3D icp_unrealize;
> >  }
> >  =20
>=20


--Sig_/IMGOc8RKah6LpiPX=uBLc3z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllBQ4kACgkQAvw66wEB28I3xgCfW6RUDqVZj2DUZvDAhEmfLzl+
Xp8An35/ts2Lh1evsCBbT+/Ea9EYproK
=kDiN
-----END PGP SIGNATURE-----

--Sig_/IMGOc8RKah6LpiPX=uBLc3z--
