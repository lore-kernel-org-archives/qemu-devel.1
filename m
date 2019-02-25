Received: from eggs.gnu.org ([209.51.188.92]:50765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gyMZf-000341-PA
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 15:10:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gyMZe-0003lh-Al
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 15:10:03 -0500
References: <20190223000614.13894-1-jsnow@redhat.com>
	<20190223000614.13894-3-jsnow@redhat.com>
	<8d518b5f-81ff-e8b1-c120-bca14fcf29ca@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <c59d4eb8-8c48-d003-002a-adf233268c96@redhat.com>
Date: Mon, 25 Feb 2019 15:09:47 -0500
MIME-Version: 1.0
In-Reply-To: <8d518b5f-81ff-e8b1-c120-bca14fcf29ca@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 02/10] block/dirty-bitmaps: rename
 frozen predicate helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, "libvir-list@redhat.com" <libvir-list@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>



On 2/25/19 2:01 AM, Vladimir Sementsov-Ogievskiy wrote:
> 23.02.2019 3:06, John Snow wrote:
>> "Frozen" was a good description a long time ago, but it isn't adequate now.
>> Rename the frozen predicate to has_successor to make the semantics of the
>> predicate more clear to outside callers.
>>
>> In the process, remove some calls to frozen() that no longer semantically
>> make sense. For bdrv_enable_dirty_bitmap_locked and
>> bdrv_disable_dirty_bitmap_locked, it doesn't make sense to prohibit QEMU
>> internals from performing this action when we only wished to prohibit QMP
>> users from issuing these commands. All of the QMP API commands for bitmap
>> manipulation already check against user_locked() to prohibit these actions.
>>
>> Several other assertions really want to check that the bitmap isn't in-use
>> by another operation -- use the bitmap_user_locked function for this instead,
>> which presently also checks for has_successor. This leaves some redundant
>> checks of has_sucessor through different helpers that are addressed in
>> forthcoming patches.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   block/dirty-bitmap.c           | 32 +++++++++++++++++---------------
>>   include/block/dirty-bitmap.h   |  2 +-
>>   migration/block-dirty-bitmap.c |  2 +-
>>   3 files changed, 19 insertions(+), 17 deletions(-)
>>
>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>> index 101383b3af..aa3f86bb73 100644
>> --- a/block/dirty-bitmap.c
>> +++ b/block/dirty-bitmap.c
> 
> [..]
> 
>> @@ -285,7 +288,7 @@ void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap)
>>   static void bdrv_release_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap)
>>   {
>>       assert(!bitmap->active_iterators);
>> -    assert(!bdrv_dirty_bitmap_frozen(bitmap));
>> +    assert(!bdrv_dirty_bitmap_user_locked(bitmap));
> 
> hmm. I'd prefere to keep a separate assertion for successor: we don't free it here,
> so we really depend on absence of this object.
> 

Reasonable.

>>       assert(!bitmap->meta);
>>       QLIST_REMOVE(bitmap, list);
>>       hbitmap_free(bitmap->bitmap);
>> @@ -325,7 +328,7 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
>>   /**
>>    * In cases of failure where we can no longer safely delete the parent,
>>    * we may wish to re-join the parent and child/successor.
>> - * The merged parent will be un-frozen, but not explicitly re-enabled.
>> + * The merged parent will not be user_locked, nor explicitly re-enabled.
>>    * Called within bdrv_dirty_bitmap_lock..unlock and with BQL taken.
>>    */
>>   BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap_locked(BlockDriverState *bs,
>> @@ -373,7 +376,7 @@ void bdrv_dirty_bitmap_truncate(BlockDriverState *bs, int64_t bytes)
>>   
>>       bdrv_dirty_bitmaps_lock(bs);
>>       QLIST_FOREACH(bitmap, &bs->dirty_bitmaps, list) {
>> -        assert(!bdrv_dirty_bitmap_frozen(bitmap));
>> +        assert(!bdrv_dirty_bitmap_user_locked(bitmap));
> 
> and here too. As we don't truncate successors.
> 
>>           assert(!bitmap->active_iterators);
>>           hbitmap_truncate(bitmap->bitmap, bytes);
>>           bitmap->size = bytes;
>> @@ -391,7 +394,7 @@ void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap)
>>   
>>   /**
>>    * Release all named dirty bitmaps attached to a BDS (for use in bdrv_close()).
>> - * There must not be any frozen bitmaps attached.
>> + * There must not be any user_locked bitmaps attached.
>>    * This function does not remove persistent bitmaps from the storage.
>>    * Called with BQL taken.
>>    */
>> @@ -428,7 +431,6 @@ void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>>   void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap)
>>   {
>>       bdrv_dirty_bitmap_lock(bitmap);
>> -    assert(!bdrv_dirty_bitmap_frozen(bitmap));
>>       bitmap->disabled = true;
>>       bdrv_dirty_bitmap_unlock(bitmap);
>>   }
>> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
>> index 04a117fc81..cdbb4dfefd 100644
>> --- a/include/block/dirty-bitmap.h
>> +++ b/include/block/dirty-bitmap.h
> 
> Could you please add scripts/git.orderfile to your .git/config, like
> 
> [diff]
>      orderFile = /path/to/scripts/git.orderfile
> 
> ?
> 

Hm, we should add this to the .gitpublish profile, but yes, let me
re-add this.

>> @@ -36,7 +36,7 @@ BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs);
>>   uint32_t bdrv_get_default_bitmap_granularity(BlockDriverState *bs);
>>   uint32_t bdrv_dirty_bitmap_granularity(const BdrvDirtyBitmap *bitmap);
>>   bool bdrv_dirty_bitmap_enabled(BdrvDirtyBitmap *bitmap);
>> -bool bdrv_dirty_bitmap_frozen(BdrvDirtyBitmap *bitmap);
>> +bool bdrv_dirty_bitmap_has_successor(BdrvDirtyBitmap *bitmap);
>>   const char *bdrv_dirty_bitmap_name(const BdrvDirtyBitmap *bitmap);
>>   int64_t bdrv_dirty_bitmap_size(const BdrvDirtyBitmap *bitmap);
>>   DirtyBitmapStatus bdrv_dirty_bitmap_status(BdrvDirtyBitmap *bitmap);
>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
>> index 6426151e4f..ac6954142f 100644
>> --- a/migration/block-dirty-bitmap.c
>> +++ b/migration/block-dirty-bitmap.c
>> @@ -542,7 +542,7 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DirtyBitmapLoadState *s)
>>           }
>>       }
>>   
>> -    if (bdrv_dirty_bitmap_frozen(s->bitmap)) {
>> +    if (bdrv_dirty_bitmap_has_successor(s->bitmap)) {
>>           bdrv_dirty_bitmap_lock(s->bitmap);
>>           if (enabled_bitmaps == NULL) {
>>               /* in postcopy */
>>
> 
> 
> With my suggestions or without:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> And thank you for rewriting commit message, it's more clear now!
> 

Thanks!
