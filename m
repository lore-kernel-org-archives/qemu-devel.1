Received: from eggs.gnu.org ([2001:4830:134:3::10]:45540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0VYZ-0004PD-A2
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 13:37:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0VYY-0004qO-HZ
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 13:37:31 -0400
Date: Thu, 13 Sep 2018 19:36:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180913173643.GD5172@localhost.localdomain>
References: <20180913125217.23173-1-kwolf@redhat.com>
	<20180913125217.23173-9-kwolf@redhat.com>
	<98c140fc-2d06-29a5-404e-0c5fe7a85629@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98c140fc-2d06-29a5-404e-0c5fe7a85629@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 08/17] block: Add missing locking in
 bdrv_co_drain_bh_cb()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, famz@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

Am 13.09.2018 um 17:17 hat Paolo Bonzini geschrieben:
> On 13/09/2018 14:52, Kevin Wolf wrote:
> > bdrv_do_drained_begin/end() assume that they are called with the
> > AioContext lock of bs held. If we call drain functions from a coroutine
> > with the AioContext lock held, we yield and schedule a BH to move out of
> > coroutine context. This means that the lock for the home context of the
> > coroutine is released and must be re-acquired in the bottom half.
> 
> What exactly needs the lock, is it bdrv_drain_invoke?
> 
> Would it make sense to always do release/acquire in bdrv_drain, and
> always do acquire/release in bdrv_drain_invoke?  (Conditional locking is
> tricky...).

The thing that made it obvious was an aio_poll() call around which we
want to release the lock temporarily, and if you don't hold it, you get
a crash. This aio_poll() has actually disappeared in v2, and I'm not
sure if AIO_WAIT_WHILE() can hit it, but I think locking is still right.

I'm not sure what data structures are actually protected by it, but the
simple rule as documented for bdrv_co_drain() has always been to hold
the AioContext lock of bs when you call bdrv_drain(bs), so this patch
just obeys it.

Kevin
