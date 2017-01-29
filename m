Received: from eggs.gnu.org ([2001:4830:134:3::10]:39253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXskt-0000sL-9Y
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 11:55:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXskr-0002zx-P9
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 11:55:07 -0500
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
	<20170123121036.4823-23-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b24dd2ce-2472-d170-2d09-dbe2bf85edd8@redhat.com>
Date: Sun, 29 Jan 2017 17:54:52 +0100
MIME-Version: 1.0
In-Reply-To: <20170123121036.4823-23-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bUisP2G2Qb5D5em6JdBijLQKQ9tK4fuwR"
Subject: Re: [Qemu-devel] [PATCH 22/24] block/dirty-bitmap: deep release
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
--bUisP2G2Qb5D5em6JdBijLQKQ9tK4fuwR
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <b24dd2ce-2472-d170-2d09-dbe2bf85edd8@redhat.com>
Subject: Re: [PATCH 22/24] block/dirty-bitmap: deep release dirty bitmaps
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
 <20170123121036.4823-23-vsementsov@virtuozzo.com>
In-Reply-To: <20170123121036.4823-23-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 23.01.2017 13:10, Vladimir Sementsov-Ogievskiy wrote:
> Remove persistent bitmap from its storage on bdrv_release_dirty_bitmap.=

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/dirty-bitmap.c      | 21 ++++++++++++++++++---
>  include/block/block_int.h |  3 +++
>  2 files changed, 21 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 775181c9ab..0977df6309 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -297,7 +297,8 @@ void bdrv_dirty_bitmap_truncate(BlockDriverState *b=
s)
> =20
>  static void bdrv_do_release_matching_dirty_bitmap(BlockDriverState *bs=
,
>                                                    BdrvDirtyBitmap *bit=
map,
> -                                                  bool only_named)
> +                                                  bool only_named,
> +                                                  bool deep)

I'd rather call it "remove_persistent" or something, which is bad
grammar, but it's better at getting the point across.

>  {
>      BdrvDirtyBitmap *bm, *next;
>      QLIST_FOREACH_SAFE(bm, &bs->dirty_bitmaps, list, next) {
> @@ -305,6 +306,19 @@ static void bdrv_do_release_matching_dirty_bitmap(=
BlockDriverState *bs,
>              assert(!bm->active_iterators);
>              assert(!bdrv_dirty_bitmap_frozen(bm));
>              assert(!bm->meta);
> +
> +            if (deep && bm->persistent && bs->drv &&
> +                bs->drv->bdrv_remove_persistent_dirty_bitmap)
> +            {
> +                Error *local_err =3D NULL;
> +                bs->drv->bdrv_remove_persistent_dirty_bitmap(bs, bm->n=
ame,
> +                                                             &local_er=
r);
> +                if (local_err !=3D NULL) {
> +                    error_report_err(local_err);

This looks like maybe it's the wrong thing to do... I do agree that
sometimes it may not be fatal, but sometimes it probably is.

> +                }
> +            }
> +
> +
>              QLIST_REMOVE(bm, list);
>              hbitmap_free(bm->bitmap);
>              g_free(bm->name);
> @@ -322,16 +336,17 @@ static void bdrv_do_release_matching_dirty_bitmap=
(BlockDriverState *bs,
> =20
>  void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *=
bitmap)
>  {
> -    bdrv_do_release_matching_dirty_bitmap(bs, bitmap, false);
> +    bdrv_do_release_matching_dirty_bitmap(bs, bitmap, false, true);

The @deep parameter (or however you decide to call it) should be
available to this function's caller, too. I don't believe qcow2's
load_bitmap() wants to delete the persistent bitmap in the error path;
and block-dirty-bitmap-remove should probably allow the user to decide
what to do.

Which brings me to the error thing above: If the user (or management
tool) decides that block-dirty-bitmap-remove should remove the
persistent bitmap, I believe that the operation should be aborted if the
persistent bitmap cannot be removed. It should not just go on and
release the in-memory bitmap but abort altogether. If the user just
wants to release that in-memory bitmap then, they can still go on an
call block-dirty-bitmap-remove with deep=3Dfalse.

>  }
> =20
>  /**
>   * Release all named dirty bitmaps attached to a BDS (for use in bdrv_=
close()).
>   * There must not be any frozen bitmaps attached.
> + * This function do not remove persistent bitmaps from the storage.

*does

Max

>   */
>  void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs)
>  {
> -    bdrv_do_release_matching_dirty_bitmap(bs, NULL, true);
> +    bdrv_do_release_matching_dirty_bitmap(bs, NULL, true, false);
>  }
> =20
>  void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index b38b3aa198..3e080d6d68 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -326,6 +326,9 @@ struct BlockDriver {
>                                                  Error **errp);
>      bool (*bdrv_can_store_new_dirty_bitmap)(BlockDriverState *bs, cons=
t char *name,
>                                              uint32_t granularity, Erro=
r **errp);
> +    void (*bdrv_remove_persistent_dirty_bitmap)(BlockDriverState *bs,
> +                                                const char *name,
> +                                                Error **errp);
> =20
>      QLIST_ENTRY(BlockDriver) list;
>  };
>=20



--bUisP2G2Qb5D5em6JdBijLQKQ9tK4fuwR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliOHlwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AWF8H/ix9IN5mGZ9zQzI11s7Jjgf9sgmgRymj
y4koom2B7EWPuYs7lljSZ3yQfHbCDCW/uphCVvgz9Va4NqHq7EPqOmPtlDNotfST
gs+afwg6qhL5jFVbMdOZERZ9dg9z8VlTGgMrcGPYIM5sG1+U5F08w/L0eOUSpBos
b7FNlTn5oaw6p1x7wQt9LZeo2/w3cH1TWq2jgmXGnCXDh7QUxuAE4ahE4ZxSIuhi
yhPttKZJ73r2IJtxSUGCbiFCnZKzYKBObVIg0jRZClGvGRvKDzR6M83cMIMLGQhH
Z7XSZQ/cYvv56iY1DWTAvMnSTKoYuVWbhTLUkUJ5RBs0z9VJ40tzsCI=
=6JRf
-----END PGP SIGNATURE-----

--bUisP2G2Qb5D5em6JdBijLQKQ9tK4fuwR--
