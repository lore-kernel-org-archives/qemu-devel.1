Received: from eggs.gnu.org ([2001:4830:134:3::10]:50315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eqikQ-0002xj-Mz
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:09:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eqikP-0003hM-CS
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:09:02 -0500
Date: Tue, 27 Feb 2018 18:08:49 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180227170849.GC5269@localhost.localdomain>
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-6-jsnow@redhat.com>
	<20180227162759.GB5269@localhost.localdomain>
	<0b9a7368-0425-8879-91db-3c1b3049912e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b9a7368-0425-8879-91db-3c1b3049912e@redhat.com>
Subject: Re: [Qemu-devel] [RFC v4 05/21] blockjobs: add state transition
 table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org

Am 27.02.2018 um 17:45 hat John Snow geschrieben:
> 
> 
> On 02/27/2018 11:27 AM, Kevin Wolf wrote:
> > Am 24.02.2018 um 00:51 hat John Snow geschrieben:
> >> The state transition table has mostly been implied. We're about to make
> >> it a bit more complex, so let's make the STM explicit instead.
> >>
> >> Perform state transitions with a function that for now just asserts the
> >> transition is appropriate.
> >>
> >> Transitions:
> >> Undefined -> Created: During job initialization.
> >> Created   -> Running: Once the job is started.
> >>                       Jobs cannot transition from "Created" to "Paused"
> >>                       directly, but will instead synchronously transition
> >>                       to running to paused immediately.
> >> Running   -> Paused:  Normal workflow for pauses.
> >> Running   -> Ready:   Normal workflow for jobs reaching their sync point.
> >>                       (e.g. mirror)
> >> Ready     -> Standby: Normal workflow for pausing ready jobs.
> >> Paused    -> Running: Normal resume.
> >> Standby   -> Ready:   Resume of a Standby job.
> >>
> >>
> >> +---------+
> >> |UNDEFINED|
> >> +--+------+
> >>    |
> >> +--v----+
> >> |CREATED|
> >> +--+----+
> >>    |
> >> +--v----+     +------+
> >> |RUNNING<----->PAUSED|
> >> +--+----+     +------+
> >>    |
> >> +--v--+       +-------+
> >> |READY<------->STANDBY|
> >> +-----+       +-------+
> >>
> >>
> >> Notably, there is no state presently defined as of this commit that
> >> deals with a job after the "running" or "ready" states, so this table
> >> will be adjusted alongside the commits that introduce those states.
> >>
> >> Signed-off-by: John Snow <jsnow@redhat.com>
> >> ---
> >>  block/trace-events |  3 +++
> >>  blockjob.c         | 42 ++++++++++++++++++++++++++++++++++++------
> >>  2 files changed, 39 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/block/trace-events b/block/trace-events
> >> index 02dd80ff0c..b75a0c8409 100644
> >> --- a/block/trace-events
> >> +++ b/block/trace-events
> >> @@ -4,6 +4,9 @@
> >>  bdrv_open_common(void *bs, const char *filename, int flags, const char *format_name) "bs %p filename \"%s\" flags 0x%x format_name \"%s\""
> >>  bdrv_lock_medium(void *bs, bool locked) "bs %p locked %d"
> >>  
> >> +# blockjob.c
> >> +block_job_state_transition(void *job,  int ret, const char *legal, const char *s0, const char *s1) "job %p (ret: %d) attempting %s transition (%s-->%s)"
> >> +
> >>  # block/block-backend.c
> >>  blk_co_preadv(void *blk, void *bs, int64_t offset, unsigned int bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %u flags 0x%x"
> >>  blk_co_pwritev(void *blk, void *bs, int64_t offset, unsigned int bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %u flags 0x%x"
> >> diff --git a/blockjob.c b/blockjob.c
> >> index 1be9c20cff..d745b3bb69 100644
> >> --- a/blockjob.c
> >> +++ b/blockjob.c
> >> @@ -28,6 +28,7 @@
> >>  #include "block/block.h"
> >>  #include "block/blockjob_int.h"
> >>  #include "block/block_int.h"
> >> +#include "block/trace.h"
> >>  #include "sysemu/block-backend.h"
> >>  #include "qapi/error.h"
> >>  #include "qapi/qmp/qerror.h"
> >> @@ -41,6 +42,34 @@
> >>   * block_job_enter. */
> >>  static QemuMutex block_job_mutex;
> >>  
> >> +/* BlockJob State Transition Table */
> >> +bool BlockJobSTT[BLOCK_JOB_STATUS__MAX][BLOCK_JOB_STATUS__MAX] = {
> >> +                                          /* U, C, R, P, Y, S */
> >> +    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0, 0},
> > 
> > Even at the end of the series, this is the only use of
> > BLOCK_JOB_STATUS_UNDEFINED.
> > 
> >> +    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0, 0},
> >> +    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1, 0},
> >> +    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 0, 0},
> >> +    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 0, 0, 1},
> >> +    /* S: */ [BLOCK_JOB_STATUS_STANDBY]   = {0, 0, 0, 0, 1, 0},
> >> +};
> >> +
> >> +static void block_job_state_transition(BlockJob *job, BlockJobStatus s1)
> >> +{
> >> +    BlockJobStatus s0 = job->status;
> >> +    if (s0 == s1) {
> >> +        return;
> >> +    }
> >> +    assert(s1 >= 0 && s1 <= BLOCK_JOB_STATUS__MAX);
> >> +    trace_block_job_state_transition(job, job->ret, BlockJobSTT[s0][s1] ?
> >> +                                     "allowed" : "disallowed",
> >> +                                     qapi_enum_lookup(&BlockJobStatus_lookup,
> >> +                                                      s0),
> >> +                                     qapi_enum_lookup(&BlockJobStatus_lookup,
> >> +                                                      s1));
> >> +    assert(BlockJobSTT[s0][s1]);
> >> +    job->status = s1;
> >> +}
> >> +
> >>  static void block_job_lock(void)
> >>  {
> >>      qemu_mutex_lock(&block_job_mutex);
> >> @@ -320,7 +349,7 @@ void block_job_start(BlockJob *job)
> >>      job->pause_count--;
> >>      job->busy = true;
> >>      job->paused = false;
> >> -    job->status = BLOCK_JOB_STATUS_RUNNING;
> >> +    block_job_state_transition(job, BLOCK_JOB_STATUS_RUNNING);
> >>      bdrv_coroutine_enter(blk_bs(job->blk), job->co);
> >>  }
> >>  
> >> @@ -704,6 +733,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
> >>      job->refcnt        = 1;
> >>      job->manual        = (flags & BLOCK_JOB_MANUAL);
> >>      job->status        = BLOCK_JOB_STATUS_CREATED;
> >> +    block_job_state_transition(job, BLOCK_JOB_STATUS_CREATED);
> > 
> > So did you intend to start with BLOCK_JOB_STATUS_UNDEFINED and then
> > transition to BLOCK_JOB_STATUS_CREATED?
> > 
> > Or should we completely remove BLOCK_JOB_STATUS_UNDEFINED, keep the
> > initialisation and not call block_job_state_transition() here?
> > 
> > Kevin
> > 
> 
> We can do that;
> 
> I had it start as "Undefined" because I liked how a g_new0() object will
> default to that state, so it felt "safe."
> 
> On the negatives, it does mean that technically you COULD witness a job
> in this state if QEMU did something wrong, which would be confusing
> because you wouldn't be able to fix it via QMP.

I don't really mind which way you do it as long as the code seems
self-consistent. You could change the initialisation this way:

    job->status        = BLOCK_JOB_STATUS_UNDEFINED;
    block_job_state_transition(job, BLOCK_JOB_STATUS_CREATED);

Or if you want to make use of the fact that g_new0() already results in
BLOCK_JOB_STATUS_UNDEFINED, you can omit the first line.

I'm also not strictly opposed to a CREATED -> CREATED transition, even
though it looks a bit odd. But then there is no reason to allow an
UNDEFINED -> CREATED transition that never happens in practice.
UNDEFINED would then be a completely unused state that could only be
active in the case of a bug.

Kevin
