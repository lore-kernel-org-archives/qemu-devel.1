Received: from eggs.gnu.org ([2001:4830:134:3::10]:59640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dvLTu-0000T7-Tk
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:46:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dvLTu-0005vk-2F
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:46:50 -0400
Date: Fri, 22 Sep 2017 12:46:38 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170922104638.GC12295@localhost.localdomain>
References: <20170915101008.16646-1-kwolf@redhat.com>
	<20170915101008.16646-2-kwolf@redhat.com>
	<20170921135314.GD4677@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170921135314.GD4677@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/6] qemu-io: Reset qemuio_blk
 permissions before each command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, eblake@redhat.com

Am 21.09.2017 um 15:53 hat Kevin Wolf geschrieben:
> Am 15.09.2017 um 12:10 hat Kevin Wolf geschrieben:
> > qemu-io provides a 'reopen' command that allows switching from writable
> > to read-only access. We need to make sure that we don't try to keep
> > write permissions to a BlockBackend that becomes read-only, otherwise
> > things are going to fail.
> > 
> > command() already makes sure to request any additional permissions that
> > a qemu-io command requires, so just resetting the permissions to values
> > that are safe for read-only images is enough to fix this.
> > 
> > As a side effect, this makes the output of qemu-iotests case 187 more
> > consistent.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> 
> This seems to break qemu-iotests 077 and 081 for raw. I'll look into
> it tomorrow.

The problem seems to be related to 'aio_write': We already reset the
permissions while the request is still in flight and might still start
new internal requests that aren't allowed any more. We would have to
drain blk around resetting the permissions, but this would obviously
defeat the purpose of the aio_* commands.

I tried creating a separate temporary BB, but it doesn't seem to be that
straightforward (still crashes during 'aio_flush'). It would also
provide the wrong semantics, HMP 'qemu-io' commands are supposed to be
executed on the exact BlockBackend that was given.

So unless someone has an idea how to salvage this patch, I'm afraid I'll
just have to drop it. The original state isn't really correct either, but
it errs on the side of having more permissions than necessary, so
failure is less likely.

Kevin
