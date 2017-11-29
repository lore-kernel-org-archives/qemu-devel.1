Received: from eggs.gnu.org ([2001:4830:134:3::10]:39668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eK8VC-0006tq-1a
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 14:58:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eK8VB-0001cM-3C
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 14:58:38 -0500
Date: Wed, 29 Nov 2017 19:58:18 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171129195818.GA32030@work-vm>
References: <20171129035502.GD8889@lemon>
	<20171129120018.GB2601@stefanha-x1.localdomain>
	<7ccb7f4a-b576-349f-655c-f741ec3a0dff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ccb7f4a-b576-349f-655c-f741ec3a0dff@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, kwolf@redhat.com, qemu-block@nongnu.org, jcody@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 29/11/2017 13:00, Stefan Hajnoczi wrote:
> > We are at a point where code review isn't finding certain bugs because
> > no single person knows all the assumptions.  Previously the problem was
> > contained because maintainers spotted problems before patches were
> > merged.
> > 
> > This is not primarily a documentation problem though.  We cannot
> > document our way out of this because no single person (patch author or
> > code reviewer) can know or check everything anymore due to the scale.
> > 
> > I think it's a (lack of) design problem because we have many incomplete
> > abstractions like block jobs, IOThreads, block graph, image locking,
> > etc.  They do not cover all possibly states and interactions today.
> > Extending them leads to complex bugs.
> 
> I think the main interactions are:
> 
> 1) block graph modifications and drain.  This has always been a carnage.
>  Implementing BlockBackend isolation instead of drain would probably be
> a starting point to fix it, because IIRC there are extremely few cases
> where we really need "drain" semantics.
> 
> 2) block jobs and coroutines.  Block jobs were too clever about
> coroutines.  Using a simplified API is going to fix this problem.
> Ideally, if you're not in a coroutine "co", the only coroutine APIs you
> should use on "co" are:
> 
> - aio_co_enter/qemu_coroutine_enter (start a coroutine, respectively on
> another AioContext or this context);
> 
> - aio_co_schedule/aio_co_wake (restart a coroutine that has yielded,
> respectively on a given AioContext or its own original.
> 
> 3) block jobs and drain.  This is related to (1) because drain can
> terminate jobs and in turn that can cause block graph modifications.
> I'm not even sure it's a separate issue.

Block and migration has been having a rough time for a while, generally
around whether block devices should be inactivated at particular points.
While we've got some changes recently, we've still got at least one
known failure.

Dave

> Regarding documentation, the include file documentation is good for
> coroutines and block jobs.  But it's bad for block graph modification
> APIs, and even for coroutines + block jobs the docs/devel documentation
> could be improved *and* it's ugly that we're not generating anything
> readable from include file documentation, to go with docs/devel.
> 
> Paolo
> 
> > A little progress has been made with defining higher-level APIs for
> > block drivers and block jobs.  This way they either don't deal with
> > low-level details of the concurrency and event loop models (e.g.
> > bdrv_coroutine_enter()) or there is an interface that prompts them to
> > integrate properly like bdrv_attach/detach_aio_context().
> > 
> > Event loops and coroutines are good but they should not be used directly
> > by block drivers and block jobs.  We need safe, high-level APIs that
> > implement commonly-used operations.
> 
> 


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
