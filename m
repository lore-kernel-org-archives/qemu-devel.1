Received: from eggs.gnu.org ([2001:4830:134:3::10]:60199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dtqpo-0004FB-35
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 03:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dtqpl-0002qS-20
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 03:51:16 -0400
Date: Mon, 18 Sep 2017 15:51:07 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170918075107.GK15551@lemon.lan>
References: <20170915101008.16646-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170915101008.16646-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] block: Fix permissions after ro/rw
 reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org

On Fri, 09/15 12:10, Kevin Wolf wrote:
> bdrv_reopen() can switch nodes between read-only and read-write modes.
> This has implications for the required permissions on their child nodes.
> For example, a qcow2 node requests write permissions on bs->file only if
> it is writable itself.
> 
> This means that during bdrv_reopen(), the permissions need to be
> recalculated in order to prevent failures where the bs->file
> permissions don't match its actual read-only state (e.g. bs->file is a
> read-write node, but the permission still enforces read-only access).

Passing reopen_queue around makes the interface and implementations complicated.
I wonder if any of the alternatives make sense:

1) Don't pass reopen_queue as a parameter, just pass the one interesting
BDRVReopenState pointer. So that callees don't need to call
bdrv_reopen_get_flags().

2) Don't change the prototypes at all, just change .bdrv_reopen_prepare contract
so that after it returns, .bdrv_child_perm/.bdrv_check_perm should comply to the
new state that would be commited once .bdrv_reopen_commit() is called, or
reverted if .bdrv_reopen_abort().

3) Don't change the prototypes at all, track the reopen progress in block.c
generically, (e.g. ignore conflicts and voilations) and update the permissions
only after bdrv_reopen_commit().

Fam

> 
> Kevin Wolf (6):
>   qemu-io: Reset qemuio_blk permissions before each command
>   block: Add reopen_queue to bdrv_child_perm()
>   block: Add reopen queue to bdrv_check_perm()
>   block: Base permissions on rw state after reopen
>   block: reopen: Queue children after their parents
>   block: Fix permissions after bdrv_reopen()
> 
>  include/block/block.h      |   2 +-
>  include/block/block_int.h  |   7 ++
>  block.c                    | 191 +++++++++++++++++++++++++++++++++------------
>  block/commit.c             |   1 +
>  block/mirror.c             |   1 +
>  block/replication.c        |   1 +
>  block/vvfat.c              |   1 +
>  qemu-io.c                  |  13 +++
>  tests/qemu-iotests/187.out |   2 +-
>  9 files changed, 169 insertions(+), 50 deletions(-)
> 
> -- 
> 2.13.5
> 
