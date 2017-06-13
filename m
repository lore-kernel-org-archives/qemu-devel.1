Received: from eggs.gnu.org ([2001:4830:134:3::10]:39628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dKg2l-0002Ki-N1
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 03:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dKg2i-0005CP-Hs
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 03:15:15 -0400
Received: from 17.mo5.mail-out.ovh.net ([46.105.56.132]:44188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dKg2i-00056I-BS
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 03:15:12 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id B6693105CFD
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 09:15:02 +0200 (CEST)
Date: Tue, 13 Jun 2017 09:14:55 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170613091455.3f307990@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170612141546.GH18542@umbus>
References: <149692935202.12119.3614006195497745877.stgit@bahia>
	<149692939833.12119.5229563110691809599.stgit@bahia>
	<20170612141546.GH18542@umbus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/3OYybo+rKmN6zslidFMjOUT";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v4 5/6] xics: directly register ICPState
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

--Sig_/3OYybo+rKmN6zslidFMjOUT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Jun 2017 22:15:46 +0800
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Jun 08, 2017 at 03:43:18PM +0200, Greg Kurz wrote:
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
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> This is certainly an improvement.  You answered my query on the
> previous version as to why this doesn't break migration, but that
> information should go into the commit message.
>=20

I'll add this explanation to the changelog.

> So, ideally, we would use the XICS "server number" as the migration
> key.  That's an architected part of the XICs state, since those values
> are entered explicitly into the ICS.  We have a way to go from server
> number to ICP at the moment, but not the reverse, but we can fix that.
>=20
> Unfortunately I think those won't always match existing automatically
> generated IDs, which makes things harder.
>=20

Maybe things will get better when cpu_dt_id can be contiguous:

http://www.spinics.net/lists/kvm/msg150390.html

But I guess it won't help with existing machine types.

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


--Sig_/3OYybo+rKmN6zslidFMjOUT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlk/kO8ACgkQAvw66wEB28KblACggR5z7P0w1pqItQp8H76jx3+K
1xUAn3Dv7mi6SB5yEIZFoycHwJc7DNbM
=O2ap
-----END PGP SIGNATURE-----

--Sig_/3OYybo+rKmN6zslidFMjOUT--
