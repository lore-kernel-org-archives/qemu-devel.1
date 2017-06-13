Received: from eggs.gnu.org ([2001:4830:134:3::10]:48041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dKgTp-00039H-Bd
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 03:43:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dKgTl-0004VZ-FM
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 03:43:13 -0400
Received: from 4.mo5.mail-out.ovh.net ([178.33.111.247]:59033)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dKgTl-0004VM-8e
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 03:43:09 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id E14E91021F3
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 09:43:07 +0200 (CEST)
Date: Tue, 13 Jun 2017 09:43:02 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170613094302.1cb4012c@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170611093842.GA13479@umbus>
References: <149692935202.12119.3614006195497745877.stgit@bahia>
	<20170609022813.GF26521@umbus.fritz.box>
	<20170609113631.229dd346@bahia.ttt.fr.ibm.com>
	<20170609102832.GL26521@umbus.fritz.box>
	<20170609170913.2e6526c3@bahia.ttt.fr.ibm.com>
	<20170611093842.GA13479@umbus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/F.Lp5fmv+Xc6Fwy1b0rxHjR";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v4 0/6] spapr/xics: fix migration of older
 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

--Sig_/F.Lp5fmv+Xc6Fwy1b0rxHjR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 11 Jun 2017 17:38:42 +0800
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Jun 09, 2017 at 05:09:13PM +0200, Greg Kurz wrote:
> > On Fri, 9 Jun 2017 20:28:32 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > On Fri, Jun 09, 2017 at 11:36:31AM +0200, Greg Kurz wrote: =20
> > > > On Fri, 9 Jun 2017 12:28:13 +1000
> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > >    =20
> > > > > On Thu, Jun 08, 2017 at 03:42:32PM +0200, Greg Kurz wrote:   =20
> > > > > > I've provided answers for all comments from the v3 review that =
I deliberately
> > > > > > don't address in v4.     =20
> > > > >=20
> > > > > I've merged patches 1-4.  5 & 6 I'm still reviewing.
> > > > >    =20
> > > >=20
> > > > Cool. FYI, I forgot to mention that I only tested with KVM.
> > > >=20
> > > > I'm now trying with TCG and I hit various guest crash on
> > > > the destination (using your ppc-for-2.10 branch WITHOUT
> > > > my patches):   =20
> > >=20
> > > Drat.  What's your reproducer for this crash?
> > >  =20
> >=20
> > 1) start guest
> >=20
> > qemu-system-ppc64 \
> >  -nodefaults -nographic -snapshot -no-shutdown -serial mon:stdio \
> >  -device virtio-net,netdev=3Dnetdev0,id=3Dnet0 \
> >  -netdev bridge,id=3Dnetdev0,br=3Dvirbr0,helper=3D/usr/libexec/qemu-bri=
dge-helper \
> >  -device virtio-blk,drive=3Ddrive0,id=3Dblk0 \
> >  -drive file=3D/home/greg/images/sle12-sp1-ppc64le.qcow2,id=3Ddrive0,if=
=3Dnone \
> >  -machine type=3Dpseries,accel=3Dtcg -cpu POWER8
> >=20
> > 2) migrate
> >=20
> > 3) destination crashes (immediately or after very short delay) or
> > hangs =20
>=20
> Ok.  I'll bisect it when I can, but you might well get to it first.
>=20
>=20

Heh, maybe you didn't see in my mail but I did bisect:

f0b0685d6694a28c66018f438e822596243b1250 is the first bad commit
commit f0b0685d6694a28c66018f438e822596243b1250
Author: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date:   Thu Apr 27 10:48:23 2017 +0530

    tcg: enable MTTCG by default for PPC64 on x86


--Sig_/F.Lp5fmv+Xc6Fwy1b0rxHjR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlk/l4YACgkQAvw66wEB28IjWQCePlLGqwAVsGl1cukIvmd3rpNm
cV8An1Ce7OBfKZx8IBKwg+INyPUmW1u6
=sVfm
-----END PGP SIGNATURE-----

--Sig_/F.Lp5fmv+Xc6Fwy1b0rxHjR--
