Received: from eggs.gnu.org ([209.51.188.92]:60631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1goAu2-0003AY-VT
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:41:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1goAtz-0004aj-QD
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:40:58 -0500
Date: Mon, 28 Jan 2019 18:40:36 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190128174036.GK5756@localhost.localdomain>
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
	<20181229122027.42245-12-vsementsov@virtuozzo.com>
	<1ea09d99-04ff-711e-9137-cdae33ca8681@redhat.com>
	<643f318f-392d-1370-f952-b2a01e7d9bb7@virtuozzo.com>
	<ea0a19fd-2db5-bfa5-180b-68c3ef80e046@redhat.com>
	<cd1c98bd-1f40-5aa9-01ec-5109ee36e1e8@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd1c98bd-1f40-5aa9-01ec-5109ee36e1e8@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v5 11/11] block/backup: use backup-top
 instead of write notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, Denis Lunev <den@virtuozzo.com>, "eblake@redhat.com" <eblake@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>

Am 28.01.2019 um 17:44 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 28.01.2019 18:59, Max Reitz wrote:
> > On 28.01.19 12:29, Vladimir Sementsov-Ogievskiy wrote:
> >> 18.01.2019 17:56, Max Reitz wrote:
> >>> On 29.12.18 13:20, Vladimir Sementsov-Ogievskiy wrote:
> >>>> Drop write notifiers and use filter node instead. Changes:
> >>>>
> >>>> 1. copy-before-writes now handled by filter node, so, drop all
> >>>>      is_write_notifier arguments.
> >>>>
> >>>> 2. we don't have intersecting requests, so their handling is dropped.
> >>>> Instead, synchronization works as follows:
> >>>> when backup or backup-top starts copying of some area it firstly
> >>>> clears copy-bitmap bits, and nobody touches areas, not marked with
> >>>> dirty bits in copy-bitmap, so there is no intersection. Also, backup
> >>>> job copy operations are surrounded by bdrv region lock, which is
> >>>> actually serializing request, to not interfer with guest writes and
> >>>> not read changed data from source (before reading we clear
> >>>> corresponding bit in copy-bitmap, so, this area is not more handled by
> >>>> backup-top).
> >>>>
> >>>> 3. To sync with in-flight requests we now just drain hook node, we
> >>>> don't need rw-lock.
> >>>>
> >>>> 4. After the whole backup loop (top, full, incremental modes), we need
> >>>> to check for not copied clusters, which were under backup-top operation
> >>>> and we skipped them, but backup-top operation failed, error returned to
> >>>> the guest and dirty bits set back.
> >>>>
> >>>> 5. Don't create additional blk, use backup-top children for copy
> >>>> operations.
> >>>>
> >>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >>>> ---
> >>>>    block/backup.c | 285 ++++++++++++++++++++++++++-----------------------
> >>>>    1 file changed, 149 insertions(+), 136 deletions(-)
> >>>>
> >>>> diff --git a/block/backup.c b/block/backup.c
> >>>> index 88c0242b4e..e332909fb7 100644
> >>>> --- a/block/backup.c
> >>>> +++ b/block/backup.c
> >>>
> >>> [...]
> >>>
> >>>> @@ -300,21 +231,23 @@ static void backup_abort(Job *job)
> >>>>    static void backup_clean(Job *job)
> >>>>    {
> >>>>        BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
> >>>> -    assert(s->target);
> >>>> -    blk_unref(s->target);
> >>>> +
> >>>> +    /* We must clean it to not crash in backup_drain. */
> >>>>        s->target = NULL;
> >>>
> >>> Why not set s->source to NULL along with it?  It makes sense if you're
> >>> going to drop the backup-top node because both of these are its children.
> >>
> >> agree.
> >>
> >>>
> >>>>    
> >>>>        if (s->copy_bitmap) {
> >>>>            hbitmap_free(s->copy_bitmap);
> >>>>            s->copy_bitmap = NULL;
> >>>>        }
> >>>> +
> >>>> +    bdrv_backup_top_drop(s->backup_top);
> >>>>    }
> >>>
> >>> [...]
> >>>
> >>>> @@ -386,21 +319,45 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
> >>>>        bool error_is_read;
> >>>>        int64_t offset;
> >>>>        HBitmapIter hbi;
> >>>> +    void *lock = NULL;
> >>>>    
> >>>>        hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
> >>>> -    while ((offset = hbitmap_iter_next(&hbi)) != -1) {
> >>>> +    while (hbitmap_count(job->copy_bitmap)) {
> >>>> +        offset = hbitmap_iter_next(&hbi);
> >>>> +        if (offset == -1) {
> >>>> +            /*
> >>>> +             * we may have skipped some clusters, which were handled by
> >>>> +             * backup-top, but failed and finished by returning error to
> >>>> +             * the guest and set dirty bit back.
> >>>> +             */
> >>>> +            hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
> >>>> +            offset = hbitmap_iter_next(&hbi);
> >>>> +            assert(offset);
> >>>
> >>> I think you want to assert "offset >= 0".
> >>>
> >>>> +        }
> >>>> +
> >>>> +        lock = bdrv_co_try_lock(job->source, offset, job->cluster_size);
> >>>> +        /*
> >>>> +         * Dirty bit is set, which means that there are no in-flight
> >>>> +         * write requests on this area. We must succeed.
> >>>> +         */
> >>>> +        assert(lock);
> >>>
> >>> I'm not sure that is true right now, but more on that below in backup_run().
> >>>
> >>>> +
> >>>>            do {
> >>>>                if (yield_and_check(job)) {
> >>>> +                bdrv_co_unlock(lock);
> >>>>                    return 0;
> >>>>                }
> >>>> -            ret = backup_do_cow(job, offset,
> >>>> -                                job->cluster_size, &error_is_read, false);
> >>>> +            ret = backup_do_cow(job, offset, job->cluster_size, &error_is_read);
> >>>>                if (ret < 0 && backup_error_action(job, error_is_read, -ret) ==
> >>>>                               BLOCK_ERROR_ACTION_REPORT)
> >>>>                {
> >>>> +                bdrv_co_unlock(lock);
> >>>>                    return ret;
> >>>>                }
> >>>>            } while (ret < 0);
> >>>> +
> >>>> +        bdrv_co_unlock(lock);
> >>>> +        lock = NULL;
> >>>
> >>> This statement seems unnecessary here.
> >>>
> >>>>        }
> >>>>    
> >>>>        return 0;
> >>>
> >>> [...]
> >>>
> >>>> @@ -447,26 +402,39 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
> >>>>            hbitmap_set(s->copy_bitmap, 0, s->len);
> >>>>        }
> >>>>    
> >>>> -    s->before_write.notify = backup_before_write_notify;
> >>>> -    bdrv_add_before_write_notifier(bs, &s->before_write);
> >>>> -
> >>>>        if (s->sync_mode == MIRROR_SYNC_MODE_NONE) {
> >>>>            /* All bits are set in copy_bitmap to allow any cluster to be copied.
> >>>>             * This does not actually require them to be copied. */
> >>>>            while (!job_is_cancelled(job)) {
> >>>> -            /* Yield until the job is cancelled.  We just let our before_write
> >>>> -             * notify callback service CoW requests. */
> >>>> +            /*
> >>>> +             * Yield until the job is cancelled.  We just let our backup-top
> >>>> +             * fileter driver service CbW requests.
> >>>
> >>> *filter
> >>>
> >>>> +             */
> >>>>                job_yield(job);
> >>>>            }
> >>>>        } else if (s->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
> >>>>            ret = backup_run_incremental(s);
> >>>>        } else {
> >>>
> >>> [...]
> >>>
> >>>> @@ -505,8 +474,20 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
> >>>>                if (alloced < 0) {
> >>>>                    ret = alloced;
> >>>>                } else {
> >>>> +                if (!hbitmap_get(s->copy_bitmap, offset)) {
> >>>> +                    trace_backup_do_cow_skip(job, offset);
> >>>> +                    continue; /* already copied */
> >>>> +                }
> >>>> +                if (!lock) {
> >>>> +                    lock = bdrv_co_try_lock(s->source, offset, s->cluster_size);
> >>>> +                    /*
> >>>> +                     * Dirty bit is set, which means that there are no in-flight
> >>>> +                     * write requests on this area. We must succeed.
> >>>> +                     */
> >>>> +                    assert(lock);
> >>>
> >>> What if I have a different parent node for the source that issues
> >>> concurrent writes?  This used to work fine because the before_write
> >>> notifier would still work.  After this patch, that would be broken
> >>> because those writes would not cause a CbW.
> >>
> >> But haw could you have this different parent node? After appending filter,
> >> there should not be such nodes.
> > 
> > Unless you append them afterwards:
> > 
> >> And I think, during backup it should be
> >> forbidden to append new parents to source, ignoring filter, as it definitely
> >> breaks what filter does.
> > 
> > Agreed, but then this needs to be implemented.
> > 
> >> And it applies to other block-job with their filters.
> >> If we appended a filter, we don't want someone other to write omit our filter.
> >>
> >>>
> >>> That's not so bad because we just have to make sure that all writes go
> >>> through the backup-top node.  That would make this assertion valid
> >>> again, too.  But that means we cannot share PERM_WRITE; see [1].
> >>
> >> But we don't share PERM_WRITE on source in backup_top, only on target.
> > 
> > Are you sure?  The job itself shares it, and the filter shares it, too,
> > as far as I can see.  It uses bdrv_filter_default_perms(), and that does
> > seem to share PERM_WRITE.
> 
> And in bdrv_Filter_default_perms it does "*nshared = *nshared | BLK_PERM_WRITE"
> only for child_file, it is target. Source is child_backing.
> 
> > 
> >>>
> >>>> +                }
> >>>>                    ret = backup_do_cow(s, offset, s->cluster_size,
> >>>> -                                    &error_is_read, false);
> >>>> +                                    &error_is_read);
> >>>>                }
> >>>>                if (ret < 0) {
> >>>>                    /* Depending on error action, fail now or retry cluster */
> >>>> @@ -516,17 +497,34 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
> >>>>                        break;
> >>>>                    } else {
> >>>>                        offset -= s->cluster_size;
> >>>> +                    retry = true;
> >>>>                        continue;
> >>>>                    }
> >>>>                }
> >>>>            }
> >>>> +        if (lock) {
> >>>> +            bdrv_co_unlock(lock);
> >>>> +            lock = NULL;
> >>>> +        }
> >>>> +        if (ret == 0 && !job_is_cancelled(job) &&
> >>>> +            hbitmap_count(s->copy_bitmap))
> >>>> +        {
> >>>> +            /*
> >>>> +             * we may have skipped some clusters, which were handled by
> >>>> +             * backup-top, but failed and finished by returning error to
> >>>> +             * the guest and set dirty bit back.
> >>>
> >>> So it's a matter of a race?
> >>>
> >>>> +             */
> >>>> +            goto iteration;
> >>>> +        }
> >>>
> >>> Why not wrap everything in a do {} while (ret == 0 && !job_is...)
> >>> instead?  Because it would mean reindenting everything?
> >>
> >> Don't remember, but assume that yes. And this code is anyway "To be refactored",
> >> I want all FULL/TOP/INCREMENTAL go through the same (mostly) code path.
> > 
> > Hm, well, if you want to refactor it later anyway...  But I don't like
> > gotos that go backwards very much, unless there is a good reason to have
> > them (and there isn't here).
> 
> 
> Ok, not a real problem. Let's go on with do-while.
> 
> 
> > 
> >>>>        }
> >>>>    
> >>>> -    notifier_with_return_remove(&s->before_write);
> >>>> +    /* wait pending CBW operations in backup-top */
> >>>> +    bdrv_drain(s->backup_top);
> >>>>    
> >>>> -    /* wait until pending backup_do_cow() calls have completed */
> >>>> -    qemu_co_rwlock_wrlock(&s->flush_rwlock);
> >>>> -    qemu_co_rwlock_unlock(&s->flush_rwlock);
> >>>> +    backup_top_progress = bdrv_backup_top_progress(s->backup_top);
> >>>> +    job_progress_update(job, ret + backup_top_progress -
> >>>
> >>> Why the "ret"?
> >>
> >> oops, it looks like a copy-paste bug ("ret" is reasonable in backup_do_cow())
> >>
> >>>
> >>>> +                        s->backup_top_progress);
> >>>> +    s->backup_top_progress = backup_top_progress;
> >>>
> >>> So the backup-top progress is ignored during basically all of the block
> >>> job until it suddenly jumps to 100 % completion?  That doesn't sound ideal.
> >>>
> >>> Or did you mean to put this into the for () loop of MODE_TOP/MODE_FULL?
> >>>    (And the while() loop of MODE_NONE)
> >>
> >>
> >> It is done in backup_do_cow(), so FULL and TOP are covered.
> >>
> >> But you are right that MODE_NONE seems to have a problem about it.. And just updating it
> >> in a while loop would not work, as I doubt that job_yield will return until job finish
> >> or user interaction like pause/continue/cancel..
> >>
> >> So now, it looks better to call job_progress_update() from backup_top directly, and drop
> >> this hack.
> > 
> > Hmmm...  I don't think job_*() calls belong in backup_top.  How about
> > adding a callback to bdrv_backup_top_append()?
> 
> Ok for me at least as a temporary step.
> 
> > 
> >>>>    
> >>>>        return ret;
> >>>>    }
> >>>> @@ -563,6 +561,9 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
> >>>>        int ret;
> >>>>        int64_t cluster_size;
> >>>>        HBitmap *copy_bitmap = NULL;
> >>>> +    BlockDriverState *backup_top = NULL;
> >>>> +    uint64_t all_except_resize = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
> >>>> +                                 BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MOD;
> >>>
> >>> BLK_PERM_ALL & ~BLK_PERM_RESIZE?
> >>>
> >>> [1] But we probably do not want to share either PERM_WRITE or
> >>> PERM_WRITE_UNCHANGED because during the duration of the backup,
> >>> everything should go through the backup-top filter (not sure about
> >>> PERM_WRITE_UNCHANGED right now).  Or is that something that the filter
> >>> node should enforce in backup_top_child_perm()?
> >>
> >> It's not shared perm of backup_top, it's a shared perm of block-job common.blk, which is
> >> used only to "job->len is fixed, so we can't allow resize", so this part is not changed.
> >>
> >> So yes, the problem you mean by [1] is about backup_top_child_perm() where we share PERM_WRITE.
> >> And it is described by comment, we must share this write perm, otherwise we break guest writes.
> > 
> > For the target, yes, but the problem is sharing it on the source.
> > 
> >> We share PERM_WRITE in backup_top to force its target child share PERM_WRITE on its backing,
> >> as backing of target is source.
> >>
> >> But again, we share PERM_WRITE only on target, and it is shared in current code too.
> > 
> > I'm not so sure whether PERM_WRITE is shared only on the target.
> 
> Only on target, as child_file is target.
> 
> > 
> >>>
> >>>>    
> >>>>        assert(bs);
> >>>>        assert(target);
> >>>> @@ -655,25 +656,31 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
> >>>>    
> >>>>        copy_bitmap = hbitmap_alloc(len, ctz32(cluster_size));
> >>>>    
> >>>> -    /* job->len is fixed, so we can't allow resize */
> >>>> -    job = block_job_create(job_id, &backup_job_driver, txn, bs,
> >>>> -                           BLK_PERM_CONSISTENT_READ,
> >>>> -                           BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
> >>>> -                           BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MOD,
> >>>> -                           speed, creation_flags, cb, opaque, errp);
> >>>> -    if (!job) {
> >>>> +    /*
> >>>> +     * bdrv_get_device_name will not help to find device name starting from
> >>>> +     * @bs after backup-top append,
> >>>
> >>> Why not?  Since backup-top is appended, shouldn't all parents of @bs be
> >>> parents of @backup_top then?  (Making bdrv_get_parent_name() return the
> >>> same result)
> >>
> >> bdrv_get_device_name goes finally through role->get_name, and only root role has
> >> this handler. After append we'll have backing role instead of root.
> > 
> > Ah, I see, I asked the wrong question.
> > 
> > Why is block_job_create() called on bs and not on backup_top?  mirror
> > calls it on mirror_top_bs.
> 
> Good question. I don't exactly remember, may be there are were more troubles with
> permissions or somthing. So, I've to try it again..
> 
> What is more beneficial?
> 
> My current approach, is that job and filter are two sibling users of source node,
> they do copying, they are synchronized. And in this way, it is better to read from
> source directly, to not create extra intersection between job and filter..
> 
> On the other hand, if we read through the filter, we possible should do the whole
> copy operation through the filter..
> 
> What is the difference between guest read and backup-job read, in filter POV? I think:
> 
> For guest read, filter MUST read (as we must handle guest request), and than, if
> we don't have too much in-flight requests, ram-cache is not full, etc, we can handle
> already read data in terms of backup, so, copy it somewhere. Or we can drop it, if
> we can't handle it at the moment..
> 
> For job read, we even MAY not read, if our queues are full, postponing job request.
> 
> So
> 
> Guest read: MUST read, MAY backup
> Job read: MAY read and backup
> 
> So, reading through filter has a possibility of common code path + native prioritization
> of copy operations. This of course will need more refactoring of backup, and may be done
> as a separate step, but definitely, I have to at least try to create job above the filter.
> 
> > 
> >>>>                                        so let's calculate job_id before. Do
> >>>> +     * it in the same way like block_job_create
> >>>> +     */
> >>>> +    if (job_id == NULL && !(creation_flags & JOB_INTERNAL)) {
> >>>> +        job_id = bdrv_get_device_name(bs);
> >>>> +    }
> >>>> +
> >>>> +    backup_top = bdrv_backup_top_append(bs, target, copy_bitmap, errp);
> >>>> +    if (!backup_top) {
> >>>>            goto error;
> >>>>        }
> >>>>    
> >>>> -    /* The target must match the source in size, so no resize here either */
> >>>> -    job->target = blk_new(BLK_PERM_WRITE,
> >>>> -                          BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
> >>>> -                          BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MOD);
> >>>> -    ret = blk_insert_bs(job->target, target, errp);
> >>>> -    if (ret < 0) {
> >>>> +    /* job->len is fixed, so we can't allow resize */
> >>>> +    job = block_job_create(job_id, &backup_job_driver, txn, bs, 0,
> >>>
> >>> Is there a reason you dropped PERM_CONSISTENT_READ here?
> >>
> >> Because, we don't use this blk for read now, we read through backup_top child.
> > 
> > Makes sense.
> > 
> >>>> +                           all_except_resize, speed, creation_flags,
> >>>> +                           cb, opaque, errp);
> >>>> +    if (!job) {
> >>>>            goto error;
> >>>>        }
> >>>>    
> >>>> +    job->source = backup_top->backing;
> >>>> +    job->target = ((BDRVBackupTopState *)backup_top->opaque)->target;
> >>>
> >>> This looks really ugly.  I think as long as the block job performs
> >>> writes itself, it should use its own BlockBackend.
> >>
> >> They are not BlockBackends, they are BdrvChildren.
> > 
> > Exactly, which is what I don't like.  They are children of a node that
> > is implemented in a different file, it looks weird to use them here.
> > 
> >> It was Kevin's idea to reuse filter's
> >> children in backup job:
> >>
> >> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01017.html
> > 
> > It's still ugly if backup_top is in a different file.  Well, maybe just
> > to me.
> > 
> >> Hmm, and this is also why I need PERM_WRITE in backup_top, to write to target.
> >>
> >>>
> >>> Alternatively, I think it would make sense for the backup-top filter to
> >>> offer functions that this job can use to issue writes to the target.
> >>> Then the backup job would no longer need direct access to the target as
> >>> a BdrvChild.
> > 
> > So what would be the problem with this?
> 
> I have no specific arguments against, I'll try. Kevin, do have comments on this?

I haven't really followed this thread recently because there was other
stuff that needed my attention and you seemed to have a good discussion
with Max. If you think my input would be important at this point, I can
try to read up on it tomorrow.

Kevin
