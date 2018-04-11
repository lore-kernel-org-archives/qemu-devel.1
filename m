Received: from eggs.gnu.org ([2001:4830:134:3::10]:59090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f6G4g-000629-0z
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 09:46:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f6G4a-0002Un-3k
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 09:46:10 -0400
References: <20180411122606.367301-1-vsementsov@virtuozzo.com>
	<20180411122606.367301-2-vsementsov@virtuozzo.com>
	<b763ca01-d906-dbf8-2eb6-48e4140d2efe@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e1534f1b-3c4f-b03b-8375-d1e9f468c460@virtuozzo.com>
Date: Wed, 11 Apr 2018 16:45:51 +0300
MIME-Version: 1.0
In-Reply-To: <b763ca01-d906-dbf8-2eb6-48e4140d2efe@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qcow2: try load bitmaps only once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, mreitz@redhat.com

11.04.2018 16:22, Eric Blake wrote:
> On 04/11/2018 07:26 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Checking reopen by existence of some bitmaps is wrong, as it may be
>> some other bitmaps, or on the other hand, user may remove bitmaps. This
>> criteria is bad. To simplify things and make behavior more predictable
>> let's just add a flag to remember, that we've already tried to load
>> bitmaps on open and do not want do it again.
> Wording suggestion:
>
> Checking whether we are reopening an image based on the existence of
> some bitmaps is wrong, as the set of bitmaps may have changed (for
> example, the user may have added or removed bitmaps in the meantime).
> To simplify things and make behavior more predictable, let's just add a
> flag to remember whether we've already tried to load bitmaps, so that we
> only attempt it on the initial open.

You've dropped an idea supposed by Max, about migration related bitmaps,
I said "some other bitmaps", because now I doubt is it possible: we have 
migration related
bitmaps on source, not on target..

Anyway, I'm ok with all your suggestions, thank you. I can respin, or 
they may be squashed-in inflight.

>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/qcow2.h |  1 +
>>   block/qcow2.c | 16 ++++++++--------
>>   2 files changed, 9 insertions(+), 8 deletions(-)
>>
>> @@ -1480,10 +1481,9 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
>>           s->autoclear_features &= QCOW2_AUTOCLEAR_MASK;
>>       }
>>   
>> -    if (bdrv_dirty_bitmap_next(bs, NULL)) {
>> -        /* It's some kind of reopen with already existing dirty bitmaps. There
>> -         * are no known cases where we need loading bitmaps in such situation,
>> -         * so it's safer don't load them.
>> +    if (s->dirty_bitmaps_loaded) {
>> +        /* It's some kind of reopen. There are no known cases where we need
>> +         * loading bitmaps in such situation, so it's safer don't load them.
> Pre-existing wording, but sounds better as:
>
> There are no known cases where we need to reload bitmaps in such a
> situation, so it's safer to skip them.
>
>>            *
>>            * Moreover, if we have some readonly bitmaps and we are reopening for
>>            * rw we should reopen bitmaps correspondingly.
>> @@ -1491,13 +1491,13 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
>>           if (bdrv_has_readonly_bitmaps(bs) &&
>>               !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTIVE))
>>           {
>> -            bool header_updated = false;
>>               qcow2_reopen_bitmaps_rw_hint(bs, &header_updated, &local_err);
>> -            update_header = update_header && !header_updated;
>>           }
>> -    } else if (qcow2_load_dirty_bitmaps(bs, &local_err)) {
>> -        update_header = false;
>> +    } else {
>> +        header_updated = qcow2_load_dirty_bitmaps(bs, &local_err);
>> +        s->dirty_bitmaps_loaded = true;
>>       }
>> +    update_header = update_header && !header_updated;
> Could write this as 'update_header &= !header_updated;'
>


-- 
Best regards,
Vladimir
