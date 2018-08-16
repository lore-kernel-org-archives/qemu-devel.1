Received: from eggs.gnu.org ([2001:4830:134:3::10]:38473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fq7ds-0000Fv-5T
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:04:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fq7dr-0001nJ-C3
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:04:04 -0400
From: Max Reitz <mreitz@redhat.com>
References: <20180815025614.53588-1-eblake@redhat.com>
	<20180815025614.53588-2-eblake@redhat.com>
Message-ID: <222b07f8-4a41-04f5-c93c-727244e6d1e8@redhat.com>
Date: Thu, 16 Aug 2018 04:03:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180815025614.53588-2-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="H8xFJL4LzTG8kqw0JXFaY7Oby5au995Bb"
Subject: [Qemu-devel] [PATCH 1/2] qemu-img: Fix dd with skip= and count=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: fullmanet@gmail.com, qemu-block@nongnu.org, qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H8xFJL4LzTG8kqw0JXFaY7Oby5au995Bb
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: fullmanet@gmail.com, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <222b07f8-4a41-04f5-c93c-727244e6d1e8@redhat.com>
Subject: [PATCH 1/2] qemu-img: Fix dd with skip= and count=
References: <20180815025614.53588-1-eblake@redhat.com>
 <20180815025614.53588-2-eblake@redhat.com>
In-Reply-To: <20180815025614.53588-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-15 04:56, Eric Blake wrote:
> When both skip=3D and count=3D are active, qemu-img dd was not copying
> enough data. It didn't help that the code made the same check for
> dd.flags & C_SKIP in two separate places. Compute 'size' as the
> amount of bytes to be read, and 'end' as the offset to end at,
> rather than trying to cram both meanings into a single variable
> (which only worked as long as we had at most one of those two
> limiting factors to worry about, but not both).
>=20
> Enhance the test to cover more combinations, and expose the problem.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> CC: qemu-stable@nongnu.org
> ---
>  qemu-img.c                 | 39 ++++++++++++++++---------------------
>  tests/qemu-iotests/160     |  9 ++++++---
>  tests/qemu-iotests/160.out | 48 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  3 files changed, 70 insertions(+), 26 deletions(-)
>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index 1acddf693c6..d72f0f0ec94 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c

[...]

> @@ -4559,19 +4559,23 @@ static int img_dd(int argc, char **argv)
>          goto out;
>      }
>=20
> +    /* Overflow means the specified offset is beyond input image's siz=
e */
> +    if (dd.flags & C_SKIP && (in.offset > INT64_MAX / in.bsz ||
> +                              size < in.bsz * in.offset)) {
> +        size =3D 0;
> +        error_report("%s: cannot skip to specified offset", in.filenam=
e);

in_pos should be initialized as well (to "size", I suppose), or my gcc
will continue to complain. :-)

The rest looks good to me.

> +    } else {
> +        size -=3D in.offset * in.bsz;
> +        in_pos =3D in.offset * in.bsz;
> +    }
> +

[...]

> diff --git a/tests/qemu-iotests/160 b/tests/qemu-iotests/160
> index 5c910e5bfc1..48380a3aafc 100755
> --- a/tests/qemu-iotests/160
> +++ b/tests/qemu-iotests/160
> @@ -44,6 +44,7 @@ _supported_os Linux
>  TEST_SKIP_BLOCKS=3D"1 2 30 30K"
>=20
>  for skip in $TEST_SKIP_BLOCKS; do
> +  for count in '' 'count=3D1 '; do

Ah, so this is why we indent everything by four spaces!  So you can
squeeze in three more block headers without having to re-indent
everything.  I finally see. O:-)

(Not sure why you put a space after the 'count=3D1', though, but OK)

Max

>      echo
>      echo "=3D=3D Creating image =3D=3D"
>=20


--H8xFJL4LzTG8kqw0JXFaY7Oby5au995Bb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt024QACgkQ9AfbAGHV
z0DicQf9HAUBqIgpvV4eLKx0/3QWxXeyUY91u0jdZalkNpARyiI9z0qStFaLW1gx
Vtc/VtFMqxHF7t+BuHgXqjP9cCeeJlPSn1pdAsvsdkGC0/0RMrE86oOAlNWl932J
n0PbIjjS+I7pIiQol74lBmOQB1XRd99UByfHFLk5M1sQmQBCmS9X8Eoji7+qyug1
sgJ56Z6NXuYhq5msT2X9lkvwQY21yE6gHNDkXdpzPSOW7fapaUgvcDIKXK2izI6n
HJou/g0fAbLCnspCNXANL5r4Cbe65QDNvqUhBEyMMPWa0XnAZ8l1VsiYtqSZfjqc
O2EG5ZV4Uh1JYSj47qPHQoLm8MvuAA==
=5bPd
-----END PGP SIGNATURE-----

--H8xFJL4LzTG8kqw0JXFaY7Oby5au995Bb--
