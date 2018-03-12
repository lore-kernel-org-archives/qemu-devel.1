Received: from eggs.gnu.org ([2001:4830:134:3::10]:36580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1evQEY-0006cV-Gn
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:23:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1evQEX-0001Vc-4G
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:23:34 -0400
References: <20180310082746.24198-1-jsnow@redhat.com>
	<20180310082746.24198-11-jsnow@redhat.com>
	<20180312152835.GF31537@localhost.localdomain>
	<07da6f60-4ef4-7d0e-b81c-c18fce085764@redhat.com>
	<20180312160706.GG31537@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <2daecd20-40c5-ad9b-ad5d-4fb1f5d4bc28@redhat.com>
Date: Mon, 12 Mar 2018 12:23:23 -0400
MIME-Version: 1.0
In-Reply-To: <20180312160706.GG31537@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 10/21] blockjobs: add NULL state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org



On 03/12/2018 12:07 PM, Kevin Wolf wrote:
> Am 12.03.2018 um 16:41 hat John Snow geschrieben:
>> On 03/12/2018 11:28 AM, Kevin Wolf wrote:
>>> Am 10.03.2018 um 09:27 hat John Snow geschrieben:
>>>> Add a new state that specifically demarcates when we begin to permanently
>>>> demolish a job after it has performed all work. This makes the transition
>>>> explicit in the STM table and highlights conditions under which a job may
>>>> be demolished.
>>>>
>>>> Alongside this state, add a new helper command "block_job_decommission",
>>>> which transitions to the NULL state and puts down our implicit reference.
>>>> This separates instances in the code for "block_job_unref" which merely
>>>> undo a matching "block_job_ref" with instances intended to initiate the
>>>> full destruction of the object.
>>>>
>>>> This decommission action also sets a number of fields to make sure that
>>>> block internals or external users that are holding a reference to a job
>>>> to see when it "finishes" are convinced that the job object is "done."
>>>> This is necessary, for instance, to do a block_job_cancel_sync on a
>>>> created object which will not make any progress.
>>>>
>>>> Now, all jobs must go through block_job_decommission prior to being
>>>> freed, giving us start-to-finish state machine coverage for jobs.
>>>>
>>>>
>>>> Transitions:
>>>> Created   -> Null: Early failure event before the job is started
>>>> Concluded -> Null: Standard transition.
>>>>
>>>> Verbs:
>>>> None. This should not ever be visible to the monitor.
>>>>
>>>>              +---------+
>>>>              |UNDEFINED|
>>>>              +--+------+
>>>>                 |
>>>>              +--v----+
>>>>    +---------+CREATED+------------------+
>>>>    |         +--+----+                  |
>>>>    |            |                       |
>>>>    |         +--v----+     +------+     |
>>>>    +---------+RUNNING<----->PAUSED|     |
>>>>    |         +--+-+--+     +------+     |
>>>>    |            | |                     |
>>>>    |            | +------------------+  |
>>>>    |            |                    |  |
>>>>    |         +--v--+       +-------+ |  |
>>>>    +---------+READY<------->STANDBY| |  |
>>>>    |         +--+--+       +-------+ |  |
>>>>    |            |                    |  |
>>>> +--v-----+   +--v------+             |  |
>>>> |ABORTING+--->CONCLUDED<-------------+  |
>>>> +--------+   +--+------+                |
>>>>                 |                       |
>>>>              +--v-+                     |
>>>>              |NULL<---------------------+
>>>>              +----+
>>>>
>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>
>>>> +static void block_job_decommission(BlockJob *job)
>>>> +{
>>>> +    assert(job);
>>>> +    job->completed = true;
>>>> +    job->busy = false;
>>>> +    job->paused = false;
>>>> +    job->deferred_to_main_loop = true;
>>>
>>> Why do we set all of these fields now? I don't see the use of it, and
>>> overwriting fields here potentially makes debugging harder.
>>>
>>> Especially for deferred_to_main_loop I might expect an assert() that it
>>> already is true, but shouldn't setting it always be done while actually
>>> deferring to the main loop?
>>>
>>> Can we turn all of these assignments into asserts or are there some that
>>> actually aren't already guaranteed, but that we want anyway?
>>>
>>>> +    block_job_state_transition(job, BLOCK_JOB_STATUS_NULL);
>>>> +    block_job_unref(job);
>>>> +}
>>>
>>> Kevin
>>>
>>
>> Gonna be real honest; we probably only need to set maybe one field
>> (job->completed = true) but it was late and I started hitting things
>> with big hammers.
>>
>> The problem is that if jobs do not look "done" to functions like
>> finish_sync, they will loop forever trying to make progress on a job
>> that doesn't do anything.
>>
>> I set a bunch of fields here more as a semantic statement than a
>> necessity, to be really really honest. ("Well, the job definitely has
>> these properties if it made it here, so let's update these fields to be
>> correct and the rest of the code will hopefully Do The Right Thing.")
> 
> So essentially, we want this to be assert(), but currently that breaks
> for some reasons and we can't figure out why before the freeze?
> 

Nah, I knew exactly why it broke.

> I guess that's fair enough, but then it would be good to use the freeze
> period to find the offenders and actually turn it into assertions.
> 
> Kevin
> 

I appear to be horridly confused, and you haven't seen the intermediate
mess that caused my confusion. A veritable maelstrom of confusion. Mr
Babbage would not be able to rightly comprehend, &c.

Let's give this another shot.

I added that code at a time when my local branch was not calling
block_job_completed, because I declared in v4's STM that a pre-created
job "shall not pass go, and shall not collect $200" -- that CREATED jobs
should either go to RUNNING or NULL.

The discovery here is that directly decommissioning a created job
actually breaks finish_sync because it polls on the completed boolean,
which nothing ever sets. So, under the reasoning I gave you in my last
reply;

"I'm simply setting these booleans based on the facts of the state
machine at this point: we ARE completed, we AREN'T busy, we AREN'T
paused, and we have technically now deferred back to the main loop (we
never entered it.)"

this was enough for finish_sync to get out of the way, but there were
other problems with the approach -- a CREATED job has pre-2.12 called
the abort/commit callbacks, so I went back to the 2.11 style and added
the appropriate transition into the graph. I forgot to check if this
code was still necessary at that point.

So actually, as of right now, these lines in decommission are useless;
but they shouldn't be assertions ... they might fail in a few cases. for
instance, "deferred to main loop" won't be set when we cancel a CREATED job.
