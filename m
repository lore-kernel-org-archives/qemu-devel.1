Received: from eggs.gnu.org ([2001:4830:134:3::10]:33114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cxshL-0006aQ-73
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cxshK-0001pl-3x
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:06:55 -0400
Date: Tue, 11 Apr 2017 12:06:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170411100642.GH4516@noname.str.redhat.com>
References: <20170410150542.30376-1-famz@redhat.com>
	<20170410150542.30376-10-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170410150542.30376-10-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.9 v3 09/10] block: Use
 bdrv_coroutine_enter to start I/O coroutines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 10.04.2017 um 17:05 hat Fam Zheng geschrieben:
> BDRV_POLL_WHILE waits for the started I/O by releasing bs's ctx then polling
> the main context, which relies on the yielded the coroutine would continue on
> bs->ctx and notify qemu_aio_context with bdrv_wakeup(). Thus, using
> qemu_coroutine_enter to start I/O is wrong because if the coroutine is entered
> from main loop, co->ctx will be qemu_aio_context, as a result of the "release,
> poll, acquire" loop of BDRV_POLL_WHILE, race conditions happen when both
> main thread and the iothread access the same BDS:
> 
>   main loop                                iothread
> -----------------------------------------------------------------------
>   blockdev_snapshot
>     aio_context_acquire(bs->ctx)
>                                            virtio_scsi_data_plane_handle_cmd
>     bdrv_drained_begin(bs->ctx)
>     bdrv_flush(bs)
>       bdrv_co_flush(bs)                      aio_context_acquire(bs->ctx).enter
>         ...
>         qemu_coroutine_yield(co)
>       BDRV_POLL_WHILE()
>         aio_context_release(bs->ctx)
>                                              aio_context_acquire(bs->ctx).return
>                                                ...
>                                                  aio_co_wake(co)
>         aio_poll(qemu_aio_context)               ...
>           co_schedule_bh_cb()                    ...
>             qemu_coroutine_enter(co)             ...
> 
>               /* (A) bdrv_co_flush(bs)           /* (B) I/O on bs */
>                       continues... */
>                                              aio_context_release(bs->ctx)
>         aio_context_acquire(bs->ctx)
> 
> Note that in above case, bdrv_drained_begin() doesn't do the "release,
> poll, acquire" in BDRV_POLL_WHILE, because bs->in_flight == 0.
> 
> Fix this by using bdrv_coroutine_enter and enter coroutine in the right
> context.
> 
> iotests 109 output is updated because the coroutine reenter flow during
> mirror job complete is different (now through co_queue_wakeup, instead
> of the unconditional qemu_coroutine_switch before), making the end job
> len different.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> fixup
> ---
>  block/block-backend.c      |  4 ++--
>  block/io.c                 | 14 +++++++-------

These changes are okay.

The question is whether we need more of them. We do have a few more
callers of qemu_coroutine_create():

* blkverify, quorum: Here, we are already in a coroutine context and
  therefore the caller has made sure that we're in the right AioContext.
  The usual functions simply inherit it, which is correct.

* nbd-client: Has its own handling for getting the coroutine in to the
  right AioContexts, I'll assume it's okay.

* sheepdog:

  co_read_response() calls aio_co_wake() immediately after
  qemu_coroutine_create(). Is this allowed? I don't think co->ctx is
  even initialised at this time. Is this a bug introduced in Paolo's
  9d456654? ('block: explicitly acquire aiocontext in callbacks that
  need it') Anyway, called only in AioContext callbacks, so we're fine.

  do_req() is called from the main loop context in a few instances. Not
  sure if this is a problem, but maybe using bdrv_coroutine_enter()
  there would be safer.

* 9p, migration: Outside the block layer, trivially ok

* nbd/server: nbd_co_client_start() runs in the caller's AioContext.
  Should be fine, it doesn't directly issue any requests, but just
  spawns other coroutines that are put in the right AioContext.

* qemu-img, tests: Nobody cares about AioContexts there

So I think we should have another look at Sheepdog, the rest seems to be
fine.

>  tests/qemu-iotests/109.out | 10 +++++-----

This one is curious. Why do we copy more data depending on how the job
coroutine is reentered?

Kevin
