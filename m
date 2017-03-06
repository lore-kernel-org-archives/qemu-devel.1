Received: from eggs.gnu.org ([2001:4830:134:3::10]:39411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckyx8-0002JK-O1
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:09:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckyx7-00006I-Ps
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:09:54 -0500
References: <20170306195255.15806-1-mreitz@redhat.com>
	<20170306195434.16782-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ad414a21-b74e-8f25-1b1e-024c0db7986a@redhat.com>
Date: Mon, 6 Mar 2017 14:09:45 -0600
MIME-Version: 1.0
In-Reply-To: <20170306195434.16782-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cRkIvPFlhe36Ulj1X69U7TfrWFlSatLkM"
Subject: Re: [Qemu-devel] [PATCH for-2.10 3/3] block: Add some
 bdrv_truncate() error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cRkIvPFlhe36Ulj1X69U7TfrWFlSatLkM
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <ad414a21-b74e-8f25-1b1e-024c0db7986a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 3/3] block: Add some bdrv_truncate()
 error messages
References: <20170306195255.15806-1-mreitz@redhat.com>
 <20170306195434.16782-1-mreitz@redhat.com>
In-Reply-To: <20170306195434.16782-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/06/2017 01:54 PM, Max Reitz wrote:
> Add missing error messages for the drivers I am comfortable to do this
> in.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/file-posix.c | 8 +++++++-
>  block/qcow2.c      | 2 ++
>  block/qed.c        | 4 +++-
>  block/raw-format.c | 2 ++
>  4 files changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 9d2bea730d..553213221c 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1341,20 +1341,26 @@ static int raw_truncate(BlockDriverState *bs, i=
nt64_t offset, Error **errp)
>  {
>      BDRVRawState *s =3D bs->opaque;
>      struct stat st;
> +    int ret;
> =20
>      if (fstat(s->fd, &st)) {
> -        return -errno;
> +        ret =3D -errno;
> +        error_setg_errno(errp, -ret, "Failed to fstat() the file");
> +        return ret;
>      }
> =20
>      if (S_ISREG(st.st_mode)) {
>          if (ftruncate(s->fd, offset) < 0) {
> +            /* The generic error message will be fine */
>              return -errno;

Relying on a generic error message in the caller is awkward. I see it as
evidence of a partial conversion if we have an interface that requires a
return of a negative errno value to make up for when errp is not set.  I
know you aren't comfortable converting all drivers, but for the drivers
you do convert, I'd rather guarantee that ALL errors set errp.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--cRkIvPFlhe36Ulj1X69U7TfrWFlSatLkM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvcIJAAoJEKeha0olJ0NqIIEIAIUbhdqhVgYcUUJKl6xGprjk
qYcgiZmgDwOxBc2ug5RiWRa0sIKHY1FF2Bm12sJeqK7E+SLdA6JrR3anvaVh1j5v
Ltps7XwnEerYk6dYLUYGsXSyqr6Z206K6wU8ynl2N/B0Jf/y0+wXAYKpwjthZAJ5
clq5kRf2Hbpr8KUkkpaJEJdEObeZXixem1vwYiTvVLlpl3wvoofR9JkAVPyAyYjT
rDnrGfofHJIyjwU1ReA/Dp06cUdACH6DeIdW5Fz9YxAmXVCIVPosj01IVwh9AeCS
xCbm0H85TIApFW/e2MNc3hgHFe1KfBAGpB0cORw9wSavhgCz3PgQomW7WgtHcVQ=
=MG1c
-----END PGP SIGNATURE-----

--cRkIvPFlhe36Ulj1X69U7TfrWFlSatLkM--
