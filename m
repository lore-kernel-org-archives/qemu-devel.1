Received: from eggs.gnu.org ([2001:4830:134:3::10]:35465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTrGw-0005Qp-7G
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:08:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTrGv-0008Gu-92
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:08:22 -0400
Date: Fri, 15 Jun 2018 18:08:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180615160813.GF5187@localhost.localdomain>
References: <20180529172156.29311-1-kwolf@redhat.com>
	<20180611122314.GF15038@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611122314.GF15038@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 00/20] Drain fixes and
 cleanups, part 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com

Am 11.06.2018 um 14:23 hat Kevin Wolf geschrieben:
> ping?
> 
> Am 29.05.2018 um 19:21 hat Kevin Wolf geschrieben:
> > This is the third and hopefully for now last part of my work to fix
> > drain. The main goal of this series is to make drain robust against
> > graph changes that happen in any callbacks of in-flight requests while
> > we drain a block node.
> > 
> > The individual patches describe the details, but the rough plan is to
> > change all three drain types (single node, subtree and all) to work like
> > this:
> > 
> > 1. First call all the necessary callbacks to quiesce external sources
> >    for new requests. This includes the block driver callbacks, the child
> >    node callbacks and disabling external AioContext events. This is done
> >    recursively.
> > 
> >    Much of the trouble we had with drain resulted from the fact that the
> >    graph changed while we were traversing the graph recursively. None of
> >    the callbacks called in this phase may change the graph.
> > 
> > 2. Then do a single AIO_WAIT_WHILE() to drain the requests of all
> >    affected nodes. The aio_poll() called by it is where graph changes
> >    can happen and we need to be careful.
> > 
> >    However, while evaluating the loop condition, the graph can't change,
> >    so we can safely call all necessary callbacks, if needed recursively,
> >    to determine whether there are still pending requests in any affected
> >    nodes. We just need to make sure that we don't rely on the set of
> >    nodes being the same between any two evaluation of the condition.
> > 
> > There are a few more smaller, mostly self-contained changes needed
> > before we're actually safe, but this is the main mechanism that will
> > help you understand what we're working towards during the series.

Without objection, applied to the block branch.

Kevin
