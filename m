Received: from eggs.gnu.org ([2001:4830:134:3::10]:58988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dHCJ1-0004v8-5k
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 12:53:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dHCIy-0001cQ-3R
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 12:53:39 -0400
References: <20170602112158.232757-1-vsementsov@virtuozzo.com>
	<20170602112158.232757-14-vsementsov@virtuozzo.com>
	<4930d026-75c1-6843-ea45-e87c55e5e986@redhat.com>
From: Sementsov-Ogievskiy Vladimir <vsementsov@virtuozzo.com>
Message-ID: <d3560aae-bb8c-f95f-e2b1-78427c6bf8ac@virtuozzo.com>
Date: Sat, 3 Jun 2017 19:53:23 +0300
MIME-Version: 1.0
In-Reply-To: <4930d026-75c1-6843-ea45-e87c55e5e986@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v20 13/30] block: new
 bdrv_reopen_bitmaps_rw interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org



On 03.06.2017 01:17, John Snow wrote:
>
> On 06/02/2017 07:21 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Add format driver handler, which should mark loaded read-only
>> bitmaps as 'IN_USE' in the image and unset read_only field in
>> corresponding BdrvDirtyBitmap's.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block.c                   | 17 +++++++++++++++++
>>   include/block/block_int.h |  7 +++++++
>>   2 files changed, 24 insertions(+)
>>
>> diff --git a/block.c b/block.c
>> index 04af7697dc..161db9e32a 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -2946,12 +2946,16 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
>>   {
>>       BlockDriver *drv;
>>       BlockDriverState *bs;
>> +    bool old_can_write, new_can_write;
>>   
>>       assert(reopen_state != NULL);
>>       bs = reopen_state->bs;
>>       drv = bs->drv;
>>       assert(drv != NULL);
>>   
>> +    old_can_write =
>> +        !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTIVE);
>> +
>>       /* If there are any driver level actions to take */
>>       if (drv->bdrv_reopen_commit) {
>>           drv->bdrv_reopen_commit(reopen_state);
>> @@ -2965,6 +2969,19 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
>>       bs->read_only = !(reopen_state->flags & BDRV_O_RDWR);
>>   
>>       bdrv_refresh_limits(bs, NULL);
>> +
>> +    new_can_write =
>> +        !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTIVE);
>> +    if (!old_can_write && new_can_write && drv->bdrv_reopen_bitmaps_rw) {
>> +        Error *local_err = NULL;
>> +        if (drv->bdrv_reopen_bitmaps_rw(bs, &local_err) < 0) {
>> +            /* This is not fatal, bitmaps just left read-only, so all following
>> +             * writes will fail. User can remove read-only bitmaps to unblock
>> +             * writes.
>> +             */
>> +            error_report_err(local_err);
>> +        }
>> +    }
>>   }
>>   
>>   /*
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index 8d3724cce6..1dc6f2e90d 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -380,6 +380,13 @@ struct BlockDriver {
>>                                uint64_t parent_perm, uint64_t parent_shared,
>>                                uint64_t *nperm, uint64_t *nshared);
>>   
>> +    /**
>> +     * Bitmaps should be marked as 'IN_USE' in the image on reopening image
>> +     * as rw. This handler should realize it. It also should unset readonly
>> +     * field of BlockDirtyBitmap's in case of success.
>> +     */
>> +    int (*bdrv_reopen_bitmaps_rw)(BlockDriverState *bs, Error **errp);
>> +
> Hmm, do we need a new top-level hook for this? We already have
> .bdrv_reopen_commit and .bdrv_reopen_prepare which inform the
> blockdriver that a reopen event is occurring.
>
> Can't we just amend qcow2_reopen_prepare and qcow2_reopen_commit to do
> the necessary tasks of either:
>
> (A) Flushing the bitmap in preparation for reopening as RO, or
> (B) Writing in_use and removing the RO flag in preparation for reopening
> as RW

(A) is done (see patch about reopen RO)

(B) - We can't do it, as on this preparation the image is still RO, and 
I've created new handler, write 'in_use' _after_ the point when new 
flags was set.

>
>>       QLIST_ENTRY(BlockDriver) list;
>>   };
>>   
>>
>
> Well, design issues aside, I will at least confirm that I think this
> patch should work as designed, and I will leave the design critiques to
> Max and Kevin:
>
> Reviewed-by: John Snow <jsnow@redhat.com>
>

-- 
Best regards,
Vladimir.
