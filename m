Received: from eggs.gnu.org ([2001:4830:134:3::10]:58686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cWSFF-0005R5-LW
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:24:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cWSFE-0003OL-Lg
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:24:33 -0500
References: <9a93d47ddba5f86d36cbdf884d86e2fa6f5542ae.1485364872.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b77236d0-edde-3d14-4282-c61a7c7615af@redhat.com>
Date: Wed, 25 Jan 2017 12:24:23 -0600
MIME-Version: 1.0
In-Reply-To: <9a93d47ddba5f86d36cbdf884d86e2fa6f5542ae.1485364872.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rBWI3SNBGjmkw8cGwqE2OmhpWd3RlWeqK"
Subject: Re: [Qemu-devel] [PATCH 1/1] block: check full backing filename
 when searching protocol filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rBWI3SNBGjmkw8cGwqE2OmhpWd3RlWeqK
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu block <qemu-block@nongnu.org>
Message-ID: <b77236d0-edde-3d14-4282-c61a7c7615af@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] block: check full backing filename when
 searching protocol filenames
References: <9a93d47ddba5f86d36cbdf884d86e2fa6f5542ae.1485364872.git.jcody@redhat.com>
In-Reply-To: <9a93d47ddba5f86d36cbdf884d86e2fa6f5542ae.1485364872.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/25/2017 11:22 AM, Jeff Cody wrote:
> In bdrv_find_backing_image(), if we are searching an image for a backin=
g
> file that contains a protocol, we currently only compare unmodified
> paths.
>=20
> However, some management software will change the backing filename to b=
e
> a relative filename in a path.  QEMU is able to handle this fine,
> because internally it will use path_combine to put together the full
> protocol URI.
>=20
> However, this can lead to an inability to match an image during a QAPI
> command that needs to use bdrv_find_backing_image() to find the image,
> when it is searched by the full URI.
>=20
> When searching for a protocol filename, if the straight comparison
> fails, this patch will also compare against the full backing filename t=
o
> see if that is a match.
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Does this overlap with Max' work on 'block: Fix some filename generation
issues'?  But in isolation, it looks okay to me,

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block.c b/block.c
> index 39ddea3..a173afc 100644
> --- a/block.c
> +++ b/block.c
> @@ -3145,6 +3145,7 @@ BlockDriverState *bdrv_find_backing_image(BlockDr=
iverState *bs,
>      int is_protocol =3D 0;
>      BlockDriverState *curr_bs =3D NULL;
>      BlockDriverState *retval =3D NULL;
> +    Error *local_error =3D NULL;

I might have scoped this...

> =20
>      if (!bs || !bs->drv || !backing_file) {
>          return NULL;
> @@ -3165,6 +3166,17 @@ BlockDriverState *bdrv_find_backing_image(BlockD=
riverState *bs,
>                  retval =3D curr_bs->backing->bs;
>                  break;
>              }

=2E..as the first line within the if that uses it. But no big deal.

> +            /* Also check against the full backing filename for the im=
age */
> +            bdrv_get_full_backing_filename(curr_bs, backing_file_full,=
 PATH_MAX,
> +                                           &local_error);
> +            if (local_error =3D=3D NULL) {
> +                if (strcmp(backing_file, backing_file_full) =3D=3D 0) =
{
> +                    retval =3D curr_bs->backing->bs;
> +                    break;
> +                }
> +            } else {
> +                error_free(local_error);
> +            }
>          } else {
>              /* If not an absolute filename path, make it relative to t=
he current
>               * image's filename path */
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--rBWI3SNBGjmkw8cGwqE2OmhpWd3RlWeqK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYiO1XAAoJEKeha0olJ0Nqz+sIAJfnswZ5bmnvBz4R6o7ytte5
dDdxkmvDaBdavy3C/f4MS640OzgmEpw7OC4xfDUEHs8y2h7/rmlHrFnK6QVUfZqd
8dReC/Cq2OoIuLMEFcFS63iyn4DGovD46+EQzU6AODcSEUVTqdrnH1HVJZncAcj6
vdxmQSGJ8RDzmmLTOrov1YEih7rgda8lZca7EOvmuM/gi4EtC5Ugwg0QvcZfMq1N
5cJVLVO+o77qV5B8haIld2zr1TyFTkueTZKSU+YHVV5d4GaXEunUqOLogr+Mj5Vy
g/UVbHFEZohnUxreFmyngY5L4KojiD5GRWOAh+IFLlYXnKHol/utfSB+Gl5SIjk=
=NjFv
-----END PGP SIGNATURE-----

--rBWI3SNBGjmkw8cGwqE2OmhpWd3RlWeqK--
