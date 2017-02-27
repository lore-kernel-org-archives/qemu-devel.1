Received: from eggs.gnu.org ([2001:4830:134:3::10]:51884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ciLVW-00064T-Bl
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:38:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ciLVV-00008Z-Fo
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:38:30 -0500
References: <20170225170758.427066-1-vsementsov@virtuozzo.com>
	<20170225170758.427066-12-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3e19d516-0763-1e41-effa-d14d05f417b9@redhat.com>
Date: Mon, 27 Feb 2017 14:38:18 +0100
MIME-Version: 1.0
In-Reply-To: <20170225170758.427066-12-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OEHD90IqpDuOJjbqEBQmWs3aNoB1wJvI3"
Subject: Re: [Qemu-devel] [PATCH v16 11/22] block: introduce persistent
 dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OEHD90IqpDuOJjbqEBQmWs3aNoB1wJvI3
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <3e19d516-0763-1e41-effa-d14d05f417b9@redhat.com>
Subject: Re: [PATCH v16 11/22] block: introduce persistent dirty bitmaps
References: <20170225170758.427066-1-vsementsov@virtuozzo.com>
 <20170225170758.427066-12-vsementsov@virtuozzo.com>
In-Reply-To: <20170225170758.427066-12-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 25.02.2017 18:07, Vladimir Sementsov-Ogievskiy wrote:
> New field BdrvDirtyBitmap.persistent means, that bitmap should be saved=

> on bdrv_close, using format driver.

Somehow this sentence stays valid, but it has a much different meaning
now. bdrv_close() no longer directly takes care of saving bitmaps but
its completely up to the format driver. In any case, this patch has no
longer anything to do with that, so I think this statement should be
changed.

Max

>                                     Format driver should maintain bitma=
p
> storing.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/dirty-bitmap.c         | 26 ++++++++++++++++++++++++++
>  block/qcow2-bitmap.c         |  1 +
>  include/block/dirty-bitmap.h |  6 ++++++
>  3 files changed, 33 insertions(+)
>=20
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index a9dfce8d00..d2fbf55964 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -44,6 +44,7 @@ struct BdrvDirtyBitmap {
>      int64_t size;               /* Size of the bitmap (Number of secto=
rs) */
>      bool disabled;              /* Bitmap is read-only */
>      int active_iterators;       /* How many iterators are active */
> +    bool persistent;            /* bitmap must be saved to owner disk =
image */
>      bool autoload;              /* For persistent bitmaps: bitmap must=
 be
>                                     autoloaded on image opening */
>      QLIST_ENTRY(BdrvDirtyBitmap) list;
> @@ -72,6 +73,7 @@ void bdrv_dirty_bitmap_make_anon(BdrvDirtyBitmap *bit=
map)
>      assert(!bdrv_dirty_bitmap_frozen(bitmap));
>      g_free(bitmap->name);
>      bitmap->name =3D NULL;
> +    bitmap->persistent =3D false;
>      bitmap->autoload =3D false;
>  }
> =20
> @@ -241,6 +243,8 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDr=
iverState *bs,
>      bitmap->name =3D NULL;
>      successor->name =3D name;
>      bitmap->successor =3D NULL;
> +    successor->persistent =3D bitmap->persistent;
> +    bitmap->persistent =3D false;
>      successor->autoload =3D bitmap->autoload;
>      bitmap->autoload =3D false;
>      bdrv_release_dirty_bitmap(bs, bitmap);
> @@ -555,3 +559,25 @@ bool bdrv_dirty_bitmap_get_autoload(const BdrvDirt=
yBitmap *bitmap)
>  {
>      return bitmap->autoload;
>  }
> +
> +void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap, bool p=
ersistent)
> +{
> +    bitmap->persistent =3D persistent;
> +}
> +
> +bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap)
> +{
> +    return bitmap->persistent;
> +}
> +
> +bool bdrv_has_persistent_bitmaps(BlockDriverState *bs)
> +{
> +    BdrvDirtyBitmap *bm;
> +    QLIST_FOREACH(bm, &bs->dirty_bitmaps, list) {
> +        if (bm->persistent) {
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 6b1a2c9c67..ba72b7d2ac 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -780,6 +780,7 @@ void qcow2_load_autoloading_dirty_bitmaps(BlockDriv=
erState *bs, Error **errp)
>                  goto fail;
>              }
> =20
> +            bdrv_dirty_bitmap_set_persistance(bitmap, true);
>              bdrv_dirty_bitmap_set_autoload(bitmap, true);
>              bm->flags |=3D BME_FLAG_IN_USE;
>              created_dirty_bitmaps =3D
> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.=
h
> index 45a389a20a..8dbd16b040 100644
> --- a/include/block/dirty-bitmap.h
> +++ b/include/block/dirty-bitmap.h
> @@ -77,4 +77,10 @@ void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyB=
itmap *bitmap);
> =20
>  void bdrv_dirty_bitmap_set_autoload(BdrvDirtyBitmap *bitmap, bool auto=
load);
>  bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap);
> +void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap,
> +                                                bool persistent);
> +bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap);
> +
> +bool bdrv_has_persistent_bitmaps(BlockDriverState *bs);
> +
>  #endif
>=20



--OEHD90IqpDuOJjbqEBQmWs3aNoB1wJvI3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli0K8oSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A+4AIAI7yCPaOIBvCVYOKC0qRCpNSGjXPIGgR
TTQ/yDmmq17/TP8+gUe8oGt1TZ1C0AXVVIWa+czmqdhlbHBGibqoDCvfHE4wtyvI
NzSTiyNTpLpJQFGfGDmvwVnCAMUnapA3XXAbqJIUsR2zOlat9C98K3BBtxJ1lRCq
FE8E/CwjTWGmURY/rT326Mml6Rutlbk1kmBhvOiFh/OKntXgoTu3Q5199SYxVFVz
1npI8QUm+Z9qdO57z6hurvKoepulbz0UI/tk1u7O7OxYD/zP3CU5IrrlH6pggoxz
ABWWSkXn2oXwnzScVYikK8hrWuML2h56f3EBY7u8Op5nOnxibzix6mg=
=o6kL
-----END PGP SIGNATURE-----

--OEHD90IqpDuOJjbqEBQmWs3aNoB1wJvI3--
