Received: from eggs.gnu.org ([2001:4830:134:3::10]:41612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIi0L-0008JG-Vj
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 16:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIi0H-0004XA-4K
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 16:56:38 -0400
Received: from 3.mo178.mail-out.ovh.net ([46.105.44.197]:41280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dIi0G-0004Wr-TM
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 16:56:33 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 698A73E0BF
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 22:56:31 +0200 (CEST)
Date: Wed, 7 Jun 2017 22:56:27 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170607225627.0929223c@bahia.ttt.fr.ibm.com>
In-Reply-To: <2f1659c4-0bad-a3d1-91fc-a0a802f21fa5@kaod.org>
References: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
	<149685583778.12025.272004316108066026.stgit@bahia.lan>
	<2f1659c4-0bad-a3d1-91fc-a0a802f21fa5@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/lyNn1MlCEYJhvtTISeOvxsh";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v3 4/5] xics: directly register ICPState
 objects to vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

--Sig_/lyNn1MlCEYJhvtTISeOvxsh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 7 Jun 2017 20:14:01 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 06/07/2017 07:17 PM, Greg Kurz wrote:
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
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/intc/xics.c |    5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> > index 330441ff7fe8..3d76b43876c5 100644
> > --- a/hw/intc/xics.c
> > +++ b/hw/intc/xics.c
> > @@ -348,10 +348,14 @@ static void icp_realize(DeviceState *dev, Error *=
*errp)
> >      }
> > =20
> >      qemu_register_reset(icp_reset, dev);
> > +    vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, ic=
p); =20
>=20
> so, what I just said in the previous email regarding ->cs would break thi=
s=20
> patch. Forget about it.=20
>=20

Unless we have an icp->cpu_index like I mentioned in the other mail.

>=20
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> Thanks,
>=20
> C.
>=20
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
> > @@ -359,7 +363,6 @@ static void icp_class_init(ObjectClass *klass, void=
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


--Sig_/lyNn1MlCEYJhvtTISeOvxsh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlk4aHsACgkQAvw66wEB28LBpgCfRlp0ULIUTmZFsFdPugJ4mmAz
lp0AnRNVjYGHvL4Dca5JUI2tG1pTi2Ub
=jCDy
-----END PGP SIGNATURE-----

--Sig_/lyNn1MlCEYJhvtTISeOvxsh--
