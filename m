Received: from eggs.gnu.org ([2001:4830:134:3::10]:54743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6cVV-0003UP-ON
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 09:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6cVU-0007FN-Qn
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 09:43:21 -0400
References: <20180411163940.2523-1-kwolf@redhat.com>
	<20180411163940.2523-8-kwolf@redhat.com>
	<33c2ce2d-18d6-5479-19d4-3a1923cea3cb@redhat.com>
	<20180412095157.GA5004@localhost.localdomain>
	<f30ff8e9-4273-c01b-ae67-5784d5914c7a@redhat.com>
	<20180412111143.GB5004@localhost.localdomain>
	<569800ae-12f8-53f1-012a-50408700ba39@redhat.com>
	<20180412115316.GC5004@localhost.localdomain>
	<306e73f3-9e72-e60f-123c-47a8a72915e2@redhat.com>
	<20180412132735.GD5004@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dc693c45-e1dc-5a3d-3c95-adcb946c65d6@redhat.com>
Date: Thu, 12 Apr 2018 15:42:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180412132735.GD5004@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, famz@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

On 12/04/2018 15:27, Kevin Wolf wrote:
> Not sure I follow. Let's look at an example. Say, we have a block job
> BlockBackend as the root (because that uses proper layering, unlike
> devices which use aio_disable_external()), connected to a qcow2 node
> over file.
>=20
> 1. The block job issues a request to the qcow2 node
>=20
> 2. In order to process that request, the qcow2 node internally issues
>    one or more requests to the file node
>=20
> 3. Someone calls bdrv_drained_begin(qcow2_node)
>=20
> 4. We call BlockDriver.bdrv_drained_begin() for qcow2_node and
>    file_node, and BdrvChildRole.drained_begin() for the block job.
>=20
>    Now the block nodes don't create any new original requests any more
>    (qcow2 and file don't do that anyway; qcow2 only creates requests to
>    its children in the context of parent requests). The job potentially
>    continues sending requests until it reaches the next pause point. Th=
e
>    previously issued requests are still in flight.
>
>    Is this step what you meant by X->drv->bdrv_drain(X)? I don't see wh=
y
>    pending requests can only be in X's children. Why can't the request
>    be pending in X itself, say waiting for a thread pool worker
>    decrypting a buffer?

No, that step is ->bdrv_co_drain_begin in BlockDriver.  It's where the
"last" requests are sent to file_node after we know that qcow2_node
won't get any more requests.

>    Also, note that after this series, the driver callbacks are called
>    asynchronously, but I don't think it makes a big difference here.
>=20
> 5. The file_node request completes. file_node doesn't have any requests
>    in flight any more, but in theory it could still get new requests
>    from qcow2_node. Anyway, let's say this is the last request, so I
>    think we'd call its requests concluded?

No, if it can still get more requests they're not concluded.  That's why
we need to first ensure qcow2_node is quiescent, and before then we need
to ensure that the BlockBackends are quiescent (in this case meaning the
job has reached its pause point).  Only then we can look at file_node.
In this case we'll see that we have nothing to do---file_node is already
quiescent---and bdrv_drained_begin() can return.

> 6. qcow2 still has a request in flight, but doesn't need to access
>    file_node for it. It finishes the work and therefore concludes its
>    requests as well. Note that qcow2_node (the parent) concludes after
>    file_node (the child).
>=20
> 7. We'll keep the example simple, so after completion of its request,
>    the job reaches a pause point without sending a new request. Again,
>    this happens after qcow2_node has concluded.
>=20
> 8. Only when neither file_node nor qcow2_node have a request in flight
>    and the job has reached a pause point, bdrv_drained_begin() can
>    return.
>=20
> So completing the last request and reaching an actually quiescent state
> looks very much like a process in child-to-parent order to me?
