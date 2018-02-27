Received: from eggs.gnu.org ([2001:4830:134:3::10]:54258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqkT4-0002QZ-CN
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 13:59:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqkT3-0000dU-Dh
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 13:59:14 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-6-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fbfc54ab-1aba-97e3-0779-7675133ada71@redhat.com>
Date: Tue, 27 Feb 2018 12:58:51 -0600
MIME-Version: 1.0
In-Reply-To: <20180223235142.21501-6-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org

On 02/23/2018 05:51 PM, John Snow wrote:
> The state transition table has mostly been implied. We're about to make
> it a bit more complex, so let's make the STM explicit instead.
> 
> Perform state transitions with a function that for now just asserts the
> transition is appropriate.
> 
> Transitions:
> Undefined -> Created: During job initialization.

Unless we use Created as the default state 0 for g_new0().

> Created   -> Running: Once the job is started.
>                        Jobs cannot transition from "Created" to "Paused"
>                        directly, but will instead synchronously transition
>                        to running to paused immediately.
> Running   -> Paused:  Normal workflow for pauses.
> Running   -> Ready:   Normal workflow for jobs reaching their sync point.
>                        (e.g. mirror)
> Ready     -> Standby: Normal workflow for pausing ready jobs.
> Paused    -> Running: Normal resume.
> Standby   -> Ready:   Resume of a Standby job.
> 
> 
> +---------+
> |UNDEFINED|
> +--+------+
>     |
> +--v----+
> |CREATED|
> +--+----+
>     |
> +--v----+     +------+
> |RUNNING<----->PAUSED|
> +--+----+     +------+
>     |
> +--v--+       +-------+
> |READY<------->STANDBY|
> +-----+       +-------+
> 
> 
> Notably, there is no state presently defined as of this commit that
> deals with a job after the "running" or "ready" states, so this table
> will be adjusted alongside the commits that introduce those states.

The ascii-art tables help in this and other patches.  Thanks for 
producing them.

> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   block/trace-events |  3 +++
>   blockjob.c         | 42 ++++++++++++++++++++++++++++++++++++------
>   2 files changed, 39 insertions(+), 6 deletions(-)
> 

> +static void block_job_state_transition(BlockJob *job, BlockJobStatus s1)
> +{
> +    BlockJobStatus s0 = job->status;
> +    if (s0 == s1) {
> +        return;
> +    }
> +    assert(s1 >= 0 && s1 <= BLOCK_JOB_STATUS__MAX);

Or, if you keep the zero state distinct from valid states, this could be 
'assert(s1 > 0 && ...)'

> @@ -320,7 +349,7 @@ void block_job_start(BlockJob *job)
>       job->pause_count--;
>       job->busy = true;
>       job->paused = false;
> -    job->status = BLOCK_JOB_STATUS_RUNNING;
> +    block_job_state_transition(job, BLOCK_JOB_STATUS_RUNNING);
>       bdrv_coroutine_enter(blk_bs(job->blk), job->co);
>   }
>   
> @@ -704,6 +733,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
>       job->refcnt        = 1;
>       job->manual        = (flags & BLOCK_JOB_MANUAL);
>       job->status        = BLOCK_JOB_STATUS_CREATED;
> +    block_job_state_transition(job, BLOCK_JOB_STATUS_CREATED);

Oops, missing a deletion of the job->status assignment line.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
