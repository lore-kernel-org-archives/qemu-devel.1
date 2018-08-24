Received: from eggs.gnu.org ([2001:4830:134:3::10]:52945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ft6QE-0001Pf-7n
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 03:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ft6QC-0006qP-90
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 03:22:18 -0400
Date: Fri, 24 Aug 2018 15:22:05 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180824072205.GD31581@lemon.usersys.redhat.com>
References: <20180817170246.14641-1-kwolf@redhat.com>
	<20180817170246.14641-4-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817170246.14641-4-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 3/5] job: Drop AioContext lock around
 aio_poll()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org

On Fri, 08/17 19:02, Kevin Wolf wrote:
> Simimlar to AIO_WAIT_WHILE(), job_finish_sync() needs to release the
> AioContext lock of the job before calling aio_poll(). Otherwise,
> callbacks called by aio_poll() would possibly take the lock a second
> time and run into a deadlock with a nested AIO_WAIT_WHILE() call.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  job.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/job.c b/job.c
> index a746bfe70b..6acf55bceb 100644
> --- a/job.c
> +++ b/job.c
> @@ -1016,7 +1016,10 @@ int job_finish_sync(Job *job, void (*finish)(Job *, Error **errp), Error **errp)
>          job_drain(job);
>      }
>      while (!job_is_completed(job)) {
> +        AioContext *aio_context = job->aio_context;
> +        aio_context_release(aio_context);
>          aio_poll(qemu_get_aio_context(), true);
> +        aio_context_acquire(aio_context);
>      }
>      ret = (job_is_cancelled(job) && job->ret == 0) ? -ECANCELED : job->ret;
>      job_unref(job);

Why doesn't this function just use AIO_WAIT_WHILE()?

Fam
