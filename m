Received: from eggs.gnu.org ([2001:4830:134:3::10]:37045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fM7kJ-00080f-Rm
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:06:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fM7kF-0003Ak-2n
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:06:43 -0400
Date: Fri, 25 May 2018 10:06:32 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180525080632.GB5562@localhost.localdomain>
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-32-kwolf@redhat.com>
	<8af81ec5-9a7b-e787-25cd-61deec9a40dc@redhat.com>
	<20180524083020.GD4008@localhost.localdomain>
	<1f9b1685-1d1c-b1d4-0408-d11a12f2a199@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f9b1685-1d1c-b1d4-0408-d11a12f2a199@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 31/40] job: Add job_is_ready()
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

Am 24.05.2018 um 19:25 hat John Snow geschrieben:
> >>> diff --git a/job.c b/job.c
> >>> index af31de4669..66ee26f2a0 100644
> >>> --- a/job.c
> >>> +++ b/job.c
> >>> @@ -199,6 +199,28 @@ bool job_is_cancelled(Job *job)
> >>>      return job->cancelled;
> >>>  }
> >>>  
> >>> +bool job_is_ready(Job *job)
> >>> +{
> >>> +    switch (job->status) {
> >>> +    case JOB_STATUS_UNDEFINED:
> >>> +    case JOB_STATUS_CREATED:
> >>> +    case JOB_STATUS_RUNNING:
> >>> +    case JOB_STATUS_PAUSED:
> >>> +    case JOB_STATUS_WAITING:
> >>> +    case JOB_STATUS_PENDING:
> >>> +    case JOB_STATUS_ABORTING:
> >>> +    case JOB_STATUS_CONCLUDED:
> >>> +    case JOB_STATUS_NULL:
> >>> +        return false;
> >>> +    case JOB_STATUS_READY:
> >>> +    case JOB_STATUS_STANDBY:
> >>> +        return true;
> >>> +    default:
> >>> +        g_assert_not_reached();
> >>> +    }
> >>> +    return false;
> >>> +}
> >>> +
> >>
> >> What's the benefit to a switch statement with a default clause here,
> >> over the shorter:
> >>
> >> if (job->status == READY || job->status == STANDBY) {
> >>   return true;
> >> }
> >> return false;
> >>
> >> (Yes, I realize you already merged this code, but I'm still curious and
> >> I need to read the series anyway to see what's changed...)
> > 
> > That it's easy to copy and paste from job_is_completed()? :-P
> > 
> 
> Haha! Sure!
> 
> > I guess you could argue that the switch ensures that we don't forget to
> > explicitly handle every state if we ever add a new one, but the real
> > reason is more like, job_is_completed() was already there and I didn't
> > see a reason to do something different here.
> > 
> 
> I think the "default" case removes that benefit somewhat; it's nicer
> when the compiler yelps at you for forgetting. The cases that might
> cause an assertion could be harder to hit.

Good point. I'm not sure which compilers would actually warn here, while
asserting makes sure to crash some tests, but in this context I think we
could actually have both: All enum values that are handled return inside
the switch statement. So if we move the g_assert_not_reached() just
after the switch block, we should get both the compiler warning and the
crash.

Would you like to send a patch?

Kevin
