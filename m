Received: from eggs.gnu.org ([208.118.235.92]:59649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eKo4i-0007ct-WE
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:22:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eKo3e-0004Z2-3z
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:22:04 -0500
Date: Fri, 1 Dec 2017 18:16:44 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171201101644.GB11092@lemon>
References: <20171129035502.GD8889@lemon>
	<20171129120018.GB2601@stefanha-x1.localdomain>
	<20171130094709.GA20286@lemon>
	<20171130141954.GC14748@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171130141954.GC14748@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] Block layer complexity: what to do to keep it
 under control?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, jcody@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com

On Thu, 11/30 14:19, Stefan Hajnoczi wrote:
> On Thu, Nov 30, 2017 at 05:47:09PM +0800, Fam Zheng wrote:
> > On Wed, 11/29 12:00, Stefan Hajnoczi wrote:
> > > On Wed, Nov 29, 2017 at 11:55:02AM +0800, Fam Zheng wrote:
> > > 
> > > Event loops and coroutines are good but they should not be used directly
> > > by block drivers and block jobs.  We need safe, high-level APIs that
> > > implement commonly-used operations.
> > > 
> > > > - Documentation
> > > > 
> > > >   There is no central developer doc about block layer, especially how all pieces
> > > >   fit together. Having one will make it a lot easier for new contributors to
> > > >   understand better. Of course, we're facing the old problem: the code is
> > > >   moving, maintaining an updated document needs effort.
> > > > 
> > > >   Idea: add ./doc/deve/block.txt?
> > > 
> > > IOThreads and AioContexts are addressed here:
> > > docs/devel/multiple-iothreads.txt
> > > 
> > > The game has become significantly more complex than what the document
> > > describes.  It's lacking aio_co_wake() and aio_co_schedule() for
> > > example.
> > > 
> > > > - Simplified code, or more orthogonal/modularized architecture.
> > > > 
> > > >   Each aspect of block layer is complex enough so isolating them as much as
> > > >   possible is a reasonable approach to control the complexity. Block jobs and
> > > >   throttling becoming block filters is a good example, we should identify more.
> > > > 
> > > >   Idea: rethink event loops. Create coroutines ubiquitously (for example for
> > > >   each fd handler, BH and timer), so that many nested aio_poll() can be removed.
> > > > 
> > > >   Crazy idea: move the whole block layer to a vhost process, and implement
> > > >   existing features differently, especially in terms of multi-threading (hint:
> > > >   rust?).
> > > 
> > > A reimplementation will not solve the problem because:
> > > 
> > > 1. If it still has the same feature set and requirements then the level
> > >    of complexity will be comparable.
> > > 
> > > 2. We can reduce accidental (inessential) complexity by continuing the
> > >    various efforts around the block graph, block jobs, multi-queue block
> > >    layer with an eye towards higher level APIs.
> > 
> > Starting over is certainly not the motivation to do qemu-vhost, but it would be
> > an opportunity to use different async/concurrency paradigms if that is going to
> > happen. I think in current block layer, event loop + coroutine is a good
> > combination, but having nested aio_poll()'s made it worse, then mixing IOThreads
> > in makes it a lot more complicated.
> 
> Why alternative model are you thinking of?

To utilize whatever is offered in the different language. In particular I've
heard good things about rust (without programming it myself) that doing
concurrency correctly is easier with it. We'll probably lose all the good bits
about coroutine (unlike what is special in Go), but I expects using simpler
concurrency models (IOW threads only) can lead to simpler code. (I have no
problem with coroutine excpet the debuggability problem I pointed out, which
hopefully can be solved by writing more gdb extensions.)

Another thing about rust is it can call into C code so maybe the change can be
done incrementally like suggested by Dan in his libvirt discussion about using
Go:

https://www.redhat.com/archives/libvir-list/2017-November/msg00528.html

> 
> One slight change is to make everything run in a coroutine so that there
> are no while (aio_poll()) loops.  Instead the caller would yield.

Yes I fully agree this is a good idea that we should try.

Fam
