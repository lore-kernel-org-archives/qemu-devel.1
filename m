Received: from eggs.gnu.org ([2001:4830:134:3::10]:45910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cwNn1-0007kJ-Ga
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 02:54:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cwNn0-0004NZ-FO
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 02:54:35 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  7 Apr 2017 14:54:08 +0800
Message-Id: <20170407065414.9143-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/6] block: Fixes regarding dataplane and
 management operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

v2: - Drop patch 4 in v1. A second thought made me feel neither it nor Kevin's
      suggestion to move the BH process to bdrv_drain_recurse/BDRV_POLL_WHILE
      is a complete fix. So leave it for a separate patch.
    - Add rev-by to patches 1, 3, 4.
    - Split from patch 1 in v1 and add patch 2, for the new assertions. [Kevin]
    - Rewrite patch 5. Fix block job's co when a BDS is moved to a different
      aio context. [Kevin]
    - Add patch 6.

Crashes are reported on dataplane devices when doing snapshot and commit under
guest I/O.

With this series, Ed's test case '176' now passes (reran 10+ times):

    https://github.com/skyportsystems/qemu-1/commits/eswierk-iotests-2.9

The biggest fix for this is patch 5, which fixes a race condition between main
thread and iothread.

Fam Zheng (6):
  block: Fix unpaired aio_disable_external in external snapshot
  block: Assert attached child node has right aio context
  mirror: Fix aio context of mirror_top_bs
  block: Quiesce old aio context during bdrv_set_aio_context
  coroutine: Explicitly specify AioContext when entering coroutine
  tests/block-job-txn: Don't start block job before adding to txn

 block.c                    | 30 ++++++++++++++++++++++++++----
 block/blkdebug.c           |  4 ++--
 block/blkverify.c          |  8 ++++----
 block/block-backend.c      |  4 ++--
 block/io.c                 | 14 +++++++-------
 block/mirror.c             |  3 ++-
 block/quorum.c             | 16 ++++++++--------
 block/sheepdog.c           |  4 ++--
 blockdev.c                 |  4 ++--
 blockjob.c                 |  4 ++--
 hw/9pfs/9p.c               |  4 ++--
 hw/9pfs/coth.c             |  4 ++--
 include/block/block.h      | 11 +++++++++++
 include/qemu/coroutine.h   | 11 ++++++-----
 include/qemu/main-loop.h   |  2 +-
 migration/colo.c           |  3 ++-
 migration/migration.c      |  2 +-
 nbd/server.c               |  5 +++--
 qemu-img.c                 |  4 ++--
 qemu-io-cmds.c             |  2 +-
 tests/test-blockjob-txn.c  |  6 +++++-
 tests/test-coroutine.c     | 41 +++++++++++++++++++++--------------------
 tests/test-thread-pool.c   |  2 +-
 util/async.c               |  4 ++--
 util/qemu-coroutine-io.c   |  3 ++-
 util/qemu-coroutine-lock.c |  6 ++++--
 util/qemu-coroutine.c      | 10 +++++-----
 util/trace-events          |  2 +-
 28 files changed, 129 insertions(+), 84 deletions(-)

-- 
2.9.3
