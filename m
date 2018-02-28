Received: from eggs.gnu.org ([2001:4830:134:3::10]:38306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1er5xm-0007ff-Sw
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 12:56:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1er5xm-00069p-1V
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 12:56:22 -0500
Date: Wed, 28 Feb 2018 18:55:56 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180228175556.GK4855@localhost.localdomain>
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-18-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223235142.21501-18-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [RFC v4 17/21] blockjobs: add PENDING status and
 event
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
> For jobs utilizing the new manual workflow, we intend to prohibit
> them from modifying the block graph until the management layer provides
> an explicit ACK via block-job-finalize to move the process forward.
> 
> To distinguish this runstate from "ready" or "waiting," we add a new
> "pending" event.
> 
> For now, the transition from PENDING to CONCLUDED/ABORTING is automatic,
> but a future commit will add the explicit block-job-finalize step.
> 
> Transitions:
> Waiting -> Pending:   Normal transition.
> Pending -> Concluded: Normal transition.
> Pending -> Aborting:  Late transactional failures and cancellations.
> 
> Removed Transitions:
> Waiting -> Concluded: Jobs must go to PENDING first.
> 
> Verbs:
> Cancel: Can be applied to a pending job.
> 
>              +---------+
>              |UNDEFINED|
>              +--+------+
>                 |
>              +--v----+
>              |CREATED+-----------------+
>              +--+----+                 |
>                 |                      |
>              +--+----+     +------+    |
>    +---------+RUNNING<----->PAUSED|    |
>    |         +--+-+--+     +------+    |
>    |            | |                    |
>    |            | +------------------+ |
>    |            |                    | |
>    |         +--v--+       +-------+ | |
>    +---------+READY<------->STANDBY| | |
>    |         +--+--+       +-------+ | |
>    |            |                    | |
>    |         +--v----+               | |
>    +---------+WAITING+---------------+ |
>    |         +--+----+                 |
>    |            |                      |
>    |         +--v----+                 |
>    +---------+PENDING|                 |
>    |         +--+----+                 |
>    |            |                      |
> +--v-----+   +--v------+               |
> |ABORTING+--->CONCLUDED|               |
> +--------+   +--+------+               |
>                 |                      |
>              +--v-+                    |
>              |NULL+--------------------+
>              +----+
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Your diagram lost two arrow heads in this commit. :-)

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
