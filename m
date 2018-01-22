Received: from eggs.gnu.org ([2001:4830:134:3::10]:55992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1edYBe-0002u1-A3
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 04:14:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1edYBc-00030m-LG
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 04:14:42 -0500
References: <20180116125427.18540-1-vsementsov@virtuozzo.com>
	<20180116125427.18540-5-vsementsov@virtuozzo.com>
	<6688fdd4-c820-89c7-3e39-84e9ccfb0bbf@virtuozzo.com>
	<f4db110c-6ccb-914a-5966-baa2611b62c4@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d3537688-8b70-a3c9-47c0-11153dca8aa7@virtuozzo.com>
Date: Mon, 22 Jan 2018 12:14:25 +0300
MIME-Version: 1.0
In-Reply-To: <f4db110c-6ccb-914a-5966-baa2611b62c4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 4/6] qmp: transaction support for
 block-dirty-bitmap-enable/disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mnestratov@virtuozzo.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org

20.01.2018 03:28, John Snow wrote:
>
> On 01/17/2018 10:06 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 16.01.2018 15:54, Vladimir Sementsov-Ogievskiy wrote:
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>  =C2=A0 qapi/transaction.json |=C2=A0 4 +++
>>>  =C2=A0 blockdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 79
>>> +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  =C2=A0 2 files changed, 83 insertions(+)
>>>
>>> diff --git a/qapi/transaction.json b/qapi/transaction.json
>>> index bd312792da..b643d848f8 100644
>>> --- a/qapi/transaction.json
>>> +++ b/qapi/transaction.json
>>> @@ -46,6 +46,8 @@
>>>  =C2=A0 # - @abort: since 1.6
>>>  =C2=A0 # - @block-dirty-bitmap-add: since 2.5
>>>  =C2=A0 # - @block-dirty-bitmap-clear: since 2.5
>>> +# - @block-dirty-bitmap-enable: since 2.12
>>> +# - @block-dirty-bitmap-disable: since 2.12
>>>  =C2=A0 # - @blockdev-backup: since 2.3
>>>  =C2=A0 # - @blockdev-snapshot: since 2.5
>>>  =C2=A0 # - @blockdev-snapshot-internal-sync: since 1.7
>>> @@ -59,6 +61,8 @@
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'abort': 'Abort',
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'block-dirty-bitmap-a=
dd': 'BlockDirtyBitmapAdd',
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'block-dirty-bitmap-c=
lear': 'BlockDirtyBitmap',
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'block-dirty-bitmap-enable': 'Blo=
ckDirtyBitmap',
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'block-dirty-bitmap-disable': 'Bl=
ockDirtyBitmap',
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'blockdev-backup': 'B=
lockdevBackup',
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'blockdev-snapshot': =
'BlockdevSnapshot',
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'blockdev-snapshot-in=
ternal-sync': 'BlockdevSnapshotInternal',
>>> diff --git a/blockdev.c b/blockdev.c
>>> index 997a6f514c..d338363d78 100644
>>> --- a/blockdev.c
>>> +++ b/blockdev.c
>>> @@ -1962,6 +1962,7 @@ typedef struct BlockDirtyBitmapState {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AioContext *aio_context;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HBitmap *backup;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool prepared;
>>> +=C2=A0=C2=A0=C2=A0 bool was_enabled;
>>>  =C2=A0 } BlockDirtyBitmapState;
>>>  =C2=A0 =C2=A0 static void block_dirty_bitmap_add_prepare(BlkActionStat=
e *common,
>>> @@ -2069,6 +2070,74 @@ static void
>>> block_dirty_bitmap_clear_clean(BlkActionState *common)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>  =C2=A0 }
>>>  =C2=A0 +static void block_dirty_bitmap_enable_prepare(BlkActionState *=
common,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 BlockDirtyBitmap *action;
>>> +=C2=A0=C2=A0=C2=A0 BlockDirtyBitmapState *state =3D DO_UPCAST(BlockDir=
tyBitmapState,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 common, common);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (action_check_completion_mode(common, errp) < 0)=
 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 action =3D common->action->u.block_dirty_bitmap_ena=
ble.data;
>>> +=C2=A0=C2=A0=C2=A0 state->bitmap =3D block_dirty_bitmap_lookup(action-=
>node,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 action->name,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &state->bs,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errp);
>>> +=C2=A0=C2=A0=C2=A0 if (!state->bitmap) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 state->was_enabled =3D bdrv_dirty_bitmap_enabled(st=
ate->bitmap);
>>> +=C2=A0=C2=A0=C2=A0 bdrv_enable_dirty_bitmap(state->bitmap);
>>> +}
>>> +
>>> +static void block_dirty_bitmap_enable_abort(BlkActionState *common)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 BlockDirtyBitmapState *state =3D DO_UPCAST(BlockDir=
tyBitmapState,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 common, common);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!state->was_enabled) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_disable_dirty_bitmap(s=
tate->bitmap);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +}
>>> +
>>> +static void block_dirty_bitmap_disable_prepare(BlkActionState *common,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 BlockDirtyBitmap *action;
>>> +=C2=A0=C2=A0=C2=A0 BlockDirtyBitmapState *state =3D DO_UPCAST(BlockDir=
tyBitmapState,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 common, common);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (action_check_completion_mode(common, errp) < 0)=
 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 action =3D common->action->u.block_dirty_bitmap_dis=
able.data;
>>> +=C2=A0=C2=A0=C2=A0 state->bitmap =3D block_dirty_bitmap_lookup(action-=
>node,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 action->name,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &state->bs,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errp);
>>> +=C2=A0=C2=A0=C2=A0 if (!state->bitmap) {
> &state->bs should be NULL if we're not going to use it. If we're going
> to use it, we should check the error condition here because it might fail=
.

yes, it should be checked. It think it should be checked in other=20
commands too.

>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 state->was_enabled =3D bdrv_dirty_bitmap_enabled(st=
ate->bitmap);
>>> +=C2=A0=C2=A0=C2=A0 bdrv_disable_dirty_bitmap(state->bitmap);
>> hm. actually, I just make it like _clear is made. But now I doubt,
>> why do we need disable here? we can disable in commit, and do not need
>> state->was_enabled..
>>
> You need to make sure that there is no way for bdrv_disable_dirty_bitmap
> to fail, so you need to add that frozen check in. Then you're alright,
> and you can move the actual disable portion to the commit, and get rid
> of the undo call.
>
> Or, we can even do this kind of trick to remove the redundant error
> checking:
>
> void qmp_block_dirty_bitmap_enable(const char *node, const char *name,
>                                     Error **errp)
> {
>      BlockDirtyBitmap data =3D {
> 	.node =3D node,
>          .name =3D name
>      };
>      TransactionAction action =3D {
>          .type =3D TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_ENABLE,
> 	.u.block_dirty_bitmap_enable.data =3D &data,
>      };
>      blockdev_do_action(&action, errp);
> }
>
> static void block_dirty_bitmap_enable_prepare(BlkActionState *common,
>                                                Error **errp)
> {
>      BlockDirtyBitmap *action;
>      BlockDirtyBitmapState *state =3D DO_UPCAST(BlockDirtyBitmapState,
>                                               common, common);
>
>      if (action_check_completion_mode(common, errp) < 0) {
> 	return;
>      }
>
>      action =3D common->action->u.block_dirty_bitmap_enable.data;
>      state->bitmap =3D block_dirty_bitmap_lookup(action->node,
>                                                action->name,
>                                                NULL,
>                                                errp);
>      if (!state->bitmap) {
>          return;
>      }
>
>      if (bdrv_dirty_bitmap_frozen(state->bitmap)) {
>          error_setg(errp, "Bitmap '%s' is currently frozen and cannot be
>                           " enabled", name);
>          return;
>      }
> }
>
> static void block_dirty_bitmap_enable_commit(BlkActionState *common,
>                                                Error **errp)
> {
>      ...blah...
>      bdrv_dirty_bitmap_enable(state->bitmap);
> }
>
> You can do the same for disable.
>
>> and for _clear, we not to clear bitmap in commit? and then, we do not ne=
ed
>> bdrv_undo_clear_dirty_bitmap at all?
>>
> Yeah, you can apply the same technique here too. You can consolidate the
> error checking in .prepare(), then recycle that error checking for the
> standalone QMP command.
>
> Then we can be assured we're not missing a safeguard in the transaction
> version, and it should be safe to move the action to the commit phase,
> because _enable, _disable, and _clear all cannot actually fail.
>
> Then you can get rid of the state->backup state, too, and the extra
> argument to bdrv_clear_dirty_bitmap.
>
> Nice!
>
>> or what do I miss? if nothing, I'll respin the series including _clear
>> refactoring.
>>
> Just pay heed to the error checking in .prepare(), and make sure the
> error checking is identical between the QMP and transactional versions.
>
>>> +}
>>> +
>>> +static void block_dirty_bitmap_disable_abort(BlkActionState *common)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 BlockDirtyBitmapState *state =3D DO_UPCAST(BlockDir=
tyBitmapState,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 common, common);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (state->was_enabled) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_enable_dirty_bitmap(st=
ate->bitmap);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +}
>>> +
>>>  =C2=A0 static void abort_prepare(BlkActionState *common, Error **errp)
>>>  =C2=A0 {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Transaction aborted u=
sing Abort action");
>>> @@ -2130,6 +2199,16 @@ static const BlkActionOps actions[] =3D {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .commit =3D blo=
ck_dirty_bitmap_clear_commit,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .abort =3D bloc=
k_dirty_bitmap_clear_abort,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .clean =3D bloc=
k_dirty_bitmap_clear_clean,
>>> +=C2=A0=C2=A0=C2=A0 },
>>> +=C2=A0=C2=A0=C2=A0 [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_ENABLE]=
 =3D {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .instance_size =3D sizeof(B=
lockDirtyBitmapState),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .prepare =3D block_dirty_bi=
tmap_enable_prepare,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .abort =3D block_dirty_bitm=
ap_enable_abort,
>>> +=C2=A0=C2=A0=C2=A0 },
>>> +=C2=A0=C2=A0=C2=A0 [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_DISABLE=
] =3D {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .instance_size =3D sizeof(B=
lockDirtyBitmapState),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .prepare =3D block_dirty_bi=
tmap_disable_prepare,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .abort =3D block_dirty_bitm=
ap_disable_abort,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>  =C2=A0 };
>>>   =20
>>
> Thanks!


--=20
Best regards,
Vladimir
