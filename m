Received: from eggs.gnu.org ([2001:4830:134:3::10]:47228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwSUo-0003VW-4C
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 08:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwSUn-00065X-9d
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 08:28:22 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Sep 2017 14:28:03 +0200
Message-Id: <20170925122808.14561-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] commit: Support multiple roots above top
 node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This is a step towards making the commit job flexible enough that it can
work with any kind of block graph. Currently, it requires that not only
the top and base node of the commit operation are specified, but also
the active layer of the backing file chain. Of course, the assumption
that a single active layer exists is invalid.

This series makes the commit job consider other roots as well so that
all parent nodes of the top node get their backing file updated and stay
valid after the commit job completes.

With this, we should have all of the prerequisites for a follow-up
series that adds a new and clean blockdev-commit QMP command which
doesn't require an option for the active layer and which accepts node
names instead of file names for base and top.

Kevin Wolf (5):
  block: Introduce BdrvChildRole.update_filename
  commit: Support multiple roots above top node
  qemu-iotests: Allow QMP pretty printing in common.qemu
  qemu-iotests: Test commit block job where top has two parents
  commit: Remove overlay_bs

 include/block/block.h          |   3 +-
 include/block/block_int.h      |   6 +
 block.c                        |  91 +++--
 block/commit.c                 |  64 +---
 tests/qemu-iotests/030         |   4 -
 tests/qemu-iotests/191         | 152 ++++++++
 tests/qemu-iotests/191.out     | 827 +++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/common.qemu |  14 +-
 tests/qemu-iotests/group       |   1 +
 9 files changed, 1078 insertions(+), 84 deletions(-)
 create mode 100755 tests/qemu-iotests/191
 create mode 100644 tests/qemu-iotests/191.out

-- 
2.13.5
