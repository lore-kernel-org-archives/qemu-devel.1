Received: from eggs.gnu.org ([2001:4830:134:3::10]:59332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fnOwC-00020h-Sb
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 09:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fnOwB-0001P4-Mn
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 09:55:44 -0400
References: <20180807043349.27196-1-jsnow@redhat.com>
	<20180807043349.27196-3-jsnow@redhat.com>
	<20180808040253.GE755222@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <d9dcee87-d879-166b-695f-c8eca203f6a3@redhat.com>
Date: Wed, 8 Aug 2018 09:55:34 -0400
MIME-Version: 1.0
In-Reply-To: <20180808040253.GE755222@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/21] jobs: add exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>



On 08/08/2018 12:02 AM, Jeff Cody wrote:
> On Tue, Aug 07, 2018 at 12:33:30AM -0400, John Snow wrote:
>> Most jobs do the same thing when they leave their running loop:
>> - Store the return code in a structure
>> - wait to receive this structure in the main thread
>> - signal job completion via job_completed
>>
>> More seriously, when we utilize job_defer_to_main_loop_bh to call
>> a function that calls job_completed, job_finalize_single will run
>> in a context where it has recursively taken the aio_context lock,
>> which can cause hangs if it puts down a reference that causes a flush.
>>
>> The job infrastructure is perfectly capable of registering job
>> completion itself when we leave the job's entry point. In this
>> context, we can signal job completion from outside of the aio_context,
>> which should allow for job cleanup code to run with only one lock.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
> 
> I like the simplification, both in SLOC and in exit logic (as seen in
> patches 3-7).
> 
>> ---
>>  include/qemu/job.h |  7 +++++++
>>  job.c              | 19 +++++++++++++++++++
>>  2 files changed, 26 insertions(+)
>>
>> diff --git a/include/qemu/job.h b/include/qemu/job.h
>> index 845ad00c03..0c24e8704f 100644
>> --- a/include/qemu/job.h
>> +++ b/include/qemu/job.h
>> @@ -204,6 +204,13 @@ struct JobDriver {
>>       */
>>      void (*drain)(Job *job);
>>  
>> +    /**
>> +     * If the callback is not NULL, exit will be invoked from the main thread
>> +     * when the job's coroutine has finished, but before transactional
>> +     * convergence; before @prepare or @abort.
>> +     */
>> +    void (*exit)(Job *job);
>> +
>>      /**
>>       * If the callback is not NULL, prepare will be invoked when all the jobs
>>       * belonging to the same transaction complete; or upon this job's completion
>> diff --git a/job.c b/job.c
>> index b281f30375..cc5ac9ac30 100644
>> --- a/job.c
>> +++ b/job.c
>> @@ -535,6 +535,19 @@ void job_drain(Job *job)
>>      }
>>  }
>>  
>> +static void job_exit(void *opaque)
>> +{
>> +    Job *job = (Job *)opaque;
>> +    AioContext *aio_context = job->aio_context;
>> +
>> +    if (job->driver->exit) {
>> +        aio_context_acquire(aio_context);
>> +        job->driver->exit(job);
>> +        aio_context_release(aio_context);
>> +    }
>> +    job_completed(job, job->ret);
>> +}
>> +
>>  /**
>>   * All jobs must allow a pause point before entering their job proper. This
>>   * ensures that jobs can be paused prior to being started, then resumed later.
>> @@ -546,6 +559,12 @@ static void coroutine_fn job_co_entry(void *opaque)
>>      assert(job && job->driver && job->driver->start);
>>      job_pause_point(job);
>>      job->driver->start(job);
> 
> One nit-picky observation here, that is unrelated to this patch: reading
> through, it may not be so obvious that 'start' is really a 'run' or
> 'execute', (linguistically, to me 'start' implies a kick-off rather than
> ongoing execution).
> 
> Just some bike-shedding again, though, and not even for this patch.  So
> nothing to do here :)
> 
> Reviewed-by: Jeff Cody <jcody@redhat.com>

I agree with you and thought the same as I was going through these
changes. I think with patch 12 in particular where I really solidify the
idea that this is the main execution loop for the coroutine makes it
obvious that it should be named .run or similar.

Also, while we're bikeshedding naming, it's weird that the flow here is:

.run/.start
.exit
.prepare
.commit
.abort
.clean

...I might want to emphasize a few points here:

(A) exit occurs prior to "finalization" and should not modify the graph
(B) "prepare" really means "prepare to finalize"

I just don't always have good terminology.

> 
> 
>> +    if (!job->deferred_to_main_loop) {
>> +        job->deferred_to_main_loop = true;
>> +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
>> +                                job_exit,
>> +                                job);
>> +    }
>>  }
>>  
>>  
>> -- 
>> 2.14.4
>>
> 
