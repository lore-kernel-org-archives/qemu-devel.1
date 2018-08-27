Received: from eggs.gnu.org ([2001:4830:134:3::10]:53741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fuJxJ-0001g4-Lj
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 12:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fuJxE-0006n8-Ja
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 12:01:29 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-2-jsnow@redhat.com>
	<fd070439-3f9f-7c86-0466-49cd7aeab942@redhat.com>
	<e97c1bf4-9cbf-eb5a-7237-c83c534eb3b6@redhat.com>
	<208168ca-5e05-83b1-9531-a6ac77c80bae@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d5f3eda3-5eab-2e27-d55e-cda74d879fe7@redhat.com>
Date: Mon, 27 Aug 2018 12:01:02 -0400
MIME-Version: 1.0
In-Reply-To: <208168ca-5e05-83b1-9531-a6ac77c80bae@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/7] jobs: change start callback to run
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, kwolf@redhat.com, jtc@redhat.com



On 08/25/2018 09:33 AM, Max Reitz wrote:
> On 2018-08-23 01:01, John Snow wrote:
>>
>>
>> On 08/22/2018 06:51 AM, Max Reitz wrote:
>>> On 2018-08-17 21:04, John Snow wrote:
>>>> Presently we codify the entry point for a job as the "start" callback,
>>>> but a more apt name would be "run" to clarify the idea that when this
>>>> function returns we consider the job to have "finished," except for
>>>> any cleanup which occurs in separate callbacks later.
>>>>
>>>> As part of this clarification, change the signature to include an error
>>>> object and a return code. The error ptr is not yet used, and the return
>>>> code while captured, will be overwritten by actions in the job_completed
>>>> function.
>>>>
>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>> ---
>>>>  block/backup.c            |  7 ++++---
>>>>  block/commit.c            |  7 ++++---
>>>>  block/create.c            |  8 +++++---
>>>>  block/mirror.c            | 10 ++++++----
>>>>  block/stream.c            |  7 ++++---
>>>>  include/qemu/job.h        |  2 +-
>>>>  job.c                     |  6 +++---
>>>>  tests/test-bdrv-drain.c   |  7 ++++---
>>>>  tests/test-blockjob-txn.c | 16 ++++++++--------
>>>>  tests/test-blockjob.c     |  7 ++++---
>>>>  10 files changed, 43 insertions(+), 34 deletions(-)
>>>
>>> [...]
>>>
>>>> diff --git a/job.c b/job.c
>>>> index fa671b431a..898260b2b3 100644
>>>> --- a/job.c
>>>> +++ b/job.c
>>>> @@ -544,16 +544,16 @@ static void coroutine_fn job_co_entry(void *opaque)
>>>>  {
>>>>      Job *job = opaque;
>>>>  
>>>> -    assert(job && job->driver && job->driver->start);
>>>> +    assert(job && job->driver && job->driver->run);
>>>>      job_pause_point(job);
>>>> -    job->driver->start(job);
>>>> +    job->ret = job->driver->run(job, NULL);
>>>>  }
>>>
>>> Hmmm, this breaks the iff relationship with job->error.  We might call
>>> job_update_rc() afterwards, but then job_completed() would need to free
>>> it if it overwrites it with the error description from a potential error
>>> object.
>>>
>>> Also, I suspect the following patches might fix the relationship anyway?
>>>  (But then an "XXX: This does not hold right now, but will be fixed in a
>>> future patch" in the documentation of Job.error might help.)
>>>
>>> Max
>>>
>>
>> Hmm... does it? ... I guess you mean that we are setting job->ret
>> earlier than we used to, which gives us a window where you can have ret
>> set, but error unset.
>>
>> This will get settled out by the end of the series anyway:
> 
> Oh no, it appears I accidentally removed yet another chunk from my reply
> to patch 2...
> 
>> - char *error gets replaced with Error *err,
> 
> Which is basically the same.  I noted in the deleted chunk that patch 2
> just removes the iff relationship from the describing comment, but, well...
> 
>> - I remove the error object from job_completed
>> - v2 will remove the ret argument, too.
> 
> The most important bit of the chunk I removed was that I was complaining
> about Job.ret still being there.  I don't really see the point of this
> patch here at this point.
> 
> Unfortunately I can't quite recall...
> 
> Having a central Error object doesn't really make sense.  Whenever the
> block job wants to return an error, it should probably do so as "return"
> values of methods (like .run()).  Same for ret, of course.
> 
> I understand that this is probably really only possible after v2 when
> you've made more use of abort/commit.  But still, I don't think this
> patch improves anything, so I would leave this clean-up until later when
> you can really do something.
> 
> I suppose the idea here is that you want to drop the errp parameter from
> job_completed(), because it is not going to be called by .exit().  But
> the obvious way around this would be to pass an errp to .exit() and then
> pass the result on to job_completed().
> 
> Max
> 

That might be a good idea, but I need to look at the pathway for
actually showing that error to the user, since we need to pass it down a
few times anyway. It's certainly simpler to just stash it in the object.

I'll take a look.
