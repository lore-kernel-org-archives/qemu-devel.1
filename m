Received: from eggs.gnu.org ([2001:4830:134:3::10]:55111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d16tc-0006tM-BH
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d16tb-0003Fp-3Y
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:52:56 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 20 Apr 2017 15:52:17 +0800
Message-Id: <20170420075237.18219-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v13 00/20] block: Image locking series
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

v13: - Address Max's comments.
     - Add reviewed-by from Max and Eric.
     - Rebase for 2.10:
       * Use op blocker API
       * Add --unsafe-read for qemu-img and qemu-io

Fam Zheng (20):
  block: Introduce BDRV_O_UNSAFE_READ
  block: Drop consistent read perm if opened unsafe
  block: Don't require BLK_PERM_CONSISTENT_READ when unsafe open
  qemu-img: Add --unsafe-read option to subcommands
  qemu-img: Update documentation for --unsafe-read
  qemu-io: Add --unsafe-read option
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
  block: Workaround drive-backup sync=none for image locking
  osdep: Add qemu_lock_fd and qemu_unlock_fd
  file-posix: Add image locking in perm operations
  tests: Add test-image-lock

 block.c                    |  16 +-
 block/block-backend.c      |   2 +-
 block/file-posix.c         | 749 ++++++++++++++++++++++++++++++++++++++++++++-
 blockdev.c                 |   3 +
 include/block/block.h      |   1 +
 include/qemu/osdep.h       |   3 +
 qemu-img-cmds.hx           |  48 +--
 qemu-img.c                 | 148 +++++++--
 qemu-io.c                  |  31 +-
 tests/Makefile.include     |   2 +
 tests/drive_del-test.c     |   2 +-
 tests/nvme-test.c          |   2 +-
 tests/qemu-iotests/030     |  24 +-
 tests/qemu-iotests/046     |   2 +-
 tests/qemu-iotests/055     |  32 +-
 tests/qemu-iotests/085     |  34 +-
 tests/qemu-iotests/085.out |   3 +-
 tests/qemu-iotests/087     |   6 +-
 tests/qemu-iotests/091     |   2 +
 tests/qemu-iotests/172     |  55 ++--
 tests/qemu-iotests/172.out |  50 +--
 tests/test-image-lock.c    | 259 ++++++++++++++++
 tests/test-replication.c   |   9 +-
 tests/usb-hcd-uhci-test.c  |   2 +-
 tests/usb-hcd-xhci-test.c  |   2 +-
 tests/virtio-blk-test.c    |   2 +-
 tests/virtio-scsi-test.c   |   4 +-
 util/osdep.c               |  48 +++
 28 files changed, 1363 insertions(+), 178 deletions(-)
 create mode 100644 tests/test-image-lock.c

-- 
2.9.3
