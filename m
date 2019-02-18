Received: from eggs.gnu.org ([209.51.188.92]:43577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gvsJp-0004EH-I8
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 18:27:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gvs8L-0003oR-2K
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 18:15:34 -0500
References: <20190213232356.21034-1-jsnow@redhat.com>
	<20190213232356.21034-4-jsnow@redhat.com>
	<bed70b4c-618f-b0c7-c7b8-6365a38b9d35@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <6d42cbe7-cbb8-daf8-7ce1-54c00653917a@redhat.com>
Date: Mon, 18 Feb 2019 18:15:15 -0500
MIME-Version: 1.0
In-Reply-To: <bed70b4c-618f-b0c7-c7b8-6365a38b9d35@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/6] block/dirty-bitmap: change
 semantics of enabled predicate
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



On 2/18/19 11:39 AM, Vladimir Sementsov-Ogievskiy wrote:
> 14.02.2019 2:23, John Snow wrote:
>> Currently, enabled means something like "the status of the bitmap
>> is ACTIVE." After this patch, it should mean exclusively: "This
>> bitmap is recording guest writes, and is allowed to do so."
>>
>> In many places, this is how this predicate was already used.
>> We'll allow users to call user_locked if they're really curious about
>> finding out if the bitmap is in use by an operation.
>>
>> To accommodate this, modify the create_successor routine to now
>> explicitly disable the parent bitmap at creation time.
>>
>>
>> Justifications:
>>
>> 1. bdrv_dirty_bitmap_status suffers no change from the lack of
>>     1:1 parity with the new predicates because of the order in which
>>     the predicates are checked. This is now only for compatibility.
>>
>> 2. bdrv_set_dirty_bitmap is only used by mirror, which does not use
>>     disabled bitmaps -- all of these writes are internal usages.
>>     Therefore, we should allow writes even in the disabled state.
>>     The condition is removed.
>>
>> 3. bdrv_reset_dirty_bitmap Similarly, this is only used internally by
>>     mirror and migration. In these contexts it is always enabled anyway,
>>     but our API does not need to enforce this.
>>
>> 4. bdrv_set_dirty() is unchanged: pre-patch, it was skipping bitmaps that were
>>     disabled or had a successor, while post-patch it is only skipping bitmaps
>>     that are disabled. To accommodate this, create_successor now ensures that
>>     any bitmap with a successor is explicitly disabled.
>>
> 
> 5-8 are examples of "this is how this predicate was already used"
> 
>> 5. qcow2_store_persistent_dirty_bitmaps: This only ever wanted to check if the
>>     bitmap was enabled or not. Theoretically if we save during an operation,
>>     this now gets set as enabled instead of disabled,
> 
> No, as you explicitly disable bitmap in create_successor, so bitmaps with successor
> will be disabled anyway.
> 

Well, yeah. There's no way it happens in practice currently. It's just
"theoretically" from the viewpoint of the API call itself. There's
nothing stopping a developer from making that call, and this is a
potential change in behavior that we don't expect to observe. Just
noting it down.

> Hmm, and this shows, that actually, you don't need this big description for all calls,
> as actually nothing changed and all calls may be described like (4.). Except (2. and 3.),
> as these calls are removed (so, is it worth to split them into separate previous patch?)
> 

I could, to at least have its own justification in a commit message
apart from these -- but at this point it's primarily a benefit for Eric,
You, and myself.

>   but this cannot happen
>>     in practice because jobs must be finished before we close the disk.
>>
>> 6. block_dirty_bitmap_enable_prepare only ever cared about the
>>     literal bit, and already checked for user_locked beforehand.
>>
>> 7. block_dirty_bitmap_disable_prepare ditto as above.
>>
>> 8. init_dirty_bitmap_migration also already checks user_locked,
>>     so this call can be a simple enabled/disabled check.
> 
> 
> hmmm
> 9. nbd_export_new, which too checks bdrv_dirty_bitmap_user_locked but _after_
>     call to bdrv_dirty_bitmap_enabled. Anyway it's not changed as described in (4.),
>     I think it is better to check _user_locked first.
> 

You're right, and Eric left a similar feedback elsewhere. user_locked is
the more obvious disqualifier. I think this ought to be its own small
patch because it has nothing much to do with this one.

> 
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>>   block/dirty-bitmap.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>> index 639ebc0645..bb2e19e0d8 100644
>> --- a/block/dirty-bitmap.c
>> +++ b/block/dirty-bitmap.c
>> @@ -209,7 +209,7 @@ bool bdrv_dirty_bitmap_qmp_locked(BdrvDirtyBitmap *bitmap)
>>   /* Called with BQL taken.  */
>>   bool bdrv_dirty_bitmap_enabled(BdrvDirtyBitmap *bitmap)
>>   {
>> -    return !(bitmap->disabled || bitmap->successor);
>> +    return !bitmap->disabled;
>>   }
>>   
>>   /* Called with BQL taken.  */
>> @@ -264,6 +264,7 @@ int bdrv_dirty_bitmap_create_successor(BlockDriverState *bs,
>>   
>>       /* Successor will be on or off based on our current state. */
>>       child->disabled = bitmap->disabled;
>> +    bitmap->disabled = true;
>>   
>>       /* Install the successor and freeze the parent */
>>       bitmap->successor = child;
>> @@ -346,6 +347,8 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
>>           error_setg(errp, "Merging of parent and successor bitmap failed");
>>           return NULL;
>>       }
>> +
>> +    parent->disabled = successor->disabled;
> 
> at this point comment to the function
> "The merged parent will not be user_locked, nor explicitly re-enabled."
> becomes really weird. Need to reword it somehow..
> 

It is a pretty awkward comment. I'll try to touch it up here.

>>       bdrv_release_dirty_bitmap_locked(successor);
>>       parent->successor = NULL;
>>   
>> @@ -542,7 +545,6 @@ int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter)
>>   void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
>>                                     int64_t offset, int64_t bytes)
>>   {
>> -    assert(bdrv_dirty_bitmap_enabled(bitmap));
>>       assert(!bdrv_dirty_bitmap_readonly(bitmap));
>>       hbitmap_set(bitmap->bitmap, offset, bytes);
>>   }
>> @@ -559,7 +561,6 @@ void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
>>   void bdrv_reset_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
>>                                       int64_t offset, int64_t bytes)
>>   {
>> -    assert(bdrv_dirty_bitmap_enabled(bitmap));
>>       assert(!bdrv_dirty_bitmap_readonly(bitmap));
>>       hbitmap_reset(bitmap->bitmap, offset, bytes);
>>   }
>>
> 
> 
