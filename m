Received: from eggs.gnu.org ([2001:4830:134:3::10]:43483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duYWn-0000K3-TV
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:30:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duYWm-0001my-F9
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:30:33 -0400
Date: Wed, 20 Sep 2017 16:17:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170920061756.GJ5520@umbus.fritz.box>
References: <20170913073519.GK7550@umbus.fritz.box>
	<8760clsw17.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170915064830.GI5250@umbus.fritz.box>
	<87377omkuk.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170915085115.GN5250@umbus.fritz.box>
	<87y3pgl45f.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170919082421.GU27153@umbus>
	<871sn2hugn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920045524.GH5520@umbus.fritz.box>
	<87y3pagdg0.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dwWFXG4JqVa0wfCP"
Content-Disposition: inline
In-Reply-To: <87y3pagdg0.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
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


--dwWFXG4JqVa0wfCP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2017 at 10:43:19AM +0530, Nikunj A Dadhania wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> > On Wed, Sep 20, 2017 at 09:50:24AM +0530, Nikunj A Dadhania wrote:
> >> David Gibson <david@gibson.dropbear.id.au> writes:
> >>=20
> >> > On Fri, Sep 15, 2017 at 02:39:16PM +0530, Nikunj A Dadhania wrote:
> >> >> David Gibson <david@gibson.dropbear.id.au> writes:
> >> >>=20
> >> >> > On Fri, Sep 15, 2017 at 01:53:15PM +0530, Nikunj A Dadhania wrote:
> >> >> >> David Gibson <david@gibson.dropbear.id.au> writes:
> >> >> >>=20
> >> >> >> >>=20
> >> >> >> >> I thought, I am doing the same here for PowerNV, number of on=
line cores
> >> >> >> >> is equal to initial online vcpus / threads per core
> >> >> >> >>=20
> >> >> >> >>    int boot_cores_nr =3D smp_cpus / smp_threads;
> >> >> >> >>=20
> >> >> >> >> Only difference that I see in PowerNV is that we have multipl=
e chips
> >> >> >> >> (max 2, at the moment)
> >> >> >> >>=20
> >> >> >> >>         cores_per_chip =3D smp_cpus / (smp_threads * pnv->num=
_chips);
> >> >> >> >
> >> >> >> > This doesn't make sense to me.  Cores per chip should *always*=
 equal
> >> >> >> > smp_cores, you shouldn't need another calculation for it.
> >> >> >> >
> >> >> >> >> And in case user has provided sane smp_cores, we use it.
> >> >> >> >
> >> >> >> > If smp_cores isn't sane, you should simply reject it, not try =
to fix
> >> >> >> > it.  That's just asking for confusion.
> >> >> >>=20
> >> >> >> This is the case where the user does not provide a topology(whic=
h is a
> >> >> >> valid scenario), not sure we should reject it. So qemu defaults
> >> >> >> smp_cores/smt_threads to 1. I think it makes sense to over-ride.
> >> >> >
> >> >> > If you can find a way to override it by altering smp_cores when i=
t's
> >> >> > not explicitly specified, then ok.
> >> >>=20
> >> >> Should I change the global smp_cores here as well ?
> >> >
> >> > I'm pretty uneasy with that option.
> >>=20
> >> Me too.
> >>=20
> >> > It would take a fair bit of checking to ensure that changing smp_cor=
es
> >> > is safe here. An easier to verify option would be to make the generic
> >> > logic which splits up an unspecified -smp N into cores and sockets
> >> > more flexible, possibly based on machine options for max values.
> >> >
> >> > That might still be more trouble than its worth.
> >>=20
> >> I think the current approach is the simplest and less intrusive, as we
> >> are handling a case where user has not bothered to provide a detailed
> >> topology, the best we can do is create single threaded cores equal to
> >> number of cores.
> >
> > No, sorry.  Having smp_cores not correspond to the number of cores per
> > chip in all cases is just not ok.  Add an error message if the
> > topology isn't workable for powernv by all means.  But users having to
> > use a longer command line is better than breaking basic assumptions
> > about what numbers reflect what topology.
>=20
> Sorry to ask again, as I am still not convinced, we do similar
> adjustment in spapr where the user did not provide the number of cores,
> but qemu assumes them as single threaded cores and created
> cores(boot_cores_nr) that were not same as smp_cores ?

What?  boot_cores_nr has absolutely nothing to do with adjusting the
topology, and it certainly doesn't assume they're single threaded.

boot_cores_nr is simply the number of cores (each of smp_threads
threads) which are online initially.  In an sPAPR system there are
max_cpus total potential threads.  Those are divided into cores each
with smp_threads threads (so max_cpus / smp_threads total cores), and
those cores are divided into sockets each with smp_cores sockets (so
max_cpus / smp_threads / smp_cores total sockets).  Of all those
potential threads smp_cpus are initially online (the rest can be
hotplugged later), so there are smp_cpus / smp_threads cores initially
online.

We need that calculation because we can only hotplug cpus on spapr at
core granularity, not thread granularity (x86 can do that).  If
smp_cpus is not a multiple of smp_threads we give an error (except for
old machine types, where we have some hacks for backwards compat).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dwWFXG4JqVa0wfCP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnCCBIACgkQbDjKyiDZ
s5JTMhAAgPKFG2jc2Rgk/qgB1RikEBIWhuu9TfLQA0fXD/oY8SG1eScslMvRBtJB
HH/cw/YeiWB0w90Hko8zU3TiW5O5GEZ8N9bLJsnQujoabv9szbPgLS+ZmAkOmQZ2
Tiilu1ndeQfLOFYazYyUzyAodoo5WIDAljtKwCzWL1bnC+wouCs6Fn2n1MzIlp2p
WTXTFu2k2+9l5HsJXLr+Y7Q6H84q+XSqb1Sqa++66ueAt5kOlQ7Iwf+8gWv+zApK
D+JLrUSgZJo43YsDfJeA9Jbl6DO5Y29/jrsKQE28BY5ZzIqN9Cu28i+5wyJSWe/D
hX4zMQWJnqvozOjHbUQvHlncsUFSal8jYbVqO0JM6sAQCMdT2cgUkMUmcWlJhjG5
CaT0z2bZI/aXbJS62tirxoRb31AURhtXROEcC9lIbshOwwTGdBKOHI9ARHRb/83K
Moem38I9hvQICHaN4uAj2CBGlZMfaz87wKaUJ3JXx/V1JSh/4in1yKNTXoaYYAy0
Agre6etuQerKB7wBgsECXwr09E5Lqx+3zraCMLNjijQAKry8yl9vTjLlQsAaMcgW
VkbdxxbOhorXebS3ZHupgF7LcTfKOuyMIFH4OJbtFXVARlpLm2fI+rCU+eLf8bVl
qu4qILSrqJ4XtYrqwDI2S8tyXder29grAVr2ZQXKUqob4AYtCzk=
=Veb3
-----END PGP SIGNATURE-----

--dwWFXG4JqVa0wfCP--
