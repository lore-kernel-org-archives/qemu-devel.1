Received: from eggs.gnu.org ([2001:4830:134:3::10]:37847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cqjhY-0004pf-8D
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cqjhX-0002yN-BU
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:05:36 -0400
References: <1490034784-28177-1-git-send-email-peter.maydell@linaro.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3fabb88e-1c20-129f-e31b-2268402cc84e@redhat.com>
Date: Wed, 22 Mar 2017 18:05:26 +0100
MIME-Version: 1.0
In-Reply-To: <1490034784-28177-1-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dNr8bpbAkGAs3Bnlk1Von2J2axWvhO2sn"
Subject: Re: [Qemu-devel] [PATCH for-2.9?] block/file-posix.c: Fix unused
 variable warning on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dNr8bpbAkGAs3Bnlk1Von2J2axWvhO2sn
From: Max Reitz <mreitz@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, patches@linaro.org
Message-ID: <3fabb88e-1c20-129f-e31b-2268402cc84e@redhat.com>
Subject: Re: [PATCH for-2.9?] block/file-posix.c: Fix unused variable warning
 on OpenBSD
References: <1490034784-28177-1-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1490034784-28177-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 20.03.2017 19:33, Peter Maydell wrote:
> On OpenBSD none of the ioctls probe_logical_blocksize() tries
> exist, so the variable sector_size is unused. Refactor the
> code to avoid this (and reduce the duplicated code).
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> The alternative would be to move the variable so it was
> local to a code block inside each #ifdef, but this seemed
> a bit nicer anyway.
>=20
> Tentatively tagged 'for-2.9' just because this is the only
> warning in the OpenBSD build, but I don't insist on it.

I'm fine with targeting 2.9.

> I've opted to retain the existing behaviour of "try every
> ioctl available and use the last one that works" rather
> than "stop as soon as something worked".
>=20
> ---
>  block/file-posix.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 53febd3..b980d23 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -219,28 +219,28 @@ static int probe_logical_blocksize(int fd, unsign=
ed int *sector_size_p)
>  {
>      unsigned int sector_size;
>      bool success =3D false;
> +    int i;
> =20
>      errno =3D ENOTSUP;
> -
> -    /* Try a few ioctls to get the right size */
> +    unsigned long ioctl_list[] =3D {
>  #ifdef BLKSSZGET
> -    if (ioctl(fd, BLKSSZGET, &sector_size) >=3D 0) {
> -        *sector_size_p =3D sector_size;
> -        success =3D true;
> -    }
> +        BLKSSZGET,
>  #endif
>  #ifdef DKIOCGETBLOCKSIZE
> -    if (ioctl(fd, DKIOCGETBLOCKSIZE, &sector_size) >=3D 0) {
> -        *sector_size_p =3D sector_size;
> -        success =3D true;
> -    }
> +        DKIOCGETBLOCKSIZE,
>  #endif
>  #ifdef DIOCGSECTORSIZE
> -    if (ioctl(fd, DIOCGSECTORSIZE, &sector_size) >=3D 0) {
> -        *sector_size_p =3D sector_size;
> -        success =3D true;
> -    }
> +        DIOCGSECTORSIZE,
>  #endif
> +    };
> +
> +    /* Try a few ioctls to get the right size */
> +    for (i =3D 0; i < ARRAY_SIZE(ioctl_list); i++) {

On 32-bit, though:

=2E/block/file-posix.c: In function =E2=80=98probe_logical_blocksize=E2=80=
=99:
=2E/qemu/block/file-posix.c:229:19: error: comparison of unsigned
expression < 0 is always false [-Werror=3Dtype-limits]

A cast (int)ARRAY_SIZE() would fix that (I had the same problem once...).=


Max

> +        if (ioctl(fd, ioctl_list[i], &sector_size) >=3D 0) {
> +            *sector_size_p =3D sector_size;
> +            success =3D true;
> +        }
> +    }
> =20
>      return success ? 0 : -errno;
>  }
>=20



--dNr8bpbAkGAs3Bnlk1Von2J2axWvhO2sn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljSrtYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AxsUH/0uoTZ7wRTt013kDDjad6D7xnHXJi0MU
oXNn3UvZQ+ua1hANR3nMHiFvw1c5l0X8mBJz0lKo3yz3AoHiAtJqVKBwcjfJHzjY
s+62f6jDGuLFqiauVEcOnbgq+t4RS529893Sf3KCd03SvZI7AqFPAvTUipEmG+iC
n3uHLQuJkTyELbrImprOU119SKyuHk8+JAvMHOAn2oUP38uoeU/ZPDUkI0Qs08nU
chiYcqAmkptUp1cEgOWEuv7Hr2ziiF1/2CcOFiGsq2mdOQROALgUhHQjz7jhTC8L
ODmGAD+oId8KdXqMM+ObnWm11kjUvLv578QTnGZfz05X4x8v4jb4lLA=
=5sGP
-----END PGP SIGNATURE-----

--dNr8bpbAkGAs3Bnlk1Von2J2axWvhO2sn--
