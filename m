Received: from eggs.gnu.org ([2001:4830:134:3::10]:43386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ciMZE-0006C9-5K
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:46:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ciMZD-0004ug-6I
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:46:24 -0500
References: <20170225170758.427066-1-vsementsov@virtuozzo.com>
	<20170225170758.427066-16-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ff597749-2dfe-4f52-3bb1-5b95e27cc1ad@redhat.com>
Date: Mon, 27 Feb 2017 15:46:12 +0100
MIME-Version: 1.0
In-Reply-To: <20170225170758.427066-16-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0G1IelSiTpMMJOOrRRcseSa1ESaFNtJoU"
Subject: Re: [Qemu-devel] [PATCH v16 15/22] qcow2: add
 .bdrv_can_store_new_dirty_bitmap
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
--0G1IelSiTpMMJOOrRRcseSa1ESaFNtJoU
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <ff597749-2dfe-4f52-3bb1-5b95e27cc1ad@redhat.com>
Subject: Re: [PATCH v16 15/22] qcow2: add .bdrv_can_store_new_dirty_bitmap
References: <20170225170758.427066-1-vsementsov@virtuozzo.com>
 <20170225170758.427066-16-vsementsov@virtuozzo.com>
In-Reply-To: <20170225170758.427066-16-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 25.02.2017 18:07, Vladimir Sementsov-Ogievskiy wrote:
> Realize .bdrv_can_store_new_dirty_bitmap interface.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> ---
>  block/qcow2-bitmap.c | 51 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>  block/qcow2.c        |  2 ++
>  block/qcow2.h        |  4 ++++
>  3 files changed, 57 insertions(+)
>=20
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index e377215d5c..8c0c24c208 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -1280,3 +1280,54 @@ fail:
> =20
>      bitmap_list_free(bm_list);
>  }
> +
> +bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
> +                                      const char *name,
> +                                      uint32_t granularity,
> +                                      Error **errp)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    bool found;
> +    Qcow2BitmapList *bm_list;
> +
> +    if (check_constraints_on_bitmap(bs, name, granularity, errp) !=3D =
0) {
> +        goto fail;
> +    }
> +
> +    if (s->nb_bitmaps =3D=3D 0) {
> +        return true;
> +    }
> +
> +    if (s->nb_bitmaps >=3D QCOW2_MAX_BITMAPS) {
> +        error_setg(errp,
> +                   "Maximum number of persistent bitmaps is already re=
ached");
> +        goto fail;
> +    }
> +
> +    if (s->bitmap_directory_size + calc_dir_entry_size(strlen(name), 0=
) >
> +        QCOW2_MAX_BITMAP_DIRECTORY_SIZE)
> +    {
> +        error_setg(errp, "No enough space in the bitmap directory");

*Not

With that fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +        goto fail;
> +    }
> +
> +    bm_list =3D bitmap_list_load(bs, s->bitmap_directory_offset,
> +                               s->bitmap_directory_size, errp);
> +    if (bm_list =3D=3D NULL) {
> +        goto fail;
> +    }
> +
> +    found =3D find_bitmap_by_name(bm_list, name);
> +    bitmap_list_free(bm_list);
> +    if (found) {
> +        error_setg(errp, "Bitmap with the same name is already stored"=
);
> +        goto fail;
> +    }
> +
> +    return true;
> +
> +fail:
> +    error_prepend(errp, "Can't make bitmap '%s' persistent in '%s': ",=

> +                  name, bdrv_get_device_or_node_name(bs));
> +    return false;
> +}
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 201e7186f0..8f7937dc50 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3555,6 +3555,8 @@ BlockDriver bdrv_qcow2 =3D {
> =20
>      .bdrv_detach_aio_context  =3D qcow2_detach_aio_context,
>      .bdrv_attach_aio_context  =3D qcow2_attach_aio_context,
> +
> +    .bdrv_can_store_new_dirty_bitmap =3D qcow2_can_store_new_dirty_bit=
map,
>  };
> =20
>  static void bdrv_qcow2_init(void)
> diff --git a/block/qcow2.h b/block/qcow2.h
> index e2ef5698cd..c291858425 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -622,5 +622,9 @@ int qcow2_check_bitmaps_refcounts(BlockDriverState =
*bs, BdrvCheckResult *res,
>                                    int64_t *refcount_table_size);
>  void qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error =
**errp);
>  void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error =
**errp);
> +bool qcow2_can_store_new_dirty_bitmap(BlockDriverState *bs,
> +                                      const char *name,
> +                                      uint32_t granularity,
> +                                      Error **errp);
> =20
>  #endif
>=20



--0G1IelSiTpMMJOOrRRcseSa1ESaFNtJoU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli0O7QSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ARSsIAKGGADrUAhDkvsFZjlcIgjRS80Qx0pEg
B9ub/FAzyq3YWpvi4rBoEc5hhc6HZ6wNGW3JyrZ4QxMb8hAp7v0PoehOYz6l7Vfd
waw/+XRftt0OmTEvhWIx5fmDuKccauGlS7kaOmXXnD+qgz/S/4AEvT35g+/B7qQ2
MHg8suXIjfnYpTkuAa5IDPRlxGnj0vgui4+3HU6TGsryRthQvbi5ORIxJwxpImJY
35xEW89d5rUc49iPjRomuCvBPVl4Q0vxuR04Pqcf1DU/fqyOzRY79n4F43/1sgaJ
4U5fKIwyn3u+Cohc/qASfqGmszBTLdJYxYCBjrKfX+OTUPoQnfrz2uI=
=j9qj
-----END PGP SIGNATURE-----

--0G1IelSiTpMMJOOrRRcseSa1ESaFNtJoU--
