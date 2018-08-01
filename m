Received: from eggs.gnu.org ([2001:4830:134:3::10]:50442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fkqAw-0003gC-4j
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 08:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fkqAs-0000zS-Sq
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 08:24:22 -0400
References: <20180626135035.133432-1-vsementsov@virtuozzo.com>
	<20180626135035.133432-5-vsementsov@virtuozzo.com>
	<700dffe4-f3a8-8f70-052c-9f6f8ffbe3d3@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <27ef1832-365c-74fe-c25d-701c295b9ae3@virtuozzo.com>
Date: Wed, 1 Aug 2018 15:24:01 +0300
MIME-Version: 1.0
In-Reply-To: <700dffe4-f3a8-8f70-052c-9f6f8ffbe3d3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 4/6] dirty-bitmaps: clean-up bitmaps
 loading and migration logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, stefanha@redhat.com, famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, Eric Blake <eblake@redhat.com>

21.07.2018 05:41, John Snow wrote:
> On 06/26/2018 09:50 AM, Vladimir Sementsov-Ogievskiy wrote:
>> This patch aims to bring the following behavior:
> Just as a primer for anyone else reading this email (nobody) who might
> not understand the terminology (less than nobody), it might be helpful
> to remember that:
>
> -INACTIVATE occurs either as a starting state for a QEMU awaiting an
> incoming migration, or as a finishing state for a QEMU that has handed
> off control of its disks to a target QEMU during a migration. Despite
> being questionable grammar, it largely makes sense.
>
> -INVALIDATE occurs only on inactive images (it is a NOP on active
> images); and is used to obliterate any cache/state that may exist from a
> prior open call. This also removes the BDRV_O_INACTIVE flag, and
> therefore also "activates" an image. It is called in two cases, AFAICT:
>
> (1) To engage an image after a shared storage migration, by the
> destination QEMU
> (2) To re-engage a previously inactivated image after a failed
> migration, by the source QEMU
>
> And for those of you who already knew all of this, this is a chance for
> you to correct me if I was wrong.
>
> As further recap, bitmaps can be migrated generally in two ways:
>
> (1) For persistent bitmaps only: as part of a shared storage migration,
> they can be flushed to disk before the handoff. This does not require
> any special migration capabilities.
> (2) For either shared or non-shared storage migrations, bitmaps
> regardless of their persistence can be migrated using
> migration/block-dirty-bitmap.c. This feature has to be opted into.
>
>> 1. We don't load bitmaps, when started in inactive mode. It's the case
>> of incoming migration. In this case we wait for bitmaps migration
>> through migration channel (if 'dirty-bitmaps' capability is enabled) or
>> for invalidation (to load bitmaps from the image).
>>
> OK, so performing qcow2_open while (flags & BDRV_O_INACTIVE) -- when
> we're awaiting an incoming migration, generally -- will forego
> attempting to load ANY bitmaps, under the pretense that:
>
> (1) We will need to have re-loaded them on invalidate anyway, or
> (2) We will be receiving them through the postcopy migration mechanisms.
>
> This sounds correct to me; they won't get set as IN_USE on disk and if
> anyone tries to query or address them prior to handoff, they won't
> exist, so they can't be misused, either.
>
>> 2. We don't remove persistent bitmaps on inactivation. Instead, we only
>> remove bitmaps after storing. This is the only way to restore bitmaps,
>> if we decided to resume source after [failed] migration with
>> 'dirty-bitmaps' capability enabled (which means, that bitmaps were not
>> stored).
>>
> So currently, when we inactivate we remove the in-memory bitmaps that we
> considered to be associated with the bitmap -- ONLY for persistent ones.
> bdrv_release_persistent_dirty_bitmaps() managed this.
>
> However, the current hook for this in  bdrv_inactivate_recurse is a bit
> of a hack -- it just muses that the bitmaps "should already be stored by
> the format driver" -- and it's correct, they SHOULD be, but we can just
> move the hook to precisely when we store the bitmap. This is indeed more
> resilient.
>
> For any bitmaps theoretically left behind in this state, we can rest
> assured that we cannot write to an INACTIVE node anyway, so they won't
> be able to change on us. Either they'll get erased on close, or we'll
> re-use them on INVALIDATE.
>
>
> So now, in the shared storage + no-bitmap-migrate case:
>
> - We flush the bitmaps to disk anyway. The bitmaps are removed on-store.
> If we need to INVALIDATE and become active again, we just re-read them
> from disk. Any bitmaps we had that were NOT persistent never got
> removed, so we are fine.
>
> And in the migrate-bitmap case:
>
> You opt not to allow them to be flushed to disk, which means that not
> deleting them is definitely mandatory, in case of failure.
>
>
>
> The change that correlates to this bullet-point (delete only on store)
> is good regardless, but as of right now I'm confused as to why we can't
> flush bitmaps we want to transmit across the live migration channel to
> disk anyway.
>
> I guess you want to avoid a double-load in the case where we do a shared
> storage migration and a bitmap migration?

storing a lot of bitmap data on inactivate can significantly increase 
downtime of migration.

>
> The problem I have here is that this means that we simply ignore
> flushing to disk, so the bitmap remains IN_USE even when it isn't truly
> IN_USE, and that the method of coping with this means *ignoring* bitmaps
> that are IN_USE instead of erroring out and failing to load.

"IN_USE" means that bitmap was not successfully stored after last usage, 
and should be considered as inconsistent

>
> I think that's dangerous, unless I'm missing something -- I want QEMU to
> *error* if it sees an IN_USE bitmap. I think it ought to, as it's not
> safe to modify only some of these bitmaps.

hmm, what is unsafe with it? if bitmap is in_use it will not be loaded, 
so it's up to libvirt, to error out it's absence or recreate it..

>
> I think it's very strange to NOT flush bitmaps to disk on INACTIVATE,
> and I think we MUST do so.

Then we can't do online migration.

>
>> 3. We load bitmaps on open and any invalidation, it's ok for all cases:
>>    - normal open
> "Normal" open in the !(BDRV_O_INACTIVE) sense, yes.
>
>>    - migration target invalidation with dirty-bitmaps capability
>>      (bitmaps are migrating through migration channel, the are not
>>       stored, so they should have IN_USE flag set and will be skipped
>>       when loading. However, it would fail if bitmaps are read-only[1])
> I don't like this as stated above...
>
>>    - migration target invalidation without dirty-bitmaps capability
>>      (normal load of the bitmaps, if migrated with shared storage)
> This is good.
>
>>    - source invalidation with dirty-bitmaps capability
>>      (skip because IN_USE)
> I don't like the idea of skipping bitmaps that are IN_USE and continuing
> on as if that's OK. That could be hiding deeper problems.

I think it's a normal way to implement online migration of bitmaps 
without storing them (increasing downtime) and with a possibility to 
resume source on migration failure.

>
>>    - source invalidation without dirty-bitmaps capability
>>      (bitmaps were dropped, reload them)
> This is good.
>
>> [1]: to accurately handle this, migration of read-only bitmaps is
>>       explicitly forbidden in this patch.
>>
>> New mechanism for not storing bitmaps when migrate with dirty-bitmaps
>> capability is introduced: migration filed in BdrvDirtyBitmap.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   include/block/dirty-bitmap.h   |  2 +-
>>   block.c                        | 11 ++++---
>>   block/dirty-bitmap.c           | 36 +++++++++--------------
>>   block/qcow2-bitmap.c           | 16 +++++++++++
>>   block/qcow2.c                  | 65 ++++++++++++++++++++++++++++++++++++++++--
>>   migration/block-dirty-bitmap.c | 10 +++++--
>>   6 files changed, 109 insertions(+), 31 deletions(-)
>>
>> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
>> index 259bd27c40..95c7847ec6 100644
>> --- a/include/block/dirty-bitmap.h
>> +++ b/include/block/dirty-bitmap.h
>> @@ -26,7 +26,6 @@ BdrvDirtyBitmap *bdrv_find_dirty_bitmap(BlockDriverState *bs,
>>                                           const char *name);
>>   void bdrv_release_dirty_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap);
>>   void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs);
>> -void bdrv_release_persistent_dirty_bitmaps(BlockDriverState *bs);
>>   void bdrv_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>>                                            const char *name,
>>                                            Error **errp);
>> @@ -72,6 +71,7 @@ void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap,
>>   void bdrv_dirty_bitmap_set_qmp_locked(BdrvDirtyBitmap *bitmap, bool qmp_locked);
>>   void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
>>                                Error **errp);
>> +void bdrv_dirty_bitmap_set_migration(BdrvDirtyBitmap *bitmap, bool migration);
>>   
>>   /* Functions that require manual locking.  */
>>   void bdrv_dirty_bitmap_lock(BdrvDirtyBitmap *bitmap);
>> diff --git a/block.c b/block.c
>> index 1b8147c1b3..07d7a974d2 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -4396,6 +4396,7 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
>>       uint64_t perm, shared_perm;
>>       Error *local_err = NULL;
>>       int ret;
>> +    BdrvDirtyBitmap *bm;
>>   
>>       if (!bs->drv)  {
>>           return;
>> @@ -4445,6 +4446,12 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
>>           }
>>       }
>>   
>> +    for (bm = bdrv_dirty_bitmap_next(bs, NULL); bm;
>> +         bm = bdrv_dirty_bitmap_next(bs, bm))
>> +    {
>> +        bdrv_dirty_bitmap_set_migration(bm, false);
>> +    }
>> +
>>       ret = refresh_total_sectors(bs, bs->total_sectors);
>>       if (ret < 0) {
>>           bs->open_flags |= BDRV_O_INACTIVE;
>> @@ -4559,10 +4566,6 @@ static int bdrv_inactivate_recurse(BlockDriverState *bs,
>>           }
>>       }
>>   
>> -    /* At this point persistent bitmaps should be already stored by the format
>> -     * driver */
>> -    bdrv_release_persistent_dirty_bitmaps(bs);
>> -
>>       return 0;
>>   }
>>   
>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>> index c9b8a6fd52..a13c3bdcfa 100644
>> --- a/block/dirty-bitmap.c
>> +++ b/block/dirty-bitmap.c
>> @@ -55,6 +55,10 @@ struct BdrvDirtyBitmap {
>>                                      and this bitmap must remain unchanged while
>>                                      this flag is set. */
>>       bool persistent;            /* bitmap must be saved to owner disk image */
>> +    bool migration;             /* Bitmap is selected for migration, it should
>> +                                   not be stored on the next inactivation
>> +                                   (persistent flag doesn't matter until next
>> +                                   invalidation).*/
>>       QLIST_ENTRY(BdrvDirtyBitmap) list;
>>   };
>>   
>> @@ -384,26 +388,6 @@ void bdrv_release_named_dirty_bitmaps(BlockDriverState *bs)
>>   }
>>   
>>   /**
>> - * Release all persistent dirty bitmaps attached to a BDS (for use in
>> - * bdrv_inactivate_recurse()).
>> - * There must not be any frozen bitmaps attached.
>> - * This function does not remove persistent bitmaps from the storage.
>> - * Called with BQL taken.
>> - */
>> -void bdrv_release_persistent_dirty_bitmaps(BlockDriverState *bs)
>> -{
>> -    BdrvDirtyBitmap *bm, *next;
>> -
>> -    bdrv_dirty_bitmaps_lock(bs);
>> -    QLIST_FOREACH_SAFE(bm, &bs->dirty_bitmaps, list, next) {
>> -        if (bdrv_dirty_bitmap_get_persistance(bm)) {
>> -            bdrv_release_dirty_bitmap_locked(bm);
>> -        }
>> -    }
>> -    bdrv_dirty_bitmaps_unlock(bs);
>> -}
>> -
>> -/**
>>    * Remove persistent dirty bitmap from the storage if it exists.
>>    * Absence of bitmap is not an error, because we have the following scenario:
>>    * BdrvDirtyBitmap can have .persistent = true but not yet saved and have no
>> @@ -756,16 +740,24 @@ void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap, bool persistent)
>>       qemu_mutex_unlock(bitmap->mutex);
>>   }
>>   
>> +/* Called with BQL taken. */
>> +void bdrv_dirty_bitmap_set_migration(BdrvDirtyBitmap *bitmap, bool migration)
>> +{
>> +    qemu_mutex_lock(bitmap->mutex);
>> +    bitmap->migration = migration;
>> +    qemu_mutex_unlock(bitmap->mutex);
>> +}
>> +
>>   bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap)
>>   {
>> -    return bitmap->persistent;
>> +    return bitmap->persistent && !bitmap->migration;
>>   }
>>   
>>   bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs)
>>   {
>>       BdrvDirtyBitmap *bm;
>>       QLIST_FOREACH(bm, &bs->dirty_bitmaps, list) {
>> -        if (bm->persistent && !bm->readonly) {
>> +        if (bm->persistent && !bm->readonly && !bm->migration) {
>>               return true;
>>           }
>>       }
>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>> index 69485aa1de..c9662b21c7 100644
>> --- a/block/qcow2-bitmap.c
>> +++ b/block/qcow2-bitmap.c
>> @@ -1413,6 +1413,22 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>>           g_free(tb);
>>       }
>>   
>> +    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
>> +        /* For safety, we remove bitmap after storing.
>> +         * We may be here in two cases:
>> +         * 1. bdrv_close. It's ok to drop bitmap.
>> +         * 2. inactivation. It means migration without 'dirty-bitmaps'
>> +         *    capability, so bitmaps are not marked with
>> +         *    BdrvDirtyBitmap.migration flags. It's not bad to drop them too,
>> +         *    and reload on invalidation.
>> +         */
>> +        if (bm->dirty_bitmap == NULL) {
>> +            continue;
>> +        }
>> +
>> +        bdrv_release_dirty_bitmap(bs, bm->dirty_bitmap);
>> +    }
>> +
>>       bitmap_list_free(bm_list);
>>       return;
>>   
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 0044ff58e7..f5c99f4ed4 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -1487,8 +1487,69 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
>>           s->autoclear_features &= QCOW2_AUTOCLEAR_MASK;
>>       }
>>   
>> -    if (qcow2_load_dirty_bitmaps(bs, &local_err)) {
>> -        update_header = false;
>> +    /* == Handle persistent dirty bitmaps ==
>> +     *
>> +     * We want load dirty bitmaps in three cases:
>> +     *
>> +     * 1. Normal open of the disk in active mode, not related to invalidation
>> +     *    after migration.
>> +     *
>> +     * 2. Invalidation of the target vm after pre-copy phase of migration, if
>> +     *    bitmaps are _not_ migrating through migration channel, i.e.
>> +     *    'dirty-bitmaps' capability is disabled.
>> +     *
>> +     * 3. Invalidation of source vm after failed or canceled migration.
>> +     *    This is a very interesting case. There are two possible types of
>> +     *    bitmaps:
>> +     *
>> +     *    A. Stored on inactivation and removed. They should be loaded from the
>> +     *       image.
>> +     *
>> +     *    B. Not stored: not-persistent bitmaps and bitmaps, migrated through
>> +     *       the migration channel (with dirty-bitmaps capability).
>> +     *
> In my draft below, I suggest that "not stored" can only happen with
> non-persistent bitmaps. These are fine to keep in-memory and we don't
> need to do anything special to them on INACTIVATE/INVALIDATE cases.
>
>> +     *    On the other hand, there are two possible sub-cases:
>> +     *
>> +     *    3.1 disk was changed by somebody else while were inactive. In this
>> +     *        case all in-RAM dirty bitmaps (both persistent and not) are
>> +     *        definitely invalid. And we don't have any method to determine
>> +     *        this.
>> +     *
> I think if the disk was changed out from under us we do indeed have
> bigger problems to worry about WRT the memory state, so I wouldn't worry
> about this right now.
>
>> +     *        Simple and safe thing is to just drop all the bitmaps of type B on
>> +     *        inactivation. But in this case we lose bitmaps in valid 4.2 case.
>> +     *
>> +     *        On the other hand, resuming source vm, if disk was already changed
>> +     *        is a bad thing anyway: not only bitmaps, the whole vm state is
>> +     *        out of sync with disk.
>> +     *
>> +     *        This means, that user or management tool, who for some reason
>> +     *        decided to resume source vm, after disk was already changed by
>> +     *        target vm, should at least drop all dirty bitmaps by hand.
>> +     *
>> +     *        So, we can ignore this case for now, but TODO: "generation"
>> +     *        extension for qcow2, to determine, that image was changed after
>> +     *        last inactivation. And if it is changed, we will drop (or at least
>> +     *        mark as 'invalid' all the bitmaps of type B, both persistent
>> +     *        and not).
>> +     *
>> +     *    3.2 disk was _not_ changed while were inactive. Bitmaps may be saved
>> +     *        to disk ('dirty-bitmaps' capability disabled), or not saved
>> +     *        ('dirty-bitmaps' capability enabled), but we don't need to care
>> +     *        of: let's load bitmaps as always: stored bitmaps will be loaded,
>> +     *        and not stored has flag IN_USE=1 in the image and will be skipped
>> +     *        on loading.
>> +     *
>> +     * One remaining possible case when we don't want load bitmaps:
>> +     *
>> +     * 4. Open disk in inactive mode in target vm (bitmaps are migrating or
>> +     *    will be loaded on invalidation, no needs try loading them before)
>> +     */
>> +
>> +    if (!(bdrv_get_flags(bs) & BDRV_O_INACTIVE)) {
>> +        /* It's case 1, 2 or 3.2. Or 3.1 which is BUG in management layer. */
>> +        bool header_updated = qcow2_load_dirty_bitmaps(bs, &local_err);
>> +
>> +        update_header = update_header && !header_updated;
>>       }
>>       if (local_err != NULL) {
>>           error_propagate(errp, local_err);
>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
>> index 477826330c..ae4e88354a 100644
>> --- a/migration/block-dirty-bitmap.c
>> +++ b/migration/block-dirty-bitmap.c
>> @@ -313,6 +313,12 @@ static int init_dirty_bitmap_migration(void)
>>                   goto fail;
>>               }
>>   
>> +            if (bdrv_dirty_bitmap_readonly(bitmap)) {
>> +                error_report("Can't migrate read-only dirty bitmap: '%s",
>> +                             bdrv_dirty_bitmap_name(bitmap));
>> +                goto fail;
>> +            }
>> +
>>               bdrv_ref(bs);
>>               bdrv_dirty_bitmap_set_qmp_locked(bitmap, true);
>>   
>> @@ -335,9 +341,9 @@ static int init_dirty_bitmap_migration(void)
>>           }
>>       }
>>   
>> -    /* unset persistance here, to not roll back it */
>> +    /* unset migration flags here, to not roll back it */
> Stale comment, but I'm proposing we get rid of this idea anyway.
>
>>       QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
>> -        bdrv_dirty_bitmap_set_persistance(dbms->bitmap, false);
>> +        bdrv_dirty_bitmap_set_migration(dbms->bitmap, true);
>>       }
>>   
>>       if (QSIMPLEQ_EMPTY(&dirty_bitmap_mig_state.dbms_list)) {
>>
> So having read this, I think the problem is in cases where we migrate
> bitmaps in potentially two ways simultaneously: persistent/shared
> alongside migrate bitmaps capability.
>
> You've solved this by opting to not flush bitmaps to disk, and then just
> skipping them on-load.
>
> I'd rather do something like this:
> - Always flush bitmaps to disk on inactivate.

this is the most significant of your changes and it is unacceptable for 
us. We can't store bitmaps in migration downtime, as it is slow.
64k granulated bitmap for 16tb disk has 30mb size. And what if we have 
several of such bitmaps?

Again, we can't do it. So, I'm for my version of patch series.

> - Skip loading bitmaps if inactive.
> - When migrating, omit bitmaps from the stream if they're persistent and
> we're doing a shared storage migration. (i.e, stream only when we have to.)
> - Refuse to load an image at all if it has IN_USE bitmaps that we are
> expected to keep consistent with the disk. (We won't be able to!)
>
> I think this has a lot of good properties:
> - disk state is consistent (we never have IN_USE when that's not true)
> - it avoids unnecessary traffic for the migration stream
> - it gets rid of the special migration bool in bitmaps
> - it allows us to hard reject qcow2 files with IN_USE bitmaps, which is
> important for consistency.
>
> this breaks your test suite, though, because you don't *actually*
> initiate a block migration, you just simulate it by giving it a blank
> qcow2 to migrate the bitmaps too -- so you can fix it by actually doing
> a block migration of the empty disks.
>
> Here's a patch presented as patch 7/6 that:
>
> - Removes set_migration flag, functions, and calls
> - Changes the migbitmap behavior
> - Adjusts test 169 accordingly
>
> (Because I'm positive thunderbird is about to mangle this, I've mirrored
> it on github:
> https://github.com/jnsnow/qemu/commit/4f3f2a30c60b793312a3b994f8defbb2f2402121
> )
>
> diff --git a/block.c b/block.c
> index 5f1a133417..f16bf106d1 100644
> --- a/block.c
> +++ b/block.c
> @@ -4334,7 +4334,6 @@ static void coroutine_fn
> bdrv_co_invalidate_cache(BlockDriverState *bs,
>       uint64_t perm, shared_perm;
>       Error *local_err = NULL;
>       int ret;
> -    BdrvDirtyBitmap *bm;
>
>       if (!bs->drv)  {
>           return;
> @@ -4384,12 +4383,6 @@ static void coroutine_fn
> bdrv_co_invalidate_cache(BlockDriverState *bs,
>           }
>       }
>
> -    for (bm = bdrv_dirty_bitmap_next(bs, NULL); bm;
> -         bm = bdrv_dirty_bitmap_next(bs, bm))
> -    {
> -        bdrv_dirty_bitmap_set_migration(bm, false);
> -    }
> -
>       ret = refresh_total_sectors(bs, bs->total_sectors);
>       if (ret < 0) {
>           bs->open_flags |= BDRV_O_INACTIVE;
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index a13c3bdcfa..e44061fe2e 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -55,10 +55,6 @@ struct BdrvDirtyBitmap {
>                                      and this bitmap must remain
> unchanged while
>                                      this flag is set. */
>       bool persistent;            /* bitmap must be saved to owner disk
> image */
> -    bool migration;             /* Bitmap is selected for migration, it
> should
> -                                   not be stored on the next inactivation
> -                                   (persistent flag doesn't matter
> until next
> -                                   invalidation).*/
>       QLIST_ENTRY(BdrvDirtyBitmap) list;
>   };
>
> @@ -740,24 +736,16 @@ void
> bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap, bool persistent)
>       qemu_mutex_unlock(bitmap->mutex);
>   }
>
> -/* Called with BQL taken. */
> -void bdrv_dirty_bitmap_set_migration(BdrvDirtyBitmap *bitmap, bool
> migration)
> -{
> -    qemu_mutex_lock(bitmap->mutex);
> -    bitmap->migration = migration;
> -    qemu_mutex_unlock(bitmap->mutex);
> -}
> -
>   bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap)
>   {
> -    return bitmap->persistent && !bitmap->migration;
> +    return bitmap->persistent;
>   }
>
>   bool bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs)
>   {
>       BdrvDirtyBitmap *bm;
>       QLIST_FOREACH(bm, &bs->dirty_bitmaps, list) {
> -        if (bm->persistent && !bm->readonly && !bm->migration) {
> +        if (bm->persistent && !bm->readonly) {
>               return true;
>           }
>       }
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index ae4e88354a..428a86303d 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -295,6 +295,12 @@ static int init_dirty_bitmap_migration(void)
>                   continue;
>               }
>
> +            /* Skip persistant bitmaps, unless it's a block migration: */
> +            if (bdrv_dirty_bitmap_get_persistance(bitmap) &&
> +                !migrate_use_block()) {
> +                continue;
> +            }
> +
>               if (drive_name == NULL) {
>                   error_report("Found bitmap '%s' in unnamed node %p. It
> can't "
>                                "be migrated",
> bdrv_dirty_bitmap_name(bitmap), bs);
> @@ -341,11 +347,6 @@ static int init_dirty_bitmap_migration(void)
>           }
>       }
>
> -    /* unset migration flags here, to not roll back it */
> -    QSIMPLEQ_FOREACH(dbms, &dirty_bitmap_mig_state.dbms_list, entry) {
> -        bdrv_dirty_bitmap_set_migration(dbms->bitmap, true);
> -    }
> -
>       if (QSIMPLEQ_EMPTY(&dirty_bitmap_mig_state.dbms_list)) {
>           dirty_bitmap_mig_state.no_bitmaps = true;
>       }
> diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
> index 69850c4c67..eaff111480 100755
> --- a/tests/qemu-iotests/169
> +++ b/tests/qemu-iotests/169
> @@ -105,8 +105,7 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
>                   break
>
>           # test that bitmap is still here
> -        removed = (not migrate_bitmaps) and persistent
> -        self.check_bitmap(self.vm_a, False if removed else sha256)
> +        self.check_bitmap(self.vm_a, False if persistent else sha256)
>
>           self.vm_a.qmp('cont')
>
> @@ -142,6 +141,8 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
>           mig_caps = [{'capability': 'events', 'state': True}]
>           if migrate_bitmaps:
>               mig_caps.append({'capability': 'dirty-bitmaps', 'state': True})
> +        if not shared_storage:
> +            mig_caps.append({'capability': 'block', 'state': True})
>
>           result = self.vm_a.qmp('migrate-set-capabilities',
>                                  capabilities=mig_caps)
> @@ -191,6 +192,8 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
>               # possible error
>               log = self.vm_b.get_log()
>               log = re.sub(r'^\[I \d+\.\d+\] OPENED\n', '', log)
> +            log = re.sub(r'Receiving block device images\n', '', log)
> +            log = re.sub(r'Completed \d+ %\r?\n?', '', log)
>               log = re.sub(r'\[I \+\d+\.\d+\] CLOSED\n?$', '', log)
>               self.assertEqual(log, '')


-- 
Best regards,
Vladimir
