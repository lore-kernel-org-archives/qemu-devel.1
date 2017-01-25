Received: from eggs.gnu.org ([2001:4830:134:3::10]:59243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cWSHn-0008LA-NN
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:27:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cWSHm-0003pp-Sx
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:27:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1cWSHm-0003pT-Kr
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:27:10 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D48613DBCC
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 18:27:10 +0000 (UTC)
References: <9a93d47ddba5f86d36cbdf884d86e2fa6f5542ae.1485364872.git.jcody@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <94c9b54b-7a6b-a6db-3866-d96311920a33@redhat.com>
Date: Wed, 25 Jan 2017 19:27:07 +0100
MIME-Version: 1.0
In-Reply-To: <9a93d47ddba5f86d36cbdf884d86e2fa6f5542ae.1485364872.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KgBXVl3X0x2R6J4N1E2GnnOCLdV1vHhiW"
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
Cc: kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KgBXVl3X0x2R6J4N1E2GnnOCLdV1vHhiW
From: Max Reitz <mreitz@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com
Message-ID: <94c9b54b-7a6b-a6db-3866-d96311920a33@redhat.com>
Subject: Re: [PATCH 1/1] block: check full backing filename when searching
 protocol filenames
References: <9a93d47ddba5f86d36cbdf884d86e2fa6f5542ae.1485364872.git.jcody@redhat.com>
In-Reply-To: <9a93d47ddba5f86d36cbdf884d86e2fa6f5542ae.1485364872.git.jcody@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 25.01.2017 18:22, Jeff Cody wrote:
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
> =20
>      if (!bs || !bs->drv || !backing_file) {
>          return NULL;
> @@ -3165,6 +3166,17 @@ BlockDriverState *bdrv_find_backing_image(BlockD=
riverState *bs,
>                  retval =3D curr_bs->backing->bs;
>                  break;
>              }
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

Oops, I was a bit too quick there. You should either follow Eric's
remark about the scope, or you have to reset local_error to NULL here.

Max

> +            }
>          } else {
>              /* If not an absolute filename path, make it relative to t=
he current
>               * image's filename path */
>=20



--KgBXVl3X0x2R6J4N1E2GnnOCLdV1vHhiW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliI7fsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AzIAIAIUgCr/WdEm3ZoPIIGlBkJJa3ANljYi6
rfYVUgnnmEiO5bym2NbIfexqTIYVktot+uJcb9KXbnP7Ft/oryrk17qIx0AMgtg9
JpoNFVPiAlwlIDZNOyWtbr0cBy89cxEN7kSdOA20qBlRlCPvZbwSjGSWIXXiGr20
JVpmgRtqPk3I/KhL5fHqzqbqcOR7dgOegJr2ZaAqa5IqGa1hRrACaAPuPI+wTnUX
AApCGqGWTSB27b6/PsDdJiC1sNDNceTvQrGD5QpzGxEvo8tMG/01LTug7tQJPR+b
J6IgE+viuUozmYeseSWwveRPGy4Bdh2e4MpaHgvLnq+vj6Mg9FXPqP0=
=lGlS
-----END PGP SIGNATURE-----

--KgBXVl3X0x2R6J4N1E2GnnOCLdV1vHhiW--
