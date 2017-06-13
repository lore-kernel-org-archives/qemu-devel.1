Received: from eggs.gnu.org ([2001:4830:134:3::10]:41214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dKjB2-0007qN-5Z
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dKjAz-0001rc-0v
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:36:00 -0400
Received: from 14.mo5.mail-out.ovh.net ([188.165.51.82]:56668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dKjAy-0001r7-N9
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:35:56 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 21D08106257
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 12:35:54 +0200 (CEST)
Date: Tue, 13 Jun 2017 12:35:46 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170613123546.3b8ae326@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170613101217.GD2096@work-vm>
References: <20170608040857.GV13397@umbus.fritz.box>
	<20170608115410.2e7a2511@bahia.ttt.fr.ibm.com>
	<20170612142456.GJ18542@umbus>
	<20170613093359.4567ba94@bahia.ttt.fr.ibm.com>
	<20170613080631.GB30171@umbus>
	<20170613104003.233e21d5@bahia.ttt.fr.ibm.com>
	<20170613090002.GA2096@work-vm>
	<20170613112150.7f64171c@bahia.ttt.fr.ibm.com>
	<20170613095549.GC2096@work-vm>
	<20170613120552.44c1c58e@bahia.ttt.fr.ibm.com>
	<20170613101217.GD2096@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/=37o+Bn5GGuXeSOF=RkuSR+";
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

--Sig_/=37o+Bn5GGuXeSOF=RkuSR+
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Jun 2017 11:12:17 +0100
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
[...]
> > > > >=20
> > > > > So what's the problem with a (void *)i ?   =20
> > > >=20
> > > > https://stackoverflow.com/questions/8618637/what-does-it-mean-to-co=
nvert-int-to-void-or-vice-versa
> > > >   =20
> > > > > It's simple, as long as you're
> > > > > not actually using the opaque anywhere it's easy.
> > > > >    =20
> > > >=20
> > > > but as you say, since the opaque isn't used anywhere, it is probably
> > > > okay to pass (void *) i.   =20
> > >=20
> > > Yes, I don't think we're ever casting back from the (void *) to an int
> > > so it feels pretty safe to me.
> > >  =20
> >=20
> > Just one nit, gcc doesn't like it on 64-bit hosts:
> >=20
> > hw/ppc/spapr.c: In function =E2=80=98pre_2_10_vmstate_register_dummy_ic=
p=E2=80=99:
> > hw/ppc/spapr.c:148:60: error: cast to pointer from integer of different
> >  size [-Werror=3Dint-to-pointer-cast]
> >      vmstate_register(NULL, i, &pre_2_10_vmstate_dummy_icp, (void *) i);
> >=20
> > I need to cast to (long) first. =20
>=20
> Try casting to a uintptr_t first.
>=20

Yeah, you're right. The standard doesn't guarantees whether pointers
have the size of int or long. I'll use intptr_t.

Thanks for the suggestion.

> Dave
>=20
> > > >    =20
> > > > > Note from a quick glance at your patch;  will this work migrating
> > > > > from this 2.10 -> 2.9 ?  Are your dummy vmstate's really good eno=
ugh for
> > > > > the 2.9 ?
> > > > >    =20
> > > >=20
> > > > Yeah but I need to add some comments as David suggested.
> > > >=20
> > > > The idea is that 2.9 used to create a bunch of objects at machine i=
nit,
> > > > that only get used when CPUs are plugged. With 2.10, these objects =
are
> > > > now created under the CPUs. When migrating from 2.10 to 2.9, we onl=
y need
> > > > to send the real objects. The dummy vmstate entries don't send anyt=
hing
> > > > (.needed always returns false) since the corresponding objects in 2=
.9 aren't
> > > > being used and still have their default state.
> > > >    =20
> > >=20
> > > OK, that'll probably work.
> > >  =20
> >=20
> > Thanks for this confirmation.
> >  =20
> > > Dave
> > >  =20
> > > > > Dave
> > > > >=20
> > > > >    =20
> > > > > > --
> > > > > > Greg     =20
> > > > >=20
> > > > >=20
> > > > > --
> > > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK   =
=20
> > > >    =20
> > >=20
> > >=20
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK =20
> >  =20
>=20
>=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


--Sig_/=37o+Bn5GGuXeSOF=RkuSR+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlk/wAMACgkQAvw66wEB28KI0wCfcqfE6g3ow09K0Lrn++qDjWDl
2V0AniW8hxgcANq8G6XV9GP7dTbcJsTd
=6nZE
-----END PGP SIGNATURE-----

--Sig_/=37o+Bn5GGuXeSOF=RkuSR+--
