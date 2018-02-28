Received: from eggs.gnu.org ([2001:4830:134:3::10]:34476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1er7Mm-0000qu-Ey
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:26:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1er7Ml-0003hs-Fd
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:26:16 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-9-jsnow@redhat.com>
	<20180228145417.GB4855@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <d4742fe4-6fa0-0491-02f4-f0acddde7e79@redhat.com>
Date: Wed, 28 Feb 2018 14:26:00 -0500
MIME-Version: 1.0
In-Reply-To: <20180228145417.GB4855@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 08/21] blockjobs: add ABORTING state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org



On 02/28/2018 09:54 AM, Kevin Wolf wrote:
> Am 24.02.2018 um 00:51 hat John Snow geschrieben:
>> Add a new state ABORTING.
>>
>> This makes transitions from normative states to error states explicit
>> in the STM, and serves as a disambiguation for which states may complete
>> normally when normal end-states (CONCLUDED) are added in future commits.
>>
>> Notably, Paused/Standby jobs do not transition directly to aborting,
>> as they must wake up first and cooperate in their cancellation.
>>
>> Transitions:
>> Running -> Aborting: can be cancelled or encounter an error
>> Ready   -> Aborting: can be cancelled or encounter an error
>>
>> Verbs:
>> None. The job must finish cleaning itself up and report its final status.
>>
>>              +---------+
>>              |UNDEFINED|
>>              +--+------+
>>                 |
>>              +--v----+
>>              |CREATED|
>>              +--+----+
>>                 |
>>              +--v----+     +------+
>>    +---------+RUNNING<----->PAUSED|
>>    |         +--+----+     +------+
>>    |            |
>>    |         +--v--+       +-------+
>>    +---------+READY<------->STANDBY|
>>    |         +-----+       +-------+
>>    |
>> +--v-----+
>> |ABORTING|
>> +--------+
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
> 
>> @@ -383,6 +384,10 @@ static void block_job_completed_single(BlockJob *job)
>>  {
>>      assert(job->completed);
>>  
>> +    if (job->ret || block_job_is_cancelled(job)) {
>> +        block_job_state_transition(job, BLOCK_JOB_STATUS_ABORTING);
>> +    }
>> +
>>      if (!job->ret) {
>>          if (job->driver->commit) {
>>              job->driver->commit(job);
> 
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> 
> But I do have a question about the code below the new lines: I wonder
> where job->ret is set to an error value? I can clearly see that the job
> is marked as cancelled, so your added code should be working, but
> looking at the block job code, it looks to me as if the jobs were
> completing with job->cancelled = true and job->ret = 0.
> 
> For block_job_completed_single(), this means that we would call the
> .commit callback and .cb with a success return code, while sending a
> CANCELLED event on QMP.
> 
> Of course, the only job type that supports transactions is the backup
> job, and that one seems to compensate for this by explicitly checking
> block_job_is_cancelled() in its .commit implementation, but is that
> really how things should be working?
> 
> Kevin
> 

You re-discovered the same nonsensical thing that I discovered, which
led to patch 12.
