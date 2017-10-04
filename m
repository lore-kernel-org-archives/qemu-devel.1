Received: from eggs.gnu.org ([2001:4830:134:3::10]:34213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dzoOf-0004v6-Vh
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 14:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dzoOe-0006vB-Vz
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 14:27:53 -0400
Date: Wed, 4 Oct 2017 20:27:32 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171004182732.GE9801@localhost.localdomain>
References: <20171004015205.20724-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171004015205.20724-1-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] blockjobs: add explicit job reaping
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

Am 04.10.2017 um 03:52 hat John Snow geschrieben:
> For jobs that complete when a monitor isn't looking, there's no way to
> tell what the job's final return code was. We need to allow jobs to
> remain in the list until queried for reliable management.

Just a short summary of what I discussed with John on IRC:

Another important reason why we want to have an explicit end of block
jobs is that job completion often makes changes to the graph. For a
management tool that manages the block graph on a node level, it is a
big problem if graph changes can happen at any point that can lead to
bad race conditions. Giving the management tool control over the end of
the block job makes it aware that graph changes happen.

This means that compared to this RFC series, we need to move the waiting
earlier in the process:

1. Block job is done and calls block_job_completed()
2. Wait for other block jobs in the same job transaction to complete
3. Send a (new) QMP event to the management tool to notify it that the
   job is ready to be reaped
4. On block-job-reap, call the .commit/.abort callbacks of the jobs in
   the transaction. They will do most of the work that is currently done
   in the completion callbacks, in particular any graph changes. If we
   need to allow error cases, we can add a .prepare_completion callback
   that can still let the whole transaction fail.
5. Send the final QMP completion event for each job in the transaction
   with the final error code. This is the existing BLOCK_JOB_COMPLETED
   or BLOCK_JOB_CANCELLED event.

The current RFC still executes .commit/.abort before block-job-reap, so
the graph changes happen too early to be under control of the management
tool.

> RFC:
> The next version will add tests for transactions.
> Kevin, can you please take a look at bdrv_is_root_node and how it is
> used with respect to do_drive_backup? I suspect that in this case that
> "is root" should actually be "true", but a node in use by a job has
> two roles; child_root and child_job, so it starts returning false here.
> 
> That's fine because we prevent a collision that way, but it makes the
> error messages pretty bad and misleading. Do you have a quick suggestion?
> (Should I just amend the loop to allow non-root nodes as long as they
> happen to be jobs so that the job creation code can check permissions?)

We kind of sidestepped this problem by deciding that there is no real
reason for the backup job to require the source to be a root node.

I'm not completely sure how we could easily get a better message while
still requiring a root node (and I suppose there are other places that
rightfully still require a root node). Ignoring children with child_job
feels ugly, but might be the best option.

Note that this will not make the conflicting command work suddenly,
because every node that has a child_job parent also has op blockers for
everything, but the error message should be less confusing than "is not
a root node".

Kevin
