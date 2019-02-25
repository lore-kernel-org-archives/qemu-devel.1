Received: from eggs.gnu.org ([209.51.188.92]:38456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gyNiU-0004JB-6t
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 16:23:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gyNiQ-0004JG-GL
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 16:23:14 -0500
References: <20190223002209.23084-1-jsnow@redhat.com>
	<20190223002209.23084-4-jsnow@redhat.com>
	<be3360bb-cbc1-daa1-2297-f3f8a88faac9@virtuozzo.com>
	<f8cee179-d67f-2426-7d65-c208a82f1876@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <10b65932-bf83-a9a4-4e9c-69910ae60d48@redhat.com>
Date: Mon, 25 Feb 2019 16:22:52 -0500
MIME-Version: 1.0
In-Reply-To: <f8cee179-d67f-2426-7d65-c208a82f1876@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/4] block/dirty-bitmaps: add
 block_dirty_bitmap_check function
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



On 2/25/19 9:59 AM, Vladimir Sementsov-Ogievskiy wrote:
> 25.02.2019 16:37, Vladimir Sementsov-Ogievskiy wrote:
>> 23.02.2019 3:22, John Snow wrote:
>>> Instead of checking against busy, inconsistent, or read only directly=
,
>>> use a check function with permissions bits that let us streamline the
>>> checks without reproducing them in many places.
>>>
>>> As a side effect, this adds consistency checks to all the QMP
>>> interfaces for bitmap manipulation.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>> =C2=A0 block/dirty-bitmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 39 ++++++++++++++++++++-------
>>> =C2=A0 blockdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 49 +=
++++++---------------------------
>>> =C2=A0 include/block/dirty-bitmap.h=C2=A0=C2=A0 | 13 ++++++++-
>>> =C2=A0 migration/block-dirty-bitmap.c | 12 +++------
>>> =C2=A0 nbd/server.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +--
>>> =C2=A0 5 files changed, 54 insertions(+), 62 deletions(-)
>>>
>>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>>> index 4e8f931659..2e7fd81866 100644
>>> --- a/block/dirty-bitmap.c
>>> +++ b/block/dirty-bitmap.c
>>> @@ -174,7 +174,7 @@ bool bdrv_dirty_bitmap_has_successor(BdrvDirtyBit=
map *bitmap)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return bitmap->successor;
>>> =C2=A0 }
>>> -bool bdrv_dirty_bitmap_busy(BdrvDirtyBitmap *bitmap) {
>>> +static bool bdrv_dirty_bitmap_busy(BdrvDirtyBitmap *bitmap) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return bitmap->busy;
>>> =C2=A0 }
>>> @@ -235,6 +235,33 @@ static bool bdrv_dirty_bitmap_recording(BdrvDirt=
yBitmap *bitmap)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !bitmap->suc=
cessor->disabled);
>>> =C2=A0 }
>>> +int bdrv_dirty_bitmap_check(BdrvDirtyBitmap *bitmap, uint32_t flags,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Error **errp)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 if ((flags & BDRV_BITMAP_BUSY) && bdrv_dirty_bitm=
ap_busy(bitmap)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Bitmap =
'%s' is currently in use by another"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " operation and cannot be used", =
bitmap->name);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if ((flags & BDRV_BITMAP_RO) && bdrv_dirty_bitmap=
_readonly(bitmap)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Bitmap =
'%s' is readonly and cannot be modified",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmap->name);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if ((flags & BDRV_BITMAP_INCONSISTENT) &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_inconsi=
stent(bitmap)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Bitmap =
'%s' is inconsistent and cannot be used",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmap->name);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_append_hint(errp, "=
Try block-dirty-bitmap-remove to delete "
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 "this bitmap from disk");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +
>>> =C2=A0 /**
>>> =C2=A0=C2=A0 * Create a successor bitmap destined to replace this bit=
map after an operation.
>>> =C2=A0=C2=A0 * Requires that the bitmap is not user_locked and has no=
 successor.
>>> @@ -792,15 +819,7 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *de=
st, const BdrvDirtyBitmap *src,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_mutex_lock(dest->mutex);
>>> -=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_busy(dest)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Bitmap =
'%s' is currently in use by another"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " operation and cannot be=
 modified", dest->name);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>> -=C2=A0=C2=A0=C2=A0 }
>>> -
>>> -=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_readonly(dest)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Bitmap =
'%s' is readonly and cannot be modified",
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dest->name);
>>> +=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_check(dest, BDRV_BITMAP_DEF=
AULT, errp)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> diff --git a/blockdev.c b/blockdev.c
>>> index cbce44877d..5d74479ba7 100644
>>> --- a/blockdev.c
>>> +++ b/blockdev.c
>>> @@ -2007,11 +2007,7 @@ static void block_dirty_bitmap_clear_prepare(B=
lkActionState *common,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_busy(state->bitmap)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Cannot =
modify a bitmap in use by another operation");
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> -=C2=A0=C2=A0=C2=A0 } else if (bdrv_dirty_bitmap_readonly(state->bitm=
ap)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Cannot =
clear a readonly bitmap");
>>> +=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_check(state->bitmap, BDRV_B=
ITMAP_DEFAULT, errp)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> @@ -2056,10 +2052,7 @@ static void block_dirty_bitmap_enable_prepare(=
BlkActionState *common,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_busy(state->bitmap)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Bitmap '%s' is currently in use =
by another operation"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " and cannot be enabled", action-=
>name);
>>> +=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_check(state->bitmap, BDRV_B=
ITMAP_ALLOW_RO, errp)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> hmm, preexisting, but seems a very bad idea to enable readonly bitmap.
>>

Hmm...

I think I was thinking that you might want to enable or disable the
bitmap prior to remounting RW. I think that's a valid sequence of events.

>>> @@ -2097,10 +2090,7 @@ static void block_dirty_bitmap_disable_prepare=
(BlkActionState *common,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_busy(state->bitmap)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Bitmap '%s' is currently in use =
by another operation"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " and cannot be disabled", action=
->name);
>>> +=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_check(state->bitmap, BDRV_B=
ITMAP_ALLOW_RO, errp)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> as well as disable too
>>
>>> @@ -2891,10 +2881,7 @@ void qmp_block_dirty_bitmap_remove(const char =
*node, const char *name,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_busy(bitmap)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Bitmap '%s' is currently in use =
by another operation and"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " cannot be removed", name);
>>> +=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_B=
USY, errp)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> yes it's OK to remove inconsistent bitmap..
>>
>> what about readonly? I don't see a problem with it, readonly just mean=
s that we didn't set INUSE
>> flag for bitmap, but if we are going to remove it, why not? But it mos=
t probably will fail,
>> as qcow2 image is most probably readonly too.
>>
>> any way, it seems correct to chack only for _BUSY here.
>>

Given my reasoning below, I think maybe I should just make this fail as
early as possible. We KNOW that the image is read only. We KNOW that
this will fail. Best to just make it fail very quickly.

>>> @@ -2930,13 +2917,7 @@ void qmp_block_dirty_bitmap_clear(const char *=
node, const char *name,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_busy(bitmap)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Bitmap '%s' is currently in use =
by another operation"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " and cannot be cleared", name);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> -=C2=A0=C2=A0=C2=A0 } else if (bdrv_dirty_bitmap_readonly(bitmap)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Bitmap =
'%s' is readonly and cannot be cleared", name);
>>> +=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_D=
EFAULT, errp)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> @@ -2954,10 +2935,7 @@ void qmp_block_dirty_bitmap_enable(const char =
*node, const char *name,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_busy(bitmap)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Bitmap '%s' is currently in use =
by another operation"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " and cannot be enabled", name);
>>> +=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_A=
LLOW_RO, errp)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> @@ -2975,10 +2953,7 @@ void qmp_block_dirty_bitmap_disable(const char=
 *node, const char *name,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_busy(bitmap)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Bitmap '%s' is currently in use =
by another operation"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " and cannot be disabled", name);
>>> +=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_A=
LLOW_RO, errp)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> @@ -3551,10 +3526,7 @@ static BlockJob *do_drive_backup(DriveBackup *=
backup, JobTxn *txn,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 bdrv_unref(target_bs);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto out;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_bus=
y(bmap)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
rror_setg(errp,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Bitmap '=
%s' is currently in use by another operation"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " and can=
not be used for backup", backup->bitmap);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_che=
ck(bmap, BDRV_BITMAP_ALLOW_RO, errp)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto out;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> @@ -3664,10 +3636,7 @@ BlockJob *do_blockdev_backup(BlockdevBackup *b=
ackup, JobTxn *txn,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 error_setg(errp, "Bitmap '%s' could not be found", backup->bitm=
ap);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto out;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_bus=
y(bmap)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
rror_setg(errp,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Bitmap '=
%s' is currently in use by another operation"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " and can=
not be used for backup", backup->bitmap);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_che=
ck(bmap, BDRV_BITMAP_ALLOW_RO, errp)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto out;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> hmm, and doing backup on RO bitmap is questionable thing. On one hand =
- why not, we can.
>>
>> But we will not be able to abdicate, as we can't modify bitmap.
>>
>> So, it seems better to restrict it too. If use needs to do an incremen=
tal backup from
>> read-only image, not modifying a bitmap, he should either copy this bi=
tmap (through
>> merge for example) to a not-persistent one, or he need a way to skip b=
itmap_abdicate.
>>

Hmm, you are right... we can't clear the bitmap on success, and we KNOW
we'll be unable to do that from the outset. It's better to fail early.

I'll amend this.

>>> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitma=
p.h
>>> index b270773f7e..ee98b5014b 100644
>>> --- a/include/block/dirty-bitmap.h
>>> +++ b/include/block/dirty-bitmap.h
>>> @@ -5,6 +5,16 @@
>>> =C2=A0 #include "qapi/qapi-types-block-core.h"
>>> =C2=A0 #include "qemu/hbitmap.h"
>>> +typedef enum BitmapCheckFlags {
>>> +=C2=A0=C2=A0=C2=A0 BDRV_BITMAP_BUSY =3D 1,
>>> +=C2=A0=C2=A0=C2=A0 BDRV_BITMAP_RO =3D 2,
>>> +=C2=A0=C2=A0=C2=A0 BDRV_BITMAP_INCONSISTENT =3D 4,
>>> +} BitmapCheckFlags;
>>> +
>>> +#define BDRV_BITMAP_DEFAULT (BDRV_BITMAP_BUSY | BDRV_BITMAP_RO |=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 BDRV_BITMAP_INCONSISTENT)
>>> +#define BDRV_BITMAP_ALLOW_RO (BDRV_BITMAP_BUSY | BDRV_BITMAP_INCONSI=
STENT)
>>> +
>>> =C2=A0 BdrvDirtyBitmap *bdrv_create_dirty_bitmap(BlockDriverState *bs=
,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t granularity,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *name,
>>> @@ -24,6 +34,8 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDri=
verState *bs,
>>> =C2=A0 void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitma=
p);
>>> =C2=A0 BdrvDirtyBitmap *bdrv_find_dirty_bitmap(BlockDriverState *bs,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *name);
>>> +int bdrv_dirty_bitmap_check(BdrvDirtyBitmap *bitmap, uint32_t flags,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Error **errp);
>>> =C2=A0 void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirty=
Bitmap *bitmap);
>>> =C2=A0 void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs);
>>> =C2=A0 void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>>> @@ -93,7 +105,6 @@ bool bdrv_has_readonly_bitmaps(BlockDriverState *b=
s);
>>> =C2=A0 bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bit=
map);
>>> =C2=A0 bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap=
);
>>> =C2=A0 bool bdrv_dirty_bitmap_inconsistent(BdrvDirtyBitmap *bitmap);
>>> -bool bdrv_dirty_bitmap_busy(BdrvDirtyBitmap *bitmap);
>>> =C2=A0 bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs)=
;
>>> =C2=A0 BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bitmap);
>>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-b=
itmap.c
>>> index 7057fff242..0fcf897f32 100644
>>> --- a/migration/block-dirty-bitmap.c
>>> +++ b/migration/block-dirty-bitmap.c
>>> @@ -274,6 +274,7 @@ static int init_dirty_bitmap_migration(void)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bitmap;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DirtyBitmapMigBitmapState *dbms;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BdrvNextIterator it;
>>> +=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dirty_bitmap_mig_state.bulk_completed =
=3D false;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dirty_bitmap_mig_state.prev_bs =3D NUL=
L;
>>> @@ -301,15 +302,8 @@ static int init_dirty_bitmap_migration(void)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (bdrv_dirty_bitmap_busy(bitmap)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_report("Can't migrate a bitmap that is in use=
 by another operation: '%s'",
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_name(bitmap));
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto fail;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (bdrv_dirty_bitmap_readonly(bitmap)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_report("Can't migrate read-only dirty bitmap:=
 '%s",
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_name(bitmap));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_DEFAULT, &local_err)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_report_err(local_err);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 }
>>> diff --git a/nbd/server.c b/nbd/server.c
>>> index 02773e2836..9b87c7f243 100644
>>> --- a/nbd/server.c
>>> +++ b/nbd/server.c
>>> @@ -1510,8 +1510,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs,=
 uint64_t dev_offset,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto fail;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_bus=
y(bm)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
rror_setg(errp, "Bitmap '%s' is in use", bitmap);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_che=
ck(bm, BDRV_BITMAP_ALLOW_RO, errp)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto fail;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>
>> and it is the only correct usage of ALLOW_RO, I think.
>>
>> hmm, doesn't this mean that we should move to "int flags" in BdrvDirty=
Bitmap?
>=20
> and this will gave us cool bdrv_create_dirty_bitmap with flags, to easi=
ly create different kind of bitmaps.
>=20
>=20
> And one more important question: we now creating new qapi bitmap status=
, consisting of several bool fields.
> Shouldn't we instead implement it as an array of flags?
>=20
>=20

To the above questions I am deferring to Eric's judgement[1], I happen
to like flags as well but I trust Eric's assessment that it's more
complicated than we need in this case.

I also don't want to encourage anybody adding any more :)


[1] en-US spelling suggests we ought to use "judgment", but that's
stupid and I hate it. I will not cater to prescriptivists.
