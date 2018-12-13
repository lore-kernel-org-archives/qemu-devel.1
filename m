Received: from eggs.gnu.org ([2001:4830:134:3::10]:34874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXHce-0003ie-Ti
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 22:25:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXHcb-000554-Nz
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 22:25:12 -0500
Received: from ozlabs.org ([203.11.71.1]:51563)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gXHcV-0004u8-3d
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 22:25:05 -0500
Date: Thu, 13 Dec 2018 14:24:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181213032452.GA25689@umbus.fritz.box>
References: <20180830143348.10595-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <20180830143348.10595-1-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] seccomp: check TSYNC host capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, otubo@redhat.com


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2018 at 04:33:48PM +0200, Marc-Andr=E9 Lureau wrote:
> Remove -sandbox option if the host is not capable of TSYNC, since the
> sandbox will fail at setup time otherwise. This will help libvirt, for
> ex, to figure out if -sandbox will work.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

This seems to have introduced a regression, which I found when
preparing a ppc pull request.  Specifically when running with RHEL7 on
a POWER host, using "-sandbox off" which one of my tests did, causes a
cryptic error followed by a SEGV:

$ ./ppc64-softmmu/qemu-system-ppc64 -sandbox off
qemu-system-ppc64: -sandbox off: There is no option group 'sandbox'
Segmentation fault
$ ./x86_64-softmmu/qemu-system-x86_64 -sandbox off
qemu-system-x86_64: -sandbox off: There is no option group 'sandbox'
Segmentation fault

I think the problem is that while this wrapped one use of the sandbox
option group to produce a sensible error, it didn't do the same for
another call to qemu_opts_parse_noisily():

(gdb) bt
#0  0x00000000105b36d8 in opts_parse (list=3D0x0, params=3D0x3ffffffffab5 "=
off", permit_abbrev=3Dtrue, defaults=3Dfalse, errp=3D0x3ffffffff080)
    at util/qemu-option.c:829
#1  0x00000000105b3b74 in qemu_opts_parse_noisily (list=3D<optimized out>, =
params=3D<optimized out>, permit_abbrev=3D<optimized out>) at util/qemu-opt=
ion.c:890
#2  0x0000000010024964 in main (argc=3D<optimized out>, argv=3D<optimized o=
ut>, envp=3D<optimized out>) at vl.c:3589

I'm guessing RHEL7 triggers it because that has a version of
libseccomp that doesn't support the feature needed to complete
registration (maybe on ppc host only; I haven't had a chance to try on
an x86 RHEL7 host).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwR0QIACgkQbDjKyiDZ
s5LB5xAAwVlekPEQ30LyWDPSiN3NiCm3tmoyFVIZy4SBFscIhzKC4n+6K1QUmLIL
Uvm4P51Z7qBFQqrbilu9kyKrPgeMKvYs4ipDhTGn+rbiuotOMsh5Op/qGNcbDZfh
VTtV3xF7z1StoxH8/Ba27kDp9FDnNOdL0aN2Zsxc61P+NpqPUpl1k+qT1A7FB4Yz
Nz5MdKGEqexCzmCpHp/0ZgVeoCeBXJvVcfBQtK04TI5AHOsGVHZAVoJYZstEDbN4
EnEMC3q+YIPyQ+D7sqHt3pTgu22LmzRZbSFUNVZ+HDD5lGpXO6fnuweTyCqA5un/
4IUiDSpUFLcEAMq3WDHkuTVUU29u1j09SGs+bCgOYwE6cUOwJ0mvQUVEGMBgUKjy
3NT+PM4McXt0L1WvD6Wn5VGs7b0oTUdDorhmTCAee+Bn8oWP3aJH0FXJhauBq9FO
1rlRLlEpED3lsU60ZSOIoqdohlfcdSSZ00yDJHKkTOuH6OGIJl6IAytUqql6unzc
pPd2bl0XyRtn4HHp32srIBBxNkdpeIrfTftfE+l7uE2vV5Uoh3DDja6yCjsFb2t3
zjfrl1SK86/rZqFiScTyq+xQFwvTtW+gC+LMWKpQ+JqkuzriJKdqYjbxfa1olfHo
eeSDxiWH5xcebTAv9cLeGypUUoDTmJyV9IavvbldcWDeibRLwQI=
=dP5h
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
