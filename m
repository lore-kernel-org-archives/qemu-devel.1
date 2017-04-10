Received: from eggs.gnu.org ([2001:4830:134:3::10]:34178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxatD-0003CS-2B
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxatB-0001tX-Oj
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:05:59 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 10 Apr 2017 23:05:32 +0800
Message-Id: <20170410150542.30376-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for 2.9 v3 00/10] block: Fixes regarding
 dataplane and management operations
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

v3: Respin the unmerged changes from v2 and include one new fix:

    (Yes, it is a big series for the last -rc, and I personally prefer the v2
    approach for the 4-9 part of the problem, which is much more mechanical.)

    - 1, 2 are redoing previous patch 4, using bdrv_parent_drained_begin/end.
      [Kevin]
      Also fix the ordering against aio_context_release. [Stefan]
    - 3 is unchanged from patch 6 in v2.
    - 4-9 are reworking of patch 5 following Paolo's suggestion, which allowed
      better patch split.
    - 10 is finding of a latent bug, which is revealed by patch 9.

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

With this series, Ed's test case '176' now passes:

    https://github.com/skyportsystems/qemu-1/commits/eswierk-iotests-2.9

Fam Zheng (10):
  block: Make bdrv_parent_drained_begin/end public
  block: Quiesce old aio context during bdrv_set_aio_context
  tests/block-job-txn: Don't start block job before adding to txn
  coroutine: Extract qemu_aio_coroutine_enter
  async: Introduce aio_co_enter and aio_co_enter_if_inactive
  block: Introduce bdrv_coroutine_enter and *_if_inactive
  blockjob: Use bdrv_coroutine_enter to start coroutine
  qemu-io-cmds: Use bdrv_coroutine_enter
  block: Use bdrv_coroutine_enter to start I/O coroutines
  block: Fix bdrv_co_flush early return

 block.c                    | 17 +++++++++++++++--
 block/block-backend.c      |  4 ++--
 block/io.c                 | 34 ++++++++++++++++++----------------
 blockjob.c                 |  4 ++--
 include/block/aio.h        | 18 ++++++++++++++++++
 include/block/block.h      | 27 +++++++++++++++++++++++++++
 include/qemu/coroutine.h   |  5 +++++
 qemu-io-cmds.c             |  2 +-
 tests/qemu-iotests/109.out | 10 +++++-----
 tests/test-blockjob-txn.c  |  6 +++++-
 util/async.c               | 14 +++++++++++++-
 util/qemu-coroutine.c      | 11 ++++++++---
 util/trace-events          |  2 +-
 13 files changed, 120 insertions(+), 34 deletions(-)

-- 
2.9.3
