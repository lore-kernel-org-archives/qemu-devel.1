Received: from eggs.gnu.org ([2001:4830:134:3::10]:52737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNm2-0004CN-Nw
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNm1-0001YS-Kq
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:22 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 16:25:42 +0200
Message-Id: <20180611142611.6609-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 00/29] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

The following changes since commit 9f55925b8f50a962d1d08d815044db7767ae3838:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-3.0-pull-request' into staging (2018-06-11 12:46:16 +0100)

are available in the Git repository at:

  git://github.com/XanClic/qemu.git tags/pull-block-2018-06-11

for you to fetch changes up to c50abd175a88cd41c2c08339de91f6f6e4a7b162:

  iotests: Add case for a corrupted inactive image (2018-06-11 16:18:45 +0200)

----------------------------------------------------------------
Block patches:
- Various bug fixes
- Removal of qemu-img convert's deprecated -s option
- qemu-io now exits with an error when a command failed

----------------------------------------------------------------
Alberto Garcia (1):
  throttle: Fix crash on reopen

Max Reitz (25):
  block/file-posix: Pass FD to locking helpers
  block/file-posix: File locking during creation
  iotests: Add creation test to 153
  qemu-img: Amendment support implies create_opts
  block: Add Error parameter to bdrv_amend_options
  qemu-option: Pull out "Supported options" print
  qemu-img: Add print_amend_option_help()
  qemu-img: Recognize no creation support in -o help
  iotests: Test help option for unsupporting formats
  iotests: Rework 113
  qcow2: Repair OFLAG_COPIED when fixing leaks
  iotests: Repairing error during snapshot deletion
  qemu-io: Drop command functions' return values
  qemu-io: Let command functions return error code
  qemu-io: Exit with error when a command failed
  iotests.py: Add qemu_io_silent
  iotests: Let 216 make use of qemu-io's exit code
  qemu-img: Resolve relative backing paths in rebase
  iotests: Add test for rebasing with relative paths
  qemu-img: Special post-backing convert handling
  iotests: Test post-backing convert target behavior
  iotests: Fix 219's timing
  block: Make bdrv_is_writable() public
  qcow2: Do not mark inactive images corrupt
  iotests: Add case for a corrupted inactive image

Thomas Huth (1):
  qemu-img: Remove deprecated -s snapshot_id_or_name option

Vladimir Sementsov-Ogievskiy (2):
  iotests: improve pause_job
  block/qcow2-bitmap: fix free_bitmap_clusters

 include/block/block.h         |   4 +-
 include/block/block_int.h     |   3 +-
 include/qemu-io.h             |   9 +-
 block.c                       |  25 ++-
 block/file-posix.c            |  64 ++++++--
 block/qcow2-bitmap.c          |   1 -
 block/qcow2-refcount.c        |  25 ++-
 block/qcow2.c                 |  74 +++++----
 block/throttle.c              |  54 ++++---
 qemu-img.c                    | 108 +++++++++++--
 qemu-io-cmds.c                | 276 +++++++++++++++++++---------------
 qemu-io.c                     |  62 +++++---
 util/qemu-option.c            |   1 -
 qemu-doc.texi                 |   7 -
 qemu-img-cmds.hx              |   4 +-
 qemu-img.texi                 |   7 +-
 tests/qemu-iotests/024        |  82 +++++++++-
 tests/qemu-iotests/024.out    |  30 ++++
 tests/qemu-iotests/029        |   2 +-
 tests/qemu-iotests/060        |  30 ++++
 tests/qemu-iotests/060.out    |  18 ++-
 tests/qemu-iotests/061.out    |   7 -
 tests/qemu-iotests/080        |   4 +-
 tests/qemu-iotests/080.out    |   4 +-
 tests/qemu-iotests/082        |   9 ++
 tests/qemu-iotests/082.out    |  53 ++++---
 tests/qemu-iotests/112.out    |   5 +-
 tests/qemu-iotests/113        |  19 ++-
 tests/qemu-iotests/113.out    |   7 +-
 tests/qemu-iotests/122        |  42 ++++++
 tests/qemu-iotests/122.out    |  18 +++
 tests/qemu-iotests/153        |  18 +++
 tests/qemu-iotests/153.out    |  13 ++
 tests/qemu-iotests/216        |  23 +--
 tests/qemu-iotests/216.out    |  17 +--
 tests/qemu-iotests/217        |  90 +++++++++++
 tests/qemu-iotests/217.out    |  42 ++++++
 tests/qemu-iotests/219        |  26 +++-
 tests/qemu-iotests/219.out    |  10 +-
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |  18 ++-
 41 files changed, 970 insertions(+), 342 deletions(-)
 create mode 100755 tests/qemu-iotests/217
 create mode 100644 tests/qemu-iotests/217.out

-- 
2.17.1
