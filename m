Received: from eggs.gnu.org ([209.51.188.92]:42119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gj0Wt-0004fH-6A
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:35:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gj0Wq-0001Y2-FG
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:35:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1gj0Wq-0001Wc-4c
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:35:40 -0500
Date: Mon, 14 Jan 2019 12:35:20 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190114113520.GC6837@linux.fritz.box>
References: <154703587757.13472.3898702635363120794.stgit@pasha-VirtualBox>
	<154703599022.13472.1704009113561450219.stgit@pasha-VirtualBox>
	<20190111104923.GD5010@dhcp-200-186.str.redhat.com>
	<001001d4abf9$b6ea93e0$24bfbba0$@ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001001d4abf9$b6ea93e0$24bfbba0$@ru>
Subject: Re: [Qemu-devel] [PATCH v9 19/21] replay: add BH oneshot event for
 block layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

Am 14.01.2019 um 12:10 hat Pavel Dovgalyuk geschrieben:
> > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > Am 09.01.2019 um 13:13 hat Pavel Dovgalyuk geschrieben:
> > > Replay is capable of recording normal BH events, but sometimes
> > > there are single use callbacks scheduled with aio_bh_schedule_oneshot
> > > function. This patch enables recording and replaying such callbacks.
> > > Block layer uses these events for calling the completion function.
> > > Replaying these calls makes the execution deterministic.
> > >
> > > Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> > 
> > This still doesn't come even close to catching all BHs that need to be
> > caught. While you managed to show a few BHs that actually don't need to
> > be considered for recording when I asked for this in v7, most BHs in the
> > block layer can in some way lead to device callbacks and must therefore
> > be recorded.
> 
> Let's have a brief review. I can change all the places, but how
> should I make a test case to be sure, that all of them are working ok?

The list is changing all the time. This is why I am so concerned about
special-casing a few callers instead of having a generic solution. I
don't know how we could make sure that we call the right function
everywhere.

> aio_bh_schedule_oneshot is used in:
>  - blk_abort_aio_request
>  - bdrv_co_yield_to_drain
>  - iscsi_co_generic_cb
>  - nfs_co_generic_cb
>  - null_aio_common
>  - nvme_process_completion
>  - nvme_rw_cb
>  - rbd_finish_aiocb
>  - vxhs_iio_callback
>  - (and couple of others not in the block layer)

In addition to these, we have at least a few functions that just resume
block layer coroutines rather than directly scheduling a BH with a
callback somewhere in the block layer.

> We must change this call to replay_bh_schedule_oneshot_event when
> the result of the BH execution affects the replayed guest state
> (e.g., interrupt request is generated or memory is written)
> 
> If you think that all of these can do that, then I should change
> such function calls.

I haven't reviewed the code, but these names look like all of them can
eventually call back into the guest devices. They won't do that always,
but potentially.

> > How bad would it be to record some BHs even if recording them isn't
> > necessary? I'd definitely try to err on the safe side here. Having two
> > different sets of BH functions, you can't expect that people always use
> > the right one (especially if you don't even make the existing code base
> > consistently use the right one intially).
> 
> There are two possible options:
> 1. Execution hangs when recording. Kind of deadlock caused by the incorrect
>    management of the events. E.g., adding stopping the VM and trying to flush
>    the block layer queue.
> 2. Execution hangs when replaying. 
>    One of the events that affect the guest state is missed or generated
>    at the other moment (e.g., when BH is not linked to the execution step).
>    Then the guest behaves differently and the order of the events in the log
>    does not match the guest state (e.g., interrupt processing is not matched).

So basically when you have two events that are kind of nested? Operation
A triggers event A, but in order to complete the operation, you call
operation B with event B internally, which isn't available yet because
we're still handling event A?

Could this be solved by not having an order of events, but an order of
sets of events?

Kevin
