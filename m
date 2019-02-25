Received: from eggs.gnu.org ([209.51.188.92]:59658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gyLAD-0008NH-RY
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 13:39:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gyLA8-0006z3-KO
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 13:39:40 -0500
References: <20190223002209.23084-1-jsnow@redhat.com>
	<20190223002209.23084-2-jsnow@redhat.com>
	<5678ed17-fda7-4083-b4c6-488b3d6f916d@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <43b26a54-b52b-efd1-810e-ced939124b31@redhat.com>
Date: Mon, 25 Feb 2019 13:32:15 -0500
MIME-Version: 1.0
In-Reply-To: <5678ed17-fda7-4083-b4c6-488b3d6f916d@virtuozzo.com>
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>



On 2/25/19 9:18 AM, Vladimir Sementsov-Ogievskiy wrote:
> 23.02.2019 3:22, John Snow wrote:
>> Add an inconsistent bit to dirty-bitmaps that allows us to report a bi=
tmap as
>> persistent but potentially inconsistent, i.e. if we find bitmaps on a =
qcow2
>> that have been marked as "in use".
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   block/dirty-bitmap.c         | 19 +++++++++++++++++++
>>   include/block/dirty-bitmap.h |  2 ++
>>   qapi/block-core.json         |  8 ++++++--
>>   3 files changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>> index 86c3b87ab9..9042c04788 100644
>> --- a/block/dirty-bitmap.c
>> +++ b/block/dirty-bitmap.c
>> @@ -46,6 +46,9 @@ struct BdrvDirtyBitmap {
>>                                      and this bitmap must remain uncha=
nged while
>>                                      this flag is set. */
>>       bool persistent;            /* bitmap must be saved to owner dis=
k image */
>> +    bool inconsistent;          /* bitmap is persistent, but not owne=
d by QEMU.
>> +                                 * It cannot be used at all in any wa=
y, except
>> +                                 * a QMP user can remove it. */
>>       bool migration;             /* Bitmap is selected for migration,=
 it should
>>                                      not be stored on the next inactiv=
ation
>>                                      (persistent flag doesn't matter u=
ntil next
>> @@ -462,6 +465,8 @@ BlockDirtyInfoList *bdrv_query_dirty_bitmaps(Block=
DriverState *bs)
>>           info->recording =3D bdrv_dirty_bitmap_recording(bm);
>>           info->busy =3D bdrv_dirty_bitmap_busy(bm);
>>           info->persistent =3D bm->persistent;
>> +        info->has_inconsistent =3D bm->inconsistent;
>> +        info->inconsistent =3D bm->inconsistent;
>>           entry->value =3D info;
>>           *plist =3D entry;
>>           plist =3D &entry->next;
>> @@ -709,6 +714,15 @@ void bdrv_dirty_bitmap_set_persistance(BdrvDirtyB=
itmap *bitmap, bool persistent)
>>       qemu_mutex_unlock(bitmap->mutex);
>>   }
>>  =20
>> +/* Called with BQL taken. */
>> +void bdrv_dirty_bitmap_set_inconsistent(BdrvDirtyBitmap *bitmap)
>> +{
>> +    qemu_mutex_lock(bitmap->mutex);
>> +    bitmap->inconsistent =3D true;
>> +    bitmap->disabled =3D true;
>> +    qemu_mutex_unlock(bitmap->mutex);
>> +}
>=20
> Didn't you consider separate bdrv_create_inconsistent_bitmap, which wil=
l not allocate HBitmap?
>=20
> It may be done separately ofcourse..
>=20

Oh, when I was allowing clear I didn't do this step. Now that we are
allowing clear it could be skipped, but if it creates a lot of null
checks I'd rather just keep the empty alloc...

>> +
>>   /* Called with BQL taken. */
>>   void bdrv_dirty_bitmap_set_migration(BdrvDirtyBitmap *bitmap, bool m=
igration)
>>   {
>> @@ -722,6 +736,11 @@ bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyB=
itmap *bitmap)
>>       return bitmap->persistent && !bitmap->migration;
>>   }
>>  =20
>> +bool bdrv_dirty_bitmap_inconsistent(BdrvDirtyBitmap *bitmap)
>> +{
>> +    return bitmap->inconsistent;
>> +}
>> +
>>   bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs)
>>   {
>>       BdrvDirtyBitmap *bm;
>> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap=
.h
>> index ba8477b73f..b270773f7e 100644
>> --- a/include/block/dirty-bitmap.h
>> +++ b/include/block/dirty-bitmap.h
>> @@ -68,6 +68,7 @@ void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyB=
itmap *bitmap);
>>   void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap, bool va=
lue);
>>   void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap,
>>                                          bool persistent);
>> +void bdrv_dirty_bitmap_set_inconsistent(BdrvDirtyBitmap *bitmap);
>>   void bdrv_dirty_bitmap_set_busy(BdrvDirtyBitmap *bitmap, bool busy);
>>   void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyB=
itmap *src,
>>                                HBitmap **backup, Error **errp);
>> @@ -91,6 +92,7 @@ bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitma=
p *bitmap);
>>   bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
>>   bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap);
>>   bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap);
>> +bool bdrv_dirty_bitmap_inconsistent(BdrvDirtyBitmap *bitmap);
>>   bool bdrv_dirty_bitmap_busy(BdrvDirtyBitmap *bitmap);
>>   bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
>>   BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 6e543594b3..a7209fce22 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -470,12 +470,16 @@
>>   # @persistent: true if the bitmap will eventually be flushed to pers=
istent
>>   #              storage (since 4.0)
>>   #
>> +# @inconsistent: true if this is a persistent bitmap that QEMU does n=
ot own.
>> +#                Implies @recording and @busy to be false. To reclaim
>> +#                ownership, use @block-dirty-bitmap-remove. (since 4.=
0)
>=20
> If we opened an image for rw with in-use bitmaps, the main thing about =
them not
> that QEMU doesn't own them, but that they are truly inconsistent. Nobod=
y owns them.
>=20
> Also, "QEMU does not own" sound like somebody other may own. Then remov=
ing it don't
> seem a correct thing to do.
>=20
> And removing don't reclaim ownership, but just remove (looks like it wa=
s more about
> previous version with -clear).
>=20
> So for me something like: "Bitmap was not correctly saved after last us=
age, so it
> may be inconsistent. It's useless and only take place in a list. The on=
ly possible
> operation on it is remove." seems better.
>=20
>> +#
>>   # Since: 1.3
>>   ##
>>   { 'struct': 'BlockDirtyInfo',
>>     'data': {'*name': 'str', 'count': 'int', 'granularity': 'uint32',
>> -           'recording': 'bool', 'busy': 'bool',
>> -           'status': 'DirtyBitmapStatus', 'persistent': 'bool' } }
>> +           'recording': 'bool', 'busy': 'bool', 'status': 'DirtyBitma=
pStatus',
>> +           'persistent': 'bool', '*inconsistent': 'bool' } }
>>  =20
>>   ##
>>   # @Qcow2BitmapInfoFlags:
>>
>=20
>=20

--=20
=E2=80=94js
