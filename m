Received: from eggs.gnu.org ([2001:4830:134:3::10]:51343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ezJYg-00060P-1T
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 06:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ezJYZ-0000WW-PK
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 06:04:26 -0400
MIME-Version: 1.0
In-Reply-To: <20180323034356.72130-2-haoqf@linux.vnet.ibm.com>
References: <20180323034356.72130-1-haoqf@linux.vnet.ibm.com>
	<20180323034356.72130-2-haoqf@linux.vnet.ibm.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 23 Mar 2018 10:04:06 +0000
Message-ID: <CAJSP0QUtM4HrvTDgK_u8hDSSy4KaeCjskDdM7-AZjShd50Qw5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/1] iotests: fix test case 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Cc: qemu block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Jeff Cody <jcody@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, Mar 23, 2018 at 3:43 AM, QingFeng Hao <haoqf@linux.vnet.ibm.com> wrote:
> Test case 185 failed since commit 4486e89c219 --- "vl: introduce vm_shutdown()".
> It's because of the newly introduced function vm_shutdown calls bdrv_drain_all,
> which is called later by bdrv_close_all. bdrv_drain_all resumes the jobs
> that doubles the speed and offset is doubled.
> Some jobs' status are changed as well.
>
> The fix is to not resume the jobs that are already yielded and also change
> 185.out accordingly.
>
> Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> ---
>  blockjob.c                 | 10 +++++++++-
>  include/block/blockjob.h   |  5 +++++
>  tests/qemu-iotests/185.out | 11 +++++++++--

If drain no longer forces the block job to iterate, shouldn't the test
output remain the same?  (The means the test is fixed by the QEMU
patch.)

>  3 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/blockjob.c b/blockjob.c
> index ef3ed69ff1..fa9838ac97 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -206,11 +206,16 @@ void block_job_txn_add_job(BlockJobTxn *txn, BlockJob *job)
>
>  static void block_job_pause(BlockJob *job)
>  {
> -    job->pause_count++;
> +    if (!job->yielded) {
> +        job->pause_count++;
> +    }

The pause cannot be ignored.  This change introduces a bug.

Pause is not a synchronous operation that stops the job immediately.
Pause just remembers that the job needs to be paused.   When the job
runs again (e.g. timer callback, fd handler) it eventually reaches
block_job_pause_point() where it really pauses.

The bug in this patch is:

1. The job has a timer pending.
2. block_job_pause() is called during drain.
3. The timer fires during drain but now the job doesn't know it needs
to pause, so it continues running!

Instead what needs to happen is that block_job_pause() remains
unmodified but block_job_resume if extended:

static void block_job_resume(BlockJob *job)
{
    assert(job->pause_count > 0);
    job->pause_count--;
    if (job->pause_count) {
        return;
    }
+    if (job_yielded_before_pause_and_is_still_yielded) {
    block_job_enter(job);
+    }
}

This handles the case I mentioned above, where the yield ends before
pause ends (therefore resume must enter the job!).

To make this a little clearer, there are two cases to consider:

Case 1:
1. Job yields
2. Pause
3. Job is entered from timer/fd callback
4. Resume (enter job? yes)

Case 2:
1. Job yields
2. Pause
3. Resume (enter job? no)
4. Job is entered from timer/fd callback

Stefan
