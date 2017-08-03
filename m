Received: from eggs.gnu.org ([2001:4830:134:3::10]:59882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ddHeg-0002X6-3H
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:03:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ddHef-0006Vq-4C
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:03:18 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  3 Aug 2017 17:02:56 +0200
Message-Id: <20170803150301.10177-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 0/5] block: bdrv_reopen() fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

This is the first part of some fixes to bdrv_reopen(), which seems
reasonable enough to merge for 2.10.

There is much more wrong with bdrv_reopen() currently, especially with
respect to op blocker permissions (basically the required permissions
can change based on the options used in bdrv_reopen(), and both things
affect the whole tree and aren't integrated with each other at all), but
I have little hope to get this fixed before 2.10, so let's start with
what is ready now.

Kevin Wolf (5):
  block: Fix order in bdrv_replace_child()
  block: Allow reopen rw without BDRV_O_ALLOW_RDWR
  block: Set BDRV_O_ALLOW_RDWR during rw reopen
  qemu-io: Allow reopen read-write
  qemu-iotests: Test reopen between read-only and read-write

 include/block/block.h      |  3 +-
 block.c                    | 20 +++++++++-----
 qemu-io-cmds.c             | 19 +++++++++++--
 tests/qemu-iotests/187     | 69 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/187.out | 18 ++++++++++++
 tests/qemu-iotests/group   |  1 +
 6 files changed, 120 insertions(+), 10 deletions(-)
 create mode 100755 tests/qemu-iotests/187
 create mode 100644 tests/qemu-iotests/187.out

-- 
2.13.3
