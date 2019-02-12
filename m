Received: from eggs.gnu.org ([209.51.188.92]:40953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gtcpf-0006jl-Bh
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:31:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gtcpe-0005wD-Au
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:30:59 -0500
References: <20190212010248.11056-1-jsnow@redhat.com>
	<20190212010248.11056-3-jsnow@redhat.com>
	<987e83f6-2a6f-9547-a6d2-afe7a323181d@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <bb72e892-fcaf-f1b9-1c07-12a740478de3@redhat.com>
Date: Tue, 12 Feb 2019 13:30:44 -0500
MIME-Version: 1.0
In-Reply-To: <987e83f6-2a6f-9547-a6d2-afe7a323181d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] block/dirty-bitmaps: rename frozen
 predicate helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>



On 2/12/19 1:26 PM, Eric Blake wrote:
> On 2/11/19 7:02 PM, John Snow wrote:
>> "Frozen" was a good description a long time ago, but it isn't adequate now.
>> Rename the frozen predicate to has_successor to make the semantics of the
>> predicate more clear to outside callers.
>>
>> In the process, remove some calls to frozen() that no longer semantically
>> make sense. For enabled and disabled in particular, it's actually okay for
>> the internals to do this but only forbidden for users to invoke them, and
>> all of the QMP entry uses already check against qmp_locked.
>>
>> Several other assertions really want to check that the bitmap isn't in-use
>> by another operation -- use the qmp_locked function for this instead, which
>> presently also checks for has_successor.
>> ---
> 
> Missing S-o-b on entire series, so you have to send v2 anyway :)
> 
>> @@ -244,12 +244,16 @@ int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
>>      uint64_t granularity;
>>      BdrvDirtyBitmap *child;
>>  
>> -    if (bdrv_dirty_bitmap_frozen(bitmap)) {
>> -        error_setg(errp, "Cannot create a successor for a bitmap that is "
>> -                   "currently frozen");
>> +    if (bdrv_dirty_bitmap_has_successor(bitmap)) {
>> +        error_setg(errp, "Cannot create a successor for a bitmap that already "
>> +                   "has one");
>> +        return -1;
>> +    }
>> +    if (bdrv_dirty_bitmap_user_locked(bitmap)) {
>> +        error_setg(errp, "Cannot create a successor for a bitmap that is in-use "
>> +                   "by an operation.");
>>          return -1;
> 
> No trailing dot in error_setg().
> 

D'oh. I need to re-enable checkpatch, obviously.

> Should these two errors be swapped (check for locked before
> has_successor)?  After all, having a successor is an internal detail,
> whereas being in use by something I already triggered is fairly
> straightforward to understand.
> 

Good point. Will do.

> 
>> @@ -325,7 +328,7 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
>>  /**
>>   * In cases of failure where we can no longer safely delete the parent,
>>   * we may wish to re-join the parent and child/successor.
>> - * The merged parent will be un-frozen, but not explicitly re-enabled.
>> + * The merged parent will not be user_locked, but not explicitly re-enabled.
> 
> s/but not/nor/
> 

I was trying to draw a contrast between "We will forcibly set locked =
false, but make no guaranteed about enable/disable."

I guess nor still works in that case.
