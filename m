Received: from eggs.gnu.org ([2001:4830:134:3::10]:34306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egD4t-0000PO-RS
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:18:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egD4p-0005sP-VW
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:18:43 -0500
Date: Mon, 29 Jan 2018 18:17:55 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180129171755.GM6141@localhost.localdomain>
References: <20180127020515.27137-1-jsnow@redhat.com>
	<20180127020515.27137-4-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180127020515.27137-4-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [RFC v3 03/14] blockjobs: add state transition
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

Am 27.01.2018 um 03:05 hat John Snow geschrieben:
> The state transition table has mostly been implied. We're about to make
> it a bit more complex, so let's make the STM explicit instead.
> 
> Perform state transitions with a function that for now just asserts the
> transition is appropriate.
> 
> undefined: May only transition to 'created'.
> created: May only transition to 'running'.
>          It cannot transition to pause directly, but if a created job
>          is requested to pause prior to starting, it will transition
>          synchronously to 'running' and then to 'paused'.
> running: May transition either to 'paused' or 'ready'.
> paused: May transition to either 'running' or 'ready', but only in
>         terms of returning to that prior state.
>         p->r->y is not possible, but this is not encapsulated by the
>         STM table.

Do you mean y->p->r->y here? If not, I don't understand.

> ready: May transition to paused.
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  blockjob.c | 39 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/blockjob.c b/blockjob.c
> index 6eb783a354..d084a1e318 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -42,6 +42,35 @@
>   * block_job_enter. */
>  static QemuMutex block_job_mutex;
>  
> +/* BlockJob State Transition Table */
> +bool BlockJobSTT[BLOCK_JOB_STATUS__MAX][BLOCK_JOB_STATUS__MAX] = {
> +                                          /* U, C, R, P, Y */
> +    /* U: */ [BLOCK_JOB_STATUS_UNDEFINED] = {0, 1, 0, 0, 0},
> +    /* C: */ [BLOCK_JOB_STATUS_CREATED]   = {0, 0, 1, 0, 0},
> +    /* R: */ [BLOCK_JOB_STATUS_RUNNING]   = {0, 0, 0, 1, 1},
> +    /* P: */ [BLOCK_JOB_STATUS_PAUSED]    = {0, 0, 1, 0, 1},
> +    /* Y: */ [BLOCK_JOB_STATUS_READY]     = {0, 0, 0, 1, 0},
> +};
> +
> +static void block_job_state_transition(BlockJob *job, BlockJobStatus s1)
> +{
> +    BlockJobStatus s0 = job->status;
> +    if (s0 == s1) {
> +        return;
> +    }
> +    assert(s1 >= 0 && s1 <= BLOCK_JOB_STATUS__MAX);
> +    assert(BlockJobSTT[s0][s1]);
> +    switch (s1) {
> +    case BLOCK_JOB_STATUS_WAITING:
> +    case BLOCK_JOB_STATUS_PENDING:
> +    case BLOCK_JOB_STATUS_CONCLUDED:
> +        assert(job->manual);
> +    default:
> +        break;
> +    }

This doesn't compile because the constants don't exist yet.

Apart from that, I think the assertion is misguided, too. Which states a
job goes through shouldn't depend on whether the client wants to
complete the job manually or have it completed automatically. The
difference should only be which state transitions are automatic.

In other words, WAITING/PENDING/CONCLUDED may never be visible in
query-block-job for automatically completed jobs, but the jobs should
still (synchronously) go through all of these states.

> +    job->status = s1;
> +}
> +

Kevin
