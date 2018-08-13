Received: from eggs.gnu.org ([2001:4830:134:3::10]:58866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fpEzQ-0007zv-6Z
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fpEzP-00034X-4z
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:42:40 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20180808124925.21031-1-vsementsov@virtuozzo.com>
	<20180808124925.21031-4-vsementsov@virtuozzo.com>
	<44aeb8a6-1c4a-6859-51c7-b0e004859660@virtuozzo.com>
Message-ID: <cc0265d0-2d2f-3749-aa30-c8067a710509@virtuozzo.com>
Date: Mon, 13 Aug 2018 18:42:25 +0300
MIME-Version: 1.0
In-Reply-To: <44aeb8a6-1c4a-6859-51c7-b0e004859660@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 3/7] dirty-bitmap: add
 bdrv_dirty_bitmap_next_dirty_area
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, den@openvz.org

10.08.2018 20:05, Vladimir Sementsov-Ogievskiy wrote:
> 08.08.2018 15:49, Vladimir Sementsov-Ogievskiy wrote:
>> The function alters bdrv_dirty_iter_next_area(), which is wrong and
>> less efficient (see next commit for description).
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 include/block/dirty-bitmap.h |=C2=A0 3 +++
>> =C2=A0 include/qemu/hbitmap.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 +=
++++++++++++++
>> =C2=A0 block/dirty-bitmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 7 +++++++
>> =C2=A0 util/hbitmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 38=20
>> ++++++++++++++++++++++++++++++++++++++
>> =C2=A0 4 files changed, 63 insertions(+)
>>
>> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
>> index 5dc146abf3..c02be67564 100644
>> --- a/include/block/dirty-bitmap.h
>> +++ b/include/block/dirty-bitmap.h
>> @@ -100,6 +100,9 @@ BdrvDirtyBitmap=20
>> *bdrv_dirty_bitmap_next(BlockDriverState *bs,
>> =C2=A0 char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Err=
or=20
>> **errp);
>> =C2=A0 int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap,=20
>> uint64_t start,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 uint64_t bytes);
>> +bool bdrv_dirty_bitmap_next_dirty_area(BdrvDirtyBitmap *bitmap,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 uint64_t *offset, uint64_t end,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 uint64_t *length);
>> =C2=A0 BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverStat=
e=20
>> *bs,
>> BdrvDirtyBitmap *bitmap,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Error **errp);
>> diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
>> index cd091f6134..b1e897af28 100644
>> --- a/include/qemu/hbitmap.h
>> +++ b/include/qemu/hbitmap.h
>> @@ -306,6 +306,21 @@ unsigned long=20
>> hbitmap_iter_skip_words(HBitmapIter *hbi);
>> =C2=A0=C2=A0 */
>> =C2=A0 int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start,=20
>> uint64_t count);
>> =C2=A0 +/* hbitmap_next_dirty_area:
>> + * @hb: The HBitmap to operate on
>> + * @offset: in-out parameter.
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in: the offset=
 to start from
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 out: (if area =
found) start of found area
>> + * @end: end of requested region. (*@offset + *@length) will be <=3D @e=
nd
>> + * @length: length of found area
>> + *
>> + * If dirty area found within [@offset, @end), returns true and sets=20
>> @offset
>> + * and @length appropriately. Otherwise returns true and leaves=20
>> @offset and
>> + * @length unchanged.
>> + */
>> +bool hbitmap_next_dirty_area(const HBitmap *hb, uint64_t *offset,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t end, uint64_t *length);
>> +
>> =C2=A0 /* hbitmap_create_meta:
>> =C2=A0=C2=A0 * Create a "meta" hbitmap to track dirtiness of the bits in=
 this=20
>> HBitmap.
>> =C2=A0=C2=A0 * The caller owns the created bitmap and must call=20
>> hbitmap_free_meta(hb) to
>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>> index a9ee814da7..c24aa0e229 100644
>> --- a/block/dirty-bitmap.c
>> +++ b/block/dirty-bitmap.c
>> @@ -791,6 +791,13 @@ int64_t=20
>> bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t offset,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return hbitmap_next_zero(bitmap->bitmap, =
offset, bytes);
>> =C2=A0 }
>> =C2=A0 +bool bdrv_dirty_bitmap_next_dirty_area(BdrvDirtyBitmap *bitmap,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 uint64_t *offset, uint64_t end,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 uint64_t *length)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return hbitmap_next_dirty_area(bitmap->bitmap, offse=
t, end,=20
>> length);
>> +}
>> +
>> =C2=A0 void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const=20
>> BdrvDirtyBitmap *src,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp)
>> =C2=A0 {
>> diff --git a/util/hbitmap.c b/util/hbitmap.c
>> index 8dbcd80a3d..9de0d7bf2d 100644
>> --- a/util/hbitmap.c
>> +++ b/util/hbitmap.c
>> @@ -244,6 +244,44 @@ int64_t hbitmap_next_zero(const HBitmap *hb,=20
>> uint64_t start, uint64_t count)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return res;
>> =C2=A0 }
>> =C2=A0 +bool hbitmap_next_dirty_area(const HBitmap *hb, uint64_t *offset=
,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t end, uint64_t *length)
>> +{
>> +=C2=A0=C2=A0=C2=A0 HBitmapIter hbi;
>> +=C2=A0=C2=A0=C2=A0 int64_t off1, off0;
>> +=C2=A0=C2=A0=C2=A0 uint32_t granularity =3D 1UL << hb->granularity;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (end =3D=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end =3D hb->orig_size;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 hbitmap_iter_init(&hbi, hb, *offset << hb->granulari=
ty);
>
> "<< hb->granularity" should be dropped. Hmm, this patch needs tests.
>
>> +=C2=A0=C2=A0=C2=A0 off1 =3D hbitmap_iter_next(&hbi, true);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (off1 < 0 || off1 >=3D end) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (off1 + granularity >=3D end) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (off1 > *offset) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *off=
set =3D off1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *length =3D end - *offset;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 off0 =3D hbitmap_next_zero(hb, off1 + granularity, e=
nd);

-=C2=A0=C2=A0=C2=A0 off0 =3D hbitmap_next_zero(hb, off1 + granularity, end)=
;
+=C2=A0=C2=A0=C2=A0 off0 =3D hbitmap_next_zero(hb, off1 + granularity, end =
- off1 -=20
granularity);


>> +=C2=A0=C2=A0=C2=A0 if (off0 < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 off0 =3D end;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (off1 > *offset) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *offset =3D off1;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 *length =3D off0 - *offset;
>> +=C2=A0=C2=A0=C2=A0 return true;
>> +}
>> +
>> =C2=A0 bool hbitmap_empty(const HBitmap *hb)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return hb->count =3D=3D 0;
>
>


--=20
Best regards,
Vladimir
