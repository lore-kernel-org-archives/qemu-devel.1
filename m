Received: from eggs.gnu.org ([209.51.188.92]:34880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gvrSw-00062i-Od
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 17:32:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gvrSu-0002aG-5H
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 17:32:46 -0500
References: <20190213232356.21034-1-jsnow@redhat.com>
	<20190213232356.21034-3-jsnow@redhat.com>
	<b0847f1f-c142-0c35-f04a-7436f840af25@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <fa012e63-2a85-6c7b-bb92-75974d0d3033@redhat.com>
Date: Mon, 18 Feb 2019 17:32:31 -0500
MIME-Version: 1.0
In-Reply-To: <b0847f1f-c142-0c35-f04a-7436f840af25@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/6] block/dirty-bitmaps: rename frozen
 predicate helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>, "libvir-list@redhat.com" <libvir-list@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>



On 2/18/19 8:57 AM, Vladimir Sementsov-Ogievskiy wrote:
> 14.02.2019 2:23, John Snow wrote:
>> "Frozen" was a good description a long time ago, but it isn't adequate now.
>> Rename the frozen predicate to has_successor to make the semantics of the
>> predicate more clear to outside callers.
>>
>> In the process, remove some calls to frozen() that no longer semantically
>> make sense. For enabled and disabled in particular, it's actually okay for
>> the internals to do this but only forbidden for users to invoke them, and
> 
> I'm a bit lost in this paragraph.. to this - what?, to invoke them - whom?
> I think, it would be simpler for me to read patch itself :)
> 

Touched this up. I meant enable and disable, not enabled and disabled.

>> all of the QMP entry uses already check against qmp_locked.
>>
>> Several other assertions really want to check that the bitmap isn't in-use
>> by another operation -- use the qmp_locked function for this instead, which
>> presently also checks for has_successor.
> 
> hm, you mean user_locked, not qmp_locked.
> 

Yes.

[...]

>>   /**
>>    * Create a successor bitmap destined to replace this bitmap after an operation.
>> - * Requires that the bitmap is not frozen and has no successor.
>> + * Requires that the bitmap is not locked and has no successor.
> 
> I think, user_locked, to not interfere with bitmaps mutex. And you use user_locked in
> other comments in this patch.
> 

You're right. It gets changed again later, but I didn't make this easy
to read.

>>    * Called with BQL taken.
>>    */
>>   int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
>> @@ -244,12 +244,16 @@ int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
>>       uint64_t granularity;
>>       BdrvDirtyBitmap *child;
>>   
>> -    if (bdrv_dirty_bitmap_frozen(bitmap)) {
>> -        error_setg(errp, "Cannot create a successor for a bitmap that is "
>> -                   "currently frozen");
>> +    if (bdrv_dirty_bitmap_user_locked(bitmap)) {
>> +        error_setg(errp, "Cannot create a successor for a bitmap that is in-use "
>> +                   "by an operation");
>> +        return -1;
>> +    }
>> +    if (bdrv_dirty_bitmap_has_successor(bitmap)) {
>> +        error_setg(errp, "Cannot create a successor for a bitmap that already "
>> +                   "has one");
> 
> 
> Amm, dead code? _user_locked() implies no successor, so we instead can keep an assertion..
> 

It gets changed later in the series, but I didn't do a great job of
explaining that in advance. I'll amend the commit message to explain
what I'm trying to do.

I tried to hint at this with: "which presently also checks for
has_successor" as an admission that it was redundant, but I need to call
it out in stronger language.
