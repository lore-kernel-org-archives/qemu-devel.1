Received: from eggs.gnu.org ([2001:4830:134:3::10]:35616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eOnTq-0008RG-UG
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 11:32:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eOnTp-0006Q5-UR
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 11:32:30 -0500
References: <20171207203036.14993-1-eblake@redhat.com>
	<20171207203036.14993-10-eblake@redhat.com>
	<c0b4ca07-0404-963a-bd1f-9d182eebf469@virtuozzo.com>
	<bc667ec3-4107-4578-d236-5b914d1291a5@redhat.com>
	<f0d2401d-95e5-75a3-6112-7ef3fc3f9113@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e7ac8195-d017-304f-06f1-544ceb7b1bf4@redhat.com>
Date: Tue, 12 Dec 2017 10:32:18 -0600
MIME-Version: 1.0
In-Reply-To: <f0d2401d-95e5-75a3-6112-7ef3fc3f9113@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3iklPoOxp933MMFUHurhKdTavWAg5pFPT"
Subject: Re: [Qemu-devel] [PATCH v6 09/20] parallels: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3iklPoOxp933MMFUHurhKdTavWAg5pFPT
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <e7ac8195-d017-304f-06f1-544ceb7b1bf4@redhat.com>
Subject: Re: [PATCH v6 09/20] parallels: Switch to .bdrv_co_block_status()
References: <20171207203036.14993-1-eblake@redhat.com>
 <20171207203036.14993-10-eblake@redhat.com>
 <c0b4ca07-0404-963a-bd1f-9d182eebf469@virtuozzo.com>
 <bc667ec3-4107-4578-d236-5b914d1291a5@redhat.com>
 <f0d2401d-95e5-75a3-6112-7ef3fc3f9113@virtuozzo.com>
In-Reply-To: <f0d2401d-95e5-75a3-6112-7ef3fc3f9113@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/11/2017 09:24 AM, Vladimir Sementsov-Ogievskiy wrote:

>> On the other hand, '<< BDRV_SECTOR_BITS' only produces the same size
>> output as the input; if the left side is 32 bits, it risks overflowing=
=2E
>> But '* BDRV_SECTOR_SIZE' always produces a 64-bit value.=C2=A0 So I've=

>> learned (from past mistakes in other byte-conversion series) that the
>> multiply form is less likely to introduce unintended truncation bugs.
>=20
> hm, now I doubt. I've wrote tiny program:
>=20
> #include <stdint.h>
> #include <stdio.h>
>=20
> int main() {
> =C2=A0=C2=A0=C2=A0 uint32_t blocks =3D 1 << 20;
> =C2=A0=C2=A0=C2=A0 int block_bits =3D 15;
> =C2=A0=C2=A0=C2=A0 uint32_t block_size =3D 1 << block_bits;
> =C2=A0=C2=A0=C2=A0 uint64_t a =3D blocks * block_size;
> =C2=A0=C2=A0=C2=A0 uint64_t b =3D blocks << block_bits;
> =C2=A0=C2=A0=C2=A0 uint64_t c =3D (uint64_t)blocks * block_size;

Not the same.  'block_size' in your code is 'uint32_t', so your
multiplication is still 32-bit if you don't cast blocks; while qemu has::=


include/block/block.h:#define BDRV_SECTOR_BITS   9
include/block/block.h:#define BDRV_SECTOR_SIZE   (1ULL << BDRV_SECTOR_BIT=
S)

and the 1ULL in the qemu definition forces 'unsigned long long' results
whether or not you cast.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3iklPoOxp933MMFUHurhKdTavWAg5pFPT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlowBJIACgkQp6FrSiUn
Q2pCIgf/ayXeTlq1wWPHESoHj3YlZsVYmTEOsvH7Lr6WS11uR9D/eMVSe/fVRiOh
wBkpFyPs/eRNW26j//K/Z/MDkjStAM5mljWUdA7YpTvv8zJfiZbIejQYR3215zMF
svZ9H3wZ7sn6kTzHEL1anNMtgbO+LYYkU6n7zXoGyET1zDmNW6i5Mb3cc5N6b3zW
xKyQuThXEcYIcZ38DLgy13wSofZHcDe7ge6vGkTbDtaLaO/kjWV1ob0skmtaOBzh
xzdEZicz9wN1LrrmvITtPx8SUCNhRvTS+D4bzF7k9Ifaii73QEBqfsLUgxHiIMyO
u7R3eTQ9WjQiwUdVM1x7haNYSnW3XQ==
=dKyU
-----END PGP SIGNATURE-----

--3iklPoOxp933MMFUHurhKdTavWAg5pFPT--
