Received: from eggs.gnu.org ([2001:4830:134:3::10]:55174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fxHzv-0005vn-6X
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 16:32:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fxHzt-0005K1-Go
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 16:32:26 -0400
References: <20180904170930.28619-1-jsnow@redhat.com>
	<20180904170930.28619-5-jsnow@redhat.com>
	<20180904184620.GI415265@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <63e2cd53-a4cb-3ed7-ae70-f49b4e11fad5@redhat.com>
Date: Tue, 4 Sep 2018 16:32:17 -0400
MIME-Version: 1.0
In-Reply-To: <20180904184620.GI415265@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 04/15] block/commit: refactor commit to
 use job callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>



On 09/04/2018 02:46 PM, Jeff Cody wrote:
> On Tue, Sep 04, 2018 at 01:09:19PM -0400, John Snow wrote:
>> Use the component callbacks; prepare, abort, and clean.
>>
>> NB: prepare is only called when the job has not yet failed;
>> and abort can be called after prepare.
>>
>> complete -> prepare -> abort -> clean
>> complete -> abort -> clean
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/commit.c | 90 ++++++++++++++++++++++++++++++++--------------------------
>>  1 file changed, 49 insertions(+), 41 deletions(-)
>>
>> diff --git a/block/commit.c b/block/commit.c
>> index b6e8969877..eb3941e545 100644
>> --- a/block/commit.c
>> +++ b/block/commit.c
>> @@ -36,6 +36,7 @@ typedef struct CommitBlockJob {
>>      BlockDriverState *commit_top_bs;
>>      BlockBackend *top;
>>      BlockBackend *base;
>> +    BlockDriverState *base_bs;
>>      BlockdevOnError on_error;
>>      int base_flags;
>>      char *backing_file_str;
>> @@ -68,61 +69,65 @@ static int coroutine_fn commit_populate(BlockBackend *bs, BlockBackend *base,
>>      return 0;
>>  }
>>  
>> -static void commit_exit(Job *job)
>> +static int commit_prepare(Job *job)
>>  {
>>      CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
>> -    BlockJob *bjob = &s->common;
>> -    BlockDriverState *top = blk_bs(s->top);
>> -    BlockDriverState *base = blk_bs(s->base);
>> -    BlockDriverState *commit_top_bs = s->commit_top_bs;
>> -    bool remove_commit_top_bs = false;
>> -
>> -    /* Make sure commit_top_bs and top stay around until bdrv_replace_node() */
>> -    bdrv_ref(top);
>> -    bdrv_ref(commit_top_bs);
>>  
>>      /* Remove base node parent that still uses BLK_PERM_WRITE/RESIZE before
>>       * the normal backing chain can be restored. */
>>      blk_unref(s->base);
>> +    s->base = NULL;
>>  
>> -    if (!job_is_cancelled(job) && job->ret == 0) {
>> -        /* success */
>> -        job->ret = bdrv_drop_intermediate(s->commit_top_bs, base,
>> -                                          s->backing_file_str);
>> -    } else {
>> -        /* XXX Can (or should) we somehow keep 'consistent read' blocked even
>> -         * after the failed/cancelled commit job is gone? If we already wrote
>> -         * something to base, the intermediate images aren't valid any more. */
>> -        remove_commit_top_bs = true;
>> +    return bdrv_drop_intermediate(s->commit_top_bs, s->base_bs,
>> +                                  s->backing_file_str);
>> +}
> 
> If we can go from prepare->abort->clean, then that means to me that every
> failure case of .prepare() can be resolved without permanent changes / data
> loss.  Is this necessarily the case?
> 

That'd be a requisite to make the job a transaction, but commit, mirror
and stream are not currently transactionable.

The way commit already works, for example, can leave the base and
intermediate images as unusable as standalone images. This refactoring
will not change that alone.

So it's not necessarily a problem, but it's something that would need to
be fixed if we ever wanted transaction support.

However, in talking on IRC we did realize that this patch does change
behavior...

Before:

If bdrv_drop_intermediate fails, we store the retcode but continue
cleaning up as if it didn't fail. i.e., we don't remove the commit job's
installed top_bs node.

After:

if bdrv_drop_intermediate fails, we return the failure retcode and
.abort gets called as a result, i.e. we will remove the commit job's
installed top_bs node in favor of the original top_bs node.

I think this behavior is an improvement, however it raises a question
about the nature of failures in bdrv_drop_intermediate.

If this function fails without making any changes, the new commit
behavior is good. If it succeeds, we're also good. The problem is with
intermediate or partial successes.

If top has multiple parents (I think under normal circumstances it
won't, but I'm not absolutely sure) and it fails to update their backing
file references, it might partially succeed.

I think commit's usage here is correct, but I think we might need to
update bdrv_drop_intermediate to make it roll back changes if it
experiences a partial failure to give all-or-nothing semantics.

Thoughts?

> From bdrv_drop_intermediate():
> 
>     QLIST_FOREACH_SAFE(c, &top->parents, next_parent, next) {
>         /* Check whether we are allowed to switch c from top to base */
>         GSList *ignore_children = g_slist_prepend(NULL, c);
>         bdrv_check_update_perm(base, NULL, c->perm, c->shared_perm,
>                                ignore_children, &local_err);
>         g_slist_free(ignore_children);
>         if (local_err) {
>             ret = -EPERM;
>             error_report_err(local_err);
>             goto exit;
>         }
> 
>         /* If so, update the backing file path in the image file */
>         if (c->role->update_filename) {
>             ret = c->role->update_filename(c, base, backing_file_str,
>                                            &local_err);
>             if (ret < 0) {
>                 bdrv_abort_perm_update(base);
>                 error_report_err(local_err);
>                 goto exit;
>             }
>         }
> 
>         [...]
>      }
> 
> We could fail this but still have modified an image file backing filenames,
> right?
> 
> Or am I incorrect about the intention here, that abort() can always be clean?
> 
> -Jeff
> 
>> +
>> +static void commit_abort(Job *job)
>> +{
>> +    CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
>> +    BlockDriverState *top_bs = blk_bs(s->top);
>> +
>> +    /* Make sure commit_top_bs and top stay around until bdrv_replace_node() */
>> +    bdrv_ref(top_bs);
>> +    bdrv_ref(s->commit_top_bs);
>> +
>> +    if (s->base) {
>> +        blk_unref(s->base);
>>      }
>>  
>> +    /* free the blockers on the intermediate nodes so that bdrv_replace_nodes
>> +     * can succeed */
>> +    block_job_remove_all_bdrv(&s->common);
>> +
>> +    /* If bdrv_drop_intermediate() failed (or was not invoked), remove the
>> +     * commit filter driver from the backing chain now. Do this as the final
>> +     * step so that the 'consistent read' permission can be granted.
>> +     *
>> +     * XXX Can (or should) we somehow keep 'consistent read' blocked even
>> +     * after the failed/cancelled commit job is gone? If we already wrote
>> +     * something to base, the intermediate images aren't valid any more. */
>> +    bdrv_child_try_set_perm(s->commit_top_bs->backing, 0, BLK_PERM_ALL,
>> +                            &error_abort);
>> +    bdrv_replace_node(s->commit_top_bs, backing_bs(s->commit_top_bs),
>> +                      &error_abort);
>> +
>> +    bdrv_unref(s->commit_top_bs);
>> +    bdrv_unref(top_bs);
>> +}
>> +
>> +static void commit_clean(Job *job)
>> +{
>> +    CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
>> +
>>      /* restore base open flags here if appropriate (e.g., change the base back
>>       * to r/o). These reopens do not need to be atomic, since we won't abort
>>       * even on failure here */
>> -    if (s->base_flags != bdrv_get_flags(base)) {
>> -        bdrv_reopen(base, s->base_flags, NULL);
>> +    if (s->base_flags != bdrv_get_flags(s->base_bs)) {
>> +        bdrv_reopen(s->base_bs, s->base_flags, NULL);
>>      }
>> +
>>      g_free(s->backing_file_str);
>>      blk_unref(s->top);
>> -
>> -    /* If there is more than one reference to the job (e.g. if called from
>> -     * job_finish_sync()), job_completed() won't free it and therefore the
>> -     * blockers on the intermediate nodes remain. This would cause
>> -     * bdrv_set_backing_hd() to fail. */
>> -    block_job_remove_all_bdrv(bjob);
>> -
>> -    /* If bdrv_drop_intermediate() didn't already do that, remove the commit
>> -     * filter driver from the backing chain. Do this as the final step so that
>> -     * the 'consistent read' permission can be granted.  */
>> -    if (remove_commit_top_bs) {
>> -        bdrv_child_try_set_perm(commit_top_bs->backing, 0, BLK_PERM_ALL,
>> -                                &error_abort);
>> -        bdrv_replace_node(commit_top_bs, backing_bs(commit_top_bs),
>> -                          &error_abort);
>> -    }
>> -
>> -    bdrv_unref(commit_top_bs);
>> -    bdrv_unref(top);
>>  }
>>  
>>  static int coroutine_fn commit_run(Job *job, Error **errp)
>> @@ -211,7 +216,9 @@ static const BlockJobDriver commit_job_driver = {
>>          .user_resume   = block_job_user_resume,
>>          .drain         = block_job_drain,
>>          .run           = commit_run,
>> -        .exit          = commit_exit,
>> +        .prepare       = commit_prepare,
>> +        .abort         = commit_abort,
>> +        .clean         = commit_clean
>>      },
>>  };
>>  
>> @@ -345,6 +352,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
>>      if (ret < 0) {
>>          goto fail;
>>      }
>> +    s->base_bs = base;
>>  
>>      /* Required permissions are already taken with block_job_add_bdrv() */
>>      s->top = blk_new(0, BLK_PERM_ALL);
>> -- 
>> 2.14.4
>>
