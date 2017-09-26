Received: from eggs.gnu.org ([2001:4830:134:3::10]:60880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwqkC-0001I0-U6
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:21:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dwqk8-0005CV-3p
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:21:52 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 26 Sep 2017 16:21:09 +0200
Message-Id: <20170926142133.2498-1-kwolf@redhat.com>
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

The following changes since commit 1e3ee834083227f552179f6e43902cba5a866e6b:

  Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' into staging (2017-09-25 20:31:24 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to b156d51b62e6970753e1f9f36f7c4d5fdbf4c619:

  Merge remote-tracking branch 'mreitz/tags/pull-block-2017-09-26' into queue-block (2017-09-26 15:03:02 +0200)

----------------------------------------------------------------
Block layer patches

----------------------------------------------------------------
Alberto Garcia (1):
      throttle: Assert that bkt->max is valid in throttle_compute_wait()

Cornelia Huck (3):
      iotests: use -ccw on s390x for 040, 139, and 182
      iotests: use -ccw on s390x for 051
      iotests: use virtio aliases for 067

Fam Zheng (3):
      qemu-img: Clarify about relative backing file options
      file-posix: Clear out first sector in hdev_create
      iotests: Print full path of bad output if mismatch

Kevin Wolf (9):
      qemu-iotests: Add missing -machine accel=qtest
      qemu-io: Drop write permissions before read-only reopen
      block: Add reopen_queue to bdrv_child_perm()
      block: Add reopen queue to bdrv_check_perm()
      block: Base permissions on rw state after reopen
      block: reopen: Queue children after their parents
      block: Fix permissions after bdrv_reopen()
      qemu-iotests: Test change-backing-file command
      Merge remote-tracking branch 'mreitz/tags/pull-block-2017-09-26' into queue-block

Manos Pitsidianakis (1):
      block/throttle-groups.c: allocate RestartData on the heap

Pavel Butsykin (4):
      qemu-img: add --shrink flag for resize
      qcow2: add qcow2_cache_discard
      qcow2: add shrink image support
      qemu-iotests: add shrinking image test

Stefan Hajnoczi (1):
      docs: add qemu-block-drivers(7) man page

Thomas Huth (1):
      block: Clean up some bad code in the vvfat driver

Vladimir Sementsov-Ogievskiy (2):
      iotests: fix 181: enable postcopy-ram capability on target
      block/qcow2-bitmap: fix use of uninitialized pointer

 qapi/block-core.json          |   8 +-
 block/qcow2.h                 |  17 +
 include/block/block.h         |   2 +-
 include/block/block_int.h     |   7 +
 block.c                       | 191 +++++++---
 block/commit.c                |   1 +
 block/file-posix.c            |  10 +
 block/mirror.c                |   1 +
 block/qcow2-bitmap.c          |   2 +-
 block/qcow2-cache.c           |  26 ++
 block/qcow2-cluster.c         |  50 +++
 block/qcow2-refcount.c        | 140 +++++++-
 block/qcow2.c                 |  43 ++-
 block/replication.c           |   1 +
 block/throttle-groups.c       |  12 +-
 block/vvfat.c                 |  27 +-
 qemu-img.c                    |  23 ++
 qemu-io-cmds.c                |  12 +
 util/throttle.c               |   1 +
 Makefile                      |   6 +-
 docs/qemu-block-drivers.texi  | 804 ++++++++++++++++++++++++++++++++++++++++++
 qemu-doc.texi                 | 781 +---------------------------------------
 qemu-img-cmds.hx              |   4 +-
 qemu-img.texi                 |  15 +-
 tests/qemu-iotests/040        |   6 +-
 tests/qemu-iotests/051        |  12 +-
 tests/qemu-iotests/051.out    |   2 +-
 tests/qemu-iotests/051.pc.out |   2 +-
 tests/qemu-iotests/067        |   2 +-
 tests/qemu-iotests/067.out    |   2 +-
 tests/qemu-iotests/102        |   4 +-
 tests/qemu-iotests/106        |   2 +-
 tests/qemu-iotests/139        |  12 +-
 tests/qemu-iotests/163        | 170 +++++++++
 tests/qemu-iotests/163.out    |   5 +
 tests/qemu-iotests/172        |   2 +-
 tests/qemu-iotests/181        |   2 +
 tests/qemu-iotests/181.out    |   1 -
 tests/qemu-iotests/182        |  13 +-
 tests/qemu-iotests/186        |   6 +-
 tests/qemu-iotests/187.out    |   2 +-
 tests/qemu-iotests/195        |  92 +++++
 tests/qemu-iotests/195.out    |  78 ++++
 tests/qemu-iotests/check      |   2 +-
 tests/qemu-iotests/group      |   2 +
 45 files changed, 1708 insertions(+), 895 deletions(-)
 create mode 100644 docs/qemu-block-drivers.texi
 create mode 100644 tests/qemu-iotests/163
 create mode 100644 tests/qemu-iotests/163.out
 create mode 100755 tests/qemu-iotests/195
 create mode 100644 tests/qemu-iotests/195.out
