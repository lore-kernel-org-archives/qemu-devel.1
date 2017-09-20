Received: from eggs.gnu.org ([2001:4830:134:3::10]:41617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duenI-0007jr-ME
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:12:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duemf-0006tt-Rl
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:12:00 -0400
Date: Wed, 20 Sep 2017 21:53:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170920115342.GQ5520@umbus.fritz.box>
References: <20170915085115.GN5250@umbus.fritz.box>
	<87y3pgl45f.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170919082421.GU27153@umbus>
	<871sn2hugn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920045524.GH5520@umbus.fritz.box>
	<87y3pagdg0.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920061756.GJ5520@umbus.fritz.box>
	<87vakdhnyn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920065700.GO5520@umbus.fritz.box>
	<87poalhm74.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i/CQJCAqWP/GQJtX"
Content-Disposition: inline
In-Reply-To: <87poalhm74.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
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


--i/CQJCAqWP/GQJtX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2017 at 12:48:55PM +0530, Nikunj A Dadhania wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> > On Wed, Sep 20, 2017 at 12:10:48PM +0530, Nikunj A Dadhania wrote:
> >> David Gibson <david@gibson.dropbear.id.au> writes:
> >>=20
> >> > On Wed, Sep 20, 2017 at 10:43:19AM +0530, Nikunj A Dadhania wrote:
> >> >> David Gibson <david@gibson.dropbear.id.au> writes:
> >> >>=20
> >> >> > On Wed, Sep 20, 2017 at 09:50:24AM +0530, Nikunj A Dadhania wrote:
> >> >> >> David Gibson <david@gibson.dropbear.id.au> writes:
> >> >> >>=20
> >> >> >> > On Fri, Sep 15, 2017 at 02:39:16PM +0530, Nikunj A Dadhania wr=
ote:
> >> >> >> >> David Gibson <david@gibson.dropbear.id.au> writes:
> >> >> >> >>=20
> >> >> >> >> > On Fri, Sep 15, 2017 at 01:53:15PM +0530, Nikunj A Dadhania=
 wrote:
> >> >> >> >> >> David Gibson <david@gibson.dropbear.id.au> writes:
> >> >> >> >> >>=20
> >> >> >> >> >> >>=20
> >> >> >> >> >> >> I thought, I am doing the same here for PowerNV, number=
 of online cores
> >> >> >> >> >> >> is equal to initial online vcpus / threads per core
> >> >> >> >> >> >>=20
> >> >> >> >> >> >>    int boot_cores_nr =3D smp_cpus / smp_threads;
> >> >> >> >> >> >>=20
> >> >> >> >> >> >> Only difference that I see in PowerNV is that we have m=
ultiple chips
> >> >> >> >> >> >> (max 2, at the moment)
> >> >> >> >> >> >>=20
> >> >> >> >> >> >>         cores_per_chip =3D smp_cpus / (smp_threads * pn=
v->num_chips);
> >> >> >> >> >> >
> >> >> >> >> >> > This doesn't make sense to me.  Cores per chip should *a=
lways* equal
> >> >> >> >> >> > smp_cores, you shouldn't need another calculation for it.
> >> >> >> >> >> >
> >> >> >> >> >> >> And in case user has provided sane smp_cores, we use it.
> >> >> >> >> >> >
> >> >> >> >> >> > If smp_cores isn't sane, you should simply reject it, no=
t try to fix
> >> >> >> >> >> > it.  That's just asking for confusion.
> >> >> >> >> >>=20
> >> >> >> >> >> This is the case where the user does not provide a topolog=
y(which is a
> >> >> >> >> >> valid scenario), not sure we should reject it. So qemu def=
aults
> >> >> >> >> >> smp_cores/smt_threads to 1. I think it makes sense to over=
-ride.
> >> >> >> >> >
> >> >> >> >> > If you can find a way to override it by altering smp_cores =
when it's
> >> >> >> >> > not explicitly specified, then ok.
> >> >> >> >>=20
> >> >> >> >> Should I change the global smp_cores here as well ?
> >> >> >> >
> >> >> >> > I'm pretty uneasy with that option.
> >> >> >>=20
> >> >> >> Me too.
> >> >> >>=20
> >> >> >> > It would take a fair bit of checking to ensure that changing s=
mp_cores
> >> >> >> > is safe here. An easier to verify option would be to make the =
generic
> >> >> >> > logic which splits up an unspecified -smp N into cores and soc=
kets
> >> >> >> > more flexible, possibly based on machine options for max value=
s.
> >> >> >> >
> >> >> >> > That might still be more trouble than its worth.
> >> >> >>=20
> >> >> >> I think the current approach is the simplest and less intrusive,=
 as we
> >> >> >> are handling a case where user has not bothered to provide a det=
ailed
> >> >> >> topology, the best we can do is create single threaded cores equ=
al to
> >> >> >> number of cores.
> >> >> >
> >> >> > No, sorry.  Having smp_cores not correspond to the number of core=
s per
> >> >> > chip in all cases is just not ok.  Add an error message if the
> >> >> > topology isn't workable for powernv by all means.  But users havi=
ng to
> >> >> > use a longer command line is better than breaking basic assumptio=
ns
> >> >> > about what numbers reflect what topology.
> >> >>=20
> >> >> Sorry to ask again, as I am still not convinced, we do similar
> >> >> adjustment in spapr where the user did not provide the number of co=
res,
> >> >> but qemu assumes them as single threaded cores and created
> >> >> cores(boot_cores_nr) that were not same as smp_cores ?
> >> >
> >> > What?  boot_cores_nr has absolutely nothing to do with adjusting the
> >> > topology, and it certainly doesn't assume they're single threaded.
> >>=20
> >> When we start a TCG guest and user provides following commandline, e.g.
> >> "-smp 4", smt_threads is set to 1 by default in vl.c. So the guest boo=
ts
> >> with 4 cores, each having 1 thread.
> >
> > Ok.. and what's the problem with that behaviour on powernv?
>=20
> As smp_thread defaults to 1 in vl.c, similarly smp_cores also has the
> default value of 1 in vl.c. In powernv, we were setting nr-cores like
> this:
>=20
>         object_property_set_int(chip, smp_cores, "nr-cores", &error_fatal=
);
>=20
> Even when there were multiple cpus (-smp 4), when the guest boots up, we
> just get one core (i.e. smp_cores was 1) with single thread(smp_threads
> was 1), which is wrong as per the command-line that was provided.

Right, so, -smp 4 defaults to 4 sockets, each with 1 core of 1
thread.  If you can't supply 4 sockets you should error, but you
shouldn't go and change the number of cores per socket.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--i/CQJCAqWP/GQJtX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnCVsQACgkQbDjKyiDZ
s5JR8g//b/jghlZG8gktqssM4reqeeqAa5ABU9t+af248Um7gvQwIpZuztKVsJWh
vkKGUg7BbtFopsz3dEnB4rwGRcTUobIWtKQDkuDlO4fEIjFAMuMgRX5JP9ZxI6bm
Cs8K32GHi0RekxLgGKiJ/wrr+6ursU5uL69sX09DdaFSR18ZOZZBLOOuQXyhvsZJ
vPOBgrXG0nMRAxExTsNUnok1Mzg6cWDCiHYha819dFPbtvoYxqwYMkxjLLEmW3qN
QP79PLgYbspYg9/myYYDnHWn2GKTdjvDz1xqHNSq5zID6B6IPQct4XeTDslj6sCb
m3uNyqzWUc58hK+BhWX3RHbvRd9fklXSTDWb2aqfy39zZLuJRN9+aPca81ONwVLv
P9ZgXKPQJLIeLbBA1YHAHJx1+A1kjBuxNWyG3xHMukI0BH7Nye3551mioFZpZwZT
yVP5ON3UOj/2El3HsHj6W7JWRFmywlFLDqmzQj7gJgEujjrShED/LCnyXl2pKE7q
bBgHuMGzGUKPMci+Sk5Zxx0b+vkT86QJh4iAu57aHAMUgS3McoS7YcOGnyp9rBfs
SL9lyYHrw9O+kTW1RCr5lvffWbmCU1ap/34/UBNrObRbrlF/fRAaiAC5bxh17C8R
bf35uSj8sqxlKEQqMlyR7xXYqogF8AIM84+HhjcDDP3u4EMyOXM=
=qAuA
-----END PGP SIGNATURE-----

--i/CQJCAqWP/GQJtX--
