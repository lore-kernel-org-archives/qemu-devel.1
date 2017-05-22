Received: from eggs.gnu.org ([2001:4830:134:3::10]:47965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dCosr-0008E4-GW
	for qemu-devel@nongnu.org; Mon, 22 May 2017 11:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dCosl-0005Wk-R2
	for qemu-devel@nongnu.org; Mon, 22 May 2017 11:04:33 -0400
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:41395)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dCosl-0005Vx-KW
	for qemu-devel@nongnu.org; Mon, 22 May 2017 11:04:27 -0400
Received: from player690.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 506C33DD5E
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 17:04:25 +0200 (CEST)
Date: Mon, 22 May 2017 17:04:16 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170522170416.594d070b@bahia.lan>
In-Reply-To: <20170522091536.GO30246@umbus.fritz.box>
References: <149518991537.24289.6673616934370284758.stgit@bahia.lan>
	<149518994738.24289.215239362416048889.stgit@bahia.lan>
	<20170522023039.GH30246@umbus.fritz.box>
	<dad9039d-1b4c-be7f-bc49-c485b25632fa@kaod.org>
	<20170522091536.GO30246@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/roG_rRa6LMwU33ep_wA1iib";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2 4/4] spapr: fix migration of ICP objects
 from/to older QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>

--Sig_/roG_rRa6LMwU33ep_wA1iib
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 22 May 2017 19:15:36 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:
[...]
> > >=20
> > > Hrm.  I dislike code for the core object directly reaching into the
> > > machine to check the compat flag here (and a bunch of other places
> > > below).  I can think of a few possible ways of avoiding this:
> > >=20
> > > 1) The most direct is to make another compat flag in the cpu core
> > > object, set by the machine.  Straightforward, but ugly.
> > >=20
> > > 2) Use a property to optionally pass a reference to the ICP array into
> > > the core object.  If set it will give the cpu objects ICPs from that
> > > array (compat mode), if not it will allocate them (new style mode). =
=20
> >=20
> > for 2) we can just use a object_property_add_const_link() like
> > we do to pass the 'xics' object which is needed by the ICSes. =20
>=20
> Yes.  Though you'll need to pass one for each thread down to the core
> object, which will be fiddly.
>=20
> > > 3) (Preferred, if it works)  Always have the core allocate ICPs for
> > > each CPU.  For compat mode instead of directly allocating ICPs, the
> > > machine sets up an array of pointers to the existing ICPs for each
> > > CPU.  The "extra" slots that don't have ICPs in new-style allocation
> > > get references to dummy ICP objects (maybe even all the same one).
> > > Only the dummy ICP(s) are allocated by the machine, the rest remain
> > > owned by the cpu. =20
> >=20
> > I like this solution too as it should isolate the compat handling under
> > the machine, maybe even in a single routine. =20
>=20
> Right, that's the hope.  Plus it means we reduce the difference in
> runtime QOM structure between the two modes, which is best when
> possible.
>=20

I'll try to do 3)

--Sig_/roG_rRa6LMwU33ep_wA1iib
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlki/fAACgkQAvw66wEB28JfsQCgj1Hty30478e/VaNp5VAXwoVz
E1cAnjiFTEMUVwncJFZp1Eg4jC+RaYKE
=xetX
-----END PGP SIGNATURE-----

--Sig_/roG_rRa6LMwU33ep_wA1iib--
