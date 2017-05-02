Received: from eggs.gnu.org ([2001:4830:134:3::10]:40868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5T1A-0005bg-7e
	for qemu-devel@nongnu.org; Tue, 02 May 2017 04:18:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5T19-0007XV-0n
	for qemu-devel@nongnu.org; Tue, 02 May 2017 04:18:44 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue,  2 May 2017 16:18:10 +0800
Message-Id: <20170502081832.9546-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v16 00/22] block: Image locking series
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

v16: Rebase to the latest block-next branch of Kevin.
     Address Kevin's comments:
     - on/off => on/off/auto for file.locking option
     - Add file.locking to QAPI schema
     - Fall back to POSIX file lock if OFD lock not available
     - Print warning when falling back, if locking=on specified
       (This means qemu-io/qemu-img need --image-opts to enable lock)
     - Drop the BLK_PERM_MAX patch and use an alternative
     - Use the 'TEST_IMG="$TEST_IMG.base" _make_test_img ...' idiom
     - Drop reopen callback changes
     - Don't open s->lock_fd if !s->use_lock
     - Use the same open flags for the lock fd
     - Don't leak the returned string for bdrv_perm_names
     - Clear up comment on raw_apply_lock_bytes
     - Improve error message text
     - Pass "0, 0" to raw_handle_perm_lock in raw_abort_perm_update
     - Filter out test dir in reference output
     - Add locking to bdrv_host_device.

v15: Rework a number of things, especially around what and how lockings are
     done.  [Kevin]
     - Map each permission to a locked byte.
     - Make the new option --force-share-perms, and require read-only=on.
     - Update test case 153 accordingly.
     - Only add -U where necessary in iotest 030.
     - Reject -U if conflicting with image opts in qemu-img/qemu-io.

v14: Replace BDRV_ flag with the "force-shared-write" block option. [Kevin]
     Add bs->force_shared_write.
     Update test case accordingly.
     A few fixes in the locking code spotted by patchew and the new test,
     though the long line error is still there for readability.
     Replace the workaround to drive-backup with a real fix in patch 17.

v13: - Address Max's comments.
     - Add reviewed-by from Max and Eric.
     - Rebase for 2.10:
       * Use op blocker API
       * Add --unsafe-read for qemu-img and qemu-io

Fam Zheng (22):
  block: Make bdrv_perm_names public
  block: Add, parse and store "force-share" option
  block: Respect "force-share" in perm propagating
  qemu-img: Add --force-share option to subcommands
  qemu-img: Update documentation for -U
  qemu-io: Add --force-share option
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
  osdep: Fall back to posix lock when OFD lock is unavailable
  file-posix: Add image locking to perm operations
  qemu-iotests: Add test case 153 for image locking
  tests: Add POSIX image locking test case 182

 block.c                    |  51 ++++--
 block/file-posix.c         | 281 +++++++++++++++++++++++++++++++-
 blockdev.c                 |  15 +-
 include/block/block.h      |   3 +
 include/block/block_int.h  |   1 +
 include/qemu/osdep.h       |   3 +
 qapi/block-core.json       |   7 +
 qemu-img-cmds.hx           |  36 ++---
 qemu-img.c                 | 154 +++++++++++++-----
 qemu-io.c                  |  42 ++++-
 tests/drive_del-test.c     |   2 +-
 tests/nvme-test.c          |   2 +-
 tests/qemu-iotests/030     |  18 +--
 tests/qemu-iotests/046     |   2 +-
 tests/qemu-iotests/055     |  32 ++--
 tests/qemu-iotests/085     |  33 ++--
 tests/qemu-iotests/085.out |   3 +-
 tests/qemu-iotests/087     |   6 +-
 tests/qemu-iotests/091     |   2 +
 tests/qemu-iotests/153     | 247 ++++++++++++++++++++++++++++
 tests/qemu-iotests/153.out | 390 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/172     |  55 ++++---
 tests/qemu-iotests/172.out |  50 +++---
 tests/qemu-iotests/182     |  73 +++++++++
 tests/qemu-iotests/182.out |   8 +
 tests/qemu-iotests/group   |   2 +
 tests/test-replication.c   |   9 +-
 tests/usb-hcd-uhci-test.c  |   2 +-
 tests/usb-hcd-xhci-test.c  |   2 +-
 tests/virtio-blk-test.c    |   2 +-
 tests/virtio-scsi-test.c   |   5 +-
 util/osdep.c               |  48 ++++++
 32 files changed, 1412 insertions(+), 174 deletions(-)
 create mode 100755 tests/qemu-iotests/153
 create mode 100644 tests/qemu-iotests/153.out
 create mode 100755 tests/qemu-iotests/182
 create mode 100644 tests/qemu-iotests/182.out

-- 
2.9.3
