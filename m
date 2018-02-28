Received: from eggs.gnu.org ([2001:4830:134:3::10]:56348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1er3nu-0007XB-DS
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:38:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1er3nt-0002P4-C7
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:38:02 -0500
Date: Wed, 28 Feb 2018 16:37:43 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180228153743.GC4855@localhost.localdomain>
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-10-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223235142.21501-10-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [RFC v4 09/21] blockjobs: add CONCLUDED state
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

Am 24.02.2018 um 00:51 hat John Snow geschrieben:
> add a new state "CONCLUDED" that identifies a job that has ceased all
> operations. The wording was chosen to avoid any phrasing that might
> imply success, error, or cancellation. The task has simply ceased all
> operation and can never again perform any work.
> 
> ("finished", "done", and "completed" might all imply success.)
> 
> Transitions:
> Running  -> Concluded: normal completion
> Ready    -> Concluded: normal completion
> Aborting -> Concluded: error and cancellations
> 
> Verbs:
> None as of this commit. (a future commit adds 'dismiss')
> 
>              +---------+
>              |UNDEFINED|
>              +--+------+
>                 |
>              +--v----+
>              |CREATED|
>              +--+----+
>                 |
>              +--v----+     +------+
>    +---------+RUNNING<----->PAUSED|
>    |         +--+-+--+     +------+
>    |            | |
>    |            | +------------------+
>    |            |                    |
>    |         +--v--+       +-------+ |
>    +---------+READY<------->STANDBY| |
>    |         +--+--+       +-------+ |
>    |            |                    |
> +--v-----+   +--v------+             |
> |ABORTING+--->CONCLUDED<-------------+
> +--------+   +---------+
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

> +static void block_job_event_concluded(BlockJob *job)
> +{
> +    if (block_job_is_internal(job) || !job->manual) {
> +        return;
> +    }
> +    block_job_state_transition(job, BLOCK_JOB_STATUS_CONCLUDED);
> +}

I don't understand why internal or automatic jobs should follow a
different state machine. Sure, they won't be in this state for long
because the job is immediately unref'ed. Though if someone holds an
additional reference, it might be visible - I would consider this a bug
fix because otherwise the job stays in READY and continues to accept the
verbs for that state.

Kevin
