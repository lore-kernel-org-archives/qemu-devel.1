Received: from eggs.gnu.org ([2001:4830:134:3::10]:34190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIMU6-0004oV-Aw
	for qemu-devel@nongnu.org; Mon, 14 May 2018 19:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIMU5-0000z4-Dp
	for qemu-devel@nongnu.org; Mon, 14 May 2018 19:02:26 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-19-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <c063b982-58ac-e477-991f-07b847edc48a@redhat.com>
Date: Mon, 14 May 2018 19:02:18 -0400
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-19-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 18/42] job: Move coroutine and related code
 to Job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jcody@redhat.com, armbru@redhat.com, mreitz@redhat.com



On 05/09/2018 12:26 PM, Kevin Wolf wrote:
> This commit moves some core functions for dealing with the job coroutine
> from BlockJob to Job. This includes primarily entering the coroutine
> (both for the first and reentering) and yielding explicitly and at pause
> points.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/blockjob.h     |  40 ---------
>  include/block/blockjob_int.h |  26 ------
>  include/qemu/job.h           |  76 ++++++++++++++++
>  block/backup.c               |   2 +-
>  block/commit.c               |   4 +-
>  block/mirror.c               |  22 ++---
>  block/replication.c          |   2 +-
>  block/stream.c               |   4 +-
>  blockdev.c                   |   8 +-
>  blockjob.c                   | 201 +++++++------------------------------------
>  job.c                        | 137 +++++++++++++++++++++++++++++
>  tests/test-bdrv-drain.c      |  38 ++++----
>  tests/test-blockjob-txn.c    |  12 +--
>  tests/test-blockjob.c        |  14 +--
>  14 files changed, 296 insertions(+), 290 deletions(-)
> 

[...]

>  
>  /* Assumes the block_job_mutex is held */
> -static bool block_job_timer_pending(BlockJob *job)
> +static bool job_timer_pending(Job *job)

Is this intentionally left behind in blockjob.c, even once you've
changed the name (and moved the state to job.c?)

[...]

> +void job_start(Job *job)
> +{
> +    assert(job && !job_started(job) && job->paused &&
> +           job->driver && job->driver->start);
> +    job->co = qemu_coroutine_create(job_co_entry, job);
> +    job->pause_count--;
> +    job->busy = true;
> +    job->paused = false;
> +    job_state_transition(job, JOB_STATUS_RUNNING);
> +    aio_co_enter(job->aio_context, job->co);

I suppose patch 16 was the time to ask this, but are there any
detriments to setting the AIO Context at creation time and then using
that consistently instead of just fetching the AIO context of the BDS
whenever we need it?

I guess if the context changes then we've got it covered in
block_job_attached_aio_context.

Reviewed-by: John Snow <jsnow@redhat.com>
