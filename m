Received: from eggs.gnu.org ([209.51.188.92]:44307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gz4D5-0004GY-Al
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 13:45:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gz4Cz-0004Gm-OO
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 13:45:37 -0500
References: <20190223002209.23084-1-jsnow@redhat.com>
	<20190223002209.23084-2-jsnow@redhat.com>
	<5678ed17-fda7-4083-b4c6-488b3d6f916d@virtuozzo.com>
	<86bbc4f0-288b-4b3a-1f6a-cb3de29d80f4@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <fb9fc496-02f7-5724-06fd-fc4dcfc2b9c9@redhat.com>
Date: Wed, 27 Feb 2019 13:45:16 -0500
MIME-Version: 1.0
In-Reply-To: <86bbc4f0-288b-4b3a-1f6a-cb3de29d80f4@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] block/dirty-bitmaps: add
 inconsistent bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 2/25/19 10:30 AM, Vladimir Sementsov-Ogievskiy wrote:
> 25.02.2019 17:18, Vladimir Sementsov-Ogievskiy wrote:
>> 23.02.2019 3:22, John Snow wrote:
>>> Add an inconsistent bit to dirty-bitmaps that allows us to report a b=
itmap as
>>> persistent but potentially inconsistent, i.e. if we find bitmaps on a=
 qcow2
>>> that have been marked as "in use".
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>> =C2=A0 block/dirty-bitmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 19 +++++++++++++++++++
>>> =C2=A0 include/block/dirty-bitmap.h |=C2=A0 2 ++
>>> =C2=A0 qapi/block-core.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 8 ++++++--
>>> =C2=A0 3 files changed, 27 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>>> index 86c3b87ab9..9042c04788 100644
>>> --- a/block/dirty-bitmap.c
>>> +++ b/block/dirty-bitmap.c
>>> @@ -46,6 +46,9 @@ struct BdrvDirtyBitmap {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
and this bitmap must remain unchanged while
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
this flag is set. */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool persistent;=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* bitmap must be saved to own=
er disk image */
>>> +=C2=A0=C2=A0=C2=A0 bool inconsistent;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* bitmap is persistent, but not owned by QEMU.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * It cannot be used at a=
ll in any way, except
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * a QMP user can remove =
it. */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool migration;=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Bitmap is selected fo=
r migration, it should
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
not be stored on the next inactivation
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
(persistent flag doesn't matter until next
>>> @@ -462,6 +465,8 @@ BlockDirtyInfoList *bdrv_query_dirty_bitmaps(Bloc=
kDriverState *bs)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->recordin=
g =3D bdrv_dirty_bitmap_recording(bm);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->busy =3D=
 bdrv_dirty_bitmap_busy(bm);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->persiste=
nt =3D bm->persistent;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->has_inconsistent =3D=
 bm->inconsistent;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->inconsistent =3D bm=
->inconsistent;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry->value =3D=
 info;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *plist =3D ent=
ry;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 plist =3D &ent=
ry->next;
>>> @@ -709,6 +714,15 @@ void bdrv_dirty_bitmap_set_persistance(BdrvDirty=
Bitmap *bitmap, bool persistent)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_mutex_unlock(bitmap->mutex);
>>> =C2=A0 }
>>> +/* Called with BQL taken. */
>>> +void bdrv_dirty_bitmap_set_inconsistent(BdrvDirtyBitmap *bitmap)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 qemu_mutex_lock(bitmap->mutex);
>>> +=C2=A0=C2=A0=C2=A0 bitmap->inconsistent =3D true;
>>> +=C2=A0=C2=A0=C2=A0 bitmap->disabled =3D true;
>>> +=C2=A0=C2=A0=C2=A0 qemu_mutex_unlock(bitmap->mutex);
>>> +}
>>
>> Didn't you consider separate bdrv_create_inconsistent_bitmap, which wi=
ll not allocate HBitmap?
>>
>> It may be done separately ofcourse..
>>
>>> +
>>> =C2=A0 /* Called with BQL taken. */
>>> =C2=A0 void bdrv_dirty_bitmap_set_migration(BdrvDirtyBitmap *bitmap, =
bool migration)
>>> =C2=A0 {
>>> @@ -722,6 +736,11 @@ bool bdrv_dirty_bitmap_get_persistance(BdrvDirty=
Bitmap *bitmap)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return bitmap->persistent && !bitmap->=
migration;
>>> =C2=A0 }
>>> +bool bdrv_dirty_bitmap_inconsistent(BdrvDirtyBitmap *bitmap)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 return bitmap->inconsistent;
>>> +}
>>> +
>>> =C2=A0 bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bm;
>>> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitma=
p.h
>>> index ba8477b73f..b270773f7e 100644
>>> --- a/include/block/dirty-bitmap.h
>>> +++ b/include/block/dirty-bitmap.h
>>> @@ -68,6 +68,7 @@ void bdrv_dirty_bitmap_deserialize_finish(BdrvDirty=
Bitmap *bitmap);
>>> =C2=A0 void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap, b=
ool value);
>>> =C2=A0 void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap=
,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bool persistent);
>>> +void bdrv_dirty_bitmap_set_inconsistent(BdrvDirtyBitmap *bitmap);
>>> =C2=A0 void bdrv_dirty_bitmap_set_busy(BdrvDirtyBitmap *bitmap, bool =
busy);
>>> =C2=A0 void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const Bdrv=
DirtyBitmap *src,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HBitmap **backup, Error **errp);
>>> @@ -91,6 +92,7 @@ bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitm=
ap *bitmap);
>>> =C2=A0 bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
>>> =C2=A0 bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bit=
map);
>>> =C2=A0 bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap=
);
>>> +bool bdrv_dirty_bitmap_inconsistent(BdrvDirtyBitmap *bitmap);
>>> =C2=A0 bool bdrv_dirty_bitmap_busy(BdrvDirtyBitmap *bitmap);
>>> =C2=A0 bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs)=
;
>>> =C2=A0 BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index 6e543594b3..a7209fce22 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -470,12 +470,16 @@
>>> =C2=A0 # @persistent: true if the bitmap will eventually be flushed t=
o persistent
>>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 storage (since 4.0)
>=20
> so, bitmap can't be inconsistent and persistent, as we don't want to fl=
ush
> inconsistent bitmaps...
>=20

I think ideally I'd just change this phrasing to say something like
"true if the bitmap is stored on-disk, or is scheduled to be flushed to
disk."

>>> =C2=A0 #
>>> +# @inconsistent: true if this is a persistent bitmap that QEMU does =
not own.
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 Implies @recording and @busy to be false. To reclai=
m
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ownership, use @block-dirty-bitmap-remove. (since 4=
.0)
>>
>> If we opened an image for rw with in-use bitmaps, the main thing about=
 them not
>> that QEMU doesn't own them, but that they are truly inconsistent. Nobo=
dy owns them.
>>
>> Also, "QEMU does not own" sound like somebody other may own. Then remo=
ving it don't
>> seem a correct thing to do.
>>
>> And removing don't reclaim ownership, but just remove (looks like it w=
as more about
>> previous version with -clear).
>>
>> So for me something like: "Bitmap was not correctly saved after last u=
sage, so it
>> may be inconsistent. It's useless and only take place in a list. The o=
nly possible
>> operation on it is remove." seems better.
>>

You're right. I was going by memory, but the spec says rather plainly:
"The bitmap was not saved correctly." Pretty unambiguous.

I *was* leaving open the window that this bitmap was just simply...
something QEMU didn't understand or know about, but the spec doesn't
allow for that, so I will tighten the phrasing.

I've looked at the counter-proposal now, but I'm not convinced that I
want to have to worry about the 97 usages of the bitmap field now that
it can be NULL... Really, we shouldn't be using the allocated bitmap at
all in these cases -- I agree -- but I worry that this is a premature
optimization that makes determining the correctness of the code by a
human reader a little more difficult.

Ideally we have no bugs, but if we did accidentally use a blank bitmap,
that's much less of a problem than an assertion or SIGSEGV.

Am I being too conservative?

>>> +#
>>> =C2=A0 # Since: 1.3
>>> =C2=A0 ##
>>> =C2=A0 { 'struct': 'BlockDirtyInfo',
>>> =C2=A0=C2=A0=C2=A0 'data': {'*name': 'str', 'count': 'int', 'granular=
ity': 'uint32',
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'record=
ing': 'bool', 'busy': 'bool',
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'status=
': 'DirtyBitmapStatus', 'persistent': 'bool' } }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'record=
ing': 'bool', 'busy': 'bool', 'status': 'DirtyBitmapStatus',
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'persis=
tent': 'bool', '*inconsistent': 'bool' } }
>>> =C2=A0 ##
>>> =C2=A0 # @Qcow2BitmapInfoFlags:
>>>
>>
>>
>=20
>=20
