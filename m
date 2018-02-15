Received: from eggs.gnu.org ([2001:4830:134:3::10]:60394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emAqS-0006V0-HR
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:08:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emAqR-0001Fh-95
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:08:28 -0500
Date: Thu, 15 Feb 2018 15:08:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180215040818.GH5247@umbus.fritz.box>
References: <151863720814.3003.4939908778788942974.stgit@bahia.lan>
	<151863726311.3003.8227524786940828598.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fd5uyaI9j6xoeUBo"
Content-Disposition: inline
In-Reply-To: <151863726311.3003.8227524786940828598.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 5/5] spapr: drop DIV_ROUND_UP() from
 xics_max_server_number()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Sam Bobroff <sam.bobroff@au1.ibm.com>, Laurent Vivier <lvivier@redhat.com>


--fd5uyaI9j6xoeUBo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2018 at 08:41:03PM +0100, Greg Kurz wrote:
> XICS needs to know the highest VCPU id that may be presented to the
> guest plus 1. Commit f303f117fec3 "spapr: ensure we have at least one
> XICS server" changed how the maximum is computed from:
>=20
>         smp_cpus * kvmppc_smt_threads() / smp_threads
>=20
> to:
>=20
>         DIV_ROUND_UP(smp_cpus * kvmppc_smt_threads(), smp_threads)
>=20
> This was done because at the time we could pass broken CPU topologies
> to the -smp command line options, such as threads=3D9,cpus=3D1. On a POWE=
R8
> host this would give:
>=20
>         1 * 8 / 9 =3D=3D 0 servers
>=20
> and cause QEMU to crash later during XICS setup.
>=20
> The formulat evolved a bit to accomodate CPU hot-plug and VSMT, but
> most important, stricter checks are performed on the CPU topology.
>=20
> With -smp threads=3D9,cpus=3D1:
>=20
> qemu-system-ppc64:
>  cpu topology: sockets (1) * cores (1) * threads (9) > maxcpus (1)
>=20
> With -smp threads=3D9,maxcpus=3D1:
>=20
> qemu-system-ppc64: maxcpus must be equal to or greater than smp
>=20
> More generally, machine types with hotplug support (2.7 and up), no
> longer allow to set maxcpus or smp_cpus to a value that isnt't a
> multiple of smp_threads.
>=20
> With -smp threads=3D4,cpus=3D6:
>=20
> qemu-system-ppc64: smp_cpus (6) must be multiple of threads (4)
>=20
> With -smp threads=3D4,maxcpus=3D6:
>=20
> qemu-system-ppc64: max_cpus (6) must be multiple of threads (4)
>=20
> This means that the division is perfect and we don't need DIV_ROUND_UP(),
> and we could do a regular division:
>=20
>         max_cpus * spapr->vsmt / smp_threads
>=20
> So this patch changes xics_max_server_number() to use the spapr_vcpu_id(),
> which works too since max_cpus is a multiple of smp_threads:
>=20
>     (max_cpus / smp_threads ) * spapr->vsmt + max_cpus % smp_threads
>=20
> It breaks migration of pre-2.7 machine types with unusual CPU topologies,
> but I guess this is an acceptable trade-off.

No, not really.  Weird topologies are still allowed on old machine
types for backwards compatibility, and we shouldn't break that.  I
like the idea of consolidating this calculation, but we can't do it by
just breaking the older machines (at least not until they're formally
deprecated).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fd5uyaI9j6xoeUBo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqFB7IACgkQbDjKyiDZ
s5Lidg/7BNMlKdKTG72+eyJALWbYbYwXX5qnKd4JKSlwtqkL56jFBrsyZh8cc1Mg
pNLLXF8xrzVEgre8PW+/P3aYiNjC67ZsAZWDyqT+7dlb3McWh86sTSHiUHYBymiI
1tlkG0k1EFcXuPcxBb6dYqHCH7GbYMjdL1ybbQdZjDT6e7q123Gn9I7vuRQCAAjo
ifvnTDYLhMhX6HgYKT210YoqZPhA9EjlbJNk1DVtRpnhFlZLpr/TNOqvzTuPLKE6
E37OK7mKD5r6X40Rv36pOVpbUXZi7rjprg2JRJDlzd+7ws6TOOEWJ2RHrxwG4iEs
ygMQl4NnS5Fj/OpduoVyDQhFZ3bvBd52IgmPz5kCthu0bw+UDNVzZ2/kCCEFZQu6
KBGycisISvsSMWdLfbhfBJQKOetfVHz0wS9r3BpbIjcTk6E4Pa1zLjyQ0YFkhxYC
SSBvt2dIvfkNcBvgvU2FOneiZHNvNDsrqcCJ1cZdwlv9k7pHZb3vBKe8/Pi4S/oQ
6/GxiUBOAQ6PPMtDO5QlhaA7KfygA3FwJj0OyXwI5G3oEDAaqxIZGNiUJ4QOI42I
7EDHlVbBFpbSPJCSz1RN9/jAEEudsXyImMh0L1/cioBXnLxXGLNe6Wu5XHeMcldc
9PUu8MWVLKE7UaIVZbc3auwzNI2aea0wV91PzY+NVYcvkhc+MrQ=
=aq0L
-----END PGP SIGNATURE-----

--fd5uyaI9j6xoeUBo--
