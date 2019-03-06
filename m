Received: from eggs.gnu.org ([209.51.188.92]:58100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h1eNA-0004bb-GA
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 16:46:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h1eN9-00042e-Dl
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 16:46:44 -0500
References: <20190301191545.8728-1-jsnow@redhat.com>
	<20190301191545.8728-8-jsnow@redhat.com>
	<1055b446-a34d-2413-3e0c-85b433ae15b7@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <5c1f1971-5050-9678-f7f4-d8d4c4b53709@redhat.com>
Date: Wed, 6 Mar 2019 16:46:33 -0500
MIME-Version: 1.0
In-Reply-To: <1055b446-a34d-2413-3e0c-85b433ae15b7@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 7/7] block/dirty-bitmaps: implement
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
Cc: Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>



On 3/6/19 9:26 AM, Vladimir Sementsov-Ogievskiy wrote:
> 01.03.2019 22:15, John Snow wrote:
>> Set the inconsistent bit on load instead of rejecting such bitmaps.
>> There is no way to un-set it; the only option is to delete it.
> 
> I think, s/delete it/delete the bitmap/, as "it" is the bit after "un-set it".
> 

You are absolutely correct.

Don't let anyone fool you into thinking that Americans know English.

>>
>> Obvervations:
>> - bitmap loading does not need to update the header for in_use bitmaps.
>> - inconsistent bitmaps don't need to have their data loaded; they're
>>    glorified corruption sentinels.
>> - bitmap saving does not need to save inconsistent bitmaps back to disk.
>> - bitmap reopening DOES need to drop the readonly flag from inconsistent
>>    bitmaps to allow reopening of qcow2 files with non-qemu-owned bitmaps
>>    being eventually flushed back to disk.
> 
> hmm, and inconsitent bitmaps don't have this flag, isn't it?
> 

I didn't make any effort to treat them differently -- the readonly flag
only gets applied when the image is actually read only. I felt it was
conceptually simpler that way.

>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   block/qcow2-bitmap.c | 103 ++++++++++++++++++++++---------------------
>>   1 file changed, 53 insertions(+), 50 deletions(-)
>>
>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>> index 3ee524da4b..c3b210ede1 100644
>> --- a/block/qcow2-bitmap.c
>> +++ b/block/qcow2-bitmap.c
> 
> [..]
> 
>> @@ -962,35 +963,39 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>>       }
>>   
>>       QSIMPLEQ_FOREACH(bm, bm_list, entry) {
>> -        if (!(bm->flags & BME_FLAG_IN_USE)) {
>> -            BdrvDirtyBitmap *bitmap = load_bitmap(bs, bm, errp);
>> -            if (bitmap == NULL) {
>> -                goto fail;
>> -            }
>> -
>> -            if (!(bm->flags & BME_FLAG_AUTO)) {
>> -                bdrv_disable_dirty_bitmap(bitmap);
>> -            }
>> -            bdrv_dirty_bitmap_set_persistance(bitmap, true);
>> -            bm->flags |= BME_FLAG_IN_USE;
>> -            created_dirty_bitmaps =
>> -                    g_slist_append(created_dirty_bitmaps, bitmap);
>> +        BdrvDirtyBitmap *bitmap = load_bitmap(bs, bm, errp);
>> +        if (bitmap == NULL) {
>> +            goto fail;
>>           }
>> -    }
>>   
>> -    if (created_dirty_bitmaps != NULL) {
>> -        if (can_write(bs)) {
>> -            /* in_use flags must be updated */
>> -            int ret = update_ext_header_and_dir_in_place(bs, bm_list);
>> -            if (ret < 0) {
>> -                error_setg_errno(errp, -ret, "Can't update bitmap directory");
>> -                goto fail;
>> -            }
>> -            header_updated = true;
>> +        if (bm->flags & BME_FLAG_IN_USE) {
>> +            bdrv_dirty_bitmap_set_inconsistent(bitmap);
>>           } else {
>> -            g_slist_foreach(created_dirty_bitmaps, set_readonly_helper,
>> -                            (gpointer)true);
>> +            /* NB: updated flags only get written if can_write(bs) is true. */
>> +            bm->flags |= BME_FLAG_IN_USE;
>> +            needs_update = true;
>>           }
>> +        if (!(bm->flags & BME_FLAG_AUTO)) {
>> +            bdrv_disable_dirty_bitmap(bitmap);
>> +        }
>> +        bdrv_dirty_bitmap_set_persistance(bitmap, true);
>> +        created_dirty_bitmaps =
>> +            g_slist_append(created_dirty_bitmaps, bitmap);
>> +    }
>> +
>> +    if (needs_update && can_write(bs)) {
>> +        /* in_use flags must be updated */
>> +        int ret = update_ext_header_and_dir_in_place(bs, bm_list);
>> +        if (ret < 0) {
>> +            error_setg_errno(errp, -ret, "Can't update bitmap directory");
>> +            goto fail;
>> +        }
>> +        header_updated = true;
>> +    }
>> +
>> +    if (!can_write(bs)) {
>> +        g_slist_foreach(created_dirty_bitmaps, set_readonly_helper,
>> +                        (gpointer)true);
> 
> hmmm..
> 
> I think, inconsistent bitmaps should have readonly flag always set or always unset, independently on can_write,
> as we are not going to write something related to inconsistent bitmaps.
> 

We'll never change metadata for inconsistent bitmaps, no. We might
delete them which causes a metadata change, though -- and right now the
readonly check stops that in blockdev.c before we attempt (and fail) the
operation. It does have at least a light usage.

It's not a crucial feature, but I think the error message is nicer.

> And I think, better is always unset, to have inconsistent bitmaps as something unrelated to readonly.
> 

The way I think of it is as unrelated, which is why I set readonly and
inconsistent orthogonally.

> Readonly are bitmaps, which are not marked IN_USE on open for some reason..
>

I tend to think of readonly bitmaps as persistent bitmaps attached to
storage we are unable to write back to, so we must prevent their
modification.

I suppose the IN_USE viewpoint works too; "This is a bitmap that we have
not marked as IN_USE so it must not be used."

> I understand, that inconsistent bitmaps are some kind of readonly too, as we can't write to them..
> But we can't read too anyway, and we don't interfere with reopen logic at all. So again, better is
> don't mark inconsistent bitmaps as readonly.
> 

Hm, so in your model; we just NEVER set readonly for persistent bitmaps,
which incurs some changes at load time, but allows the reload_rw
function to go completely unmodified.

That's not unreasonable in terms of SLOC, but semantically I am not sure
which approach is better. I'm leaning towards keeping this as written
for now, but... well. Any thoughts, Eric? Would you like to flip a coin?

--js
