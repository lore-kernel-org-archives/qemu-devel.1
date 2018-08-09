Received: from eggs.gnu.org ([2001:4830:134:3::10]:48518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fnnhe-0007pk-32
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 12:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fnnhc-0000Wi-KQ
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 12:22:22 -0400
Date: Thu, 9 Aug 2018 18:22:06 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180809162206.GE4320@localhost.localdomain>
References: <20180807043349.27196-1-jsnow@redhat.com>
	<20180807043349.27196-17-jsnow@redhat.com>
	<20180809151242.GD4320@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809151242.GD4320@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 16/21] block/commit: refactor
 commit to use job callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, jtc@redhat.com, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Noticed one other thing...

Am 09.08.2018 um 17:12 hat Kevin Wolf geschrieben:
> Am 07.08.2018 um 06:33 hat John Snow geschrieben:
> > Use the component callbacks; prepare, commit, abort, and clean.
> > 
> > NB: prepare is only called when the job has not yet failed;
> > and abort can be called after prepare.
> > 
> > complete -> prepare -> abort -> clean
> > complete -> abort -> clean
> 
> I always found this confusing. After converting all jobs to use the
> infrastructure, do you think that this design is helpful? You seem to be
> calling *_common function from commit and abort, with an almost empty
> prepare, which looks like a hint that maybe we should reorganise things.
> 
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  block/commit.c | 94 +++++++++++++++++++++++++++++++++++++---------------------
> >  1 file changed, 61 insertions(+), 33 deletions(-)
> > 
> > diff --git a/block/commit.c b/block/commit.c
> > index 1a4a56795f..6673a0544e 100644
> > --- a/block/commit.c
> > +++ b/block/commit.c
> > @@ -35,7 +35,9 @@ typedef struct CommitBlockJob {
> >      BlockJob common;
> >      BlockDriverState *commit_top_bs;
> >      BlockBackend *top;
> > +    BlockDriverState *top_bs;
> >      BlockBackend *base;
> > +    BlockDriverState *base_bs;
> >      BlockdevOnError on_error;
> >      int base_flags;
> >      char *backing_file_str;
> 
> More state. :-(
> 
> Can we at least move the new fields to the end of the struct with a
> comment that they are only valid after .exit()?
> 
> > @@ -71,37 +73,37 @@ static int coroutine_fn commit_populate(BlockBackend *bs, BlockBackend *base,
> >  static void commit_exit(Job *job)
> >  {
> >      CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
> > -    BlockJob *bjob = &s->common;
> > -    BlockDriverState *top = blk_bs(s->top);
> > -    BlockDriverState *base = blk_bs(s->base);
> > -    BlockDriverState *commit_top_bs = s->commit_top_bs;
> > -    int ret = job->ret;
> > -    bool remove_commit_top_bs = false;
> > +
> > +    s->top_bs = blk_bs(s->top);
> > +    s->base_bs = blk_bs(s->base);
> >  
> >      /* Make sure commit_top_bs and top stay around until bdrv_replace_node() */
> > -    bdrv_ref(top);
> > -    bdrv_ref(commit_top_bs);
> > +    bdrv_ref(s->top_bs);
> > +    bdrv_ref(s->commit_top_bs);
> > +}

These bdrv_refs() protect against nodes going away...

> > -    /* Remove base node parent that still uses BLK_PERM_WRITE/RESIZE before
> > -     * the normal backing chain can be restored. */
> > -    blk_unref(s->base);
> > +static int commit_prepare(Job *job)
> > +{
> > +    CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
> >  
> > -    if (!job_is_cancelled(job) && ret == 0) {
> > -        /* success */
> > -        ret = bdrv_drop_intermediate(s->commit_top_bs, base,
> > -                                     s->backing_file_str);
> > -    } else {
> > -        /* XXX Can (or should) we somehow keep 'consistent read' blocked even
> > -         * after the failed/cancelled commit job is gone? If we already wrote
> > -         * something to base, the intermediate images aren't valid any more. */
> > -        remove_commit_top_bs = true;
> > -    }
> > +     /* Remove base node parent that still uses BLK_PERM_WRITE/RESIZE before
> > +      * the normal backing chain can be restored. */
> > +     blk_unref(s->base);
> > +     s->base = NULL;
> > +
> > +     return bdrv_drop_intermediate(s->commit_top_bs, s->base_bs,
> > +                                   s->backing_file_str);
> 
> The indentation is off here (which is weird because the additional space
> seems to be the only change to most of the lines).
> 
> > +}
> > +
> > +static void commit_exit_common(Job *job)
> > +{
> > +    CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
> >  
> >      /* restore base open flags here if appropriate (e.g., change the base back
> >       * to r/o). These reopens do not need to be atomic, since we won't abort
> >       * even on failure here */
> > -    if (s->base_flags != bdrv_get_flags(base)) {
> > -        bdrv_reopen(base, s->base_flags, NULL);
> > +    if (s->base_flags != bdrv_get_flags(s->base_bs)) {
> > +        bdrv_reopen(s->base_bs, s->base_flags, NULL);
> >      }
> >      g_free(s->backing_file_str);
> >      blk_unref(s->top);
> 
> Feels like general cleanup, so intuitively, I'd expect this in .clean.
> The only thing that could make this impossible is the ordering.
> 
> bdrv_reopen() of s->base_bs should be safe to be deferred, the node
> is still referenced after the job is concluded and we don't rely on it
> being read-only again in any of the following completion code.
> 
> g_free() is safe to be moved anyway.
> 
> blk_unref(s->top) doesn't change the graph because we did a
> bdrv_ref(s->top_bs). The permissions of the BlockBackend could still be
> a problem. However, it doesn't take any permissions:
> 
>     s->top = blk_new(0, BLK_PERM_ALL);
> 
> So I think moving this first part of commit_exit_common() to .clean
> should be safe.
> 
> > @@ -110,21 +112,43 @@ static void commit_exit(Job *job)
> >       * job_finish_sync()), job_completed() won't free it and therefore the
> >       * blockers on the intermediate nodes remain. This would cause
> >       * bdrv_set_backing_hd() to fail. */
> > -    block_job_remove_all_bdrv(bjob);
> > +    block_job_remove_all_bdrv(&s->common);

...during block_job_remove_all_bdrv(), I think. Before we do this, we
have a reference to each node in the subchain anyway.

> There hasn't been any bdrv_set_backing_hd() close to this comment for a
> while. Might be time to update it.
> 
> I suppose the update would refer to bdrv_replace_node(), which only
> happens in .abort, so should block_job_remove_all_bdrv() move, too?
> 
> With these changes, commit_exit_common() would be gone.

So if we move block_job_remove_all_bdrv() to .abort, the bdrv_ref()
could become local to .abort as well. This wouldn't only get us rid of
the additional state in CommitBlockJob, but in fact it would make .exit
empty.

And as it happens, commit is the only job that still has an .exit after
this series, so the callback can go away altogether. Which poses the
question whether it's really worth introducing it in the first place.
Does it simplify the conversion much?

But anyway, introducing it just for a short time and removing it again
in the same series would be okay with me, too, if it makes your life any
easier.

Kevin

> > +}
> > +
> > +static void commit_commit(Job *job)
> > +{
> > +    commit_exit_common(job);
> > +}
> 
> (I think I've answered this question now, by effectively proposing to do
> away with .commit, but I'll leave it there anyway.)
> 
> Is there any reason for the split between .prepare and .commit as it is
> or is this mostly arbitrary? Probably the latter because commit isn't
> even transactionable?
> 
> > +static void commit_abort(Job *job)
> > +{
> > +    CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
> > +
> > +    if (s->base) {
> > +        blk_unref(s->base);
> > +    }
> > +
> > +    commit_exit_common(job);
> > +
> > +    /* XXX Can (or should) we somehow keep 'consistent read' blocked even
> > +     * after the failed/cancelled commit job is gone? If we already wrote
> > +     * something to base, the intermediate images aren't valid any more. */
> >  
> >      /* If bdrv_drop_intermediate() didn't already do that, remove the commit
> >       * filter driver from the backing chain. Do this as the final step so that
> >       * the 'consistent read' permission can be granted.  */
> > -    if (remove_commit_top_bs) {
> > -        bdrv_child_try_set_perm(commit_top_bs->backing, 0, BLK_PERM_ALL,
> > -                                &error_abort);
> > -        bdrv_replace_node(commit_top_bs, backing_bs(commit_top_bs),
> > -                          &error_abort);
> > -    }
> > +    bdrv_child_try_set_perm(s->commit_top_bs->backing, 0, BLK_PERM_ALL,
> > +                            &error_abort);
> > +    bdrv_replace_node(s->commit_top_bs, backing_bs(s->commit_top_bs),
> > +                      &error_abort);
> > +}
> >  
> > -    bdrv_unref(commit_top_bs);
> > -    bdrv_unref(top);
> > -    job->ret = ret;
> > +static void commit_clean(Job *job)
> > +{
> > +    CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
> > +
> > +    bdrv_unref(s->commit_top_bs);
> > +    bdrv_unref(s->top_bs);
> >  }
> >  
> >  static int coroutine_fn commit_run(Job *job)
> > @@ -214,6 +238,10 @@ static const BlockJobDriver commit_job_driver = {
> >          .drain         = block_job_drain,
> >          .start         = commit_run,
> >          .exit          = commit_exit,
> > +        .prepare       = commit_prepare,
> > +        .commit        = commit_commit,
> > +        .abort         = commit_abort,
> > +        .clean         = commit_clean
> >      },
> >  };
> 
> Kevin
> 
