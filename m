Received: from eggs.gnu.org ([2001:4830:134:3::10]:43183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eFlCg-0001RC-F5
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:17:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eFlCf-0002Xa-Bp
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:17:26 -0500
References: <20171117164747.11525-1-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9279377e-9165-d6b9-930f-7949c2c1fb72@redhat.com>
Date: Fri, 17 Nov 2017 19:17:17 +0100
MIME-Version: 1.0
In-Reply-To: <20171117164747.11525-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="n1JoHCJ4XxkhHotJwGgK4OLesBQKceRFs"
Subject: Re: [Qemu-devel] [PATCH for-2.11] qcow2: fix image corruption on
 commit with persistent snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n1JoHCJ4XxkhHotJwGgK4OLesBQKceRFs
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com
Message-ID: <9279377e-9165-d6b9-930f-7949c2c1fb72@redhat.com>
Subject: Re: [PATCH for-2.11] qcow2: fix image corruption on commit with
 persistent snapshot
References: <20171117164747.11525-1-eblake@redhat.com>
In-Reply-To: <20171117164747.11525-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-17 17:47, Eric Blake wrote:
> If an image contains persistent snapshots, we cannot use the
> fast path of bdrv_make_empty() to clear the image during
> qemu-img commit, because that will lose the clusters related
> to the bitmaps.
>=20
> Also leave a comment in qcow2_read_extensions to remind future
> feature additions to think about fast-path removal, since we
> just barely fixed the same bug for LUKS encryption.
>=20
> It's a pain that qemu-img has not yet been taught to manipulate,
> or even at a very minimum display, information about persistent
> bitmaps; instead, we have to use QMP commands.  It's also a
> pain that only qeury-block and x-debug-block-dirty-bitmap-sha256
> will allow bitmap introspection; but the former requires the
> node to be hooked to a block device, and the latter is experimental.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>=20
> As promised, based on Dan's similar patch for LUKS encryption
>=20
>  block/qcow2.c              |  17 ++--
>  tests/qemu-iotests/176     |  55 ++++++++++--
>  tests/qemu-iotests/176.out | 216 +++++++++++++++++++++++++++++++++++++=
+++++++-
>  3 files changed, 270 insertions(+), 18 deletions(-)

The test fails with -m32 and probably also on Big Endian architectures,
because the bitmap hash differs.

The reason the hash differs for -m32 is because of different bitmap
sizes: The default bitmap granularity is 64 kB, so for 32 bit this means
the bitmap always covers a multiple of 2 MB, whereas for 64 bit, the
bitmap always covers a multiple of 4 MB.
> diff --git a/tests/qemu-iotests/176 b/tests/qemu-iotests/176
> index 950b28720e..0f31a20294 100755
> --- a/tests/qemu-iotests/176
> +++ b/tests/qemu-iotests/176

[...]

> @@ -66,14 +74,29 @@ _supported_os Linux
>  for i in 0 1 2 3; do
>=20
>  echo
> -echo "=3D=3D=3D Test pass $i =3D=3D=3D"
> +echo "=3D=3D=3D Test pass $reason.$i =3D=3D=3D"
>  echo
>=20
>  len=3D$((2100 * 1024 * 1024 + 512)) # larger than 2G, and not cluster =
aligned

That means that with -m64, the bitmap will behave as if a 2104 MB image
has been created, but with -m32, it will behave as if it is a 2102 MB
image.  Therefore, you get different hashes (because the 64 bit bitmap
has 32 more zero bits than the 32 bit bitmap).

We could "fix" this by replacing the 2100 by a 2102, so for both bit
widths rounding is the same.  But that would still leave the issue open
for Big Endian architectures (which generate just completely different
hashes) -- and I'm not really a fan of testing this on every possible
architecture and then adding different reference outputs.

Therefore, the best fix is probably to just filter the hashes out (you
don't need the exact value anyway, do you?), and I think it's fine to do
this as a follow-up.

Max


--n1JoHCJ4XxkhHotJwGgK4OLesBQKceRFs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloPJ60SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A6L4IAKrEJ677oYzpK413xSNW8oQ8nm93qpH9
IC7opgTv0kbPj3nNGBDVCH+xxhsPxghFSdn7HutLk41221k9pJTlXcqWfiChO5Av
qUygxubL0fwP30OO/xXqEiivRG8rnW+oGflS4zv0PCtAEwedQV6FJpVAzLyKa3RQ
PoPhyGSHeB9sepGMSNZquA7lZq92kdC1qA9K7yraUmD7J+IVV26fzohYhxSq0lFT
gpgvvAvqL5xETz/zuTv6aXBgkOPv6Pb0CEYUxCHeUrR0xEUrTAOE6lUn5L9ZTxGr
z4Sq8s1tIIrpAEmmkSTI+spMa7XhcMLjFiPBS6B8JEfsZsm4tbf5g+w=
=q/0L
-----END PGP SIGNATURE-----

--n1JoHCJ4XxkhHotJwGgK4OLesBQKceRFs--
