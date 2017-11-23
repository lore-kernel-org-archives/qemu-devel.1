Received: from eggs.gnu.org ([2001:4830:134:3::10]:50342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHvJk-00086A-2V
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 12:29:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHvJj-0004ak-6E
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 12:29:40 -0500
Date: Thu, 23 Nov 2017 18:29:27 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171123172927.GD4375@localhost.localdomain>
References: <c4532ef7-6e05-d14a-21de-1b8381aa2112@redhat.com>
	<1511456107-7081-1-git-send-email-deepa.srinivasan@oracle.com>
	<3DFDA265-8685-4601-B981-1BB0007C44B4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DFDA265-8685-4601-B981-1BB0007C44B4@oracle.com>
Subject: Re: [Qemu-devel] [PATCH] block: Fix qemu crash when using scsi-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Deepa Srinivasan <deepa.srinivasan@oracle.com>
Cc: stefanha@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mark.kanda@oracle.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Am 23.11.2017 um 18:05 hat Deepa Srinivasan geschrieben:
> blk_aio_prwv() now takes a void pointer and the coroutine functions
> have been modified to cast it into QEMUIOVector if needed. It does not
> use an union in BlkRwCo since this leads to code - blk_aio_prwv()
> would have to write to the void pointer member, but coroutines would
> sometimes read the QEMUIOVector member. Paolo also suggested not using
> a union.

I don't particularly like void pointers, but I guess it's fair enough.

> Note that a similar issue exists in
> blk_ioctl()/blk_ioctl_entry()/blk_prw() where blk_prw() always creates
> the QEMUIOVector even if blk_ioctl()/blk_ioctl_entry() does not need a
> QEMUIOVector. This will need to be fixed separately to keep it
> consistent with the AIO path.

I don't think there is an actual problem in the blk_ioctl() path because
the iov on the stack stays valid as long as the coroutine runs. AIO is
different because it returns before the coroutine has terminated.

Kevin
