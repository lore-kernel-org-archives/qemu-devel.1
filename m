Received: from eggs.gnu.org ([2001:4830:134:3::10]:40041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpv3I-0006W3-1P
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpv3F-0004ul-0a
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:00:40 -0400
Date: Mon, 20 Mar 2017 11:00:23 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170320110023.GH17887@stefanha-x1.localdomain>
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214045.26857-5-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZFKeWUZP29EKQNE"
Content-Disposition: inline
In-Reply-To: <20170313214045.26857-5-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 07/16] block/file-posix:
 Generalize raw_regular_truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org


--LZFKeWUZP29EKQNE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2017 at 10:40:36PM +0100, Max Reitz wrote:
> Currently, raw_regular_truncate() is intended for setting the size of a
> newly created file. However, we also want to use it for truncating an
> existing file in which case only the newly added space (when growing)
> should be preallocated.
>=20
> This also means that if resizing failed, we should try to restore the
> original file size. This is important when using preallocation.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/file-posix.c | 73 ++++++++++++++++++++++++++++++++++++++++++++----=
------
>  1 file changed, 60 insertions(+), 13 deletions(-)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 35a9e43f3e..cd229324ba 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1384,11 +1384,39 @@ static void raw_close(BlockDriverState *bs)
>      }
>  }
> =20
> -static int raw_regular_truncate(int fd, int64_t offset, PreallocMode pre=
alloc,
> +/**
> + * Truncates the given regular file @fd to @offset and, when growing, fi=
lls the
> + * new space according to @prealloc.
> + *
> + * @create must be true iff the file is new. In that case, @bs is ignore=
d. If
> + * @create is false, @bs must be valid and correspond to the same file a=
s @fd.

Returns: 0 on success, -errno on failure.

> + */
> +static int raw_regular_truncate(int fd, BlockDriverState *bs, int64_t of=
fset,

The presence of both a file descriptor and a BlockDriverState (actually
it must be a BDRVRawState) arguments is unusual.  It seems bs is needed
for bdrv_getlength().

How about using fstat(fd, &st) and then dropping bs and create?

> +                                PreallocMode prealloc, bool create,
>                                  Error **errp)
>  {
>      int result =3D 0;
> -    char *buf;
> +    int64_t current_length =3D 0;
> +    char *buf =3D NULL;
> +
> +    assert(create || bs);
> +    if (!create) {
> +        BDRVRawState *s =3D bs->opaque;
> +        assert(s->fd =3D=3D fd);
> +    }
> +
> +    if (!create) {
> +        current_length =3D bdrv_getlength(bs);
> +        if (current_length < 0) {
> +            error_setg_errno(errp, -current_length,
> +                             "Could not inquire current length");
> +            return -current_length;
> +        }
> +
> +        if (current_length > offset && prealloc !=3D PREALLOC_MODE_OFF) {
> +            return -ENOTSUP;
> +        }

Missing error_setg().

--LZFKeWUZP29EKQNE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz7ZHAAoJEJykq7OBq3PITDkIAMD8VnbSSSXOaEciALHPk9TO
p1gftaqE7Ny5OXVFK4oMg1bngGjcdnggAqB9riQVqIUDkPF4xWtNi5HEzCyQ6aYj
iER/eFXvbD5XC5Bo0ycGVcz0rkHSJqpgiy/Hy4jhexq6kw6oA6I1XfpzwboZuU7+
/qkUoy/frjdRwPLv+yCHFKeod2Io+GyTWrHwlLCKtdmh5cRq7lk04o+e+gMMx7MB
GKDtjYBWGTEhoiKiEKZv/PeDyn5qRWF3BZ1n+q0k2lhm+NRV7KiZB1c1ZVEQ+DdE
lWh3oXfEiVwXQm0HoiI5xUdULQf+2z93rHD4uMIjeCYcyLfm+h49p24MZHkPuYw=
=j+ft
-----END PGP SIGNATURE-----

--LZFKeWUZP29EKQNE--
