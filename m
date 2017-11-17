Received: from eggs.gnu.org ([2001:4830:134:3::10]:42723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFlCM-0000kH-A3
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:17:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFlCL-0002A5-4B
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:17:06 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 17 Nov 2017 19:16:28 +0100
Message-Id: <20171117181653.20651-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 00/25] Block layer patches for 2.11.0-rc2
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

The following changes since commit fec035a53fa15c4c8c4e62bfef56a35df4161e38:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20171117-pull-request' into staging (2017-11-17 10:18:41 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to d5a49c6e7d9e42059450674ec845b7bc0d62cb7e:

  Merge remote-tracking branch 'mreitz/tags/pull-block-2017-11-17' into queue-block (2017-11-17 18:24:30 +0100)

----------------------------------------------------------------
Block layer patches for 2.11.0-rc2

----------------------------------------------------------------
Anton Nefedov (1):
      qcow2: reject unaligned offsets in write compressed

Daniel P. Berrange (2):
      qcow2: don't permit changing encryption parameters
      qcow2: fix image corruption after committing qcow2 image into base

Eric Blake (1):
      qcow2: fix image corruption on commit with persistent bitmap

Kevin Wolf (5):
      qemu-iotests: Use -nographic in 182
      block: Fix error path in bdrv_backing_update_filename()
      block: Deprecate bdrv_set_read_only() and users
      block: Fix permissions in image activation
      Merge remote-tracking branch 'mreitz/tags/pull-block-2017-11-17' into queue-block

Max Reitz (15):
      qapi/qnull: Add own header
      qapi/qlist: Add qlist_append_null() macro
      qapi: Add qobject_is_equal()
      block: qobject_is_equal() in bdrv_reopen_prepare()
      iotests: Add test for non-string option reopening
      tests: Add check-qobject for equality tests
      iotests: Add test for failing qemu-img commit
      qcow2: check_errors are fatal
      qcow2: Unaligned zero cluster in handle_alloc()
      block: Guard against NULL bs->drv
      qcow2: Add bounds check to get_refblock_offset()
      qcow2: Refuse to get unaligned offsets from cache
      qcow2: Fix overly broad madvise()
      block: Make bdrv_next() keep strong references
      iotests: Make 087 pass without AIO enabled

Vladimir Sementsov-Ogievskiy (1):
      iotests: test clearing unknown autoclear_features by qcow2

Wang Guang (1):
      replication: Fix replication open fail

 qapi/block-core.json             |   7 +-
 block/qcow2.h                    |   6 -
 include/block/block.h            |   1 +
 include/qapi/qmp/qbool.h         |   1 +
 include/qapi/qmp/qdict.h         |   2 +
 include/qapi/qmp/qlist.h         |   4 +
 include/qapi/qmp/qnull.h         |  32 ++++
 include/qapi/qmp/qnum.h          |   1 +
 include/qapi/qmp/qobject.h       |  21 ++-
 include/qapi/qmp/qstring.h       |   1 +
 include/qapi/qmp/types.h         |   1 +
 block.c                          |  90 ++++++++---
 block/block-backend.c            |  48 +++++-
 block/bochs.c                    |  13 +-
 block/cloop.c                    |  13 +-
 block/dmg.c                      |  12 +-
 block/io.c                       |  36 +++++
 block/qapi.c                     |   8 +-
 block/qcow2-cache.c              |  23 ++-
 block/qcow2-cluster.c            |  13 +-
 block/qcow2-refcount.c           |  26 +++-
 block/qcow2.c                    |  31 +++-
 block/rbd.c                      |  14 +-
 block/replication.c              |  26 +++-
 block/snapshot.c                 |   6 +
 block/vvfat.c                    |   8 +-
 migration/block.c                |   1 +
 qapi/qapi-clone-visitor.c        |   1 +
 qapi/string-input-visitor.c      |   1 +
 qobject/qbool.c                  |   8 +
 qobject/qdict.c                  |  29 ++++
 qobject/qlist.c                  |  32 ++++
 qobject/qnull.c                  |  11 +-
 qobject/qnum.c                   |  54 +++++++
 qobject/qobject.c                |  29 ++++
 qobject/qstring.c                |   9 ++
 tests/check-qnull.c              |   2 +-
 tests/check-qobject.c            | 328 +++++++++++++++++++++++++++++++++++++++
 scripts/coccinelle/qobject.cocci |   3 +
 tests/.gitignore                 |   1 +
 tests/Makefile.include           |   4 +-
 tests/qemu-iotests/020           |  27 ++++
 tests/qemu-iotests/020.out       |  17 ++
 tests/qemu-iotests/060           | 125 +++++++++++++++
 tests/qemu-iotests/060.out       | 115 ++++++++++++++
 tests/qemu-iotests/087           |   9 +-
 tests/qemu-iotests/133           |   9 ++
 tests/qemu-iotests/133.out       |   5 +
 tests/qemu-iotests/176           |  55 ++++++-
 tests/qemu-iotests/176.out       | 216 +++++++++++++++++++++++++-
 tests/qemu-iotests/182           |   2 +-
 tests/qemu-iotests/196           |  66 ++++++++
 tests/qemu-iotests/196.out       |   5 +
 tests/qemu-iotests/198           | 104 +++++++++++++
 tests/qemu-iotests/198.out       | 126 +++++++++++++++
 tests/qemu-iotests/common.filter |   4 +-
 tests/qemu-iotests/group         |   2 +
 57 files changed, 1751 insertions(+), 93 deletions(-)
 create mode 100644 include/qapi/qmp/qnull.h
 create mode 100644 tests/check-qobject.c
 create mode 100755 tests/qemu-iotests/196
 create mode 100644 tests/qemu-iotests/196.out
 create mode 100755 tests/qemu-iotests/198
 create mode 100644 tests/qemu-iotests/198.out
