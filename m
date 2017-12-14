Received: from eggs.gnu.org ([2001:4830:134:3::10]:46110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ePW2U-0006cb-P6
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:07:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ePW2T-00013J-AL
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:07:14 -0500
References: <20171214005953.8898-1-jsnow@redhat.com>
	<20171214005953.8898-5-jsnow@redhat.com>
	<0ac30feb-553b-cfa3-070a-0f703c4e0f10@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <1b7494a6-aca5-41e8-469b-e2b9d8aade67@redhat.com>
Date: Thu, 14 Dec 2017 11:06:53 -0500
MIME-Version: 1.0
In-Reply-To: <0ac30feb-553b-cfa3-070a-0f703c4e0f10@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/7] blockjob: allow block_job_throttle to
 take delay_ns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com



On 12/14/2017 03:49 AM, Paolo Bonzini wrote:
> On 14/12/2017 01:59, John Snow wrote:
>> Instead of only sleeping for 0ms when we've hit a timeout, optionally
>> take a longer more explicit delay_ns that always forces the sleep.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  block/mirror.c               |  4 ++--
>>  blockjob.c                   |  9 ++++-----
>>  include/block/blockjob_int.h | 10 +++++++---
>>  3 files changed, 13 insertions(+), 10 deletions(-)
>>
>> diff --git a/block/mirror.c b/block/mirror.c
>> index 60b52cfb19..81450e6ac4 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -610,7 +610,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
>>              int bytes = MIN(s->bdev_length - offset,
>>                              QEMU_ALIGN_DOWN(INT_MAX, s->granularity));
>>  
>> -            block_job_throttle(&s->common);
>> +            block_job_throttle(&s->common, 0);
>>  
>>              if (block_job_is_cancelled(&s->common)) {
>>                  s->initial_zeroing_ongoing = false;
>> @@ -638,7 +638,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
>>          int bytes = MIN(s->bdev_length - offset,
>>                          QEMU_ALIGN_DOWN(INT_MAX, s->granularity));
>>  
>> -        block_job_throttle(&s->common);
>> +        block_job_throttle(&s->common, 0);
>>  
>>          if (block_job_is_cancelled(&s->common)) {
>>              return 0;
>> diff --git a/blockjob.c b/blockjob.c
>> index 8d0c89a813..b0868c3ed5 100644
>> --- a/blockjob.c
>> +++ b/blockjob.c
>> @@ -882,12 +882,11 @@ void block_job_yield(BlockJob *job)
>>      block_job_pause_point(job);
>>  }
>>  
>> -void block_job_throttle(BlockJob *job)
>> +void block_job_throttle(BlockJob *job, int64_t delay_ns)
>>  {
>> -    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
>> -
>> -    if (now - job->last_yield_ns > SLICE_TIME) {
>> -        block_job_sleep_ns(job, 0);
>> +    if (delay_ns || (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - \
>> +                     job->last_yield_ns > SLICE_TIME)) {
>> +        block_job_sleep_ns(job, delay_ns);
>>      } else {
>>          block_job_pause_point(job);
>>      }
>> diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
>> index 1a771b1e2e..8faec3f5e0 100644
>> --- a/include/block/blockjob_int.h
>> +++ b/include/block/blockjob_int.h
>> @@ -160,11 +160,15 @@ void block_job_yield(BlockJob *job);
>>  /**
>>   * block_job_throttle:
>>   * @job: The job that calls the function.
>> + * @delay_ns: The amount of time to sleep for
>>   *
>> - * Yield if it has been SLICE_TIME nanoseconds since the last yield.
>> - * Otherwise, check if we need to pause (and update the yield counter).
> 
> Okay, the yield counter goes away. :)
> 

Yeah, I guess I wrote the documentation twice and in one that phrase
lost out. Not any conscious decision, actually ... see my reply to your
earlier question.

>> + * Sleep for delay_ns nanoseconds.
>> + *
>> + * If delay_ns is 0, yield if it has been SLICE_TIME
>> + * nanoseconds since the last yield. Otherwise, check
>> + * if we need to yield for a pause event.
> 
> There are two meanings of yield here; one is just letting other events
> run, the other is forever.  Can we rephrase it?  Perhaps, since the
> check for pauses always holds (either directly via
> block_job_pause_point, or via block_job_sleep_ns's call), something like:
> 
> 

Yes, I see what you mean. I was trying to avoid ambiguity over exactly
which primitive we were measuring and as "yield" was presently the most
primitive before we disappear into coroutines, I opted for that. I
didn't want other readers to confuse this with:

- Sleep: We also track indefinite yields, like with pauses or user
pauses. It's not just a counter to keep track of sleep_ns calls, for
instance.
- Pause: The counter keeps track of more than just pauses or user pauses.

Since everything boils down to do_yield calls, I opted for that one to
try to be explicit about what I'm tracking. I can see that it's also
silly because of course "block_job_yield" is also a call, and of course
we don't track JUST that, either...


>    /* Sleep for delay_ns nanoseconds, and check if the block jobs
>     * was requested to pause.
>     *
>     * If delay_ns is 0, block_job_throttle will also yield momentarily
>     * if it has been SLICE_TIME nanoseconds since the last yield,
>     * letting the main loop run.
>     */
> 
> And another question.  After this series there is exactly one
> block_job_sleep_ns call (in block/mirror.c).  Perhaps instead of
> block_job_throttle, you should refine block_job_sleep_ns?
> 

Yeah, maybe? "A rose by any other name," though -- I think I might be
coming for the block/mirror call next because I have one more downstream
BZ that references this as a job that can cause the warning print.

So maybe we'll just have throttle calls instead of sleep calls from here
on out.

> There are also two remaining calls to block_job_pause_point outside
> block_job_throttle and block_job_sleep_ns (which however might be
> unified according to the previous point).  Perhaps they should become
> block_job_sleep_ns(job, 0), and block_job_pause_point can be made static?
> 
> Thanks,
> 
> Paolo
> 

Yeah, I am heading in that direction but couldn't prove to myself it was
safe yesterday; but unifying the way in which the jobs handle
cooperative scheduling is on the docket.

Of course, maybe this is just a small baby step towards unifying all the
jobs into one hideous super mega job, as per Kevin.

>> -void block_job_throttle(BlockJob *job);
>> +void block_job_throttle(BlockJob *job, int64_t delay_ns);
>>  
>>  /**
>>   * block_job_pause_all:
>>
> 
> 

Thanks,

John
