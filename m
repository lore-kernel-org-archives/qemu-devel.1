Received: from eggs.gnu.org ([2001:4830:134:3::10]:45049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cwn6n-0007QD-Nj
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 05:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cwn6k-0003RO-LN
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 05:56:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cwn6k-0003RE-CL
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 05:56:38 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C1F52E6044
	for <qemu-devel@nongnu.org>; Sat,  8 Apr 2017 09:56:37 +0000 (UTC)
References: <20170323173928.14439-1-pbonzini@redhat.com>
	<20170323173928.14439-11-pbonzini@redhat.com>
	<04b67e67-6b27-e5d0-5fbd-38ec98d57b44@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fb2a74c0-735b-f96e-8333-6985dd60d900@redhat.com>
Date: Sat, 8 Apr 2017 17:56:32 +0800
MIME-Version: 1.0
In-Reply-To: <04b67e67-6b27-e5d0-5fbd-38ec98d57b44@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/10] blockjob: use deferred_to_main_loop
 to indicate the coroutine has ended
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: jcody@redhat.com



On 08/04/2017 09:32, John Snow wrote:
> 
> 
> On 03/23/2017 01:39 PM, Paolo Bonzini wrote:
>> All block jobs are using block_job_defer_to_main_loop as the final
>> step just before the coroutine terminates.  At this point,
>> block_job_enter should do nothing, but currently it restarts
>> the freed coroutine.
>>
>> Now, the job->co states should probably be changed to an enum
>> (e.g. BEFORE_START, STARTED, YIELDED, COMPLETED) subsuming
> 
> Yes, I'd love to formalize the FSM for jobs.
> 
>> block_job_started, job->deferred_to_main_loop and job->busy.
>> For now, this patch eliminates the problematic reenter by
>> removing the reset of job->deferred_to_main_loop (which served
>> no purpose, as far as I could see) and checking the flag in
>> block_job_enter.
> 
> Not sure -- the original commit 794f01414 makes it seem like it should
> stay so that the correct AIO context can be acquired. Probably a race as
> jobs don't often stay long once they've deferred to the main loop, but I
> think the reset is harmless as you say.

You're right.  The difference is that now we pretty much expect the
deferred part to be at the end of the job:

    commit bae8196d9f97916de6323e70e3e374362ee16ec4
    Author: Paolo Bonzini <pbonzini@redhat.com>
    Date:   Thu Oct 27 12:48:50 2016 +0200

    blockjob: introduce .drain callback for jobs

    This is required to decouple block jobs from running in an
    AioContext.  With multiqueue block devices, a BlockDriverState
    does not really belong to a single AioContext.

    The solution is to first wait until all I/O operations are
    complete; then loop in the main thread for the block job to
    complete entirely.

so I'll improve the commit message to point to both 794f01414 and this one.

Paolo
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  blockjob.c                   | 10 ++++++++--
>>  include/block/blockjob_int.h |  3 ++-
>>  2 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/blockjob.c b/blockjob.c
>> index 3fa2885..2d80dae 100644
>> --- a/blockjob.c
>> +++ b/blockjob.c
>> @@ -750,7 +750,14 @@ void block_job_resume_all(void)
>>  
>>  void block_job_enter(BlockJob *job)
>>  {
>> -    if (job->co && !job->busy) {
>> +    if (!block_job_started(job)) {
>> +        return;
>> +    }
>> +    if (job->deferred_to_main_loop) {
>> +        return;
>> +    }
>> +
>> +    if (!job->busy) {
>>          qemu_coroutine_enter(job->co);
>>      }
>>  }
>> @@ -874,7 +881,6 @@ static void block_job_defer_to_main_loop_bh(void *opaque)
>>          aio_context_acquire(aio_context);
>>      }
>>  
>> -    data->job->deferred_to_main_loop = false;
>>      data->fn(data->job, data->opaque);
>>  
>>      if (aio_context != data->aio_context) {
>> diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
>> index 97ffc43..4d287ba 100644
>> --- a/include/block/blockjob_int.h
>> +++ b/include/block/blockjob_int.h
>> @@ -227,7 +227,8 @@ typedef void BlockJobDeferToMainLoopFn(BlockJob *job, void *opaque);
>>   * @fn: The function to run in the main loop
>>   * @opaque: The opaque value that is passed to @fn
>>   *
>> - * Execute a given function in the main loop with the BlockDriverState
>> + * This function must be called by the main job coroutine just before it
>> + * returns.  @fn is executed in the main loop with the BlockDriverState
>>   * AioContext acquired.  Block jobs must call bdrv_unref(), bdrv_close(), and
>>   * anything that uses bdrv_drain_all() in the main loop.
>>   *
>>
> 
> Reviewed-by: John Snow <jsnow@redhat.com>
> 
