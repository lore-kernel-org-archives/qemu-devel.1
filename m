Received: from eggs.gnu.org ([2001:4830:134:3::10]:42274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fscL3-0005bA-Ry
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 19:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fsc8N-00044M-Iv
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 19:01:52 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-2-jsnow@redhat.com>
	<fd070439-3f9f-7c86-0466-49cd7aeab942@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e97c1bf4-9cbf-eb5a-7237-c83c534eb3b6@redhat.com>
Date: Wed, 22 Aug 2018 19:01:43 -0400
MIME-Version: 1.0
In-Reply-To: <fd070439-3f9f-7c86-0466-49cd7aeab942@redhat.com>
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



On 08/22/2018 06:51 AM, Max Reitz wrote:
> On 2018-08-17 21:04, John Snow wrote:
>> Presently we codify the entry point for a job as the "start" callback,
>> but a more apt name would be "run" to clarify the idea that when this
>> function returns we consider the job to have "finished," except for
>> any cleanup which occurs in separate callbacks later.
>>
>> As part of this clarification, change the signature to include an error
>> object and a return code. The error ptr is not yet used, and the return
>> code while captured, will be overwritten by actions in the job_completed
>> function.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  block/backup.c            |  7 ++++---
>>  block/commit.c            |  7 ++++---
>>  block/create.c            |  8 +++++---
>>  block/mirror.c            | 10 ++++++----
>>  block/stream.c            |  7 ++++---
>>  include/qemu/job.h        |  2 +-
>>  job.c                     |  6 +++---
>>  tests/test-bdrv-drain.c   |  7 ++++---
>>  tests/test-blockjob-txn.c | 16 ++++++++--------
>>  tests/test-blockjob.c     |  7 ++++---
>>  10 files changed, 43 insertions(+), 34 deletions(-)
> 
> [...]
> 
>> diff --git a/job.c b/job.c
>> index fa671b431a..898260b2b3 100644
>> --- a/job.c
>> +++ b/job.c
>> @@ -544,16 +544,16 @@ static void coroutine_fn job_co_entry(void *opaque)
>>  {
>>      Job *job = opaque;
>>  
>> -    assert(job && job->driver && job->driver->start);
>> +    assert(job && job->driver && job->driver->run);
>>      job_pause_point(job);
>> -    job->driver->start(job);
>> +    job->ret = job->driver->run(job, NULL);
>>  }
> 
> Hmmm, this breaks the iff relationship with job->error.  We might call
> job_update_rc() afterwards, but then job_completed() would need to free
> it if it overwrites it with the error description from a potential error
> object.
> 
> Also, I suspect the following patches might fix the relationship anyway?
>  (But then an "XXX: This does not hold right now, but will be fixed in a
> future patch" in the documentation of Job.error might help.)
> 
> Max
> 

Hmm... does it? ... I guess you mean that we are setting job->ret
earlier than we used to, which gives us a window where you can have ret
set, but error unset.

This will get settled out by the end of the series anyway:

- char *error gets replaced with Error *err,
- I remove the error object from job_completed
- v2 will remove the ret argument, too.

--js
