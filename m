Received: from eggs.gnu.org ([2001:4830:134:3::10]:46822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwVbJ-0004Lp-Ft
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:15:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwVbI-0002ov-Jc
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:15:01 -0400
Date: Fri, 7 Apr 2017 17:14:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170407151445.GF4716@noname.redhat.com>
References: <20170407065414.9143-1-famz@redhat.com>
	<20170407065414.9143-6-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170407065414.9143-6-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/6] coroutine: Explicitly specify
 AioContext when entering coroutine
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

Am 07.04.2017 um 08:54 hat Fam Zheng geschrieben:
> Coroutine in block layer should always be waken up in bs->aio_context
> rather than the "current" context where it is entered. They differ when
> the main loop is doing QMP tasks.
> 
> Race conditions happen without this patch, because the wrong context is
> acquired in co_schedule_bh_cb, while the entered coroutine works on a
> different one:
> 
>   main loop                                iothread
> -----------------------------------------------------------------------
>   blockdev_snapshot
>     aio_context_acquire(bs->ctx)
>     bdrv_flush(bs)
>       bdrv_co_flush(bs)
>         ...
>         qemu_coroutine_yield(co)
>       BDRV_POLL_WHILE()
>         aio_context_release(bs->ctx)
>                                             aio_context_acquire(bs->ctx)
>                                               ...
>                                                 aio_co_wake(co)
>         aio_poll(qemu_aio_context)              ...
>           co_schedule_bh_cb()                   ...
>             qemu_coroutine_enter(co)            ...
>               /* (A) bdrv_co_flush(bs)              /* (B) I/O on bs */
>                       continues... */
>                                             aio_context_release(bs->ctx)

As I discussed with Fam on IRC this morning, what this patch tries to
fix (acquiring the wrong context) is not the real problem, but just a
symptom.

If you look at the example above (the same is true for the other example
that Fam posted in a reply), you see that the monitor called
aio_context_acquire() specifically in order to avoid that some other
user interferes with its activities. The real bug is that the iothread
even had a chance to run. One part of the reason is that
BDRV_POLL_WHILE() drops the lock since commit c9d1a561, so just calling
aio_context_acquire() doesn't protect you any more if there is any
chance that a nested function calls BDRV_POLL_WHILE().

I haven't checked what was done when merging said commit, but I kind of
expect that we didn't carefully audit all callers of
aio_context_acquire() whether they can cope with this. Specifically,
monitor commands tend to rely on the fact that they keep the lock and
therefore nobody else can interfere. When I scrolled through blockdev.c
this morning, I saw a few suspicious ones that could be broken now.

Now, of course, some callers additionally call bdrv_drained_begin(), and
the snapshot code is one of them. This should in theory be safe, but in
practice even both aio_context_acquire() and bdrv_drained_begin()
together don't give us the exclusive access that these callers want.
This is the real bug to address.

I don't know enough about this code to say whether aio_context_acquire()
alone should give the same guarantees again (I suspect it became
impractical?) or whether we need to fix only bdrv_drained_begin() and
add it to more places. So I'll join the others in this email thread:

Paolo, do you have an opinion on this?

Kevin

> Both (A) and (B) can access resources protected by bs->ctx, but (A) is
> not thread-safe.
> 
> Make the block layer explicitly specify a desired context for the
> entered coroutine. For the rest callers, stick to the old behavior,
> qemu_get_aio_context() or qemu_get_current_aio_context().
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
