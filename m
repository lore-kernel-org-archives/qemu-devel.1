Received: from eggs.gnu.org ([2001:4830:134:3::10]:49012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cfoph-00072S-9g
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:20:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cfopg-0007Ri-25
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:20:53 -0500
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-28-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e82893b1-908c-e1f5-3693-0396627be0be@redhat.com>
Date: Mon, 20 Feb 2017 15:20:37 +0100
MIME-Version: 1.0
In-Reply-To: <1487006583-24350-28-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dgF9Nv1E2RomjPbLk3u83ru6lUL5PiPvh"
Subject: Re: [Qemu-devel] [RFC PATCH 27/41] block: Add bdrv_new_open_driver()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dgF9Nv1E2RomjPbLk3u83ru6lUL5PiPvh
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <e82893b1-908c-e1f5-3693-0396627be0be@redhat.com>
Subject: Re: [RFC PATCH 27/41] block: Add bdrv_new_open_driver()
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
 <1487006583-24350-28-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-28-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 13.02.2017 18:22, Kevin Wolf wrote:
> This function allows to create more or less normal BlockDriverStates
> even for BlockDrivers that aren't globally registered (e.g. helper
> filters for block jobs).
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c               | 31 ++++++++++++++++++++++++++++++-
>  include/block/block.h |  2 ++
>  2 files changed, 32 insertions(+), 1 deletion(-)
>=20
> diff --git a/block.c b/block.c
> index 9c80cba..7d84d43 100644
> --- a/block.c
> +++ b/block.c
> @@ -948,13 +948,16 @@ static int bdrv_open_driver(BlockDriverState *bs,=
 BlockDriver *drv,
>      }
> =20
>      bs->drv =3D drv;
> +    bs->read_only =3D !(bs->open_flags & BDRV_O_RDWR);
>      bs->opaque =3D g_malloc0(drv->instance_size);
> =20
>      if (drv->bdrv_file_open) {
>          assert(!drv->bdrv_needs_filename || bs->filename[0]);
>          ret =3D drv->bdrv_file_open(bs, options, open_flags, &local_er=
r);
> -    } else {
> +    } else if (drv->bdrv_open) {
>          ret =3D drv->bdrv_open(bs, options, open_flags, &local_err);
> +    } else {
> +        ret =3D 0;
>      }
> =20
>      if (ret < 0) {
> @@ -995,6 +998,32 @@ free_and_fail:
>      return ret;
>  }
> =20
> +int bdrv_new_open_driver(BlockDriver *drv, BlockDriverState **result,

Really? After we put much work into getting bdrv_open() to return a BDS
pointer? :-/

Do you need to distinguish based on -EPERM somewhere? I'd much rather
have the BDS pointer returned, personally. If you need the integer
return value somewhere, couldn't that be a parameter (which can
optionally be NULL if the caller doesn't need it)?

Max

> +                         const char *node_name, int flags, Error **err=
p)
> +{
> +    BlockDriverState *bs;
> +    int ret;
> +
> +    bs =3D bdrv_new();
> +    bs->open_flags =3D flags;
> +    bs->explicit_options =3D qdict_new();
> +    bs->options =3D qdict_new();
> +    bs->opaque =3D NULL;
> +
> +    update_options_from_flags(bs->options, flags);
> +
> +    ret =3D bdrv_open_driver(bs, drv, node_name, bs->options, flags, e=
rrp);
> +    if (ret < 0) {
> +        QDECREF(bs->explicit_options);
> +        QDECREF(bs->options);
> +        bdrv_unref(bs);
> +        return ret;
> +    }
> +
> +    *result =3D bs;
> +    return 0;
> +}
> +
>  QemuOptsList bdrv_runtime_opts =3D {
>      .name =3D "bdrv_common",
>      .head =3D QTAILQ_HEAD_INITIALIZER(bdrv_runtime_opts.head),
> diff --git a/include/block/block.h b/include/block/block.h
> index 93812df..3238850 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -215,6 +215,8 @@ int bdrv_open_backing_file(BlockDriverState *bs, QD=
ict *parent_options,
>                             const char *bdref_key, Error **errp);
>  BlockDriverState *bdrv_open(const char *filename, const char *referenc=
e,
>                              QDict *options, int flags, Error **errp);
> +int bdrv_new_open_driver(BlockDriver *drv, BlockDriverState **result,
> +                         const char *node_name, int flags, Error **err=
p);
>  BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
>                                      BlockDriverState *bs,
>                                      QDict *options, int flags);
>=20



--dgF9Nv1E2RomjPbLk3u83ru6lUL5PiPvh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliq+zUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AemgH/1pw7gi2i2N0ng0sSv/lWTCaBCoGM+MW
nVB+Pi2FIXr1BJTLxk6X5YnzRaehCx/GbHcg6r3qMyCY8Fc8Xsb6DH/0HQcp96fU
dsaWMkru6BIQOlATQ8LgQuj2HAiRjDWlXeLvgyOhfiRAx57Eaz0OxYyRgpcbN0Eq
lCSzbGoORtlKd1KU1+AHilILCrx3hAzlkNaeQjvd4RUgclGu0SrPw9yGxQXue4Oy
drZiRAAr2oC5fwCfraa0AnWv4z9wx9Ku0rfkietMtAWyf5+qlfy4i+RYF7PXWZrX
hcsP4JJ/2OWNHIoHOQl0cNxuWWRlBEQm/Jac1oYh2KKV7mHdgw47d9E=
=Kea6
-----END PGP SIGNATURE-----

--dgF9Nv1E2RomjPbLk3u83ru6lUL5PiPvh--
