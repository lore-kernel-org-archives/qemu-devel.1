Received: from eggs.gnu.org ([2001:4830:134:3::10]:51660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHI-0004iR-RP
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHH-0006Bi-If
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:16 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Jun 2018 18:44:29 +0200
Message-Id: <20180618164504.24488-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/35] Block layer patches
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

The following changes since commit 2ef2f16781af9dee6ba6517755e9073ba5799f=
a2:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-2018=
0615a' into staging (2018-06-15 18:13:35 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 4c790afe2503eab12874508acab5b388d7babfd2:

  Merge remote-tracking branch 'mreitz/tags/pull-block-2018-06-18' into q=
ueue-block (2018-06-18 17:20:42 +0200)

----------------------------------------------------------------
Block layer patches:

- Active mirror (blockdev-mirror copy-mode=3Dwrite-blocking)
- bdrv_drain_*() fixes and test cases
- Fix crash with scsi-hd and drive_del

----------------------------------------------------------------
Greg Kurz (1):
      block: fix QEMU crash with scsi-hd and drive_del

Kevin Wolf (20):
      test-bdrv-drain: bdrv_drain() works with cross-AioContext events
      block: Use bdrv_do_drain_begin/end in bdrv_drain_all()
      block: Remove 'recursive' parameter from bdrv_drain_invoke()
      block: Don't manually poll in bdrv_drain_all()
      tests/test-bdrv-drain: bdrv_drain_all() works in coroutines now
      block: Avoid unnecessary aio_poll() in AIO_WAIT_WHILE()
      block: Really pause block jobs on drain
      block: Remove bdrv_drain_recurse()
      block: Drain recursively with a single BDRV_POLL_WHILE()
      test-bdrv-drain: Test node deletion in subtree recursion
      block: Don't poll in parent drain callbacks
      test-bdrv-drain: Graph change through parent callback
      block: Defer .bdrv_drain_begin callback to polling phase
      test-bdrv-drain: Test that bdrv_drain_invoke() doesn't poll
      block: Allow AIO_WAIT_WHILE with NULL ctx
      block: Move bdrv_drain_all_begin() out of coroutine context
      block: ignore_bds_parents parameter for drain functions
      block: Allow graph changes in bdrv_drain_all_begin/end sections
      test-bdrv-drain: Test graph changes in drain_all section
      Merge remote-tracking branch 'mreitz/tags/pull-block-2018-06-18' in=
to queue-block

Max Reitz (15):
      test-bdrv-drain: Add test for node deletion
      block/mirror: Pull out mirror_perform()
      block/mirror: Convert to coroutines
      block/mirror: Use CoQueue to wait on in-flight ops
      block/mirror: Wait for in-flight op conflicts
      block/mirror: Use source as a BdrvChild
      block: Generalize should_update_child() rule
      hbitmap: Add @advance param to hbitmap_iter_next()
      test-hbitmap: Add non-advancing iter_next tests
      block/dirty-bitmap: Add bdrv_dirty_iter_next_area
      block/mirror: Add MirrorBDSOpaque
      job: Add job_progress_increase_remaining()
      block/mirror: Add active mirroring
      block/mirror: Add copy mode QAPI interface
      iotests: Add test for active mirroring

 qapi/block-core.json         |  29 +-
 include/block/aio-wait.h     |  25 +-
 include/block/block.h        |  31 +-
 include/block/block_int.h    |  18 +-
 include/block/blockjob_int.h |   8 +
 include/block/dirty-bitmap.h |   2 +
 include/qemu/hbitmap.h       |   5 +-
 include/qemu/job.h           |  15 +
 block.c                      |  96 +++++-
 block/backup.c               |   2 +-
 block/block-backend.c        |   5 +
 block/dirty-bitmap.c         |  57 +++-
 block/io.c                   | 332 ++++++++++++--------
 block/mirror.c               | 613 +++++++++++++++++++++++++++++--------
 block/vvfat.c                |   1 +
 blockdev.c                   |   9 +-
 blockjob.c                   |  23 ++
 job.c                        |   5 +
 tests/test-bdrv-drain.c      | 705 +++++++++++++++++++++++++++++++++++++=
++++--
 tests/test-hbitmap.c         |  38 ++-
 util/hbitmap.c               |  10 +-
 tests/qemu-iotests/151       | 120 ++++++++
 tests/qemu-iotests/151.out   |   5 +
 tests/qemu-iotests/group     |   1 +
 24 files changed, 1836 insertions(+), 319 deletions(-)
 create mode 100755 tests/qemu-iotests/151
 create mode 100644 tests/qemu-iotests/151.out
