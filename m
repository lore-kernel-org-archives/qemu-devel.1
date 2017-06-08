Received: from eggs.gnu.org ([2001:4830:134:3::10]:60212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dItRA-0001ef-1y
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 05:09:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dItR6-0004yY-U7
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 05:09:04 -0400
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:53259)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dItR6-0004wv-Np
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 05:09:00 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 157153CD51
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 11:08:59 +0200 (CEST)
Date: Thu, 8 Jun 2017 11:08:53 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170608110853.115fa1f8@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170608035921.GU13397@umbus.fritz.box>
References: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
	<149685583778.12025.272004316108066026.stgit@bahia.lan>
	<20170608035921.GU13397@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/HBkBL8G2=_svYkit1F=rMFM";
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>

--Sig_/HBkBL8G2=_svYkit1F=rMFM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 8 Jun 2017 13:59:21 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Jun 07, 2017 at 07:17:17PM +0200, Greg Kurz wrote:
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
> >  1 file changed, 4 insertions(+), 1 deletion(-) =20
>=20
> So, this is definitely a good idea w.r.t. future compatibility.  But,
> won't it break migration compat as a once off, since the devices will
> be found under their new id instead of the qdev id?
>=20

Older machine types used to allocate/realize all ICPState objects
at machine init time and never release them. The qdev ids are thus
0,1,2... nr_servers and happen to map to cpu_index.

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


--Sig_/HBkBL8G2=_svYkit1F=rMFM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlk5FCUACgkQAvw66wEB28LUnQCgp7VueUgyQMZ39QzSlbQ88tl0
MVYAn2Dk6WctNHBHTcNXWwPBrMUzT+5b
=PRHc
-----END PGP SIGNATURE-----

--Sig_/HBkBL8G2=_svYkit1F=rMFM--
