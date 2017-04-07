Received: from eggs.gnu.org ([2001:4830:134:3::10]:54804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwPx9-0003Dq-FN
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:13:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cwPx8-0002l7-Ep
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 05:13:11 -0400
Date: Fri, 7 Apr 2017 10:13:00 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170407091300.GG13602@stefanha-x1.localdomain>
References: <cover.1491416061.git.jcody@redhat.com>
	<fcdfe9c672ecdb179264187e0671b5432fced4c4.1491416061.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Iq5ULCa7nGtWwZS"
Content-Disposition: inline
In-Reply-To: <fcdfe9c672ecdb179264187e0671b5432fced4c4.1491416061.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/9] block: do not set BDS
 read_only if copy_on_read enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com, kwolf@redhat.com


--9Iq5ULCa7nGtWwZS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 02:28:44PM -0400, Jeff Cody wrote:

Minor comments but:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

> diff --git a/block.c b/block.c
> index 7b4c7ef..f60d5ea 100644
> --- a/block.c
> +++ b/block.c
> @@ -192,9 +192,17 @@ void path_combine(char *dest, int dest_size,
>      }
>  }
> =20
> -void bdrv_set_read_only(BlockDriverState *bs, bool read_only)
> +int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **err=
p)
>  {
> +    /* Do not set read_only if copy_on_read is enabled */
> +    if (bs->copy_on_read && read_only) {
> +        error_setg(errp, "Cannot set node '%s' to r/o while COW enabled",

Users might be puzzled by "COR".  The -drive option is called
"copy-on-read" so spelling it out is clearer than using an acronym.

> @@ -1173,7 +1171,18 @@ static int vvfat_open(BlockDriverState *bs, QDict =
*options, int flags,
>          if (ret < 0) {
>              goto fail;
>          }
> -        bdrv_set_read_only(bs, false);
> +        ret =3D bdrv_set_read_only(bs, false, &local_err);
> +        if (ret < 0) {
> +            error_propagate(errp, local_err);
> +            goto fail;
> +        }

read_only =3D false by default.  There's no need to set it now that you've
moved the bdrv_set_read_only(bs, true) call.

--9Iq5ULCa7nGtWwZS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY51gcAAoJEJykq7OBq3PIo6AH/i8748Q0ovY0QB7BEIdhur9H
ZlXAeTe0mDJkdkYzXSBDzY4BzRu5uVGoL8I8D6PlhZxN5tYgERA4enZHY4Y+f6ry
hIMBRvQEPa+TdMMK5K+Il0B/Pkgo3TlmM2lksdnT5/18u/XCaZLshkLc77dF5qK7
rrUE2q/AhJYDaW1UTznhfg+zx6SF1l8nW9yCXqGKagChuQRWCIVYrOVPIuiveCj1
z4DR4xIe4ZVOBKUhmuhbEnl7MxDHDl/KmaK1I22r+tWKCuD+IvhK2zhjAEFFO1cL
OUbIMA+ewmsMjPN5HUBO3eQ8WhPQ08d4kgZU6DUHG7a4KJFRoccqqazEoYmfXDE=
=pY7c
-----END PGP SIGNATURE-----

--9Iq5ULCa7nGtWwZS--
