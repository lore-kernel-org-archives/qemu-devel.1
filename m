Received: from eggs.gnu.org ([2001:4830:134:3::10]:53541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUDrF-0007yC-Di
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:38:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUDrE-00035V-HL
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:38:33 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu, 19 Jan 2017 22:38:00 +0800
Message-Id: <20170119143816.21972-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v10 00/16] block: Image locking series
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, rjones@redhat.com

v10: While we still don't have comprehensive propagation mechanism that will be
provided by new op blocker system for "permissive modes", the locking enabled
by default is regardlessly useful and long overdue. So I think we should merge
this for 2.9 and build user options on top later when the op blocker API
settles.

Address comments from Max and Eric:
  - Use F_OFD_GETLK instead of opening r/w for ro images. [Max]
  - Lock both bytes exclusively for non-shared write. [Max]
  - Spell fixes. [Eric]
  - Fix test matrix. [Max]
  - Comment tweaks. [Max]
  - Return code cleanups. [Max]
  - Don't abuse "disable_lock" for migration. [Max]
  - Use bs->exact_filename instead of bs->filename. [Max]
  - Force protect qcow2 concurrent write.
  - Fix indentation. [Max]
  - Always use re-open for lockfd instead of dup. [Max]
  - Fall through to "abort" where "prepare" failed. [Max]
  - Fix option handling in raw_reopen_handle_lock. [Max]
  - Use "error_abort" in commit and abort. [Max]
  - Fix cleanup of raw_reopen_handle_lock() failure. [Max]
  - Add a patch for qcow2 to mask BDRV_O_SHARE_RW if r/w.
  - Rebase and fix new more cases that will be broken by "lock by default".

Fam Zheng (16):
  osdep: Add qemu_lock_fd and qemu_unlock_fd
  block: Define BDRV_O_SHARE_RW
  qemu-io: Set "share-rw" flag together with read-only
  qemu-img: Set "share-rw" flag in read-only commands
  block: Set "share-rw" flag in drive-backup when sync=none
  iotests: 055: Don't attach the drive to vm for drive-backup
  iotests: 030: Read-only open image for getting map
  iotests: 087: Don't attach test image twice
  iotests: 085: Avoid image locking conflict
  iotests: 091: Quit QEMU before checking image
  iotests: 172: Use separate images for multiple devices
  tests: Use null-co:// instead of /dev/null as the dummy image
  tests: Disable image lock in test-replication
  file-posix: Implement image locking
  qcow2: Force "no other writer" lock on bs->file
  tests: Add test-image-lock

 block/file-posix.c         | 667 ++++++++++++++++++++++++++++++++++++++++++++-
 block/qcow2.c              |  11 +
 blockdev.c                 |   3 +
 include/block/block.h      |   2 +
 include/qemu/osdep.h       |   3 +
 qemu-img.c                 |  10 +-
 qemu-io.c                  |   2 +
 tests/Makefile.include     |   2 +
 tests/drive_del-test.c     |   2 +-
 tests/nvme-test.c          |   2 +-
 tests/qemu-iotests/030     |   4 +-
 tests/qemu-iotests/055     |  32 ++-
 tests/qemu-iotests/085     |  32 ++-
 tests/qemu-iotests/085.out |   3 +-
 tests/qemu-iotests/087     |   6 +-
 tests/qemu-iotests/091     |   2 +
 tests/qemu-iotests/172     |  53 ++--
 tests/qemu-iotests/172.out |  50 ++--
 tests/test-image-lock.c    | 200 ++++++++++++++
 tests/test-replication.c   |   9 +-
 tests/usb-hcd-uhci-test.c  |   2 +-
 tests/usb-hcd-xhci-test.c  |   2 +-
 tests/virtio-blk-test.c    |   2 +-
 tests/virtio-scsi-test.c   |   4 +-
 util/osdep.c               |  48 ++++
 25 files changed, 1056 insertions(+), 97 deletions(-)
 create mode 100644 tests/test-image-lock.c

-- 
2.9.3
