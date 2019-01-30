Received: from eggs.gnu.org ([209.51.188.92]:40317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gow0S-0006RD-72
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 14:58:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gow0R-00084X-EQ
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 14:58:44 -0500
References: <1de57808-bd1d-e8a7-89b3-a08873c77346@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <4e3bec22-47f6-12b2-ba64-b9d310c6e0d6@redhat.com>
Date: Wed, 30 Jan 2019 14:58:35 -0500
MIME-Version: 1.0
In-Reply-To: <1de57808-bd1d-e8a7-89b3-a08873c77346@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] job_pause_point
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>



On 1/30/19 8:58 AM, Vladimir Sementsov-Ogievskiy wrote:
> Hi!
> 
> I have a question about job_pause_point. Now a good job of moving generic things about
> block-jobs to job.c is done..
> 
> job_pause_point do visible job-state change, as changing job->status and job->paused.
> 
> Is it assumed, that job don't do anything after that state change? Iotests are written
> exactly with this assumption. On the other hand, code don't guarantee, that all in-flight
> requests are finished to this point.
> 

Oh, right. The job being paused only certifies that the coroutine
driving the job isn't running. It has no real idea about mirror's
asynchronous children.

> Moreover, only the job itself knows about it's in-flight requests, therefore we can't
> handle it in generic job_pause_point(). So, should not job do something like
> 
> if (job_should_pause()) {
>     don't create more requests
>     wait all in-flight requests to complete
> }
> job_pause_point()
> 
> Or didn't I miss these things already discussed?
> 

Well, mirror's pause callback does this:

static void coroutine_fn mirror_pause(Job *job)
{
    MirrorBlockJob *s = container_of(job, MirrorBlockJob, common.job);

    mirror_wait_for_all_io(s);
}

That's invoked BEFORE we change our status. That ought to be sufficient,
is it not?

--js
