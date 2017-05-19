Received: from eggs.gnu.org ([2001:4830:134:3::10]:35798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dBbaA-0007JK-JR
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:40:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dBba9-000356-JI
	for qemu-devel@nongnu.org; Fri, 19 May 2017 02:40:14 -0400
Date: Fri, 19 May 2017 16:40:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170519064004.GI12284@umbus.fritz.box>
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
	<149484840466.20089.893964776019028654.stgit@bahia.lan>
	<a94cf0ed-3318-fb2d-f16c-4d2b12fff3bb@kaod.org>
	<20170515151602.61dc381d@bahia>
	<b2fe560d-e8ef-dc47-2f7a-e06092a503b6@kaod.org>
	<20170517041816.GG15596@umbus.fritz.box>
	<20170517223344.5bf8ed1f@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BWWlCdgt6QLN7tv3"
Content-Disposition: inline
In-Reply-To: <20170517223344.5bf8ed1f@bahia.lan>
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
To: Greg Kurz <groug@kaod.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>


--BWWlCdgt6QLN7tv3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2017 at 10:33:44PM +0200, Greg Kurz wrote:
> On Wed, 17 May 2017 14:18:16 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Mon, May 15, 2017 at 06:11:27PM +0200, C=C3=A9dric Le Goater wrote:
> > > >>> +        int smt =3D kvmppc_smt_threads();
> > > >>> +        int nr_servers =3D DIV_ROUND_UP(max_cpus * smt, smp_thre=
ads);
> > > >>
> > > >> may be we should reintroduce nr_servers at the machine level ?=20
> > > >> =20
> > > >=20
> > > > I had reintroduced it but then I realized it was only used in this
> > > > function. =20
> > >=20
> > > nr_servers is also used when the device tree is populated with the=20
> > > interrupt controller nodes. No big deal. =20
> >=20
> > Which is guest visible, so we should really make that stay the same
> > for older machine types.  I'd like to avoid re-introducing nr_servers
> > as a property if we can, but maybe we can't.
> >=20
>=20
> Yes we can :) or at least maybe, if you can shed light on a guest
> visible change introduced by this commit in 2.8:
>=20
> commit 9b9a19080a6e548b91420ce7925f2ac81ef63ae8
> Author: David Gibson <david@gibson.dropbear.id.au>
> Date:   Thu Oct 20 16:07:56 2016 +1100
>=20
>     pseries: Move construction of /interrupt-controller fdt node
>=20
>=20
> It changes the "ibm,interrupt-server-ranges" property in the device
> tree from
>=20
>     {0, cpu_to_be32(max_cpus)}
>=20
> to
>=20
>     {0, cpu_to_be32(xics->nr_servers)}
>=20
> ie, {0, cpu_to_be32(DIV_ROUND_UP(max_cpus * smt, smp_threads))}
>=20
> And indeed, if I start QEMU with
>=20
>  -smp cores=3D2,threads=3D4,maxcpus=3D16 -machine type=3Dpseries-2.7,acce=
l=3Dkvm
>=20
> the following is exposed to the guest with 2.7:
>=20
> ibm,interrupt-server-ranges
>                  00000000 00000010
>=20
> and with 2.8 we get:
>=20
> ibm,interrupt-server-ranges
>                  00000000 00000020
>=20
> LoPAPR B.6.9.1.1 says that the range (ie, the second number) "shall be the
> number of contiguous server#s supported by the unit (this also corresponds
> to the number of =E2=80=9Creg=E2=80=9D entries)". I'm inclined to think t=
his maps to max_cpus
> but I may be wrong... any clues ?

So, yes, it's a guest visible change in some configurations, but in
those configurations the previous behaviour was sufficiently broken
that I think that's preferable to not changing it.

Basically the ibm,interrupt-server-ranges property gives the total
range of valid server IDs.  The server IDs assigned to each thread are
based on the dt_id, and are spaced by the number of host threads, not
the number of guest threads.  That means that with 2.7, the last cpus
would have advertised ibm,ppc-interrupt-server#s properties with
values outside the range given by ibm,interrupt-server-ranages, which
is definitely wrong.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BWWlCdgt6QLN7tv3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZHpNBAAoJEGw4ysog2bOSOfsQAMeddnH5IpF8uMVapeuTEamu
hb6L3TWgf67T1HUeEfksmERiC0acNST+ZdtXip+okpXkYJGTqMM862gZhKxAm89f
//CIpmdzalVfFF6ObwpNMRcypu5xE/AnuKvBOsWTs13qGeJHfBmH/TEX4fWzsMxo
WktJSbW/CN+KLmLdiNquIGlec0uogn4lbriNzhv23MQ/8Ez2JwTi3JDVPO5mvYDF
yHAaHvg9VMRtCBK+vpv21CjL98eYn6uNwy4xsfNwo+4DHNDGxpS//wVtRWGnsVLC
ibQ93NOVrSvyRP7wn9LKW3DirZ7dk3w2Zg64i+TavZs/W7AvUXI/4suxoo9pf4wy
tkOj9dBdw6TvnTYJ5/f0AHrgTCOcF0Uig+2wTGfY3TV3dNjjFkCdVWhm63/xUOvL
ZTORE2AE/MRyztZ888ao2lxuLXbizm//eblxlX0/dOP5bwcxN8TP7yXp/29KOJBB
Lrp6PZv6IWe4E86tl8glvtUon5HBAX/UGQMtsv+wZDSBIDm2GDWq4NFX6aWorn3U
YDOm0tPA7eXyHqjPwvyKZoVuowGhIdGgdtHf9q6m63ql1NmtazCxvu7vY6oXMqw/
Ple8/yX5xKFUSXLL+6bayo6hNzNS0uaHmrlsKNzjZQC71FJCUZaS+tr1FQWZy/mZ
4VRy645F7Z9S87Qg/st3
=ZiOJ
-----END PGP SIGNATURE-----

--BWWlCdgt6QLN7tv3--
