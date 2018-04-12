Received: from eggs.gnu.org ([2001:4830:134:3::10]:47594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6awC-0002Fr-RA
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 08:02:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6awC-0001js-15
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 08:02:48 -0400
References: <20180411163940.2523-1-kwolf@redhat.com>
	<20180411163940.2523-8-kwolf@redhat.com>
	<33c2ce2d-18d6-5479-19d4-3a1923cea3cb@redhat.com>
	<20180412095157.GA5004@localhost.localdomain>
	<f30ff8e9-4273-c01b-ae67-5784d5914c7a@redhat.com>
	<20180412111143.GB5004@localhost.localdomain>
	<569800ae-12f8-53f1-012a-50408700ba39@redhat.com>
	<20180412115316.GC5004@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <306e73f3-9e72-e60f-123c-47a8a72915e2@redhat.com>
Date: Thu, 12 Apr 2018 14:02:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180412115316.GC5004@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 12/04/2018 13:53, Kevin Wolf wrote:
>> The problem I have is that there is a direction through which I/O flows
>> (parent-to-child), so why can't draining follow that natural direction.
>> Having to check for the parents' I/O, while draining the child, seems
>> wrong.  Perhaps we can't help it, but I cannot understand the reason.
> I'm not sure what's there that could be not understood. You already
> confirmed that we need to drain the parents, too, when we drain a node.
> Drain really must propagate in the opposite direction of I/O, because
> part of its job is to quiesce the origin of any I/O to the node that
> should be drained. Opposite of I/O _is_ the natural direction for drain.

Opposite of I/O is the natural direction for drain to propagate, yes.

However, I/O direction is the natural direction for requests to stop.
After quiescing X and calling X->drv->bdrv_drain(X), there can be
pending requests only in X's children.  So I don't understand why you
need to keep checking in_flight over the whole subgraph, when there are
roots that will conclude their request first, and then their children,
and so on so forth.

Thanks,

Paolo

> We also have subtree drains, but that's not because that's the natural
> direction for drain, but just as a convenience function because some
> operations (e.g. reopen) affect a whole subtree, so they need everything
> in that subtree drained rather than just a single node.
