Received: from eggs.gnu.org ([2001:4830:134:3::10]:47948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f8cOn-00039Y-FK
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 22:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f8cOm-0001RQ-DH
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 22:00:41 -0400
Date: Wed, 18 Apr 2018 11:49:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180418014908.GE2317@umbus.fritz.box>
References: <1523982095-17175-1-git-send-email-spopovyc@redhat.com>
	<20180417191751.709bb564@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline
In-Reply-To: <20180417191751.709bb564@bahia.lan>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for 2.13] spapr: Correct max
 associativity domains value for non-NUMA configs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Serhii Popovych <spopovyc@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2018 at 07:17:51PM +0200, Greg Kurz wrote:
> Cc'ing David who should always be in the recipient list when posting ppc =
related
> patches :)
>=20
> On Tue, 17 Apr 2018 12:21:35 -0400
> Serhii Popovych <spopovyc@redhat.com> wrote:
>=20
> > In non-NUMA configurations nb_numa_nodes is zero and we set 5th cell
> > in ibm,max-associativity-domains to -1. That causes to stall Linux
> > guests during boot after following line:
> >=20
> > [    0.000000] NUMA associativity depth for CPU/Memory: 4
> >=20
> > Make last possible NUMA in property zero to correct support for
> > non-NUMA guests.
> >=20
>=20
> Alternatively, as suggested by David in some other mail, you could drop t=
he
> property in this case. I've checked it fixes the hang too, and it probably
> makes more sense than exposing only zeroes.

Actually, I think this is the better solution. qemu treats "not NUMA"
and "exactly one NUMA node" differently for historical reasons, but I
don't think that actually makes a whole lot of sense.  I think
advertising them identically so we don't generate more special cases
on the guest side is a better idea.

> > Fixes: c1df49a670ef ("spapr: Add ibm,max-associativity-domains property=
")
>=20
> Since c1df49a670ef hasn't hit master yet, I guess we should squash this
> patch (or any alternative) there to preserve bisect, ie, either David
> does it for you or you post a v4 of your previous series.

Right, I've folded these together in my tree so we don't get an
interval of broken commits.

>=20
> > Signed-off-by: Serhii Popovych <spopovyc@redhat.com>
> > ---
> >  hw/ppc/spapr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 7b2bc4e..bff2125 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -914,7 +914,7 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr,=
 void *fdt)
> >          cpu_to_be32(0),
> >          cpu_to_be32(0),
> >          cpu_to_be32(0),
> > -        cpu_to_be32(nb_numa_nodes - 1),
> > +        cpu_to_be32(nb_numa_nodes ? nb_numa_nodes - 1 : 0),
> >      };
> > =20
> >      _FDT(rtas =3D fdt_add_subnode(fdt, 0, "rtas"));
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrWpBEACgkQbDjKyiDZ
s5LMeRAA3a4yDwStdW18AlxKWaTIwsWfKrSrcTreRBvp0umMUqvrvReQJV4p+/ec
YsRm/PwhUtADQ/MQWA62gGVkSwAdMPrVmP/Y29tNnhy7TDRM6UJi39mIe+McFtmw
98fEzLeo+zuc/K8LUMtXjc3c3ye0glBGupigLiyCuNNfwrdyf+V5xHeq3nB67ALg
M0nNUUem9wqOTqgVTJXSG3IplYytR4b85Ak7gwlp6yn99ieLpQc3/MPnFCH/EBnf
1MXUbTDGDb/8P3pafeOfB8FZi6mH8cEZsfDFWcxJsxbjQ2rXImuzGOGU2Wv+oHJN
n/BBVNy6exdh9TxnCknEVAWJ+s62KGXF6v2/Gsnu+sP4txTdOP59mlDnHMWJKKn/
Zj5zk+MPjEgt0lpz9sxbE6wdOXEoJZo76MdchN2Zvb2zwniRfJIYWKNzNxE01Kly
OryfxNgqukHw0XaPVRePqXmS/mG8MlRNi8T14hnQ90K4W8+PV2ROT8ajM2Epwq6C
2AIR9VNrnS6zwqp6lGIW1eewwBR1ZVkzzbes/YxI8jUoNTw5Edzqd67y+0QdrSn2
G61oOvbEfz8d9fVSFtWIx+xCFGFUASlhXF7lIyHPObnnZfIJVcjghLJMiDqndsQf
8B30wDRXvyGE9XL6iPBPN7HGa9CZo5B5leTuM2y+e27bfmygFAA=
=rbML
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--
