Received: from eggs.gnu.org ([2001:4830:134:3::10]:53437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fsb3q-00022f-3f
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 17:53:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fsb3p-0002SZ-2J
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 17:53:06 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-4-jsnow@redhat.com>
	<7c836fb4-c6f4-b590-11ef-6aadb8bc169a@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <b576a1a9-ac22-599f-665f-8559e8a9faf1@redhat.com>
Date: Wed, 22 Aug 2018 17:52:56 -0400
MIME-Version: 1.0
In-Reply-To: <7c836fb4-c6f4-b590-11ef-6aadb8bc169a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/7] jobs: add exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, jtc@redhat.com



On 08/22/2018 07:43 AM, Max Reitz wrote:
> On 2018-08-17 21:04, John Snow wrote:
>> All jobs do the same thing when they leave their running loop:
>> - Store the return code in a structure
>> - wait to receive this structure in the main thread
>> - signal job completion via job_completed
>>
>> Few jobs do anything beyond exactly this. Consolidate this exit
>> logic for a net reduction in SLOC.
>>
>> More seriously, when we utilize job_defer_to_main_loop_bh to call
>> a function that calls job_completed, job_finalize_single will run
>> in a context where it has recursively taken the aio_context lock,
>> which can cause hangs if it puts down a reference that causes a flush.
>>
>> You can observe this in practice by looking at mirror_exit's careful
>> placement of job_completed and bdrv_unref calls.
>>
>> If we centralize job exiting, we can signal job completion from outside
>> of the aio_context, which should allow for job cleanup code to run with
>> only one lock, which makes cleanup callbacks less tricky to write.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  include/qemu/job.h |  7 +++++++
>>  job.c              | 19 +++++++++++++++++++
>>  2 files changed, 26 insertions(+)
> 
> Currently all jobs do this, the question of course is why.  The answer
> is because they are block jobs that need to do some graph manipulation
> in the main thread, right?
> 

Yep.

> OK, that's reasonable enough, that sounds like even non-block jobs may
> need this (i.e. modify some global qemu state that you can only do in
> the main loop).  Interestingly, the create job only calls
> job_completed() of which it says nowhere that it needs to be executed in
> the main loop.
> 

Yeah, not all jobs will have anything meaningful to do in the main loop
context. This is one of them.

> ...on second thought, do we really want to execute job_complete() in the
> main loop?  First of all, all of the transactional functions will run in
> the main loop.  Which makes sense, but it isn't noted anywhere.
> Secondly, we may end up calling JobDriver.user_resume(), which is
> probably not something we want to call in the main loop.
> 

I think we need to execute job_complete in the main loop, or otherwise
restructure the code that can run between job_completed and
job_finalize_single so that .prepare/.commit/.abort/.clean run in the
main thread, which is something we want to preserve.

It's simpler just to say that complete will run from the main thread,
like it does presently.

Why would we not want to call user_resume from the main loop? That's
directly where it's called from, since it gets invoked directly from the
qmp thread.

> OTOH, job_finish_sync() is something that has to be run in the main loop
> because it polls the main loop (and as far as my FUSE experiments have
> told me, polling a foreign AioContext doesn't work).
> 
> So...  I suppose it would be nice if we had a real distinction which
> functions are run in which AioContext.  It seems like we indeed want to
> run job_completed() in the main loop, but what to do about the
> user_resume() call in job_cancel_async()?
> 

I don't think we need to do anything -- at least, these functions
*already* run from the main loop.

mirror_exit et al get scheduled from job_defer_to_main_loop and call
job_completed there, so it's already always done from the main loop; I'm
just cutting out the part where the jobs have to manually schedule this.

> (And it should be noted for all of the transactional methods that they
> are called in the main loop.)
> 
