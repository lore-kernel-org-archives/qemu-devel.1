Received: from eggs.gnu.org ([2001:4830:134:3::10]:42749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duXAd-0003vT-Pj
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 01:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duXAc-0002dR-Cf
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 01:03:35 -0400
Date: Wed, 20 Sep 2017 14:55:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170920045524.GH5520@umbus.fritz.box>
References: <20170909070212.GT2735@umbus.fritz.box>
	<87k2153jnx.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170913073519.GK7550@umbus.fritz.box>
	<8760clsw17.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170915064830.GI5250@umbus.fritz.box>
	<87377omkuk.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170915085115.GN5250@umbus.fritz.box>
	<87y3pgl45f.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170919082421.GU27153@umbus>
	<871sn2hugn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Yia77v5a8fyVHJSl"
Content-Disposition: inline
In-Reply-To: <871sn2hugn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: fix cores per chip for multiple
 cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, bharata@linux.vnet.ibm.com, benh@kernel.crashing.org


--Yia77v5a8fyVHJSl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2017 at 09:50:24AM +0530, Nikunj A Dadhania wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> > On Fri, Sep 15, 2017 at 02:39:16PM +0530, Nikunj A Dadhania wrote:
> >> David Gibson <david@gibson.dropbear.id.au> writes:
> >>=20
> >> > On Fri, Sep 15, 2017 at 01:53:15PM +0530, Nikunj A Dadhania wrote:
> >> >> David Gibson <david@gibson.dropbear.id.au> writes:
> >> >>=20
> >> >> >>=20
> >> >> >> I thought, I am doing the same here for PowerNV, number of onlin=
e cores
> >> >> >> is equal to initial online vcpus / threads per core
> >> >> >>=20
> >> >> >>    int boot_cores_nr =3D smp_cpus / smp_threads;
> >> >> >>=20
> >> >> >> Only difference that I see in PowerNV is that we have multiple c=
hips
> >> >> >> (max 2, at the moment)
> >> >> >>=20
> >> >> >>         cores_per_chip =3D smp_cpus / (smp_threads * pnv->num_ch=
ips);
> >> >> >
> >> >> > This doesn't make sense to me.  Cores per chip should *always* eq=
ual
> >> >> > smp_cores, you shouldn't need another calculation for it.
> >> >> >
> >> >> >> And in case user has provided sane smp_cores, we use it.
> >> >> >
> >> >> > If smp_cores isn't sane, you should simply reject it, not try to =
fix
> >> >> > it.  That's just asking for confusion.
> >> >>=20
> >> >> This is the case where the user does not provide a topology(which i=
s a
> >> >> valid scenario), not sure we should reject it. So qemu defaults
> >> >> smp_cores/smt_threads to 1. I think it makes sense to over-ride.
> >> >
> >> > If you can find a way to override it by altering smp_cores when it's
> >> > not explicitly specified, then ok.
> >>=20
> >> Should I change the global smp_cores here as well ?
> >
> > I'm pretty uneasy with that option.
>=20
> Me too.
>=20
> > It would take a fair bit of checking to ensure that changing smp_cores
> > is safe here. An easier to verify option would be to make the generic
> > logic which splits up an unspecified -smp N into cores and sockets
> > more flexible, possibly based on machine options for max values.
> >
> > That might still be more trouble than its worth.
>=20
> I think the current approach is the simplest and less intrusive, as we
> are handling a case where user has not bothered to provide a detailed
> topology, the best we can do is create single threaded cores equal to
> number of cores.

No, sorry.  Having smp_cores not correspond to the number of cores per
chip in all cases is just not ok.  Add an error message if the
topology isn't workable for powernv by all means.  But users having to
use a longer command line is better than breaking basic assumptions
about what numbers reflect what topology.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Yia77v5a8fyVHJSl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnB9LoACgkQbDjKyiDZ
s5LMfBAAk5jTOMEwie2zjO7Swc8hRyLJNfOFWZ7igZErjtA2uUtvV1rqlVB/QJIu
/okuToSsim093Zr7ozGVlHUIxnCQWrnYBw/ty7IDjD6mCy2HsuDdFLcCPQOssi2t
ICQ0BlR8cJ023DQFDyIK5elGenR0/LJrhZoiFb22vmGqg+YBr4+Z9s7vDP9WPLOM
rK+a27kUN4TfSLZp/4vRxfmJKscZY6Ngc9/ra419LK0l7yBPBFCjligPy2zBnvPu
/5Zlaor0SjHezrR29HZnxEbD5MwCj4wFbEKxPAqO/Vo/hcmtFR/IcWhnWipW11ts
U2Jt5Z+zrbk9dZMxIu44Kg0E9AB90ynsG/jTMlHD4ZoSVjPM4IlgzOtKoRxihd8l
zflyYZ0Ne3i+OHME0xrAivu7g3otNZzlpAB9+5xUtofmbYYWQQ7FTnd9mQLl0aqP
FDeZrRAWRV3HfSnzkY0RtdjqHEOhDEiLNvQcmPoWm0yQln8/at3oFokgaa4/rHGp
Qppzx21yMswJy3a+4jxO7KBx1hPq3nonkJchzk9RdkM2YTcwD6w8FNxTwk8MuVI1
E+xI3CPdv2KPPJBp/iHGhHhlYd9xSeRkj/sIwg6DLAuwdR6O80x+9ga56jGqb5wc
182JWxjLpLjr+aGDfm8GvEFoTB9ZTbVib8ShtX8E/XgXqJHcIx0=
=bUgx
-----END PGP SIGNATURE-----

--Yia77v5a8fyVHJSl--
