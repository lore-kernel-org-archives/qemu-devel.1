Received: from eggs.gnu.org ([2001:4830:134:3::10]:52734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eFkJx-000172-Vf
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 12:20:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eFkJw-00045J-Ox
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 12:20:53 -0500
References: <20171030163309.75770-1-vsementsov@virtuozzo.com>
	<20171030163309.75770-5-vsementsov@virtuozzo.com>
	<a593e984-5d1e-a95c-9b80-dbe82227b8f9@redhat.com>
	<fac1abb3-f783-ec93-3a60-13dbd666d26e@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d27739c1-9cbe-ea30-d711-bf067013918f@redhat.com>
Date: Fri, 17 Nov 2017 12:20:31 -0500
MIME-Version: 1.0
In-Reply-To: <fac1abb3-f783-ec93-3a60-13dbd666d26e@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 04/14] block/dirty-bitmap: add
 bdrv_dirty_bitmap_set_frozen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, famz@redhat.com
Cc: kwolf@redhat.com, peter.maydell@linaro.org, lirans@il.ibm.com, quintela@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com



On 11/17/2017 09:46 AM, Vladimir Sementsov-Ogievskiy wrote:
> 14.11.2017 02:32, John Snow wrote:
>>
>> On 10/30/2017 12:32 PM, Vladimir Sementsov-Ogievskiy wrote:
>>> Make it possible to set bitmap 'frozen' without a successor.
>>> This is needed to protect the bitmap during outgoing bitmap postcopy
>>> migration.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>> =C2=A0 include/block/dirty-bitmap.h |=C2=A0 1 +
>>> =C2=A0 block/dirty-bitmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 22 ++++++++++++++++++++--
>>> =C2=A0 2 files changed, 21 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitma=
p.h
>>> index a9e2a92e4f..ae6d697850 100644
>>> --- a/include/block/dirty-bitmap.h
>>> +++ b/include/block/dirty-bitmap.h
>>> @@ -39,6 +39,7 @@ uint32_t
>>> bdrv_get_default_bitmap_granularity(BlockDriverState *bs);
>>> =C2=A0 uint32_t bdrv_dirty_bitmap_granularity(const BdrvDirtyBitmap *=
bitmap);
>>> =C2=A0 bool bdrv_dirty_bitmap_enabled(BdrvDirtyBitmap *bitmap);
>>> =C2=A0 bool bdrv_dirty_bitmap_frozen(BdrvDirtyBitmap *bitmap);
>>> +void bdrv_dirty_bitmap_set_frozen(BdrvDirtyBitmap *bitmap, bool
>>> frozen);
>>> =C2=A0 const char *bdrv_dirty_bitmap_name(const BdrvDirtyBitmap *bitm=
ap);
>>> =C2=A0 int64_t bdrv_dirty_bitmap_size(const BdrvDirtyBitmap *bitmap);
>>> =C2=A0 DirtyBitmapStatus bdrv_dirty_bitmap_status(BdrvDirtyBitmap *bi=
tmap);
>>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>>> index 7578863aa1..67fc6bd6e0 100644
>>> --- a/block/dirty-bitmap.c
>>> +++ b/block/dirty-bitmap.c
>>> @@ -40,6 +40,8 @@ struct BdrvDirtyBitmap {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QemuMutex *mutex;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HBitmap *bitmap;=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Dirty bitmap implementation=
 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HBitmap *meta;=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Meta dirty bitm=
ap */
>>> +=C2=A0=C2=A0=C2=A0 bool frozen;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Bitmap is frozen, =
it can't be
>>> modified
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 through QMP =
*/
>> I hesitate, because this now means that we have two independent bits o=
f
>> state we need to update and maintain consistency with.
>=20
> it was your proposal)))
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg01172.html
>=20
> "
> Your new use case here sounds like Frozen to me, but it simply does not
> have an anonymous successor to force it to be recognized as "frozen." W=
e
> can add a `bool protected` or `bool frozen` field to force recognition
> of this status and adjust the json documentation accordingly.
>=20
> I think then we'd have four recognized states:
>=20
> FROZEN: Cannot be reset/deleted. Bitmap is in-use by a block job or
> other internal process. Bitmap is otherwise ACTIVE.
> DISABLED: Not recording any writes (by choice.)
> READONLY: Not able to record any writes (by necessity.)
> ACTIVE: Normal bitmap status.
>=20
> Sound right?
> "
>=20
>=20

I was afraid you'd say that :(

It's okay, anyway. I shouldn't let myself go so long between reviews
like this, because you catch me changing my mind. Anyway, please go
ahead with it. I don't want to delay you on something that works because
I can't make up *my* mind.
