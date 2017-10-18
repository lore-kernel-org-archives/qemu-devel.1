Received: from eggs.gnu.org ([2001:4830:134:3::10]:36371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4pF8-0004Lb-ID
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:22:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4pF7-0004h1-AO
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:22:46 -0400
References: <cover.1508257445.git.jcody@redhat.com>
	<85b170e6abd3f92bee7449d0970f6ba24e589c72.1508257445.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c93322b0-3d5d-2467-3d75-75e40ad83a9b@redhat.com>
Date: Wed, 18 Oct 2017 09:22:31 -0500
MIME-Version: 1.0
In-Reply-To: <85b170e6abd3f92bee7449d0970f6ba24e589c72.1508257445.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="A6R6xKUjTEWHOSEwGeNGOfmwEV1TTdbCf"
Subject: Re: [Qemu-devel] [PATCH v5 05/10] qemu-iotests: change qemu pid and
 fd tracking / cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--A6R6xKUjTEWHOSEwGeNGOfmwEV1TTdbCf
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com,
 kwolf@redhat.com
Message-ID: <c93322b0-3d5d-2467-3d75-75e40ad83a9b@redhat.com>
Subject: Re: [PATCH v5 05/10] qemu-iotests: change qemu pid and fd tracking /
 cleanup
References: <cover.1508257445.git.jcody@redhat.com>
 <85b170e6abd3f92bee7449d0970f6ba24e589c72.1508257445.git.jcody@redhat.com>
In-Reply-To: <85b170e6abd3f92bee7449d0970f6ba24e589c72.1508257445.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/17/2017 11:31 AM, Jeff Cody wrote:
> So that later patches can cleanup running qemu processes called from
> different subshells, track resources to cleanup in pid and fd list
> files.
>=20
> In subsquent patches, ./check will kill all QEMU processes launched wit=
h
> the common.qemu framework, and the tests will not need to cleanup
> manually (unless they want to do so as part of the test, e.g. wait for
> a process to end such as migration).
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  tests/qemu-iotests/common.qemu | 82 ++++++++++++++++++++++++++++++++--=
--------
>  tests/qemu-iotests/common.rc   |  3 +-
>  2 files changed, 64 insertions(+), 21 deletions(-)

Modulo the typo in the commit message in response to your other tweaks,


> +    # get line count, and therefore number of processes to kill
> +    numproc=3D$(wc -l "${QEMU_PID_LIST}" | sed 's/\s.*//')

Instead of having to use sed, just do:

numproc=3D$(wc -l < "${QEMU_PID_LIST}")

wc is required to behave differently when parsing stdin than when
parsing a named file, so you might as well take advantage of it.

> +
> +    for i in $(seq 1 $numproc)

Are we sure seq is always available?  Shave a subshell, and avoid the
dependency, by using bash's:

for i in {1..$numproc}

> +++ b/tests/qemu-iotests/common.rc
> @@ -40,7 +40,6 @@ poke_file()
>      printf "$3" | dd "of=3D$1" bs=3D1 "seek=3D$2" conv=3Dnotrunc &>/de=
v/null
>  }
> =20
> -
>  if ! . ./common.config

Spurious whitespace change?



--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--A6R6xKUjTEWHOSEwGeNGOfmwEV1TTdbCf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnnY6cACgkQp6FrSiUn
Q2ofXQgAoNHlHks6Vkqg/P62dvLhABhM8lM6g9NCoL+sDgKvk6YxQyBDYN+1y4IS
QY0teNECvOX8ycuILpDwzTUN6PSWThy3zCbkclM4sdBxXOG/MfSlWFCyEsZDpPZs
Sl9xLj5B5kobDz7VPcjWDghTXJubjosqUeJSmRAK+BxPByCVGQPN0POeYNOhVFTb
opwcyjuMbvkhNsdm6egxioeYTf5prVmXhchseKQu21/MeGYu4kTvIF7pRboNF3qx
HBfQ8CaFpNWHCvkcOEPSQbyGSzjIj6rxQSH2H6RT7xrIDKJ+IMvijEpa5u0fmnOF
uykmouh3khCKALFPigyFXlhJ9QRbMg==
=45lF
-----END PGP SIGNATURE-----

--A6R6xKUjTEWHOSEwGeNGOfmwEV1TTdbCf--
