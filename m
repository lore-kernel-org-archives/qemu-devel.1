Received: from eggs.gnu.org ([2001:4830:134:3::10]:33284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eKM8I-0000IH-9b
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 05:31:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eKM8H-00009U-Bp
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 05:31:54 -0500
Date: Thu, 30 Nov 2017 11:31:35 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171130103135.GA4039@localhost.localdomain>
References: <20171129144956.11409-1-famz@redhat.com>
	<20171129172546.GG3753@localhost.localdomain>
	<20171130020359.GB16237@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171130020359.GB16237@lemon>
Subject: Re: [Qemu-devel] [PATCH RFC 0/9] block: Rewrite block drain
 begin/end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jcody@redhat.com, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

Am 30.11.2017 um 03:03 hat Fam Zheng geschrieben:
> On Wed, 11/29 18:25, Kevin Wolf wrote:
> > Am 29.11.2017 um 15:49 hat Fam Zheng geschrieben:
> > > While we look at the fixes for 2.11, I briefly prototyped this series
> > > to see if it makes sense as a simplification of the drain API for
> > > 2.12.
> > > 
> > > The idea is to let AioContext manage quiesce callbacks, then the block
> > > layer only needs to do the in-flight request waiting. This lets us get
> > > rid of the callback recursion (both up and down).
> > 
> > So essentially you don't drain individual nodes any more, but whole
> > AioContexts. I have a feeeling that this would be a step in the wrong
> > direction.
> > 
> > Not only would it completely bypass the path I/O requests take and
> > potentially drain a lot more than is actually necessary, but it also
> > requires that all nodes that are connected in a tree are in the same
> > AioContext.
> 
> Yeah, good point. Initially I wanted to introduce a BlockGraph object
> which manages the per-graph draining, (i.e. where to register the
> drain callbacks), but I felt lazy and used AioContext.
> 
> Will that make it better?  BlockGraph would be a proper abstraction
> and will not limit the API to one AioContext per tree.

There is only a single graph, so this would mean going back to global
bdrv_drain_all() exclusively.

What you really mean is probably connected components in the graph, but
do we really want to manage merging and splitting object representing
connected components when a node is added or removed from the graph?
Especially when that graph change occurs in a drain callback?

You can also still easily introduce bugs where graph changes during a
drain end up in nodes not being drained, possibly drained twice, you
still access the next pointer of a deleted node or you accidentally
switch to draining a different component.

It's probably possible to get this right, but essentially you're just
switching from iterating a tree to iterating a list. You get roughly the
same set of problems that you have to consider as today, and getting it
right should be about the same difficulty.

> > And finally, I don't really think that the recursion is even a problem.
> > The problem is with graph changes made by callbacks that drain allows to
> > run. With your changes, it might be a bit easier to avoid that
> > bdrv_drain() itself gets into trouble due to graph changes, but this
> > doesn't solve the problem for any (possibly indirect) callers of
> > bdrv_drain().
> 
> The recursion is the one big place that can be easily broken by graph changes,
> fixing this doesn't make the situation any worse. We could still fix the
> indirect callers by taking references or by introducing "ubiquitous coroutines".

But hiding a bug in 80% of the cases where it shows isn't enough.

I think the only real solution is to forbid graph changes until after
any critical operation has completed. I haven't tried it out in
practice, but I suppose we could use a CoMutex around them and take it
in bdrv_drained_begin/end() and all other places that can get into
trouble with graph changes.

Kevin
