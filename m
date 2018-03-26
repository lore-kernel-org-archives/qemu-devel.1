Received: from eggs.gnu.org ([2001:4830:134:3::10]:54504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f0Qcb-00016V-Sb
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 07:49:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f0Qca-0005ux-9e
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 07:49:05 -0400
References: <20180326112056.8420-1-vsementsov@virtuozzo.com>
	<20180326112056.8420-6-vsementsov@virtuozzo.com>
	<aa6a8e20-de93-a021-0129-9a6483b85453@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <23257966-580c-6b38-0c3a-eac0d3870809@virtuozzo.com>
Date: Mon, 26 Mar 2018 14:48:53 +0300
MIME-Version: 1.0
In-Reply-To: <aa6a8e20-de93-a021-0129-9a6483b85453@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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

26.03.2018 14:44, Paolo Bonzini wrote:
> On 26/03/2018 13:20, Vladimir Sementsov-Ogievskiy wrote:
>> bdrv_clear_dirty_bitmap do not fail, so we can call it in transaction
>> commit, avoiding any rollback.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   blockdev.c | 16 +---------------
>>   1 file changed, 1 insertion(+), 15 deletions(-)
>>
>> diff --git a/blockdev.c b/blockdev.c
>> index c31bf3d98d..88eae60c1c 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -2050,7 +2050,6 @@ typedef struct BlockDirtyBitmapState {
>>       BlkActionState common;
>>       BdrvDirtyBitmap *bitmap;
>>       BlockDriverState *bs;
>> -    HBitmap *backup;
>>       bool prepared;
>>   } BlockDirtyBitmapState;
>>   
>> @@ -2129,18 +2128,6 @@ static void block_dirty_bitmap_clear_prepare(BlkActionState *common,
>>           error_setg(errp, "Cannot clear a readonly bitmap");
>>           return;
>>       }
>> -
>> -    bdrv_clear_dirty_bitmap(state->bitmap, &state->backup);
>> -}
>> -
>> -static void block_dirty_bitmap_clear_abort(BlkActionState *common)
>> -{
>> -    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
>> -                                             common, common);
>> -
>> -    if (state->backup) {
>> -        bdrv_undo_clear_dirty_bitmap(state->bitmap, state->backup);
>> -    }
> Isn't bdrv_undo_clear_dirty_bitmap new unused?

hmm, yes. I'll remove it in v2.

>
> Thanks,
>
> Paolo
>
>>   }
>>   
>>   static void block_dirty_bitmap_clear_commit(BlkActionState *common)
>> @@ -2148,7 +2135,7 @@ static void block_dirty_bitmap_clear_commit(BlkActionState *common)
>>       BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
>>                                                common, common);
>>   
>> -    hbitmap_free(state->backup);
>> +    bdrv_clear_dirty_bitmap(state->bitmap, NULL);
>>   }
>>   
>>   static void abort_prepare(BlkActionState *common, Error **errp)
>> @@ -2210,7 +2197,6 @@ static const BlkActionOps actions[] = {
>>           .instance_size = sizeof(BlockDirtyBitmapState),
>>           .prepare = block_dirty_bitmap_clear_prepare,
>>           .commit = block_dirty_bitmap_clear_commit,
>> -        .abort = block_dirty_bitmap_clear_abort,
>>       }
>>   };
>>   
>>


-- 
Best regards,
Vladimir
