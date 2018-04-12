Received: from eggs.gnu.org ([2001:4830:134:3::10]:56948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f6dAG-00018L-J8
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 10:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f6dAF-0008Ip-9p
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 10:25:28 -0400
Date: Thu, 12 Apr 2018 16:25:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180412142519.GE5004@localhost.localdomain>
References: <20180411163940.2523-8-kwolf@redhat.com>
	<33c2ce2d-18d6-5479-19d4-3a1923cea3cb@redhat.com>
	<20180412095157.GA5004@localhost.localdomain>
	<f30ff8e9-4273-c01b-ae67-5784d5914c7a@redhat.com>
	<20180412111143.GB5004@localhost.localdomain>
	<569800ae-12f8-53f1-012a-50408700ba39@redhat.com>
	<20180412115316.GC5004@localhost.localdomain>
	<306e73f3-9e72-e60f-123c-47a8a72915e2@redhat.com>
	<20180412132735.GD5004@localhost.localdomain>
	<dc693c45-e1dc-5a3d-3c95-adcb946c65d6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc693c45-e1dc-5a3d-3c95-adcb946c65d6@redhat.com>
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

Am 12.04.2018 um 15:42 hat Paolo Bonzini geschrieben:
> On 12/04/2018 15:27, Kevin Wolf wrote:
> > Not sure I follow. Let's look at an example. Say, we have a block job
> > BlockBackend as the root (because that uses proper layering, unlike
> > devices which use aio_disable_external()), connected to a qcow2 node
> > over file.
> > 
> > 1. The block job issues a request to the qcow2 node
> > 
> > 2. In order to process that request, the qcow2 node internally issues
> >    one or more requests to the file node
> > 
> > 3. Someone calls bdrv_drained_begin(qcow2_node)
> > 
> > 4. We call BlockDriver.bdrv_drained_begin() for qcow2_node and
> >    file_node, and BdrvChildRole.drained_begin() for the block job.
> > 
> >    Now the block nodes don't create any new original requests any more
> >    (qcow2 and file don't do that anyway; qcow2 only creates requests to
> >    its children in the context of parent requests). The job potentially
> >    continues sending requests until it reaches the next pause point. The
> >    previously issued requests are still in flight.
> >
> >    Is this step what you meant by X->drv->bdrv_drain(X)? I don't see why
> >    pending requests can only be in X's children. Why can't the request
> >    be pending in X itself, say waiting for a thread pool worker
> >    decrypting a buffer?
> 
> No, that step is ->bdrv_co_drain_begin in BlockDriver.  It's where the
> "last" requests are sent to file_node after we know that qcow2_node
> won't get any more requests.

That's not really how .bdrv_co_drain_begin works. It is called first,
potentially long before we know that the parent won't send new requests
any more. All it does is preventing the node from creating new original
requests, i.e. internal requests that are not triggered by a parent
request.

> >    Also, note that after this series, the driver callbacks are called
> >    asynchronously, but I don't think it makes a big difference here.
> > 
> > 5. The file_node request completes. file_node doesn't have any requests
> >    in flight any more, but in theory it could still get new requests
> >    from qcow2_node. Anyway, let's say this is the last request, so I
> >    think we'd call its requests concluded?
> 
> No, if it can still get more requests they're not concluded.

Okay. In that case, we can't really determine any order, because the
whole subtree concludes when the root node concludes. (Ignoring any
additional parents, but the effect is the same: Children always conclude
at the same time as their last parent.)

> That's why we need to first ensure qcow2_node is quiescent, and before
> then we need to ensure that the BlockBackends are quiescent (in this
> case meaning the job has reached its pause point).  Only then we can
> look at file_node.  In this case we'll see that we have nothing to
> do---file_node is already quiescent---and bdrv_drained_begin() can
> return.

bdrv_drained_begin(qcow2_node) actually never looks at file_node. Only
bdrv_subtree_drained_begin(qcow2_node) would do so.

But what you're saying is essentially that for a subtree drain, we want
the following order in bdrv_drained_poll():

1. Check if a parent still has pending requests. If so, don't bother
   checking the rest.

2. Check the node the drain request was for. If so, don't bother looking
   at the children.

3. Finally, if all parents and the node itself are drained, look at the
   children.

This is already the order we have there. What is probably different from
what you envision is that after the parents have concluded, we still
check that they are still quiescent in every iteration.

What we could do easily is introducing a bool bs->quiesce_concluded or
something that bdrv_drain_poll() sets to true the first time that it
returns false. It also gets a shortcut so that it returns false
immediately if bs->quiesce_concluded is true. The field is reset in
bdrv_do_drained_end() when bs->quiesce_counter reaches 0.

That would be a rather simple optimisation that could be done as the
final patch in this series, and would ensure that we don't recurse back
to parents that are already quiescent.

Would you be happy with this change?

Kevin
