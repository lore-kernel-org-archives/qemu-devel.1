Received: from eggs.gnu.org ([2001:4830:134:3::10]:54583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eCeLc-00086L-Ns
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 23:21:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eCeLb-0005PP-IH
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 23:21:48 -0500
Date: Thu, 9 Nov 2017 12:21:37 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171109042137.GA13786@lemon>
References: <92c47a3f-92a6-4f3a-505f-dc278604a671@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92c47a3f-92a6-4f3a-505f-dc278604a671@redhat.com>
Subject: Re: [Qemu-devel] Intermittent hang of iotest 194 (bdrv_drain_all
 after non-shared storage migration)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, 11/09 01:48, Max Reitz wrote:
> Hi,
> 
> More exciting news from the bdrv_drain() front!
> 
> I've noticed in the past that iotest 194 sometimes hangs.  I usually run
> the tests on tmpfs, but I've just now verified that it happens on my SSD
> just as well.
> 
> So the reproducer is a plain:
> 
> while ./check -raw 194; do; done

I cannot produce it on my machine.

> 
> (No difference between raw or qcow2, though.)
> 
> And then, after a couple of runs (or a couple ten), it will just hang.
> The reason is that the source VM lingers around and doesn't quit
> voluntarily -- the test itself was successful, but it just can't exit.
> 
> If you force it to exit by killing the VM (e.g. through pkill -11 qemu),
> this is the backtrace:
> 
> #0  0x00007f7cfc297e06 in ppoll () at /lib64/libc.so.6
> #1  0x0000563b846bcac9 in ppoll (__ss=0x0, __timeout=0x0,
> __nfds=<optimized out>, __fds=<optimized out>) at
> /usr/include/bits/poll2.h:77

Looking at the 0 timeout it seems we are in the aio_poll(ctx, blocking=false);
branches of BDRV_POLL_WHILE? Is it a busy loop? If so I wonder what is making
progress and causing the return value to be true in aio_poll().

> #2  0x0000563b846bcac9 in qemu_poll_ns (fds=<optimized out>,
> nfds=<optimized out>, timeout=<optimized out>) at util/qemu-timer.c:322
> #3  0x0000563b846be711 in aio_poll (ctx=ctx@entry=0x563b856e3e80,
> blocking=<optimized out>) at util/aio-posix.c:629
> #4  0x0000563b8463afa4 in bdrv_drain_recurse
> (bs=bs@entry=0x563b865568a0, begin=begin@entry=true) at block/io.c:201
> #5  0x0000563b8463baff in bdrv_drain_all_begin () at block/io.c:381
> #6  0x0000563b8463bc99 in bdrv_drain_all () at block/io.c:411
> #7  0x0000563b8459888b in block_migration_cleanup (opaque=<optimized
> out>) at migration/block.c:714
> #8  0x0000563b845883be in qemu_savevm_state_cleanup () at
> migration/savevm.c:1251
> #9  0x0000563b845811fd in migration_thread (opaque=0x563b856f1da0) at
> migration/migration.c:2298
> #10 0x00007f7cfc56f36d in start_thread () at /lib64/libpthread.so.0
> #11 0x00007f7cfc2a3e1f in clone () at /lib64/libc.so.6
> 
> 
> And when you make bdrv_drain_all_begin() print what we are trying to
> drain, you can see that it's the format node (managed by the "raw"
> driver in this case).

So what is the value of bs->in_flight?

> 
> So I thought, before I put more time into this, let's ask whether the
> test author has any ideas. :-)

Fam
