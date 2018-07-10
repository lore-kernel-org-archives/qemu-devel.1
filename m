Received: from eggs.gnu.org ([2001:4830:134:3::10]:44186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcunT-00051H-Nu
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcunS-0001aI-No
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:23 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 10 Jul 2018 17:42:40 +0200
Message-Id: <20180710154304.18304-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 00/24] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

The following changes since commit b34181056c04e05db6c632063012beaee7006a37:

  Merge remote-tracking branch 'remotes/rth/tags/pull-sh4-20180709' into staging (2018-07-09 22:44:22 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to cd47d792d7a27a57f4b621e2ff1ed8f4e83de1e9:

  block: Use common write req handling in truncate (2018-07-10 16:46:22 +0200)

----------------------------------------------------------------
Block layer patches:

- Copy offloading fixes for when the copy increases the image size
- Temporary revert of the removal of deprecated -drive options
- Fix request serialisation in the image fleecing scenario
- Fix copy-on-read crash with unaligned image size
- Fix another drain crash

----------------------------------------------------------------
Ari Sundholm (2):
      qapi/block-core.json: Add missing documentation for blklogwrites log-append option
      block/blklogwrites: Make sure the log sector size is not too small

Cornelia Huck (4):
      Revert "block: Remove dead deprecation warning code"
      Revert "block: Remove deprecated -drive option serial"
      Revert "block: Remove deprecated -drive option addr"
      Revert "block: Remove deprecated -drive geometry options"

Fam Zheng (11):
      iotests: 222: Don't run with luks
      block: Prefix file driver trace points with "file_"
      block: Add copy offloading trace points
      block: Use BdrvChild to discard
      block: Use uint64_t for BdrvTrackedRequest byte fields
      block: Extract common write req handling
      block: Fix handling of image enlarging write
      block: Use common req handling for discard
      block: Use common req handling in copy offloading
      block: Fix bdrv_co_truncate overlap check
      block: Use common write req handling in truncate

Kevin Wolf (3):
      block: Poll after drain on attaching a node
      test-bdrv-drain: Test bdrv_append() to drained node
      block: Fix copy-on-read crash with partial final cluster

Vladimir Sementsov-Ogievskiy (4):
      block/io: fix copy_range
      block: split flags in copy_range
      block: add BDRV_REQ_SERIALISING flag
      block/backup: fix fleecing scheme: use serialized writes

 qapi/block-core.json           |   2 +
 include/block/block.h          |  41 +++++-
 include/block/block_int.h      |  21 ++-
 include/hw/block/block.h       |   1 +
 include/sysemu/block-backend.h |   3 +-
 include/sysemu/blockdev.h      |   3 +
 block.c                        |   2 +-
 block/backup.c                 |  20 ++-
 block/blkdebug.c               |   2 +-
 block/blklogwrites.c           |   7 +-
 block/blkreplay.c              |   2 +-
 block/block-backend.c          |   8 +-
 block/copy-on-read.c           |   2 +-
 block/file-posix.c             |  25 ++--
 block/file-win32.c             |   2 +-
 block/io.c                     | 318 ++++++++++++++++++++++++++++-------------
 block/iscsi.c                  |  12 +-
 block/mirror.c                 |   2 +-
 block/qcow2-refcount.c         |   2 +-
 block/qcow2.c                  |  20 +--
 block/raw-format.c             |  26 ++--
 block/throttle.c               |   2 +-
 blockdev.c                     | 110 ++++++++++++++
 device-hotplug.c               |   4 +
 hw/block/block.c               |  27 ++++
 hw/block/nvme.c                |   1 +
 hw/block/virtio-blk.c          |   1 +
 hw/ide/qdev.c                  |   1 +
 hw/scsi/scsi-disk.c            |   1 +
 hw/usb/dev-storage.c           |   1 +
 qemu-img.c                     |   2 +-
 tests/ahci-test.c              |   6 +-
 tests/hd-geo-test.c            |  37 ++++-
 tests/ide-test.c               |   8 +-
 tests/test-bdrv-drain.c        |  43 ++++++
 block/trace-events             |  10 +-
 hmp-commands.hx                |   1 +
 qemu-doc.texi                  |  15 ++
 qemu-options.hx                |  14 +-
 tests/qemu-iotests/197         |   9 ++
 tests/qemu-iotests/197.out     |   8 ++
 tests/qemu-iotests/222         |   2 +
 42 files changed, 647 insertions(+), 177 deletions(-)
