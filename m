Received: from eggs.gnu.org ([2001:4830:134:3::10]:43335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eKLRE-0004N5-Nh
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 04:47:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eKLRD-0001EQ-1z
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 04:47:24 -0500
Date: Thu, 30 Nov 2017 17:47:09 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171130094709.GA20286@lemon>
References: <20171129035502.GD8889@lemon>
	<20171129120018.GB2601@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129120018.GB2601@stefanha-x1.localdomain>
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

On Wed, 11/29 12:00, Stefan Hajnoczi wrote:
> On Wed, Nov 29, 2017 at 11:55:02AM +0800, Fam Zheng wrote:
> > As we move forwards with new features in the block layer, the chances of tricky
> > bugs happening have been increasing alongside - block jobs, coroutines,
> > throttling, AioContext, op blockers and image locking combined together make a
> > large and complex picture that is hard to fully understand and work with. Some
> > bugs we've encountered are quite challenging already.  Examples are:
> > 
> > - segfault in parallel blockjobs (iotest 30)
> >   https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg01144.html
> > 
> > - Intermittent hang of iotest 194 (bdrv_drain_all after non-shared storage
> >   migration)
> >   https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg01626.html
> > 
> > - Drainage in bdrv_replace_child_noperm()
> >   https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg00868.html
> > 
> > - Regression from 2.8: stuck in bdrv_drain()
> >   https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg02193.html
> > 
> > So in principle, what should we do to make the block layer easy to understand,
> > develop with and debug?
> 
> The assumptions that the code relies on are unclear so it's easy to
> introduce new bugs.

Is that one thing we could do better in documenting?

> 
> We are at a point where code review isn't finding certain bugs because
> no single person knows all the assumptions.  Previously the problem was
> contained because maintainers spotted problems before patches were
> merged.
> 
> This is not primarily a documentation problem though.  We cannot
> document our way out of this because no single person (patch author or
> code reviewer) can know or check everything anymore due to the scale.
> 
> I think it's a (lack of) design problem because we have many incomplete
> abstractions like block jobs, IOThreads, block graph, image locking,
> etc.  They do not cover all possibly states and interactions today.
> Extending them leads to complex bugs.
> 
> A little progress has been made with defining higher-level APIs for
> block drivers and block jobs.  This way they either don't deal with
> low-level details of the concurrency and event loop models (e.g.
> bdrv_coroutine_enter()) or there is an interface that prompts them to
> integrate properly like bdrv_attach/detach_aio_context().

Sounds good.

> 
> Event loops and coroutines are good but they should not be used directly
> by block drivers and block jobs.  We need safe, high-level APIs that
> implement commonly-used operations.
> 
> > - Documentation
> > 
> >   There is no central developer doc about block layer, especially how all pieces
> >   fit together. Having one will make it a lot easier for new contributors to
> >   understand better. Of course, we're facing the old problem: the code is
> >   moving, maintaining an updated document needs effort.
> > 
> >   Idea: add ./doc/deve/block.txt?
> 
> IOThreads and AioContexts are addressed here:
> docs/devel/multiple-iothreads.txt
> 
> The game has become significantly more complex than what the document
> describes.  It's lacking aio_co_wake() and aio_co_schedule() for
> example.
> 
> > - Simplified code, or more orthogonal/modularized architecture.
> > 
> >   Each aspect of block layer is complex enough so isolating them as much as
> >   possible is a reasonable approach to control the complexity. Block jobs and
> >   throttling becoming block filters is a good example, we should identify more.
> > 
> >   Idea: rethink event loops. Create coroutines ubiquitously (for example for
> >   each fd handler, BH and timer), so that many nested aio_poll() can be removed.
> > 
> >   Crazy idea: move the whole block layer to a vhost process, and implement
> >   existing features differently, especially in terms of multi-threading (hint:
> >   rust?).
> 
> A reimplementation will not solve the problem because:
> 
> 1. If it still has the same feature set and requirements then the level
>    of complexity will be comparable.
> 
> 2. We can reduce accidental (inessential) complexity by continuing the
>    various efforts around the block graph, block jobs, multi-queue block
>    layer with an eye towards higher level APIs.

Starting over is certainly not the motivation to do qemu-vhost, but it would be
an opportunity to use different async/concurrency paradigms if that is going to
happen. I think in current block layer, event loop + coroutine is a good
combination, but having nested aio_poll()'s made it worse, then mixing IOThreads
in makes it a lot more complicated.

Fam
