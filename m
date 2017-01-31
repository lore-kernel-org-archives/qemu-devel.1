Received: from eggs.gnu.org ([2001:4830:134:3::10]:59710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYhjW-00025g-Bn
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 18:21:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYhjV-0000Zi-8Y
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 18:21:06 -0500
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
	<20170123121036.4823-24-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6ff8e50e-c6d8-d3b6-f900-3700bbe30dee@redhat.com>
Date: Wed, 1 Feb 2017 00:20:54 +0100
MIME-Version: 1.0
In-Reply-To: <20170123121036.4823-24-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CTXUUGcu2QW35MDgP6ANlKEc7vMwV7eFb"
Subject: Re: [Qemu-devel] [PATCH 23/24] qcow2: add
 .bdrv_remove_persistent_dirty_bitmap
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
--CTXUUGcu2QW35MDgP6ANlKEc7vMwV7eFb
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <6ff8e50e-c6d8-d3b6-f900-3700bbe30dee@redhat.com>
Subject: Re: [PATCH 23/24] qcow2: add .bdrv_remove_persistent_dirty_bitmap
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
 <20170123121036.4823-24-vsementsov@virtuozzo.com>
In-Reply-To: <20170123121036.4823-24-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 23.01.2017 13:10, Vladimir Sementsov-Ogievskiy wrote:
> Realize .bdrv_remove_persistent_dirty_bitmap interface.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-bitmap.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  block/qcow2.c        |  1 +
>  block/qcow2.h        |  3 +++
>  3 files changed, 44 insertions(+)
>=20
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 2687a3acd5..be026fc80e 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -1064,6 +1064,46 @@ static Qcow2Bitmap *find_bitmap_by_name(Qcow2Bit=
mapList *bm_list,
>      return NULL;
>  }
> =20
> +void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
> +                                          const char *name,
> +                                          Error **errp)
> +{
> +    int ret;
> +    BDRVQcow2State *s =3D bs->opaque;
> +    Qcow2Bitmap *bm;
> +    Qcow2BitmapList *bm_list;
> +
> +    if (s->nb_bitmaps =3D=3D 0) {
> +        /* No bitmaps - nothing to do */

Shouldn't it be an error? I.e. "bitmap not found"?

> +        return;
> +    }
> +
> +    bm_list =3D bitmap_list_load(bs, s->bitmap_directory_offset,
> +                               s->bitmap_directory_size, errp);
> +    if (bm_list =3D=3D NULL) {
> +        return;
> +    }
> +
> +    bm =3D find_bitmap_by_name(bm_list, name);
> +    if (bm =3D=3D NULL) {
> +        goto fail;

What about setting errp? Or do you not consider this an error?

I think it should be an error.

> +    }
> +
> +    QSIMPLEQ_REMOVE(bm_list, bm, Qcow2Bitmap, entry);

bm->name is leaked here.

Max

> +
> +    ret =3D update_ext_header_and_dir(bs, bm_list);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "Failed to update bitmap extensio=
n");
> +        goto fail;
> +    }
> +
> +    free_bitmap_clusters(bs, &bm->table);
> +
> +fail:
> +    bitmap_free(bm);
> +    bitmap_list_free(bm_list);
> +}
> +
>  void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error =
**errp)
>  {
>      BdrvDirtyBitmap *bitmap;
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 76a6a2ba28..f6bac38e51 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3544,6 +3544,7 @@ BlockDriver bdrv_qcow2 =3D {
>      .bdrv_load_autoloading_dirty_bitmaps =3D qcow2_load_autoloading_di=
rty_bitmaps,
>      .bdrv_store_persistent_dirty_bitmaps =3D qcow2_store_persistent_di=
rty_bitmaps,
>      .bdrv_can_store_new_dirty_bitmap =3D qcow2_can_store_new_dirty_bit=
map,
> +    .bdrv_remove_persistent_dirty_bitmap =3D qcow2_remove_persistent_d=
irty_bitmap,
>  };
> =20
>  static void bdrv_qcow2_init(void)
> diff --git a/block/qcow2.h b/block/qcow2.h
> index eaad34a527..a009827f60 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -627,5 +627,8 @@ bool qcow2_can_store_new_dirty_bitmap(BlockDriverSt=
ate *bs,
>  int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResul=
t *res,
>                                    void **refcount_table,
>                                    int64_t *refcount_table_size);
> +void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
> +                                          const char *name,
> +                                          Error **errp);
> =20
>  #endif
>=20



--CTXUUGcu2QW35MDgP6ANlKEc7vMwV7eFb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliRG9YSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AdxYH/0TLHFsUgZBYAtfJyM4BtPix2IGMF8lF
QBu8QZC7IWy+sjaH0ECG2iMxKLh+BaCcj6R+yvzV0fdeXMRNY8pdsW7svLysvmWF
yhoddffhTAlVuqxhRX2DOvdSCaG8Akr8HSfZa6VQeqmMIVp+Jr9a/rNznr/3EL/v
2oL8Ncifd+X3gn8VkGeHFAod8Xd+q3mWdLOUGbbBGs0DBuPedAnlUphqoMi2E2xI
CjTElxKw+Rq18tD8PCyoEAGrncLD9CU98041sA8oOCot+EghV9R65eX2cGQUvHM3
OaRi4PiIklmFsMNmN99My1mbQTpAEdPN1rOH7rDTyDALkC28XQAA21c=
=0xaQ
-----END PGP SIGNATURE-----

--CTXUUGcu2QW35MDgP6ANlKEc7vMwV7eFb--
