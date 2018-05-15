Received: from eggs.gnu.org ([2001:4830:134:3::10]:56589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIh2p-0008Ma-Bm
	for qemu-devel@nongnu.org; Tue, 15 May 2018 16:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIh2o-0006E8-Aj
	for qemu-devel@nongnu.org; Tue, 15 May 2018 16:59:39 -0400
References: <20180512012537.22478-1-jsnow@redhat.com>
	<20180512012537.22478-4-jsnow@redhat.com>
	<b304a857-629f-c9f1-99cf-0ae17d9b9a1c@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <bb409a04-1fbd-e9ea-932b-75718c0a19ff@redhat.com>
Date: Tue, 15 May 2018 16:59:32 -0400
MIME-Version: 1.0
In-Reply-To: <b304a857-629f-c9f1-99cf-0ae17d9b9a1c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 03/12] block/qcow2-bitmap: avoid
 adjusting bm->flags for RO bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>



On 05/14/2018 08:44 AM, Vladimir Sementsov-Ogievskiy wrote:
> 12.05.2018 04:25, John Snow wrote:
>> Instead of always setting IN_USE, handle whether or not the bitmap
>> is read-only instead of a two-loop pass. This will allow us to show
>> the flags exactly as they appear for bitmaps in `qemu-img info`.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>> =C2=A0 block/qcow2-bitmap.c | 48
>> ++++++++++++++++++++----------------------------
>> =C2=A0 1 file changed, 20 insertions(+), 28 deletions(-)
>>
>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>> index d89758f235..fc8d52fc3e 100644
>> --- a/block/qcow2-bitmap.c
>> +++ b/block/qcow2-bitmap.c
>> @@ -942,13 +942,6 @@ fail:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>> =C2=A0 -/* for g_slist_foreach for GSList of BdrvDirtyBitmap* elements=
 */
>> -static void release_dirty_bitmap_helper(gpointer bitmap,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 gpointer bs)
>> -{
>> -=C2=A0=C2=A0=C2=A0 bdrv_release_dirty_bitmap(bs, bitmap);
>> -}
>> -
>> =C2=A0 /* for g_slist_foreach for GSList of BdrvDirtyBitmap* elements =
*/
>> =C2=A0 static void set_readonly_helper(gpointer bitmap, gpointer value=
)
>> =C2=A0 {
>> @@ -967,8 +960,8 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState
>> *bs, Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRVQcow2State *s =3D bs->opaque;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Qcow2BitmapList *bm_list;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Qcow2Bitmap *bm;
>> -=C2=A0=C2=A0=C2=A0 GSList *created_dirty_bitmaps =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool header_updated =3D false;
>> +=C2=A0=C2=A0=C2=A0 bool needs_update =3D false;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->nb_bitmaps =3D=3D 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* No bitmaps -=
 nothing to do */
>> @@ -992,33 +985,32 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState
>> *bs, Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_disable_dirty_bitmap(bitmap);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 bdrv_dirty_bitmap_set_persistance(bitmap, true);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bm=
->flags |=3D BME_FLAG_IN_USE;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cr=
eated_dirty_bitmaps =3D
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_slist_append(created_dirt=
y_bitmaps, bitmap);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 }
>> -
>> -=C2=A0=C2=A0=C2=A0 if (created_dirty_bitmaps !=3D NULL) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (can_write(bs)) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 in_use flags must be updated */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
t ret =3D update_ext_header_and_dir_in_place(bs, bm_list);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (ret < 0) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_setg_errno(errp, -ret, "Can't update bitmap
>> directory");
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto fail;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (can_write(bs)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bm->flags |=3D BME_FLAG_IN_USE;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 needs_update =3D true;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =
else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_set_readonly(bitmap, true);
>=20
> oops. This shows, that patch 01 was incorrect: before this (03) patch,
> in this case we'll have IN_USE set in cache but not in the image.
>=20

Ah, I can try to order this patch first so that the cache stays
semantically correct.

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 he=
ader_updated =3D true;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_=
slist_foreach(created_dirty_bitmaps, set_readonly_helper,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (gpointer)true);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 g_slist_free(created_dirty_bitmaps);
>> +=C2=A0=C2=A0=C2=A0 /* in_use flags must be updated */
>> +=C2=A0=C2=A0=C2=A0 if (needs_update) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D update_ext_hea=
der_and_dir_in_place(bs, bm_list);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
ror_setg_errno(errp, -ret, "Can't update bitmap
>> directory");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to fail;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 header_updated =3D true;
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return header_updated;
>=20
> may be safely changed to return needs_update, as if we failed to update=
,
> we'll go to fail.
>=20

Ugh, yes.

>> =C2=A0 =C2=A0 fail:
>> -=C2=A0=C2=A0=C2=A0 g_slist_foreach(created_dirty_bitmaps,
>> release_dirty_bitmap_helper, bs);
>> -=C2=A0=C2=A0=C2=A0 g_slist_free(created_dirty_bitmaps);
>> +=C2=A0=C2=A0=C2=A0 QSIMPLEQ_FOREACH(bm, bm_list, entry) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bm->dirty_bitmap) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bd=
rv_release_dirty_bitmap(bs, bm->dirty_bitmap);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 del_bitmap_list(bs);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>=20
> overall looks good, may be worth move it before 01.
>
