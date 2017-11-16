Received: from eggs.gnu.org ([2001:4830:134:3::10]:58215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eFOl4-00005Y-4Z
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 13:19:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eFOl2-0003wg-Fh
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 13:19:26 -0500
References: <20171030163309.75770-1-vsementsov@virtuozzo.com>
	<20171030163309.75770-3-vsementsov@virtuozzo.com>
	<5027d8bb-fdec-a6ce-8150-96730d3a5ce4@redhat.com>
	<6299c687-9c73-f498-524c-e70709ca8a3b@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <81018bcc-d34f-e90c-cd48-5537b6a51920@redhat.com>
Date: Thu, 16 Nov 2017 13:18:48 -0500
MIME-Version: 1.0
In-Reply-To: <6299c687-9c73-f498-524c-e70709ca8a3b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 02/14] block/dirty-bitmap: add locked
 version of bdrv_release_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, famz@redhat.com, lirans@il.ibm.com, quintela@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com



On 11/16/2017 03:56 AM, Vladimir Sementsov-Ogievskiy wrote:
> 11.11.2017 01:52, John Snow wrote:
>>
>> On 10/30/2017 12:32 PM, Vladimir Sementsov-Ogievskiy wrote:
>>> It is needed to realize bdrv_dirty_bitmap_release_successor in
>>> the following patch.
>>>
>> OK, but...
>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>> =C2=A0 block/dirty-bitmap.c | 25 ++++++++++++++++++++-----
>>> =C2=A0 1 file changed, 20 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>>> index 81adbeb6d4..981f99d362 100644
>>> --- a/block/dirty-bitmap.c
>>> +++ b/block/dirty-bitmap.c
>>> @@ -326,13 +326,13 @@ static bool
>>> bdrv_dirty_bitmap_has_name(BdrvDirtyBitmap *bitmap)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return !!bdrv_dirty_bitmap_name(bitmap=
);
>>> =C2=A0 }
>>> =C2=A0 -/* Called with BQL taken.=C2=A0 */
>>> -static void bdrv_do_release_matching_dirty_bitmap(
>>> +/* Called within bdrv_dirty_bitmap_lock..unlock */
>> ...Add this so it will compile:
>>
>> __attribute__((__unused__))
>=20
> ok
>=20
>>> +static void bdrv_do_release_matching_dirty_bitmap_locked(
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriverState *bs, BdrvDirtyBitmap =
*bitmap,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool (*cond)(BdrvDirtyBitmap *bitmap))
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bm, *next;
>>> -=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmaps_lock(bs);
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QLIST_FOREACH_SAFE(bm, &bs->dirty_bitm=
aps, list, next) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((!bitmap |=
| bm =3D=3D bitmap) && (!cond || cond(bm))) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 assert(!bm->active_iterators);
>>> @@ -344,18 +344,33 @@ static void bdrv_do_release_matching_dirty_bitm=
ap(
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 g_free(bm);
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (bitmap) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto out;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bitmap) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abort();
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> Do we have any style guide rules on using abort() instead of assert()?
>> The rest of this function uses assert, and it'd be less lines to simpl=
y
>> write:
>>
>> assert(!bitmap);
>>
>> which I think might also carry better semantic information for coverit=
y
>> beyond an actual runtime conditional branch.
>>
>> (I think. Please correct me if I am wrong, I'm a little hazy on this.)
>=20
> agree, but it is a preexisting code, so I'll fix it with an additional
> patch.
>=20

You're right. I didn't notice it was pre-existing where I was looking at
it. I'll send my own little fixup. My mistake.

>>
>>> +}
>>> =C2=A0 -out:
>>> +/* Called with BQL taken.=C2=A0 */
>>> +static void bdrv_do_release_matching_dirty_bitmap(
>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
>>> +=C2=A0=C2=A0=C2=A0 bool (*cond)(BdrvDirtyBitmap *bitmap))
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmaps_lock(bs);
>>> +=C2=A0=C2=A0=C2=A0 bdrv_do_release_matching_dirty_bitmap_locked(bs, =
bitmap, cond);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmaps_unlock(bs);
>>> =C2=A0 }
>>> =C2=A0 +/* Called within bdrv_dirty_bitmap_lock..unlock */
>>> +static void bdrv_release_dirty_bitmap_locked(BlockDriverState *bs,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bitmap)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 bdrv_do_release_matching_dirty_bitmap_locked(bs, =
bitmap, NULL);
>>> +}
>>> +
>>> =C2=A0 /* Called with BQL taken.=C2=A0 */
>>> =C2=A0 void bdrv_release_dirty_bitmap(BlockDriverState *bs,
>>> BdrvDirtyBitmap *bitmap)
>>> =C2=A0 {
>>>
>> If you agree with those two changes, you may add:
>=20
> ok
>=20
>>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>=20
>=20

Just make sure it compiles standalone by using the unused attribute and
you can add the RB.

--js
