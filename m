Received: from eggs.gnu.org ([2001:4830:134:3::10]:50444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dGSxo-0004uM-6o
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dGSxn-0004bM-7f
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:28:44 -0400
Date: Thu, 1 Jun 2017 18:28:33 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170601162833.GH4987@noname.redhat.com>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<ceab079c-1d8e-368f-c51a-82e92a0b2852@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceab079c-1d8e-368f-c51a-82e92a0b2852@redhat.com>
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

Am 29.05.2017 um 13:22 hat Paolo Bonzini geschrieben:
> On 26/05/2017 22:21, Kevin Wolf wrote:
> > The qed block driver is one of the last remaining block drivers that use the
> > AIO callback style interfaces. This series converts it to the coroutine model
> > that other drivers are using and removes some AIO functions from the block
> > layer API afterwards.
> > 
> > If this isn't compelling enough, the diffstat should speak for itself.
> > 
> > This series is relatively long, but it consists mostly of mechanical
> > conversions of one function per patch, so it should be easy to review.
> 
> Looks great, just a few notes:
> 
> - There are a couple "Callback from qed_find_cluster()" comments that 
> are obsolete.

Fixed.

> - qed_acquire/qed_release can be removed as you inline stuff, but this
> should not cause bugs so you can either do it as a final patch or let
> me remove it later.

To be honest, I don't completely understand what they are protecting in
the first place. The places where they are look quite strange to me. So
I tried to simply leave them alone.

What is the reason that we can remove them when we inline stuff?
Shouldn't the inlining be semantically equivalent?

I guess the answer is important for the case in patch 5, where Stefan
commented that I moved some code out of the lock.

> - coroutine_fn annotations are missing.  Also can be done as a final
> patch.  It's a bit ugly that L1/L2 table access can happen both in a
> coroutine (for regular I/O) and outside (for create/check).

Create is coroutine-based these days. Maybe we should convert check,
too.

> - qed_is_allocated_cb can be inlined and QEDIsAllocatedCB removed.  Of
> course a lot more cleanup could be done (I will do a couple more such
> changes when adding a CoMutex to make the driver thread-safe) but this
> one is pretty low-hanging fruit and seems to be in line with the rest
> of the patches.
> 
> - qed_co_request doesn't need g_new for the QEDAIOCB.

I stopped intentionally when the thing was fully coroutine based
because I thought the series is already long enough. There are many more
cleanups that could be done (e.g. QEDAIOCB should be completely
avoided), but let's do that on top.

Kevin
