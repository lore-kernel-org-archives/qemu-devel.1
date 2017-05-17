Received: from eggs.gnu.org ([2001:4830:134:3::10]:59752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dB5ds-0004yV-BU
	for qemu-devel@nongnu.org; Wed, 17 May 2017 16:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dB5dp-0004cG-8e
	for qemu-devel@nongnu.org; Wed, 17 May 2017 16:33:56 -0400
Received: from 2.mo3.mail-out.ovh.net ([46.105.75.36]:37184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dB5dp-0004bp-1r
	for qemu-devel@nongnu.org; Wed, 17 May 2017 16:33:53 -0400
Received: from player797.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 919D8D2250
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 22:33:51 +0200 (CEST)
Date: Wed, 17 May 2017 22:33:44 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170517223344.5bf8ed1f@bahia.lan>
In-Reply-To: <20170517041816.GG15596@umbus.fritz.box>
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
	<149484840466.20089.893964776019028654.stgit@bahia.lan>
	<a94cf0ed-3318-fb2d-f16c-4d2b12fff3bb@kaod.org>
	<20170515151602.61dc381d@bahia>
	<b2fe560d-e8ef-dc47-2f7a-e06092a503b6@kaod.org>
	<20170517041816.GG15596@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/8uWwr.BjZWA9KSOVQgQ2izP";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 6/6] spapr: fix migration of ICP objects
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
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>

--Sig_/8uWwr.BjZWA9KSOVQgQ2izP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 May 2017 14:18:16 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, May 15, 2017 at 06:11:27PM +0200, C=C3=A9dric Le Goater wrote:
> > >>> +        int smt =3D kvmppc_smt_threads();
> > >>> +        int nr_servers =3D DIV_ROUND_UP(max_cpus * smt, smp_thread=
s);
> > >>
> > >> may be we should reintroduce nr_servers at the machine level ?=20
> > >> =20
> > >=20
> > > I had reintroduced it but then I realized it was only used in this
> > > function. =20
> >=20
> > nr_servers is also used when the device tree is populated with the=20
> > interrupt controller nodes. No big deal. =20
>=20
> Which is guest visible, so we should really make that stay the same
> for older machine types.  I'd like to avoid re-introducing nr_servers
> as a property if we can, but maybe we can't.
>=20

Yes we can :) or at least maybe, if you can shed light on a guest
visible change introduced by this commit in 2.8:

commit 9b9a19080a6e548b91420ce7925f2ac81ef63ae8
Author: David Gibson <david@gibson.dropbear.id.au>
Date:   Thu Oct 20 16:07:56 2016 +1100

    pseries: Move construction of /interrupt-controller fdt node


It changes the "ibm,interrupt-server-ranges" property in the device
tree from

    {0, cpu_to_be32(max_cpus)}

to

    {0, cpu_to_be32(xics->nr_servers)}

ie, {0, cpu_to_be32(DIV_ROUND_UP(max_cpus * smt, smp_threads))}

And indeed, if I start QEMU with

 -smp cores=3D2,threads=3D4,maxcpus=3D16 -machine type=3Dpseries-2.7,accel=
=3Dkvm

the following is exposed to the guest with 2.7:

ibm,interrupt-server-ranges
                 00000000 00000010

and with 2.8 we get:

ibm,interrupt-server-ranges
                 00000000 00000020

LoPAPR B.6.9.1.1 says that the range (ie, the second number) "shall be the
number of contiguous server#s supported by the unit (this also corresponds
to the number of =E2=80=9Creg=E2=80=9D entries)". I'm inclined to think thi=
s maps to max_cpus
but I may be wrong... any clues ?

Cheers,

--
Greg

--Sig_/8uWwr.BjZWA9KSOVQgQ2izP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkcs6gACgkQAvw66wEB28KyzACfZM39M4aV4JCUVnAG0xKOQQfu
+/QAoJhyugXGtSktyiaZgi0FiCUIrT++
=8dLQ
-----END PGP SIGNATURE-----

--Sig_/8uWwr.BjZWA9KSOVQgQ2izP--
