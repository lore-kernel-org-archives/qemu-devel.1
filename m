Received: from eggs.gnu.org ([2001:4830:134:3::10]:54529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVZw5-0006CV-1t
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 06:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVZvv-0005ko-I2
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 06:01:57 -0400
References: <20180613020613.1343-1-jsnow@redhat.com>
	<20180613020613.1343-3-jsnow@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <752e5ecf-fc5f-3576-afa7-8c4e7bec9974@virtuozzo.com>
Date: Wed, 20 Jun 2018 13:01:25 +0300
MIME-Version: 1.0
In-Reply-To: <20180613020613.1343-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 02/10] qcow2/bitmap: avoid adjusting
 bm->flags for RO bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

13.06.2018 05:06, John Snow wrote:
> Instead of always setting IN_USE, do this conditionally based on
> whether or not the bitmap is read-only. Eliminate the two-pass
> processing and move the second loop to the failure case.
>
> This will allow us to show the flags exactly as they appear
> on-disk for bitmaps in `qemu-img info`.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   block/qcow2-bitmap.c | 51 +++++++++++++++++++++------------------------=
------
>   1 file changed, 21 insertions(+), 30 deletions(-)
>
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 0670e5eb41..85c1b5afe3 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -919,13 +919,6 @@ fail:
>       return ret;
>   }
>  =20
> -/* for g_slist_foreach for GSList of BdrvDirtyBitmap* elements */
> -static void release_dirty_bitmap_helper(gpointer bitmap,
> -                                        gpointer bs)
> -{
> -    bdrv_release_dirty_bitmap(bs, bitmap);
> -}
> -
>   /* for g_slist_foreach for GSList of BdrvDirtyBitmap* elements */
>   static void set_readonly_helper(gpointer bitmap, gpointer value)
>   {
> @@ -944,8 +937,7 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, E=
rror **errp)
>       BDRVQcow2State *s =3D bs->opaque;
>       Qcow2BitmapList *bm_list;
>       Qcow2Bitmap *bm;
> -    GSList *created_dirty_bitmaps =3D NULL;
> -    bool header_updated =3D false;
> +    bool needs_update =3D false;
>  =20
>       if (s->nb_bitmaps =3D=3D 0) {
>           /* No bitmaps - nothing to do */
> @@ -968,35 +960,34 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs,=
 Error **errp)
>                   bdrv_disable_dirty_bitmap(bitmap);
>               }
>               bdrv_dirty_bitmap_set_persistance(bitmap, true);
> -            bm->flags |=3D BME_FLAG_IN_USE;
> -            created_dirty_bitmaps =3D
> -                    g_slist_append(created_dirty_bitmaps, bitmap);
> -        }
> -    }
> -
> -    if (created_dirty_bitmaps !=3D NULL) {
> -        if (can_write(bs)) {
> -            /* in_use flags must be updated */
> -            int ret =3D update_ext_header_and_dir_in_place(bs, bm_list);
> -            if (ret < 0) {
> -                error_setg_errno(errp, -ret, "Can't update bitmap direct=
ory");
> -                goto fail;
> +            if (can_write(bs)) {
> +                bm->flags |=3D BME_FLAG_IN_USE;
> +                needs_update =3D true;
> +            } else {
> +                bdrv_dirty_bitmap_set_readonly(bitmap, true);
>               }

+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bm->dirty_bitmap =3D bitmap; [1]

> -            header_updated =3D true;
> -        } else {
> -            g_slist_foreach(created_dirty_bitmaps, set_readonly_helper,
> -                            (gpointer)true);
>           }
>       }
>  =20
> -    g_slist_free(created_dirty_bitmaps);
> +    /* in_use flags must be updated */
> +    if (needs_update) {
> +        int ret =3D update_ext_header_and_dir_in_place(bs, bm_list);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Can't update bitmap directory"=
);
> +            goto fail;
> +        }
> +    }
> +
>       bitmap_list_free(bm_list);
>  =20
> -    return header_updated;
> +    return needs_update;
>  =20
>   fail:
> -    g_slist_foreach(created_dirty_bitmaps, release_dirty_bitmap_helper, =
bs);
> -    g_slist_free(created_dirty_bitmaps);
> +    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
> +        if (bm->dirty_bitmap) {

hm stop, at this point, you didn't yet set it. may be in later patches.=20
I remember that you did it in previous version of patch series, so [1].

> +            bdrv_release_dirty_bitmap(bs, bm->dirty_bitmap);
> +        }
> +    }
>       bitmap_list_free(bm_list);
>  =20
>       return false;

with [1]:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

--=20
Best regards,
Vladimir
