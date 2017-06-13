Received: from eggs.gnu.org ([2001:4830:134:3::10]:33379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dKii8-00066V-Ou
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:06:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dKii3-00080U-Pa
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:06:08 -0400
Received: from 12.mo5.mail-out.ovh.net ([46.105.39.65]:52699)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dKii3-00080E-FW
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:06:03 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 00100106270
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 12:06:01 +0200 (CEST)
Date: Tue, 13 Jun 2017 12:05:52 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170613120552.44c1c58e@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170613095549.GC2096@work-vm>
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
	<20170613095549.GC2096@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/URMkHxCtLo1JPgkVbz5wuUl";
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, Juan Quintela <quintela@redhat.com>

--Sig_/URMkHxCtLo1JPgkVbz5wuUl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Jun 2017 10:55:50 +0100
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Greg Kurz (groug@kaod.org) wrote:
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
> > =20
> > > It's simple, as long as you're
> > > not actually using the opaque anywhere it's easy.
> > >  =20
> >=20
> > but as you say, since the opaque isn't used anywhere, it is probably
> > okay to pass (void *) i. =20
>=20
> Yes, I don't think we're ever casting back from the (void *) to an int
> so it feels pretty safe to me.
>=20

Just one nit, gcc doesn't like it on 64-bit hosts:

hw/ppc/spapr.c: In function =E2=80=98pre_2_10_vmstate_register_dummy_icp=E2=
=80=99:
hw/ppc/spapr.c:148:60: error: cast to pointer from integer of different
 size [-Werror=3Dint-to-pointer-cast]
     vmstate_register(NULL, i, &pre_2_10_vmstate_dummy_icp, (void *) i);

I need to cast to (long) first.

> >  =20
> > > Note from a quick glance at your patch;  will this work migrating
> > > from this 2.10 -> 2.9 ?  Are your dummy vmstate's really good enough =
for
> > > the 2.9 ?
> > >  =20
> >=20
> > Yeah but I need to add some comments as David suggested.
> >=20
> > The idea is that 2.9 used to create a bunch of objects at machine init,
> > that only get used when CPUs are plugged. With 2.10, these objects are
> > now created under the CPUs. When migrating from 2.10 to 2.9, we only ne=
ed
> > to send the real objects. The dummy vmstate entries don't send anything
> > (.needed always returns false) since the corresponding objects in 2.9 a=
ren't
> > being used and still have their default state.
> >  =20
>=20
> OK, that'll probably work.
>=20

Thanks for this confirmation.

> Dave
>=20
> > > Dave
> > >=20
> > >  =20
> > > > --
> > > > Greg   =20
> > >=20
> > >=20
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK =20
> >  =20
>=20
>=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


--Sig_/URMkHxCtLo1JPgkVbz5wuUl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEUEARECAAYFAlk/uQAACgkQAvw66wEB28LudwCfYBu9TLC7goHIQYb/7+LzyOUm
ifwAlAwPQQSlwy9k54firvadq8xPi4o=
=u2ZP
-----END PGP SIGNATURE-----

--Sig_/URMkHxCtLo1JPgkVbz5wuUl--
