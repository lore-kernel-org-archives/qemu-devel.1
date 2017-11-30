Received: from eggs.gnu.org ([2001:4830:134:3::10]:37585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eKQUF-0003Ov-GP
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:10:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eKQUE-0007ja-39
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:10:51 -0500
Date: Thu, 30 Nov 2017 16:10:38 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171130151038.GE4039@localhost.localdomain>
References: <20171129144956.11409-1-famz@redhat.com>
	<20171129172546.GG3753@localhost.localdomain>
	<20171130020359.GB16237@lemon>
	<20171130103135.GA4039@localhost.localdomain>
	<20171130143430.GA24067@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171130143430.GA24067@lemon>
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

Am 30.11.2017 um 15:34 hat Fam Zheng geschrieben:
> On Thu, 11/30 11:31, Kevin Wolf wrote:
> > What you really mean is probably connected components in the graph, but
> > do we really want to manage merging and splitting object representing
> > connected components when a node is added or removed from the graph?
> > Especially when that graph change occurs in a drain callback?
> > 
> > You can also still easily introduce bugs where graph changes during a
> > drain end up in nodes not being drained, possibly drained twice, you
> > still access the next pointer of a deleted node or you accidentally
> > switch to draining a different component.
> > 
> > It's probably possible to get this right, but essentially you're just
> > switching from iterating a tree to iterating a list. You get roughly the
> > same set of problems that you have to consider as today, and getting it
> > right should be about the same difficulty.
> 
> Not quite. The essential idea is redo the drain begin/end in a correct way:
> 
> bdrv_drained_begin(bs):
>     1.a) stop all sources of new requests in the connected components, including
>         * aio_disable_external()
>         * stop QED timer
>         * stop block job
>     1.b) aio_poll() until:
>         * no request is in flight for bs
>         * no progress is made (any progress may generate new requests)
> 
> bdrv_drained_end(bs):
>     2.a) resume stopped sources of new requests
>     2.b) no need to do aio_poll() because the main loop will move on
> 
> 1.a) can be either done with either a graph recursion like now, or a list
> traversing if managed somewhere, like in this series. Or better, BlockGraph will
> be the manager. The rule is that these operations will not cause graph change,
> so it's an improvement.
> 
> 1.b) doesn't need recursion IMO, only looking at bs->in_flight and the return
> value of aio_poll() should be enough.

The trouble is with 1.b), which can cause graph changes, including nodes
being added to or removed from a connected component. This means that
you can get nodes in the component for which 1.a) hasn't been executed,
or nodes that are outside the component, but for which 1.a) has still
been executed.

You then need to compensate for that somehow, and basically execute 1.a)
for any new nodes (otherwise you have nodes in the component that could
still be issuing requests; skipping drained_end for them is not enough)
and execute 2.*) for the removed ones.

> For 2.a) if the drain begin/end callbacks are mananged in a list, it's
> easy to only call drained_end() for entries that got drained_begin()
> earlier, as shown in patch 2.

Yes, but not draining them was a bug in the first place.

I'll give you that trying to separate 1.a) and 1.b) so that we have only
a single BDRV_POLL_WHILE() after the most critical code, is an
interesting idea. But as long as 1.b) can involve graph changes, it
remains quite tricky.

And of course, it can't solve the problem with graph changes in callers
of bdrv_drained_begin/end because at least one BDRV_POLL_WHILE() will
stay there that can cause graph changes.

> > > > And finally, I don't really think that the recursion is even a problem.
> > > > The problem is with graph changes made by callbacks that drain allows to
> > > > run. With your changes, it might be a bit easier to avoid that
> > > > bdrv_drain() itself gets into trouble due to graph changes, but this
> > > > doesn't solve the problem for any (possibly indirect) callers of
> > > > bdrv_drain().
> > > 
> > > The recursion is the one big place that can be easily broken by graph changes,
> > > fixing this doesn't make the situation any worse. We could still fix the
> > > indirect callers by taking references or by introducing "ubiquitous coroutines".
> > 
> > But hiding a bug in 80% of the cases where it shows isn't enough.
> 
> I think they are separate bugs. And with the one that this series is fixing,
> others (bdrv_drain*() callers') may even not show up, because
> bdrv_drained_begin() crashed already.
> 
> > 
> > I think the only real solution is to forbid graph changes until after
> > any critical operation has completed. I haven't tried it out in
> > practice, but I suppose we could use a CoMutex around them and take it
> > in bdrv_drained_begin/end() and all other places that can get into
> > trouble with graph changes.
> 
> Yes, I agree, but that (using CoMutex around graph change) requires
> everything, especially the defer_to_main_loop_bh, runs in a coroutine
> context, which is exactly what I mean by "introducing 'ubiquitous
> coroutines'", because currently we don't have them.

Is it hard to do, though? Instead of using a BH to switch to the main
loop and outside of coroutine context, you could use aio_co_schedule()
and yield, which would leave you in the main loop, but still in
coroutine context.

Would this have any bad side effects I'm not aware of?

I'm not sure about other places, of course. We'd have to check that.

Kevin
