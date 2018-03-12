Received: from eggs.gnu.org ([2001:4830:134:3::10]:54739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evPNg-0007g0-Iz
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evPNf-00063I-LL
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:28:56 -0400
Date: Mon, 12 Mar 2018 16:28:35 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180312152835.GF31537@localhost.localdomain>
References: <20180310082746.24198-1-jsnow@redhat.com>
	<20180310082746.24198-11-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180310082746.24198-11-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 10/21] blockjobs: add NULL state
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

Am 10.03.2018 um 09:27 hat John Snow geschrieben:
> Add a new state that specifically demarcates when we begin to permanently
> demolish a job after it has performed all work. This makes the transition
> explicit in the STM table and highlights conditions under which a job may
> be demolished.
> 
> Alongside this state, add a new helper command "block_job_decommission",
> which transitions to the NULL state and puts down our implicit reference.
> This separates instances in the code for "block_job_unref" which merely
> undo a matching "block_job_ref" with instances intended to initiate the
> full destruction of the object.
> 
> This decommission action also sets a number of fields to make sure that
> block internals or external users that are holding a reference to a job
> to see when it "finishes" are convinced that the job object is "done."
> This is necessary, for instance, to do a block_job_cancel_sync on a
> created object which will not make any progress.
> 
> Now, all jobs must go through block_job_decommission prior to being
> freed, giving us start-to-finish state machine coverage for jobs.
> 
> 
> Transitions:
> Created   -> Null: Early failure event before the job is started
> Concluded -> Null: Standard transition.
> 
> Verbs:
> None. This should not ever be visible to the monitor.
> 
>              +---------+
>              |UNDEFINED|
>              +--+------+
>                 |
>              +--v----+
>    +---------+CREATED+------------------+
>    |         +--+----+                  |
>    |            |                       |
>    |         +--v----+     +------+     |
>    +---------+RUNNING<----->PAUSED|     |
>    |         +--+-+--+     +------+     |
>    |            | |                     |
>    |            | +------------------+  |
>    |            |                    |  |
>    |         +--v--+       +-------+ |  |
>    +---------+READY<------->STANDBY| |  |
>    |         +--+--+       +-------+ |  |
>    |            |                    |  |
> +--v-----+   +--v------+             |  |
> |ABORTING+--->CONCLUDED<-------------+  |
> +--------+   +--+------+                |
>                 |                       |
>              +--v-+                     |
>              |NULL<---------------------+
>              +----+
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

> +static void block_job_decommission(BlockJob *job)
> +{
> +    assert(job);
> +    job->completed = true;
> +    job->busy = false;
> +    job->paused = false;
> +    job->deferred_to_main_loop = true;

Why do we set all of these fields now? I don't see the use of it, and
overwriting fields here potentially makes debugging harder.

Especially for deferred_to_main_loop I might expect an assert() that it
already is true, but shouldn't setting it always be done while actually
deferring to the main loop?

Can we turn all of these assignments into asserts or are there some that
actually aren't already guaranteed, but that we want anyway?

> +    block_job_state_transition(job, BLOCK_JOB_STATUS_NULL);
> +    block_job_unref(job);
> +}

Kevin
