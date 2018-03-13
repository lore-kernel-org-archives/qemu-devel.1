Received: from eggs.gnu.org ([2001:4830:134:3::10]:59151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmd3-0001G4-2R
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmcy-0004UE-To
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:21 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Mar 2018 17:17:22 +0100
Message-Id: <20180313161803.1814-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/41] Block layer patches
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

The following changes since commit 22ef7ba8e8ce7fef297549b3defcac333742b8=
04:

  Merge remote-tracking branch 'remotes/famz/tags/staging-pull-request' i=
nto staging (2018-03-13 11:42:45 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to be6c885842efded81a20f4ca24f0d4e123a80c00:

  block/mirror: change the semantic of 'force' of block-job-cancel (2018-=
03-13 16:54:47 +0100)

----------------------------------------------------------------
Block layer patches

----------------------------------------------------------------
Fam Zheng (2):
      block: Fix flags in reopen queue
      iotests: Add regression test for commit base locking

John Snow (21):
      blockjobs: fix set-speed kick
      blockjobs: model single jobs as transactions
      Blockjobs: documentation touchup
      blockjobs: add status enum
      blockjobs: add state transition table
      iotests: add pause_wait
      blockjobs: add block_job_verb permission table
      blockjobs: add ABORTING state
      blockjobs: add CONCLUDED state
      blockjobs: add NULL state
      blockjobs: add block_job_dismiss
      blockjobs: ensure abort is called for cancelled jobs
      blockjobs: add commit, abort, clean helpers
      blockjobs: add block_job_txn_apply function
      blockjobs: add prepare callback
      blockjobs: add waiting status
      blockjobs: add PENDING status and event
      blockjobs: add block-job-finalize
      blockjobs: Expose manual property
      iotests: test manual job dismissal
      tests/test-blockjob: test cancellations

Kevin Wolf (14):
      luks: Separate image file creation from formatting
      luks: Create block_crypto_co_create_generic()
      luks: Support .bdrv_co_create
      luks: Turn invalid assertion into check
      luks: Catch integer overflow for huge sizes
      qemu-iotests: Test luks QMP image creation
      parallels: Support .bdrv_co_create
      qemu-iotests: Enable write tests for parallels
      qcow: Support .bdrv_co_create
      qed: Support .bdrv_co_create
      vdi: Make comments consistent with other drivers
      vhdx: Support .bdrv_co_create
      vpc: Support .bdrv_co_create
      vpc: Require aligned size in .bdrv_co_create

Liang Li (1):
      block/mirror: change the semantic of 'force' of block-job-cancel

Max Reitz (3):
      vdi: Pull option parsing from vdi_co_create
      vdi: Move file creation to vdi_co_create_opts
      vdi: Implement .bdrv_co_create

 qapi/block-core.json          | 363 ++++++++++++++++++++++++++++++++++++=
++++--
 include/block/blockjob.h      |  71 ++++++++-
 include/block/blockjob_int.h  |  17 +-
 block.c                       |   8 +
 block/backup.c                |   5 +-
 block/commit.c                |   2 +-
 block/crypto.c                | 150 ++++++++++++-----
 block/mirror.c                |  12 +-
 block/parallels.c             | 199 +++++++++++++++++------
 block/qcow.c                  | 196 +++++++++++++++--------
 block/qed.c                   | 204 ++++++++++++++++--------
 block/stream.c                |   2 +-
 block/vdi.c                   | 147 +++++++++++++----
 block/vhdx.c                  | 216 +++++++++++++++++++------
 block/vpc.c                   | 241 +++++++++++++++++++++-------
 blockdev.c                    |  71 +++++++--
 blockjob.c                    | 358 +++++++++++++++++++++++++++++++++++-=
-----
 tests/test-bdrv-drain.c       |   5 +-
 tests/test-blockjob-txn.c     |  27 ++--
 tests/test-blockjob.c         | 233 ++++++++++++++++++++++++++-
 block/trace-events            |   7 +
 hmp-commands.hx               |   3 +-
 tests/qemu-iotests/030        |   6 +-
 tests/qemu-iotests/055        |  17 +-
 tests/qemu-iotests/056        | 187 ++++++++++++++++++++++
 tests/qemu-iotests/056.out    |   4 +-
 tests/qemu-iotests/109.out    |  24 +--
 tests/qemu-iotests/153        |  12 ++
 tests/qemu-iotests/153.out    |   5 +
 tests/qemu-iotests/181        |   2 +-
 tests/qemu-iotests/209        | 210 ++++++++++++++++++++++++
 tests/qemu-iotests/209.out    | 136 ++++++++++++++++
 tests/qemu-iotests/check      |   1 -
 tests/qemu-iotests/common.rc  |   2 +-
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |  12 +-
 36 files changed, 2642 insertions(+), 514 deletions(-)
 create mode 100755 tests/qemu-iotests/209
 create mode 100644 tests/qemu-iotests/209.out
