Received: from eggs.gnu.org ([2001:4830:134:3::10]:45396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eUWAc-00022L-0k
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 06:16:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eUWAX-0006bz-0X
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 06:16:17 -0500
References: <20171220154945.88410-1-vsementsov@virtuozzo.com>
	<20171220154945.88410-4-vsementsov@virtuozzo.com>
	<20171228052418.GC9192@lemon>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f6637c9d-047b-b9f3-1a5a-4b59baf49cbc@virtuozzo.com>
Date: Thu, 28 Dec 2017 14:16:06 +0300
MIME-Version: 1.0
In-Reply-To: <20171228052418.GC9192@lemon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v9 03/13] block/dirty-bitmap: add _locked
 version of bdrv_reclaim_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

28.12.2017 08:24, Fam Zheng wrote:
> On Wed, 12/20 18:49, Vladimir Sementsov-Ogievskiy wrote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   include/block/dirty-bitmap.h |  3 +++
>>   block/dirty-bitmap.c         | 25 ++++++++++++++++---------
>>   2 files changed, 19 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
>> index 93d4336505..caf1f3d861 100644
>> --- a/include/block/dirty-bitmap.h
>> +++ b/include/block/dirty-bitmap.h
>> @@ -92,5 +92,8 @@ bool bdrv_has_changed_persistent_bitmaps(BlockDriverSt=
ate *bs);
>>   BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
>>                                           BdrvDirtyBitmap *bitmap);
>>   char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **=
errp);
>> +BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
>> +                                                  BdrvDirtyBitmap *bitm=
ap,
>> +                                                  Error **errp);
>>  =20
>>   #endif
>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>> index d83da077d5..fe27ddfb83 100644
>> --- a/block/dirty-bitmap.c
>> +++ b/block/dirty-bitmap.c
>> @@ -327,15 +327,11 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockD=
riverState *bs,
>>    * The merged parent will be un-frozen, but not explicitly re-enabled.
>>    * Called with BQL taken.
> Maybe update the comment as
>
> s/Called with BQL taken/Called within bdrv_dirty_bitmap_lock..unlock/
>
> and ...

we have the following comment:

 =C2=A0=C2=A0=C2=A0 /* Writing to the list requires the BQL _and_ the dirty=
_bitmap_mutex.
 =C2=A0=C2=A0=C2=A0=C2=A0 * Reading from the list can be done with either t=
he BQL or the
 =C2=A0=C2=A0=C2=A0=C2=A0 * dirty_bitmap_mutex.=C2=A0 Modifying a bitmap on=
ly requires
 =C2=A0=C2=A0=C2=A0=C2=A0 * dirty_bitmap_mutex. */
 =C2=A0=C2=A0=C2=A0 QemuMutex dirty_bitmap_mutex;

(I don't understand well the logic, why is it so. Paolo introduced the=20
lock, but didn't update some functions..)

so, actually, here we need both BQL and mutex.

>
>>    */
>> -BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
>> -                                           BdrvDirtyBitmap *parent,
>> -                                           Error **errp)
>> +BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
>> +                                                  BdrvDirtyBitmap *pare=
nt,
>> +                                                  Error **errp)
>>   {
>> -    BdrvDirtyBitmap *successor;
>> -
>> -    qemu_mutex_lock(parent->mutex);
>> -
>> -    successor =3D parent->successor;
>> +    BdrvDirtyBitmap *successor =3D parent->successor;
>>  =20
>>       if (!successor) {
>>           error_setg(errp, "Cannot reclaim a successor when none is pres=
ent");
>> @@ -349,9 +345,20 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDri=
verState *bs,
>>       bdrv_release_dirty_bitmap_locked(bs, successor);
>>       parent->successor =3D NULL;
>>  =20
>> +    return parent;
>> +}
>> +
> ... move the "Called with BQL taken" comment here?

and here BQL.

Ok, I'll add/fix comments.

>
>> +BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
>> +                                           BdrvDirtyBitmap *parent,
>> +                                           Error **errp)
>> +{
>> +    BdrvDirtyBitmap *ret;
>> +
>> +    qemu_mutex_lock(parent->mutex);
>> +    ret =3D bdrv_reclaim_dirty_bitmap_locked(bs, parent, errp);
>>       qemu_mutex_unlock(parent->mutex);
>>  =20
>> -    return parent;
>> +    return ret;
>>   }
>>  =20
>>   /**
>> --=20
>> 2.11.1
>>


--=20
Best regards,
Vladimir
