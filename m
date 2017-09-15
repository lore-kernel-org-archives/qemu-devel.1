Received: from eggs.gnu.org ([2001:4830:134:3::10]:37256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dsnZo-00026R-Ls
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 06:10:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dsnZn-0004Ic-PX
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 06:10:24 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 15 Sep 2017 12:10:02 +0200
Message-Id: <20170915101008.16646-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 0/6] block: Fix permissions after ro/rw reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

bdrv_reopen() can switch nodes between read-only and read-write modes.
This has implications for the required permissions on their child nodes.
For example, a qcow2 node requests write permissions on bs->file only if
it is writable itself.

This means that during bdrv_reopen(), the permissions need to be
recalculated in order to prevent failures where the bs->file
permissions don't match its actual read-only state (e.g. bs->file is a
read-write node, but the permission still enforces read-only access).

Kevin Wolf (6):
  qemu-io: Reset qemuio_blk permissions before each command
  block: Add reopen_queue to bdrv_child_perm()
  block: Add reopen queue to bdrv_check_perm()
  block: Base permissions on rw state after reopen
  block: reopen: Queue children after their parents
  block: Fix permissions after bdrv_reopen()

 include/block/block.h      |   2 +-
 include/block/block_int.h  |   7 ++
 block.c                    | 191 +++++++++++++++++++++++++++++++++------------
 block/commit.c             |   1 +
 block/mirror.c             |   1 +
 block/replication.c        |   1 +
 block/vvfat.c              |   1 +
 qemu-io.c                  |  13 +++
 tests/qemu-iotests/187.out |   2 +-
 9 files changed, 169 insertions(+), 50 deletions(-)

-- 
2.13.5
