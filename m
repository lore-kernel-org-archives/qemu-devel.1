Received: from eggs.gnu.org ([2001:4830:134:3::10]:53935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eqiuI-00013e-PH
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:19:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eqiuH-0002r0-Mt
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:19:14 -0500
Date: Tue, 27 Feb 2018 18:19:02 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180227171902.GG5269@localhost.localdomain>
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-5-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223235142.21501-5-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [RFC v4 04/21] blockjobs: add status enum
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
> We're about to add several new states, and booleans are becoming
> unwieldly and difficult to reason about. It would help to have a
> more explicit bookkeeping of the state of blockjobs. To this end,
> add a new "status" field and add our existing states in a redundant
> manner alongside the bools they are replacing:
> 
> UNDEFINED: Placeholder, default state. Not currently visible to QMP
>            unless changes occur in the future to allow creating jobs
>            without starting them via QMP.
> CREATED:   replaces !!job->co && paused && !busy
> RUNNING:   replaces effectively (!paused && busy)
> PAUSED:    Nearly redundant with info->paused, which shows pause_count.
>            This reports the actual status of the job, which almost always
>            matches the paused request status. It differs in that it is
>            strictly only true when the job has actually gone dormant.
> READY:     replaces job->ready.
> STANDBY:   Paused, but job->ready is true.
> 
> New state additions in coming commits will not be quite so redundant:
> 
> WAITING:   Waiting on transaction. This job has finished all the work
>            it can until the transaction converges, fails, or is canceled.
> PENDING:   Pending authorization from user. This job has finished all the
>            work it can until the job or transaction is finalized via
>            block_job_finalize. This implies the transaction has converged
>            and left the WAITING phase.
> ABORTING:  Job has encountered an error condition and is in the process
>            of aborting.
> CONCLUDED: Job has ceased all operations and has a return code available
>            for query and may be dismissed via block_job_dismiss.
> NULL:      Job has been dismissed and (should) be destroyed. Should never
>            be visible to QMP.
> 
> Some of these states appear somewhat superfluous, but it helps define the
> expected flow of a job; so some of the states wind up being synchronous
> empty transitions. Importantly, jobs can be in only one of these states
> at any given time, which helps code and external users alike reason about
> the current condition of a job unambiguously.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
