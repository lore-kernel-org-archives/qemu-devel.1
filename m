Received: from eggs.gnu.org ([2001:4830:134:3::10]:41855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f6anM-0004YU-TQ
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f6anL-0003TN-Vi
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:53:40 -0400
Date: Thu, 12 Apr 2018 13:53:16 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180412115316.GC5004@localhost.localdomain>
References: <20180411163940.2523-1-kwolf@redhat.com>
	<20180411163940.2523-8-kwolf@redhat.com>
	<33c2ce2d-18d6-5479-19d4-3a1923cea3cb@redhat.com>
	<20180412095157.GA5004@localhost.localdomain>
	<f30ff8e9-4273-c01b-ae67-5784d5914c7a@redhat.com>
	<20180412111143.GB5004@localhost.localdomain>
	<569800ae-12f8-53f1-012a-50408700ba39@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <569800ae-12f8-53f1-012a-50408700ba39@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/19] block: Really pause block jobs on
 drain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, famz@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

Am 12.04.2018 um 13:30 hat Paolo Bonzini geschrieben:
> On 12/04/2018 13:11, Kevin Wolf wrote:
> >> Well, there is one gotcha: bdrv_ref protects against disappearance, but
> >> bdrv_ref/bdrv_unref are not thread-safe.  Am I missing something else?
> >
> > Apart from the above, if we do an extra bdrv_ref/unref we'd also have
> > to keep track of all the nodes that we've referenced so that we unref
> > the same nodes again, even if the graph has changes.
> >
> > So essentially you'd be introducing a new list of BDSes that we have to
> > manage and then check for every reachable node whether it's already in
> > that list or not, and for every node in the list whether it's still
> > reachable.
> 
> That would be a hash table (a set), not a list, so easy to check.  But
> the thread-safety is a bigger issue.
> 
> The problem I have is that there is a direction through which I/O flows
> (parent-to-child), so why can't draining follow that natural direction.
> Having to check for the parents' I/O, while draining the child, seems
> wrong.  Perhaps we can't help it, but I cannot understand the reason.

I'm not sure what's there that could be not understood. You already
confirmed that we need to drain the parents, too, when we drain a node.
Drain really must propagate in the opposite direction of I/O, because
part of its job is to quiesce the origin of any I/O to the node that
should be drained. Opposite of I/O _is_ the natural direction for drain.

We also have subtree drains, but that's not because that's the natural
direction for drain, but just as a convenience function because some
operations (e.g. reopen) affect a whole subtree, so they need everything
in that subtree drained rather than just a single node.

Kevin
