Received: from eggs.gnu.org ([209.51.188.92]:53089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hEu5a-0003h7-JL
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hEu5Y-0004Ua-B9
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:11:21 -0400
Date: Fri, 12 Apr 2019 13:11:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190412111113.GE4522@linux.fritz.box>
References: <20190225152053.15976-1-kwolf@redhat.com>
	<20190225152053.15976-17-kwolf@redhat.com>
	<4f9792a1-4702-62d0-cad4-4da1169baa3b@virtuozzo.com>
	<20190411141548.GE5694@linux.fritz.box>
	<1391b876-74ed-21f0-c41f-f2fb22d2eae7@virtuozzo.com>
	<20190411164803.GF5694@linux.fritz.box>
	<2558f6fa-03d5-9483-07ff-7ec0a4d37835@virtuozzo.com>
	<0b088cc0-6ea9-297d-6989-2d61e1c25075@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b088cc0-6ea9-297d-6989-2d61e1c25075@virtuozzo.com>
Subject: Re: [Qemu-devel] [PULL 16/71] nbd: Increase bs->in_flight during
 AioContext switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Am 11.04.2019 um 19:20 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 11.04.2019 20:13, Vladimir Sementsov-Ogievskiy wrote:
> > 11.04.2019 19:48, Kevin Wolf wrote:
> >> Am 11.04.2019 um 16:48 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >>> 11.04.2019 17:15, Kevin Wolf wrote:
> >>>> Am 11.04.2019 um 15:40 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >>>>> 25.02.2019 18:19, Kevin Wolf wrote:
> >>>>>> bdrv_drain() must not leave connection_co scheduled, so bs->in_flight
> >>>>>> needs to be increased while the coroutine is waiting to be scheduled
> >>>>>> in the new AioContext after nbd_client_attach_aio_context().
> >>>>>
> >>>>> Hi!
> >>>>>
> >>>>> I have some questions, could you explain, please?
> >>>>>
> >>>>> "bdrv_drain() must not leave connection_co scheduled" - it's because we want to be
> >>>>> sure that connection_co yielded from nbd_read_eof, yes?
> >>>>>
> >>>>> But it is guaranteed by aio_wait_bh_oneshot.. Why do we need additioinally inc/dec
> >>>>> bs->in_flight ?
> >>>>
> >>>> Without incrementing bs->in_flight, nothing would guarantee that
> >>>> aio_poll() is called and the BH is actually executed before bdrv_drain()
> >>>> returns.
> >>>
> >>> Don't follow.. Don't we want exactly this, we want BH to be executed while node is still
> >>> drained, as you write in comment?
> >>
> >> Yes, exactly. But if bs->in_flight == 0, the AIO_WAIT_WHILE() condition
> >> in the drain code could become false, so aio_poll() would not be called
> >> again and drain would return even if the BH is still pending.
> >>
> > 
> > Ah, oops, sorry my English, I read it like "nothing would prevent". Understand now, thanks.
> 
> Or not again.. We will not return to drain code, as we will loop in aio_wait_bh_oneshot,
> which will not return until BH handled

Oh, hm, good point, it's not just aio_bh_schedule_oneshot(), but the
waiting version.

I think I added the aio_wait_bh_oneshot() only later to address a review
comment, so maybe increasing bs->in_flight isn't needed any more now.

But it can't hurt at least...

Kevin
