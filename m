Received: from eggs.gnu.org ([2001:4830:134:3::10]:48848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvAUG-0008DL-Pk
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 20:07:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvAUC-0000ri-7W
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 20:06:59 -0400
References: <20180823220856.10094-1-jsnow@redhat.com>
	<20180823220856.10094-2-jsnow@redhat.com>
	<86874359-e26c-4974-c2ec-bbc4e8ade264@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d9592097-39f1-86f3-7a34-cb82b3025147@redhat.com>
Date: Wed, 29 Aug 2018 20:06:22 -0400
MIME-Version: 1.0
In-Reply-To: <86874359-e26c-4974-c2ec-bbc4e8ade264@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/9] jobs: change start callback to run
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
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, jtc@redhat.com, Jeff Cody <jcody@redhat.com>



On 08/27/2018 05:30 AM, Max Reitz wrote:
> On 2018-08-24 00:08, John Snow wrote:
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
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> 
> But I see a discrepancy in the upcoming s->ret <=> s->err relationship
> now.  And that is if .run() doesn't return an Error *...
> 
> That could be remedied immediately in job_co_entry(), though, either by
> calling job_update_rc(), or by inlining its "if (!job->err)" part.
> 
> Max
> 

Jobs currently exist in ... five-ish phases.

Phase 0: Not started. (Always UNDEFINED or CREATED.)
Phase 1: In the coroutine. (RUNNING, READY, STANDBY, PAUSED.)
Phase 2: Deferred to main, but job_completed not yet called. [Not
dignified with a formal status, but job->deferred_to_main_loop set.]
Phase 3: job_completed has been called. (ABORTING, WAITING, PENDING)
Phase 4: job_finalize_single has been called. (CONCLUDED, NULL)

Broadly, though, we separate these out into two main clusters:

(A): job_is_completed == FALSE; Phases 0, 1 and 2 above.
(B): job_is_completed == TRUE; Phases 3 and 4 above.

The ABORTING status as it exists now is a phase 3 status. It never gets
set before this call, so it is a reliable indicator of being in phase 3.

If I adjust the usage of job_update_rc like you asked in several
reviews, it changes it to being a status that can exist in either Phase
2 *or* 3, which complicates the code a bit as it requires an audit of
every caller to job_is_completed and replacing it with something more
appropriate. Worse, we have no way to identify phase 2 anymore without
adding a new status or a new boolean.

I think this is a change worth making, but I must beg to defer this
change for a later patchset for the time-being, and leave the
job_update_rc calls alone for the present patchset so I can focus on
more pressing matters.

It might be simplest to say that at CONCLUDED time, the "err iff ret"
relationship will be true but potentially not before then. I think this
is reasonable as the error code cannot be held to be final until, well,
the job has finished.

Thanks,
--js
