Received: from eggs.gnu.org ([2001:4830:134:3::10]:57397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cxNcq-0003qr-SH
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 20:56:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cxNcn-0000vc-S5
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 20:56:12 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170407065414.9143-1-famz@redhat.com>
	<20170407065414.9143-6-famz@redhat.com>
	<20170407151445.GF4716@noname.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f28a47ae-4c65-8b56-d7c0-d0298f03c3f7@redhat.com>
Date: Mon, 10 Apr 2017 08:56:00 +0800
MIME-Version: 1.0
In-Reply-To: <20170407151445.GF4716@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
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
To: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 07/04/2017 23:14, Kevin Wolf wrote:
> One part of the reason is that
> BDRV_POLL_WHILE() drops the lock since commit c9d1a561, so just calling
> aio_context_acquire() doesn't protect you any more if there is any
> chance that a nested function calls BDRV_POLL_WHILE().

Hi guys, sorry for the late reply.

There wasn't actually much that changed in commit c9d1a561.  Everything
that could break was also broken before.

With commit c9d1a561 the logic is

	aio_context_acquire
	prepare I/O
	aio_context_release
	poll main AioContext
				aio_context_acquire
				aio_poll secondary AioContext
				complete I/O
			    <-- bdrv_wakeup
	aio_context_acquire
				aio_context_release
	Sync I/O is complete

while before it was

	aio_context_acquire
	prepare I/O
	aio_poll secondary AioContext
	complete I/O
	Sync I/O is complete

The code that can run in "aio_poll secondary AioContext" is the same in
both cases.  The difference is that, after c9d1a561, it always runs in
one thread which eliminates the need for RFifoLock's contention
callbacks (and a bunch of bdrv_drain_all deadlocks that arose from the
combination of contention callbacks and recursive locking).

The patch that introduced the bug is the one that introduced the "home
AioContext" co->ctx for coroutines, because now you have

	aio_context_acquire
	prepare I/O
	aio_context_release
	poll main AioContext
				aio_context_acquire
				aio_poll secondary AioContext
				aio_co_wake
	complete I/O
	bdrv_wakeup
	aio_context_acquire
				aio_context_release
	Sync I/O is complete

and if "complete I/O" causes anything to happen in the iothread, bad
things happen.

I think Fam's analysis is right.  This patch will hopefully be reverted
in 2.10, but right now it's the right thing to do.  However, I don't
like very much adding an argument to qemu_coroutine_enter because:

1) coroutines can be used without AioContexts (CoMutex has a dependency
on aio_co_wake, but it is hidden behind the API and if you have a single
AioContext you could just define aio_co_wake to be qemu_coroutine_enter).

2) the value that is assigned to co->ctx is not the AioContext in which
the coroutine is running.

It would be better to split aio_co_wake so that aio_co_wake is

    /* Read coroutine before co->ctx.  Matches smp_wmb in
     * qemu_coroutine_enter.
     */
    smp_read_barrier_depends();
    ctx = atomic_read(&co->ctx);
    aio_co_enter(ctx, co);

and aio_co_enter is the rest of the logic.

Then the coroutine code always runs in the right thread, which obviously
is thread-safe.

Paolo
