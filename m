Received: from eggs.gnu.org ([2001:4830:134:3::10]:53230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dSJvn-0005oz-PW
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dSJvi-0005jC-Nm
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:15:39 -0400
Received: from 13.mo4.mail-out.ovh.net ([178.33.251.8]:59552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dSJvi-0005iq-GX
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:15:34 -0400
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 9BA4081CB1
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 11:15:32 +0200 (CEST)
Date: Tue, 4 Jul 2017 11:15:24 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170704111524.4ba767d5@bahia.lan>
In-Reply-To: <20170704091133.GC7689@in.ibm.com>
References: <149908449117.14256.2821600309813941055.stgit@bahia.lan>
	<20170704033143.GA7689@in.ibm.com>
	<20170704035050.GB7689@in.ibm.com>
	<20170704100246.37100aa1@bahia.lan>
	<20170704091133.GC7689@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/SkC=l=JSEdcqOrZ4bGhhjh7";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] spapr: fix memory hotplug error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

--Sig_/SkC=l=JSEdcqOrZ4bGhhjh7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Jul 2017 14:41:33 +0530
Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:

> On Tue, Jul 04, 2017 at 10:02:46AM +0200, Greg Kurz wrote:
> > > > There is some history to this. I was doing error recovery and propa=
gation
> > > > here similarly during memory hotplug development phase until Igor
> > > > suggested that we shoudn't try to recover after we have done guest
> > > > visible changes.
> > > >=20
> > > > Refer to "changes in v6" section in this post:
> > > > https://lists.gnu.org/archive/html/qemu-ppc/2015-06/msg00296.html
> > > >=20
> > > > However at that time we were doing memory add by DRC index method
> > > > and hence would attach and online one LMB at a time.
> > > > In that method, if an intermediate attach fails we would end up wit=
h a few
> > > > LMBs being onlined by the guest already. However subsequently
> > > > we have switched (optionally, based on dedicated_hp_event_source) to
> > > > count-indexed method of hotplug where we do attach of all LMBs one =
by one
> > > > and then request the guest to hotplug all of them at once using cou=
nt-indexed
> > > > method.
> > > >=20
> > > > So it will be a bit tricky to abort for index based case and recover
> > > > correctly for count-indexed case.   =20
> > >=20
> > > Looked at the code again and realized that though we started with
> > > index based LMB addition, we later switched to count based addition. =
Then
> > > we added support for count-indexed type subject to the presence
> > > of dedidated hotplug event source while still retaining the support
> > > for count based addition.
> > >=20
> > > So presently we do attach of all LMBs one by one and then do onlining
> > > (count based or count-indexed based) once. Hence error recovery
> > > for both cases would be similar now. So I guess you should take care =
of
> > > undoing pc_dimm_memory_plug() like Igor mentioned and also undo the
> > > effects of partial successful attaches.
> > >  =20
> >=20
> > I've sent a v2 that adds rollback. =20
>=20
> oh ok, somehow v2 didn't reach me at all and I saw the v2 in archives only
> now. So just noting that my above replies were sent w/o being aware of v2=
 :)
>=20

No problem at all. It confirms that v2 was indeed needed. Also, it exposes
some details I wasn't aware of. Thanks for the explanation! :)

Cheers,

--
Greg

> > > >=20
> > > > Regards,
> > > > Bharata.   =20
>=20


--Sig_/SkC=l=JSEdcqOrZ4bGhhjh7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllbXKwACgkQAvw66wEB28JyHwCgkwTiMdWb9HAno6iWcLqcS2SX
qjIAniD0QsYRHVinmAmk/LZX1FEEZXfW
=r5Ol
-----END PGP SIGNATURE-----

--Sig_/SkC=l=JSEdcqOrZ4bGhhjh7--
