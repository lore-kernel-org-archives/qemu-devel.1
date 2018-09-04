Received: from eggs.gnu.org ([2001:4830:134:3::10]:34007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fwzjX-0002Mk-Ci
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 21:02:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fwzjV-0005a1-As
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 21:02:19 -0400
Date: Tue, 4 Sep 2018 09:02:04 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180904010204.GB28443@lemon.usersys.redhat.com>
References: <20180824024342.749-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824024342.749-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH v2] job: Fix nested
 aio_poll() hanging in job_txn_apply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, qemu-stable@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, eblake@redhat.com

On Fri, 08/24 10:43, Fam Zheng wrote:
> All callers have acquired ctx already. Doing that again results in
> aio_poll() hang. This fixes the problem that a BDRV_POLL_WHILE() in the
> callback cannot make progress because ctx is recursively locked, for
> example, when drive-backup finishes.
> 
> There are two callers of job_finalize():
> 
>     fam@lemon:~/work/qemu [master]$ git grep -w -A1 '^\s*job_finalize'
>     blockdev.c:    job_finalize(&job->job, errp);
>     blockdev.c-    aio_context_release(aio_context);
>     --
>     job-qmp.c:    job_finalize(job, errp);
>     job-qmp.c-    aio_context_release(aio_context);
>     --
>     tests/test-blockjob.c:    job_finalize(&job->job, &error_abort);
>     tests/test-blockjob.c-    assert(job->job.status == JOB_STATUS_CONCLUDED);
> 
> Ignoring the test, it's easy to see both callers to job_finalize (and
> job_do_finalize) have acquired the context.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Gu Nini <ngu@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Ping?
