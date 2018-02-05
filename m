Received: from eggs.gnu.org ([2001:4830:134:3::10]:44358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eimRu-00046R-CY
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eimRt-0004oM-4E
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:06 -0500
References: <153D07A7-F411-4EF4-A48D-D244621E97E9@gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <af357239-5670-fca5-d9ec-ee0a10f4e00e@redhat.com>
Date: Mon, 5 Feb 2018 14:28:55 -0500
MIME-Version: 1.0
In-Reply-To: <153D07A7-F411-4EF4-A48D-D244621E97E9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block/mirror: change the semantic of
 'force' of block-job-cancel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liang Li <liliang.opensource@gmail.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, eblake@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Liang Li <liliangleo@didichuxing.com>, Huaitong Han <huanhuaitong@didichuxing.com>



On 01/31/2018 09:19 PM, Liang Li wrote:
> On Tue, Jan 30, 2018 at 03:18:31PM -0500, John Snow wrote:
>>
>>
>> On 01/30/2018 03:38 AM, Liang Li wrote:
>>> When doing drive mirror to a low speed shared storage, if there was heavy
>>> BLK IO write workload in VM after the 'ready' event, drive mirror block job
>>> can't be canceled immediately, it would keep running until the heavy BLK IO
>>> workload stopped in the VM.
>>>
>>> Because libvirt depends on block-job-cancel for block live migration, the
>>> current block-job-cancel has the semantic to make sure data is in sync after
>>> the 'ready' event.  This semantic can't meet some requirement, for example,
>>> people may use drive mirror for realtime backup while need the ability of
>>> block live migration. If drive mirror can't not be cancelled immediately,
>>> it means block live migration need to wait, because libvirt make use drive
>>> mirror to implement block live migration and only one drive mirror block
>>> job is allowed at the same time for a give block dev.
>>>
>>> We need a new interface for 'force cancel', which could quit block job
>>> immediately if don't care about whether data is in sync or not.
>>>
>>> 'force' is not used by libvirt currently, to make things simple, change
>>> it's semantic slightly, hope it will not break some use case which need its
>>> original semantic.
>>>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Jeff Cody <jcody@redhat.com>
>>> Cc: Kevin Wolf <kwolf@redhat.com>
>>> Cc: Max Reitz <mreitz@redhat.com>
>>> Cc: Eric Blake <eblake@redhat.com>
>>> Cc: John Snow <jsnow@redhat.com>
>>> Reported-by: Huaitong Han <huanhuaitong@didichuxing.com>
>>> Signed-off-by: Huaitong Han <huanhuaitong@didichuxing.com>
>>> Signed-off-by: Liang Li <liliangleo@didichuxing.com>
>>> ---
>>> block/mirror.c            |  9 +++------
>>> blockdev.c                |  4 ++--
>>> blockjob.c                | 11 ++++++-----
>>> hmp-commands.hx           |  3 ++-
>>> include/block/blockjob.h  |  9 ++++++++-
>>> qapi/block-core.json      |  6 ++++--
>>> tests/test-blockjob-txn.c |  8 ++++----
>>> 7 files changed, 29 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/block/mirror.c b/block/mirror.c
>>> index c9badc1..c22dff9 100644
>>> --- a/block/mirror.c
>>> +++ b/block/mirror.c
>>> @@ -869,11 +869,8 @@ static void coroutine_fn mirror_run(void *opaque)
>>>
>>>         ret = 0;
>>>         trace_mirror_before_sleep(s, cnt, s->synced, delay_ns);
>>> -        if (!s->synced) {
>>> -            block_job_sleep_ns(&s->common, delay_ns);
>>> -            if (block_job_is_cancelled(&s->common)) {
>>> -                break;
>>> -            }
>>> +        if (block_job_is_cancelled(&s->common) && s->common.force) {
>>> +            break;
>>
>> what's the justification for removing the sleep in the case that
>> !s->synced && !block_job_is_cancelled(...) ?
>>
> if !block_job_is_cancelled() satisfied, the code in 'if (!should_complete) {}'
> will execute, there is a block_job_sleep_ns there.
> 
> block_job_sleep_ns is for rate throttling, if there is no more data to sync, 
> sleep is not needed, right?
> 
>>>         } else if (!should_complete) {
>>>             delay_ns = (s->in_flight == 0 && cnt == 0 ? SLICE_TIME : 0);
>>>             block_job_sleep_ns(&s->common, delay_ns);
>>> @@ -887,7 +884,7 @@ immediate_exit:
>>>          * or it was cancelled prematurely so that we do not guarantee that
>>>          * the target is a copy of the source.
>>>          */
>>> -        assert(ret < 0 || (!s->synced && block_job_is_cancelled(&s->common)));
>>> +        assert(ret < 0 || block_job_is_cancelled(&s->common));
>>
>> This assertion gets weaker in the case where force isn't provided, is
>> that desired?
>>
> yes. if force quit is used, the following condition can be true
> 
> (ret >= 0) && (s->synced) && (block_job_is_cancelled(&s->common)) 
> 
> so the above assert should be changed, or it will be failed.
> 

What I mean is that when we *don't* use force quit, the assertion here
is weakened. You can work the force conditional in here:

ret < 0 || (block_job_is_cancelled(job) && (job->force || !s->synced))

which preserves the stricter assertion when force isn't provided.

>>>         assert(need_drain);
>>>         mirror_wait_for_all_io(s);
>>>     }
>>> diff --git a/blockdev.c b/blockdev.c
>>> index 8e977ee..039f156 100644
>>> --- a/blockdev.c
>>> +++ b/blockdev.c
>>> @@ -145,7 +145,7 @@ void blockdev_mark_auto_del(BlockBackend *blk)
>>>         aio_context_acquire(aio_context);
>>>
>>>         if (bs->job) {
>>> -            block_job_cancel(bs->job);
>>> +            block_job_cancel(bs->job, false);
>>>         }
>>>
>>>         aio_context_release(aio_context);
>>> @@ -3802,7 +3802,7 @@ void qmp_block_job_cancel(const char *device,
>>>     }
>>>
>>>     trace_qmp_block_job_cancel(job);
>>> -    block_job_cancel(job);
>>> +    block_job_cancel(job, force);
>>> out:
>>>     aio_context_release(aio_context);
>>> }
>>> diff --git a/blockjob.c b/blockjob.c
>>> index f5cea84..0aacb50 100644
>>> --- a/blockjob.c
>>> +++ b/blockjob.c
>>> @@ -365,7 +365,7 @@ static void block_job_completed_single(BlockJob *job)
>>>     block_job_unref(job);
>>> }
>>>
>>> -static void block_job_cancel_async(BlockJob *job)
>>> +static void block_job_cancel_async(BlockJob *job, bool force)
>>> {
>>>     if (job->iostatus != BLOCK_DEVICE_IO_STATUS_OK) {
>>>         block_job_iostatus_reset(job);
>>> @@ -376,6 +376,7 @@ static void block_job_cancel_async(BlockJob *job)
>>>         job->pause_count--;
>>>     }
>>>     job->cancelled = true;
>>> +    job->force = force;
>>> }
>>>
>>
>> I suppose this is okay; we're setting a permanent property of the job as
>> part of a limited operation.
>>
>> Granted, the job should disappear afterwards, so it should never
>> conflict, but it made me wonder for a moment.
>>
>> What happens if we cancel with force = true and then immediately cancel
>> again with force = false? What happens? Can it cause issues?
>>
> 
> Indeed. It can be fixed by:
> 
> if (!job->force)
>    job->force = force
> 
> it's that ok ?
> 

I think so, yes. or job->force |= force, or your preferred equivalent
for only allowing false-->true here.

>>> static int block_job_finish_sync(BlockJob *job,
>>> @@ -437,7 +438,7 @@ static void block_job_completed_txn_abort(BlockJob *job)
>>>      * on the caller, so leave it. */
>>>     QLIST_FOREACH(other_job, &txn->jobs, txn_list) {
>>>         if (other_job != job) {
>>> -            block_job_cancel_async(other_job);
>>> +            block_job_cancel_async(other_job, true);
>>
>> What's the rationale for deciding that transactional cancellations are
>> always force=true?
>>
> 
> no particular reason, just try to speed up the abort process. :)
> 

I'd prefer we not change the semantics of how transactions fail without
a stronger justification than wanting to make it faster!

>> Granted, this doesn't matter currently because mirror isn't a
>> transactional job, but that makes the decision all the more curious.
>>
>>>         }
>>>     }
> 
> Thanks for your comments.
> 
> Liang
> 
