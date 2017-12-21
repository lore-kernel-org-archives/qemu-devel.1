Received: from eggs.gnu.org ([2001:4830:134:3::10]:42127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eS1kp-0002ix-Il
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:23:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eS1kl-0001nS-8n
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:23:23 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 21 Dec 2017 15:22:32 +0100
Message-Id: <20171221142251.18366-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/19] Drain fixes and cleanups, part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

This is the second part of my work to fix drain and hopefully to prevent
it from attracting bugs as much as it did in the past. There is
definitely at least a third part coming after this, see below.

In this series, the following improvments are made:
* Fix several bugs and inconsistencies
* Create lots of unit tests for the drain functions
* Introduce bdrv_subtree_drained_begin/end() to drain a whole subtree
  rather than only a single node
* Use this to make bdrv_reopen() safe (graph changes in callbacks
  called during its internal bdrv_drain_all() frequently broke it)

Planned for part three: Make graph modifications in callbacks safe by
avoiding BDRV_POLL_WHILE() calls while we're recursing through the
graph. We can recurse before BDRV_POLL_WHILE(), after it or while
evaluating its condition, but never call any callbacks while we're
iterating child or parent lists.

v2:
- Improved the commit message of patch 3 [Fam]
- Split the coroutine test cases in individual parts [Paolo]
- Export bdrv_(un)apply_subtree_drain  rather than
  bdrv_do_drained_begin/end() [Paolo]

Fam Zheng (1):
  block: Remove unused bdrv_requests_pending

Kevin Wolf (18):
  block: Assert drain_all is only called from main AioContext
  block: Make bdrv_drain() driver callbacks non-recursive
  test-bdrv-drain: Test callback for bdrv_drain
  test-bdrv-drain: Test bs->quiesce_counter
  blockjob: Pause job on draining any job BDS
  test-bdrv-drain: Test drain vs. block jobs
  block: Don't block_job_pause_all() in bdrv_drain_all()
  block: Nested drain_end must still call callbacks
  test-bdrv-drain: Test nested drain sections
  block: Don't notify parents in drain call chain
  block: Add bdrv_subtree_drained_begin/end()
  test-bdrv-drain: Tests for bdrv_subtree_drain
  test-bdrv-drain: Test behaviour in coroutine context
  test-bdrv-drain: Recursive draining with multiple parents
  block: Allow graph changes in subtree drained section
  test-bdrv-drain: Test graph changes in drained section
  commit: Simplify reopen of base
  block: Keep nodes drained between reopen_queue/multiple

 include/block/block.h     |  15 +-
 include/block/block_int.h |   6 +-
 block.c                   |  66 ++++--
 block/commit.c            |   8 +-
 block/io.c                | 151 +++++++++----
 block/replication.c       |   6 +
 blockjob.c                |  22 +-
 qemu-io-cmds.c            |   3 +
 tests/test-bdrv-drain.c   | 528 +++++++++++++++++++++++++++++++++++++++++++++-
 9 files changed, 717 insertions(+), 88 deletions(-)

-- 
2.13.6
