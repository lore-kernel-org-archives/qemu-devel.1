Received: from eggs.gnu.org ([2001:4830:134:3::10]:33961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eJjIU-00021B-U2
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:03:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eJjIS-0000lW-KW
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:03:50 -0500
Date: Tue, 28 Nov 2017 18:03:31 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171128170331.GI3703@localhost.localdomain>
References: <20171128154350.21504-1-kwolf@redhat.com>
	<20171128154350.21504-4-kwolf@redhat.com>
	<9bd2921d-64c6-724c-0d80-b43e33f41817@redhat.com>
	<20171128162850.GF3703@localhost.localdomain>
	<20171128164210.GG25110@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171128164210.GG25110@localhost.localdomain>
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
To: Jeff Cody <jcody@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

Am 28.11.2017 um 17:42 hat Jeff Cody geschrieben:
> On Tue, Nov 28, 2017 at 05:28:50PM +0100, Kevin Wolf wrote:
> > Am 28.11.2017 um 17:14 hat Paolo Bonzini geschrieben:
> > > On 28/11/2017 16:43, Kevin Wolf wrote:
> > > > +    /* Make sure that a coroutine that can alternatively reentered from two
> > > > +     * different sources isn't reentered more than once when the first caller
> > > > +     * uses aio_co_schedule() and the other one enters to coroutine directly.
> > > > +     * This is achieved by cancelling the pending aio_co_schedule().
> > > > +     *
> > > > +     * The other way round, if aio_co_schedule() would be called after this
> > > > +     * point, this would be a problem, too, but in practice it doesn't happen
> > > > +     * because we're holding the AioContext lock here and aio_co_schedule()
> > > > +     * callers must do the same.
> > > 
> > > No, this is not true.  aio_co_schedule is thread-safe.
> > 
> > Hm... With the reproducer we were specfically looking at
> > qmp_block_job_cancel(), which does take the AioContext locks. But it
> > might not be as universal as I thought.
> > 
> > To be honest, I just wasn't sure what to do with this case anyway. It
> > means that the coroutine is already running when someone else schedules
> > it. We don't really know whether we have to enter it a second time or
> > not.
> > 
> > So if it can indeed happen in practice, we need to think a bit more
> > about this.
> 
> It would be nice if, on coroutine termination, we could unschedule all
> pending executions for that coroutine.  I think use-after-free is the main
> concern for someone else calling aio_co_schedule() while the coroutine is
> currently running.

I'd rather assert that this never happens.

Because if you have the same situation, but the coroutine doesn't
terminate, but just yields for another reason, then reentering it with
the assumption that it's still in the previous yield is a bad bug that
you definitely want to catch.

Kevin
