Received: from eggs.gnu.org ([2001:4830:134:3::10]:55776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f0Qgb-0002Or-4R
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 07:53:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f0Qga-00080I-0l
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 07:53:13 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20180326112056.8420-1-vsementsov@virtuozzo.com>
	<20180326112056.8420-6-vsementsov@virtuozzo.com>
	<aa6a8e20-de93-a021-0129-9a6483b85453@redhat.com>
	<23257966-580c-6b38-0c3a-eac0d3870809@virtuozzo.com>
Message-ID: <eef75dd5-bb86-4d72-e3eb-e08c3b223861@virtuozzo.com>
Date: Mon, 26 Mar 2018 14:53:01 +0300
MIME-Version: 1.0
In-Reply-To: <23257966-580c-6b38-0c3a-eac0d3870809@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 5/7] blockdev: refactor
 block-dirty-bitmap-clear transaction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com

26.03.2018 14:48, Vladimir Sementsov-Ogievskiy wrote:
> 26.03.2018 14:44, Paolo Bonzini wrote:
>> On 26/03/2018 13:20, Vladimir Sementsov-Ogievskiy wrote:
>>> bdrv_clear_dirty_bitmap do not fail, so we can call it in transaction
>>> commit, avoiding any rollback.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>> =C2=A0 blockdev.c | 16 +---------------
>>> =C2=A0 1 file changed, 1 insertion(+), 15 deletions(-)
>>>
>>> diff --git a/blockdev.c b/blockdev.c
>>> index c31bf3d98d..88eae60c1c 100644
>>> --- a/blockdev.c
>>> +++ b/blockdev.c
>>> @@ -2050,7 +2050,6 @@ typedef struct BlockDirtyBitmapState {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlkActionState common;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bitmap;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriverState *bs;
>>> -=C2=A0=C2=A0=C2=A0 HBitmap *backup;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool prepared;
>>> =C2=A0 } BlockDirtyBitmapState;
>>> =C2=A0 @@ -2129,18 +2128,6 @@ static void=20
>>> block_dirty_bitmap_clear_prepare(BlkActionState *common,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp,=
 "Cannot clear a readonly bitmap");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -
>>> -=C2=A0=C2=A0=C2=A0 bdrv_clear_dirty_bitmap(state->bitmap, &state->back=
up);
>>> -}
>>> -
>>> -static void block_dirty_bitmap_clear_abort(BlkActionState *common)
>>> -{
>>> -=C2=A0=C2=A0=C2=A0 BlockDirtyBitmapState *state =3D DO_UPCAST(BlockDir=
tyBitmapState,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 common, common);
>>> -
>>> -=C2=A0=C2=A0=C2=A0 if (state->backup) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_undo_clear_dirty_bitma=
p(state->bitmap, state->backup);
>>> -=C2=A0=C2=A0=C2=A0 }
>> Isn't bdrv_undo_clear_dirty_bitmap new unused?
>
> hmm, yes. I'll remove it in v2.

or, here, as 5.5/7

>
>>
>> Thanks,
>>
>> Paolo
>>
>>> =C2=A0 }
>>> =C2=A0 =C2=A0 static void block_dirty_bitmap_clear_commit(BlkActionStat=
e *common)
>>> @@ -2148,7 +2135,7 @@ static void=20
>>> block_dirty_bitmap_clear_commit(BlkActionState *common)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDirtyBitmapState *state =3D DO_UPCA=
ST(BlockDirtyBitmapState,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 common, common);
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 hbitmap_free(state->backup);
>>> +=C2=A0=C2=A0=C2=A0 bdrv_clear_dirty_bitmap(state->bitmap, NULL);
>>> =C2=A0 }
>>> =C2=A0 =C2=A0 static void abort_prepare(BlkActionState *common, Error *=
*errp)
>>> @@ -2210,7 +2197,6 @@ static const BlkActionOps actions[] =3D {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .instance_size =
=3D sizeof(BlockDirtyBitmapState),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .prepare =3D blo=
ck_dirty_bitmap_clear_prepare,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .commit =3D bloc=
k_dirty_bitmap_clear_commit,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .abort =3D block_dirty_bitm=
ap_clear_abort,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 };
>>>
>
>


--=20
Best regards,
Vladimir
