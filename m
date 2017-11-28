Received: from eggs.gnu.org ([2001:4830:134:3::10]:37357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eJjNl-0006Jv-Iv
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:09:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eJjNk-0003ax-IE
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:09:17 -0500
Date: Tue, 28 Nov 2017 12:09:02 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171128170902.GH25110@localhost.localdomain>
References: <20171128154350.21504-1-kwolf@redhat.com>
	<20171128154350.21504-4-kwolf@redhat.com>
	<9bd2921d-64c6-724c-0d80-b43e33f41817@redhat.com>
	<20171128162850.GF3703@localhost.localdomain>
	<20171128164210.GG25110@localhost.localdomain>
	<73fda5ef-429b-1310-255f-0f37b7e3a325@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73fda5ef-429b-1310-255f-0f37b7e3a325@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 3/4] coroutine: Cancel
 aio_co_schedule() on direct entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

On Tue, Nov 28, 2017 at 05:51:21PM +0100, Paolo Bonzini wrote:
> On 28/11/2017 17:42, Jeff Cody wrote:
> > On Tue, Nov 28, 2017 at 05:28:50PM +0100, Kevin Wolf wrote:
> >> Am 28.11.2017 um 17:14 hat Paolo Bonzini geschrieben:
> >>> On 28/11/2017 16:43, Kevin Wolf wrote:
> >>>> +    /* Make sure that a coroutine that can alternatively reentered from two
> >>>> +     * different sources isn't reentered more than once when the first caller
> >>>> +     * uses aio_co_schedule() and the other one enters to coroutine directly.
> >>>> +     * This is achieved by cancelling the pending aio_co_schedule().
> >>>> +     *
> >>>> +     * The other way round, if aio_co_schedule() would be called after this
> >>>> +     * point, this would be a problem, too, but in practice it doesn't happen
> >>>> +     * because we're holding the AioContext lock here and aio_co_schedule()
> >>>> +     * callers must do the same.
> >>>
> >>> No, this is not true.  aio_co_schedule is thread-safe.
> >>
> >> Hm... With the reproducer we were specfically looking at
> >> qmp_block_job_cancel(), which does take the AioContext locks. But it
> >> might not be as universal as I thought.
> >>
> >> To be honest, I just wasn't sure what to do with this case anyway. It
> >> means that the coroutine is already running when someone else schedules
> >> it. We don't really know whether we have to enter it a second time or
> >> not.
> >>
> >> So if it can indeed happen in practice, we need to think a bit more
> >> about this.
> > 
> > It would be nice if, on coroutine termination, we could unschedule all
> > pending executions for that coroutine.  I think use-after-free is the main
> > concern for someone else calling aio_co_schedule() while the coroutine is
> > currently running.
> 
> Yes, terminating a scheduled coroutine is a bug; same for scheduling a
> terminated coroutine, both orders are wrong. However, "unscheduling" is
> not the solution; you would just be papering over the issue.
> 

Maybe we should at least add an abort on coroutine termination if there are
still outstanding schedules, as that is preferable to operating in the
weeds.


> aio_co_schedule() on a running coroutine can only happen when the
> coroutine is going to yield soon.
> 

That is a bit vague.  What is "soon", and how does an external caller know
if a coroutine is going to yield in this timeframe?


Jeff
