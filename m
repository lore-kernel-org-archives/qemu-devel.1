Received: from eggs.gnu.org ([2001:4830:134:3::10]:34153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dGTa0-0007N7-OL
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:08:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dGTZz-0004l1-Kx
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:08:12 -0400
Date: Thu, 1 Jun 2017 19:08:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170601170801.GI4987@noname.redhat.com>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<ceab079c-1d8e-368f-c51a-82e92a0b2852@redhat.com>
	<20170601162833.GH4987@noname.redhat.com>
	<4c7ba620-b0cf-554d-7494-530bc0652076@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c7ba620-b0cf-554d-7494-530bc0652076@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 00/29] qed: Convert to
 coroutines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com

Am 01.06.2017 um 18:40 hat Paolo Bonzini geschrieben:
> On 01/06/2017 18:28, Kevin Wolf wrote:
> >> - qed_acquire/qed_release can be removed as you inline stuff, but this
> >> should not cause bugs so you can either do it as a final patch or let
> >> me remove it later.
> > To be honest, I don't completely understand what they are protecting in
> > the first place. The places where they are look quite strange to me. So
> > I tried to simply leave them alone.
> > 
> > What is the reason that we can remove them when we inline stuff?
> > Shouldn't the inlining be semantically equivalent?
> 
> You're right, they can be removed when going from callback to direct
> call.  Callbacks are invoked without the AioContext acquire (aio_co_wake
> does it for the callbacks).

So if we take qed_read_table_cb() for example:

    qed_acquire(s);
    for (i = 0; i < noffsets; i++) {
        table->offsets[i] = le64_to_cpu(table->offsets[i]);
    }
    qed_release(s);

First of all, I don't see what it protects. If we wanted to avoid that
someone else sees table->offsets with wrong endianness, we would be
taking the lock much too late. And if nobody else knows about the table
yet, what is there to be locked?

But anyway, given your explanation that acquiring the AioContext lock is
getting replaced by coroutine magic, the qed_acquire/release() pair
actually can't be removed in patch 2 when the callback is converted to a
direct call, but only when the whole call path between .bdrv_aio_readv/
writev and this specific callback is converted, so that we never drop
out of coroutine context before reaching this code. Correct?

This happens only very late in the series, so it probably also means
that patch 5 is indeed wrong because it removes the lock too early?

> >> - coroutine_fn annotations are missing.  Also can be done as a final
> >> patch.  It's a bit ugly that L1/L2 table access can happen both in a
> >> coroutine (for regular I/O) and outside (for create/check).
> >
> > Create is coroutine-based these days. Maybe we should convert check,
> > too.
> 
> Good idea, separate series. :)
> 
> >> - qed_is_allocated_cb can be inlined and QEDIsAllocatedCB removed.  Of
> >> course a lot more cleanup could be done (I will do a couple more such
> >> changes when adding a CoMutex to make the driver thread-safe) but this
> >> one is pretty low-hanging fruit and seems to be in line with the rest
> >> of the patches.
> >>
> >> - qed_co_request doesn't need g_new for the QEDAIOCB.
> >
> > I stopped intentionally when the thing was fully coroutine based
> > because I thought the series is already long enough. There are many more
> > cleanups that could be done (e.g. QEDAIOCB should be completely
> > avoided), but let's do that on top.
> 
> Agreed about qed_is_allocated_cb.  Regarding qed_co_request you're
> already doing an almost complete rewrite of it in patch 27, and making
> QEDAIOCB not heap allocated would be a very small change removing half a
> dozen lines of code.

You're right, wasn't aware of this change any more. :-)

I'll do that then.

Kevin
