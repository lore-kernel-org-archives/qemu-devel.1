Received: from eggs.gnu.org ([2001:4830:134:3::10]:57332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1er3sq-000134-Tm
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:43:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1er3sq-0005Z5-2T
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:43:08 -0500
Date: Wed, 28 Feb 2018 16:42:53 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180228154253.GD4855@localhost.localdomain>
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-11-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223235142.21501-11-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [RFC v4 10/21] blockjobs: add NULL state
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
> Add a new state that specifically demarcates when we begin to permanently
> demolish a job after it has performed all work. This makes the transition
> explicit in the STM table and highlights conditions under which a job may
> be demolished.
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
>              |CREATED+------------------+
>              +--+----+                  |
>                 |                       |
>              +--v----+     +------+     |
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

The commit message does not match the code:

> @@ -423,6 +424,7 @@ static void block_job_completed_single(BlockJob *job)
>      QLIST_REMOVE(job, txn_list);
>      block_job_txn_unref(job->txn);
>      block_job_event_concluded(job);
> +    block_job_state_transition(job, BLOCK_JOB_STATUS_NULL);
>      block_job_unref(job);
>  }
>  
> @@ -734,9 +736,6 @@ static void block_job_event_completed(BlockJob *job, const char *msg)
>  
>  static void block_job_event_concluded(BlockJob *job)
>  {
> -    if (block_job_is_internal(job) || !job->manual) {
> -        return;
> -    }
>      block_job_state_transition(job, BLOCK_JOB_STATUS_CONCLUDED);
>  }

Any job that transition to NULL goes first through CONCLUDED. There is
no way to reach NULL directly from CREATED.

The second hunk addresses my comment in the previous patch, so it should
probably be squashed in there.

Kevin
