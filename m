Received: from eggs.gnu.org ([2001:4830:134:3::10]:58533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Pg9-0005bA-UX
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 23:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Pg8-0003ex-Vt
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 23:56:18 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 21 Apr 2017 11:55:46 +0800
Message-Id: <20170421035606.448-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v14 00/20] block: Image locking series
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

v14: - Replace BDRV_ flag with the "force-shared-write" block option. [Kevin]
     - Add bs->force_shared_write.
     - Update test case accordingly, back to bash again. :)
     - A few fixes in the locking code spotted by patchew and the new test,
       though the long line error is still there for readability.
     - Replace the workaround to drive-backup with a real fix in patch 17.

v13: - Address Max's comments.
     - Add reviewed-by from Max and Eric.
     - Rebase for 2.10:
       * Use op blocker API
       * Add --unsafe-read for qemu-img and qemu-io

Fam Zheng (20):
  block: Add, parse and store "force-shared-write" option
  qapi: Add 'force-shared-write' to blockdev-add arguments
  block: Respect "force-shared-write" in perm propagating
  qemu-img: Add --share-rw option to subcommands
  qemu-img: Update documentation for --share-rw
  qemu-io: Add --share-rw option
  iotests: 030: Prepare for image locking
  iotests: 046: Prepare for image locking
  iotests: 055: Don't attach the target image already for drive-backup
  iotests: 085: Avoid image locking conflict
  iotests: 087: Don't attach test image twice
  iotests: 091: Quit QEMU before checking image
  iotests: 172: Use separate images for multiple devices
  tests: Use null-co:// instead of /dev/null as the dummy image
  file-posix: Add 'locking' option
  tests: Disable image lock in test-replication
  block: Reuse bs as backing hd for drive-backup sync=none
  osdep: Add qemu_lock_fd and qemu_unlock_fd
  file-posix: Add image locking in perm operations
  qemu-iotests: Add test case 153 for image locking

 block.c                    |  40 ++-
 block/file-posix.c         | 744 ++++++++++++++++++++++++++++++++++++++++++++-
 blockdev.c                 |  15 +-
 include/block/block.h      |   2 +
 include/block/block_int.h  |   1 +
 include/qemu/osdep.h       |   3 +
 qapi/block-core.json       |   3 +
 qemu-img-cmds.hx           |  48 +--
 qemu-img.c                 | 155 +++++++---
 qemu-io.c                  |  35 ++-
 tests/drive_del-test.c     |   2 +-
 tests/nvme-test.c          |   2 +-
 tests/qemu-iotests/030     |  24 +-
 tests/qemu-iotests/046     |   2 +-
 tests/qemu-iotests/055     |  32 +-
 tests/qemu-iotests/085     |  34 ++-
 tests/qemu-iotests/085.out |   3 +-
 tests/qemu-iotests/087     |   6 +-
 tests/qemu-iotests/091     |   2 +
 tests/qemu-iotests/153     | 219 +++++++++++++
 tests/qemu-iotests/153.out | 627 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/172     |  55 ++--
 tests/qemu-iotests/172.out |  50 +--
 tests/qemu-iotests/group   |   1 +
 tests/test-replication.c   |   9 +-
 tests/usb-hcd-uhci-test.c  |   2 +-
 tests/usb-hcd-xhci-test.c  |   2 +-
 tests/virtio-blk-test.c    |   2 +-
 tests/virtio-scsi-test.c   |   4 +-
 util/osdep.c               |  48 +++
 30 files changed, 1988 insertions(+), 184 deletions(-)
 create mode 100755 tests/qemu-iotests/153
 create mode 100644 tests/qemu-iotests/153.out

-- 
2.9.3
