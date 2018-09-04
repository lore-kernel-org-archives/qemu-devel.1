Received: from eggs.gnu.org ([2001:4830:134:3::10]:60198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fxCZK-0000OS-6b
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 10:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fxCZI-0003Np-GA
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 10:44:38 -0400
Date: Tue, 4 Sep 2018 16:44:25 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180904144425.GA4371@localhost.localdomain>
References: <20180817170246.14641-1-kwolf@redhat.com>
	<20180817170246.14641-4-kwolf@redhat.com>
	<20180824072205.GD31581@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824072205.GD31581@lemon.usersys.redhat.com>
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
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org

Am 24.08.2018 um 09:22 hat Fam Zheng geschrieben:
> On Fri, 08/17 19:02, Kevin Wolf wrote:
> > Simimlar to AIO_WAIT_WHILE(), job_finish_sync() needs to release the
> > AioContext lock of the job before calling aio_poll(). Otherwise,
> > callbacks called by aio_poll() would possibly take the lock a second
> > time and run into a deadlock with a nested AIO_WAIT_WHILE() call.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  job.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/job.c b/job.c
> > index a746bfe70b..6acf55bceb 100644
> > --- a/job.c
> > +++ b/job.c
> > @@ -1016,7 +1016,10 @@ int job_finish_sync(Job *job, void (*finish)(Job *, Error **errp), Error **errp)
> >          job_drain(job);
> >      }
> >      while (!job_is_completed(job)) {
> > +        AioContext *aio_context = job->aio_context;
> > +        aio_context_release(aio_context);
> >          aio_poll(qemu_get_aio_context(), true);
> > +        aio_context_acquire(aio_context);
> >      }
> >      ret = (job_is_cancelled(job) && job->ret == 0) ? -ECANCELED : job->ret;
> >      job_unref(job);
> 
> Why doesn't this function just use AIO_WAIT_WHILE()?

I don't have an AioWait here, so this seemed the simplest way. But
thinking more about it, a dummy AioWait should do because otherwise the
code would already hang as it is.

Of course, we need to #include "block/aio-wait.h", which doesn't feel
completely right outside the block layer. But maybe that just means that
the header should be moved somewhere else.

Kevin
