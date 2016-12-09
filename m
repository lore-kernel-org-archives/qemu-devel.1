Received: from eggs.gnu.org ([2001:4830:134:3::10]:37612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cFOyn-0001pg-KV
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:29:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cFOym-0002LG-F8
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:29:05 -0500
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
	<1479835586-74394-16-git-send-email-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f3b2be4f-3ea6-0af9-00f6-e28d5b502974@redhat.com>
Date: Fri, 9 Dec 2016 18:28:53 +0100
MIME-Version: 1.0
In-Reply-To: <1479835586-74394-16-git-send-email-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eSDAtaFBfhtFsFI7Alt3gWRo0RwTdtnof"
Subject: Re: [Qemu-devel] [PATCH 15/21] qcow2: add
 .bdrv_can_store_dirty_bitmap
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
--eSDAtaFBfhtFsFI7Alt3gWRo0RwTdtnof
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <f3b2be4f-3ea6-0af9-00f6-e28d5b502974@redhat.com>
Subject: Re: [PATCH 15/21] qcow2: add .bdrv_can_store_dirty_bitmap
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
 <1479835586-74394-16-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1479835586-74394-16-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 22.11.2016 18:26, Vladimir Sementsov-Ogievskiy wrote:
> Realize .bdrv_can_store_dirty_bitmap interface.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-bitmap.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  block/qcow2.c        |  1 +
>  block/qcow2.h        |  4 ++++
>  3 files changed, 45 insertions(+)
>=20
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index a975388..55b1112 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -1115,3 +1115,43 @@ fail:
> =20
>      bitmap_list_free(bm_list);
>  }
> +
> +bool qcow2_can_store_dirty_bitmap(BlockDriverState *bs,
> +                                  const char *name,
> +                                  uint32_t granularity,
> +                                  Error **errp)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    const char *reason =3D NULL;
> +    bool found;
> +    Qcow2BitmapList *bm_list;
> +
> +    if (check_constraints_on_bitmap(bs, name, granularity) !=3D 0) {
> +        reason =3D "it doesn't satisfy the constraints";
> +        goto common_errp;
> +    }
> +
> +    if (s->nb_bitmaps =3D=3D 0) {
> +        return true;
> +    }
> +
> +    bm_list =3D bitmap_list_load(bs, s->bitmap_directory_offset,
> +                               s->bitmap_directory_size, errp);

Maybe it would make sense to keep the bitmap list in memory...

> +    if (bm_list =3D=3D NULL) {
> +        return false;
> +    }
> +
> +    found =3D !!find_bitmap_by_name(bm_list, name);

You can omit the !!, storing it in a bool will do that for you.

> +    bitmap_list_free(bm_list);
> +    if (found) {
> +        reason =3D "bitmap with the same name is already stored";
> +        goto common_errp;
> +    }
> +
> +    return true;
> +
> +common_errp:
> +    error_setg(errp, "Can't make bitmap '%s' persistent in '%s', as %s=
=2E",
> +               name, bdrv_get_device_or_node_name(bs), reason);

Hm, so this function isn't for checking whether a bitmap can be stored,
but whether it can be made persistent. That's a difference; you can
store a bitmap of the same name in the file if you want to overwrite it
(i.e. it's an auto-load bitmap), but you cannot create a new bitmap with
the same name.

Maybe rename it from bdrv_can_store_dirty_bitmap to
bdrv_can_store_new_dirty_bitmap?

Max

> +    return false;
> +}
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 66c7f74..cb9c2a2 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3516,6 +3516,7 @@ BlockDriver bdrv_qcow2 =3D {
> =20
>      .bdrv_load_autoloading_dirty_bitmaps =3D qcow2_load_autoloading_di=
rty_bitmaps,
>      .bdrv_store_persistent_dirty_bitmaps =3D qcow2_store_persistent_di=
rty_bitmaps,
> +    .bdrv_can_store_dirty_bitmap =3D qcow2_can_store_dirty_bitmap,
>  };
> =20
>  static void bdrv_qcow2_init(void)
> diff --git a/block/qcow2.h b/block/qcow2.h
> index d9a7643..e7a44a1 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -616,5 +616,9 @@ void qcow2_cache_put(BlockDriverState *bs, Qcow2Cac=
he *c, void **table);
>  /* qcow2-bitmap.c functions */
>  void qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error =
**errp);
>  void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error =
**errp);
> +bool qcow2_can_store_dirty_bitmap(BlockDriverState *bs,
> +                                  const char *name,
> +                                  uint32_t granularity,
> +                                  Error **errp);
> =20
>  #endif
>=20



--eSDAtaFBfhtFsFI7Alt3gWRo0RwTdtnof
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlhK6dUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A90QH/1hAUG+GrYX11Kic8dm6jG+QeUqnQwaS
l8jxnUsvUoksa7fFcqriREXiZeKOA93MKhvuNg81/sYByO9n7ztu+9ljeqi3LqMi
qv5pL2mcc43AUVMUwRUhJxk8gUJWIeMINQEzXP8uTMMTTNCO1xlONaFfuKJC/aLC
j4pvWDvorVWNeUgsjAYTexLceQk6LGuY+Vj6leHJgbKks06zpzVro3JG5IZFSHar
Prz66xMVUiqtGNNWITQvuaEUoq7BdFVi0TX1n9vXOsaqNojdYm2c71f/HqlQNQy0
bGRVzN8l+ZC37rEZ7puQJWzfKbG/R7rPaDFVh0g3POrcCuq0RJ+QO7s=
=0U5W
-----END PGP SIGNATURE-----

--eSDAtaFBfhtFsFI7Alt3gWRo0RwTdtnof--
