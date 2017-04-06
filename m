Received: from eggs.gnu.org ([2001:4830:134:3::10]:45959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cw8MD-0005S5-Tj
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cw8MC-0001eW-GD
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:25:53 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu,  6 Apr 2017 22:25:22 +0800
Message-Id: <20170406142527.25835-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 0/5] block: Fixes regarding dataplane
 and management operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

These are accumulated fixes that showed up when working on the "change"
issue and "repeated snapshot + commit" crash on dataplane:

    [Qemu-devel] [PATCH] blk: fix aio context loss on media change
        - Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

    [Qemu-devel] New iotest repros failures on virtio external snapshot with
    iothread
        - Ed Swierk <eswierk@skyportsystems.com>

Specifically, patch 4 is an output of the former, and the rest are from the
latter. They seem quite related hence this one series.

With this series applied, Ed's test case '176' passes (reran 10+ times):

    https://github.com/skyportsystems/qemu-1/commits/eswierk-iotests-2.9

NOTE: The "change" crash still needs Vladimir's fix. Patch 4 is noticed with a
few not-so-related WIP patches, but my understanding is this is a latent bug
and IMO the change is rather harmless to have.

Fam Zheng (5):
  block: Fix unpaired aio_disable_external in external snapshot
  mirror: Fix aio context of mirror_top_bs
  block: Quiesce old aio context during bdrv_set_aio_context
  block: Drain BH in bdrv_drained_begin
  coroutine: Explicitly specify AioContext when creating coroutine

 block.c                      | 23 +++++++++++++++++---
 block/blkverify.c            |  4 ++--
 block/block-backend.c        |  4 ++--
 block/io.c                   | 21 ++++++++++++-------
 block/mirror.c               |  1 +
 block/nbd-client.c           |  2 +-
 block/quorum.c               |  6 +++---
 block/sheepdog.c             |  4 ++--
 blockdev.c                   |  4 ++--
 blockjob.c                   |  2 +-
 hw/9pfs/9p.c                 |  4 ++--
 include/block/block.h        |  3 +++
 include/qemu/coroutine.h     |  3 ++-
 include/qemu/main-loop.h     |  2 +-
 migration/migration.c        |  3 ++-
 nbd/server.c                 |  6 ++++--
 qemu-img.c                   |  3 ++-
 qemu-io-cmds.c               |  3 ++-
 tests/test-aio-multithread.c | 12 +++++++----
 tests/test-coroutine.c       | 50 ++++++++++++++++++++++++++++++--------------
 tests/test-thread-pool.c     |  3 ++-
 util/qemu-coroutine.c        |  6 ++++--
 22 files changed, 113 insertions(+), 56 deletions(-)

-- 
2.9.3
