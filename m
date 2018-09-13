Received: from eggs.gnu.org ([2001:4830:134:3::10]:41843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0VKG-0000Ur-N3
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 13:22:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0VK9-0006w3-1o
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 13:22:40 -0400
Date: Thu, 13 Sep 2018 19:21:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180913172143.GC5172@localhost.localdomain>
References: <20180913125217.23173-1-kwolf@redhat.com>
	<20180913125217.23173-4-kwolf@redhat.com>
	<0d3a1209-9770-bcf7-aa47-4baa95fd88e9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d3a1209-9770-bcf7-aa47-4baa95fd88e9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 03/17] aio-wait: Increase num_waiters
 even in home thread
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

Am 13.09.2018 um 17:11 hat Paolo Bonzini geschrieben:
> On 13/09/2018 14:52, Kevin Wolf wrote:
> > Even if AIO_WAIT_WHILE() is called in the home context of the
> > AioContext, we still want to allow the condition to change depending on
> > other threads as long as they kick the AioWait. Specfically block jobs
> > can be running in an I/O thread and should then be able to kick a drain
> > in the main loop context.
> 
> I don't understand the scenario very well.  Why hasn't the main loop's
> drain incremented num_waiters?

We are in this path (that didn't increase num_waiters before this patch)
because drain, and therefore AIO_WAIT_WHILE(), was called from the main
thread. But draining depends on a job in a different thread, so we need
to be able to be kicked when that job finally is quiesced.

If I revert this, the test /bdrv-drain/blockjob/iothread/drain hangs.
This is a block job that works on two nodes in two different contexts.

(I think I saw this with mirror, which doesn't take additional locks
when it issues a request, so maybe there's a bit more wrong there... We
clearly need more testing with iothreads, this series probably only
scratches the surface.)

> Note I'm not against the patch---though I would hoist the
> atomic_inc/atomic_dec outside the if, since it's done in both branches.

Ok.

Kevin
