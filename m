Received: from eggs.gnu.org ([2001:4830:134:3::10]:56178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dKngQ-0004zm-0e
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 11:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dKngM-0001gw-I7
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 11:24:42 -0400
Received: from 18.mo5.mail-out.ovh.net ([178.33.45.10]:34827)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dKngM-0001fT-BT
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 11:24:38 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 17FEC105F2D
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 17:24:35 +0200 (CEST)
Date: Tue, 13 Jun 2017 17:24:28 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170613172428.08dee7ea@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170613100146.GA13420@umbus>
References: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
	<149685584629.12025.14875914798241845062.stgit@bahia.lan>
	<20170608040857.GV13397@umbus.fritz.box>
	<20170608115410.2e7a2511@bahia.ttt.fr.ibm.com>
	<20170612142456.GJ18542@umbus>
	<20170613093359.4567ba94@bahia.ttt.fr.ibm.com>
	<20170613080631.GB30171@umbus>
	<20170613104003.233e21d5@bahia.ttt.fr.ibm.com>
	<20170613090002.GA2096@work-vm>
	<20170613112150.7f64171c@bahia.ttt.fr.ibm.com>
	<20170613100146.GA13420@umbus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/xvJjRSj0PTFCnTn8wZDL4p=";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v3 5/5] spapr: fix migration of ICPState
 objects from/to older QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, Juan Quintela <quintela@redhat.com>

--Sig_/xvJjRSj0PTFCnTn8wZDL4p=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Jun 2017 18:01:46 +0800
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Jun 13, 2017 at 11:21:50AM +0200, Greg Kurz wrote:
> > On Tue, 13 Jun 2017 10:00:03 +0100
> > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> >  =20
> > > * Greg Kurz (groug@kaod.org) wrote: =20
> > > > On Tue, 13 Jun 2017 16:06:31 +0800
> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > >    =20
> > > > > On Tue, Jun 13, 2017 at 09:33:59AM +0200, Greg Kurz wrote:   =20
> > > > [...]   =20
> > > > > > > > > > +static void pre_2_10_vmstate_register_dummy_icp(sPAPRM=
achineState *spapr, int i)
> > > > > > > > > > +{
> > > > > > > > > > +    bool *flag =3D &spapr->pre_2_10_ignore_icp[i];
> > > > > > > > > > +
> > > > > > > > > > +    g_assert(!*flag);         =20
> > > > > > > > >=20
> > > > > > > > > Apart from this assert(), you never seem to test the valu=
es in the
> > > > > > > > > pre_2_10_ignore_icp() array, so it seems a bit pointless.
> > > > > > > > >        =20
> > > > > > > >=20
> > > > > > > > There's the opposite check in pre_2_10_vmstate_unregister_d=
ummy_icp().
> > > > > > > > But I agree it isn't really useful... but more because of p=
aranoia :)       =20
> > > > > > >=20
> > > > > > > I'm all for paranoid assert()s if they can be made using data=
 readily
> > > > > > > to hand.  Adding a data structure just for the purpose of mak=
ing an
> > > > > > > assert() later, not so much.
> > > > > > >      =20
> > > > > >=20
> > > > > > It is also passed as opaque argument to vmstate_register(), whe=
re it is
> > > > > > used as a key when calling vmstate_unregister(). I could possib=
ly pass
> > > > > > (void *) i instead, but I'm not a big fan of hijacking pointer =
arguments
> > > > > > to pass numbers.     =20
> > > > >=20
> > > > > Ah, I see your point.  Creating an array, purely to generate arbi=
trary
> > > > > pointers is also kind of ugly, though.  Really the cpu_index / XI=
CS
> > > > > server number makes sense to identify the vmstate, but it looks l=
ike
> > > > > vmstate_unregister() doesn't take that.
> > > > >    =20
> > > >=20
> > > > Indeed... what about adding a vmstate_unregister_by_instance_id() t=
hen ?
> > > >=20
> > > > Cc'ing Juan and David.   =20
> > >=20
> > > So what's the problem with a (void *)i ? =20
> >=20
> > https://stackoverflow.com/questions/8618637/what-does-it-mean-to-conver=
t-int-to-void-or-vice-versa
> >  =20
> > > It's simple, as long as you're
> > > not actually using the opaque anywhere it's easy.
> > >  =20
> >=20
> > but as you say, since the opaque isn't used anywhere, it is probably
> > okay to pass (void *) i. =20
>=20
> Right, that's probably the right short term approach.
>=20

I'm currently heading towards (void *)(intptr_t) i

>=20
> Incidentally, for a somewhat safer-than-standard approach to this
> common problem, see https://ccodearchive.net/info/ptrint.html
>=20

Heh, your code :)

IIUC it is licensed under the terms of CC0, which I believe to be GPL
compatible. Why not using it in QEMU ?

--Sig_/xvJjRSj0PTFCnTn8wZDL4p=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllAA6wACgkQAvw66wEB28I16gCeNcEETJWCbRkaItjbLO5r0+Rq
groAn36w15seiAs1MO8DKNJZ0ffFgYNr
=AUQf
-----END PGP SIGNATURE-----

--Sig_/xvJjRSj0PTFCnTn8wZDL4p=--
