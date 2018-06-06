Received: from eggs.gnu.org ([2001:4830:134:3::10]:60359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQUbW-0005yw-2n
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 05:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQUbS-0005zx-3H
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 05:19:42 -0400
Received: from 4.mo173.mail-out.ovh.net ([46.105.34.219]:56553)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fQUbR-0005t6-T0
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 05:19:38 -0400
Received: from player718.ha.ovh.net (unknown [10.109.120.2])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 10B14C484D
	for <qemu-devel@nongnu.org>; Wed,  6 Jun 2018 11:19:29 +0200 (CEST)
Date: Wed, 6 Jun 2018 11:19:22 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180606111922.66882650@bahia.lan>
In-Reply-To: <20180606005317.GD17757@umbus.fritz.box>
References: <20180507180835.4b7b9222@bahia.lan>
	<20180507165242.46502-1-leandro.lupori@gmail.com>
	<20180604005322.GE4251@umbus> <20180605184612.42099707@bahia.lan>
	<20180606005317.GD17757@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/usN/3Pv5y_KYy+n/n.EhMJT";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3] target/ppc: Allow PIR read
 in privileged mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: luporl <leandro.lupori@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

--Sig_/usN/3Pv5y_KYy+n/n.EhMJT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Jun 2018 10:53:17 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Jun 05, 2018 at 06:46:12PM +0200, Greg Kurz wrote:
> > On Mon, 4 Jun 2018 10:53:22 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > On Mon, May 07, 2018 at 01:52:42PM -0300, luporl wrote: =20
> > > > According to PowerISA, the PIR register should be readable in privi=
leged
> > > > mode also, not only in hypervisor privileged mode.
> > > >=20
> > > > PowerISA 3.0 - 4.3.3 Processor Identification Register
> > > >=20
> > > > "Read access to the PIR is privileged; write access is not
> > > > provided."   =20
> > >=20
> > > Yes... but a little further down it says "The PIR is a hypervisor
> > > resource".  Looking at the older 2.07 ISA, it says that
> > > guest-supervisor mode reads to the PIR should be redirected to the
> > > GPIR register, which this change won't accomplish.
> > >  =20
> >=20
> > Hmmm, there are two definitions for the PIR, one in Book III-S (4.3.3)
> > and one in Book III-E (5.3.3). It looks like you're referring to the
> > latter...
> >=20
> > [Category:Embedded.Hypervisor]
> > Read accesses to the PIR in guest supervisor state are
> > mapped to the GPIR.
> >=20
> > The Book III-S definition doesn't mention the GPIR. =20
>=20
> Oops, sorry.  Yes the GPIR stuff is only for BookE.  The statement
> about the PIR being a hypervisor resource is definitely in the BookS
> section, however (both 2.07 and 3.0).
>=20

Yes it is, but IIUC, this means that the guest cannot modify it, eg,
do mtspr. Section 4.4.4 in Book III-S has a list of SPRs that seem to
indicate that mfspr doesn't require hypervisor state with the PIR.

FWIW, this can be verified with xmon in a KVM guest:

0:mon> S
...
srr0   =3D c0000000000cd06c  srr1  =3D 8000000000001033 dsisr  =3D 00000000
dscr   =3D 0000000000000000  ppr   =3D 0010000000000000 pir    =3D 00000020
...
0:mon> Sr 3ff
SPR 0x3ff (1023) =3D 0x20

but with TCG xmon hits a program check:

0:mon> S
...
srr0   =3D c0000000000ef204  srr1  =3D 8000000000041033 dsisr  =3D 40000000
cpu 0x0: Vector: 700 (Program Check) at [c00000003ffdf510]
...
cpu 0x0: Exception 700 (Program Check) in xmon, returning to main loop
...
0:mon> Sr 3ff
SPR 0x3ff (1023) Faulted during read

This patch makes xmon happy under TCG.

--Sig_/usN/3Pv5y_KYy+n/n.EhMJT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlsXpxoACgkQcdTV5YIv
c9Zc2BAAnXBCvdYiZeIbB+su1Wkcsab0By81JTYa9hGg/IPusnBhrQGQN1FvQHPA
3JgTR1Xz3Kz4H6dtBRYbnu6KK2sCDFsvYAxCfmI5S1o9iq8F8Q/I0vRmwMwPBbnB
rxAyPWie8WevmQuIhAg+t+11YBL/SFbJBh/e+1pkK5jKl5ddtPJPtAXN4z05uqc6
tog630SLha0M+p2h/DNdT+/o9CBE0AG3Ar5ROV7Vs0sTz82NYV45rbHI2oolrD5z
gGqzYCg2m15vjd1PeWD6XqZuj1CgxLcZPZTwjNCZAWhhelqCpZ3zag4EPHndLrcp
DZjgOaPT5ullzS+MxNuYPkE03Tlu5xKjbrMb5vA+dUCo/KxCpnXw7vat8XHywJB8
LhUl5ra/tnv/og5qUdkT+yeaO8kwpmb3lOFt6Galb3RhnfTgg/YOmT40FGDKFB4f
2uL1Y6W16WVJR/Icr7YKg+6mVkFiCDgtwavlqkchSUe1yOg2OQ6n/mPiAchrmqf6
7QNtFrjt7hbHpadr4H2klBlI6tde3qGYw3sndrqgs3MNcFxFDN3GNjew/jnN3wcq
154Iq8m6uA6izvKWR49Ahh6gmgsvWJkKE8V/0YAnrImSpVOdL1cQYBJ3ZigJU9ff
zvdqHfCJb0w2tyY5Apb/IkUCmQEt+RwS7twLboqo2z8BP8Kc8bQ=
=sRwu
-----END PGP SIGNATURE-----

--Sig_/usN/3Pv5y_KYy+n/n.EhMJT--
