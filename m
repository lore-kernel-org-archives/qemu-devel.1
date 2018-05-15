Received: from eggs.gnu.org ([2001:4830:134:3::10]:42204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIYye-0004lV-30
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:22:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIYyc-0006v5-Vc
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:22:48 -0400
Date: Tue, 15 May 2018 14:22:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180515122235.GC4442@localhost.localdomain>
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-18-kwolf@redhat.com>
	<ff7476fd-5f6d-be11-c65a-296f3b717040@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff7476fd-5f6d-be11-c65a-296f3b717040@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 17/42] job: Move defer_to_main_loop to Job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, jcody@redhat.com, armbru@redhat.com, mreitz@redhat.com

Am 15.05.2018 um 00:33 hat John Snow geschrieben:
> 
> 
> On 05/09/2018 12:26 PM, Kevin Wolf wrote:
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> 
> Hmm, this one is a bit more than just code motion due to the way the
> aio_context acquisition has changed. I think at a minimum a good commit
> message is warranted.

I know it took a while to convince myself that it's right. I wonder
where the commit message has gone...

> > @@ -170,3 +171,35 @@ void job_unref(Job *job)
> >          g_free(job);
> >      }
> >  }
> > +
> > +typedef struct {
> > +    Job *job;
> > +    JobDeferToMainLoopFn *fn;
> > +    void *opaque;
> > +} JobDeferToMainLoopData;
> > +
> > +static void job_defer_to_main_loop_bh(void *opaque)
> > +{
> > +    JobDeferToMainLoopData *data = opaque;
> > +    Job *job = data->job;
> > +    AioContext *aio_context = job->aio_context;
> > +
> > +    /* Prevent race with job_defer_to_main_loop() */
> > +    aio_context_acquire(aio_context);
> > +    data->fn(data->job, data->opaque);
> > +    aio_context_release(aio_context);
> > +
> > +    g_free(data);
> > +}
> > +
> 
> This function showed up in '14, with dec7d42 from Stefan. His first
> draft looked like Kevin's, until:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2014-10/msg00111.html
> 
> Max, from 2014:
> 
> "I'm not so sure whether it'd be possible to change the BDS's AIO
> context (in another thread) after the call to bdrv_get_aio_context() in
> block_job_defer_to_main_loop() and before
> block_job_defer_to_main_loop_bh() is run. If so, this might create race
> conditions."
> 
> Err, I dunno either.

This one at least is not a problem in the new code any more because we
have job->aio_context now, which is updated when the BDS's context
changes. We read job->aio_context only in the BH, so we always get the
current one.

In contrast, the old code put it into BlockJobDeferToMainLoopData at
the time when the BH was scheduled, so it could be outdated when the BH
actually ran.

Kevin
