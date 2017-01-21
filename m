Received: from eggs.gnu.org ([2001:4830:134:3::10]:44588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cV1Fh-00047v-QL
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 14:23:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cV1Fe-0004BJ-Li
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 14:23:05 -0500
References: <20170103182801.9638-1-berrange@redhat.com>
	<20170103182801.9638-16-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a8323336-51b4-21a6-8113-6b80d85d58f7@redhat.com>
Date: Sat, 21 Jan 2017 20:22:53 +0100
MIME-Version: 1.0
In-Reply-To: <20170103182801.9638-16-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eiCwGwnmhvC5r9qbftKQhpbql0WTi2org"
Subject: Re: [Qemu-devel] [PATCH v1 15/15] block: remove all encryption
 handling APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eiCwGwnmhvC5r9qbftKQhpbql0WTi2org
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <a8323336-51b4-21a6-8113-6b80d85d58f7@redhat.com>
Subject: Re: [PATCH v1 15/15] block: remove all encryption handling APIs
References: <20170103182801.9638-1-berrange@redhat.com>
 <20170103182801.9638-16-berrange@redhat.com>
In-Reply-To: <20170103182801.9638-16-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.01.2017 19:28, Daniel P. Berrange wrote:
> Now that all encryption keys must be provided upfront via
> the QCryptoSecret API and associated block driver properties
> there is no need for any explicit encryption handling APIs
> in the block layer. Encryption can be handled transparently
> within the block driver. We only retain an API for querying
> whether an image is encrypted or not, since that is a
> potentially useful piece of metadata to report to the user.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block.c                   | 77 +--------------------------------------=
--------
>  block/crypto.c            |  1 -
>  block/qapi.c              |  2 +-
>  block/qcow.c              |  1 -
>  block/qcow2.c             |  1 -
>  blockdev.c                | 37 ++---------------------
>  include/block/block.h     |  3 --
>  include/block/block_int.h |  1 -
>  include/qapi/error.h      |  1 -
>  qapi/common.json          |  5 +--
>  10 files changed, 5 insertions(+), 124 deletions(-)

It would probably make sense to replace the description of
BlockDeviceInfo's @encryption_key_missing in qapi/block-core.json by
"Deprecated; always false".

[...]

> diff --git a/blockdev.c b/blockdev.c
> index 245e1e1..dfeba0c 100644
> --- a/blockdev.c
> +++ b/blockdev.c

[...]

> @@ -2244,24 +2240,8 @@ void qmp_block_passwd(bool has_device, const cha=
r *device,
>                        bool has_node_name, const char *node_name,
>                        const char *password, Error **errp)
>  {
> -    Error *local_err =3D NULL;
> -    BlockDriverState *bs;
> -    AioContext *aio_context;
> -
> -    bs =3D bdrv_lookup_bs(has_device ? device : NULL,
> -                        has_node_name ? node_name : NULL,
> -                        &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -
> -    aio_context =3D bdrv_get_aio_context(bs);
> -    aio_context_acquire(aio_context);
> -
> -    bdrv_add_key(bs, password, errp);
> -
> -    aio_context_release(aio_context);
> +    error_setg_errno(errp, -ENOSYS,
> +                     "Setting block passwords directly is no longer su=
pported");

A plain error_setg() without _errno should be sufficient.

>  }
> =20

I'll leave it up to you whether you want to follow the suggestions I've
given, so:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--eiCwGwnmhvC5r9qbftKQhpbql0WTi2org
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliDtQ0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AQQQH/3wpKoNIYd0XJGgCsM6ANydbUlHSC41m
nz28MyFQ02Kza3qB1muSXigt84WjoaV7T05VKa1awIO/U2wqTomDv4w2HdfBjNnZ
QdwpPalE3+QT/5VjOgxigvxj0zczCSsqCnmVRs6a6NxCAPU+WiQvFKFAJrC5gO2c
uurtc7wavN8dZD76UDiz5KT647tgi6HF+89/8Et5vNioHlQ9WNB0CuAib9pyuSDP
usdR6FKwtP6GGZSaoSGVnXMlFBiivbjCj7CiNT6R+6q8031KT1CZp7wyp77dAH5u
YTH3cUY4PrWFkMUddsxCVWl/oognTYIWxM917zOZpOzYoYi/QbQ/Dl0=
=Jot9
-----END PGP SIGNATURE-----

--eiCwGwnmhvC5r9qbftKQhpbql0WTi2org--
