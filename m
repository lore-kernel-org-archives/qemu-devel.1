Received: from eggs.gnu.org ([2001:4830:134:3::10]:43407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duYxX-0002ci-V8
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:58:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duYxW-0004jV-Ii
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:58:12 -0400
Date: Wed, 20 Sep 2017 16:57:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170920065700.GO5520@umbus.fritz.box>
References: <20170915064830.GI5250@umbus.fritz.box>
	<87377omkuk.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170915085115.GN5250@umbus.fritz.box>
	<87y3pgl45f.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170919082421.GU27153@umbus>
	<871sn2hugn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920045524.GH5520@umbus.fritz.box>
	<87y3pagdg0.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920061756.GJ5520@umbus.fritz.box>
	<87vakdhnyn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IpgPcFyQO6wM49Um"
Content-Disposition: inline
In-Reply-To: <87vakdhnyn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
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


--IpgPcFyQO6wM49Um
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2017 at 12:10:48PM +0530, Nikunj A Dadhania wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> > On Wed, Sep 20, 2017 at 10:43:19AM +0530, Nikunj A Dadhania wrote:
> >> David Gibson <david@gibson.dropbear.id.au> writes:
> >>=20
> >> > On Wed, Sep 20, 2017 at 09:50:24AM +0530, Nikunj A Dadhania wrote:
> >> >> David Gibson <david@gibson.dropbear.id.au> writes:
> >> >>=20
> >> >> > On Fri, Sep 15, 2017 at 02:39:16PM +0530, Nikunj A Dadhania wrote:
> >> >> >> David Gibson <david@gibson.dropbear.id.au> writes:
> >> >> >>=20
> >> >> >> > On Fri, Sep 15, 2017 at 01:53:15PM +0530, Nikunj A Dadhania wr=
ote:
> >> >> >> >> David Gibson <david@gibson.dropbear.id.au> writes:
> >> >> >> >>=20
> >> >> >> >> >>=20
> >> >> >> >> >> I thought, I am doing the same here for PowerNV, number of=
 online cores
> >> >> >> >> >> is equal to initial online vcpus / threads per core
> >> >> >> >> >>=20
> >> >> >> >> >>    int boot_cores_nr =3D smp_cpus / smp_threads;
> >> >> >> >> >>=20
> >> >> >> >> >> Only difference that I see in PowerNV is that we have mult=
iple chips
> >> >> >> >> >> (max 2, at the moment)
> >> >> >> >> >>=20
> >> >> >> >> >>         cores_per_chip =3D smp_cpus / (smp_threads * pnv->=
num_chips);
> >> >> >> >> >
> >> >> >> >> > This doesn't make sense to me.  Cores per chip should *alwa=
ys* equal
> >> >> >> >> > smp_cores, you shouldn't need another calculation for it.
> >> >> >> >> >
> >> >> >> >> >> And in case user has provided sane smp_cores, we use it.
> >> >> >> >> >
> >> >> >> >> > If smp_cores isn't sane, you should simply reject it, not t=
ry to fix
> >> >> >> >> > it.  That's just asking for confusion.
> >> >> >> >>=20
> >> >> >> >> This is the case where the user does not provide a topology(w=
hich is a
> >> >> >> >> valid scenario), not sure we should reject it. So qemu defaul=
ts
> >> >> >> >> smp_cores/smt_threads to 1. I think it makes sense to over-ri=
de.
> >> >> >> >
> >> >> >> > If you can find a way to override it by altering smp_cores whe=
n it's
> >> >> >> > not explicitly specified, then ok.
> >> >> >>=20
> >> >> >> Should I change the global smp_cores here as well ?
> >> >> >
> >> >> > I'm pretty uneasy with that option.
> >> >>=20
> >> >> Me too.
> >> >>=20
> >> >> > It would take a fair bit of checking to ensure that changing smp_=
cores
> >> >> > is safe here. An easier to verify option would be to make the gen=
eric
> >> >> > logic which splits up an unspecified -smp N into cores and sockets
> >> >> > more flexible, possibly based on machine options for max values.
> >> >> >
> >> >> > That might still be more trouble than its worth.
> >> >>=20
> >> >> I think the current approach is the simplest and less intrusive, as=
 we
> >> >> are handling a case where user has not bothered to provide a detail=
ed
> >> >> topology, the best we can do is create single threaded cores equal =
to
> >> >> number of cores.
> >> >
> >> > No, sorry.  Having smp_cores not correspond to the number of cores p=
er
> >> > chip in all cases is just not ok.  Add an error message if the
> >> > topology isn't workable for powernv by all means.  But users having =
to
> >> > use a longer command line is better than breaking basic assumptions
> >> > about what numbers reflect what topology.
> >>=20
> >> Sorry to ask again, as I am still not convinced, we do similar
> >> adjustment in spapr where the user did not provide the number of cores,
> >> but qemu assumes them as single threaded cores and created
> >> cores(boot_cores_nr) that were not same as smp_cores ?
> >
> > What?  boot_cores_nr has absolutely nothing to do with adjusting the
> > topology, and it certainly doesn't assume they're single threaded.
>=20
> When we start a TCG guest and user provides following commandline, e.g.
> "-smp 4", smt_threads is set to 1 by default in vl.c. So the guest boots
> with 4 cores, each having 1 thread.

Ok.. and what's the problem with that behaviour on powernv?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IpgPcFyQO6wM49Um
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnCEToACgkQbDjKyiDZ
s5KpgxAA2TneHZbt6Gc/XTHesCJk2qkh+ZvfhotLOKKz4MTJjeJVer2IQdo32sO3
/YvgxXt7gDlBeEIIsOENO81KjvNHaLroTxsuPySY9ZHFm5LjpfAHIKm6AA8k+7h5
jAtcxft1r1sFjkrqT/sQke19CUYRKlKDes0aMExv74SImTdZNemm6FzLCLnox/rx
wxvZqWoYTQV09nYWG67rDpgdrWAu+4G4suMly5dfDYGCMU/32XKGjFxp05wLwimT
RQgqdxZdLwahsZyAkwzlxLbVs7OqOCUuNZtOTEI0u0WMtvl6FjJZo29geHXFv0al
s1wcUAHaJTYIqf5ohQjjfpxuuH2k4Ewolsyk0z6D4Av9ItDcOQp3xsIeqkzdOJVw
fL4lgaQQ2NrerwAMXQgnV9hzpQOAS3Gq8E2+hFB9pOjeKjInZG4CKiOtot7GXR3v
hNK3dMRw78HvRUTzYzyWcYZ2IrpYzNOLQLux2tH1BQRCadUctlIonwUsKX4ZFZYq
ySK3iYTFA6aZlUiQI16BvGaXZ2VgfQXjceNWTSUldVlecMSHJCZzj/H1jq+0za1W
DjWDeAYN1XtYer/wp5kbDUA7CjYMgiZ/AptYtrEa3SEeg5xkzefGkaHmvMKA23fW
zHnRy4UiBAWWslSU0BVyc0lkiYg1pSEKD4lNoI5WEu6s2Jd6gsg=
=rfRV
-----END PGP SIGNATURE-----

--IpgPcFyQO6wM49Um--
