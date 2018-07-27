Received: from eggs.gnu.org ([2001:4830:134:3::10]:39156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1firHU-0002pS-W9
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 21:10:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1firHR-0006JU-PN
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 21:10:56 -0400
Date: Fri, 27 Jul 2018 11:09:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180727010917.GB3694@umbus.fritz.box>
References: <20180504042044.10318-1-mdroth@linux.vnet.ibm.com>
	<20180726050746.GC12001@umbus.fritz.box>
	<c23b3b10-a73b-24c8-36c5-114933d9b41b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline
In-Reply-To: <c23b3b10-a73b-24c8-36c5-114933d9b41b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: only save guest timebase once
 after stopping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 26, 2018 at 09:44:11AM +0200, Laurent Vivier wrote:
> On 26/07/2018 07:07, David Gibson wrote:
> > On Thu, May 03, 2018 at 11:20:44PM -0500, Michael Roth wrote:
> >> In some cases (e.g. spapr) we record guest timebase after qmp_stop()
> >> via a runstate hook so we can restore it on qmp_cont(). If a migration
> >> occurs in between those events we end up saving it again, this time
> >> based on the current timebase the guest would be seeing had it been
> >> running. This has the effect of advancing the guest timebase while
> >> it is stopped, which is not what the code intends.
> >>
> >> Other than simple jumps in time, this has been seen to trigger what
> >> appear to be RCU-related crashes in recent kernels when the advance
> >> exceeds rcu_cpu_stall_timeout, and it can be triggered by fairly
> >> common operations such as `virsh migrate ... --timeout 60`.
> >>
> >> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> >> Cc: David Gibson <david@gibson.dropbear.id.au>
> >> Cc: Laurent Vivier <lvivier@redhat.com>
> >> Cc: qemu-ppc@nongnu.org
> >> Cc: qemu-stable@nongnu.org
> >> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> >=20
> > Sorry, this fell off my radar for ages, but I've finally had a chance
> > to look at it properly.
> >=20
> > I'm not totally convinced this handle all the possible edge cases
> > correctly, but I am convinced it gives behaviour that's more correct
> > than we have now.  It doesn't introduce changes to the interface or
> > migration stream that would break things in future, so I've applied it
> > to ppc-for-3.1.
>=20
> See https://bugzilla.redhat.com/show_bug.cgi?id=3D1571230#c8
>=20
> So you revert:
>=20
> commit 42043e4f1241eeb77f87f5816b5cf0b6e9583ed7
> Author: Laurent Vivier <lvivier@redhat.com>
> Date:   Fri Jan 27 13:24:58 2017 +0100
>=20
>     spapr: clock should count only if vm is running
>=20
> and change the behaviour compared to x86_64
>=20
>      6053a86 kvmclock: reduce kvmclock difference on migration
>=20
> Is this what you want?

Ah, no, not really.  I've pulled it out of 3.1 again.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltacLsACgkQbDjKyiDZ
s5J7cBAAiNXxcTIUyXokGLzmMyCVQKwVp4AIG8bhZLC8Nz+siRgzn5XkOEjGc4JU
jVYoeqvhrggf1mXDrUeiXYDc7WSVh++eMqQff1tqnAP79Mhk8q27kA9kTwWHbx43
LxS8Vnmo5V0amfz63PEn3b21WvuzSJEGhMqKCXkjfYvwUED/XAI706W8rgNwetmZ
GZmyZlcW3SLA6R5lT2OO1P7HFNuhnMQposWloDI0kBxc4EYlysINhtSNRUJkj5Ec
AAUYbxfkVLszoa2nw36OzwvATRZCDkcqIgjwxr4Hgf+n8p6Zc77PSLjpqQqWZtiV
AM+CY07E4t4vTIWTdxA3rgpYTSZIiPhdqV0Gns+zfn+io/bN1j+cH7/Bdmc+fk1E
u+N/wrByYMtvr6v0hJjWVQjZJoTtoq2+Lq2Nbxf99EIbb9goAPoj1pSbdv5d6adv
pOWT761RP3sGc3pVuScWg0lp3ADMAYscFVQ2X9QMmavXaoN4QL1NhAsoVeDWYLqU
UqirM1tL+twTiUkAgQHKQhX54mcA+X2jIHHJff7QV+2e3509xyI1L2/YzKfhxZ6H
LA4YPqlQU+3Bb8WpMQoxFNgTvqA3KGK1Mv2ZUk1f7O2t+2Y76TCS0s7/6CBjYWS7
F5iY15AzBaQwMEvsf1fgrvKAWluIa/totBYYbMrzxZvZjXSJJtA=
=tn/i
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
