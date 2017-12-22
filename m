Received: from eggs.gnu.org ([2001:4830:134:3::10]:56716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP6B-0005Fx-32
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:19:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP69-0001pI-R8
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:18:59 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 22 Dec 2017 16:18:11 +0100
Message-Id: <20171222151846.28110-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v3 00/35] Block layer patches
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

The following changes since commit 281f327487c9c9b1599f93c589a408bbf4a651=
b8:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.12-pull-re=
quest' into staging (2017-12-22 00:11:36 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 1a63a907507fbbcfaee3f622907ec244b7eabda8:

  block: Keep nodes drained between reopen_queue/multiple (2017-12-22 15:=
05:32 +0100)

----------------------------------------------------------------
Block layer patches

----------------------------------------------------------------
Doug Gale (1):
      nvme: Add tracing

Edgar Kaziakhmedov (1):
      qcow2: get rid of qcow2_backing_read1 routine

Fam Zheng (2):
      block: Open backing image in force share mode for size probe
      block: Remove unused bdrv_requests_pending

John Snow (1):
      iotests: fix 197 for vpc

Kevin Wolf (27):
      block: Formats don't need CONSISTENT_READ with NO_IO
      block: Make bdrv_drain_invoke() recursive
      block: Call .drain_begin only once in bdrv_drain_all_begin()
      test-bdrv-drain: Test BlockDriver callbacks for drain
      block: bdrv_drain_recurse(): Remove unused begin parameter
      block: Don't wait for requests in bdrv_drain*_end()
      block: Unify order in drain functions
      block: Don't acquire AioContext in hmp_qemu_io()
      block: Document that x-blockdev-change breaks quorum children list
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

Thomas Huth (3):
      block: Remove the obsolete -drive boot=3Don|off parameter
      block: Remove the deprecated -hdachs option
      block: Mention -drive cyls/heads/secs/trans/serial/addr in deprecat=
ion chapter

 qapi/block-core.json             |   4 +
 block/qcow2.h                    |   3 -
 include/block/block.h            |  15 +-
 include/block/block_int.h        |   6 +-
 block.c                          |  75 ++++-
 block/commit.c                   |   8 +-
 block/io.c                       | 164 +++++++---
 block/qcow2.c                    |  51 +--
 block/replication.c              |   6 +
 blockdev.c                       |  11 -
 blockjob.c                       |  22 +-
 hmp.c                            |   6 -
 hw/block/nvme.c                  | 349 +++++++++++++++++----
 qemu-io-cmds.c                   |   3 +
 tests/test-bdrv-drain.c          | 651 +++++++++++++++++++++++++++++++++=
++++++
 vl.c                             |  86 +-----
 hw/block/trace-events            |  93 ++++++
 qemu-doc.texi                    |  29 +-
 qemu-options.hx                  |  19 +-
 tests/Makefile.include           |   2 +
 tests/qemu-iotests/197           |   4 +
 tests/qemu-iotests/common.filter |   3 +-
 22 files changed, 1294 insertions(+), 316 deletions(-)
 create mode 100644 tests/test-bdrv-drain.c
