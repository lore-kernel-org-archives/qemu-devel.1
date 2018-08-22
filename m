Received: from eggs.gnu.org ([2001:4830:134:3::10]:34276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fsM0Z-0000un-Hl
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 01:48:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fsM0Y-0004Ti-JG
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 01:48:43 -0400
Date: Wed, 22 Aug 2018 13:48:33 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180822054833.GA3878@lemon.usersys.redhat.com>
References: <20180821064538.19750-1-famz@redhat.com>
	<ba24e15d-7783-dc05-49a8-ffa5e7905499@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba24e15d-7783-dc05-49a8-ffa5e7905499@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] job: Fix nested aio_poll() hanging in
 job_txn_apply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, qemu-stable@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com

On Tue, 08/21 11:15, Eric Blake wrote:
> On 08/21/2018 01:45 AM, Fam Zheng wrote:
> > All callers have acquired ctx already. Doing that again results in
> > aio_poll() hang. This fixes the problem that a BDRV_POLL_WHILE() in the
> > callback cannot make progress because ctx is recursively locked, for
> > example, when drive-backup finishes.
> > 
> > Cc: qemu-stable@nongnu.org
> > Reported-by: Gu Nini <ngu@redhat.com>
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >   job.c | 18 +++++-------------
> >   1 file changed, 5 insertions(+), 13 deletions(-)
> > 
> > diff --git a/job.c b/job.c
> > index fa671b431a..b07c5d0ffc 100644
> > --- a/job.c
> > +++ b/job.c
> > @@ -136,21 +136,13 @@ static void job_txn_del_job(Job *job)
> >       }
> >   }
> > -static int job_txn_apply(JobTxn *txn, int fn(Job *), bool lock)
> > +static int job_txn_apply(JobTxn *txn, int fn(Job *))
> 
> Is it worth adding a comment here that callers must have already acquired
> the job context?

I think most job accessing functions require it. If any, the comment should go
to the public functions like job_finalize().

> 
> However, I was unable to quickly audit whether all callers really did have
> the lock (it balloons into whether all callers of job_finalize() have the
> lock), so I'm reluctant to give R-b.
> 
> > @@ -857,10 +849,10 @@ static void job_completed_txn_success(Job *job)
> >           assert(other_job->ret == 0);
> >       }
> > -    job_txn_apply(txn, job_transition_to_pending, false);
> > +    job_txn_apply(txn, job_transition_to_pending);
> >       /* If no jobs need manual finalization, automatically do so */
> > -    if (job_txn_apply(txn, job_needs_finalize, false) == 0) {
> > +    if (job_txn_apply(txn, job_needs_finalize) == 0) {
> >           job_do_finalize(job);
> 
> That said, the change makes sense here: since the first direct call to
> job_txn_apply() did not need to lock, why should the second indirect call
> through job_do_finalize() need it?
> 
> Or, is the fix to have job_do_finalize() gain a bool parameter, where
> job_completed_txn_success() would pass false to that parameter, while
> job_finalize() would pass true (again, going back to auditing whether all
> callers of job_finalize() have already acquired the context).

There are two callers of job_finalize():

    fam@lemon:~/work/qemu [master]$ git grep -w -A1 '^\s*job_finalize'
    blockdev.c:    job_finalize(&job->job, errp);
    blockdev.c-    aio_context_release(aio_context);
    --
    job-qmp.c:    job_finalize(job, errp);
    job-qmp.c-    aio_context_release(aio_context);
    --
    tests/test-blockjob.c:    job_finalize(&job->job, &error_abort);
    tests/test-blockjob.c-    assert(job->job.status == JOB_STATUS_CONCLUDED);

Ignoring the test, it's very easy to see both callers have acquired the context.

Fam
