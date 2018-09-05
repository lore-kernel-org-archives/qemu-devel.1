Received: from eggs.gnu.org ([2001:4830:134:3::10]:47997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fxdEG-0005HJ-QN
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 15:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fxd7h-000489-CI
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 15:05:54 -0400
References: <20180904170930.28619-1-jsnow@redhat.com>
	<20180904170930.28619-5-jsnow@redhat.com>
	<20180904184620.GI415265@localhost.localdomain>
	<63e2cd53-a4cb-3ed7-ae70-f49b4e11fad5@redhat.com>
	<57dc1c6c-29bd-f134-646f-15139df7f4f4@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d774e078-de1c-a1e8-621a-436cb022860c@redhat.com>
Date: Wed, 5 Sep 2018 15:05:45 -0400
MIME-Version: 1.0
In-Reply-To: <57dc1c6c-29bd-f134-646f-15139df7f4f4@redhat.com>
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
To: Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>



On 09/05/2018 06:27 AM, Max Reitz wrote:
> On 2018-09-04 22:32, John Snow wrote:
>>
>>
>> On 09/04/2018 02:46 PM, Jeff Cody wrote:
>>> On Tue, Sep 04, 2018 at 01:09:19PM -0400, John Snow wrote:
>>>> Use the component callbacks; prepare, abort, and clean.
>>>>
>>>> NB: prepare is only called when the job has not yet failed;
>>>> and abort can be called after prepare.
>>>>
>>>> complete -> prepare -> abort -> clean
>>>> complete -> abort -> clean
>>>>
>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>  block/commit.c | 90 ++++++++++++++++++++++++++++++++--------------------------
>>>>  1 file changed, 49 insertions(+), 41 deletions(-)
>>>>
>>>> diff --git a/block/commit.c b/block/commit.c
>>>> index b6e8969877..eb3941e545 100644
>>>> --- a/block/commit.c
>>>> +++ b/block/commit.c
>>>> @@ -36,6 +36,7 @@ typedef struct CommitBlockJob {
>>>>      BlockDriverState *commit_top_bs;
>>>>      BlockBackend *top;
>>>>      BlockBackend *base;
>>>> +    BlockDriverState *base_bs;
>>>>      BlockdevOnError on_error;
>>>>      int base_flags;
>>>>      char *backing_file_str;
>>>> @@ -68,61 +69,65 @@ static int coroutine_fn commit_populate(BlockBackend *bs, BlockBackend *base,
>>>>      return 0;
>>>>  }
>>>>  
>>>> -static void commit_exit(Job *job)
>>>> +static int commit_prepare(Job *job)
>>>>  {
>>>>      CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
>>>> -    BlockJob *bjob = &s->common;
>>>> -    BlockDriverState *top = blk_bs(s->top);
>>>> -    BlockDriverState *base = blk_bs(s->base);
>>>> -    BlockDriverState *commit_top_bs = s->commit_top_bs;
>>>> -    bool remove_commit_top_bs = false;
>>>> -
>>>> -    /* Make sure commit_top_bs and top stay around until bdrv_replace_node() */
>>>> -    bdrv_ref(top);
>>>> -    bdrv_ref(commit_top_bs);
>>>>  
>>>>      /* Remove base node parent that still uses BLK_PERM_WRITE/RESIZE before
>>>>       * the normal backing chain can be restored. */
>>>>      blk_unref(s->base);
>>>> +    s->base = NULL;
>>>>  
>>>> -    if (!job_is_cancelled(job) && job->ret == 0) {
>>>> -        /* success */
>>>> -        job->ret = bdrv_drop_intermediate(s->commit_top_bs, base,
>>>> -                                          s->backing_file_str);
>>>> -    } else {
>>>> -        /* XXX Can (or should) we somehow keep 'consistent read' blocked even
>>>> -         * after the failed/cancelled commit job is gone? If we already wrote
>>>> -         * something to base, the intermediate images aren't valid any more. */
>>>> -        remove_commit_top_bs = true;
>>>> +    return bdrv_drop_intermediate(s->commit_top_bs, s->base_bs,
>>>> +                                  s->backing_file_str);
>>>> +}
>>>
>>> If we can go from prepare->abort->clean, then that means to me that every
>>> failure case of .prepare() can be resolved without permanent changes / data
>>> loss.  Is this necessarily the case?
>>>
>>
>> That'd be a requisite to make the job a transaction, but commit, mirror
>> and stream are not currently transactionable.
> 
> Is that already documented anywhere?
> 

Hm, no, not really.

I'm most inclined to document it near the action table because it would
be hard to miss if you went to add it.

I'll add this in an extra patch at the end in case you want to debate
the wording and/or location.

> (Otherwise I'd be afraid of us forgetting in like a year, asking "Why
> isn't this a transaction already?", just making it one, and then
> remembering half a year later.)
> 

No, it's a good point.

>> The way commit already works, for example, can leave the base and
>> intermediate images as unusable as standalone images. This refactoring
>> will not change that alone.
>>
>> So it's not necessarily a problem, but it's something that would need to
>> be fixed if we ever wanted transaction support.
>>
>> However, in talking on IRC we did realize that this patch does change
>> behavior...
>>
>> Before:
>>
>> If bdrv_drop_intermediate fails, we store the retcode but continue
>> cleaning up as if it didn't fail. i.e., we don't remove the commit job's
>> installed top_bs node.
>>
>> After:
>>
>> if bdrv_drop_intermediate fails, we return the failure retcode and
>> .abort gets called as a result, i.e. we will remove the commit job's
>> installed top_bs node in favor of the original top_bs node.
>>
>> I think this behavior is an improvement,
> 
> I agree.
> 

Based on this I will leave the stickier fix to a future patch... I will
add a FIXME note detailing the shortfall in this patch, but I am
asserting that the current behavior is /not worse/ than the old
behavior, while there is still a bug that we might need to fix in the
future.

>> however it raises a question
>> about the nature of failures in bdrv_drop_intermediate.
>>
>> If this function fails without making any changes, the new commit
>> behavior is good. If it succeeds, we're also good. The problem is with
>> intermediate or partial successes.
>>
>> If top has multiple parents (I think under normal circumstances it
>> won't, but I'm not absolutely sure) and it fails to update their backing
>> file references, it might partially succeed.
>>
>> I think commit's usage here is correct, but I think we might need to
>> update bdrv_drop_intermediate to make it roll back changes if it
>> experiences a partial failure to give all-or-nothing semantics.
> 
> Sure, that would be good.
> 
>> Thoughts?
> 
> We could start by calling bdrv_check_update_perm() on all parents before
> doing any changes.  Then the roll back would consist only of invoking
> bdrv_abort_perm_update() and in theory reverting the
> c->update_filename() changes.
> 
> In practice...  How do we want to revert c->update_filename()?  There
> currently is no way of getting the old value.  (And just using the old
> child's filename may well be wrong, because the old child might not be
> the one referenced by the image header.)
> 
> I have three ideas:
> 1) We could introduce a way of getting the old filename the parent has,
> so we can restore it.
> 
> 2) We could make .update_filename() kind of transactionable (seems like
> overkill, but it would be easier in practice, I think).
> 
> 3) We basically ignore .update_filename() errors.  We'd still return
> them, but we don't abort the graph change operation.  So after
> bdrv_drop_intermediate() is done, the graph has been changed
> succesfully, or it hasn't changed at all -- whether the filename updates
> all went through, that's a different story.
> 
> #3 would be the simplest solution.  It's a bit stupid, but it would work
> for most problems, I think; at least the callers would know that the
> graph is in exactly one of two well-defined states.
> 
> Max
> 

I suppose another option would be to just update the function to return
which kind of error it had.

If it couldn't update *anything*, we can treat this as a hard failure.
If it managed to update *some things*, we can ignore the error for the
purposes of cleanup, but report the error. "Hey, something... happened.
The commit worked but the graph change failed. Please investigate."
And, of course, success is success.

I don't really need or want "transaction" semantics here, just the
ability to have well-defined ending states. The trinary outcome might be
enough -- it's perhaps not the end of the world to ask for manual
intervention after a failure. It seems conservatively the safest option.
