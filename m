Received: from eggs.gnu.org ([2001:4830:134:3::10]:44334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Oa3-0002Rh-Kc
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0OZx-0001Ni-Jv
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:06:03 -0400
Date: Fri, 6 Oct 2017 11:05:37 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171006090537.GA4325@localhost.localdomain>
References: <20171004015205.20724-1-jsnow@redhat.com>
	<20171004182732.GE9801@localhost.localdomain>
	<7fd66217-8eda-8de2-f34f-148f69f9df4d@redhat.com>
	<20171005113818.GA4416@localhost.localdomain>
	<40eebf9c-611a-3924-91d9-b006738c7dee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40eebf9c-611a-3924-91d9-b006738c7dee@redhat.com>
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
Cc: Fam Zheng <famz@redhat.com>, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 06.10.2017 um 05:56 hat John Snow geschrieben:
> On 10/05/2017 07:38 AM, Kevin Wolf wrote:
> > Let me try to just consolidate all of the above into a single state
> > machine:
> > 
> > 1.  CREATED --> RUNNING
> >         driver callback: .start
> > 2a. RUNNING --> READY | CANCELLED
> >         via: auto transition (when bulk copy is finished) / block-job-cancel
> >         event: BLOCK_JOB_READY
> > 2b. READY --> READY (COMPLETING) | READY (CANCELLING)
> >         via: block-job-complete / block-job-cancel
> >         event: none
> >         driver callback: .complete / none
> > 3.  READY (CANCELLING | COMPLETING) --> DONE
> >         via: auto transition
> >              (CANCELLING: after draining in-flight mirror requests;
> >               COMPLETING: when images are in sync)
> >         event: BLOCK_JOB_DONE
> 
> I have some doubts about "DONE" necessarily coming prior to "PENDING" as
> this means that the transaction gives up control of the jobs at this
> point, and then "PENDING" jobs may complete one without the other,
> especially if we introduce a PREPARE() callback.
> 
> (At least, if I've understood you correctly that "DONE" is the phase
> where jobs queue up, ready to be dispatched by the transaction mechanism.)

Yes. This means that DONE is state where a job end up when it has
completed its work, which is generally a different point in time for
each job in the transaction. Something has to come there, and it can't
be PENDING yet because the transaction hasn't completed yet.

In other words, DONE is the inactive state that exists today, but is
externally exposed as RUNNING even though the job isn't actually doing
any work any more.

I don't see though why this means that the transaction has to give up
control?

> I think jobs needs to not clear that transactional hurdle until they've
> been allowed to call prepare so that we can be guaranteed that any
> changes that occur after that point in time will not fail (and cannot
> any longer affect the transactional group.)

The earliest point where the transaction can be removed from the picture
is the first call of block-job-finalize for any job in the transaction.
This is where all jobs of the transaction need to complete at least
their .prepare stage, otherwise this first job can't be finalised.

As we discussed yesterday, block-job-finalize is really an operation on
the whole transaction, but keeping it at the job level in the external
interface spares us managing transactions as named objects.

Kevin
