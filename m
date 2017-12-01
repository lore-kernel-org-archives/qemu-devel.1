Received: from eggs.gnu.org ([2001:4830:134:3::10]:35892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eKnQy-0003GK-Nb
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:42:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eKnQI-0006xX-JW
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:41:00 -0500
Date: Fri, 1 Dec 2017 23:00:03 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171201150003.GD11092@lemon>
References: <20171129035502.GD8889@lemon>
	<20171129120018.GB2601@stefanha-x1.localdomain>
	<20171130094709.GA20286@lemon>
	<20171130141954.GC14748@stefanha-x1.localdomain>
	<20171201101644.GB11092@lemon>
	<20171201140833.GB12803@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171201140833.GB12803@stefanha-x1.localdomain>
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

On Fri, 12/01 14:08, Stefan Hajnoczi wrote:
> What I'm getting at is that the essential complexity of a parallel I/O
> engine with a runtime reconfigurable graph, background operations, and
> non-trivial disk image file formats sets a certain floor (minimum)
> complexity.  The consequence is that our code needs to handle
> concurrency and this is where we fall down today.

I think complexity comes from too many (incomplete) abstractions going together,
and there is no simple core mechanism to coordinate them. Specifically, there is
no elegant synchronization interface between graph reconfiguration (control path
operation) and I/O (data path operation), and background operations have no
clear modeling (block jobs are not first class citizen in our event loop, they
are just specially purposed coroutines). If we redesign from the ground up, we
can hopefully model better and draw more "rigorous" lines between different
parts of the picture, or we can use a simpler design, such as "everything is a
block node in the graph".

> 
> Switching programming language will not reduce complexity below this
> floor.  We'd have to abandon features in order to reduce complexity.
> "Let's start from scratch" attempts often hope to do this but ultimately
> users don't want to lose features.

The complexity can be hidden with a higher level abstraction in exchange of full
control and extreme performance, that is probably the real difference to expect
by changing the programming language. I don't believe "start from scratch" is a
way to fix the old system, there will always be bugs, it's just different, and
it's extremely hard to do it fully compatible with the old implementation.

> 
> We need to think through the corner cases we've been hitting and in the
> process of fixing them we should consider if simplified interfaces/APIs
> with less concurrency would allow us to write better code at the expense
> of less control and performance in cases where we don't need it.
> 
> That means insulate block jobs and drivers as much as possible.  Don't
> make them use low-level primitives.  Make them use high-level APIs where
> the concurrency is baked in and as safe as we can make it without giving
> up performance.
> 

Yes, we should take this step sooner rather than later.

Fam
